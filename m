Return-Path: <stable+bounces-92025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1A9C2E95
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EB21C20E4A
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8A19C54B;
	Sat,  9 Nov 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqjuWYAB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3813AD26
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731171238; cv=none; b=lf4Lc/9RveZbFNwy/pzXwSA2swh9F4Jgsm2m9uk1tfOKJYB8THUi7uFjvKgSwRq05kPWKej+kL0xjjRTN7OBvuoxA7oLYPdC6hIt+TEvLmSwDgbAY4KHEtykrwjIyr5Wqd5kFNeW+eZWVUcyp+QUJh5vPb4rEgdLDosErL2vLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731171238; c=relaxed/simple;
	bh=B0D3RjUs/NpM4HHtT0sVJNeLh58HXMM/RyplQSstj4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN2BXdz5aCaApKZ9RtqBG0WAMgLuUh7dmZJ5jOmB1ZGxANXok3FnUItZaFXCKBIZSjqxcaE0pOt39vWsjGOOJuyMvFSxyL/xZ9w8RKkCwlxtoFPvO1U+7LDe+zzroejIv0ijOVixeEPrKedz35hPOEO9+g70SKeVOX8yeUupmds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqjuWYAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C90AC4CECE;
	Sat,  9 Nov 2024 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731171238;
	bh=B0D3RjUs/NpM4HHtT0sVJNeLh58HXMM/RyplQSstj4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqjuWYABxtQJcBplLJe47+vMB/6rzVs68f82J6EE+S+zhxsw/yXaFaUcQgBNpVKgZ
	 7F6meHfbbk/x2i4oNycJbXshhsqTOf6VBNH6c5IhER4mIOBGkdrY9tokm1327Itcbe
	 2Suk8kwXJ2r2IGESb2cIfRlvNLxwe4Wq0mUP+mcA=
Date: Sat, 9 Nov 2024 17:53:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Gong, Richard" <Richard.Gong@amd.com>
Subject: Re: AMD PMF on 6.11.y
Message-ID: <2024110944-excuse-reach-68c4@gregkh>
References: <478eac36-fc71-4564-959c-422da304f139@kernel.org>
 <2024110903-previous-sequel-5a74@gregkh>
 <da9f1725-01b8-4630-a768-82800f1cc08a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9f1725-01b8-4630-a768-82800f1cc08a@kernel.org>

On Sat, Nov 09, 2024 at 10:48:37AM -0600, Mario Limonciello wrote:
> 
> 
> On 11/9/24 09:30, Greg KH wrote:
> > On Wed, Nov 06, 2024 at 11:52:58PM -0600, Mario Limonciello wrote:
> > > Hi,
> > > 
> > > 6.11 already supports most functionality of AMD family 0x1a model 0x60, but
> > > the amd-pmf driver doesn't load due to a missing device ID.
> > > 
> > > The device ID was added in 6.12 with:
> > > 
> > > commit 8ca8d07857c69 ("platform/x86/amd/pmf: Add SMU metrics table support
> > > for 1Ah family 60h model")
> > > 
> > > Can this please come back to 6.11.y to enable it more widely?
> > 
> > I would be glad to, but it does not apply cleanly, are you sure you
> > tried this?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Whoops! I had thought we had the context changes already in 6.11.y and got
> fooled by the one line change.
> 
> Here's the correct series.
> 
> commit 375780541739 ("platform/x86/amd/pmf: Relocate CPU ID macros to the
> PMF header")
> commit 8f2407cb3f1e ("platform/x86/amd/pmf: Update SMU metrics table for 1AH
> family series")
> commit 8ca8d07857c6 ("platform/x86/amd/pmf: Add SMU metrics table support
> for 1Ah family 60h model")

Much better thanks!  All now queued up.

greg k-h

