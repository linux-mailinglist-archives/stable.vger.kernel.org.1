Return-Path: <stable+bounces-50246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71129052A7
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA92825BE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DA216FF59;
	Wed, 12 Jun 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tytCVI6F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D716F29C
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196008; cv=none; b=UEj5NA1RxFJXdDpZwr82CsbkYlyJn9uUy2fJI0dkyqhikjBo2NAHX+vf9YSJGJn2CNMvFa3mvdIhpbXzWMhgR2QNURvV1CxWv6s/7h4zXNNC2mdHry6FHeXvHdncDbatUc/6HroMstbPWA0sM6aC0XfTi2IjfZjUqkAMpve8Vhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196008; c=relaxed/simple;
	bh=no24WWCIOhWHm9BPqM1ypU2F5wveQ0sWqNBCT3zo4o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+fYZoHmFW0CGNF7nhAuZrC574MEfIjxAhjEkZLhEjD1XPs4xqv4Kz4TST+nluBwZYZuuh38GMUD0yh2+Rt/Y9Oq+UD9UyQPp+Zqj92JhX9tWoQNMzr9yqrTN6Ou9f53DDCpCRkwtlDC8nUYM7zbzcx14FwOowdc+EIDDbv36O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tytCVI6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E103C3277B;
	Wed, 12 Jun 2024 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196008;
	bh=no24WWCIOhWHm9BPqM1ypU2F5wveQ0sWqNBCT3zo4o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tytCVI6FScV0VzuW69YID8QQPrJEQgiREHXOno79+/HGIyzp5Zik+6s/qiH191hGW
	 s6Dg0cY7yTM86Yd12IRgKKuJsPak4qZNc6gxglbiVLcnh51xevOL/s8t3EhMRSD/DM
	 aJiUKuAQ9dgc4gBE+tuafkrQr2iw0aDdVloh1ERo=
Date: Wed, 12 Jun 2024 14:40:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/i915/audio: Fix audio time stamp programming
 for DP
Message-ID: <2024061257-rally-vividness-8a77@gregkh>
References: <2024051325-ipad-sturdily-5677@gregkh>
 <20240527054547.3072037-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527054547.3072037-1-chaitanya.kumar.borah@intel.com>

On Mon, May 27, 2024 at 11:15:47AM +0530, Chaitanya Kumar Borah wrote:
> Intel hardware is capable of programming the Maud/Naud SDPs on its
> own based on real-time clocks. While doing so, it takes care
> of any deviations from the theoretical values. Programming the registers
> explicitly with static values can interfere with this logic. Therefore,
> let the HW decide the Maud and Naud SDPs on it's own.
> 
> Cc: stable@vger.kernel.org # v5.17
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8097
> Co-developed-by: Kai Vehmanen <kai.vehmanen@intel.com>
> Signed-off-by: Kai Vehmanen <kai.vehmanen@intel.com>
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> Signed-off-by: Animesh Manna <animesh.manna@intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20240430091825.733499-1-chaitanya.kumar.borah@intel.com
> (cherry picked from commit 8e056b50d92ae7f4d6895d1c97a69a2a953cf97b)
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> (cherry picked from commit c66b8356273c8d22498f88e4223af47a7bf8a23c)
> ---
>  drivers/gpu/drm/i915/display/intel_audio.c | 116 ++-------------------
>  1 file changed, 9 insertions(+), 107 deletions(-)

Now queued up, thanks.

greg k-h

