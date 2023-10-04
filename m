Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6877B882B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbjJDSNV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbjJDSNU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:13:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620BCC1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:13:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EEEC433C8;
        Wed,  4 Oct 2023 18:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443197;
        bh=KKaa0B9Sg+jP1C5zPoHdSm1SLVMAjycVd21VW+2J+EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TypeIzssE49cnb8USMf9FmhiCGPXslvwWEEt/ieIx3S8yYoge3bGjMg4jfs1ITDcj
         KYvZ3IAY9lHCN2sk7etUk03m04oTqUhbR4TEXiqqi51aYKVGYl1V+oD7LrBxb7xXwR
         O5ceN96kfhRGps1PEi63+JiePOAjAPqz/3sv8rYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jian Shen <shenjian15@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/259] net: hns3: only enable unicast promisc when mac table full
Date:   Wed,  4 Oct 2023 19:54:04 +0200
Message-ID: <20231004175220.664909129@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit f2ed304922a55690529bcca59678dd92d7466ce8 ]

Currently, the driver will enable unicast promisc for the function
once configure mac address fail. It's unreasonable when the failure
is caused by using same mac address with other functions. So only
enable unicast promisc when mac table full.

Fixes: c631c696823c ("net: hns3: refactor the promisc mode setting")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 884e45fb6b72e..a8019eac2b33e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -8930,7 +8930,7 @@ static void hclge_update_overflow_flags(struct hclge_vport *vport,
 	if (mac_type == HCLGE_MAC_ADDR_UC) {
 		if (is_all_added)
 			vport->overflow_promisc_flags &= ~HNAE3_OVERFLOW_UPE;
-		else
+		else if (hclge_is_umv_space_full(vport, true))
 			vport->overflow_promisc_flags |= HNAE3_OVERFLOW_UPE;
 	} else {
 		if (is_all_added)
-- 
2.40.1



