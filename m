Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C66703398
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbjEOQjN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242830AbjEOQjD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1C40CD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A1A362853
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A91C433EF;
        Mon, 15 May 2023 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168740;
        bh=Gy57csLcaAWWB0mx0c3QjN/ePODeXw2Bu4FNBHPqwyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpmT6UadFswcPgvDfH0SqTrQQo30US2/M/YinEfnuYu8wbyI/83y9X4f4SXRUBjoT
         r8LkMLPKif3ku0f15vTFbFruf1SiTyU1UOLy5vk8Zv7EecVLljqum/DWCRlM1+KuUo
         Q/jBAK3PLPZmj/wh4Lc9WVrSUVMeU6FkTfmPhvmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiping Ma <jiping.ma2@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Gou Hao <gouhao@uniontech.com>
Subject: [PATCH 4.19 006/191] stmmac: debugfs entry name is not be changed when udev rename device name.
Date:   Mon, 15 May 2023 18:24:03 +0200
Message-Id: <20230515161707.431008921@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Jiping Ma <jiping.ma2@windriver.com>

commit 481a7d154cbbd5ca355cc01cc8969876b240eded upstream.

Add one notifier for udev changes net device name.
Fixes: b6601323ef9e ("net: stmmac: debugfs entry name is not be changed when udev rename")

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Gou Hao <gouhao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -114,6 +114,7 @@ MODULE_PARM_DESC(chain_mode, "To use cha
 static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 
 #ifdef CONFIG_DEBUG_FS
+static const struct net_device_ops stmmac_netdev_ops;
 static int stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
@@ -4034,6 +4035,34 @@ static const struct file_operations stmm
 	.release = single_release,
 };
 
+/* Use network device events to rename debugfs file entries.
+ */
+static int stmmac_device_event(struct notifier_block *unused,
+			       unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	if (dev->netdev_ops != &stmmac_netdev_ops)
+		goto done;
+
+	switch (event) {
+	case NETDEV_CHANGENAME:
+		if (priv->dbgfs_dir)
+			priv->dbgfs_dir = debugfs_rename(stmmac_fs_dir,
+							 priv->dbgfs_dir,
+							 stmmac_fs_dir,
+							 dev->name);
+		break;
+	}
+done:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block stmmac_notifier = {
+	.notifier_call = stmmac_device_event,
+};
+
 static int stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4072,6 +4101,8 @@ static int stmmac_init_fs(struct net_dev
 		return -ENOMEM;
 	}
 
+	register_netdevice_notifier(&stmmac_notifier);
+
 	return 0;
 }
 
@@ -4079,6 +4110,7 @@ static void stmmac_exit_fs(struct net_de
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */


