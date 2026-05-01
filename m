Return-Path: <stable+bounces-242387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOUxMyOY9GnTCgIAu9opvQ
	(envelope-from <stable+bounces-242387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:10:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 167344AC3E1
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78B7A30093B8
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9939E6C9;
	Fri,  1 May 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6WrKSCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520524DCF9
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637406; cv=none; b=ol8ibR4+IT71lgRWSntZJGyMSGJH/AGKADQIl4ioWyzfkWm05gIwCxVcrRsapMMmJyueFFDwHHb5E5RjQHjRhLdZpnqJMlw6XWkX4MKL46ZrY5+mbF0w5TjKTdI7fHNLkX1jEdqk28QnlOtYlHtpMo3Ex0iN3yjvzvW6gySSHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637406; c=relaxed/simple;
	bh=/WlYp5tTdMIpdBWSJcapuHWNfGoup5dbH5hBneVr4Sc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S1q0p/sKTnapBQ7yP0XaJFVVtAsFlU3kYhtUVArzUckfxtQdnvACe10EO9pycPz1yEQrfkiIm+UkOgTK4aMik8nhQ2w6Q26myaNYsV+9lJ5T/bEtoOpIKsrWmJ8VNYcOPXHXz5x/H9T6uyu464FCTXBqYvKA9OHFKdw7Bx/toh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6WrKSCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B3EC2BCB4;
	Fri,  1 May 2026 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777637406;
	bh=/WlYp5tTdMIpdBWSJcapuHWNfGoup5dbH5hBneVr4Sc=;
	h=Subject:To:Cc:From:Date:From;
	b=N6WrKSCCtrRYR5JD2DjcTdhmapZM+/15PZdAKFPRdQkKZSGtMUy9GX8iKzQ8BoH9V
	 QFU2S3qDJ+SdZb5R4V8xa+x3M4DGRHYEFxREC7n7w3f+tn2HxC286NAj5Rm5mW22Ng
	 kWzyVMi9vSSFj/S/T5FpMCGJ3R/dZEk2fu0Q+t2M=
Subject: FAILED: patch "[PATCH] net: qrtr: ns: Limit the total number of nodes" failed to apply to 5.10-stable tree
To: manivannan.sadhasivam@oss.qualcomm.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:09:54 +0200
Message-ID: <2026050154-diagnoses-sensitive-b6e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 167344AC3E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,msgid.link:server fail,gregkh:server fail,linuxfoundation.org:server fail,qualcomm.com:server fail];
	TAGGED_FROM(0.00)[bounces-242387-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,gregkh:email,linuxfoundation.org:dkim]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 27d5e84e810b0849d08b9aec68e48570461ce313
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050154-diagnoses-sensitive-b6e5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27d5e84e810b0849d08b9aec68e48570461ce313 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 23:04:15 +0530
Subject: [PATCH] net: qrtr: ns: Limit the total number of nodes

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

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 1b9a90240a68..c0418764470b 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -71,12 +71,16 @@ struct qrtr_node {
 	u32 server_count;
 };
 
-/* Max server, lookup limits are chosen based on the current platform requirements.
- * If the requirement changes in the future, these values can be increased.
+/* Max nodes, server, lookup limits are chosen based on the current platform
+ * requirements. If the requirement changes in the future, these values can be
+ * increased.
  */
+#define QRTR_NS_MAX_NODES   64
 #define QRTR_NS_MAX_SERVERS 256
 #define QRTR_NS_MAX_LOOKUPS 64
 
+static u8 node_count;
+
 static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
@@ -85,6 +89,11 @@ static struct qrtr_node *node_get(unsigned int node_id)
 	if (node)
 		return node;
 
+	if (node_count >= QRTR_NS_MAX_NODES) {
+		pr_err_ratelimited("QRTR clients exceed max node limit!\n");
+		return NULL;
+	}
+
 	/* If node didn't exist, allocate and insert it to the tree */
 	node = kzalloc_obj(*node);
 	if (!node)
@@ -98,6 +107,8 @@ static struct qrtr_node *node_get(unsigned int node_id)
 		return NULL;
 	}
 
+	node_count++;
+
 	return node;
 }
 
@@ -404,6 +415,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 delete_node:
 	xa_erase(&nodes, from->sq_node);
 	kfree(node);
+	node_count--;
 
 	return ret;
 }


