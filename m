Return-Path: <stable+bounces-154767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A998FAE0147
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430BD3B99CB
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF528368C;
	Thu, 19 Jun 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i82dvHp7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146A2797B5
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323802; cv=none; b=b567P8kk1R5ICINI14I0RLTiSe8C0F9CoyEWEO6yie7tFf57XlE1jbYIBY4Gf8H+w7Gr24lg8/D4/qvb/d1mY1mZ65+C2lvS4Vxin1yPfGI8rwonLz9zmeB3GwuPJZGRgihzrOVmBuYr/V/5RDxVggP6BoD20hDVasP2VzlQbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323802; c=relaxed/simple;
	bh=hxxEZC8YdFe86cPF9DIZb6hnNU6+vThjHv43DSz4+iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/kMAfpKcRFljd9AzY0lvoeln+44TppwobTX1fnZHYAKhsKHUHXCtlAAK3V9XVp4IbpPW1igYcJH3FrUi+fUOyBRjBn70pwXFNMW+BXI3/pUOX2n1QcsnyiZ/0H7NvacKJUa4kRjiWCk0wYloYx4FSUnoXpt2/nhVMqcF5k2SYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i82dvHp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F44BC4CEEA;
	Thu, 19 Jun 2025 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323801;
	bh=hxxEZC8YdFe86cPF9DIZb6hnNU6+vThjHv43DSz4+iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i82dvHp7N5CaESnFw790x3gveNe73UAHgmDPk28AUW06+9ukq29Rikt2Ob1KSnl4g
	 O1biLn8eL4eTHRbCGFkQrN8r99gaveA6Db8F3zTjFu6jrklT9Cp1GoREcUCALiaFC+
	 KCfZsJ47h0uZieQeLFv+QkBimiU4S2AnDI/qIM1SPbxPysDmHUX/xxDb3ue2SH1ex/
	 yvnjn8HLimTSO9Pf01yzeVDuK372claw0vxkm7HzpxQ38CwEcGBY5zdBFUduPwu3N4
	 qzhcrXS+0KaOZac8GxpmrRezf6BTPU1CSPooxm5/la493qF3jtBdXJKLgSecGNwXvs
	 VaZUCvju+eQbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 05/16] x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
Date: Thu, 19 Jun 2025 05:03:19 -0400
Message-Id: <20250618171828-ebdcd37d56c3a76b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-5-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: ac0ee0a9560c97fa5fe1409e450c2425d4ebd17a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: c51a456b4179)
5.15.y | Present (different SHA1: 7339b1ce5ea6)

Note: The patch differs from the upstream commit:
---
1:  ac0ee0a9560c9 ! 1:  afe5930bd1f3d x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
    @@ Metadata
      ## Commit message ##
         x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
     
    +    commit ac0ee0a9560c97fa5fe1409e450c2425d4ebd17a upstream.
    +
         In order to re-write Jcc.d32 instructions text_poke_bp() needs to be
         taught about them.
     
    @@ Commit message
         last 5 bytes and adding the rule that 'length == 6' instruction will
         be prefixed with a 0x0f byte.
     
    +    Change-Id: Ie3f72c6b92f865d287c8940e5a87e59d41cfaa27
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
         Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
         Link: https://lore.kernel.org/r/20230123210607.115718513@infradead.org
    +    [cascardo: there is no emit_call_track_retpoline]
    +    Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/kernel/alternative.c ##
     @@ arch/x86/kernel/alternative.c: void __init_or_module noinline apply_alternatives(struct alt_instr *start,
    - 	}
    + 	kasan_enable_current();
      }
      
     +static inline bool is_jcc32(struct insn *insn)
    @@ arch/x86/kernel/alternative.c: void __init_or_module noinline apply_alternatives
     +	return insn->opcode.bytes[0] == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80;
     +}
     +
    - #if defined(CONFIG_RETPOLINE) && defined(CONFIG_OBJTOOL)
    + #if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
      
      /*
    -@@ arch/x86/kernel/alternative.c: static int emit_indirect(int op, int reg, u8 *bytes)
    - 	return i;
    - }
    - 
    --static inline bool is_jcc32(struct insn *insn)
    --{
    --	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
    --	return insn->opcode.bytes[0] == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80;
    --}
    --
    - static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
    - {
    - 	u8 op = insn->opcode.bytes[0];
     @@ arch/x86/kernel/alternative.c: void text_poke_sync(void)
      	on_each_cpu(do_sync_core, NULL, 1);
      }
    @@ arch/x86/kernel/alternative.c: static void text_poke_loc_init(struct text_poke_l
      	case JMP32_INSN_OPCODE:
     @@ arch/x86/kernel/alternative.c: static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
      		BUG_ON(len != insn.length);
    - 	}
    + 	};
      
     -
      	switch (tp->opcode) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

