Return-Path: <stable+bounces-14039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DC8837F42
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EAA1F29736
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF93412A161;
	Tue, 23 Jan 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SbDDnr/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BF12A155;
	Tue, 23 Jan 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971020; cv=none; b=a2XO6WNi1Ejq0pHjHDArR5cuTOlPuo5S+Qa6ajMYMojS98d868FsKUu66InsXKU2FJRT2EX/dfMkaZM3R0WS7xhHwFPrJ1pUF08K3wuYhw9l1bV199yFO5iQ7H3S46YZYYQwrQxbvbAuA6d0sjY182UmXpa7oY8Mam70z1MOjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971020; c=relaxed/simple;
	bh=RoUi1SxsfhXL4bL+DdCzQPh/b/Zmfc4fmakw5g7+Hqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4LkZTGnpyoO2+ilPMMwzmwGSLevAEAAb8Bfcb0DklZg0AgQ8FP7OwwP5MgkV7h6XQQpZ0/iIh4E+lDkDgGrAlYTv5dd8s5Rm2lpi4SpplIwY1JmXBJe/vD6RBwSiBxHMdvKoxmRvEZgGNjcoTr+LTeTjJb29knf+LFwVShrq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SbDDnr/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21E0C433C7;
	Tue, 23 Jan 2024 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971020;
	bh=RoUi1SxsfhXL4bL+DdCzQPh/b/Zmfc4fmakw5g7+Hqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbDDnr/SoKiHWFyWCVOt3Z6/aO3FWQTvKq3KGWkrhoXjrSrNXzPALgIPXRLIrCTdM
	 tJ/A1ReEQvLIT8DMl3HiJcL7Wmbfcr5lPTee1kGpVj9JBsLXSloDuvXR0d3H2EGfwF
	 etn1eQPHMFloOc0icMiyRZ7Fs01Y5Q4+TzXWrLNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 071/286] calipso: fix memory leak in netlbl_calipso_add_pass()
Date: Mon, 22 Jan 2024 15:56:17 -0800
Message-ID: <20240122235734.751485989@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit ec4e9d630a64df500641892f4e259e8149594a99 ]

If IPv6 support is disabled at boot (ipv6.disable=1),
the calipso_init() -> netlbl_calipso_ops_register() function isn't called,
and the netlbl_calipso_ops_get() function always returns NULL.
In this case, the netlbl_calipso_add_pass() function allocates memory
for the doi_def variable but doesn't free it with the calipso_doi_free().

BUG: memory leak
unreferenced object 0xffff888011d68180 (size 64):
  comm "syz-executor.1", pid 10746, jiffies 4295410986 (age 17.928s)
  hex dump (first 32 bytes):
    00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<...>] kmalloc include/linux/slab.h:552 [inline]
    [<...>] netlbl_calipso_add_pass net/netlabel/netlabel_calipso.c:76 [inline]
    [<...>] netlbl_calipso_add+0x22e/0x4f0 net/netlabel/netlabel_calipso.c:111
    [<...>] genl_family_rcv_msg_doit+0x22f/0x330 net/netlink/genetlink.c:739
    [<...>] genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
    [<...>] genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c:800
    [<...>] netlink_rcv_skb+0x14d/0x440 net/netlink/af_netlink.c:2515
    [<...>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
    [<...>] netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
    [<...>] netlink_unicast+0x54b/0x800 net/netlink/af_netlink.c:1339
    [<...>] netlink_sendmsg+0x90a/0xdf0 net/netlink/af_netlink.c:1934
    [<...>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<...>] sock_sendmsg+0x157/0x190 net/socket.c:671
    [<...>] ____sys_sendmsg+0x712/0x870 net/socket.c:2342
    [<...>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2396
    [<...>] __sys_sendmsg+0xea/0x1b0 net/socket.c:2429
    [<...>] do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
    [<...>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller

Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink protocol.")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
[PM: merged via the LSM tree at Jakub Kicinski request]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlabel/netlabel_calipso.c | 49 +++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
index 91a19c3ea1a3..84ef4a29864b 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -54,6 +54,28 @@ static const struct nla_policy calipso_genl_policy[NLBL_CALIPSO_A_MAX + 1] = {
 	[NLBL_CALIPSO_A_MTYPE] = { .type = NLA_U32 },
 };
 
+static const struct netlbl_calipso_ops *calipso_ops;
+
+/**
+ * netlbl_calipso_ops_register - Register the CALIPSO operations
+ * @ops: ops to register
+ *
+ * Description:
+ * Register the CALIPSO packet engine operations.
+ *
+ */
+const struct netlbl_calipso_ops *
+netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
+{
+	return xchg(&calipso_ops, ops);
+}
+EXPORT_SYMBOL(netlbl_calipso_ops_register);
+
+static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
+{
+	return READ_ONCE(calipso_ops);
+}
+
 /* NetLabel Command Handlers
  */
 /**
@@ -96,15 +118,18 @@ static int netlbl_calipso_add_pass(struct genl_info *info,
  *
  */
 static int netlbl_calipso_add(struct sk_buff *skb, struct genl_info *info)
-
 {
 	int ret_val = -EINVAL;
 	struct netlbl_audit audit_info;
+	const struct netlbl_calipso_ops *ops = netlbl_calipso_ops_get();
 
 	if (!info->attrs[NLBL_CALIPSO_A_DOI] ||
 	    !info->attrs[NLBL_CALIPSO_A_MTYPE])
 		return -EINVAL;
 
+	if (!ops)
+		return -EOPNOTSUPP;
+
 	netlbl_netlink_auditinfo(&audit_info);
 	switch (nla_get_u32(info->attrs[NLBL_CALIPSO_A_MTYPE])) {
 	case CALIPSO_MAP_PASS:
@@ -362,28 +387,6 @@ int __init netlbl_calipso_genl_init(void)
 	return genl_register_family(&netlbl_calipso_gnl_family);
 }
 
-static const struct netlbl_calipso_ops *calipso_ops;
-
-/**
- * netlbl_calipso_ops_register - Register the CALIPSO operations
- * @ops: ops to register
- *
- * Description:
- * Register the CALIPSO packet engine operations.
- *
- */
-const struct netlbl_calipso_ops *
-netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
-{
-	return xchg(&calipso_ops, ops);
-}
-EXPORT_SYMBOL(netlbl_calipso_ops_register);
-
-static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
-{
-	return READ_ONCE(calipso_ops);
-}
-
 /**
  * calipso_doi_add - Add a new DOI to the CALIPSO protocol engine
  * @doi_def: the DOI structure
-- 
2.43.0




