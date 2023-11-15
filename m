Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451297ECF26
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjKOTqj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjKOTqi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6ADB8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ABBC433C8;
        Wed, 15 Nov 2023 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077595;
        bh=EXoTRkx94aLEa/RCY3nu+jX7Sf+vV8Rc9L5JrfMTW1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2+1omcELHxa7o4E2qb5HUgC7uxnnUkLU2IvM+J7DEpS7u3cS8yHsRW+NGOESlDSn
         bPaTMGma7zjHcR3EOkgxWpLXmD0T1qZ8apjqWbPPG295YaA6UiR3YGxDMhZBLYdUvf
         ySgH9hcYEfB9uYWBhv/5IWPX4p48oHZEeVvJ8AKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 378/603] RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
Date:   Wed, 15 Nov 2023 14:15:23 -0500
Message-ID: <20231115191639.560555560@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index cdc1c6de43a17..828b58534aa97 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1064,7 +1064,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_ib_create_qp ucmd;
+	struct hns_roce_ib_create_qp ucmd = {};
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
-- 
2.42.0



