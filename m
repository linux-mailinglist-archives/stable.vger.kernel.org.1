Return-Path: <stable+bounces-16682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A0840DFB
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D443C286D89
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6A315B102;
	Mon, 29 Jan 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KF098NIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98815705A;
	Mon, 29 Jan 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548200; cv=none; b=ieelvHuuMblHv8S1GngaIiD4tgzi5IPcKJw0cPDQtC5jubi47y7IX+DEdTT+Q4KKqeqy5fyCKKKVlOpOGbh6dNoUYb4fmW8TeqlFqv7zLE8oIKGwmxHn2Nu+JGVOQxe2lDta3JAQ0RYvD2t6Aago7zDgXK9j05d5x0IhO4XNz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548200; c=relaxed/simple;
	bh=RB5MJrHJRd3o29ooRp7439YNB74dKzsN9l6cusmhTyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdavtctN+ScVfrLcc2n5pW1l9vQc582eYVyGUcoUMtoOarHFM83eBX3KJsu2eAxjMECRAWmPelD/TDfxOT7iCSu1YOn4KTMkRkF6tiAPZJ/L8ml+cnPbW00nEOTNsas6K25oPjDvIc82JjkXY1fLNVesnZW7ubGYcxLdh+6j1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KF098NIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B2BC433F1;
	Mon, 29 Jan 2024 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548200;
	bh=RB5MJrHJRd3o29ooRp7439YNB74dKzsN9l6cusmhTyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF098NIovAJLadMCwq232SF2ZRKvJKWBEtNR7d48duCkf+aEeQiZYue4rKI9O6Lb4
	 FlXnOUrTBHZjujXiB0rDfPQunGypnSSFhUjEW5ssZ/6UflDUIh63LKs4/9iLWXR1e5
	 6tBlg1eOjde/mr6dFYn7halwPfu+Jw/7AFsh3pLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xinglong Yang <xinglong.yang@cixtech.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 6.7 240/346] firmware: arm_scmi: Check mailbox/SMT channel for consistency
Date: Mon, 29 Jan 2024 09:04:31 -0800
Message-ID: <20240129170023.468303683@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Marussi <cristian.marussi@arm.com>

commit 437a310b22244d4e0b78665c3042e5d1c0f45306 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_scmi/common.h  |    1 +
 drivers/firmware/arm_scmi/mailbox.c |   14 ++++++++++++++
 drivers/firmware/arm_scmi/shmem.c   |    6 ++++++
 3 files changed, 21 insertions(+)

--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -314,6 +314,7 @@ void shmem_fetch_notification(struct scm
 void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
+bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -45,6 +45,20 @@ static void rx_callback(struct mbox_clie
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
 
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -122,3 +122,9 @@ bool shmem_poll_done(struct scmi_shared_
 		(SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
 		 SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
+
+bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
+{
+	return (ioread32(&shmem->channel_status) &
+			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
+}



