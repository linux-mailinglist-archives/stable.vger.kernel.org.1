Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213CB703610
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbjEORFz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbjEORFT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324AA5F6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0D8620EE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5948C433EF;
        Mon, 15 May 2023 17:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170237;
        bh=eEBAiiBCgzU9U61iVTAMLTN1afYZd/1k+cLBowTbzak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2lesorBbN63/uq5V0+iyvwRhVkqi1Ufcod0+/YEwEoCDDOyGzZGMCsOnxdNfAeY9D
         vujA9jLhjUFJZtpQedOfb4ArKFLj0wuadiOBcfV4EGd1brMVELlTse55RTN5viQVBB
         W2uIjxlYBEemVe5nP3/KyVLTx3CRUj0fCmEnDLmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Sai Krishna <saikrishnag@marvell.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/239] octeontx2-pf: Increase the size of dmac filter flows
Date:   Mon, 15 May 2023 18:25:31 +0200
Message-Id: <20230515161723.735243019@linuxfoundation.org>
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

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit 2a6eecc592b4d59a04d513aa25fc0f30d52100cd ]

CN10kb supports large number of dmac filter flows to be
inserted. Increase the field size to accommodate the same

Fixes: b747923afff8 ("octeontx2-af: Exact match support")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 634ca4140346b..241016ca64d05 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -332,11 +332,11 @@ struct otx2_flow_config {
 #define OTX2_PER_VF_VLAN_FLOWS	2 /* Rx + Tx per VF */
 #define OTX2_VF_VLAN_RX_INDEX	0
 #define OTX2_VF_VLAN_TX_INDEX	1
-	u16			max_flows;
-	u8			dmacflt_max_flows;
 	u32			*bmap_to_dmacindex;
 	unsigned long		*dmacflt_bmap;
 	struct list_head	flow_list;
+	u32			dmacflt_max_flows;
+	u16                     max_flows;
 };
 
 struct otx2_tc_info {
-- 
2.39.2



