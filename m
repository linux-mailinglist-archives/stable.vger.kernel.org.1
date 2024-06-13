Return-Path: <stable+bounces-52041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1E9072CA
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CD61C21CC7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255872566;
	Thu, 13 Jun 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btnNe2tY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AD2913;
	Thu, 13 Jun 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283060; cv=none; b=Rsd9IWWmbkwjn4vegYZZxS8ph9goDhKpb0/XyeGp9wytsBGcC0Ex8jikCyOOyvu/95BTHUGz9JMN01ACg76g1Lgx5yuIV5Nm/385Rl6D2lj2cy2Rod2eYJ+9OmQXEkSA5vcJVfANQWXv4r8c/P2bR/E2LSoNYw7LA3Nnq/ToO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283060; c=relaxed/simple;
	bh=pP8VeNxEIhmn3rxNgID/fohB7QhHRomC0DgFjm2c4eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiRdqgXEkm6x6NlUUes8SOEXexTU2Z45M56bHvaJD1ljfjr6BSE5FSHufSQepW2DY3+9SNSdYO3zqVuI2n/9LZSflg/0hVoE2jsQVJ9AKRU5MTcSnMJXBNM2z029Deg/yCSK3xZkM6ScJ7ySc3Ux2lWQMcSj56jue/wD0ZNca58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btnNe2tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5753EC2BBFC;
	Thu, 13 Jun 2024 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718283060;
	bh=pP8VeNxEIhmn3rxNgID/fohB7QhHRomC0DgFjm2c4eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btnNe2tYfZGYNOdbUkWXNroQI8pAuqCxsvTk+woc5ZmQhCUrQMDLEe/pHwztYUEzP
	 RZcknjtBI45YhsIuI0UoW3ag0y4s4pdDMGjBx8jlyqnHpxmES8kX9dKX9e438DorjO
	 Y9Iqt9BlzO/o/GKQjShqMhO1yaG9OMj9zoNDhsuI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.1 84/85] powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH
Date: Thu, 13 Jun 2024 13:36:22 +0200
Message-ID: <20240613113217.377594421@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Puranjay Mohan <puranjay@kernel.org>

commit b1e7cee96127468c2483cf10c2899c9b5cf79bf8 upstream.

The Linux Kernel Memory Model [1][2] requires RMW operations that have a
return value to be fully ordered.

BPF atomic operations with BPF_FETCH (including BPF_XCHG and
BPF_CMPXCHG) return a value back so they need to be JITed to fully
ordered operations. POWERPC currently emits relaxed operations for
these.

We can show this by running the following litmus-test:

  PPC SB+atomic_add+fetch

  {
      0:r0=x;  (* dst reg assuming offset is 0 *)
      0:r1=2;  (* src reg *)
      0:r2=1;
      0:r4=y;  (* P0 writes to this, P1 reads this *)
      0:r5=z;  (* P1 writes to this, P0 reads this *)
      0:r6=0;

      1:r2=1;
      1:r4=y;
      1:r5=z;
  }

  P0                      | P1            ;
  stw         r2, 0(r4)   | stw  r2,0(r5) ;
                          |               ;
  loop:lwarx  r3, r6, r0  |               ;
  mr          r8, r3      |               ;
  add         r3, r3, r1  | sync          ;
  stwcx.      r3, r6, r0  |               ;
  bne         loop        |               ;
  mr          r1, r8      |               ;
                          |               ;
  lwa         r7, 0(r5)   | lwa  r7,0(r4) ;

  ~exists(0:r7=0 /\ 1:r7=0)

  Witnesses
  Positive: 9 Negative: 3
  Condition ~exists (0:r7=0 /\ 1:r7=0)
  Observation SB+atomic_add+fetch Sometimes 3 9

This test shows that the older store in P0 is reordered with a newer
load to a different address. Although there is a RMW operation with
fetch between them. Adding a sync before and after RMW fixes the issue:

  Witnesses
  Positive: 9 Negative: 0
  Condition ~exists (0:r7=0 /\ 1:r7=0)
  Observation SB+atomic_add+fetch Never 0 9

[1] https://www.kernel.org/doc/Documentation/memory-barriers.txt
[2] https://www.kernel.org/doc/Documentation/atomic_t.txt

Fixes: aea7ef8a82c0 ("powerpc/bpf/32: add support for BPF_ATOMIC bitwise operations")
Fixes: 2d9206b22743 ("powerpc/bpf/32: Add instructions for atomic_[cmp]xchg")
Fixes: dbe6e2456fb0 ("powerpc/bpf/64: add support for atomic fetch operations")
Fixes: 1e82dfaa7819 ("powerpc/bpf/64: Add instructions for atomic_[cmp]xchg")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Naveen N Rao <naveen@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240513100248.110535-1-puranjay@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp32.c |   12 ++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c |   12 ++++++++++++
 2 files changed, 24 insertions(+)

--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -814,6 +814,15 @@ int bpf_jit_build_body(struct bpf_prog *
 
 			/* Get offset into TMP_REG */
 			EMIT(PPC_RAW_LI(tmp_reg, off));
+			/*
+			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
+			 * before and after the operation.
+			 *
+			 * This is a requirement in the Linux Kernel Memory Model.
+			 * See __cmpxchg_u32() in asm/cmpxchg.h as an example.
+			 */
+			if ((imm & BPF_FETCH) && IS_ENABLED(CONFIG_SMP))
+				EMIT(PPC_RAW_SYNC());
 			tmp_idx = ctx->idx * 4;
 			/* load value from memory into r0 */
 			EMIT(PPC_RAW_LWARX(_R0, tmp_reg, dst_reg, 0));
@@ -867,6 +876,9 @@ int bpf_jit_build_body(struct bpf_prog *
 
 			/* For the BPF_FETCH variant, get old data into src_reg */
 			if (imm & BPF_FETCH) {
+				/* Emit 'sync' to enforce full ordering */
+				if (IS_ENABLED(CONFIG_SMP))
+					EMIT(PPC_RAW_SYNC());
 				EMIT(PPC_RAW_MR(ret_reg, ax_reg));
 				if (!fp->aux->verifier_zext)
 					EMIT(PPC_RAW_LI(ret_reg - 1, 0)); /* higher 32-bit */
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -784,6 +784,15 @@ emit_clear:
 
 			/* Get offset into TMP_REG_1 */
 			EMIT(PPC_RAW_LI(tmp1_reg, off));
+			/*
+			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
+			 * before and after the operation.
+			 *
+			 * This is a requirement in the Linux Kernel Memory Model.
+			 * See __cmpxchg_u64() in asm/cmpxchg.h as an example.
+			 */
+			if ((imm & BPF_FETCH) && IS_ENABLED(CONFIG_SMP))
+				EMIT(PPC_RAW_SYNC());
 			tmp_idx = ctx->idx * 4;
 			/* load value from memory into TMP_REG_2 */
 			if (size == BPF_DW)
@@ -846,6 +855,9 @@ emit_clear:
 			PPC_BCC_SHORT(COND_NE, tmp_idx);
 
 			if (imm & BPF_FETCH) {
+				/* Emit 'sync' to enforce full ordering */
+				if (IS_ENABLED(CONFIG_SMP))
+					EMIT(PPC_RAW_SYNC());
 				EMIT(PPC_RAW_MR(ret_reg, _R0));
 				/*
 				 * Skip unnecessary zero-extension for 32-bit cmpxchg.



