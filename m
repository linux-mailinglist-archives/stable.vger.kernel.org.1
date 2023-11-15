Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A5B7ED0F3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbjKOT6e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbjKOT6d (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D2A194
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFEEC433C8;
        Wed, 15 Nov 2023 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078309;
        bh=bwnvWftxlIbnUs81YLrFahmfJMPhdiyYrWuaxqnFQrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMI1fS1RtAou5F1+CLv2yB+mMsh5AcfbmLL7i2b5Cq5tFik+aRLb3fx6jck1muiGC
         9PlloYin/bQ1+uiv++oIDRyI5xhneHkKZ7umYIGqAl4epQ40n6qYvTT8C9G0VMPQ+Q
         7UE2kMjC/jlKPgqYw2g8KEc+aAsTcKR7/Y09qxSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 219/379] RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
Date:   Wed, 15 Nov 2023 14:24:54 -0500
Message-ID: <20231115192658.075980176@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit c64e9710f9241e38a1c761ed1c1a30854784da66 ]

ucmd in hns_roce_create_qp_common() are not initialized. But it works fine
until new member sdb_addr is added to struct hns_roce_ib_create_qp.

If the user-mode driver uses an old version ABI, then the value of the new
member will be undefined after ib_copy_from_udata().

This patch fixes it by initialize this variable to 0. And the default value
of the new member sdb_addr will be 0 which is invalid.

Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20231017125239.164455-3-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7a95f8677a02c..7b79e6b3f3baa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1128,7 +1128,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_ib_create_qp ucmd;
+	struct hns_roce_ib_create_qp ucmd = {};
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
-- 
2.42.0



