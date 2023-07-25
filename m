Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0745676143E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjGYLRf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjGYLRP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492CE1BD8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B36AC61691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B7FC433C8;
        Tue, 25 Jul 2023 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283833;
        bh=sLI5jFOQC5lhvYPsoEmpMEImX2r2RIbCFH9SYL7BVP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuyD4LYwFViQo6pKE6tWMRuiWbvJoHrFglDlEz/gVkiYXXG5m06kPKaGZWXI7MD6p
         BCfkPWNNOBIJihBJzscWOXCLrZQ+NFOAUyBrieoJsU++bdi1IAOy6B8uGVj3zBnDC1
         RqXgupaRsbM1HPSpn3XWO2Lz5HMwF/1mOfHhiMRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 138/509] RDMA/hns: Use refcount_t APIs for HEM
Date:   Tue, 25 Jul 2023 12:41:17 +0200
Message-ID: <20230725104600.070696211@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Weihang Li <liweihang@huawei.com>

[ Upstream commit 82eb481da64586ccd287b2b2c5a086202c65e7eb ]

refcount_t is better than integer for reference counting, it will WARN on
overflow/underflow and avoid use-after-free risks.

Link: https://lore.kernel.org/r/1621589395-2435-5-git-send-email-liweihang@huawei.com
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: cf5b608fb0e3 ("RDMA/hns: Fix hns_roce_table_get return value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 32 +++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hem.h |  4 +--
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index edc287a0a91a1..831e9476c6284 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -260,7 +260,6 @@ static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
 	if (!hem)
 		return NULL;
 
-	hem->refcount = 0;
 	INIT_LIST_HEAD(&hem->chunk_list);
 
 	order = get_order(hem_alloc_size);
@@ -607,7 +606,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 
 	mutex_lock(&table->mutex);
 	if (table->hem[index.buf]) {
-		++table->hem[index.buf]->refcount;
+		refcount_inc(&table->hem[index.buf]->refcount);
 		goto out;
 	}
 
@@ -626,7 +625,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	++table->hem[index.buf]->refcount;
+	refcount_set(&table->hem[index.buf]->refcount, 1);
 	goto out;
 
 err_alloc:
@@ -652,7 +651,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	mutex_lock(&table->mutex);
 
 	if (table->hem[i]) {
-		++table->hem[i]->refcount;
+		refcount_inc(&table->hem[i]->refcount);
 		goto out;
 	}
 
@@ -675,7 +674,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 		goto out;
 	}
 
-	++table->hem[i]->refcount;
+	refcount_set(&table->hem[i]->refcount, 1);
 out:
 	mutex_unlock(&table->mutex);
 	return ret;
@@ -742,11 +741,11 @@ static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 		return;
 	}
 
-	mutex_lock(&table->mutex);
-	if (check_refcount && (--table->hem[index.buf]->refcount > 0)) {
-		mutex_unlock(&table->mutex);
+	if (!check_refcount)
+		mutex_lock(&table->mutex);
+	else if (!refcount_dec_and_mutex_lock(&table->hem[index.buf]->refcount,
+					      &table->mutex))
 		return;
-	}
 
 	clear_mhop_hem(hr_dev, table, obj, &mhop, &index);
 	free_mhop_hem(hr_dev, table, &mhop, &index);
@@ -768,16 +767,15 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 	i = (obj & (table->num_obj - 1)) /
 	    (table->table_chunk_size / table->obj_size);
 
-	mutex_lock(&table->mutex);
+	if (!refcount_dec_and_mutex_lock(&table->hem[i]->refcount,
+					 &table->mutex))
+		return;
 
-	if (--table->hem[i]->refcount == 0) {
-		/* Clear HEM base address */
-		if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
-			dev_warn(dev, "Clear HEM base address failed.\n");
+	if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
+		dev_warn(dev, "failed to clear HEM base address.\n");
 
-		hns_roce_free_hem(hr_dev, table->hem[i]);
-		table->hem[i] = NULL;
-	}
+	hns_roce_free_hem(hr_dev, table->hem[i]);
+	table->hem[i] = NULL;
 
 	mutex_unlock(&table->mutex);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 112243d112c23..03d44e2efa473 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -87,8 +87,8 @@ struct hns_roce_hem_chunk {
 };
 
 struct hns_roce_hem {
-	struct list_head	 chunk_list;
-	int			 refcount;
+	struct list_head chunk_list;
+	refcount_t refcount;
 };
 
 struct hns_roce_hem_iter {
-- 
2.39.2



