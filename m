Return-Path: <stable+bounces-228513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOpLMvJTwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:53:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA72F55FC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E2B3183B4A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921A39890A;
	Mon, 23 Mar 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TzKr1222"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5DD823DD;
	Mon, 23 Mar 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275331; cv=none; b=SzcoWAnR5Sk7G4dUT4pDv0Ci209qd+SEqT1Ws5Vcnvzrymeu4PT5J3mvKSjXhmLRm6JcVeD7o/qzxhCOEk/bIE/8/8A7tFjNZDFAI0GWztyg9ZPLMNbGgJk7kkuTFvN3snYzUHbCCjK5Z0s8pwmKB0NWLHuiJdz+O3uoHOxfiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275331; c=relaxed/simple;
	bh=Ocbp8Nl9bMeETmfVngz3i0DrdjdPotFNHZjhCmCOgNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpsSbnjt5BOCvKXoAhQrlMsPBRhkBZG6OgzLoI+JOlnETcuX3D21Lw7pGvUxrgpE7/Hmks4JG7fUrg09NpLkntbxjFfoYVSe/U02eZnUvRA3YdQvQcbC05larPVKMbKjGg1lNm9eh4xLJmeMobdKYGnjIrjy5l57QyNMJHIX4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TzKr1222; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9340EC4CEF7;
	Mon, 23 Mar 2026 14:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275330;
	bh=Ocbp8Nl9bMeETmfVngz3i0DrdjdPotFNHZjhCmCOgNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TzKr1222lD/X5ZsVdnRMtsUDz5ktb6UXlLct8QgDL0AgHIaWJG9vVMhng5cowVvHL
	 LEq9weLjmuQnsHMOvkiBCyiFq6cY+SJCG9tjVDOoRTn6UHM5PUC8EomhnXdULWo+y3
	 F0QunHl2ibD8eZcpzfXhTWIzyk2q21pvGbkIw3wE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 052/460] bonding: Correctly support GSO ESP offload
Date: Mon, 23 Mar 2026 14:40:48 +0100
Message-ID: <20260323134527.986370361@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228513-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,jvosburgh.net,redhat.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 57AA72F55FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a ]

The referenced fix is incomplete. It correctly computes
bond_dev->gso_partial_features across slaves, but unfortunately
netdev_fix_features discards gso_partial_features from the feature set
if NETIF_F_GSO_PARTIAL isn't set in bond_dev->features.

This is visible with ethtool -k bond0 | grep esp:
tx-esp-segmentation: off [requested on]
esp-hw-offload: on
esp-tx-csum-hw-offload: on

This patch reworks the bonding GSO offload support by:
- making aggregating gso_partial_features across slaves similar to the
  other feature sets (this part is a no-op).
- advertising the default partial gso features on empty bond devs, same
  as with other feature sets (also a no-op).
- adding NETIF_F_GSO_PARTIAL to hw_enc_features filtered across slaves.
- adding NETIF_F_GSO_PARTIAL to features in bond_setup()

With all of these, 'ethtool -k bond0 | grep esp' now reports:
tx-esp-segmentation: on
esp-hw-offload: on
esp-tx-csum-hw-offload: on

Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Link: https://patch.msgid.link/20250127104147.759658-1-cratiu@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index aac385607ac42..fe29a0911308d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1548,17 +1548,20 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
+				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_PARTIAL)
 
 #define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_GSO_SOFTWARE)
 
+#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 
 static void bond_compute_features(struct bonding *bond)
 {
+	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;
-	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
 	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
 	netdev_features_t enc_features  = BOND_ENC_FEATURES;
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1592,8 +1595,9 @@ static void bond_compute_features(struct bonding *bond)
 							  BOND_XFRM_FEATURES);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
-			gso_partial_features &= slave->dev->gso_partial_features;
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 slave->dev->gso_partial_features,
+								 BOND_GSO_PARTIAL_FEATURES);
 
 		mpls_features = netdev_increment_features(mpls_features,
 							  slave->dev->mpls_features,
@@ -1608,12 +1612,8 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
-	if (gso_partial_features & NETIF_F_GSO_ESP)
-		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
-	else
-		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
-
 done:
+	bond_dev->gso_partial_features = gso_partial_features;
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
 				    NETIF_F_HW_VLAN_CTAG_TX |
@@ -6082,6 +6082,7 @@ void bond_setup(struct net_device *bond_dev)
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
 	bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
+	bond_dev->features |= NETIF_F_GSO_PARTIAL;
 #ifdef CONFIG_XFRM_OFFLOAD
 	bond_dev->hw_features |= BOND_XFRM_FEATURES;
 	/* Only enable XFRM features if this is an active-backup config */
-- 
2.51.0




