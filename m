Return-Path: <stable+bounces-144343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E81AB6714
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C67B1774F2
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB1224AED;
	Wed, 14 May 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVxe6Zka"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB361BC3F;
	Wed, 14 May 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214147; cv=none; b=ptqicpzoaLT0LHeaYwPYgD61C7QnZS3OAHq3dfmoRoJaTNNV/fZApGC2OtVIbzu9UZDFmybxSxKtJ5L/teCtpeSSboxmwxrLbOsy5yYm5RCQxzOQB0cuNF4oidqCzTknAArCAQl8V70bb3xuNweZbjrIsVRO2DA/LfZR3jABgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214147; c=relaxed/simple;
	bh=1cKoue+upTo4HfjWM/Vwi5Qay2EkwgJIx0igGvDWUwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLHUbXtOboFwV0aEmC5/gPN6GG3TSCcnU60Aqt0Pm27aaD/wyAdfp4qkoSNdR5Hrxwi1ySfc/0kmh9ZDcDGXpA93aCJY/9bN7GhV2/gJ1H02V4SFahlUMn0QgEV/bySEBiVsWhc331zQEPOZkgM1UXY4n2DdssOlFGYHvMwp//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVxe6Zka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764C1C4CEE9;
	Wed, 14 May 2025 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747214146;
	bh=1cKoue+upTo4HfjWM/Vwi5Qay2EkwgJIx0igGvDWUwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVxe6Zka6jWGS+tUAFUL78fgvJsnjKkZzqksLrW3yyshPyT5rWbBhgZqjFCjewVed
	 qStVS4di+0Lj2l5vZgJe/+CxQiX0AuP5EI4bd99SZBaHycPeWXVICIW3haayavbCeP
	 BlFlSBz2Du4jk9Cw3cTy6WgHijEL4bQGFAxc0rx+GybtjFawzTAuzqWIfZAHIzOeIB
	 pz+a/FbjvHvk2ZRoAUS85yNXnuLJpnEI6mf34w9+n5Qca0kfLt8rqyqp1U/TZNrHlK
	 rHwpmjzMK4PjWRWCTOC5eNERmuAmQutzD8k/wi7ANenKb9PzxwY1nQpu1X9E2J8w7O
	 sd06XPpg7XQbw==
Date: Wed, 14 May 2025 11:15:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ashish Kalra <ashish.kalra@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Srikanth Aithal <sraithal@amd.com>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/sev: Do not touch VMSA pages during SNP
 guest memory kdump
Message-ID: <aCRfPTxaPvoqILq8@gmail.com>
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
 <174715966762.406.12942579862694214802.tip-bot2@tip-bot2>
 <aCREWka5uQndvTN_@gmail.com>
 <20250514081120.GAaCRQKOVcm4dgqp59@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514081120.GAaCRQKOVcm4dgqp59@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, May 14, 2025 at 09:20:58AM +0200, Ingo Molnar wrote:
> > Boris, please don't rush these SEV patches without proper review first! ;-)
> 
> You didn't read the R-by and SOB tags at the beginning?

Reviewed-by tags and SOB tags don't necessarily imply a proper review, 
as my review feedback here amply demonstrates.

> Feel free to propose fixes, Tom and I will review them and even test 
> them for you!
> 
> But ontop of those: those are fixes and the "issues" you've pointed 
> out are to existing code which this patch only moves.

Firstly, while you may be inclined to ignore the half dozen typos in 
the changelog and the comments as inconsequential, do your scare-quotes 
around 'issues' imply that you don't accept the other issues my review 
identified, such as the messy type conversions and the inconsistent 
handling of svsm_caa_pa as valid? That would be sad.

Secondly, the fact that half of the patch is moving/refactoring code, 
while the other half is adding new code is no excuse to ignore review 
feedback for the code that gets moved/refactored - reviewers obviously 
need to read and understand the code that gets moved too. This is 
kernel maintenance 101.

And the new functionality introduced obviously expands on the bad 
practices & fragile code I outlined.

This is a basic requirement when implementing new functionality (and 
kdump never really worked on SEV-SNP I suppose, at least since August 
laste year, so it's basically new functionality), is to have a clean 
codebase it is extending, especially if the changes are so large:

   1 file changed, 158 insertions(+), 86 deletions(-)

All these problems accumulate and may result in fragility and bugs.

Third, this patch should have been split into two parts to begin with: 
the first one refactors the code into vmgexit_ap_control() and moves 
snp_set_vmsa() and snp_cleanup_vmsa() - and a second, smaller, easier 
to review patch that does the real changes. Right now the actual 
changes are hidden within the noise of code movement and refactoring.

> I would usually say "Thx" here but not this time.

Oh wow, you really don't take constructive criticism of patches very 
well. Review feedback isn't a personal attack against you. Please don't 
shoot the messenger.

Thanks,

	Ingo

