Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED3726EFE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjFGUym (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjFGUy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AE41FCC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 870DE647D1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993F2C433D2;
        Wed,  7 Jun 2023 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171262;
        bh=KBnscMsejoRYf6J9D5eLrZtkWwh27ql5DYTQZ+a1Hbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRmn+oD3+F+/h4z9OIfTEkUOw4EBB1sFH62krCfbb48BMvth+UZox5JttrQ1tUAM3
         Dh1HOadG98TdQzWdlC8/i5G8sx1hYhaxaBFa6VOaSMQzgOaqj9Ulk1KUlP3o2RGa96
         4ofUCvK4phrVDZu3EivmVltMfUnBJ4kKsRcB7INw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hyunwoo Kim <v4bel@theori.io>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 51/99] media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221
Date:   Wed,  7 Jun 2023 22:16:43 +0200
Message-ID: <20230607200901.846665193@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
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

From: Hyunwoo Kim <v4bel@theori.io>

[ Upstream commit 280a8ab81733da8bc442253c700a52c4c0886ffd ]

If the device node of dvb_ca_en50221 is open() and the
device is disconnected, a UAF may occur when calling
close() on the device node.

The root cause is that wake_up() and wait_event() for
dvbdev->wait_queue are not implemented.

So implement wait_event() function in dvb_ca_en50221_release()
and add 'remove_mutex' which prevents race condition
for 'ca->exit'.

[mchehab: fix a checkpatch warning]

Link: https://lore.kernel.org/linux-media/20221121063308.GA33821@ubuntu
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 37 ++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index b1a7b5f8b9aa4..dec036e0336cb 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -151,6 +151,12 @@ struct dvb_ca_private {
 
 	/* mutex serializing ioctls */
 	struct mutex ioctl_mutex;
+
+	/* A mutex used when a device is disconnected */
+	struct mutex remove_mutex;
+
+	/* Whether the device is disconnected */
+	int exit;
 };
 
 static void dvb_ca_private_free(struct dvb_ca_private *ca)
@@ -1708,12 +1714,22 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
 	dprintk("%s\n", __func__);
 
-	if (!try_module_get(ca->pub->owner))
+	mutex_lock(&ca->remove_mutex);
+
+	if (ca->exit) {
+		mutex_unlock(&ca->remove_mutex);
+		return -ENODEV;
+	}
+
+	if (!try_module_get(ca->pub->owner)) {
+		mutex_unlock(&ca->remove_mutex);
 		return -EIO;
+	}
 
 	err = dvb_generic_open(inode, file);
 	if (err < 0) {
 		module_put(ca->pub->owner);
+		mutex_unlock(&ca->remove_mutex);
 		return err;
 	}
 
@@ -1738,6 +1754,7 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
 	dvb_ca_private_get(ca);
 
+	mutex_unlock(&ca->remove_mutex);
 	return 0;
 }
 
@@ -1757,6 +1774,8 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
 	dprintk("%s\n", __func__);
 
+	mutex_lock(&ca->remove_mutex);
+
 	/* mark the CA device as closed */
 	ca->open = 0;
 	dvb_ca_en50221_thread_update_delay(ca);
@@ -1767,6 +1786,13 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
 	dvb_ca_private_put(ca);
 
+	if (dvbdev->users == 1 && ca->exit == 1) {
+		mutex_unlock(&ca->remove_mutex);
+		wake_up(&dvbdev->wait_queue);
+	} else {
+		mutex_unlock(&ca->remove_mutex);
+	}
+
 	return err;
 }
 
@@ -1890,6 +1916,7 @@ int dvb_ca_en50221_init(struct dvb_adapter *dvb_adapter,
 	}
 
 	mutex_init(&ca->ioctl_mutex);
+	mutex_init(&ca->remove_mutex);
 
 	if (signal_pending(current)) {
 		ret = -EINTR;
@@ -1932,6 +1959,14 @@ void dvb_ca_en50221_release(struct dvb_ca_en50221 *pubca)
 
 	dprintk("%s\n", __func__);
 
+	mutex_lock(&ca->remove_mutex);
+	ca->exit = 1;
+	mutex_unlock(&ca->remove_mutex);
+
+	if (ca->dvbdev->users < 1)
+		wait_event(ca->dvbdev->wait_queue,
+				ca->dvbdev->users == 1);
+
 	/* shutdown the thread if there was one */
 	kthread_stop(ca->thread);
 
-- 
2.39.2



