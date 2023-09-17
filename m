Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F67A3B06
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbjIQULv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbjIQULk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:11:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56450103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:11:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F242C433C8;
        Sun, 17 Sep 2023 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981493;
        bh=IR3h7znMFYK4GmZryJN1k+y9fmJpuzCpOE+hWGQfqy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9lhKTXeZK9DLYrTYIyPg/bAj7KIrd7u5JUtbO58glekHhpXXnhis8lAT5Bo8dX8m
         i36ZQ91ppS4BwRi3hMzfZ89ToAo+rfYx4IPunO4lHgbGniUxEZRGhgUM/LWwNkvGk5
         vAYPMhtxr+4zTTX34aPzUdra3hiBSZZIGhVOm7Yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Chen <chenhao418@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 131/219] net: hns3: fix debugfs concurrency issue between kfree buffer and read
Date:   Sun, 17 Sep 2023 21:14:18 +0200
Message-ID: <20230917191045.720449941@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Chen <chenhao418@huawei.com>

[ Upstream commit c295160b1d95e885f1af4586a221cb221d232d10 ]

Now in hns3_dbg_uninit(), there may be concurrency between
kfree buffer and read, it may result in memory error.

Moving debugfs_remove_recursive() in front of kfree buffer to ensure
they don't happen at the same time.

Fixes: 5e69ea7ee2a6 ("net: hns3: refactor the debugfs process")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 69d1549e63a98..00eed9835cb55 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1406,9 +1406,9 @@ int hns3_dbg_init(struct hnae3_handle *handle)
 	return 0;
 
 out:
-	mutex_destroy(&handle->dbgfs_lock);
 	debugfs_remove_recursive(handle->hnae3_dbgfs);
 	handle->hnae3_dbgfs = NULL;
+	mutex_destroy(&handle->dbgfs_lock);
 	return ret;
 }
 
@@ -1416,6 +1416,9 @@ void hns3_dbg_uninit(struct hnae3_handle *handle)
 {
 	u32 i;
 
+	debugfs_remove_recursive(handle->hnae3_dbgfs);
+	handle->hnae3_dbgfs = NULL;
+
 	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd); i++)
 		if (handle->dbgfs_buf[i]) {
 			kvfree(handle->dbgfs_buf[i]);
@@ -1423,8 +1426,6 @@ void hns3_dbg_uninit(struct hnae3_handle *handle)
 		}
 
 	mutex_destroy(&handle->dbgfs_lock);
-	debugfs_remove_recursive(handle->hnae3_dbgfs);
-	handle->hnae3_dbgfs = NULL;
 }
 
 void hns3_dbg_register_debugfs(const char *debugfs_dir_name)
-- 
2.40.1



