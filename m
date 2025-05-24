Return-Path: <stable+bounces-146241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3FAC3027
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB55189C654
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C0191F8F;
	Sat, 24 May 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sh3bcpw9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93564D
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748100981; cv=none; b=tPJ98gmyovW74Fy6eakUp2SvbwPp0JBmmMkNIfMqFNaWbayexH1QUWparKH9dugq4BCVB2k9RULNMODStwrdr3YWFh+mVbgA3tPC8Bq/8H5MbC/nWZ1WOdAcG6BSoDpQC4EXeztKkQRE49V8xc/iaO4bSnprlzBpyRSqiRIip1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748100981; c=relaxed/simple;
	bh=05UjM/UZI8K4y+mNupMqBrXrwln9jkhX8eCO8QocWvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqjSPBUR4KPLIDtuydS6a5zshrRxH96QQf7EBzzmR2QQfty4SMHw8+1uZ7nwVufcfGsxequbpkizRqE6oj2PZWbBoBK+rr7dUNn92fWNJsH1/34sn91uwoh2Vg4jFXdASw/DJFujgca2Q6XoO1FP+s4/nVXUxDPoq0+SIEl4N5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sh3bcpw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A83C4CEE4;
	Sat, 24 May 2025 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748100980;
	bh=05UjM/UZI8K4y+mNupMqBrXrwln9jkhX8eCO8QocWvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sh3bcpw9Ru12A04D8ILBwQBZYUzaUxrpnf0ECTNzGnZjHBfyoz4dPx/4m1hrZmNMB
	 Qbs7whNp59E4fy7nfS/P+vD/kYkObXR52x80+Kgf/zPvDpa4uqogDH2vx9UwN+oxin
	 ouLdlldadzWPNnDgiGGG6EBiZYiv9WghWI9BPt7c=
Date: Sat, 24 May 2025 17:36:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff LaBundy <jeff@labundy.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Input: iqs7222 - preserve system status register
Message-ID: <2025052405-unreeling-shelving-1531@gregkh>
References: <aDHip8uMZlBzg6kb@nixie71>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDHip8uMZlBzg6kb@nixie71>

On Sat, May 24, 2025 at 10:15:51AM -0500, Jeff LaBundy wrote:
> Some register groups reserve a byte at the end of their continuous
> address space. Depending on the variant of silicon, this field may
> share the same memory space as the lower byte of the system status
> register (0x10).
> 
> In these cases, caching the reserved byte and writing it later may
> effectively reset the device depending on what happened in between
> the read and write operations.
> 
> Solve this problem by avoiding any access to this last byte within
> offending register groups. This method replaces a workaround which
> attempted to write the reserved byte with up-to-date contents, but
> left a small window in which updates by the device could have been
> clobbered.
> 
> Now that the driver does not touch these reserved bytes, the order
> in which the device's registers are written no longer matters, and
> they can be written in their natural order. The new method is also
> much more generic, and can be more easily extended to new variants
> of silicon with different register maps.
> 
> As part of this change, the register read and write functions must
> be gently updated to support byte access instead of word access.
> 
> Fixes: 2e70ef525b73 ("Input: iqs7222 - acknowledge reset before writing registers")
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Link: https://lore.kernel.org/r/Z85Alw+d9EHKXx2e@nixie71
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/iqs7222.c | 47 +++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

