Return-Path: <stable+bounces-118671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D46A40998
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C163B1AE3
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092D61CBEAA;
	Sat, 22 Feb 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck/zUpGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83E1C8601
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239629; cv=none; b=MIas7526Twt5KK/o7HsTyslALyc9xyZr2d6gHPoozQKTstnWIB00KcClZh8XCZvc9KdTlYxORZQXyBOeGFCacbEepwEu4EOOd6QDIA0zokre0jVP4CdR/Qzt8IrE5PRxZ2ZINO7toWipx+Zfhf4WSD4dGG69qRqKBQypg1YgNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239629; c=relaxed/simple;
	bh=DNhDjbJN3YC3GK2rxp6IewfkJzwvN62/6/Ho6EAJmxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+VPmjLk71qu7EXxqjoUKDAZ5WD8Ig0QelFV8HwYmo348RKnOJtie/LJfn/ISLIyjfdhCmnApJ6veUuRGY16mudBKWGk9GAOLBIsyfWE94DzZv0piGfa67nbncmbU5AQk6+cHlgi4LevIKRmgThPM86r3P4lsXInXEy9W/7928Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck/zUpGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC620C4CED1;
	Sat, 22 Feb 2025 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239629;
	bh=DNhDjbJN3YC3GK2rxp6IewfkJzwvN62/6/Ho6EAJmxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ck/zUpGkqvdlX5oTVaKd6opS+lRg/tabxch5+UIoXEOy3KHUCU53C9QyrvX1aBYfU
	 QC8Wfojp6rg75L+SejgZNMfAB90x6d3C8y2DGeX4t5BgM9ev2RBOiI+iGmi5E0z7x3
	 hB3lx44ZA8baIcos5hIAVUO7rKF3S/1iRjAIsyTcgFVYTiEfrJLcOJfI5NNIsdG1lz
	 OnrzAp+3cS619uaWAWnz3R32h9TvVIbk/bo31VT2uhHLMyB1OSWTQx4s9A8vXpbKNk
	 LR3P/rxow+t/CVQgYBffd0+BBv3Q5GcA5gDm6fy3omGwDUeN5g+J64XWVOKNcLOIdz
	 54/MR7GA0dLkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Patrick Bellasi <derkling@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
Date: Sat, 22 Feb 2025 10:53:47 -0500
Message-Id: <20250221203055-b786f70fab651df1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221142002.4136456-1-derkling@google.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 318e8c339c9a0891c389298bb328ed0762a9935e

Note: The patch differs from the upstream commit:
---
1:  318e8c339c9a0 ! 1:  7e78323cfe696 x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
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
| stable/linux-6.6.y        |  Success    |  Success   |

