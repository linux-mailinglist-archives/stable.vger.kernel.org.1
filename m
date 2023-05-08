Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE65A6FABAB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjEHLQG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjEHLQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AE236CF3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3CE162BF5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ED8C4339B;
        Mon,  8 May 2023 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544564;
        bh=KYBPsMv6YoQYLw8l5kU9m+x0DiLVOu0azJ1u/99zPkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBMdM04mrzaQZBZoaA8inlytBz0C+kSHaK6kKvPVFVvf15UUfmERvREwNx0WdkIF+
         krVmkcZX9e1XFwepkNwESz9lw5hgk5sgCkssyjOcHg21MZZ6iHZ5USMrOJl1tmsnik
         BVwRkyg+4KTqw1rboBlSmMt6bXbKdZRnU0VE3SV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 420/694] md/raid10: fix memleak for conf->bio_split
Date:   Mon,  8 May 2023 11:44:15 +0200
Message-Id: <20230508094446.924596164@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit c9ac2acde53f5385de185bccf6aaa91cf9ac1541 ]

In the error path of raid10_run(), 'conf' need be freed, however,
'conf->bio_split' is missed and memory will be leaked.

Since there are 3 places to free 'conf', factor out a helper to fix the
problem.

Fixes: fc9977dd069e ("md/raid10: simplify the splitting of requests.")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230310073855.1337560-6-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b1c575859218a..5736ba5932c7f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4015,6 +4015,20 @@ static int setup_geo(struct geom *geo, struct mddev *mddev, enum geo_type new)
 	return nc*fc;
 }
 
+static void raid10_free_conf(struct r10conf *conf)
+{
+	if (!conf)
+		return;
+
+	mempool_exit(&conf->r10bio_pool);
+	kfree(conf->mirrors);
+	kfree(conf->mirrors_old);
+	kfree(conf->mirrors_new);
+	safe_put_page(conf->tmppage);
+	bioset_exit(&conf->bio_split);
+	kfree(conf);
+}
+
 static struct r10conf *setup_conf(struct mddev *mddev)
 {
 	struct r10conf *conf = NULL;
@@ -4097,13 +4111,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	return conf;
 
  out:
-	if (conf) {
-		mempool_exit(&conf->r10bio_pool);
-		kfree(conf->mirrors);
-		safe_put_page(conf->tmppage);
-		bioset_exit(&conf->bio_split);
-		kfree(conf);
-	}
+	raid10_free_conf(conf);
 	return ERR_PTR(err);
 }
 
@@ -4294,10 +4302,7 @@ static int raid10_run(struct mddev *mddev)
 
 out_free_conf:
 	md_unregister_thread(&mddev->thread);
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf);
+	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
 	return -EIO;
@@ -4305,15 +4310,7 @@ static int raid10_run(struct mddev *mddev)
 
 static void raid10_free(struct mddev *mddev, void *priv)
 {
-	struct r10conf *conf = priv;
-
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf->mirrors_old);
-	kfree(conf->mirrors_new);
-	bioset_exit(&conf->bio_split);
-	kfree(conf);
+	raid10_free_conf(priv);
 }
 
 static void raid10_quiesce(struct mddev *mddev, int quiesce)
-- 
2.39.2



