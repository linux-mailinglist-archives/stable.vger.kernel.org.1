Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1A73E928
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjFZSdF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjFZSdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90C94
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D9160F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA08C433C0;
        Mon, 26 Jun 2023 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804380;
        bh=vgy54zVLHfKxQrPWgzf6k7yx1TAALDUu5NoFA/xkWhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0jNIkqFCm3rPXOIXY6cehutBQJLXBfjhDdJKQ+Yrj5mNFetmB9WPhiW4jMjN/+/K
         DXY1Ol6QdTQ/xNYkQnXxo7CcWUpnjVEm82EmDzUe/HYxiA+oByClICPwd8iV4yUngd
         4WHTUjRPQnEzGz3rOlflJ8Dawl6RkwGx20AmTLik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 136/170] media: cec: core: disable adapter in cec_devnode_unregister
Date:   Mon, 26 Jun 2023 20:11:45 +0200
Message-ID: <20230626180806.664533332@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit fe4526d99e2e06b08bb80316c3a596ea6a807b75 ]

Explicitly disable the CEC adapter in cec_devnode_unregister()

Usually this does not really do anything important, but for drivers
that use the CEC pin framework this is needed to properly stop the
hrtimer. Without this a crash would happen when such a driver is
unloaded with rmmod.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/core/cec-adap.c | 5 ++++-
 drivers/media/cec/core/cec-core.c | 2 ++
 drivers/media/cec/core/cec-priv.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 4f5ab3cae8a71..ac18707fddcd2 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1582,7 +1582,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
  *
  * This function is called with adap->lock held.
  */
-static int cec_adap_enable(struct cec_adapter *adap)
+int cec_adap_enable(struct cec_adapter *adap)
 {
 	bool enable;
 	int ret = 0;
@@ -1592,6 +1592,9 @@ static int cec_adap_enable(struct cec_adapter *adap)
 	if (adap->needs_hpd)
 		enable = enable && adap->phys_addr != CEC_PHYS_ADDR_INVALID;
 
+	if (adap->devnode.unregistered)
+		enable = false;
+
 	if (enable == adap->is_enabled)
 		return 0;
 
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index af358e901b5f3..7e153c5cad04f 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -191,6 +191,8 @@ static void cec_devnode_unregister(struct cec_adapter *adap)
 	mutex_lock(&adap->lock);
 	__cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false);
 	__cec_s_log_addrs(adap, NULL, false);
+	// Disable the adapter (since adap->devnode.unregistered is true)
+	cec_adap_enable(adap);
 	mutex_unlock(&adap->lock);
 
 	cdev_device_del(&devnode->cdev, &devnode->dev);
diff --git a/drivers/media/cec/core/cec-priv.h b/drivers/media/cec/core/cec-priv.h
index b78df931aa74b..ed1f8c67626bf 100644
--- a/drivers/media/cec/core/cec-priv.h
+++ b/drivers/media/cec/core/cec-priv.h
@@ -47,6 +47,7 @@ int cec_monitor_pin_cnt_inc(struct cec_adapter *adap);
 void cec_monitor_pin_cnt_dec(struct cec_adapter *adap);
 int cec_adap_status(struct seq_file *file, void *priv);
 int cec_thread_func(void *_adap);
+int cec_adap_enable(struct cec_adapter *adap);
 void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block);
 int __cec_s_log_addrs(struct cec_adapter *adap,
 		      struct cec_log_addrs *log_addrs, bool block);
-- 
2.39.2



