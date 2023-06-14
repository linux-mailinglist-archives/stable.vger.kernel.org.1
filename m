Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54A726BC5
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjFGU2K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjFGU2F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50488212B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0194F6448C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136F7C433D2;
        Wed,  7 Jun 2023 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169661;
        bh=ZgdiypEPt9M4XPZg8uoKvG0ycjYi70CExDzRN4CGuDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8uu23sBSFfnQDF/qtm/F9VbAgXgoZBUzkp0CpL4G5SuiaQ5Uz0TyL4g/XcIE/4uc
         a60u7VCByfLGhQr/sAvTNl8bBCVFqZaGNLwt/xj30q7iNzO1pr818LdYvA50FQhtOC
         6w7ZE0+9dMUD1Nw0nkQRCVXcvuI7NZQx6ietoOfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hyunwoo Kim <imv4bel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 136/286] media: dvb-core: Fix use-after-free on race condition at dvb_frontend
Date:   Wed,  7 Jun 2023 22:13:55 +0200
Message-ID: <20230607200927.531074599@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f ]

If the device node of dvb_frontend is open() and the device is
disconnected, many kinds of UAFs may occur when calling close()
on the device node.

The root cause of this is that wake_up() for dvbdev->wait_queue
is implemented in the dvb_frontend_release() function, but
wait_event() is not implemented in the dvb_frontend_stop() function.

So, implement wait_event() function in dvb_frontend_stop() and
add 'remove_mutex' which prevents race condition for 'fe->exit'.

[mchehab: fix a couple of checkpatch warnings and some mistakes at the error handling logic]

Link: https://lore.kernel.org/linux-media/20221117045925.14297-2-imv4bel@gmail.com
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 53 ++++++++++++++++++++++-----
 include/media/dvb_frontend.h          |  6 ++-
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index cc0a789f09ae5..947b61959b2b8 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -809,15 +809,26 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
+	mutex_lock(&fe->remove_mutex);
+
 	if (fe->exit != DVB_FE_DEVICE_REMOVED)
 		fe->exit = DVB_FE_NORMAL_EXIT;
 	mb();
 
-	if (!fepriv->thread)
+	if (!fepriv->thread) {
+		mutex_unlock(&fe->remove_mutex);
 		return;
+	}
 
 	kthread_stop(fepriv->thread);
 
+	mutex_unlock(&fe->remove_mutex);
+
+	if (fepriv->dvbdev->users < -1) {
+		wait_event(fepriv->dvbdev->wait_queue,
+			   fepriv->dvbdev->users == -1);
+	}
+
 	sema_init(&fepriv->sem, 1);
 	fepriv->state = FESTATE_IDLE;
 
@@ -2761,9 +2772,13 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	struct dvb_adapter *adapter = fe->dvb;
 	int ret;
 
+	mutex_lock(&fe->remove_mutex);
+
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
-	if (fe->exit == DVB_FE_DEVICE_REMOVED)
-		return -ENODEV;
+	if (fe->exit == DVB_FE_DEVICE_REMOVED) {
+		ret = -ENODEV;
+		goto err_remove_mutex;
+	}
 
 	if (adapter->mfe_shared == 2) {
 		mutex_lock(&adapter->mfe_lock);
@@ -2771,7 +2786,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			if (adapter->mfe_dvbdev &&
 			    !adapter->mfe_dvbdev->writers) {
 				mutex_unlock(&adapter->mfe_lock);
-				return -EBUSY;
+				ret = -EBUSY;
+				goto err_remove_mutex;
 			}
 			adapter->mfe_dvbdev = dvbdev;
 		}
@@ -2794,8 +2810,10 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			while (mferetry-- && (mfedev->users != -1 ||
 					      mfepriv->thread)) {
 				if (msleep_interruptible(500)) {
-					if (signal_pending(current))
-						return -EINTR;
+					if (signal_pending(current)) {
+						ret = -EINTR;
+						goto err_remove_mutex;
+					}
 				}
 			}
 
@@ -2807,7 +2825,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 				if (mfedev->users != -1 ||
 				    mfepriv->thread) {
 					mutex_unlock(&adapter->mfe_lock);
-					return -EBUSY;
+					ret = -EBUSY;
+					goto err_remove_mutex;
 				}
 				adapter->mfe_dvbdev = dvbdev;
 			}
@@ -2866,6 +2885,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
+
+	mutex_unlock(&fe->remove_mutex);
 	return ret;
 
 err3:
@@ -2887,6 +2908,9 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 err0:
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
+
+err_remove_mutex:
+	mutex_unlock(&fe->remove_mutex);
 	return ret;
 }
 
@@ -2897,6 +2921,8 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int ret;
 
+	mutex_lock(&fe->remove_mutex);
+
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
@@ -2918,10 +2944,18 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 		}
 		mutex_unlock(&fe->dvb->mdev_lock);
 #endif
-		if (fe->exit != DVB_FE_NO_EXIT)
-			wake_up(&dvbdev->wait_queue);
 		if (fe->ops.ts_bus_ctrl)
 			fe->ops.ts_bus_ctrl(fe, 0);
+
+		if (fe->exit != DVB_FE_NO_EXIT) {
+			mutex_unlock(&fe->remove_mutex);
+			wake_up(&dvbdev->wait_queue);
+		} else {
+			mutex_unlock(&fe->remove_mutex);
+		}
+
+	} else {
+		mutex_unlock(&fe->remove_mutex);
 	}
 
 	dvb_frontend_put(fe);
@@ -3022,6 +3056,7 @@ int dvb_register_frontend(struct dvb_adapter *dvb,
 	fepriv = fe->frontend_priv;
 
 	kref_init(&fe->refcount);
+	mutex_init(&fe->remove_mutex);
 
 	/*
 	 * After initialization, there need to be two references: one
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index e7c44870f20de..367d5381217b5 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -686,7 +686,10 @@ struct dtv_frontend_properties {
  * @id:			Frontend ID
  * @exit:		Used to inform the DVB core that the frontend
  *			thread should exit (usually, means that the hardware
- *			got disconnected.
+ *			got disconnected).
+ * @remove_mutex:	mutex that avoids a race condition between a callback
+ *			called when the hardware is disconnected and the
+ *			file_operations of dvb_frontend.
  */
 
 struct dvb_frontend {
@@ -704,6 +707,7 @@ struct dvb_frontend {
 	int (*callback)(void *adapter_priv, int component, int cmd, int arg);
 	int id;
 	unsigned int exit;
+	struct mutex remove_mutex;
 };
 
 /**
-- 
2.39.2



