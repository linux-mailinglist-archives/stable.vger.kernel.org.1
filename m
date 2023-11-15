Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480237ECFA7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjKOTtx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjKOTtw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166ED1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CDC433C8;
        Wed, 15 Nov 2023 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077788;
        bh=UHfJF4R+soAri8DckuaXXUclWKCRpAbNHB67MA10oP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyeNRc3T8UXtWa3EfverS/9lZsZeAtOkLCcXpRKHdRS/G4URBg7ZmWeVnUq8bNx5i
         sycG+QS6XAvfkiqxaKKC/b+hZ2iBbcck7D1x+tvDmQhrobSr75rIDYw4KeFA+BrskK
         dArDAXygnlI2v0UrkAabfeW+ZfR7uzoy5F1AFDFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 489/603] cxl/pci: Cleanup sanitize to always poll
Date:   Wed, 15 Nov 2023 14:17:14 -0500
Message-ID: <20231115191646.177421703@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit e30a106558e7d1e06d1fcfd12466dc646673d03d ]

In preparation for fixing the init/teardown of the 'sanitize' workqueue
and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
to be the single location where the sysfs attribute is notified. With
that change there is no distinction between polled mode and interrupt
mode. All the interrupt does is accelerate the polling interval.

The change to check for "mds->security.sanitize_node" under the lock is
there to ensure that the interrupt, the work routine and the
setup/teardown code can all have a consistent view of the registered
notifier and the workqueue state. I.e. the expectation is that the
interrupt is live past the point that the sanitize sysfs attribute is
published, and it may race teardown, so it must be consulted under a
lock. Given that new locking requirement, cxl_pci_mbox_irq() is moved
from hard to thread irq context.

Lastly, some opportunistic replacements of
"queue_delayed_work(system_wq, ...)", which is just open coded
schedule_delayed_work(), are included.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Stable-dep-of: 5f2da1971446 ("cxl/pci: Fix sanitize notifier setup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/memdev.c |  3 +-
 drivers/cxl/cxlmem.h      |  2 --
 drivers/cxl/pci.c         | 60 ++++++++++++++++-----------------------
 3 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f547..2a7a07f6d1652 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -561,8 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (mds->security.poll)
-		cancel_delayed_work_sync(&mds->security.poll_dwork);
+	cancel_delayed_work_sync(&mds->security.poll_dwork);
 }
 
 static void cxl_memdev_shutdown(struct device *dev)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef43..55f00ad17a772 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -360,7 +360,6 @@ struct cxl_fw_state {
  *
  * @state: state of last security operation
  * @enabled_cmds: All security commands enabled in the CEL
- * @poll: polling for sanitization is enabled, device has no mbox irq support
  * @poll_tmo_secs: polling timeout
  * @poll_dwork: polling work item
  * @sanitize_node: sanitation sysfs file to notify
@@ -368,7 +367,6 @@ struct cxl_fw_state {
 struct cxl_security_state {
 	unsigned long state;
 	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
-	bool poll;
 	int poll_tmo_secs;
 	struct delayed_work poll_dwork;
 	struct kernfs_node *sanitize_node;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index aa1b3dd9e64c4..49d9b2ef5c5c0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -128,10 +128,10 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		mutex_lock(&mds->mbox_mutex);
 		if (mds->security.sanitize_node)
-			sysfs_notify_dirent(mds->security.sanitize_node);
-
-		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
+			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
+		mutex_unlock(&mds->mbox_mutex);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
 		rcuwait_wake_up(&mds->mbox_wait);
@@ -160,8 +160,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		int timeout = mds->security.poll_tmo_secs + 10;
 
 		mds->security.poll_tmo_secs = min(15 * 60, timeout);
-		queue_delayed_work(system_wq, &mds->security.poll_dwork,
-				   timeout * HZ);
+		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
 	}
 	mutex_unlock(&mds->mbox_mutex);
 }
@@ -293,15 +292,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		 * and allow userspace to poll(2) for completion.
 		 */
 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-			if (mds->security.poll) {
-				/* give first timeout a second */
-				timeout = 1;
-				mds->security.poll_tmo_secs = timeout;
-				queue_delayed_work(system_wq,
-						   &mds->security.poll_dwork,
-						   timeout * HZ);
-			}
-
+			/* give first timeout a second */
+			timeout = 1;
+			mds->security.poll_tmo_secs = timeout;
+			schedule_delayed_work(&mds->security.poll_dwork,
+					      timeout * HZ);
 			dev_dbg(dev, "Sanitization operation started\n");
 			goto success;
 		}
@@ -384,7 +379,9 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 	struct device *dev = cxlds->dev;
 	unsigned long timeout;
+	int irq, msgnum;
 	u64 md_status;
+	u32 ctrl;
 
 	timeout = jiffies + mbox_ready_timeout * HZ;
 	do {
@@ -432,33 +429,26 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
 
 	rcuwait_init(&mds->mbox_wait);
+	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
 
-	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
-		u32 ctrl;
-		int irq, msgnum;
-		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-
-		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
-		irq = pci_irq_vector(pdev, msgnum);
-		if (irq < 0)
-			goto mbox_poll;
-
-		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
-			goto mbox_poll;
+	/* background command interrupts are optional */
+	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
+		return 0;
 
-		/* enable background command mbox irq support */
-		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
-		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
-		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
+	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
+	if (irq < 0)
+		return 0;
 
+	if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
 		return 0;
-	}
 
-mbox_poll:
-	mds->security.poll = true;
-	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
+	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
+	/* enable background command mbox irq support */
+	ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+	ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
+	writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
-	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
 
-- 
2.42.0



