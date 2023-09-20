Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA437A7E8B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjITMSq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjITMSp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256BCB6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:18:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CEEC433C8;
        Wed, 20 Sep 2023 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212317;
        bh=36qHRyHyPyA5GaI6rgOr/7q7kaoqLCnykXSZxNKTRD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcLmpD7fDtcurABq1lSCUrIn6Hd1HHNxuCSrRtZiMUh4v4G108iDlwr7LGC+RYhLD
         rdA5IBF95KuYsFBwlZg3EreyGKMvDhB0AqB69lHIDd1r61E6rFE2Qp1PWicA27yZqH
         kQY4PnD0rOzTnxroZ508DWxpw7EUNMUEy24kxdjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangyu Hua <hbh25y@gmail.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 231/273] net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()
Date:   Wed, 20 Sep 2023 13:31:11 +0200
Message-ID: <20230920112853.519764627@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit e4c79810755f66c9a933ca810da2724133b1165a ]

rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
rule_cnt from user space. So rule_cnt needs to be check before using
rule_locs to avoid NULL pointer dereference.

Fixes: 7aab747e5563 ("net: ethernet: mediatek: add ethtool functions to configure RX flows of HW LRO")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53cff913abf0b..1a4f96894cd70 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1621,6 +1621,9 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
 	int i;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (cnt == cmd->rule_cnt)
+			return -EMSGSIZE;
+
 		if (mac->hwlro_ip[i]) {
 			rule_locs[cnt] = i;
 			cnt++;
-- 
2.40.1



