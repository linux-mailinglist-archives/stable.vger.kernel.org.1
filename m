Return-Path: <stable+bounces-158398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE5AE65E5
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9666E167E96
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC6028D8FA;
	Tue, 24 Jun 2025 13:04:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D927A92D
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770290; cv=none; b=GjwOPXyCpRT5NIZb4HzrdUyW94Y/GMVgHuAbOyutleBQtmoYM/UdrQajQrE7NkuwVa+d6hj2nP3ZCBmf2gP9gwrZdUdwME926/Vvr7XRiqYIbSUagmzeVyvgdL1yU81/JUyjeEeeaK+kQVOsR42PpRiJRUNXqLjJm329Hdtc3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770290; c=relaxed/simple;
	bh=Z/GxZKw/yQDWhD9TmO3GTCG2DhJQ0kISu1+Ne6vko4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hU/kR3lhxVbgHZGyw/sSmnRXMAbgeJihmrBPovnBz02HJrHfepXq3FoLVNRTX0iRESwLXTtivoyeCoIvD0aPpGpnMMHS/2ybMKWX31ATZ1GVafoaJX5mkB9O2ZVQql4g8iu7mAKdsBFdueQtcjk4UE0usbSAipa+XBBwjD+Yotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D968C339;
	Tue, 24 Jun 2025 06:04:29 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A136A3F58B;
	Tue, 24 Jun 2025 06:04:46 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 6.6.y 1/2] firmware: arm_scmi: Add a common helper to check if a message is supported
Date: Tue, 24 Jun 2025 14:04:42 +0100
Message-Id: <20250624130443.1338155-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025062017-daybreak-patronage-a6b4@gregkh>
References: <2025062017-daybreak-patronage-a6b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit 637b6d6cae9c42db5a9525da67c991294924d2cd ]

A common helper is provided to check if a specific protocol message is
supported or not.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20240212123233.1230090-3-cristian.marussi@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 34 +++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 65d1e66a347d..24babf87adb9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1820,10 +1820,44 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
 #endif
 }
 
+/**
+ * scmi_protocol_msg_check  - Check protocol message attributes
+ *
+ * @ph: A reference to the protocol handle.
+ * @message_id: The ID of the message to check.
+ * @attributes: A parameter to optionally return the retrieved message
+ *		attributes, in case of Success.
+ *
+ * An helper to check protocol message attributes for a specific protocol
+ * and message pair.
+ *
+ * Return: 0 on SUCCESS
+ */
+static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
+				   u32 message_id, u32 *attributes)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = xfer_get_init(ph, PROTOCOL_MESSAGE_ATTRIBUTES,
+			    sizeof(__le32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(message_id, t->tx.buf);
+	ret = do_xfer(ph, t);
+	if (!ret && attributes)
+		*attributes = get_unaligned_le32(t->rx.buf);
+	xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
+	.protocol_msg_check = scmi_protocol_msg_check,
 	.fastchannel_init = scmi_common_fastchannel_init,
 	.fastchannel_db_ring = scmi_common_fastchannel_db_ring,
 };
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 78e1a01eb656..9fc2f1e293d4 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -250,6 +250,8 @@ struct scmi_fc_info {
  *			provided in @ops.
  * @iter_response_run: A common helper to trigger the run of a previously
  *		       initialized iterator.
+ * @protocol_msg_check: A common helper to check is a specific protocol message
+ *			is supported.
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
@@ -262,6 +264,8 @@ struct scmi_proto_helpers_ops {
 				    unsigned int max_resources, u8 msg_id,
 				    size_t tx_size, void *priv);
 	int (*iter_response_run)(void *iter);
+	int (*protocol_msg_check)(const struct scmi_protocol_handle *ph,
+				  u32 message_id, u32 *attributes);
 	void (*fastchannel_init)(const struct scmi_protocol_handle *ph,
 				 u8 describe_id, u32 message_id,
 				 u32 valid_size, u32 domain,
-- 
2.34.1


