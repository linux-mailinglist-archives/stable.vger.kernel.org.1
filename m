Return-Path: <stable+bounces-16115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D271E83F076
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D7B23684
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517191B807;
	Sat, 27 Jan 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRiwc3vR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D21B7FA
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393121; cv=none; b=TtT2JjB1VRSkR5NTvXrB7iIsYs7ezjw8kb/q77Qj4ktoVZvaZ5KEtobieB6wLGv8hTl+AjjZwYvatzRrPk8DgPlliy9XEoKWr7WhpiQM7KMNR8A9DDsscy1PlGweKjJlDdn1bMNB8gtGcue0uMQ4Ul+a1/9ZezDP+HQXSdYDPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393121; c=relaxed/simple;
	bh=lDqYV5ukP+eU11sp8+5fmAtBBfLD0iCLemGhKhxF/Tk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ba2uM9eWYYutNxMmZtgSOuxHJlUl9xrC/2QyG4r3gX8d6tSJ9jG3CtR+xcBxAaSr9ZKWqPnt5+jJQB8Dm/uwHyBEntuh9Dtxrm4ONiLDT+gBX8+LNSWzzOBFgc1Qy/5dUXWjijh60yVm5HvtoN9bthLUFxQc4FAQYxbrh5YMNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BRiwc3vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8721C433C7;
	Sat, 27 Jan 2024 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706393120;
	bh=lDqYV5ukP+eU11sp8+5fmAtBBfLD0iCLemGhKhxF/Tk=;
	h=Subject:To:Cc:From:Date:From;
	b=BRiwc3vR1ishKEd681ocg6/Mm2UKewfsK5lSwiZYMMm+4UQ51fQ+YcZtgtqmjkM8E
	 AlpbSLQaF7TOYWjiybPs8J4i3e5oqGxUrXspj2cpOyS52TkNbzPmwzVOp2UzfK8Llq
	 vA5F55lMM9r3NXLhU7p755Q4NQNl08CMvpkz9zY0=
Subject: FAILED: patch "[PATCH] firmware: arm_scmi: Check mailbox/SMT channel for consistency" failed to apply to 5.10-stable tree
To: cristian.marussi@arm.com,sudeep.holla@arm.com,xinglong.yang@cixtech.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:05:19 -0800
Message-ID: <2024012719-remarry-magical-0c2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 437a310b22244d4e0b78665c3042e5d1c0f45306
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012719-remarry-magical-0c2e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

437a310b2224 ("firmware: arm_scmi: Check mailbox/SMT channel for consistency")
13fba878ccdd ("firmware: arm_scmi: Add priv parameter to scmi_rx_callback")
e9b21c96181c ("firmware: arm_scmi: Make .clear_channel optional")
ed7c04c1fea3 ("firmware: arm_scmi: Handle concurrent and out-of-order messages")
9ca5a1838e59 ("firmware: arm_scmi: Introduce monotonically increasing tokens")
3669032514be ("firmware: arm_scmi: Remove scmi_dump_header_dbg() helper")
e30d91d4ffda ("firmware: arm_scmi: Move reinit_completion from scmi_xfer_get to do_xfer")
0cb7af474e0d ("firmware: arm_scmi: Reset Rx buffer to max size during async commands")
d4f9dddd21f3 ("firmware: arm_scmi: Add dynamic scmi devices creation")
f5800e0bf6f9 ("firmware: arm_scmi: Add protocol modularization support")
a02d7c93c1f3 ("firmware: arm_scmi: Make notify_priv really private")
9162afa2ae99 ("firmware: arm_scmi: Cleanup unused core transfer helper wrappers")
51fe1b154e2f ("firmware: arm_scmi: Cleanup legacy protocol init code")
fe4894d968f4 ("firmware: arm_scmi: Port voltage protocol to new protocols interface")
b46d852718c1 ("firmware: arm_scmi: Port systempower protocol to new protocols interface")
9694a7f62359 ("firmware: arm_scmi: Port sensor protocol to new protocols interface")
7e0293442238 ("firmware: arm_scmi: Port reset protocol to new protocols interface")
887281c7519d ("firmware: arm_scmi: Port clock protocol to new protocols interface")
9bc8069c8567 ("firmware: arm_scmi: Port power protocol to new protocols interface")
1fec5e6b5233 ("firmware: arm_scmi: Port perf protocol to new protocols interface")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 437a310b22244d4e0b78665c3042e5d1c0f45306 Mon Sep 17 00:00:00 2001
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 20 Dec 2023 17:21:12 +0000
Subject: [PATCH] firmware: arm_scmi: Check mailbox/SMT channel for consistency

On reception of a completion interrupt the shared memory area is accessed
to retrieve the message header at first and then, if the message sequence
number identifies a transaction which is still pending, the related
payload is fetched too.

When an SCMI command times out the channel ownership remains with the
platform until eventually a late reply is received and, as a consequence,
any further transmission attempt remains pending, waiting for the channel
to be relinquished by the platform.

Once that late reply is received the channel ownership is given back
to the agent and any pending request is then allowed to proceed and
overwrite the SMT area of the just delivered late reply; then the wait
for the reply to the new request starts.

It has been observed that the spurious IRQ related to the late reply can
be wrongly associated with the freshly enqueued request: when that happens
the SCMI stack in-flight lookup procedure is fooled by the fact that the
message header now present in the SMT area is related to the new pending
transaction, even though the real reply has still to arrive.

This race-condition on the A2P channel can be detected by looking at the
channel status bits: a genuine reply from the platform will have set the
channel free bit before triggering the completion IRQ.

Add a consistency check to validate such condition in the A2P ISR.

Reported-by: Xinglong Yang <xinglong.yang@cixtech.com>
Closes: https://lore.kernel.org/all/PUZPR06MB54981E6FA00D82BFDBB864FBF08DA@PUZPR06MB5498.apcprd06.prod.outlook.com/
Fixes: 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of the transport type")
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Xinglong Yang <xinglong.yang@cixtech.com>
Link: https://lore.kernel.org/r/20231220172112.763539-1-cristian.marussi@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c46dc5215af7..00b165d1f502 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -314,6 +314,7 @@ void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
+bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 19246ed1f01f..b8d470417e8f 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -45,6 +45,20 @@ static void rx_callback(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
+	/*
+	 * An A2P IRQ is NOT valid when received while the platform still has
+	 * the ownership of the channel, because the platform at first releases
+	 * the SMT channel and then sends the completion interrupt.
+	 *
+	 * This addresses a possible race condition in which a spurious IRQ from
+	 * a previous timed-out reply which arrived late could be wrongly
+	 * associated with the next pending transaction.
+	 */
+	if (cl->knows_txdone && !shmem_channel_free(smbox->shmem)) {
+		dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\n");
+		return;
+	}
+
 	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
 }
 
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 87b4f4d35f06..517d52fb3bcb 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -122,3 +122,9 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		(SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
 		 SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
+
+bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
+{
+	return (ioread32(&shmem->channel_status) &
+			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
+}


