Return-Path: <stable+bounces-242862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGSpFoBN+GmQsQIAu9opvQ
	(envelope-from <stable+bounces-242862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:40:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BCC4B9744
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45B023016C99
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C63043CF;
	Mon,  4 May 2026 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhOnUny/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E88303A37
	for <stable@vger.kernel.org>; Mon,  4 May 2026 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880416; cv=none; b=kFeHiNXrndSAWBqh+FtwaSsa/XIPu7d5aYtFOK4EkZ/L9jlNCBegvROY8YurysIPiLtTdu9yZULyJP4KQ4Ad8X1iyVRMbcI30cwHxTerb25Rq4OTMZl66AowIaOVEUCKxCbIl6JWWlu5iUfEDIpCXHstlLVETm3dKdQaWlpj/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880416; c=relaxed/simple;
	bh=YwKzZ3hsrpIYkQts1JCSz/KBpRmwBX3YeC2nkET2p8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqC5VVXU229fBfx+XyTYYvABIZhNDjB34SgWnZzlJkSkxyUnxNW4fP0fh8Vmj0JL3YtjlK2J/oihpTCXAnxYIYK4sK+LisX6xPjTWWC0XEjyYGjWGk9PWQw97HTnWwHKK2ePJEFm3BA2ejQxNh8hvGx6pmtuY4KP2aeiXQ1LgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhOnUny/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4934CC2BCB8;
	Mon,  4 May 2026 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777880416;
	bh=YwKzZ3hsrpIYkQts1JCSz/KBpRmwBX3YeC2nkET2p8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhOnUny/HwnSwRWX6kOPBm1+9Qb6donv9dxYtl4FTyudAqroincMg0dpL1U3CL7tP
	 H3EzsJQE6/jRRzR+iLkn1PJsQfFlUV9soZfCG0w5FrDAGPrGFcTm/rymj50bVYqoN6
	 zMZiKKDGj1NEwkh1/vrbvnCe5lHAG2oWM3dKjIe3qq9WtkTl/mklaryz4dAi7E4tug
	 RBkjn+WA4QCcp+5bQmC++kUVZLARCW5kvBNb9gD0/bvnXkgttocwYxH6rmieR4pDie
	 ODSN1G5R19qtlIRzsOonAB5Q251N8NsG5xf0rGymeXaj3c+rGh2OkjEPZwGrjdSVdL
	 y4+ksmvCFWMzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] net: qrtr: ns: Limit the total number of nodes
Date: Mon,  4 May 2026 03:40:08 -0400
Message-ID: <20260504074008.1850682-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504074008.1850682-1-sashal@kernel.org>
References: <2026050151-blooper-pang-c22e@gregkh>
 <20260504074008.1850682-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4BCC4B9744
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-242862-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

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
[ dropped comment/define changes for missing QRTR_NS_MAX_SERVERS/LOOKUPS prereqs and kept plain kzalloc instead of kzalloc_obj ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index e1f27464279cf..adb6a4ba093db 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -69,6 +69,13 @@ struct qrtr_node {
 	struct xarray servers;
 };
 
+/* Max nodes limit is chosen based on the current platform requirements.
+ * If the requirement changes in the future, this value can be increased.
+ */
+#define QRTR_NS_MAX_NODES   64
+
+static u8 node_count;
+
 static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
@@ -77,6 +84,11 @@ static struct qrtr_node *node_get(unsigned int node_id)
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
@@ -90,6 +102,8 @@ static struct qrtr_node *node_get(unsigned int node_id)
 		return NULL;
 	}
 
+	node_count++;
+
 	return node;
 }
 
@@ -386,6 +400,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 delete_node:
 	xa_erase(&nodes, from->sq_node);
 	kfree(node);
+	node_count--;
 
 	return ret;
 }
-- 
2.53.0


