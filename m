Return-Path: <stable+bounces-106983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25FA029AA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC8D1882215
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B11D88AC;
	Mon,  6 Jan 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2LtwrXQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA5146D40;
	Mon,  6 Jan 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177101; cv=none; b=GE2o3JXGyVxM5PgxM9qRpeHVmAKq+1tHQrTD5KVy1d2kvpmcu0fOH7GMwnUZlav5/zboJ50b1blXRggWlM0kWa2jUL6vv7408tnYiBFKD37cZXuaIylqnXCnR1a2X27fe0Zy0DyVduNE9eJ4EDx7eCgwXMgp0oKI4ivQxvpR6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177101; c=relaxed/simple;
	bh=ubTDnL+qtbYuhvMJt9kN2ADwoHGXKbKQwwPZwwIwZhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJIum8DlZz3WG38f66b4/wSjXjsGE/aqD7Avg6cJfBCt9UdyFUGX0hxKWpfgGn1belKHxXukKQwagCDF4KBjvQDMTZ4S9zMY79sGYdpfNkLnwQMMl1Q/ttLlggi3kbKAFb1uFa87XbwTBeTmHnFnoJ0DEc6d++1KN+130MonXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2LtwrXQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C9CC4CEDF;
	Mon,  6 Jan 2025 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177101;
	bh=ubTDnL+qtbYuhvMJt9kN2ADwoHGXKbKQwwPZwwIwZhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2LtwrXQLcYTfZhPSI+MZieevNNbZX82mdirOp7PbRq2OOjG6qy/+PfsqVmRRTHtIO
	 zvqX9fwslfjnXktWz9md8HbdJyHPt/aUyHikqRVr26UYp0JkQjUTy6/eiBp+aQz0nB
	 SB3e6bLaG6wVSeRE1/XqJ9Dkvp5x4tByL58a8CmA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huisong Li <lihuisong@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 050/222] mailbox: pcc: Support shared interrupt for multiple subspaces
Date: Mon,  6 Jan 2025 16:14:14 +0100
Message-ID: <20250106151152.499427129@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huisong Li <lihuisong@huawei.com>

[ Upstream commit 3db174e478cb0bb34888c20a531608b70aec9c1f ]

If the platform acknowledge interrupt is level triggered, then it can
be shared by multiple subspaces provided each one has a unique platform
interrupt ack preserve and ack set masks.

If it can be shared, then we can request the irq with IRQF_SHARED and
IRQF_ONESHOT flags. The first one indicating it can be shared and the
latter one to keep the interrupt disabled until the hardirq handler
finished.

Further, since there is no way to detect if the interrupt is for a given
channel as the interrupt ack preserve and ack set masks are for clearing
the interrupt and not for reading the status(in case Irq Ack register
may be write-only on some platforms), we need a way to identify if the
given channel is in use and expecting the interrupt.

PCC type0, type1 and type5 do not support shared level triggered interrupt.
The methods of determining whether a given channel for remaining types
should respond to an interrupt are as follows:
 - type2: Whether the interrupt belongs to a given channel is only
          determined by the status field in Generic Communications Channel
          Shared Memory Region, which is done in rx_callback of PCC client.
 - type3: This channel checks chan_in_use flag first and then checks the
          command complete bit(value '1' indicates that the command has
          been completed).
 - type4: Platform ensure that the default value of the command complete
          bit corresponding to the type4 channel is '1'. This command
          complete bit is '0' when receive a platform notification.

The new field, 'chan_in_use' is used by the type only support the
communication from OSPM to Platform (like type3) and should be completely
ignored by other types so as to avoid too many type unnecessary checks in
IRQ handler.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://lore.kernel.org/r/20230801063827.25336-3-lihuisong@huawei.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Stable-dep-of: 7f9e19f207be ("mailbox: pcc: Check before sending MCTP PCC response ACK")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 80310b48bfb6..94885e411085 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -92,6 +92,13 @@ struct pcc_chan_reg {
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
  * @type: PCC subspace type
+ * @plat_irq_flags: platform interrupt flags
+ * @chan_in_use: this flag is used just to check if the interrupt needs
+ *		handling when it is shared. Since only one transfer can occur
+ *		at a time and mailbox takes care of locking, this flag can be
+ *		accessed without a lock. Note: the type only support the
+ *		communication from OSPM to Platform, like type3, use it, and
+ *		other types completely ignore it.
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -102,6 +109,8 @@ struct pcc_chan_info {
 	struct pcc_chan_reg error;
 	int plat_irq;
 	u8 type;
+	unsigned int plat_irq_flags;
+	bool chan_in_use;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
@@ -225,6 +234,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
+{
+	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
+		ACPI_LEVEL_SENSITIVE;
+}
+
 static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 {
 	u64 val;
@@ -242,6 +257,7 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	 * command complete.
 	 */
 	val &= pchan->cmd_complete.status_mask;
+
 	/*
 	 * If this is PCC slave subspace channel, and the command complete
 	 * bit 0 indicates that Platform is sending a notification and OSPM
@@ -268,6 +284,10 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
+	    !pchan->chan_in_use)
+		return IRQ_NONE;
+
 	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
@@ -289,9 +309,12 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	/*
 	 * The PCC slave subspace channel needs to set the command complete bit
 	 * and ring doorbell after processing message.
+	 *
+	 * The PCC master subspace channel clears chan_in_use to free channel.
 	 */
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
 		pcc_send_data(chan, NULL);
+	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }
@@ -371,7 +394,11 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	if (ret)
 		return ret;
 
-	return pcc_chan_reg_read_modify_write(&pchan->db);
+	ret = pcc_chan_reg_read_modify_write(&pchan->db);
+	if (!ret && pchan->plat_irq > 0)
+		pchan->chan_in_use = true;
+
+	return ret;
 }
 
 /**
@@ -384,11 +411,14 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 static int pcc_startup(struct mbox_chan *chan)
 {
 	struct pcc_chan_info *pchan = chan->con_priv;
+	unsigned long irqflags;
 	int rc;
 
 	if (pchan->plat_irq > 0) {
-		rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq, 0,
-				      MBOX_IRQ_NAME, chan);
+		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
+						IRQF_SHARED | IRQF_ONESHOT : 0;
+		rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq,
+				      irqflags, MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
 			dev_err(chan->mbox->dev, "failed to register PCC interrupt %d\n",
 				pchan->plat_irq);
@@ -494,6 +524,7 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 		       pcct_ss->platform_interrupt);
 		return -EINVAL;
 	}
+	pchan->plat_irq_flags = pcct_ss->flags;
 
 	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
@@ -515,6 +546,12 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 					"PLAT IRQ ACK");
 	}
 
+	if (pcc_chan_plat_irq_can_be_shared(pchan) &&
+	    !pchan->plat_irq_ack.gas) {
+		pr_err("PCC subspace has level IRQ with no ACK register\n");
+		return -EINVAL;
+	}
+
 	return ret;
 }
 
-- 
2.39.5




