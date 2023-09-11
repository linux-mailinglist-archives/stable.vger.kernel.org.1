Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21579C0D1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353967AbjIKVvs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbjIKO1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:27:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE89F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:27:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC8C433C9;
        Mon, 11 Sep 2023 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442436;
        bh=iOFxcw4MFz2SrrmS3mg80kL38IkTocbmSWZcUIAsluc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nb3E87zfSF5M5QHDlUN+c4nc9FBMFI71gAB0iSlVofb0/4T7bbeQPnGOw+xAGEv0J
         QVUCT5qrlkhdvE3KeSnrmC02OPtFsA/CUdm4K2V6stsekv0A3owzY83TtJ5YKNsE3O
         fpLFLoQRs9pTkCRJDq8mmY+h8RRqNu1EqC9SsoBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nikolay Burykin <burikin@ivk.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 008/737] media: pci: cx23885: fix error handling for cx23885 ATSC boards
Date:   Mon, 11 Sep 2023 15:37:47 +0200
Message-ID: <20230911134650.547446437@linuxfoundation.org>
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

From: Nikolay Burykin <burikin@ivk.ru>

[ Upstream commit 4aaa96b59df5fac41ba891969df6b092061ea9d7 ]

After having been assigned to NULL value at cx23885-dvb.c:1202,
pointer '0' is dereferenced at cx23885-dvb.c:2469.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Nikolay Burykin <burikin@ivk.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-dvb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index 8fd5b6ef24282..7551ca4a322a4 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -2459,16 +2459,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
@@ -2505,16 +2499,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
-- 
2.40.1



