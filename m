Return-Path: <stable+bounces-118668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F285BA4099D
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6841889251
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11751C863C;
	Sat, 22 Feb 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WklJqSFb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C171C8604
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239623; cv=none; b=ksPf9xHtpKFw+yJY39662zp8KpDXVfDNO7/qk4HZzzrsw4e/9lHEj0LnHmTWLic3KhMEITgK8d0EeDRr0ODkdQiXYW1572g3QcQtwDFF/2p+gFp89Ktf8lVRHJNPusJrPxyKCQmfRx5S2rYmvbo4rjW3++1/LuO7PH5pxBlELPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239623; c=relaxed/simple;
	bh=QH/S0Vqe8yKf/GFjOR1nH5/tIG/zMnHl2gBa8oUCtDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjZy9DOjhvlcCg9tVyisJdO2xPanDJxsRIstIdGc7MfWYQ3QkdPUpSu0usxk9Uo3MC9Agz0ilor1GstfU1sxIZuEnNeM7uXwSFxBKsxnudRDxhtHmpAF6LXxFk5JcT2j1ZOy369U7wz7UWJWusqCiedP7U30zwwsuQaAr89ZMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WklJqSFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C456DC4CED1;
	Sat, 22 Feb 2025 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239623;
	bh=QH/S0Vqe8yKf/GFjOR1nH5/tIG/zMnHl2gBa8oUCtDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WklJqSFbQBR4X3EZUiSagPJwlBCpH2tEp3tTQr9KGNqx98DRBjRTEdUZmT6HmkpsF
	 eBvJP57JvyHrLZICHE76sFtF3Q65/fEvSL80br3zHEioIaDMYywgtNFLdwlLXhkvDY
	 xkgIOt0A/woQBV977W9si3m9ewaw+tEoJVfjf+Ml3S/E8i1RoJgdO6GTZbdtll1MSI
	 du4DOV9KGUHzmY17aQDJMXg10s2nyxG5dRZmXoWtKrZrB4oKJPo8MJ5vVUJRgu8pg8
	 pxCL/Me91qHi8qp5M3zP9B+2Riw5igxZ92/V1BUgBRk/UxdimX6Ac70HxNBpfzF7xQ
	 JEHF8sl4c4M5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	derkling@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
Date: Sat, 22 Feb 2025 10:53:41 -0500
Message-Id: <20250221194210-7d86ada791744bf6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221143051.23140-1-derkling@google.com>
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

The upstream commit SHA1 provided is correct: 318e8c339c9a0891c389298bb328ed0762a9935e


Status in newer kernel trees:
6.13.y | Present (different SHA1: 0bdda736ef7f)
6.12.y | Present (different SHA1: eea6d16f56e9)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  318e8c339c9a0 ! 1:  e509c2d77c608 x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
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
| stable/linux-6.1.y        |  Success    |  Success   |

