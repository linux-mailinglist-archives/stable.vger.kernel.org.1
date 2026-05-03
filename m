Return-Path: <stable+bounces-242809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD8GGgSM92mIiwIAu9opvQ
	(envelope-from <stable+bounces-242809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:55:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7912D4B6DBA
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41F4630015BE
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39938B7C9;
	Sun,  3 May 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkClCzau"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71662773C3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830910; cv=none; b=PhcTgzUVchcrX+YYLhJYzQfcQ+QQoWNUQs1MaqekBH55ehrKcz4EFhxxqZQlmMNBdMd66L/09WbRHuJvjhfunIj5tF6r4zQU9nI/Pez7JRPwUswnhRjPkN2Re//znUEMfzeOgk42UjJswJg5ctxRP80/7DZZ4y9pPR8ek8uVZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830910; c=relaxed/simple;
	bh=LxWEgEZbFVqRnBekVGDqjwEWFZEjKWmSXJz9+kiBL0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twf8XPsT5UXyd/wtOeth6g0xYWbpsDv2XXQZKdlWziSKmK+u1STH24CQpvFcTiFqA208SNY/zoiK9aMdtRH6kgkQVEBtwFhkd2TJvvZNrmwBuBh9tDFlS0Txfvv+i0kj4TIbTsMMCktd7Cpzgno+rne2JzoqJQN8aVJ7uyymd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkClCzau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A12C2BCB4;
	Sun,  3 May 2026 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777830910;
	bh=LxWEgEZbFVqRnBekVGDqjwEWFZEjKWmSXJz9+kiBL0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkClCzaud3Zn5w+kTEz/f5SnSM+6PdWBrsPiyQppxZuWyR0zoLVWzGHZD+bfX8y6Y
	 n0C0RUkWx/s7oGlLlC8nYnn0RMCSFMhyx05OMnxmAvKfYRBKd1wm36Ei5kkQEDV5wD
	 7jg+w6EC/SJwXNYyKoyYCz1lBvmEXCGsdn+sgVoG9twWn5iMa9/5rGfFctkaqW8Swo
	 dukVVLwUYSC/U9UwKYbU7L8xTst5qBDxYSGAubxNpBAikmiQHnbWJjjXcihOtJqnzd
	 nDgX+JNpGPamMvUxdutkVb1/sg0MGv6hXAy4UCtlFtJl9WkCjdJWqOWNqOXyKGrryC
	 MKGmEzy089kUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: qrtr: ns: Limit the maximum number of lookups
Date: Sun,  3 May 2026 13:55:04 -0400
Message-ID: <20260503175504.1151555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050116-sibling-trace-05b5@gregkh>
References: <2026050116-sibling-trace-05b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7912D4B6DBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242809-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit 5640227d9a21c6a8be249a10677b832e7f40dc55 ]

Current code does no bound checking on the number of lookups a client can
perform. Though the code restricts the lookups to local clients, there is
still a possibility of a malicious local client sending a flood of
NEW_LOOKUP messages over the same socket.

Fix this issue by limiting the maximum number of lookups to 64 globally.
Since the nameserver allows only atmost one local observer, this global
lookup count will ensure that the lookups stay within the limit.

Note that, limit of 64 is chosen based on the current platform
requirements. If requirement changes in the future, this limit can be
increased.

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-qrtr-fix-v3-2-00a8a5ff2b51@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted comment block to only mention QRTR_NS_MAX_LOOKUPS and kept kzalloc() instead of kzalloc_obj() due to missing prerequisite commits ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3de9350cbf307..2a039153136cf 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -22,6 +22,7 @@ static struct {
 	struct socket *sock;
 	struct sockaddr_qrtr bcast_sq;
 	struct list_head lookups;
+	u32 lookup_count;
 	struct workqueue_struct *workqueue;
 	struct work_struct work;
 	int local_node;
@@ -69,6 +70,11 @@ struct qrtr_node {
 	struct xarray servers;
 };
 
+/* Max lookup limit is chosen based on the current platform requirements. If the
+ * requirement changes in the future, this value can be increased.
+ */
+#define QRTR_NS_MAX_LOOKUPS 64
+
 static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
@@ -417,6 +423,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 
 		list_del(&lookup->li);
 		kfree(lookup);
+		qrtr_ns.lookup_count--;
 	}
 
 	/* Remove the server belonging to this port but don't broadcast
@@ -534,6 +541,11 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	if (from->sq_node != qrtr_ns.local_node)
 		return -EINVAL;
 
+	if (qrtr_ns.lookup_count >= QRTR_NS_MAX_LOOKUPS) {
+		pr_err_ratelimited("QRTR client node exceeds max lookup limit!\n");
+		return -ENOSPC;
+	}
+
 	lookup = kzalloc(sizeof(*lookup), GFP_KERNEL);
 	if (!lookup)
 		return -ENOMEM;
@@ -542,6 +554,7 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	lookup->service = service;
 	lookup->instance = instance;
 	list_add_tail(&lookup->li, &qrtr_ns.lookups);
+	qrtr_ns.lookup_count++;
 
 	memset(&filter, 0, sizeof(filter));
 	filter.service = service;
@@ -582,6 +595,7 @@ static void ctrl_cmd_del_lookup(struct sockaddr_qrtr *from,
 
 		list_del(&lookup->li);
 		kfree(lookup);
+		qrtr_ns.lookup_count--;
 	}
 }
 
-- 
2.53.0


