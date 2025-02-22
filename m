Return-Path: <stable+bounces-118667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C1A40994
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6D47AC786
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD01C84D8;
	Sat, 22 Feb 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/rGoZW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9F69D2B
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239621; cv=none; b=L8KzDQ9QAygRxYs2wZNoMynnTlXhYyr8uRHnXw0fhbZi35iY328DtjyKrQl1KP4bdvwhEe6lQ4mf4LAwKsKFazgESJbuVGsNOSC/oanIWX9AJEQQxgW/xPiFVBEo9WtZ6rnZPdVhX9ykiLIFF8wq5ToQrFhuNzp6ipDXoCuFBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239621; c=relaxed/simple;
	bh=ISpo4qTVDUZgajJMaos0lkQdItuYJlF+VUoUCwDsAuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h91KJmu9Y2sw+gR+R9w0lA8yIdQ/jb8f/c8FK7CHyBwoSQsa3ToH4Dq09TLZlCHw0CiIQlouwBs0Qj3j5KYULx/n7CMHV+5HX2T+cHu0koewdVb+sYlqmuI1S901WF5nUorc5bIY3Xkg+TqFrSqV0Z+NzENVvBQKx1c192jZZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/rGoZW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68A6C4CED1;
	Sat, 22 Feb 2025 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239621;
	bh=ISpo4qTVDUZgajJMaos0lkQdItuYJlF+VUoUCwDsAuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/rGoZW2HZy7FV03R7LWzQ078KH+piK9IPEeTlakbKD3WoAg1Yq2/aDoFNfPSKaf7
	 fcaZtWYZdxvvTn87inTd1v52I3TWD1uT+tDtgCxCdCLl17y6pzAZy6UotvpUtB/6z4
	 N5NaQd2IQp5fQ/uSakcBFW40u8LvsylZeQpjld3zMqYNRXrf8oBxyh4RvQR0d/TTjG
	 E0GgME2zYInfM+FJsiweR5JPrPzGEnxlLbn5v1D0QnamU3/J1ROvdmQfmVzm2WTYSs
	 EE2RrobGshMpNvkDBT6ZlHmZl1+QAUwwmCSxGDCSsFm3402pDKMe6n5TvTJLFdKeqY
	 qdcK3mtmSLL9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	derkling@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
Date: Sat, 22 Feb 2025 10:53:39 -0500
Message-Id: <20250221201501-c7596cf2ed3aee8b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221144209.135763-1-derkling@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ Patch is missing in 6.6.y (ignore if backport was sent)
ℹ️ Patch is missing in 6.1.y (ignore if backport was sent)
ℹ️ Patch is missing in 5.4.y (ignore if backport was sent)

The upstream commit SHA1 provided is correct: 318e8c339c9a0891c389298bb328ed0762a9935e


Status in newer kernel trees:
6.13.y | Present (different SHA1: 0bdda736ef7f)
6.12.y | Present (different SHA1: eea6d16f56e9)
6.6.y | Not found
6.1.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  318e8c339c9a0 ! 1:  86f437c1d34fe x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
    @@ Metadata
      ## Commit message ##
         x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
     
    +    commit 318e8c339c9a0891c389298bb328ed0762a9935e upstream.
    +
         In [1] the meaning of the synthetic IBPB flags has been redefined for a
         better separation of concerns:
          - ENTRY_IBPB     -- issue IBPB on entry only
    @@ Commit message
         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
     
      ## arch/x86/Kconfig ##
    -@@ arch/x86/Kconfig: config MITIGATION_IBPB_ENTRY
    +@@ arch/x86/Kconfig: config CPU_IBPB_ENTRY
      	depends on CPU_SUP_AMD && X86_64
      	default y
      	help
    @@ arch/x86/Kconfig: config MITIGATION_IBPB_ENTRY
     +	  Compile the kernel with support for the retbleed=ibpb and
     +	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
      
    - config MITIGATION_IBRS_ENTRY
    + config CPU_IBRS_ENTRY
      	bool "Enable IBRS on kernel entry"
     
      ## arch/x86/kernel/cpu/bugs.c ##
    @@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
      		setup_clear_cpu_cap(X86_FEATURE_UNRET);
      		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
      
    --		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
     -		mitigate_smt = true;
     -
      		/*
      		 * There is no need for RSB filling: entry_ibpb() ensures
      		 * all predictions, including the RSB, are invalidated,
     @@ arch/x86/kernel/cpu/bugs.c: static void __init srso_select_mitigation(void)
    - 		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
    + 		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
      			if (has_microcode) {
      				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
     +				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
    @@ arch/x86/kernel/cpu/bugs.c: static void __init srso_select_mitigation(void)
     +				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
      			}
      		} else {
    - 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
    + 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
     @@ arch/x86/kernel/cpu/bugs.c: static void __init srso_select_mitigation(void)
    + 		break;
      
    - ibpb_on_vmexit:
      	case SRSO_CMD_IBPB_ON_VMEXIT:
    --		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
    +-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
     -			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
    -+		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
    ++		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
     +			if (has_microcode) {
      				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
      				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
    @@ arch/x86/kernel/cpu/bugs.c: static void __init srso_select_mitigation(void)
      				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
      			}
      		} else {
    --			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
    +-			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
    ++			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
    + 			goto pred_cmd;
     -                }
    -+			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
     +		}
      		break;
    + 
      	default:
    - 		break;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

