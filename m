Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25EE7BDFAF
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377118AbjJINcm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjJINcl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A729D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:32:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF2AC433C7;
        Mon,  9 Oct 2023 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858359;
        bh=6ao3GmEuYxtorJnpR35ZYkqcmq/qoFveU67ae0AORl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCdqi7zdsXivyDy2UtiaeHzPfMl9ty5zKnLVqx718CU987r5TZYqkNUmKjJpOXSvG
         APMbHJdnfTs6m5jqDCk1IRz/gim3glnsPMk7RGX40xZxGEMr1S7pm/i7ebuQPrnL8J
         8ypp8+UAik+57Z2h+JUCMWKjXV2TgShiHisleP1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Hao <yhao016@ucr.edu>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 097/131] ubi: Refuse attaching if mtds erasesize is 0
Date:   Mon,  9 Oct 2023 15:02:17 +0200
Message-ID: <20231009130119.377313813@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit 017c73a34a661a861712f7cc1393a123e5b2208c ]

There exists mtd devices with zero erasesize, which will trigger a
divide-by-zero exception while attaching ubi device.
Fix it by refusing attaching if mtd's erasesize is 0.

Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
Reported-by: Yu Hao <yhao016@ucr.edu>
Link: https://lore.kernel.org/lkml/977347543.226888.1682011999468.JavaMail.zimbra@nod.at/T/
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/build.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index f29ed9102ce91..a7169b0d5ba65 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -865,6 +865,13 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 		return -EINVAL;
 	}
 
+	/* UBI cannot work on flashes with zero erasesize. */
+	if (!mtd->erasesize) {
+		pr_err("ubi: refuse attaching mtd%d - zero erasesize flash is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
-- 
2.40.1



