Return-Path: <stable+bounces-102043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E449EF094
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E701E1892DDE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8D235C5F;
	Thu, 12 Dec 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIi+nU2Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF0222D66;
	Thu, 12 Dec 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019751; cv=none; b=D17bEaBouKHTXa4mgNLMl7tCuPQ4pi6mfGqiqQ2gUzryKz2bDKAdHF5bxt1wbiAS0+3amTgyGFgGw0RY8fhYhEnc/6lBRM+NuqhdIiOkPulI8LvPHiHoNuhe72GDsGmdERJWYj/CBTNemP1JJplMmD+Q9DtsTD145NZS00LbfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019751; c=relaxed/simple;
	bh=8SO9boh73o6zQCIntcE6ZNw6iWRqGq2AL9MBNjYZijQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwCyGo+pMfEmd6VE1jJk31vL0DfigHFp1sCN+eX+bCXaOIByvBUuW2Gg7VSjr+gCHFXj2D9aueqEC7fURz3sxNxfWqffte/96yeNenXIK+uI2TsIfn1VLvZioN332mLh3Y48A2xdk9Z98WcX8H9vMgqW/SCgYotYUpV0xkRNE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIi+nU2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C34C4CECE;
	Thu, 12 Dec 2024 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019751;
	bh=8SO9boh73o6zQCIntcE6ZNw6iWRqGq2AL9MBNjYZijQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIi+nU2QTVJjzmaDCib3AvFJA78ldKXxkwdZgzYKel8dZ+5dLHaZ7XTknFVV6PKUA
	 ptBYRRuWR+oP3zAdM+bNoyCZGXbMxuKPE2obkcuaoUQ7lUOea9qOLsPzf6Jw1lL1Qu
	 wWSbw8sHbSBEh7icrQLCQYXRQYUjStORyKlWb7Ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Chris Lew <quic_clew@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 287/772] rpmsg: glink: Fix GLINK command prefix
Date: Thu, 12 Dec 2024 15:53:52 +0100
Message-ID: <20241212144401.766807681@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit 4e816d0318fdfe8932da80dbf04ba318b13e4b3a ]

The upstream GLINK driver was first introduced to communicate with the
RPM on MSM8996, presumably as an artifact from that era the command
defines was prefixed RPM_CMD, while they actually are GLINK_CMDs.

Let's rename these, to keep things tidy. No functional change.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230214225933.2025595-1-quic_bjorande@quicinc.com
Stable-dep-of: 06c59d97f63c ("rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rpmsg/qcom_glink_native.c | 98 +++++++++++++++----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index cb8f65c1d4e3b..2c388426e4019 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -189,20 +189,20 @@ struct glink_channel {
 
 static const struct rpmsg_endpoint_ops glink_endpoint_ops;
 
-#define RPM_CMD_VERSION			0
-#define RPM_CMD_VERSION_ACK		1
-#define RPM_CMD_OPEN			2
-#define RPM_CMD_CLOSE			3
-#define RPM_CMD_OPEN_ACK		4
-#define RPM_CMD_INTENT			5
-#define RPM_CMD_RX_DONE			6
-#define RPM_CMD_RX_INTENT_REQ		7
-#define RPM_CMD_RX_INTENT_REQ_ACK	8
-#define RPM_CMD_TX_DATA			9
-#define RPM_CMD_CLOSE_ACK		11
-#define RPM_CMD_TX_DATA_CONT		12
-#define RPM_CMD_READ_NOTIF		13
-#define RPM_CMD_RX_DONE_W_REUSE		14
+#define GLINK_CMD_VERSION		0
+#define GLINK_CMD_VERSION_ACK		1
+#define GLINK_CMD_OPEN			2
+#define GLINK_CMD_CLOSE			3
+#define GLINK_CMD_OPEN_ACK		4
+#define GLINK_CMD_INTENT		5
+#define GLINK_CMD_RX_DONE		6
+#define GLINK_CMD_RX_INTENT_REQ		7
+#define GLINK_CMD_RX_INTENT_REQ_ACK	8
+#define GLINK_CMD_TX_DATA		9
+#define GLINK_CMD_CLOSE_ACK		11
+#define GLINK_CMD_TX_DATA_CONT		12
+#define GLINK_CMD_READ_NOTIF		13
+#define GLINK_CMD_RX_DONE_W_REUSE	14
 
 #define GLINK_FEATURE_INTENTLESS	BIT(1)
 
@@ -311,7 +311,7 @@ static void qcom_glink_send_read_notify(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_READ_NOTIF);
+	msg.cmd = cpu_to_le16(GLINK_CMD_READ_NOTIF);
 	msg.param1 = 0;
 	msg.param2 = 0;
 
@@ -373,7 +373,7 @@ static int qcom_glink_send_version(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_VERSION);
+	msg.cmd = cpu_to_le16(GLINK_CMD_VERSION);
 	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
 	msg.param2 = cpu_to_le32(glink->features);
 
@@ -384,7 +384,7 @@ static void qcom_glink_send_version_ack(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_VERSION_ACK);
+	msg.cmd = cpu_to_le16(GLINK_CMD_VERSION_ACK);
 	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
 	msg.param2 = cpu_to_le32(glink->features);
 
@@ -396,7 +396,7 @@ static void qcom_glink_send_open_ack(struct qcom_glink *glink,
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_OPEN_ACK);
+	msg.cmd = cpu_to_le16(GLINK_CMD_OPEN_ACK);
 	msg.param1 = cpu_to_le16(channel->rcid);
 	msg.param2 = cpu_to_le32(0);
 
@@ -422,11 +422,11 @@ static void qcom_glink_handle_intent_req_ack(struct qcom_glink *glink,
 }
 
 /**
- * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
+ * qcom_glink_send_open_req() - send a GLINK_CMD_OPEN request to the remote
  * @glink: Ptr to the glink edge
  * @channel: Ptr to the channel that the open req is sent
  *
- * Allocates a local channel id and sends a RPM_CMD_OPEN message to the remote.
+ * Allocates a local channel id and sends a GLINK_CMD_OPEN message to the remote.
  * Will return with refcount held, regardless of outcome.
  *
  * Return: 0 on success, negative errno otherwise.
@@ -455,7 +455,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
 
 	channel->lcid = ret;
 
-	req.msg.cmd = cpu_to_le16(RPM_CMD_OPEN);
+	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
 	req.msg.param1 = cpu_to_le16(channel->lcid);
 	req.msg.param2 = cpu_to_le32(name_len);
 	strcpy(req.name, channel->name);
@@ -480,7 +480,7 @@ static void qcom_glink_send_close_req(struct qcom_glink *glink,
 {
 	struct glink_msg req;
 
-	req.cmd = cpu_to_le16(RPM_CMD_CLOSE);
+	req.cmd = cpu_to_le16(GLINK_CMD_CLOSE);
 	req.param1 = cpu_to_le16(channel->lcid);
 	req.param2 = 0;
 
@@ -492,7 +492,7 @@ static void qcom_glink_send_close_ack(struct qcom_glink *glink,
 {
 	struct glink_msg req;
 
-	req.cmd = cpu_to_le16(RPM_CMD_CLOSE_ACK);
+	req.cmd = cpu_to_le16(GLINK_CMD_CLOSE_ACK);
 	req.param1 = cpu_to_le16(rcid);
 	req.param2 = 0;
 
@@ -523,7 +523,7 @@ static void qcom_glink_rx_done_work(struct work_struct *work)
 		iid = intent->id;
 		reuse = intent->reuse;
 
-		cmd.id = reuse ? RPM_CMD_RX_DONE_W_REUSE : RPM_CMD_RX_DONE;
+		cmd.id = reuse ? GLINK_CMD_RX_DONE_W_REUSE : GLINK_CMD_RX_DONE;
 		cmd.lcid = cid;
 		cmd.liid = iid;
 
@@ -635,7 +635,7 @@ static int qcom_glink_send_intent_req_ack(struct qcom_glink *glink,
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_RX_INTENT_REQ_ACK);
+	msg.cmd = cpu_to_le16(GLINK_CMD_RX_INTENT_REQ_ACK);
 	msg.param1 = cpu_to_le16(channel->lcid);
 	msg.param2 = cpu_to_le32(granted);
 
@@ -666,7 +666,7 @@ static int qcom_glink_advertise_intent(struct qcom_glink *glink,
 	} __packed;
 	struct command cmd;
 
-	cmd.id = cpu_to_le16(RPM_CMD_INTENT);
+	cmd.id = cpu_to_le16(GLINK_CMD_INTENT);
 	cmd.lcid = cpu_to_le16(channel->lcid);
 	cmd.count = cpu_to_le32(1);
 	cmd.size = cpu_to_le32(intent->size);
@@ -1031,42 +1031,42 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 		param2 = le32_to_cpu(msg.param2);
 
 		switch (cmd) {
-		case RPM_CMD_VERSION:
-		case RPM_CMD_VERSION_ACK:
-		case RPM_CMD_CLOSE:
-		case RPM_CMD_CLOSE_ACK:
-		case RPM_CMD_RX_INTENT_REQ:
+		case GLINK_CMD_VERSION:
+		case GLINK_CMD_VERSION_ACK:
+		case GLINK_CMD_CLOSE:
+		case GLINK_CMD_CLOSE_ACK:
+		case GLINK_CMD_RX_INTENT_REQ:
 			ret = qcom_glink_rx_defer(glink, 0);
 			break;
-		case RPM_CMD_OPEN_ACK:
+		case GLINK_CMD_OPEN_ACK:
 			ret = qcom_glink_rx_open_ack(glink, param1);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
-		case RPM_CMD_OPEN:
+		case GLINK_CMD_OPEN:
 			ret = qcom_glink_rx_defer(glink, param2);
 			break;
-		case RPM_CMD_TX_DATA:
-		case RPM_CMD_TX_DATA_CONT:
+		case GLINK_CMD_TX_DATA:
+		case GLINK_CMD_TX_DATA_CONT:
 			ret = qcom_glink_rx_data(glink, avail);
 			break;
-		case RPM_CMD_READ_NOTIF:
+		case GLINK_CMD_READ_NOTIF:
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 
 			mbox_send_message(glink->mbox_chan, NULL);
 			mbox_client_txdone(glink->mbox_chan, 0);
 			break;
-		case RPM_CMD_INTENT:
+		case GLINK_CMD_INTENT:
 			qcom_glink_handle_intent(glink, param1, param2, avail);
 			break;
-		case RPM_CMD_RX_DONE:
+		case GLINK_CMD_RX_DONE:
 			qcom_glink_handle_rx_done(glink, param1, param2, false);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
-		case RPM_CMD_RX_DONE_W_REUSE:
+		case GLINK_CMD_RX_DONE_W_REUSE:
 			qcom_glink_handle_rx_done(glink, param1, param2, true);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
-		case RPM_CMD_RX_INTENT_REQ_ACK:
+		case GLINK_CMD_RX_INTENT_REQ_ACK:
 			qcom_glink_handle_intent_req_ack(glink, param1, param2);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
@@ -1269,7 +1269,7 @@ static int qcom_glink_request_intent(struct qcom_glink *glink,
 
 	reinit_completion(&channel->intent_req_comp);
 
-	cmd.id = RPM_CMD_RX_INTENT_REQ;
+	cmd.id = GLINK_CMD_RX_INTENT_REQ;
 	cmd.cid = channel->lcid;
 	cmd.size = size;
 
@@ -1343,7 +1343,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
 		chunk_size = SZ_8K;
 		left_size = len - chunk_size;
 	}
-	req.msg.cmd = cpu_to_le16(RPM_CMD_TX_DATA);
+	req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
 	req.msg.param1 = cpu_to_le16(channel->lcid);
 	req.msg.param2 = cpu_to_le32(iid);
 	req.chunk_size = cpu_to_le32(chunk_size);
@@ -1365,7 +1365,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
 			chunk_size = SZ_8K;
 		left_size -= chunk_size;
 
-		req.msg.cmd = cpu_to_le16(RPM_CMD_TX_DATA_CONT);
+		req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA_CONT);
 		req.msg.param1 = cpu_to_le16(channel->lcid);
 		req.msg.param2 = cpu_to_le32(iid);
 		req.chunk_size = cpu_to_le32(chunk_size);
@@ -1631,22 +1631,22 @@ static void qcom_glink_work(struct work_struct *work)
 		param2 = le32_to_cpu(msg->param2);
 
 		switch (cmd) {
-		case RPM_CMD_VERSION:
+		case GLINK_CMD_VERSION:
 			qcom_glink_receive_version(glink, param1, param2);
 			break;
-		case RPM_CMD_VERSION_ACK:
+		case GLINK_CMD_VERSION_ACK:
 			qcom_glink_receive_version_ack(glink, param1, param2);
 			break;
-		case RPM_CMD_OPEN:
+		case GLINK_CMD_OPEN:
 			qcom_glink_rx_open(glink, param1, msg->data);
 			break;
-		case RPM_CMD_CLOSE:
+		case GLINK_CMD_CLOSE:
 			qcom_glink_rx_close(glink, param1);
 			break;
-		case RPM_CMD_CLOSE_ACK:
+		case GLINK_CMD_CLOSE_ACK:
 			qcom_glink_rx_close_ack(glink, param1);
 			break;
-		case RPM_CMD_RX_INTENT_REQ:
+		case GLINK_CMD_RX_INTENT_REQ:
 			qcom_glink_handle_intent_req(glink, param1, param2);
 			break;
 		default:
-- 
2.43.0




