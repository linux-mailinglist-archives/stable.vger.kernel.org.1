Return-Path: <stable+bounces-151967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DEAAD16DF
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE518897CF
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8524503E;
	Mon,  9 Jun 2025 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQAxT95u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AD246332
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436464; cv=none; b=JqehlfFX6xLKz7CnyIKKzEwx1OhAmRl62hHNlBt6h8mvk5IhKCZg4pQqJw5M7M39z4rBJuwUI5WimSsjf71GXs+XQSnMORUOR4RC183vcpXzWehfMK8qF89CY4rn8w/VueRD9+9/gedaL3/RtqyL55WCD5P0gAY0PfVgqd40S24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436464; c=relaxed/simple;
	bh=JU34Pys1bp1YSP4pw4i7cvUk11IjqeBB5DLdsnq0Mok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIFulqmb7BkHB7CT048TFYAA4gTCKI2rr5nwn3BXhQ2axJFGS+9cHRfTJo2WDxPLbLFiJjihpTUH87J/rgl/idUuH1dF+0p+qqxykempNNzBaQF6nEMpvVC+P2QmlppLGOeYzU+3j7/jt0DfN8MO44Pze2M8wpQuGd+IokwDhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQAxT95u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CBFC4CEEE;
	Mon,  9 Jun 2025 02:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436464;
	bh=JU34Pys1bp1YSP4pw4i7cvUk11IjqeBB5DLdsnq0Mok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQAxT95uv+l8oZfuBnA/+fmyKFKfYVrDh7/lziOhAyNDEjXHl+8RfPME+b2RnswxI
	 1EeDX4LmU4VlzfAyOlHwFZ3DgkBdLhUz2nm+hROoc5CrwPCCDXmOI+fG7y6PestGJN
	 C0GAyxXa5szcuRJj5yEa4vpXe+9QNdVgkH015Ms3Vayt/4D7fSYcDSgkmWy/RzN4i3
	 n7tec6LN1N/U01VKcebNT2+03XqMDZY3EWyycnCTPh/61xX5/ad9WCw5xguPJpjied
	 IYp1nqrjThrGeK1HofDntK3u8wm47XqvTnN9G2Qusc77z0yXxK/Sc8KyvHfdmQLZua
	 R8+pdvm0n5ABw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 03/14] arm64: insn: add encoders for atomic operations
Date: Sun,  8 Jun 2025 22:34:22 -0400
Message-Id: <20250608182059-f3fcde8a9bd938ba@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-4-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: fa1114d9eba5087ba5e81aab4c56f546995e6cd3

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
1:  fa1114d9eba50 ! 1:  5d6b22f0bb8f5 arm64: insn: add encoders for atomic operations
    @@ Metadata
      ## Commit message ##
         arm64: insn: add encoders for atomic operations
     
    +    [ Upstream commit fa1114d9eba5087ba5e81aab4c56f546995e6cd3 ]
    +
         It is a preparation patch for eBPF atomic supports under arm64. eBPF
         needs support atomic[64]_fetch_add, atomic[64]_[fetch_]{and,or,xor} and
         atomic[64]_{xchg|cmpxchg}. The ordering semantics of eBPF atomics are
    @@ Commit message
         Signed-off-by: Hou Tao <houtao1@huawei.com>
         Link: https://lore.kernel.org/r/20220217072232.1186625-3-houtao1@huawei.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/insn.h ##
     @@ arch/arm64/include/asm/insn.h: enum aarch64_insn_ldst_type {
    @@ arch/arm64/include/asm/insn.h: enum aarch64_insn_adr_type {
      #define	__AARCH64_INSN_FUNCS(abbr, mask, val)				\
      static __always_inline bool aarch64_insn_is_##abbr(u32 code)		\
      {									\
    -@@ arch/arm64/include/asm/insn.h: __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
    - __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
    +@@ arch/arm64/include/asm/insn.h: __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
    + __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
      __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
      __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
     +__AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
    @@ arch/arm64/include/asm/insn.h: u32 aarch64_insn_gen_prefetch(enum aarch64_insn_r
      u32 aarch64_set_branch_offset(u32 insn, s32 offset);
      
     
    - ## arch/arm64/lib/insn.c ##
    -@@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
    + ## arch/arm64/kernel/insn.c ##
    +@@ arch/arm64/kernel/insn.c: u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
      
      	switch (type) {
      	case AARCH64_INSN_LDST_LOAD_EX:
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_regi
      		break;
      	default:
      		pr_err("%s: unknown load/store exclusive encoding %d\n", __func__, type);
    -@@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
    +@@ arch/arm64/kernel/insn.c: u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
      					    state);
      }
      
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_regi
      
      	switch (size) {
      	case AARCH64_INSN_SIZE_32:
    -@@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
    +@@ arch/arm64/kernel/insn.c: u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
      
      	insn = aarch64_insn_encode_ldst_size(size, insn);
      
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register res
      	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
      					    result);
      
    -@@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
    +@@ arch/arm64/kernel/insn.c: u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
      					    value);
      }
      
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register res
      
      static u32 aarch64_insn_encode_prfm_imm(enum aarch64_insn_prfm_type type,
      					enum aarch64_insn_prfm_target target,
    -@@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
    +@@ arch/arm64/kernel/insn.c: u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
      	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
      	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
      }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

