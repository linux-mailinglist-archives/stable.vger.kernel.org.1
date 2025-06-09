Return-Path: <stable+bounces-151965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C4AD16D7
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB831889712
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898012459DD;
	Mon,  9 Jun 2025 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j87jgOWF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7452459C9
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436461; cv=none; b=mwSC+aLuiTzo7jcr5w3vAnNSRdp3XuyuDVtuo4QRA3V9ixH8ZDD09KKTT8ARDXjlFgkqpA+5/F0qFGgZeSlj5qIEAfOIHOSMVaITsXLuzJiGT3n2WHPS7a8t1UKz2jGdGnHMM3jZSYoFMqTUp02+KdxnJcL9tIojSwOLBfDHk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436461; c=relaxed/simple;
	bh=ywSKjIoWzVTTVyGbCbI+xcbE6WjlPJsMmcgtIVNJn/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHX43V9svmuoz5wQfXUqo/C/j72TkKbemBdgcL15HxxC1kGBpyzFAfgNxJB9dZe8yMW+ZXUes7rGH+oonuzH25H6ndweiTDeiGG0eywBuGGNXPA5tI+znkQxgVvlhnhMa6b3nvtzRLrEuleNX3GH3oewXSQweoSssWbFbYDj4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j87jgOWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E74BC4CEEE;
	Mon,  9 Jun 2025 02:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436459;
	bh=ywSKjIoWzVTTVyGbCbI+xcbE6WjlPJsMmcgtIVNJn/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j87jgOWFkL0XIj4k8xGq8lyVyr7gi00ivp7sRkGXKLUXzlF/RYE4ecXcQAlWP/6KB
	 T7sEz6NITydbIrHG5h7OcZSHVJjIQAkCPrhXjeRfC7BeT1ivnE9iNHWIW1aDE+PSFS
	 08p5EecYGMo4lebXI/m8+ezbaWKO6Pj1jNXhFQ72UPw8iquR1wJQJpxmWWHOTuGtLw
	 r2AW7TVMAM3EbQbrMRGc8unqzL+U1SZWl2yP9PKbVyTirs7nKDysmqBHZlb2FRiIfD
	 5RvsJOZRaTCWO6a93AzuxxZj7unnYelxkn9fQjeG1/MHAD/P5y+/uvCsSx6i5mAPWG
	 vU8xKubJel75w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 02/14] arm64: move AARCH64_BREAK_FAULT into insn-def.h
Date: Sun,  8 Jun 2025 22:34:18 -0400
Message-Id: <20250608180205-091e3538a750c9e1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-3-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 97e58e395e9c074fd096dad13c54e9f4112cf71d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Hou Tao<houtao1@huawei.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  97e58e395e9c0 ! 1:  8387fc9ea68d2 arm64: move AARCH64_BREAK_FAULT into insn-def.h
    @@ Metadata
      ## Commit message ##
         arm64: move AARCH64_BREAK_FAULT into insn-def.h
     
    +    [ Upstream commit 97e58e395e9c074fd096dad13c54e9f4112cf71d ]
    +
         If CONFIG_ARM64_LSE_ATOMICS is off, encoders for LSE-related instructions
         can return AARCH64_BREAK_FAULT directly in insn.h. In order to access
         AARCH64_BREAK_FAULT in insn.h, we can not include debug-monitors.h in
    @@ Commit message
         Signed-off-by: Hou Tao <houtao1@huawei.com>
         Link: https://lore.kernel.org/r/20220217072232.1186625-2-houtao1@huawei.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    Conflicts:
    +            arch/arm64/include/asm/insn.h
    +    [not exist insn-def.h file, move to insn.h]
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/debug-monitors.h ##
     @@
    @@ arch/arm64/include/asm/debug-monitors.h
      	(AARCH64_BREAK_MON | (KGDB_DYN_DBG_BRK_IMM << 5))
      
     
    - ## arch/arm64/include/asm/insn-def.h ##
    + ## arch/arm64/include/asm/insn.h ##
     @@
    - #ifndef __ASM_INSN_DEF_H
    - #define __ASM_INSN_DEF_H
    - 
    -+#include <asm/brk-imm.h>
    -+
      /* A64 instructions are always 32 bits. */
      #define	AARCH64_INSN_SIZE		4
      
    @@ arch/arm64/include/asm/insn-def.h
     + * BRK instruction encoding
     + * The #imm16 value should be placed at bits[20:5] within BRK ins
     + */
    -+#define AARCH64_BREAK_MON	0xd4200000
    ++#define AARCH64_BREAK_MON      0xd4200000
     +
     +/*
     + * BRK instruction for provoking a fault on purpose
     + * Unlike kgdb, #imm16 value with unallocated handler is used for faulting.
     + */
    -+#define AARCH64_BREAK_FAULT	(AARCH64_BREAK_MON | (FAULT_BRK_IMM << 5))
    ++#define AARCH64_BREAK_FAULT    (AARCH64_BREAK_MON | (FAULT_BRK_IMM << 5))
     +
    - #endif /* __ASM_INSN_DEF_H */
    + #ifndef __ASSEMBLY__
    + /*
    +  * ARM Architecture Reference Manual for ARMv8 Profile-A, Issue A.a
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

