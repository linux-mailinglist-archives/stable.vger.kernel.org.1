Return-Path: <stable+bounces-242997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH4aGuCD+Gn0wAIAu9opvQ
	(envelope-from <stable+bounces-242997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:32:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29464BC65B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 723CF3008D16
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46593B8D7E;
	Mon,  4 May 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blqvUYc1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875B3A6B6A
	for <stable@vger.kernel.org>; Mon,  4 May 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894365; cv=none; b=iZESdlBgUIg2B0Lgp8JT3Rx4loITAKLMQ1Wlrzx9wCVEgXAffPtRLHSjqOdg6E6COmrEaXYGrouLIUITOXkkDyQDCJjZRXg4UwxxoN8UCRNWmQ4LO9GfiWUtwhahtubshWINYV9DGHyTeFieYswZJ0jtKsflg+cReJE7NjtmKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894365; c=relaxed/simple;
	bh=vBGzFA7IwLLx2eHt5WpqgiBMvUbkepevMuAg+6q8iZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLfC7ilos1qFK1ap41HRtpFegnK31iAlhtyao5HGqBh1qyyp1xAYNWbxcNH3sBYIdkedmm4spw1bf+Y2alRKrv/PcQs7GZpXezOt85isCc0UU6o0e5pc7n9wtuAuWZmwxS3GTUKQaum/SN4ZArx68gJQ0k3XNPyws6cAU84U+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blqvUYc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131ACC2BCF4;
	Mon,  4 May 2026 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777894365;
	bh=vBGzFA7IwLLx2eHt5WpqgiBMvUbkepevMuAg+6q8iZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blqvUYc1XC2ylQKmdMGLvHorxoWkC7cVcdRsRM8Qvoi58IdWYBNh4tX6eAQZEKoVg
	 5wUiUsocxG5qwbpSBaLVru0qnpLLty/jTMslATvRKz9W90dTd9RKWHVHtME16cruWh
	 arka7n7y2C9S1f6C/ImFZs9n1wwfmvO8PoSq02Yu71P21ER5bzh9V2gbf4Nyi1PtXT
	 qZ+4ZhjgNNX0J/80LcxN2Od/j2ztioDNPzBcvtMp69AlelLrjv8N67qhhdMrJKIhHZ
	 31GYv2S3jV//Q8gSh0aBwLTJaHcnibB/B6g3mJLDPE0HIbWX7W2/eOP2PTKB/eTeGB
	 h1t0ppVuiWRZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: qrtr: ns: Limit the total number of nodes
Date: Mon,  4 May 2026 07:32:41 -0400
Message-ID: <20260504113241.2090164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050154-diagnoses-sensitive-b6e5@gregkh>
References: <2026050154-diagnoses-sensitive-b6e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B29464BC65B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242997-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
index 1da34d54092be..5c7cc7af565e8 100644
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


