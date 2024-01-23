Return-Path: <stable+bounces-13211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F3837AFB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75B2283108
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1D1487D3;
	Tue, 23 Jan 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjMSk7Z5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A61487D0;
	Tue, 23 Jan 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969148; cv=none; b=h6mLQU2kWfO36vzuBMbg3+DU5PfV4+vh/QtLqEp34CuCvSodWY2XbbGfeHLk9AUYPy+JxdtnZe6QHlDKdvOT+Bw+Q+4Coj0mTr/eRjL7pkRi5cz7veX4K9BiE6o3adsh/IIqkVXUcaLvKPHAzT+WPQm+XGyAhxGRGaT7LBRGSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969148; c=relaxed/simple;
	bh=WRjGD8RYjMiP4qNqiW6MRhsrihA9R1Una9NpQqiMNyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aV6jwxx3kcJEn20+0533P+0jGhmLQ/wJ2bemKnTSYF3qjpXulTZKU57BNfBlOpNbueRyNcDNwZZrSIsU6Kb9Jvr5oATIcMp/K/hkl01I3VUQ9t80swGdheE7b+KM1DRDH9sr/8irsv9rlSLHasMOLsqQ8glQpFCHU/VcEgJgZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjMSk7Z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902A1C43394;
	Tue, 23 Jan 2024 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969147;
	bh=WRjGD8RYjMiP4qNqiW6MRhsrihA9R1Una9NpQqiMNyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjMSk7Z5deGVVkRTrLOKncpKObT/GQKCfs/7WsBZyEXlv+PGxEqhG7ZP7iEgGLBrf
	 IF9+kvser65jAVrfl169q+No0SWT1nCzlkHUEokLzKhQm5xf7I8WZDRMGSbOF6oJHd
	 eLbSl7Z9b4gIh0blsKpYu2uv5VrUfPJ0F1kzF2Bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 030/641] calipso: fix memory leak in netlbl_calipso_add_pass()
Date: Mon, 22 Jan 2024 15:48:54 -0800
Message-ID: <20240122235819.028789753@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

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
index f1d5b8465217..a07c2216d28b 100644
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
@@ -363,28 +388,6 @@ int __init netlbl_calipso_genl_init(void)
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




