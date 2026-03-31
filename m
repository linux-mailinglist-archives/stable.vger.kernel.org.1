Return-Path: <stable+bounces-232093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOF9K6YCzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:21:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0277036E8B3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D5B32CD183
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1BE4279F2;
	Tue, 31 Mar 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvmEw1hd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA44279F0;
	Tue, 31 Mar 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975857; cv=none; b=Pj2nA5fcWXmODsGoR9Nxmm3IDmxyWwLfnl4R9DaIGNLAnBcMDN9GEWGWCLOJkkNFEvOEaFAiNTwPqQ9yT6VSlVpdOEn6IN8NBUG2MQSiFoKE94HsBCtUBxIOPaxsIiVWn+6hgSHzfpkCjtrfcWx9TDpZGtbgtpeff9qLJn8uqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975857; c=relaxed/simple;
	bh=CrVCiliTRJZCEbUktdG5AqllTQmLkg8J1zNgehaUut0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j83oPIlO8EhQzXNk+C5GPHb4sm8xmGUv/3piGm0Q1QBQyuSrkpIdPeq/EveKBbVsGfDfAFeZLUEqZX6G1qzQWpV2N98ZCjnCZnrIfX7lWTL2EJDinn9RjXRRr4gxB8w/fsfVRiNHgKK/I8iMyYrjNfsq1nPYJiLKbRcmsEInSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvmEw1hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E894C19423;
	Tue, 31 Mar 2026 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975857;
	bh=CrVCiliTRJZCEbUktdG5AqllTQmLkg8J1zNgehaUut0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvmEw1hd75xeIs3puyJkccCEBBAZU2l8LU8W6we7fZqXh+r5/hGVh9g79hO4cIhjx
	 sjt8mBxs/wwaOiBnArCh2IsyFm8pp6UUlqlO3nxT8EjTtttOf/m8d/DmNYTVVxR85l
	 MV1JyvZRk0SiQ+1drXm2jyjkyN+9WVgeggADtQU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 114/244] RDMA/irdma: Return EINVAL for invalid arp index error
Date: Tue, 31 Mar 2026 18:21:04 +0200
Message-ID: <20260331161745.875384289@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232093-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0277036E8B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit 7221f581eefa79ead06e171044f393fb7ee22f87 ]

When rdma_connect() fails due to an invalid arp index, user space rdma core
reports ENOMEM which is confusing. Modify irdma_make_cm_node() to return the
correct error code.

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/cm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index e7f315e102d51..6a911f6230648 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -2240,11 +2240,12 @@ irdma_make_cm_node(struct irdma_cm_core *cm_core, struct irdma_device *iwdev,
 	int oldarpindex;
 	int arpindex;
 	struct net_device *netdev = iwdev->netdev;
+	int ret;
 
 	/* create an hte and cm_node for this instance */
 	cm_node = kzalloc(sizeof(*cm_node), GFP_ATOMIC);
 	if (!cm_node)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	/* set our node specific transport info */
 	cm_node->ipv4 = cm_info->ipv4;
@@ -2347,8 +2348,10 @@ irdma_make_cm_node(struct irdma_cm_core *cm_core, struct irdma_device *iwdev,
 			arpindex = -EINVAL;
 	}
 
-	if (arpindex < 0)
+	if (arpindex < 0) {
+		ret = -EINVAL;
 		goto err;
+	}
 
 	ether_addr_copy(cm_node->rem_mac,
 			iwdev->rf->arp_table[arpindex].mac_addr);
@@ -2359,7 +2362,7 @@ irdma_make_cm_node(struct irdma_cm_core *cm_core, struct irdma_device *iwdev,
 err:
 	kfree(cm_node);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void irdma_destroy_connection(struct irdma_cm_node *cm_node)
@@ -3020,8 +3023,8 @@ static int irdma_create_cm_node(struct irdma_cm_core *cm_core,
 
 	/* create a CM connection node */
 	cm_node = irdma_make_cm_node(cm_core, iwdev, cm_info, NULL);
-	if (!cm_node)
-		return -ENOMEM;
+	if (IS_ERR(cm_node))
+		return PTR_ERR(cm_node);
 
 	/* set our node side to client (active) side */
 	cm_node->tcp_cntxt.client = 1;
@@ -3218,9 +3221,9 @@ void irdma_receive_ilq(struct irdma_sc_vsi *vsi, struct irdma_puda_buf *rbuf)
 		cm_info.cm_id = listener->cm_id;
 		cm_node = irdma_make_cm_node(cm_core, iwdev, &cm_info,
 					     listener);
-		if (!cm_node) {
+		if (IS_ERR(cm_node)) {
 			ibdev_dbg(&cm_core->iwdev->ibdev,
-				  "CM: allocate node failed\n");
+				  "CM: allocate node failed ret=%ld\n", PTR_ERR(cm_node));
 			refcount_dec(&listener->refcnt);
 			return;
 		}
-- 
2.53.0




