Return-Path: <stable+bounces-158400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A4BAE65EB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F31605AE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC8291C28;
	Tue, 24 Jun 2025 13:07:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F54139E
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770477; cv=none; b=h6HuDPYEyCJTrvFitwiUis9NS7puj9s0PNbFyDf3y/nwJq5NUahhW5TCUCG0eFvvDKKv/F2djqWigujh/XWg4TyVvaTb/8eFjQ0hc3/xiaOH27qu4LxdTi8CSu8AV5dpLCxpfc0RhJzaXhHjVsKkHZ7gaSbN1STpBDMVH8dkock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770477; c=relaxed/simple;
	bh=k1vu4YQn7quvnK4D3mhtroVZhBJZp8hfAhS6Cl2/Y9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVpK1FK1phkKR0tMjNsV+Rz579Sf+g1X5Cf8zr6ycsjND09dBdWzq4x6RtGIOx2F6Z9Oaat8Sd7xvxyZAbeaQO01gmZ4mF7sBujLP9YwQOgKkqObBk2EeLHLj02qSUPhypKQ9Y/lynzmAlUEChCKHxG/Pq+Qj9rEuNikHUIfFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3A3E113E;
	Tue, 24 Jun 2025 06:07:37 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A0FD3F58B;
	Tue, 24 Jun 2025 06:07:54 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 6.1.y 1/2] firmware: arm_scmi: Add a common helper to check if a message is supported
Date: Tue, 24 Jun 2025 14:07:51 +0100
Message-Id: <20250624130752.1339984-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025062018-joyfully-unmixable-8b37@gregkh>
References: <2025062018-joyfully-unmixable-8b37@gregkh>
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
index fe06dc193689..aa89bbf04eb2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1450,10 +1450,44 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
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
index 2f3bf691db7c..9024281f172a 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -243,6 +243,8 @@ struct scmi_fc_info {
  *			provided in @ops.
  * @iter_response_run: A common helper to trigger the run of a previously
  *		       initialized iterator.
+ * @protocol_msg_check: A common helper to check is a specific protocol message
+ *			is supported.
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
@@ -255,6 +257,8 @@ struct scmi_proto_helpers_ops {
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


