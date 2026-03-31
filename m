Return-Path: <stable+bounces-231838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG5ED9z/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4AF36E098
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45B7E3172072
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA53425CD5;
	Tue, 31 Mar 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YO6n3xQX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3203421A1D;
	Tue, 31 Mar 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975200; cv=none; b=klBahz4YH4BBdsll4scVSL0/Jfp6i6Go73NIT5pdNYmXkz6krjPqPPLgcIfdeRSsq751EWwSq1VkJCYG8zoGJnrZq+r1aDyUN1mMO6JaRrIHc3gxqqh6evw0aGOpAVnqAPrvj8v6Kw9RA+c+SPRclrd3rwXMFQwoFWKZThmzs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975200; c=relaxed/simple;
	bh=W1sxsnNmokIy4hSx2EQoKOi9vksy7E+noBB9M99ju+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dljnqy3YV0Lt6QvG7wt+wB58LFL3omhSG7kHokR1wpW+opwqGqjF4vdUX2bGIDaRKHCexEq6heYtKowHQzM7eD+layYvvSt8LPhLlR9AmunHjklI44PEhQ48R4wpGkodp/WBJVc/OQkNWS+gcMPQNzVhWxQU+xnBggZnAqDENrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YO6n3xQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B39C19423;
	Tue, 31 Mar 2026 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975200;
	bh=W1sxsnNmokIy4hSx2EQoKOi9vksy7E+noBB9M99ju+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YO6n3xQXns27ZZRmU0HyNeIZPg+RYMjRYqtRuYc9J8n1J0Jy0P6VPuFZSyqrsHTWQ
	 kOZg+UzuFg/kP+bAnxxnB+KhsYMiYNJyNwhM04Z/vs4Ifh0j2sAQsMu7fg+2atsT91
	 p0c6giLsArT8dRAUc2wj06tH0HsZUGAJ3QExXcnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Barrera <ivan.d.barrera@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 159/342] RDMA/irdma: Clean up unnecessary dereference of event->cm_node
Date: Tue, 31 Mar 2026 18:19:52 +0200
Message-ID: <20260331161804.861645419@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231838-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 1B4AF36E098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Barrera <ivan.d.barrera@intel.com>

[ Upstream commit b415399c9a024d574b65479636f0d4eb625b9abd ]

The cm_node is available and the usage of cm_node and event->cm_node
seems arbitrary. Clean up unnecessary dereference of event->cm_node.

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Ivan Barrera <ivan.d.barrera@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/cm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index f4f4f92ba63ac..128cfcf27714d 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -4239,21 +4239,21 @@ static void irdma_cm_event_handler(struct work_struct *work)
 		irdma_cm_event_reset(event);
 		break;
 	case IRDMA_CM_EVENT_CONNECTED:
-		if (!event->cm_node->cm_id ||
-		    event->cm_node->state != IRDMA_CM_STATE_OFFLOADED)
+		if (!cm_node->cm_id ||
+		    cm_node->state != IRDMA_CM_STATE_OFFLOADED)
 			break;
 		irdma_cm_event_connected(event);
 		break;
 	case IRDMA_CM_EVENT_MPA_REJECT:
-		if (!event->cm_node->cm_id ||
+		if (!cm_node->cm_id ||
 		    cm_node->state == IRDMA_CM_STATE_OFFLOADED)
 			break;
 		irdma_send_cm_event(cm_node, cm_node->cm_id,
 				    IW_CM_EVENT_CONNECT_REPLY, -ECONNREFUSED);
 		break;
 	case IRDMA_CM_EVENT_ABORTED:
-		if (!event->cm_node->cm_id ||
-		    event->cm_node->state == IRDMA_CM_STATE_OFFLOADED)
+		if (!cm_node->cm_id ||
+		    cm_node->state == IRDMA_CM_STATE_OFFLOADED)
 			break;
 		irdma_event_connect_error(event);
 		break;
@@ -4263,7 +4263,7 @@ static void irdma_cm_event_handler(struct work_struct *work)
 		break;
 	}
 
-	irdma_rem_ref_cm_node(event->cm_node);
+	irdma_rem_ref_cm_node(cm_node);
 	kfree(event);
 }
 
-- 
2.53.0




