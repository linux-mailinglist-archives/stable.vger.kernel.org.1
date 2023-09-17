Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF177A3A0A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbjIQT54 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbjIQT5p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C59EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:57:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AC4C433C8;
        Sun, 17 Sep 2023 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980659;
        bh=xwEBM2F7ViCdlwYb/SdFxtF9OzLa8Kb7sm6ep900lHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qmog1rd/iKXGS2r/1k56EAoFvfukiMQFHusE4aquY0Iwha4CVVPeYuPYWi2oCPmTQ
         qIUXjWWb6udTYb3gJ5lH3tBlnNJY5u+u4Ta7IZxF4H+yonL7QEGBmYGmjkCaxfzZuN
         Nf3pJoIFggCnC5d9pj3SQbTuUX7+ajv1VjkAY9M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangyu Hua <hbh25y@gmail.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 256/285] net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()
Date:   Sun, 17 Sep 2023 21:14:16 +0200
Message-ID: <20230917191100.137185501@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 2d15342c260ae..7f0807672071f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2860,6 +2860,9 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
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



