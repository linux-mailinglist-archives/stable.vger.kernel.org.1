Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0079B806
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbjIKWfU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242376AbjIKP3U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:29:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F0AF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:29:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAE8C433AD;
        Mon, 11 Sep 2023 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446156;
        bh=nXJKOWuJivfRWmD0H9eRSd7N1UWemOTS2A0XJxgneoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2+twzHantcAGS2cBM/zCLJgP8GoV1495513MohkF8S3fPaQJ4m+J/rJckVt14zc/
         kcCmh3u1HENg5jzWz+PzUNFS0go+yqLJ8Do1ONAfgZ0RONGwoV7D/n0p+s/NegLyxp
         8tRF8rKZd8G3uN2echclaXv68Ya7My8JOLs49/jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 6.1 575/600] s390/dcssblk: fix kernel crash with list_add corruption
Date:   Mon, 11 Sep 2023 15:50:08 +0200
Message-ID: <20230911134650.590266644@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

commit c8f40a0bccefd613748d080147469a4652d6e74c upstream.

Commit fb08a1908cb1 ("dax: simplify the dax_device <-> gendisk
association") introduced new logic for gendisk association, requiring
drivers to explicitly call dax_add_host() and dax_remove_host().

For dcssblk driver, some dax_remove_host() calls were missing, e.g. in
device remove path. The commit also broke error handling for out_dax case
in device add path, resulting in an extra put_device() w/o the previous
get_device() in that case.

This lead to stale xarray entries after device add / remove cycles. In the
case when a previously used struct gendisk pointer (xarray index) would be
used again, because blk_alloc_disk() happened to return such a pointer, the
xa_insert() in dax_add_host() would fail and go to out_dax, doing the extra
put_device() in the error path. In combination with an already flawed error
handling in dcssblk (device_register() cleanup), which needs to be
addressed in a separate patch, this resulted in a missing device_del() /
klist_del(), and eventually in the kernel crash with list_add corruption on
a subsequent device_add() / klist_add().

Fix this by adding the missing dax_remove_host() calls, and also move the
put_device() in the error path to restore the previous logic.

Fixes: fb08a1908cb1 ("dax: simplify the dax_device <-> gendisk association")
Cc: <stable@vger.kernel.org> # 5.17+
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dcssblk.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -411,6 +411,7 @@ removeseg:
 	}
 	list_del(&dev_info->lh);
 
+	dax_remove_host(dev_info->gd);
 	kill_dax(dev_info->dax_dev);
 	put_dax(dev_info->dax_dev);
 	del_gendisk(dev_info->gd);
@@ -706,9 +707,9 @@ dcssblk_add_store(struct device *dev, st
 	goto out;
 
 out_dax_host:
+	put_device(&dev_info->dev);
 	dax_remove_host(dev_info->gd);
 out_dax:
-	put_device(&dev_info->dev);
 	kill_dax(dev_info->dax_dev);
 	put_dax(dev_info->dax_dev);
 put_dev:
@@ -788,6 +789,7 @@ dcssblk_remove_store(struct device *dev,
 	}
 
 	list_del(&dev_info->lh);
+	dax_remove_host(dev_info->gd);
 	kill_dax(dev_info->dax_dev);
 	put_dax(dev_info->dax_dev);
 	del_gendisk(dev_info->gd);


