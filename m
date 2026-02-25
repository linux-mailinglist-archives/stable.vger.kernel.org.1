Return-Path: <stable+bounces-219292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBELOxWfnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:04:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C1192E47
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F57C315F217
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BFB2D94AF;
	Wed, 25 Feb 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BisftjRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E82D77EA;
	Wed, 25 Feb 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002620; cv=none; b=PPFBkPWhZnbyvKNvKjOTo5mpFRO3EbRhpx9GPof9h1Sc2TzWwsPclmNmtjbsfy9uksii/MNEvpqzABpV3b8LZdsZ8D2ygI8CSPFOzhUlRJi67eN6wdPb7NiY1lW9XfGt9fKcMmmavfGM71dlrFyW3HiKOJjPZWoaapkJNUogQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002620; c=relaxed/simple;
	bh=bBAfxyNQyPxGyBvC4W23u+KL7K9XdiqCdVSEwUV95Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFC9ygYLGyof9XifLZNhL8+1Aujl+Jsn7e8XhQd1hFrikX6lR0Abt/oTaXo26ph2YsYB6aIUBcDqVYdpqQr+oc+CZTibDaQb0/dMBLOgAL3GG3gZ6zJ6H2o7GNOLwPQIVJPYCyu9Trpa2mQBOcEuJm7j29uWbBePV1iY2KHoW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BisftjRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE55C116D0;
	Wed, 25 Feb 2026 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002620;
	bh=bBAfxyNQyPxGyBvC4W23u+KL7K9XdiqCdVSEwUV95Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BisftjRvXL1VUgbANMq2qPcBVg5j9x1ojabpbBvujsRvDAUdfAgnBIfDOpiXdgd+g
	 H1rl3FPJQQuXq/A1UeKmRlioJHAKJpxPxPvISKq8+yWqWh8uifUKV3MvmjxIt3emy5
	 Wb1xgQam4YFki07E4QpAjSApSmMvYOyHvwbsT+RQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Dege <michael.dege@renesas.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 334/641] net: renesas: rswitch: fix forwarding offload statemachine
Date: Tue, 24 Feb 2026 17:21:00 -0800
Message-ID: <20260225012356.774351720@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-219292-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 514C1192E47
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Dege <michael.dege@renesas.com>

[ Upstream commit e9a5073a98d940837cbb95e71eed1f28f48e7b30 ]

A change of the port state of one port, caused the state of another
port to change. This behvior was unintended.

Fixes: b7502b1043de ("net: renesas: rswitch: add offloading for L2 switching")
Signed-off-by: Michael Dege <michael.dege@renesas.com>
Link: https://patch.msgid.link/20260206-fix-offloading-statemachine-v3-1-07bfba07d03e@renesas.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/rswitch_l2.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_l2.c b/drivers/net/ethernet/renesas/rswitch_l2.c
index 4a69ec77d69c6..9433cd8adced9 100644
--- a/drivers/net/ethernet/renesas/rswitch_l2.c
+++ b/drivers/net/ethernet/renesas/rswitch_l2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Renesas Ethernet Switch device driver
  *
- * Copyright (C) 2025 Renesas Electronics Corporation
+ * Copyright (C) 2025 - 2026 Renesas Electronics Corporation
  */
 
 #include <linux/err.h>
@@ -60,6 +60,7 @@ static void rswitch_update_l2_hw_learning(struct rswitch_private *priv)
 static void rswitch_update_l2_hw_forwarding(struct rswitch_private *priv)
 {
 	struct rswitch_device *rdev;
+	bool new_forwarding_offload;
 	unsigned int fwd_mask;
 
 	/* calculate fwd_mask with zeroes in bits corresponding to ports that
@@ -73,8 +74,9 @@ static void rswitch_update_l2_hw_forwarding(struct rswitch_private *priv)
 	}
 
 	rswitch_for_all_ports(priv, rdev) {
-		if ((rdev_for_l2_offload(rdev) && rdev->forwarding_requested) ||
-		    rdev->forwarding_offloaded) {
+		new_forwarding_offload = (rdev_for_l2_offload(rdev) && rdev->forwarding_requested);
+
+		if (new_forwarding_offload || rdev->forwarding_offloaded) {
 			/* Update allowed offload destinations even for ports
 			 * with L2 offload enabled earlier.
 			 *
@@ -84,13 +86,10 @@ static void rswitch_update_l2_hw_forwarding(struct rswitch_private *priv)
 				  priv->addr + FWPC2(rdev->port));
 		}
 
-		if (rdev_for_l2_offload(rdev) &&
-		    rdev->forwarding_requested &&
-		    !rdev->forwarding_offloaded) {
+		if (new_forwarding_offload && !rdev->forwarding_offloaded)
 			rswitch_change_l2_hw_offloading(rdev, true, false);
-		} else if (rdev->forwarding_offloaded) {
+		else if (!new_forwarding_offload && rdev->forwarding_offloaded)
 			rswitch_change_l2_hw_offloading(rdev, false, false);
-		}
 	}
 }
 
-- 
2.51.0




