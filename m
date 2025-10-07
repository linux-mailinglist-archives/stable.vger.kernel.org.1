Return-Path: <stable+bounces-183539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B4BC160A
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 14:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE7744F5AE3
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679D12DF15C;
	Tue,  7 Oct 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mhb2YTzq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3B2DF154
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840693; cv=none; b=VR0LwPWkjU5MlxGbxgExQmkmTVY4U1Z//8BduwbH7fbDUlgGBJWxYHeCBiyu5cZJvwv6UU5PQTL1BRhFWwZ19GiaWpbvuOUaAnBqvpdlhcRN5AMOXpJFQj+SBrK4iClYL/vZ8Joxy8uDrKpHbikC0Op+xuxuMb9zzKuFzhbtUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840693; c=relaxed/simple;
	bh=yWq5L3M4l95kta9gzuPIvejQV8C57YtxjgckSKYwmyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjPWMxMmSEMyDodKf7ly4jXahPckFWrkkwH4TceWc00+H7qgfYOwV3F9dMf7nHBIWypB01FfgwG2LMFtsjWzadOaQ3v8TJp6jOsRBOULYqOyuGhbS05fKtqRlzS+fqsZMB4xUHwS4xWsLdbouYMne0J+cj8M+6DQTQVajSe5FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mhb2YTzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA55C4CEFE;
	Tue,  7 Oct 2025 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759840692;
	bh=yWq5L3M4l95kta9gzuPIvejQV8C57YtxjgckSKYwmyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhb2YTzqNgY++uTAAYnliHuyrPHcPQlsGaRPtQlUAi5+I3USudHHWXLy7RLaWd6i0
	 GyeH+HTdy38Hiz2LKFhI8af6/d5DapQJFySs2FnF6Uj0naAj/bBiZJ+O2GuTEFeq8C
	 B2e8Lx+uyDZguw7mNaqL2WKCiZZzbLx6TnAE+XC0=
Date: Tue, 7 Oct 2025 14:38:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: LR compute WA
Message-ID: <2025100700-startup-refining-261d@gregkh>
References: <3c147f99-0911-420b-812b-a41a26b4a723@kernel.org>
 <2025100627-landfill-helium-d99a@gregkh>
 <f2d82fa5-7eb3-4717-89ba-6568658e1bf4@kernel.org>
 <7bf4b055-d751-4a84-bfd0-a7df78c2a6d8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bf4b055-d751-4a84-bfd0-a7df78c2a6d8@kernel.org>

On Mon, Oct 06, 2025 at 12:37:30PM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 10/6/2025 8:56 AM, Mario Limonciello (AMD) (kernel.org) wrote:
> > 
> > 
> > On 10/6/2025 5:04 AM, Greg KH wrote:
> > > On Sat, Oct 04, 2025 at 01:41:29PM -0500, Mario Limonciello (AMD)
> > > (kernel.org) wrote:
> > > > Hi,
> > > > 
> > > > We have some reports of long compute jobs on APUs hanging the
> > > > system. This
> > > > has been root caused and a workaround has been introduced in the
> > > > mainline
> > > > kernel.  I didn't CC stable on the original W/A because I wanted to make
> > > > sure we've had enough time to test it didn't have unintended
> > > > side effects.
> > > > 
> > > > I feel comfortable with the testing at this point and I think it's worth
> > > > bringing back to any stable kernels it will apply to 6.12.y and
> > > > newer. The
> > > > commit is:
> > > > 
> > > > 1fb710793ce2619223adffaf981b1ff13cd48f17
> > > 
> > > It did not apply to 6.12.y, so if you want it there, can you provide a
> > > working backport?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Thanks, I see 6.16 and 6.17 had no problem.  I'll find the contextually
> > missing patches and send out 6.12.y separately.
> 
> OK - here's the 3 patches needed for 6.12.y to cleanly cherry-pick:
> 
> ce4971388c79d36b3f50f607c3278dbfae6c789b
> 1c687c0da9efb7c627793483a8927554764e7a55
> 15d8c92f107c17c2e585cb4888c67873538f9722

All now queued up, thanks.

greg k-h

