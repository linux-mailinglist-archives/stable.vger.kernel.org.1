Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FDA755602
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjGPUqu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjGPUqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06393E54
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B414C60EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16A2C433C8;
        Sun, 16 Jul 2023 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540400;
        bh=U7ZsPrUblNl0UJ+Qxq3gGSSoqYDcKQ1i1Y7w+DrSTMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3hYsZsLsWapnDE2WeQqsjjOJ4phCQbAJjLRaCV0NBMrq+GQYGLQclxRosLdcPNtQ
         Suug529+slKie+PAtyf+wFUF0E2z0F1Vkmkpma5ojdGlOeDTAqwQRpue8ip+VzFmhS
         FmnBgtgOpCRxxtq1FZGlUyTbQq9p9OPF4D6Ea7AM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 350/591] dax: Fix dax_mapping_release() use after free
Date:   Sun, 16 Jul 2023 21:48:09 +0200
Message-ID: <20230716194932.966169208@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 6d24b170a9db0456f577b1ab01226a2254c016a8 ]

A CONFIG_DEBUG_KOBJECT_RELEASE test of removing a device-dax region
provider (like modprobe -r dax_hmem) yields:

 kobject: 'mapping0' (ffff93eb460e8800): kobject_release, parent 0000000000000000 (delayed 2000)
 [..]
 DEBUG_LOCKS_WARN_ON(1)
 WARNING: CPU: 23 PID: 282 at kernel/locking/lockdep.c:232 __lock_acquire+0x9fc/0x2260
 [..]
 RIP: 0010:__lock_acquire+0x9fc/0x2260
 [..]
 Call Trace:
  <TASK>
 [..]
  lock_acquire+0xd4/0x2c0
  ? ida_free+0x62/0x130
  _raw_spin_lock_irqsave+0x47/0x70
  ? ida_free+0x62/0x130
  ida_free+0x62/0x130
  dax_mapping_release+0x1f/0x30
  device_release+0x36/0x90
  kobject_delayed_cleanup+0x46/0x150

Due to attempting ida_free() on an ida object that has already been
freed. Devices typically only hold a reference on their parent while
registered. If a child needs a parent object to complete its release it
needs to hold a reference that it drops from its release callback.
Arrange for a dax_mapping to pin its parent dev_dax instance until
dax_mapping_release().

Fixes: 0b07ce872a9e ("device-dax: introduce 'mapping' devices")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/168577283412.1672036.16111545266174261446.stgit@dwillia2-xfh.jf.intel.com
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dax/bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index c64e7076537cb..d7a838f651813 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -621,10 +621,12 @@ EXPORT_SYMBOL_GPL(alloc_dax_region);
 static void dax_mapping_release(struct device *dev)
 {
 	struct dax_mapping *mapping = to_dax_mapping(dev);
-	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
+	struct device *parent = dev->parent;
+	struct dev_dax *dev_dax = to_dev_dax(parent);
 
 	ida_free(&dev_dax->ida, mapping->id);
 	kfree(mapping);
+	put_device(parent);
 }
 
 static void unregister_dax_mapping(void *data)
@@ -764,6 +766,7 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	dev = &mapping->dev;
 	device_initialize(dev);
 	dev->parent = &dev_dax->dev;
+	get_device(dev->parent);
 	dev->type = &dax_mapping_type;
 	dev_set_name(dev, "mapping%d", mapping->id);
 	rc = device_add(dev);
-- 
2.39.2



