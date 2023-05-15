Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B219703619
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbjEORGl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbjEORG0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453439000
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19203629FC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB27EC433D2;
        Mon, 15 May 2023 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170241;
        bh=kwoBhNKHQ7REzUdvtc6uUBn2PrJkb8zVnZU/IqC+a/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWVHVXluZKJ0cMceruJOEg7Ietix+ZI2s5nBRhDYKMyAfnrJWtbdkJZHi3/4aT0mZ
         VP1g5ijMx/YBIukLHtY7EZ6iN9l4NTOuQpt9bh2jg8EDCJC2G8aSUVcySS64hwx0fG
         kU9Oh/aruS1xQd1l2RQLw93mYLGS1XlyslfBsrGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suman Ghosh <sumang@marvell.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 069/239] octeontx2-af: Allow mkex profile without DMAC and add L2M/L2B header extraction support
Date:   Mon, 15 May 2023 18:25:32 +0200
Message-Id: <20230515161723.764102165@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 2cee6401c4eaa562abc1d437d5d03e80bbee79c1 ]

1. It is possible to have custom mkex profiles which do not extract
DMAC at all into the key. Hence allow mkex profiles which do not
have DMAC to be loaded into MCAM hardware. This patch also adds
debugging prints needed to identify profiles with wrong
configuration.

2. If a mkex profile set "l2l3mb" field for Rx interface,
then Rx multicast and broadcast entry should be configured.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Link: https://lore.kernel.org/r/20221031090856.1404303-1-sumang@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 406bed11fb91 ("octeontx2-af: Update/Fix NPC field hash extract feature")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  1 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  6 ++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 81 ++++++++++++++-----
 3 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index f187293e3e084..d027c23b8ef8e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -620,6 +620,7 @@ struct rvu_npc_mcam_rule {
 	bool vfvlan_cfg;
 	u16 chan;
 	u16 chan_mask;
+	u8 lxmb;
 };
 
 #endif /* NPC_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 0cab27448399c..aadc352c2ffbd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2759,6 +2759,12 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 	for_each_set_bit(bit, (unsigned long *)&rule->features, 64) {
 		seq_printf(s, "\t%s  ", npc_get_field_name(bit));
 		switch (bit) {
+		case NPC_LXMB:
+			if (rule->lxmb == 1)
+				seq_puts(s, "\tL2M nibble is set\n");
+			else
+				seq_puts(s, "\tL2B nibble is set\n");
+			break;
 		case NPC_DMAC:
 			seq_printf(s, "%pM ", rule->packet.dmac);
 			seq_printf(s, "mask %pM\n", rule->mask.dmac);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 67c85382eef62..282d85846647a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -43,6 +43,7 @@ static const char * const npc_flow_names[] = {
 	[NPC_DPORT_UDP]	= "udp destination port",
 	[NPC_SPORT_SCTP] = "sctp source port",
 	[NPC_DPORT_SCTP] = "sctp destination port",
+	[NPC_LXMB]	= "Mcast/Bcast header ",
 	[NPC_UNKNOWN]	= "unknown",
 };
 
@@ -340,8 +341,10 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	vlan_tag2 = &key_fields[NPC_VLAN_TAG2];
 
 	/* if key profile programmed does not extract Ethertype at all */
-	if (!etype_ether->nr_kws && !etype_tag1->nr_kws && !etype_tag2->nr_kws)
+	if (!etype_ether->nr_kws && !etype_tag1->nr_kws && !etype_tag2->nr_kws) {
+		dev_err(rvu->dev, "mkex: Ethertype is not extracted.\n");
 		goto vlan_tci;
+	}
 
 	/* if key profile programmed extracts Ethertype from one layer */
 	if (etype_ether->nr_kws && !etype_tag1->nr_kws && !etype_tag2->nr_kws)
@@ -354,35 +357,45 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	/* if key profile programmed extracts Ethertype from multiple layers */
 	if (etype_ether->nr_kws && etype_tag1->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (etype_ether->kw_mask[i] != etype_tag1->kw_mask[i])
+			if (etype_ether->kw_mask[i] != etype_tag1->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Etype pos is different for untagged and tagged pkts.\n");
 				goto vlan_tci;
+			}
 		}
 		key_fields[NPC_ETYPE] = *etype_tag1;
 	}
 	if (etype_ether->nr_kws && etype_tag2->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (etype_ether->kw_mask[i] != etype_tag2->kw_mask[i])
+			if (etype_ether->kw_mask[i] != etype_tag2->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Etype pos is different for untagged and double tagged pkts.\n");
 				goto vlan_tci;
+			}
 		}
 		key_fields[NPC_ETYPE] = *etype_tag2;
 	}
 	if (etype_tag1->nr_kws && etype_tag2->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (etype_tag1->kw_mask[i] != etype_tag2->kw_mask[i])
+			if (etype_tag1->kw_mask[i] != etype_tag2->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Etype pos is different for tagged and double tagged pkts.\n");
 				goto vlan_tci;
+			}
 		}
 		key_fields[NPC_ETYPE] = *etype_tag2;
 	}
 
 	/* check none of higher layers overwrite Ethertype */
 	start_lid = key_fields[NPC_ETYPE].layer_mdata.lid + 1;
-	if (npc_check_overlap(rvu, blkaddr, NPC_ETYPE, start_lid, intf))
+	if (npc_check_overlap(rvu, blkaddr, NPC_ETYPE, start_lid, intf)) {
+		dev_err(rvu->dev, "mkex: Ethertype is overwritten by higher layers.\n");
 		goto vlan_tci;
+	}
 	*features |= BIT_ULL(NPC_ETYPE);
 vlan_tci:
 	/* if key profile does not extract outer vlan tci at all */
-	if (!vlan_tag1->nr_kws && !vlan_tag2->nr_kws)
+	if (!vlan_tag1->nr_kws && !vlan_tag2->nr_kws) {
+		dev_err(rvu->dev, "mkex: Outer vlan tci is not extracted.\n");
 		goto done;
+	}
 
 	/* if key profile extracts outer vlan tci from one layer */
 	if (vlan_tag1->nr_kws && !vlan_tag2->nr_kws)
@@ -393,15 +406,19 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	/* if key profile extracts outer vlan tci from multiple layers */
 	if (vlan_tag1->nr_kws && vlan_tag2->nr_kws) {
 		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
-			if (vlan_tag1->kw_mask[i] != vlan_tag2->kw_mask[i])
+			if (vlan_tag1->kw_mask[i] != vlan_tag2->kw_mask[i]) {
+				dev_err(rvu->dev, "mkex: Out vlan tci pos is different for tagged and double tagged pkts.\n");
 				goto done;
+			}
 		}
 		key_fields[NPC_OUTER_VID] = *vlan_tag2;
 	}
 	/* check none of higher layers overwrite outer vlan tci */
 	start_lid = key_fields[NPC_OUTER_VID].layer_mdata.lid + 1;
-	if (npc_check_overlap(rvu, blkaddr, NPC_OUTER_VID, start_lid, intf))
+	if (npc_check_overlap(rvu, blkaddr, NPC_OUTER_VID, start_lid, intf)) {
+		dev_err(rvu->dev, "mkex: Outer vlan tci is overwritten by higher layers.\n");
 		goto done;
+	}
 	*features |= BIT_ULL(NPC_OUTER_VID);
 done:
 	return;
@@ -522,6 +539,10 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 	if (npc_check_field(rvu, blkaddr, NPC_LB, intf))
 		*features |= BIT_ULL(NPC_VLAN_ETYPE_CTAG) |
 			     BIT_ULL(NPC_VLAN_ETYPE_STAG);
+
+	/* for L2M/L2B/L3M/L3B, check if the type is present in the key */
+	if (npc_check_field(rvu, blkaddr, NPC_LXMB, intf))
+		*features |= BIT_ULL(NPC_LXMB);
 }
 
 /* Scan key extraction profile and record how fields of our interest
@@ -598,16 +619,6 @@ static int npc_scan_verify_kex(struct rvu *rvu, int blkaddr)
 		dev_err(rvu->dev, "Channel cannot be overwritten\n");
 		return -EINVAL;
 	}
-	/* DMAC should be present in key for unicast filter to work */
-	if (!npc_is_field_present(rvu, NPC_DMAC, NIX_INTF_RX)) {
-		dev_err(rvu->dev, "DMAC not present in Key\n");
-		return -EINVAL;
-	}
-	/* check that none of the fields overwrite DMAC */
-	if (npc_check_overlap(rvu, blkaddr, NPC_DMAC, 0, NIX_INTF_RX)) {
-		dev_err(rvu->dev, "DMAC cannot be overwritten\n");
-		return -EINVAL;
-	}
 
 	npc_set_features(rvu, blkaddr, NIX_INTF_TX);
 	npc_set_features(rvu, blkaddr, NIX_INTF_RX);
@@ -850,6 +861,11 @@ static void npc_update_flow(struct rvu *rvu, struct mcam_entry *entry,
 		npc_update_entry(rvu, NPC_LE, entry, NPC_LT_LE_ESP,
 				 0, ~0ULL, 0, intf);
 
+	if (features & BIT_ULL(NPC_LXMB)) {
+		output->lxmb = is_broadcast_ether_addr(pkt->dmac) ? 2 : 1;
+		npc_update_entry(rvu, NPC_LXMB, entry, output->lxmb, 0,
+				 output->lxmb, 0, intf);
+	}
 #define NPC_WRITE_FLOW(field, member, val_lo, val_hi, mask_lo, mask_hi)	      \
 do {									      \
 	if (features & BIT_ULL((field))) {				      \
@@ -1152,6 +1168,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	rule->chan_mask = write_req.entry_data.kw_mask[0] & NPC_KEX_CHAN_MASK;
 	rule->chan = write_req.entry_data.kw[0] & NPC_KEX_CHAN_MASK;
 	rule->chan &= rule->chan_mask;
+	rule->lxmb = dummy.lxmb;
 	if (is_npc_intf_tx(req->intf))
 		rule->intf = pfvf->nix_tx_intf;
 	else
@@ -1214,6 +1231,34 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	if (!is_npc_interface_valid(rvu, req->intf))
 		return NPC_FLOW_INTF_INVALID;
 
+	/* If DMAC is not extracted in MKEX, rules installed by AF
+	 * can rely on L2MB bit set by hardware protocol checker for
+	 * broadcast and multicast addresses.
+	 */
+	if (npc_check_field(rvu, blkaddr, NPC_DMAC, req->intf))
+		goto process_flow;
+
+	if (is_pffunc_af(req->hdr.pcifunc)) {
+		if (is_unicast_ether_addr(req->packet.dmac)) {
+			dev_err(rvu->dev,
+				"%s: mkex profile does not support ucast flow\n",
+				__func__);
+			return NPC_FLOW_NOT_SUPPORTED;
+		}
+
+		if (!npc_is_field_present(rvu, NPC_LXMB, req->intf)) {
+			dev_err(rvu->dev,
+				"%s: mkex profile does not support bcast/mcast flow",
+				__func__);
+			return NPC_FLOW_NOT_SUPPORTED;
+		}
+
+		/* Modify feature to use LXMB instead of DMAC */
+		req->features &= ~BIT_ULL(NPC_DMAC);
+		req->features |= BIT_ULL(NPC_LXMB);
+	}
+
+process_flow:
 	if (from_vf && req->default_rule)
 		return NPC_FLOW_VF_PERM_DENIED;
 
-- 
2.39.2



