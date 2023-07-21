Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9000175D380
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjGUTL0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGUTLZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BF30E2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B418D61D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52DFC433C7;
        Fri, 21 Jul 2023 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966683;
        bh=BYzRZsnPw4y4/aXoMMYbnsSFm3LcPKoc1zgXW/qJzB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyBYwdbBHcPvvjMtfNQQbuhfGEuEvdqzydmQLJXuwHazFLC74vlnkQz/rZaL2fZK0
         z/0czKjHaOXddUX3iUVh4HE8JbpGsXVxB/fZU9uMp7ridfhKi0GidU7syprPUIKIqB
         XqBzuny/mzCnfXpFzHkjH0/eyuDfJLkMV5a/uyTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suman Ghosh <sumang@marvell.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 430/532] octeontx2-pf: Add additional check for MCAM rules
Date:   Fri, 21 Jul 2023 18:05:34 +0200
Message-ID: <20230721160637.895570421@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 8278ee2a2646b9acf747317895e47a640ba933c9 ]

Due to hardware limitation, MCAM drop rule with
ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
such rules.

Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Link: https://lore.kernel.org/r/20230710103027.2244139-1-sumang@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c   |  8 ++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c  | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 63889449b8f61..483f660cebc40 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -827,6 +827,14 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 				return -EINVAL;
 
 			vlan_etype = be16_to_cpu(fsp->h_ext.vlan_etype);
+
+			/* Drop rule with vlan_etype == 802.1Q
+			 * and vlan_id == 0 is not supported
+			 */
+			if (vlan_etype == ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
+			    fsp->ring_cookie == RX_CLS_FLOW_DISC)
+				return -EINVAL;
+
 			/* Only ETH_P_8021Q and ETH_P_802AD types supported */
 			if (vlan_etype != ETH_P_8021Q &&
 			    vlan_etype != ETH_P_8021AD)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index a42373e6f2593..26231c59b0241 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -536,6 +536,21 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 			return -EOPNOTSUPP;
 		}
 
+		if (!match.mask->vlan_id) {
+			struct flow_action_entry *act;
+			int i;
+
+			flow_action_for_each(i, act, &rule->action) {
+				if (act->id == FLOW_ACTION_DROP) {
+					netdev_err(nic->netdev,
+						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
+						   ntohs(match.key->vlan_tpid),
+						   match.key->vlan_id);
+					return -EOPNOTSUPP;
+				}
+			}
+		}
+
 		if (match.mask->vlan_id ||
 		    match.mask->vlan_dei ||
 		    match.mask->vlan_priority) {
-- 
2.39.2



