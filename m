Return-Path: <stable+bounces-131791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98378A81032
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D718C1851
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC411A8407;
	Tue,  8 Apr 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SWGfbROS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBC1ADC7D
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126141; cv=none; b=SanIF1gSIMewGi/oCu8X5uQWXqTKxzzWTbWzkkuSCpiK9P1LqiOSa98RQBRhmjK4OnZlb904XWDEwFCdk935scwQbVFFFVa1oLqHUsSP9EYIpYFgO3egML7bpEKCbGC6OlJ8T268n0kw9GxFhkXKaNo5RqKe2+1AiycB2s7LNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126141; c=relaxed/simple;
	bh=DIUQbobSpYypAGmF0gksQ5mhkcSDjD9ojMpOY42cBsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIyaQU+i5aFUyvjaVaRUf3kHFP9FtOGhydwCdN2WaUMSjGiGUWzMeXcap83OmQODm71qF9bdi870HhS+6GwjeVEOV+C1eSnp0wz1IvHhyO5DnUxRFQ2LceDEmUVoRanYnAjleP0BpEHqEwM9vPkJuOEtKu182znFH0wUNcxrakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SWGfbROS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EE9C4CEE5;
	Tue,  8 Apr 2025 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744126141;
	bh=DIUQbobSpYypAGmF0gksQ5mhkcSDjD9ojMpOY42cBsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWGfbROSsh/1wUq6JsrNFfywmzvZFpEdRRyQmSjqxKjztJ67x66UO9Q2pkir5p6YV
	 vCF2sJYMxC63yu11i6zRAQgJll6pk009kx3I6KqWn1ryUjjSdLv5223mIN3eF8urCE
	 nN40NJ4KBAKW54RG5qBlAVCl1I1/zwfj9IE/9XpM=
Date: Tue, 8 Apr 2025 17:27:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk,
	stable@vger.kernel.org, broonie@kernel.org
Subject: Re: FAILED: patch "[PATCH] ARM: 9443/1: Require linker to support
 KEEP within OVERLAY" failed to apply to 6.13-stable tree
Message-ID: <2025040818-false-refill-e37b@gregkh>
References: <2025040805-boaster-hazing-36c3@gregkh>
 <20250408152300.GA3301081@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408152300.GA3301081@ax162>

On Tue, Apr 08, 2025 at 08:23:00AM -0700, Nathan Chancellor wrote:
> On Tue, Apr 08, 2025 at 11:15:05AM +0200, gregkh@linuxfoundation.org wrote:
> ...
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From e7607f7d6d81af71dcc5171278aadccc94d277cd Mon Sep 17 00:00:00 2001
> > From: Nathan Chancellor <nathan@kernel.org>
> > Date: Thu, 20 Mar 2025 22:33:49 +0100
> > Subject: [PATCH] ARM: 9443/1: Require linker to support KEEP within OVERLAY
> >  for DCE
> 
> Attached is a backport for 6.12 and 6.13. This change is necessary for
> "ARM: 9444/1: add KEEP() keyword to ARM_VECTORS", as pointed out at
> https://lore.kernel.org/71339b92-5292-48b7-8a45-addbac43ee32@sirena.org.uk/.

Thanks, now queued up.

greg k-h

