Return-Path: <stable+bounces-191759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C444C21A86
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5DD4261E1
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC2225761;
	Thu, 30 Oct 2025 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="b0t/wa0a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9C1548C;
	Thu, 30 Oct 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847525; cv=none; b=Q5Fqe6w2Y5p1SZ8QlJPqAaoFqAPfBYnc8U8WzmN0MqzX0cyVBo0EThRCuHUYc/OpllyoYpvWX0hEkJ3hdiyx99F59gNueOCD8bQoLJOYP5Qex1j+cbQbVKMJIe/KoLH3rT2kxuSgvHFYNKdD+chQF5WjKeJgabMYSw6DHmQUom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847525; c=relaxed/simple;
	bh=5dJCpSYJda5JOWuZQ03rOxB+6fmYMRpkRNbSd+lQi08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsDwMYMA+C3SBPBIEq5QdKq6BnZdN/Yc4QAtOnM8Z2sqkhTY6MWEMWyL3wP6gvj07VOLPbfhI86OsBC9q38BxYXD12uocP52x3pXKloDpGUNAACEB8YUusOxR5Zd8r600vwmCY47pBXYHo+fuTDOC1B5bgeNVi0xshWOJifsW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=b0t/wa0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873CEC4CEF1;
	Thu, 30 Oct 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="b0t/wa0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1761847522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMs9QZUJ7HcpIibPSK9sPD6W2zzm5fAqrjn4MgdL9bg=;
	b=b0t/wa0aVWOq4N9g2M1jjQgtOzhZAL0/kFFKSDR+7+36kKpOcLWJuBDaJAZ6Iidub/7T6t
	+mCW4PBOzPsL2vcq2cl1TLdPPhrlRRv9aJ9sSQYhpt/xtXrv2uAH5w4D9PvUFh8f3fkN6I
	63IjPOdlbC0meKJHOkLCZ94aZNrLiHY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4508ba34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Oct 2025 18:05:22 +0000 (UTC)
Date: Thu, 30 Oct 2025 19:05:16 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/CPU/AMD: Add RDSEED fix for Zen5
Message-ID: <aQOo3LcsdU23q1i2@zx2c4.com>
References: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>

Hi,

On Tue, Oct 28, 2025 at 12:01:51PM -0000, tip-bot2 for Gregory Price wrote:
> x86/CPU/AMD: Add RDSEED fix for Zen5
> 
> There's an issue with RDSEED's 16-bit and 32-bit register output
> variants on Zen5 which return a random value of 0 "at a rate inconsistent
> with randomness while incorrectly signaling success (CF=1)". Search the
> web for AMD-SB-7055 for more detail.
> 
> Add a fix glue which checks microcode revisions.
> 
>   [ bp: Add microcode revisions checking, rewrite. ]
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20251018024010.4112396-1-gourry@gourry.net

I didn't see this on LKML or any mailing list before this appeared in
tip. Did I miss something?

Jason

