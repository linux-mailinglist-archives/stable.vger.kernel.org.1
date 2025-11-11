Return-Path: <stable+bounces-194343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B637C4B13C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DC574F1472
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624D2F12C1;
	Tue, 11 Nov 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLYNeR8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BE26B76A;
	Tue, 11 Nov 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825381; cv=none; b=J8Hg93TAvdrqWakljUN5VvHkBn7dNeEyem4D+/Po5WtLZdce2mZF5rYNNyI2PQrxq2tHK76CqjWpYvhNWXhm0raImnWT6Zo4jgEmrSWkpzkXKS7pgefKDUMRblOyWft6ZBDXoSYJe89JC1BJ2HmQPi3DTenrEx9VxfM0vbZnRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825381; c=relaxed/simple;
	bh=gsNaFRHbtHxQCfKp9N/wlxXsjSe3x4du2//i6O5mcUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7hk3jueHSPGMrp6GO81aSP1qBiSxB6ZxaT2FRNfOIsQZk1xYcT8Lg5eP4iQUxD+BscMg/wTwxz2clt9/ucaeyYXG8zAFbuoeNn8wWuq0CDP9FKzVrBZe5ai+BhDHmIdvxDPf9qgaXpTd9QvWbJVn7x2/ypMT7epUfiMUqnToqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLYNeR8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2957AC19425;
	Tue, 11 Nov 2025 01:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762825381;
	bh=gsNaFRHbtHxQCfKp9N/wlxXsjSe3x4du2//i6O5mcUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLYNeR8ahGCtAgseYiBlws2L+yWct2ygGbV/r5CAS0tZVYgZTkLoosQfDPpI4iKzM
	 /c22WvycfPyRqpivQwri0dSp6wYpYFGJkn3th0KUbTA2mzNsUZo+8Re+0Ue0lPNpJj
	 mTceu8T2A1CQiN2JC1nE8bj9cjEcJbPBF+rrmJyw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mohammad Heib <mheib@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 778/849] net: ionic: map SKB after pseudo-header checksum prep
Date: Tue, 11 Nov 2025 09:45:48 +0900
Message-ID: <20251111004555.240306634@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammad Heib <mheib@redhat.com>

[ Upstream commit de0337d641bfa5b6d6b489e479792f1039274e84 ]

The TSO path called ionic_tx_map_skb() before preparing the TCP pseudo
checksum (ionic_tx_tcp_[inner_]pseudo_csum()), which may perform
skb_cow_head() and might modifies bytes in the linear header area.

Mapping first and then mutating the header risks:
  - Using a stale DMA address if skb_cow_head() relocates the head, and/or
  - Device reading stale header bytes on weakly-ordered systems
    (CPU writes after mapping are not guaranteed visible without an
    explicit dma_sync_single_for_device()).

Reorder the TX path to perform all header mutations (including
skb_cow_head()) *before* DMA mapping. Mapping is now done only after the
skb layout and header contents are final. This removes the need for any
post-mapping dma_sync and prevents on-wire corruption observed under
VLAN+TSO load after repeated runs.

This change is purely an ordering fix; no functional behavior change
otherwise.

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Link: https://patch.msgid.link/20251031155203.203031-2-mheib@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 30 ++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2e571d0a0d8a2..301ebee2fdc50 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1448,19 +1448,6 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 	bool encap;
 	int err;
 
-	desc_info = &q->tx_info[q->head_idx];
-
-	if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
-		return -EIO;
-
-	len = skb->len;
-	mss = skb_shinfo(skb)->gso_size;
-	outer_csum = (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
-						   SKB_GSO_GRE_CSUM |
-						   SKB_GSO_IPXIP4 |
-						   SKB_GSO_IPXIP6 |
-						   SKB_GSO_UDP_TUNNEL |
-						   SKB_GSO_UDP_TUNNEL_CSUM));
 	has_vlan = !!skb_vlan_tag_present(skb);
 	vlan_tci = skb_vlan_tag_get(skb);
 	encap = skb->encapsulation;
@@ -1474,12 +1461,21 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 		err = ionic_tx_tcp_inner_pseudo_csum(skb);
 	else
 		err = ionic_tx_tcp_pseudo_csum(skb);
-	if (unlikely(err)) {
-		/* clean up mapping from ionic_tx_map_skb */
-		ionic_tx_desc_unmap_bufs(q, desc_info);
+	if (unlikely(err))
 		return err;
-	}
 
+	desc_info = &q->tx_info[q->head_idx];
+	if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
+		return -EIO;
+
+	len = skb->len;
+	mss = skb_shinfo(skb)->gso_size;
+	outer_csum = (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
+						   SKB_GSO_GRE_CSUM |
+						   SKB_GSO_IPXIP4 |
+						   SKB_GSO_IPXIP6 |
+						   SKB_GSO_UDP_TUNNEL |
+						   SKB_GSO_UDP_TUNNEL_CSUM));
 	if (encap)
 		hdrlen = skb_inner_tcp_all_headers(skb);
 	else
-- 
2.51.0




