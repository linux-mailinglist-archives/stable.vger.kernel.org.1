Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305947B897F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbjJDS0y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244332AbjJDS0k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:26:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34556AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:26:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA70C433C8;
        Wed,  4 Oct 2023 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443995;
        bh=bhmraMFqXX9tESr8MfhVI4elhszbcmciMWEEVAylW7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/ahZFA7QmuTx0DqjwY1UL6pwMfvAHySR/LyNkQm3YxNqUROl4SgJYindrxlJFXKt
         7lbhiA+JS0X87feLvJXcm3nM/I6hVEYivivokoT1L5kNHhKlJsiwF5u45Oy7sb6pVZ
         WuZzzXwuvU/B98KfE8cW7Sj8ZnF8mxfBv9jT9qnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 094/321] net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check hwdev
Date:   Wed,  4 Oct 2023 19:53:59 +0200
Message-ID: <20231004175233.571341547@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

From: Cai Huoqing <cai.huoqing@linux.dev>

[ Upstream commit 22b6e7f3d6d51ff2716480f3d8f3098d90d69165 ]

'hwdev' is checked too late and hwdev will not be NULL, so remove the check

Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_port.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 9406237c461e0..f81a43d2cdfcd 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -456,9 +456,6 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 	u16 out_size = sizeof(vlan_filter);
 	int err;
 
-	if (!hwdev)
-		return -EINVAL;
-
 	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
 	vlan_filter.enable = en;
 
-- 
2.40.1



