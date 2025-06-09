Return-Path: <stable+bounces-151964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D002AAD16D4
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCA23AA737
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A662459D1;
	Mon,  9 Jun 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5JYhsgB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F0157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436457; cv=none; b=laO1QFIYtgFJJnCfvNz764s37uPP4QG+YB5VKdgW6vnPNERB7OP5cy7Iw279TWqHQew2/vfG1KeekyOrEmf0UCP2rvxbS3qaJcBiqmK2WpMCaiFWglkSPQRU732ieID9lvLXJi7JAf5hqvhTTo8OL+2sMmVPyEaCfQdaI9mUQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436457; c=relaxed/simple;
	bh=rI3/YkYy4JhUBM4Vxu5Wc84cf3oTjr13SfyySLR6Sf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eukzYdaDpd0bM0jkal7xExry63fZamPtSGrTMMuSNfqUjyFwQFUgJtKa0FQ7ZeMbFtq9oqHRk4zMBoPTDSshj06y/QgPffYp492xDGpgqZRxGgPuT7B7NtflvIZ9TcNPGy80kdgU3uk+aXyaqtKkQcPlivsSVnL6nV1/xPRhans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5JYhsgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31517C4CEEE;
	Mon,  9 Jun 2025 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436457;
	bh=rI3/YkYy4JhUBM4Vxu5Wc84cf3oTjr13SfyySLR6Sf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5JYhsgBmX1+3OBhuK/Gp+Zm9B5QRdmtKfn2/nEG0KyU2CfmkcRzMOxJ0sJRWiR4s
	 dJBrlKnEX5RGkCSmF2jLO3WJ1//ksiGDIG6eI3OC9Pras8qj03P5bjlVemC36eUNUH
	 4E5hVKq2RoCHW6MWcBO19PXuQKKfaD5MC4GvlTk82yyKmSiv1fZjb8w4bgYqv8TiHF
	 ofOzG1MqPYUveXzBXPxYSAdikUTR7mhyP5uZ5ep7kjfZgN8gYPcnHOWr/TeE4nfJoY
	 q64EYocgcG3PQGJOakWNSGAIiijMgNeLFzkvrbD8I5g9zRHj0MR7iVx92N8JI/Kpx4
	 b7eTqc3Y/UwDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 04/14] arm64: insn: Add support for encoding DSB
Date: Sun,  8 Jun 2025 22:34:15 -0400
Message-Id: <20250608183950-a48a1c0357dc51f9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-5-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 63de8abd97ddb9b758bd8f915ecbd18e1f1a87a0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 1e1963205784)
6.12.y | Present (different SHA1: 2a3915e86187)
6.6.y | Present (different SHA1: 054fc98d691a)
6.1.y | Present (different SHA1: cc0b8e148c33)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  63de8abd97ddb ! 1:  e18103b8fbb3a arm64: insn: Add support for encoding DSB
    @@ Metadata
      ## Commit message ##
         arm64: insn: Add support for encoding DSB
     
    +    [ Upstream commit 63de8abd97ddb9b758bd8f915ecbd18e1f1a87a0 ]
    +
         To generate code in the eBPF epilogue that uses the DSB instruction,
         insn.c needs a heler to encode the type and domain.
     
    @@ Commit message
     
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/insn.h ##
     @@ arch/arm64/include/asm/insn.h: u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
    @@ arch/arm64/include/asm/insn.h: u32 aarch64_insn_gen_cas(enum aarch64_insn_regist
      #endif
      u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
     +u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type);
    - u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
    - 			 enum aarch64_insn_system_register sysreg);
      
    + s32 aarch64_get_branch_offset(u32 insn);
    + u32 aarch64_set_branch_offset(u32 insn, s32 offset);
     
    - ## arch/arm64/lib/insn.c ##
    + ## arch/arm64/kernel/insn.c ##
     @@
       *
       * Copyright (C) 2014-2016 Zi Shen Lim <zlim.lnx@gmail.com>
    @@ arch/arm64/lib/insn.c
     +#include <linux/bitfield.h>
      #include <linux/bitops.h>
      #include <linux/bug.h>
    - #include <linux/printk.h>
    -@@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
    + #include <linux/compiler.h>
    +@@ arch/arm64/kernel/insn.c: u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
      	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
      }
      
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_extr(enum aarch64_insn_variant varia
      
      	insn = aarch64_insn_get_dmb_value();
      	insn &= ~GENMASK(11, 8);
    -@@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
    +@@ arch/arm64/kernel/insn.c: u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
    + 
      	return insn;
      }
    - 
    ++
     +u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type)
     +{
     +	u32 opt, insn;
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
     +
     +	return insn;
     +}
    -+
    - u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
    - 			 enum aarch64_insn_system_register sysreg)
    - {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

