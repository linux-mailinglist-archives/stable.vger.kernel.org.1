Return-Path: <stable+bounces-227888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK6sIWnewGn6NQQAu9opvQ
	(envelope-from <stable+bounces-227888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:32:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7042ED161
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E5E73003BC2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6962C234E;
	Mon, 23 Mar 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="apiZGX1x"
X-Original-To: stable@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DE2C21F4
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774247522; cv=none; b=WIdxWUJPIvkTg3ytBw7vfPLrGEk6QbmJbY80145I7SpvKLBbWLF90Zgyyj10j6ckJnahNHgt9fMo0axBjaM0wW3aNOsazPIbJbUm1WZ6gd6QkRxRXbHXvoYsRRV25xKGOcCTcYMh789VsylVoMR4rL0rsnGd5zQ70yQI0M0pb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774247522; c=relaxed/simple;
	bh=Rs2neo4FxLnmJGr6Qjf/JC9WoglZcU1W5DKFZwrmMtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a7mHArbz4/VFP9g4eEIdX36jw7Zz1x8vrIP4EyHB3NHibRPQGth20djSLKJ6XhzF7lW6Hkocu1qmhNNKZAF//6tk5m8wpxKCImjpfHKA2nuxLdsCFIhRktVyXFJL9yg129dyYeTlyAsolspg57V83ulL6BwQ51Nj8VHtHP+QA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=apiZGX1x; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1774247519;
	bh=w/6QTn2RrWbgNuU6QaGGcFWM01G6XO+tMUvHhd4TYjY=;
	h=From:Subject:Date:Message-Id;
	b=apiZGX1xPLe0/OOKwdf6suNVwdnBU5rmu4fwPshn/sIMJhR8XqxSXrNpTtU0qydDd
	 IT7mEGyCvMSmwhd3b9t2bu5af5sdtiYkkj4dLhqBdPQP8VPXzdNrq+L5yVarXf9eFz
	 re2RQM+57zhvtMux1CI7JRu3xTAgzocqRz4XNrY4=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.23) with ESMTP
	id 69C0DE330000165C; Mon, 23 Mar 2026 14:31:19 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 6027208913430
X-SMAIL-UIID: F608F980582B4633BEBF41786CA6AB3D-20260323-143119-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	zhangchunyan@iscas.ac.cn
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	xujiakai2025@iscas.ac.cn,
	linux-riscv@lists.infradead.org,
	pjw@kernel.org
Subject: [PATCH 6.1.y] riscv: stacktrace: Disable KASAN checks for non-current tasks
Date: Mon, 23 Mar 2026 14:31:14 +0800
Message-Id: <20260323063115.3555043-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227888-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sina.cn:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[sina.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seclists.org:url,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F7042ED161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

[ Upstream commit 060ea84a484e852b52b938f234bf9b5503a6c910 ]

Unwinding the stack of a task other than current, KASAN would report
"BUG: KASAN: out-of-bounds in walk_stackframe+0x41c/0x460"

There is a same issue on x86 and has been resolved by the commit
84936118bdf3 ("x86/unwind: Disable KASAN checks for non-current tasks")
The solution could be applied to RISC-V too.

This patch also can solve the issue:
https://seclists.org/oss-sec/2025/q4/23

Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
Co-developed-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Link: https://lore.kernel.org/r/20251022072608.743484-1-zhangchunyan@iscas.ac.cn
[pjw@kernel.org: clean up checkpatch issues]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
[ Minor conflict resolved. ]
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 arch/riscv/kernel/stacktrace.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 10e311b2759d..4f78b7962651 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,6 +16,22 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
+/*
+ * This disables KASAN checking when reading a value from another task's stack,
+ * since the other task could be running on another CPU and could have poisoned
+ * the stack in the meantime.
+ */
+#define READ_ONCE_TASK_STACK(task, x)			\
+({							\
+	unsigned long val;				\
+	unsigned long addr = x;				\
+	if ((task) == current)				\
+		val = READ_ONCE(addr);			\
+	else						\
+		val = READ_ONCE_NOCHECK(addr);		\
+	val;						\
+})
+
 extern asmlinkage void ret_from_exception(void);
 
 static inline int fp_is_valid(unsigned long fp, unsigned long sp)
@@ -68,8 +84,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->ra;
 			pc = regs->ra;
 		} else {
-			fp = frame->fp;
-			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
+			fp = READ_ONCE_TASK_STACK(task, frame->fp);
+			pc = READ_ONCE_TASK_STACK(task, frame->ra);
+			pc = ftrace_graph_ret_addr(current, &graph_idx, pc,
 						   &frame->ra);
 			if (pc == (unsigned long)ret_from_exception) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
-- 
2.34.1


