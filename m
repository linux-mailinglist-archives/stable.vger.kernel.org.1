Return-Path: <stable+bounces-152970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475BADD1AB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C8F188D0C8
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C42E9753;
	Tue, 17 Jun 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="faKO1asx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E51E8332;
	Tue, 17 Jun 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174430; cv=none; b=MkctRriyCO/OAU4XIeYfqfqwXsClkQqGLU6HglWEUfBnDQpG8HS/HdGXngUfiBFtbHFTf+uEJRpIU81R7cLIDzc95zhcc/yrY6GiWMV1/dYIX4n83jF/3dU5z71RnLyHRGMnN9Pkj0cRJ8wFfB3ZCUOscz6Nnf2vQmCi6WxoWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174430; c=relaxed/simple;
	bh=2eeGmzbezLmOPYJ9xjqYRkKDG1Ix1e0Q/QHFUsXhe5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onTaXuMYlIF5wNWRf6KVHy9jxr9ncBWcZWuuiA0XiAk6icdnnK4aR4SVFi+7f1BtaMZvDrBfkPGaDG7y6HrCo5/1k9q8n08Eq8m9yIgOJUScOx1wGMsKBbsZn34dyPQ2PPoxoSRXBwJijTC/qU1oH1T3rRYkbgsjrA1Q775nypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=faKO1asx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18D7C4CEE3;
	Tue, 17 Jun 2025 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174430;
	bh=2eeGmzbezLmOPYJ9xjqYRkKDG1Ix1e0Q/QHFUsXhe5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=faKO1asxPPZ/zSe0BaM/IlXP/0jvu2z1SEVcZGgofL02QMhcC/c7smonNcpu5gwAB
	 rQ513BsfHSsK1Eonu/N5uqZvaXZyf6EBuL7c9cjc9jsDnLMS/XPBKSaXoj0cCZuAUz
	 8IiPMjUkvkddZywGFouAs9gAp5Bj4fYxTNgMaStg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 018/512] x86/insn: Fix opcode map (!REX2) superscript tags
Date: Tue, 17 Jun 2025 17:19:44 +0200
Message-ID: <20250617152420.261872896@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit ca698ec2f07873a448d53c580795c4e023c75393 ]

Commit:

  159039af8c07 ("x86/insn: x86/insn: Add support for REX2 prefix to the instruction decoder opcode map")

added (!REX2) superscript with a space, but the correct format requires ','
for concatination with other superscript tags.

Add ',' to generate correct insn attribute tables.

I confirmed with following command:

      arch/x86/lib/x86-opcode-map.txt | grep e8 | head -n 1
  [0xe8] = INAT_MAKE_IMM(INAT_IMM_VWORD32) | INAT_FORCE64 | INAT_NO_REX2,

Fixes: 159039af8c07 ("x86/insn: x86/insn: Add support for REX2 prefix to the instruction decoder opcode map")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/174580489027.388420.15539375184727726142.stgit@devnote2
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/x86-opcode-map.txt       | 50 +++++++++++++--------------
 tools/arch/x86/lib/x86-opcode-map.txt | 50 +++++++++++++--------------
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index f5dd84eb55dcd..cd3fd5155f6ec 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -35,7 +35,7 @@
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
 #
-# REX2 Prefix
+# REX2 Prefix Superscripts
 #  - (!REX2): REX2 is not allowed
 #  - (REX2): REX2 variant e.g. JMPABS
 
@@ -286,10 +286,10 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
-e1: LOOPE/LOOPZ Jb (f64) (!REX2)
-e2: LOOP Jb (f64) (!REX2)
-e3: JrCXZ Jb (f64) (!REX2)
+e0: LOOPNE/LOOPNZ Jb (f64),(!REX2)
+e1: LOOPE/LOOPZ Jb (f64),(!REX2)
+e2: LOOP Jb (f64),(!REX2)
+e3: JrCXZ Jb (f64),(!REX2)
 e4: IN AL,Ib (!REX2)
 e5: IN eAX,Ib (!REX2)
 e6: OUT Ib,AL (!REX2)
@@ -298,10 +298,10 @@ e7: OUT Ib,eAX (!REX2)
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64) (!REX2)
-e9: JMP-near Jz (f64) (!REX2)
-ea: JMP-far Ap (i64) (!REX2)
-eb: JMP-short Jb (f64) (!REX2)
+e8: CALL Jz (f64),(!REX2)
+e9: JMP-near Jz (f64),(!REX2)
+ea: JMP-far Ap (i64),(!REX2)
+eb: JMP-short Jb (f64),(!REX2)
 ec: IN AL,DX (!REX2)
 ed: IN eAX,DX (!REX2)
 ee: OUT DX,AL (!REX2)
@@ -478,22 +478,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64) (!REX2)
-81: JNO Jz (f64) (!REX2)
-82: JB/JC/JNAE Jz (f64) (!REX2)
-83: JAE/JNB/JNC Jz (f64) (!REX2)
-84: JE/JZ Jz (f64) (!REX2)
-85: JNE/JNZ Jz (f64) (!REX2)
-86: JBE/JNA Jz (f64) (!REX2)
-87: JA/JNBE Jz (f64) (!REX2)
-88: JS Jz (f64) (!REX2)
-89: JNS Jz (f64) (!REX2)
-8a: JP/JPE Jz (f64) (!REX2)
-8b: JNP/JPO Jz (f64) (!REX2)
-8c: JL/JNGE Jz (f64) (!REX2)
-8d: JNL/JGE Jz (f64) (!REX2)
-8e: JLE/JNG Jz (f64) (!REX2)
-8f: JNLE/JG Jz (f64) (!REX2)
+80: JO Jz (f64),(!REX2)
+81: JNO Jz (f64),(!REX2)
+82: JB/JC/JNAE Jz (f64),(!REX2)
+83: JAE/JNB/JNC Jz (f64),(!REX2)
+84: JE/JZ Jz (f64),(!REX2)
+85: JNE/JNZ Jz (f64),(!REX2)
+86: JBE/JNA Jz (f64),(!REX2)
+87: JA/JNBE Jz (f64),(!REX2)
+88: JS Jz (f64),(!REX2)
+89: JNS Jz (f64),(!REX2)
+8a: JP/JPE Jz (f64),(!REX2)
+8b: JNP/JPO Jz (f64),(!REX2)
+8c: JL/JNGE Jz (f64),(!REX2)
+8d: JNL/JGE Jz (f64),(!REX2)
+8e: JLE/JNG Jz (f64),(!REX2)
+8f: JNLE/JG Jz (f64),(!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index f5dd84eb55dcd..cd3fd5155f6ec 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -35,7 +35,7 @@
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
 #
-# REX2 Prefix
+# REX2 Prefix Superscripts
 #  - (!REX2): REX2 is not allowed
 #  - (REX2): REX2 variant e.g. JMPABS
 
@@ -286,10 +286,10 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
-e1: LOOPE/LOOPZ Jb (f64) (!REX2)
-e2: LOOP Jb (f64) (!REX2)
-e3: JrCXZ Jb (f64) (!REX2)
+e0: LOOPNE/LOOPNZ Jb (f64),(!REX2)
+e1: LOOPE/LOOPZ Jb (f64),(!REX2)
+e2: LOOP Jb (f64),(!REX2)
+e3: JrCXZ Jb (f64),(!REX2)
 e4: IN AL,Ib (!REX2)
 e5: IN eAX,Ib (!REX2)
 e6: OUT Ib,AL (!REX2)
@@ -298,10 +298,10 @@ e7: OUT Ib,eAX (!REX2)
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64) (!REX2)
-e9: JMP-near Jz (f64) (!REX2)
-ea: JMP-far Ap (i64) (!REX2)
-eb: JMP-short Jb (f64) (!REX2)
+e8: CALL Jz (f64),(!REX2)
+e9: JMP-near Jz (f64),(!REX2)
+ea: JMP-far Ap (i64),(!REX2)
+eb: JMP-short Jb (f64),(!REX2)
 ec: IN AL,DX (!REX2)
 ed: IN eAX,DX (!REX2)
 ee: OUT DX,AL (!REX2)
@@ -478,22 +478,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64) (!REX2)
-81: JNO Jz (f64) (!REX2)
-82: JB/JC/JNAE Jz (f64) (!REX2)
-83: JAE/JNB/JNC Jz (f64) (!REX2)
-84: JE/JZ Jz (f64) (!REX2)
-85: JNE/JNZ Jz (f64) (!REX2)
-86: JBE/JNA Jz (f64) (!REX2)
-87: JA/JNBE Jz (f64) (!REX2)
-88: JS Jz (f64) (!REX2)
-89: JNS Jz (f64) (!REX2)
-8a: JP/JPE Jz (f64) (!REX2)
-8b: JNP/JPO Jz (f64) (!REX2)
-8c: JL/JNGE Jz (f64) (!REX2)
-8d: JNL/JGE Jz (f64) (!REX2)
-8e: JLE/JNG Jz (f64) (!REX2)
-8f: JNLE/JG Jz (f64) (!REX2)
+80: JO Jz (f64),(!REX2)
+81: JNO Jz (f64),(!REX2)
+82: JB/JC/JNAE Jz (f64),(!REX2)
+83: JAE/JNB/JNC Jz (f64),(!REX2)
+84: JE/JZ Jz (f64),(!REX2)
+85: JNE/JNZ Jz (f64),(!REX2)
+86: JBE/JNA Jz (f64),(!REX2)
+87: JA/JNBE Jz (f64),(!REX2)
+88: JS Jz (f64),(!REX2)
+89: JNS Jz (f64),(!REX2)
+8a: JP/JPE Jz (f64),(!REX2)
+8b: JNP/JPO Jz (f64),(!REX2)
+8c: JL/JNGE Jz (f64),(!REX2)
+8d: JNL/JGE Jz (f64),(!REX2)
+8e: JLE/JNG Jz (f64),(!REX2)
+8f: JNLE/JG Jz (f64),(!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
-- 
2.39.5




