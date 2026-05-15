Return-Path: <stable+bounces-248385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEAuCTBKB2rUwQIAu9opvQ
	(envelope-from <stable+bounces-248385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:30:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96EB5534CD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75DCC3119DC8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867A3B635B;
	Fri, 15 May 2026 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EvAfb4b0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068B3A961B;
	Fri, 15 May 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861600; cv=none; b=dny2/ij6EPg2ChPF8WoxoSrjxzhRdJZ81f44oEQ4XzJjPNNtESl/0SV8vBa33VLR9Q7NILfDlVsLlNixk8PhxVuV73pj2zPZrgKh6jzH+ilLcwXDplorc7ccLNBVbnX4EOmJCWYdBzy7toRgqi5Tb15lxiuB7IBHnD6sTHigeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861600; c=relaxed/simple;
	bh=qRx1Myc65XmuaIqFkw3Sc5fHKzm2axDy9dvG/KlABdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSsFR/JeBqUSQGtp0lpfp+hkl18wTP1ZwA8UM/iLEpL/bYvCGWP/x8zhlK9efy+kl5RTf8aqBcklbr4PUA4pBCW/MMjJwy5tnuwO3mXugL+wQiaETg7yHgGfoSn+Y2taWmRbGpdIX2jlxmMOhPJfTgd5Bos0c8hrlkTbkCZ/CxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EvAfb4b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67901C2BCB0;
	Fri, 15 May 2026 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861600;
	bh=qRx1Myc65XmuaIqFkw3Sc5fHKzm2axDy9dvG/KlABdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvAfb4b0E6qPndQA6LTondi3Q0GpIC8AO4eHSQI0rKkQcT2UImiWmIcsPgi5C5iQR
	 fWpesgo3BSl54xT4ctSQCRnQNcRdD7WNk99sXYkwZ4lqP+9MW6MdC3hUrV3iIkGKMe
	 A8+FksUNBi4yl3JtNNs+j2Dli+0MNTPbinjH+Vcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 392/474] net: qrtr: ns: Limit the total number of nodes
Date: Fri, 15 May 2026 17:48:21 +0200
Message-ID: <20260515154723.524991597@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B96EB5534CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248385-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/qrtr/ns.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -82,6 +82,13 @@ struct qrtr_node {
  */
 #define QRTR_NS_MAX_LOOKUPS 64
 
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
@@ -90,6 +97,11 @@ static struct qrtr_node *node_get(unsign
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
@@ -103,6 +115,8 @@ static struct qrtr_node *node_get(unsign
 		return NULL;
 	}
 
+	node_count++;
+
 	return node;
 }
 
@@ -406,6 +420,7 @@ static int ctrl_cmd_bye(struct sockaddr_
 delete_node:
 	xa_erase(&nodes, from->sq_node);
 	kfree(node);
+	node_count--;
 
 	return ret;
 }



