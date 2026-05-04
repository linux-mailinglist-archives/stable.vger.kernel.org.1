Return-Path: <stable+bounces-242992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHBLHLJ2+GlavgIAu9opvQ
	(envelope-from <stable+bounces-242992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:36:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E04BBD2D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C318300FEEA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D153A4F2D;
	Mon,  4 May 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjLnS72c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1203A3E80
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890781; cv=none; b=AIi6+KmEWHxfxgXmMiXSpagnTyrN13WBMe46H39S5rdFED15ZRw8LOuV3VUlcC50ZVDeOKij+2gOCoAG5XNYLH5+UcxjBTclqw2xPUD2otSfKpQltaJPpDRnjcBh8MW9TIJkXeKtHPf9Tfy55/+8Lqo977ALa1FnmWVYKT52hsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890781; c=relaxed/simple;
	bh=Jp2dRtSbJ6bggEeqzfFJcjmzx+vU6aa4ExgTZk+M29g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6neiLVpJSzP/XYFah5o4Np6ayIYCVn7VMivOl73SQQuQ8FmiFwfcDkJnfN1t/R/w+IzYNjH0HPypKI493AHtUjRCMYYOCW7obNYUVF7+HlVgagEh2eLjJrxdbd0KAsWHRMW6G1Ee8Gm953CjuH92+MsJ7bCCWZph3hm3oJ3pN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjLnS72c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C5EC2BCB8;
	Mon,  4 May 2026 10:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777890780;
	bh=Jp2dRtSbJ6bggEeqzfFJcjmzx+vU6aa4ExgTZk+M29g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjLnS72cH/C4DVX6/N6nX8iBnIKQibkyeyXz2s78gdBQAdfBIPDIl5aFmBVadzCHV
	 xkHDUX09tiCgR0bSrjf9zuzaBT3z7tRPYnFeFvJyLnxbD1CLytD+97BY4sE2y6lLQV
	 cX7ivLaNdWIBIFfHtRQv4abMxHYVGREoVlecWFKX0ZatfbnQf0gC+TejlA0LR50Q7I
	 lfh6buUXcx1eZkr2LcDVfrGnehQ7DndO7oeIl0sajE6B7mZpBCUPVBV5SWSOKLmD+L
	 GqZ7VkfB/9Djx1Tc6b6V13egsDxuV5E0pjRv/Hz0CzpmfoUqcr/9S5+mquOqahfZWZ
	 nDwqLncCXrbzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: qrtr: ns: Limit the total number of nodes
Date: Mon,  4 May 2026 06:32:53 -0400
Message-ID: <20260504103253.2070381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050153-why-recopy-0aae@gregkh>
References: <2026050153-why-recopy-0aae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C26E04BBD2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242992-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit 27d5e84e810b0849d08b9aec68e48570461ce313 ]

Currently, the nameserver doesn't limit the number of nodes it handles.
This can be an attack vector if a malicious client starts registering
random nodes, leading to memory exhaustion.

Hence, limit the maximum number of nodes to 64. Note that, limit of 64 is
chosen based on the current platform requirements. If requirement changes
in the future, this limit can be increased.

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-qrtr-fix-v3-4-00a8a5ff2b51@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ dropped node_count-- hunk since ctrl_cmd_bye() has no delete_node ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3c513e7ca2d5c..03b5ae3100de7 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -68,6 +68,16 @@ struct qrtr_node {
 	struct radix_tree_root servers;
 };
 
+/* Max nodes, server, lookup limits are chosen based on the current platform
+ * requirements. If the requirement changes in the future, these values can be
+ * increased.
+ */
+#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_SERVERS 256
+#define QRTR_NS_MAX_LOOKUPS 64
+
+static u8 node_count;
+
 static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
@@ -76,6 +86,11 @@ static struct qrtr_node *node_get(unsigned int node_id)
 	if (node)
 		return node;
 
+	if (node_count >= QRTR_NS_MAX_NODES) {
+		pr_err_ratelimited("QRTR clients exceed max node limit!\n");
+		return NULL;
+	}
+
 	/* If node didn't exist, allocate and insert it to the tree */
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
@@ -88,6 +103,8 @@ static struct qrtr_node *node_get(unsigned int node_id)
 		return NULL;
 	}
 
+	node_count++;
+
 	return node;
 }
 
-- 
2.53.0


