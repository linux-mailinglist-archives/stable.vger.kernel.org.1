Return-Path: <stable+bounces-242370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOhhLPGX9GnTCgIAu9opvQ
	(envelope-from <stable+bounces-242370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:09:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51D4AC385
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B99563010BA1
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4403A1680;
	Fri,  1 May 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dLPzu1+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504AD24DCF9
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637351; cv=none; b=skKgdVHijNIC+mgAN6RF6v12Rf3Yc7tZBPds4QY/G0J7aHC3baR5cKjnHdZFFvfrfkp2O+OVRfIVdr0bpyl5PbxpEl+FodjDLjjfpdEm0SfVLT7TJBViKmzKruKyXhJMqBPbx3jhzuD6/5B7qdQchcF/aWEV4MnSiAGr2QrLnwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637351; c=relaxed/simple;
	bh=wkc2/BVAbUT0zgQUjUM5y84yKSp8yzs78WsIi/BC7IM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n+AL4yCojdVAQzvWq51v9jInaEPgEl3sCrw9/vjH99bgFf0tX7tmuBH/XHewBF7rdAiee/vLBkerfNG0oXVMq0eUnYGLnlZ4kKXn2CTwQP7Nxi8HbgufTe+8KPh96wuc4uTcKpBjx8vE7uUFeam3Dc0kkHSzmqeM5gGGlEHzKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dLPzu1+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67A5C2BCB4;
	Fri,  1 May 2026 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777637351;
	bh=wkc2/BVAbUT0zgQUjUM5y84yKSp8yzs78WsIi/BC7IM=;
	h=Subject:To:Cc:From:Date:From;
	b=dLPzu1+DY//0pQPC+tnGgrCyV/wFRFuzqs8zNV1FVbt7RjvRRnVbWe/LB5FuufmvZ
	 uAEIeTOX635plhnI+5uLmU3Kk1Hht3zVdd9RI1va423rDQK1mMpBP25xXItInGE5Ni
	 z8J9PJPCv+6eXrvngAE0K9E9ruvUYlDLGGjsxt6I=
Subject: FAILED: patch "[PATCH] net: qrtr: ns: Limit the maximum server registration per node" failed to apply to 5.15-stable tree
To: manivannan.sadhasivam@oss.qualcomm.com,horms@kernel.org,kuba@kernel.org,yimingqian591@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:09:03 +0200
Message-ID: <2026050103-reproduce-payment-a434@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE51D4AC385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242370-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,qualcomm.com:server fail,sea.lore.kernel.org:server fail,linuxfoundation.org:server fail,gregkh:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d5ee2ff98322337951c56398e79d51815acbf955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050103-reproduce-payment-a434@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5ee2ff98322337951c56398e79d51815acbf955 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 23:04:12 +0530
Subject: [PATCH] net: qrtr: ns: Limit the maximum server registration per node

Current code does no bound checking on the number of servers added per
node. A malicious client can flood NEW_SERVER messages and exhaust memory.

Fix this issue by limiting the maximum number of server registrations to
256 per node. If the NEW_SERVER message is received for an old port, then
don't restrict it as it will get replaced. While at it, also rate limit
the error messages in the failure path of qrtr_ns_worker().

Note that the limit of 256 is chosen based on the current platform
requirements. If requirement changes in the future, this limit can be
increased.

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-qrtr-fix-v3-1-00a8a5ff2b51@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3203b2220860..63cb5861d87a 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -67,8 +67,14 @@ struct qrtr_server {
 struct qrtr_node {
 	unsigned int id;
 	struct xarray servers;
+	u32 server_count;
 };
 
+/* Max server limit is chosen based on the current platform requirements. If the
+ * requirement changes in the future, this value can be increased.
+ */
+#define QRTR_NS_MAX_SERVERS 256
+
 static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
@@ -229,6 +235,17 @@ static struct qrtr_server *server_add(unsigned int service,
 	if (!service || !port)
 		return NULL;
 
+	node = node_get(node_id);
+	if (!node)
+		return NULL;
+
+	/* Make sure the new servers per port are capped at the maximum value */
+	old = xa_load(&node->servers, port);
+	if (!old && node->server_count >= QRTR_NS_MAX_SERVERS) {
+		pr_err_ratelimited("QRTR client node %u exceeds max server limit!\n", node_id);
+		return NULL;
+	}
+
 	srv = kzalloc_obj(*srv);
 	if (!srv)
 		return NULL;
@@ -238,10 +255,6 @@ static struct qrtr_server *server_add(unsigned int service,
 	srv->node = node_id;
 	srv->port = port;
 
-	node = node_get(node_id);
-	if (!node)
-		goto err;
-
 	/* Delete the old server on the same port */
 	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
@@ -252,6 +265,8 @@ static struct qrtr_server *server_add(unsigned int service,
 		} else {
 			kfree(old);
 		}
+	} else {
+		node->server_count++;
 	}
 
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
@@ -292,6 +307,7 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	}
 
 	kfree(srv);
+	node->server_count--;
 
 	return 0;
 }
@@ -670,7 +686,7 @@ static void qrtr_ns_worker(struct work_struct *work)
 		}
 
 		if (ret < 0)
-			pr_err("failed while handling packet from %d:%d",
+			pr_err_ratelimited("failed while handling packet from %d:%d",
 			       sq.sq_node, sq.sq_port);
 	}
 


