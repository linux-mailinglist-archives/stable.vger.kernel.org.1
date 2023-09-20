Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25847A7ACB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjITLqK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjITLqJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D26DC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:46:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F12C433C8;
        Wed, 20 Sep 2023 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210363;
        bh=9IZ3/Nr5tYd9VV35L0TDLykVvoINU7h7/59Ueg1yX0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZvcFzy5A3oDmtkjbw8Kc8ejwgxdN9ZIUTctoVkdpR5sNgqb2v3lt0/zdWi2pvptt
         YnqtPEKeDdx9+Y++hmnIf2oeB44i+EmIQeiwSv1YLH9RwQW3brhcbWf6EQJymrNNDO
         C6rJBs6B9mFBix2QzU9CeiN74rcjc+YFoZIQXP0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, GONG@vger.kernel.org
Subject: [PATCH 6.5 049/211] alx: fix OOB-read compiler warning
Date:   Wed, 20 Sep 2023 13:28:13 +0200
Message-ID: <20230920112847.306521062@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: GONG, Ruiqi <gongruiqi1@huawei.com>

[ Upstream commit 3a198c95c95da10ad844cbeade2fe40bdf14c411 ]

The following message shows up when compiling with W=1:

In function ‘fortify_memcpy_chk’,
    inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to get alx stats altogether, alx_get_ethtool_stats() reads
beyond hw->stats.rx_ok. Fix this warning by directly copying hw->stats,
and refactor the unnecessarily complicated BUILD_BUG_ON btw.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230821013218.1614265-1-gongruiqi@huaweicloud.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/alx/ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index b716adacd8159..7f6b69a523676 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -292,9 +292,8 @@ static void alx_get_ethtool_stats(struct net_device *netdev,
 	spin_lock(&alx->stats_lock);
 
 	alx_update_hw_stats(hw);
-	BUILD_BUG_ON(sizeof(hw->stats) - offsetof(struct alx_hw_stats, rx_ok) <
-		     ALX_NUM_STATS * sizeof(u64));
-	memcpy(data, &hw->stats.rx_ok, ALX_NUM_STATS * sizeof(u64));
+	BUILD_BUG_ON(sizeof(hw->stats) != ALX_NUM_STATS * sizeof(u64));
+	memcpy(data, &hw->stats, sizeof(hw->stats));
 
 	spin_unlock(&alx->stats_lock);
 }
-- 
2.40.1



