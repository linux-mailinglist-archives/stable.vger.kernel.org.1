Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E279B091
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377488AbjIKW0g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbjIKPAz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E101B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A637C433C8;
        Mon, 11 Sep 2023 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444450;
        bh=d+2GW8Kb9yTcyq9WX77BQ0LcWDUzYv0eOsL46arI6WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jl7gx7+LrhmAohhyLPuVYZxvj6awnaGHk4Pv0g2ZEsrcv0vVgRmWyx9U1PFowbJ2L
         d0D8xAS4BjNAhR3DY9COsnjso6lzlTfQOO99rQ4HdbPCatZRVrKJEfRi2SBaN8GK/N
         HVCr83m26CFXOyovCTGWTEkM67qdZNRVuUuuXhgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 6.4 707/737] s390/dcssblk: fix kernel crash with list_add corruption
Date:   Mon, 11 Sep 2023 15:49:26 +0200
Message-ID: <20230911134710.268284302@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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


