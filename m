Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E46726C98
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjFGUe7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjFGUeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A914FC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9C86454B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCF5C433D2;
        Wed,  7 Jun 2023 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170069;
        bh=GBeSLJIX8UIkYb9sZu6S8yqG1JK98fV0232YBA07j4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBTa4gR9mEyoJm4hlO46WKKDVDjnYdqnvTI6THMynhtGpZtpMQ2zpc9jrLiDl19ll
         1ozhuxB5XLQlU1yfVU+dMO1H5dnbZEat7+WvG2mVR8f4R+HSv0UIQHMeZHag77/aHK
         Y9Vl9ld4xWb7CK7l552yRDouit6O0dJtIa2kJPQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/88] nbd: Fix debugfs_create_dir error checking
Date:   Wed,  7 Jun 2023 22:15:51 +0200
Message-ID: <20230607200900.263302780@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit 4913cfcf014c95f0437db2df1734472fd3e15098 ]

The debugfs_create_dir function returns ERR_PTR in case of error, and the
only correct way to check if an error occurred is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Link: https://lore.kernel.org/r/20230512130533.98709-1-ivan.orlov0322@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cc66983e8b6ab..28024248a7b53 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1547,7 +1547,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1573,7 +1573,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
-- 
2.39.2



