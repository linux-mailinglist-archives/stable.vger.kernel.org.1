Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D66F6933
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 12:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjEDKkc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEDKka (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 06:40:30 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611A4EF3
        for <stable@vger.kernel.org>; Thu,  4 May 2023 03:40:19 -0700 (PDT)
X-QQ-mid: bizesmtp78t1683196781tqy6rw2g
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 May 2023 18:39:40 +0800 (CST)
X-QQ-SSF: 01400000000000C0G000000A0000000
X-QQ-FEAT: phdD4l/15n1/rShA7iIUCOkUSLnCG43e0eyKJSqa1zfu8EU298pJ9OkSzXDSc
        w4GOh27zPUO4zDpcaxEse+75zxBNcwqc3b33ldOp8N9jysW+oz5aWhfXH8nGS0foj/UHRtb
        WGwUMiUJuMvxTg0U3F2Q7KweP+9ZvxcM2lmBcgZV+MZwB7XgWI0u28uNmXpNh1fl5uENRXB
        aBlSGKkbNxh2F4xS7G3T9JQUzkRqTZtx6yqt4bp50ZrVktEk2sU2YfbJfTGqB+ZsvYYUbtf
        X3F56bI6xG+MR24OuMO9Ptq8unDyX2IGpu0HMN0gRlTUqxwfuz5lO1hnW134+iI1oD6X2U+
        Wgw2KVT7yq6USgSxsxJ2H8/T0GV7Fo28RDwNHY1RAj7EItc6jf/5RqsHfZd3Y5qHrLQ9tsb
        0ap7P1fiM2g=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 244953449734146993
From:   gouhao@uniontech.com
To:     stable@vger.kernel.org
Cc:     jiping.ma2@windriver.com, davem@davemloft.net
Subject: [PATCH 4.19] stmmac: debugfs entry name is not be changed when udev rename device name.
Date:   Thu,  4 May 2023 18:39:37 +0800
Message-Id: <20230504103937.12687-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiping Ma <jiping.ma2@windriver.com>

commit 481a7d154cbbd5ca355cc01cc8969876b240eded upstream.

Add one notifier for udev changes net device name.

Fixes: 466c5ac8bdf2 ("net: stmmac: create one debugfs dir per net-device")
Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0a4d093adfc9..3e35cdf0d2b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -114,6 +114,7 @@ MODULE_PARM_DESC(chain_mode, "To use chain instead of ring mode");
 static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 
 #ifdef CONFIG_DEBUG_FS
+static const struct net_device_ops stmmac_netdev_ops;
 static int stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
@@ -4034,6 +4035,34 @@ static const struct file_operations stmmac_dma_cap_fops = {
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
@@ -4072,6 +4101,8 @@ static int stmmac_init_fs(struct net_device *dev)
 		return -ENOMEM;
 	}
 
+	register_netdevice_notifier(&stmmac_notifier);
+
 	return 0;
 }
 
@@ -4079,6 +4110,7 @@ static void stmmac_exit_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */
-- 
2.20.1

