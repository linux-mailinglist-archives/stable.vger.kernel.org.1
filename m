Return-Path: <stable+bounces-242870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKp7C1tX+GkgtQIAu9opvQ
	(envelope-from <stable+bounces-242870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:22:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A86294BA1F2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5830030117AB
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF155329C66;
	Mon,  4 May 2026 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ+4SqsB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E323290DC
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882961; cv=none; b=jYpyXcJsvHAlemFsv4Dazq+yVk8qIaeKnpO0qO2MDrRovjZw+WZoFZsIkhtTMh0sbChXwhFhmmZyvHN7vhwFL9A13XO6RKn7XEXGTF1zHI6U1J+nnmS421eWQyx/7HvrJBbfu1qCayxPPfACQyJUJCxWIz1G2cIsv5ia/CBBif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882961; c=relaxed/simple;
	bh=dZXNwV4xvM6iP/D46AEvpuUjax6ampSRGqrTI4UFz5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcJbKC1vP2T09Z91WHcbkMDn3JXWC77LowQZkedfeT+/KHKhfPfHhCaMPOYHPX9JxrLKsz0uacUHRSa8rLp45frPXZnt5TYySM1bzEKeODHPY+IR37/4athNagQi7J+rvEOjhZk6yPjbpc0lhUaL95Pt3RdXYZFc96XMGJChG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ+4SqsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25252C2BCF4;
	Mon,  4 May 2026 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777882961;
	bh=dZXNwV4xvM6iP/D46AEvpuUjax6ampSRGqrTI4UFz5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJ+4SqsBAhJEVkvKjaFXYZ5CAIa/RI54FlcOeei3RuNwfJrErtW6eB1V1/jWACaYr
	 V4ErGGIdaIOvdnUtagRlGO/1x11Out6ZqBrl2ug91owpb6nchrM9CHmy8A8t5V86P5
	 P0Ifn+w4Uh3lNSrzVD07w14yONri8K8dan81NRJ6nttb1kIbAzfW0AkhuS2rw0b5co
	 go0+og4xDaO25FKXRpCUtqVnKfPFsWukLDSbkYqGPGIwy8NTe5/jWnsC+PRZf63T30
	 5ug4TiWDzO/dldF8BjE2sJEh8RP6rZpQtBmst4cQ/qXA0ErcVSYIawt39iWo2s2OtI
	 YgmqMHpu6bpDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] net: qrtr: ns: Limit the total number of nodes
Date: Mon,  4 May 2026 04:22:33 -0400
Message-ID: <20260504082233.1875710-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504082233.1875710-1-sashal@kernel.org>
References: <2026050152-wok-satchel-2937@gregkh>
 <20260504082233.1875710-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A86294BA1F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242870-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
index 7f7bd87cc6052..8a545b66d14bb 100644
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
 
@@ -383,6 +397,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 delete_node:
 	xa_erase(&nodes, from->sq_node);
 	kfree(node);
+	node_count--;
 
 	return ret;
 }
-- 
2.53.0


