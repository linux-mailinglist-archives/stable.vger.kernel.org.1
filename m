Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2217BE011
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377222AbjJINhJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377224AbjJINhI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:37:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9739C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:37:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820A6C433C7;
        Mon,  9 Oct 2023 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858626;
        bh=uhoKFnioQEtFQ8XR7oRu9XEGXnq+MHuIErbqBRy7C3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjNVJq3XxRtPPYVxyyU3acg+VBCre5P3vSFe9whAXidGpKKmz4agRFibGgcd7iCeD
         aZOoceIf8N8ROcMLlBVxgX62BjfLCmkipWvhQKKUQoU+SYVy5CnNxJS5YIyw2glDV3
         DoJ8R30CLxWhw2R7u2YjKIYmD4/NquG58rMTlaUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jian Shen <shenjian15@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 049/226] net: hns3: only enable unicast promisc when mac table full
Date:   Mon,  9 Oct 2023 15:00:10 +0200
Message-ID: <20231009130128.074177509@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 47f8f66cf7ecd..49eeeb0c9a1f8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7850,7 +7850,7 @@ static void hclge_update_overflow_flags(struct hclge_vport *vport,
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



