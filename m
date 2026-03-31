Return-Path: <stable+bounces-231486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AHuCZj2y2kGNAYAu9opvQ
	(envelope-from <stable+bounces-231486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:30:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE65036CA9A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CF8D3055A27
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626062EE262;
	Tue, 31 Mar 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpMbNUco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520D30C345;
	Tue, 31 Mar 2026 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974297; cv=none; b=qFcwmJ2hb/E4kb+ib9mTFtqyPeL3wGmeLvgs5zGC21lI+s9HFqGU3Skhu12y0xgZVxe2FR67tNfHUv/PnhP/5XicUSZOwdykrNaigNoe8eOyjdveV3lEJR70+5XWxuf09BljUp1HE2UNETHe82C0nMTPP3MuxYLxv5kt1O9Dsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974297; c=relaxed/simple;
	bh=ez8jx2xjKK4/nFL1CC10HcnWTlvLEU4dLddSMX8Kphs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlEO13n0EZRkDtEPNk06OCt0o31eP5ZwqYgSztZyrvlR9PKrunsYSfdE3mDoJyKDEpz+xmZ9BDK2SYLaZlAV2VZkZ+3XQO9neCke7C5aS5J7WpnwdgUPB0QUnFHUUh4uIOFtCUyrzoc1rulpBj6qKWd+CKWoZuXLP8rZrdzsngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpMbNUco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797F9C19423;
	Tue, 31 Mar 2026 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974296;
	bh=ez8jx2xjKK4/nFL1CC10HcnWTlvLEU4dLddSMX8Kphs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpMbNUco2zpv3ZGVBRInXQBzvXmxG2cKIV5MIaCcBmprcTL5J+QRM/rHbGCcUFLqs
	 ZRYYoNzyzhHPGGWlyOVGrLRGXHCiOJ/CKlp3DlTfcv3UJmiWZ85ADxSeWkDQ3kcaTs
	 2w8LfIASpWyaTMl0NnSf2iyLuH3m3wXLbt3xokn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/175] objtool: Handle Clang RSP musical chairs
Date: Tue, 31 Mar 2026 18:20:14 +0200
Message-ID: <20260331161730.893627302@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231486-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,arndb.de:email]
X-Rspamd-Queue-Id: CE65036CA9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 7fdaa640c810cb42090a182c33f905bcc47a616a ]

For no apparent reason (possibly related to CONFIG_KMSAN), Clang can
randomly pass the value of RSP to other registers and then back again to
RSP.  Handle that accordingly.

Fixes the following warnings:

  drivers/input/misc/uinput.o: warning: objtool: uinput_str_to_user+0x165: undefined stack state
  drivers/input/misc/uinput.o: warning: objtool: uinput_str_to_user+0x165: unknown CFA base reg -1

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/90956545-2066-46e3-b547-10c884582eb0@app.fastmail.com
Link: https://patch.msgid.link/240e6a172cc73292499334a3724d02ccb3247fc7.1772818491.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/arch/x86/decode.c | 62 ++++++++++++---------------------
 tools/objtool/check.c           | 14 ++++++++
 2 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c0f25d00181ec..40a5aa02bd831 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -325,52 +325,36 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		if (!rex_w)
 			break;
 
-		if (modrm_reg == CFI_SP) {
-
-			if (mod_is_reg()) {
-				/* mov %rsp, reg */
-				ADD_OP(op) {
-					op->src.type = OP_SRC_REG;
-					op->src.reg = CFI_SP;
-					op->dest.type = OP_DEST_REG;
-					op->dest.reg = modrm_rm;
-				}
-				break;
-
-			} else {
-				/* skip RIP relative displacement */
-				if (is_RIP())
-					break;
-
-				/* skip nontrivial SIB */
-				if (have_SIB()) {
-					modrm_rm = sib_base;
-					if (sib_index != CFI_SP)
-						break;
-				}
-
-				/* mov %rsp, disp(%reg) */
-				ADD_OP(op) {
-					op->src.type = OP_SRC_REG;
-					op->src.reg = CFI_SP;
-					op->dest.type = OP_DEST_REG_INDIRECT;
-					op->dest.reg = modrm_rm;
-					op->dest.offset = ins.displacement.value;
-				}
-				break;
+		if (mod_is_reg()) {
+			/* mov reg, reg */
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG;
+				op->src.reg = modrm_reg;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = modrm_rm;
 			}
-
 			break;
 		}
 
-		if (rm_is_reg(CFI_SP)) {
+		/* skip RIP relative displacement */
+		if (is_RIP())
+			break;
 
-			/* mov reg, %rsp */
+		/* skip nontrivial SIB */
+		if (have_SIB()) {
+			modrm_rm = sib_base;
+			if (sib_index != CFI_SP)
+				break;
+		}
+
+		/* mov %rsp, disp(%reg) */
+		if (modrm_reg == CFI_SP) {
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
-				op->src.reg = modrm_reg;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
+				op->src.reg = CFI_SP;
+				op->dest.type = OP_DEST_REG_INDIRECT;
+				op->dest.reg = modrm_rm;
+				op->dest.offset = ins.displacement.value;
 			}
 			break;
 		}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c021798ba8372..6497c80fd6f77 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2969,6 +2969,20 @@ static int update_cfi_state(struct instruction *insn,
 				cfi->stack_size += 8;
 			}
 
+			else if (cfi->vals[op->src.reg].base == CFI_CFA) {
+				/*
+				 * Clang RSP musical chairs:
+				 *
+				 *   mov %rsp, %rdx [handled above]
+				 *   ...
+				 *   mov %rdx, %rbx [handled here]
+				 *   ...
+				 *   mov %rbx, %rsp [handled above]
+				 */
+				cfi->vals[op->dest.reg].base = CFI_CFA;
+				cfi->vals[op->dest.reg].offset = cfi->vals[op->src.reg].offset;
+			}
+
 
 			break;
 
-- 
2.51.0




