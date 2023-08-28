Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C197878AD4B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjH1KrC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjH1Kql (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C431132
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE1E60F9E
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41253C433C8;
        Mon, 28 Aug 2023 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219592;
        bh=RerUlKityUFnB/750i6fs3oLRsGKt7J4+gUS1mz9CFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCTDhK7VdYi+vkBoHkTiSmXAb/HpWuGTXG5p6Nwiwj4XGkdz8pyujjeTr+iFpVHnk
         SDlXVC9DcpMHhqT8kLPXRT/9RkYuqNyiuUYa40+fO5j+4BFUxbJYDqOtNBRdS3HuSM
         cUNZqEx4oL9SEPP1zlhv/K1OIdBq3GSZKVbrnp30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhu Wang <wangzhu9@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 83/89] scsi: core: raid_class: Remove raid_component_add()
Date:   Mon, 28 Aug 2023 12:14:24 +0200
Message-ID: <20230828101153.029949429@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhu Wang <wangzhu9@huawei.com>

commit 60c5fd2e8f3c42a5abc565ba9876ead1da5ad2b7 upstream.

The raid_component_add() function was added to the kernel tree via patch
"[SCSI] embryonic RAID class" (2005). Remove this function since it never
has had any callers in the Linux kernel. And also raid_component_release()
is only used in raid_component_add(), so it is also removed.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Link: https://lore.kernel.org/r/20230822015254.184270-1-wangzhu9@huawei.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Fixes: 04b5b5cb0136 ("scsi: core: Fix possible memory leak if device_add() fails")
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/raid_class.c  |   48 ---------------------------------------------
 include/linux/raid_class.h |    4 ---
 2 files changed, 52 deletions(-)

--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -209,54 +209,6 @@ raid_attr_ro_state(level);
 raid_attr_ro_fn(resync);
 raid_attr_ro_state_fn(state);
 
-static void raid_component_release(struct device *dev)
-{
-	struct raid_component *rc =
-		container_of(dev, struct raid_component, dev);
-	dev_printk(KERN_ERR, rc->dev.parent, "COMPONENT RELEASE\n");
-	put_device(rc->dev.parent);
-	kfree(rc);
-}
-
-int raid_component_add(struct raid_template *r,struct device *raid_dev,
-		       struct device *component_dev)
-{
-	struct device *cdev =
-		attribute_container_find_class_device(&r->raid_attrs.ac,
-						      raid_dev);
-	struct raid_component *rc;
-	struct raid_data *rd = dev_get_drvdata(cdev);
-	int err;
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&rc->node);
-	device_initialize(&rc->dev);
-	rc->dev.release = raid_component_release;
-	rc->dev.parent = get_device(component_dev);
-	rc->num = rd->component_count++;
-
-	dev_set_name(&rc->dev, "component-%d", rc->num);
-	list_add_tail(&rc->node, &rd->component_list);
-	rc->dev.class = &raid_class.class;
-	err = device_add(&rc->dev);
-	if (err)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	put_device(&rc->dev);
-	list_del(&rc->node);
-	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
-	return err;
-}
-EXPORT_SYMBOL(raid_component_add);
-
 struct raid_template *
 raid_class_attach(struct raid_function_template *ft)
 {
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -77,7 +77,3 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, s
 	
 struct raid_template *raid_class_attach(struct raid_function_template *);
 void raid_class_release(struct raid_template *);
-
-int __must_check raid_component_add(struct raid_template *, struct device *,
-				    struct device *);
-


