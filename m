Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A930D7E2534
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjKFN3V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjKFN3U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:29:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251A92
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:29:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81664C433C8;
        Mon,  6 Nov 2023 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277357;
        bh=3E4e3FXo5dRZ7yrlYedqOGjQLzeOpG9H48IwICFGMrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czODo1qD44CmtxCDANvjVgGVucQYG0rNA1pd6u9A2wvFHvK5Ec9H3iu44hVrPOkx0
         sUe1p9i1/edHGOLHFUz+/zh82Eh/NIPVMeS5m6YdaW4d6gDqslon75lKUKEA9nAYS5
         ittGXGvGU0aEs1IlDGrTYyZNe/hcmKbNTbCDSVCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Su Hui <suhui@nfschina.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 097/128] net: chelsio: cxgb4: add an error code check in t4_load_phy_fw
Date:   Mon,  6 Nov 2023 14:04:17 +0100
Message-ID: <20231106130313.573474414@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 9f771493da935299c6393ad3563b581255d01a37 ]

t4_set_params_timeout() can return -EINVAL if failed, add check
for this.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index b1c9f65ab10f6..c99f5920c957c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3816,6 +3816,8 @@ int t4_load_phy_fw(struct adapter *adap, int win,
 		 FW_PARAMS_PARAM_Z_V(FW_PARAMS_PARAM_DEV_PHYFW_DOWNLOAD));
 	ret = t4_set_params_timeout(adap, adap->mbox, adap->pf, 0, 1,
 				    &param, &val, 30000);
+	if (ret)
+		return ret;
 
 	/* If we have version number support, then check to see that the new
 	 * firmware got loaded properly.
-- 
2.42.0



