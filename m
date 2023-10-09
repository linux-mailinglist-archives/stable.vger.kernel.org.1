Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10927BE014
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377220AbjJINhM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377226AbjJINhL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:37:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628BAD8
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:37:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A095CC433C8;
        Mon,  9 Oct 2023 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858630;
        bh=2B9DLv2Yw/5yPgL4kk7t1f184MH2owlXaeM1RgZDna4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16RNxZyzTHb+v+0t96TzEgcbJTuYKTKKyB8q+Sf3tXSKbKGUbC2BcaudUQslaqTIs
         4T/24mraLqfmXvcSGkEX+zZTB5wG3U+BY+3cyQR+oCXlFgbjdrpDzdB1cK0zGaX1HK
         yBiR4ZOegHBoc6XnLnHrX13KfC/+99jd/1T52WJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jie Wang <wangjie125@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/226] net: hns3: add 5ms delay before clear firmware reset irq source
Date:   Mon,  9 Oct 2023 15:00:11 +0200
Message-ID: <20231009130128.099037297@linuxfoundation.org>
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

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit 0770063096d5da4a8e467b6e73c1646a75589628 ]

Currently the reset process in hns3 and firmware watchdog init process is
asynchronous. we think firmware watchdog initialization is completed
before hns3 clear the firmware interrupt source. However, firmware
initialization may not complete early.

so we add delay before hns3 clear firmware interrupt source and 5 ms delay
is enough to avoid second firmware reset interrupt.

Fixes: c1a81619d73a ("net: hns3: Add mailbox interrupt handling to PF driver")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 49eeeb0c9a1f8..deba485ced1bd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3125,8 +3125,13 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 static void hclge_clear_event_cause(struct hclge_dev *hdev, u32 event_type,
 				    u32 regclr)
 {
+#define HCLGE_IMP_RESET_DELAY		5
+
 	switch (event_type) {
 	case HCLGE_VECTOR0_EVENT_RST:
+		if (regclr == BIT(HCLGE_VECTOR0_IMPRESET_INT_B))
+			mdelay(HCLGE_IMP_RESET_DELAY);
+
 		hclge_write_dev(&hdev->hw, HCLGE_MISC_RESET_STS_REG, regclr);
 		break;
 	case HCLGE_VECTOR0_EVENT_MBX:
-- 
2.40.1



