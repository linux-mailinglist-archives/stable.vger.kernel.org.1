Return-Path: <stable+bounces-185808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79CBDE74C
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69193B3F4C
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E430BB87;
	Wed, 15 Oct 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHq0Y1T0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88A31BCA9;
	Wed, 15 Oct 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531048; cv=none; b=Za1joIFNLXROTdRBIWnSbWChkLmLDSKg8nTke30mSiTdSp6MoUbgHZ9d6ILBnl2keonHJiLIGldBl3K6SfDSM+sLC1EHw3I03rHxAivE2/QNA9lqwKwJe7QlQg+HowisbUeGnW3EgfSYC8sZmleQwBDVMq75yFfQ64aa4dCgKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531048; c=relaxed/simple;
	bh=einmqBwIuypeNxpCQimu1e9AUffXSE8F2adt++EgnoY=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QadK4iedXL85tJLoCqcNtxcE1UuJXJkzpeD07PiYkkMQdG70Cl1ZJwnIhGRM7huWvcMetw3tHN+7faPDc4JuC9Wxrfo3eU+YxomiNEAqO0P9qLNMH6Z7ET5Lopi1LJc6mhT6mxEUXMb+Wx7VwYVH1Xng/t6pD36c2K9Cv8tBLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHq0Y1T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B900EC4CEF8;
	Wed, 15 Oct 2025 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531045;
	bh=einmqBwIuypeNxpCQimu1e9AUffXSE8F2adt++EgnoY=;
	h=Date:From:To:Cc:From;
	b=eHq0Y1T0h8wiHoyLD4P6Xeb07YuN8vFoJgyZXblnQh8Bnf4QN0Y1jZwWyWeD6v8Cd
	 PLldPS/GZp1XaluXE76j86mkooAZ9IdPiofcNXO13arifK49cLaj/hH6Uynt7Tj763
	 JzVk3vdPr23OfKddYRIUOrr4FwemY5XjeHT5Rs3jNe+S8m6h4Wh4cPEIHfrxyymnhD
	 W5Pf7wHZSEQN8rJGy7zZU5eIb9dyHqQn/3zVhgdIAKtZ7MEUzrJBkPQcTomLEIJscH
	 UJqjT+vsH10n5dKgW6zqpFvmhBJyAG0xHNZtsFOarKRdKgxVSvMoDt5ltRNADJyyYj
	 CJfdbMjtQQbQA==
Date: Wed, 15 Oct 2025 14:24:00 +0200
From: Alexey Gladkov <legion@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Message-ID: <aO-SYFfYK4-cns9e@example.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bcc: 
Subject: Re: Patch "s390: vmlinux.lds.S: Reorder sections" has been added to
 the 6.17-stable tree
Reply-To: 
In-Reply-To: <20251015114101.1339594-1-sashal@kernel.org>

On Wed, Oct 15, 2025 at 07:41:01AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     s390: vmlinux.lds.S: Reorder sections
> 
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      s390-vmlinux.lds.s-reorder-sections.patch
> and it can be found in the queue-6.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

If you take this commit, then I think this commit is also needed:

https://lore.kernel.org/all/20251008-kbuild-fix-modinfo-regressions-v1-3-9fc776c5887c@kernel.org/

> 
> commit 106cf24aac7413e5fb6aa632707ff81451a202c1
> Author: Alexey Gladkov <legion@kernel.org>
> Date:   Thu Sep 18 10:05:45 2025 +0200
> 
>     s390: vmlinux.lds.S: Reorder sections
>     
>     [ Upstream commit 8d18ef04f940a8d336fe7915b5ea419c3eb0c0a6 ]
>     
>     In the upcoming changes, the ELF_DETAILS macro will be extended with
>     the ".modinfo" section, which will cause an error:
>     
>     >> s390x-linux-ld: .tmp_vmlinux1: warning: allocated section `.modinfo' not in segment
>     >> s390x-linux-ld: .tmp_vmlinux2: warning: allocated section `.modinfo' not in segment
>     >> s390x-linux-ld: vmlinux.unstripped: warning: allocated section `.modinfo' not in segment
>     
>     This happens because the .vmlinux.info use :NONE to override the default
>     segment and tell the linker to not put the section in any segment at all.
>     
>     To avoid this, we need to change the sections order that will be placed
>     in the default segment.
>     
>     Cc: Heiko Carstens <hca@linux.ibm.com>
>     Cc: Vasily Gorbik <gor@linux.ibm.com>
>     Cc: Alexander Gordeev <agordeev@linux.ibm.com>
>     Cc: linux-s390@vger.kernel.org
>     Reported-by: kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202506062053.zbkFBEnJ-lkp@intel.com/
>     Signed-off-by: Alexey Gladkov <legion@kernel.org>
>     Acked-by: Heiko Carstens <hca@linux.ibm.com>
>     Link: https://patch.msgid.link/20d40a7a3a053ba06a54155e777dcde7fdada1db.1758182101.git.legion@kernel.org
>     Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>     Stable-dep-of: 9338d660b79a ("s390/vmlinux.lds.S: Move .vmlinux.info to end of allocatable sections")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 1c606dfa595d8..feecf1a6ddb44 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -209,6 +209,11 @@ SECTIONS
>  	. = ALIGN(PAGE_SIZE);
>  	_end = . ;
>  
> +	/* Debugging sections.	*/
> +	STABS_DEBUG
> +	DWARF_DEBUG
> +	ELF_DETAILS
> +
>  	/*
>  	 * uncompressed image info used by the decompressor
>  	 * it should match struct vmlinux_info
> @@ -239,11 +244,6 @@ SECTIONS
>  #endif
>  	} :NONE
>  
> -	/* Debugging sections.	*/
> -	STABS_DEBUG
> -	DWARF_DEBUG
> -	ELF_DETAILS
> -
>  	/*
>  	 * Make sure that the .got.plt is either completely empty or it
>  	 * contains only the three reserved double words.
> 

-- 
Rgrds, legion


