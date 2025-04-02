Return-Path: <stable+bounces-127388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B634CA78968
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A5C16F2B2
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D567081C;
	Wed,  2 Apr 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K5jw05Dg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA0208A9
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580885; cv=none; b=bT38KwXAnXnHjkywTfN0An6Q3ARWaKplbUTkYuLLZAmdQj3hUZRmpTpQu3l2nNNiWCNYD1qyR3yUM7Xr9IrlQ2p+kyxx4RdkiCKMQzMId7LaMXSbkbgPazKh+Gehjl+kZpLOcnJEeHR2xcQdP4eEy/ff60QIN1xB0RElb6ISoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580885; c=relaxed/simple;
	bh=6yotCW6EaDR7quUYwzT9sXqkflANEf7E+25bH9RUw2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmbUXq8mMdNcVxNYwp8uePq0naIyiMANeS8rwRbewBVYp6y5xd5cOiasq94HcCU5XAkFLprvaiFUbLuN74+Bv4ylbzBlRaIUtdRcmVyP2q+xLQjzrUYDD33tlTUYPgnCqdB82iExeEE7k6Mww5/Duxx3bxYr8orgiALK2mrC0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K5jw05Dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA29C4CEDD;
	Wed,  2 Apr 2025 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743580884;
	bh=6yotCW6EaDR7quUYwzT9sXqkflANEf7E+25bH9RUw2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5jw05DgvdzTZoRzYtTtBqY+NmFIzH9jJKBSsWhTN9vcpntJ3PSXIywqnB3iANCns
	 kFM4noKZ7bYkPmmToU+KyLOKUfj6PDEGAhO5Tvp+FWiEMCh3I7PXEe+8efq0Ji2cD/
	 FWSaBKhEEpw08WYY+en8U6ToFi0C4mCnsjcH3g28=
Date: Wed, 2 Apr 2025 08:59:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] sound/pci: Add fixup for Star Labs laptops
Message-ID: <2025040246-resident-passport-add8@gregkh>
References: <CABtds-2+RYQdJ_y0pP7tm9mVBJBHOUWSEtGXPNdt+mLi+3fpDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtds-2+RYQdJ_y0pP7tm9mVBJBHOUWSEtGXPNdt+mLi+3fpDw@mail.gmail.com>

On Wed, Apr 02, 2025 at 03:50:14AM -0400, Sean Rhodes wrote:
> >From 427d5b100dee0c5c3a09e3e1ad095b06ebe33a8b Mon Sep 17 00:00:00 2001
> From: Sean Rhodes <sean@starlabs.systems>
> Date: Wed, 2 Apr 2025 08:31:04 +0100
> Subject: [PATCH] sound/pci: Add fixup for Star Labs laptops
> 
> For all Star Labs boards that use Realtek cards, select
> ALC269_FIXUP_LIMIT_INT_MIC_BOOST to mitigate noise when the fans are
> active.
> 
> Cc: Oder Chiou <oder_chiou@realtek.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  sound/pci/hda/patch_realtek.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

