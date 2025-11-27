Return-Path: <stable+bounces-197114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE69C8EB50
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93673A68FD
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40F3328F3;
	Thu, 27 Nov 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JS70pH5t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74D235358
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252404; cv=none; b=lbdg4DomiW2OiV/YL40HtbhuSGRanR1uSNIP2uVgGdrzn90Npysp/qEECChiAm59wHTtanxlUzRduaHedKTT7xc9PBgs3TH4pic/N2f0HHCrAdFjyBz7cfDvED3xyV8mLJWyl9q0zaRDFjtoXXcupZx71/kK7CE30ae9SorzZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252404; c=relaxed/simple;
	bh=A2dkFCwTd827pYFxBrfRCLQSbbFvk24cld3CkJX4wuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0+WELfZ8fexl0e0MI9Goi7xC1IqXx6GmCY+6ahgnrnQWJ4C5OoaaoO7PRbuDQqiu7IsSpHaSEcjgVdT9ByrYlJ2RttBPLciigoSp7fEyDVy7mcmWXAcFv94l4SGcpCjQyFTDwj03pMdlNJfehw8c62rLP0GBBnhC7oqa6oXowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JS70pH5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8A0C113D0;
	Thu, 27 Nov 2025 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764252403;
	bh=A2dkFCwTd827pYFxBrfRCLQSbbFvk24cld3CkJX4wuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JS70pH5tjiUmidu/0Nv7KyHuGheYpw9/ZKHgZptG+0bSGMXX34LTDIvLWMpybsxeX
	 Blu0V+4DngAtyX84OBf/en3kR7eeyGLtjCwik+F6tISW73Qfo+hSxxXRoNVxJHqt4L
	 O93oa33y37UB/sCek2HtfGd/aL2TpWxsm8eIFjsQ=
Date: Thu, 27 Nov 2025 15:06:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: stable@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: please backport 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3
 when sink doesn't support TPS4"")
Message-ID: <2025112734-cartel-famished-3e7a@gregkh>
References: <ae09d103eb4427f690685dc7daf428764fed2421@intel.com>
 <5b080d938b4a6132e407d956a37fd079dbd71a67@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b080d938b4a6132e407d956a37fd079dbd71a67@intel.com>

On Wed, Nov 26, 2025 at 12:45:04PM +0200, Jani Nikula wrote:
> On Wed, 26 Nov 2025, Jani Nikula <jani.nikula@intel.com> wrote:
> > Stable team, please backport
> >
> > 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"")
> >
> > from v6.18-rc1 to v6.15+. It's missing the obvious
> >
> > Fixes: 584cf613c24a ("drm/i915/dp: Reject HBR3 when sink doesn't support TPS4")
> 
> Oh, please *also* backport
> 
> 21c586d9233a ("drm/i915/dp: Add device specific quirk to limit eDP rate to HBR2")
> 
> along with it, as it'll fix what the revert breaks.

Both now queued up, thanks.

greg k-h

