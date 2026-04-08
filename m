Return-Path: <stable+bounces-234853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLHuJaCi1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:46:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDA3C180A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF60A3019477
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E47D33121F;
	Wed,  8 Apr 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LADOB4HZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22104355F30;
	Wed,  8 Apr 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673935; cv=none; b=kucfvgDtPxt330b1+pAvU38PkcNN2xLSl4vP6csd5BjT4FoyjmL1N1v6MaU87RNOynQZZzA9p+dOKrOZol1M5qogGYc3Eol1wzaBbXasn+fA7y7dOPaO6H4buJtURIWV3QIMWTzsgyKGulzkeYdhqXDecioiAskZ7WVzfd9tZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673935; c=relaxed/simple;
	bh=d/8tqFAvOca783w9avI9zE2VHcDIInzm9JbpXsOorXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEe2PqSU09dXOv98vA78cEZEhsyLT+1bYlY/EoFNFtQZbvfPStfmY4k4p0bwtr9ogbhfp5bO5QbSNE6+p7r3GXcP4A4WLK6jbmB72CoeBxFZDyhXWrcYpVnETFBMXNl/S3ley9rjMPtqw8J94wVYjwqMhoOYd1sGoW+PtiowGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LADOB4HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C6C19425;
	Wed,  8 Apr 2026 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673935;
	bh=d/8tqFAvOca783w9avI9zE2VHcDIInzm9JbpXsOorXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LADOB4HZrsGMJqTLOS2vicmVu/pQT8a132ZLGESco9lgmomkMVAq8J17Tcis4ZXfW
	 YcLiY86DDLrg/t6hJos1cUHrTrv/se+Yzrl2JH3yCUVY5bpa0Ni1Oxzfh9yWsNwFsJ
	 rgH/4MkbKO0SvJqmUjU6bLdPOwYeTnJ4AB/I/+k0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vincent Chen <vincent.chen@sifive.com>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 113/242] riscv: kgdb: fix several debug register assignment bugs
Date: Wed,  8 Apr 2026 20:02:33 +0200
Message-ID: <20260408175931.316147150@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234853-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sifive.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 30FDA3C180A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Walmsley <pjw@kernel.org>

[ Upstream commit 834911eb8eef2501485d819b4eabebadc25c3497 ]

Fix several bugs in the RISC-V kgdb implementation:

- The element of dbg_reg_def[] that is supposed to pertain to the S1
  register embeds instead the struct pt_regs offset of the A1
  register.  Fix this to use the S1 register offset in struct pt_regs.

- The sleeping_thread_to_gdb_regs() function copies the value of the
  S10 register into the gdb_regs[] array element meant for the S9
  register, and copies the value of the S11 register into the array
  element meant for the S10 register.  It also neglects to copy the
  value of the S11 register.  Fix all of these issues.

Fixes: fe89bd2be8667 ("riscv: Add KGDB support")
Cc: Vincent Chen <vincent.chen@sifive.com>
Link: https://patch.msgid.link/fde376f8-bcfd-bfe4-e467-07d8f7608d05@kernel.org
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/kgdb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 9f3db3503dabd..edaab2aa16a3e 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -175,7 +175,7 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{DBG_REG_T1, GDB_SIZEOF_REG, offsetof(struct pt_regs, t1)},
 	{DBG_REG_T2, GDB_SIZEOF_REG, offsetof(struct pt_regs, t2)},
 	{DBG_REG_FP, GDB_SIZEOF_REG, offsetof(struct pt_regs, s0)},
-	{DBG_REG_S1, GDB_SIZEOF_REG, offsetof(struct pt_regs, a1)},
+	{DBG_REG_S1, GDB_SIZEOF_REG, offsetof(struct pt_regs, s1)},
 	{DBG_REG_A0, GDB_SIZEOF_REG, offsetof(struct pt_regs, a0)},
 	{DBG_REG_A1, GDB_SIZEOF_REG, offsetof(struct pt_regs, a1)},
 	{DBG_REG_A2, GDB_SIZEOF_REG, offsetof(struct pt_regs, a2)},
@@ -244,8 +244,9 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 	gdb_regs[DBG_REG_S6_OFF] = task->thread.s[6];
 	gdb_regs[DBG_REG_S7_OFF] = task->thread.s[7];
 	gdb_regs[DBG_REG_S8_OFF] = task->thread.s[8];
-	gdb_regs[DBG_REG_S9_OFF] = task->thread.s[10];
-	gdb_regs[DBG_REG_S10_OFF] = task->thread.s[11];
+	gdb_regs[DBG_REG_S9_OFF] = task->thread.s[9];
+	gdb_regs[DBG_REG_S10_OFF] = task->thread.s[10];
+	gdb_regs[DBG_REG_S11_OFF] = task->thread.s[11];
 	gdb_regs[DBG_REG_EPC_OFF] = task->thread.ra;
 }
 
-- 
2.53.0




