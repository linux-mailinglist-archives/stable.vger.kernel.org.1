Return-Path: <stable+bounces-132750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2AA8A114
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CB1168FBB
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026312918C7;
	Tue, 15 Apr 2025 14:30:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4EC1B0434;
	Tue, 15 Apr 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727411; cv=none; b=nktMPkC74HeaEBrLvTgBalrh/VFgpC1ZiSksLKfpyjV0o89A3ORZb9+VYPGp7Pye6W+m4rI4O0Z+d0qusZaBHTk0AO0VuAqXTXbwTcwlexGf8RJj48fMJxTraNwZKJ6+Y7TaUVaA+Rs1UDrhZK1ChiXPcw2XAVD0ktwzLwltLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727411; c=relaxed/simple;
	bh=2mD5L5mLgBED0q8FXEIKxUdCbRXJ6s+ze57Y0Ayovbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spl6Ox63R3hc0/4qBjvZyiflOKoU5TMVbIjeEen6b8xRqQ36UGXfMuiu2CYpySfOmtKnAZgLtshZvkrZ160ZlUkP0G93Mb0FkHl4CkuMgb339o6DND0uqN1+75YHiQz2R+NKuCUfAADTVrrYqYx6YcCPJwDY836m+NV42OR9YXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2EDF1756;
	Tue, 15 Apr 2025 07:30:06 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F843F694;
	Tue, 15 Apr 2025 07:30:06 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	maz@kernel.org,
	johan@kernel.org,
	stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/4] firmware: arm_scmi: Ensure that the message-id supports fastchannel
Date: Tue, 15 Apr 2025 15:29:30 +0100
Message-ID: <20250415142933.1746249-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250415142933.1746249-1-cristian.marussi@arm.com>
References: <20250415142933.1746249-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sibi Sankar <quic_sibis@quicinc.com>

Currently the perf and powercap protocol relies on the protocol domain
attributes, which just ensures that one fastchannel per domain, before
instantiating fastchannels for all possible message-ids. Fix this by
ensuring that each message-id supports fastchannel before initialization.

Logs:
scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:0] - ret:-95. Using regular messaging.
scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:1] - ret:-95. Using regular messaging.
scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:2] - ret:-95. Using regular messaging.

CC: stable@vger.kernel.org
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
[Cristian: Modified the condition checked to establish support or not]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
RFC -> V1
 - picked up a few tags

Since PROTOCOL_MESSAGE_ATTRIBUTES, used to check if message_id is supported,
is a mandatory command, it cannot fail so we must bail-out NOT only if FC was
not supported for that command but also if the query fails as a whole; so the
condition checked for bailing out is modified to:

	if (ret || !MSG_SUPPORTS_FASTCHANNEL(attributes)) {

Removed also Tested-by and Reviewed-by tags since I modified the logic.
---
 drivers/firmware/arm_scmi/driver.c    | 76 +++++++++++++++------------
 drivers/firmware/arm_scmi/protocols.h |  2 +
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 1cf18cc8e63f..0e281fca0a38 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1738,6 +1738,39 @@ static int scmi_common_get_max_msg_size(const struct scmi_protocol_handle *ph)
 	return info->desc->max_msg_size;
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
 /**
  * struct scmi_iterator  - Iterator descriptor
  * @msg: A reference to the message TX buffer; filled by @prepare_message with
@@ -1879,6 +1912,7 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	int ret;
 	u32 flags;
 	u64 phys_addr;
+	u32 attributes;
 	u8 size;
 	void __iomem *addr;
 	struct scmi_xfer *t;
@@ -1887,6 +1921,15 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	struct scmi_msg_resp_desc_fc *resp;
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 
+	/* Check if the MSG_ID supports fastchannel */
+	ret = scmi_protocol_msg_check(ph, message_id, &attributes);
+	if (ret || !MSG_SUPPORTS_FASTCHANNEL(attributes)) {
+		dev_dbg(ph->dev,
+			"Skip FC init for 0x%02X/%d  domain:%d - ret:%d\n",
+			pi->proto->id, message_id, domain, ret);
+		return;
+	}
+
 	if (!p_addr) {
 		ret = -EINVAL;
 		goto err_out;
@@ -2004,39 +2047,6 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
 		SCMI_PROTO_FC_RING_DB(64);
 }
 
-/**
- * scmi_protocol_msg_check  - Check protocol message attributes
- *
- * @ph: A reference to the protocol handle.
- * @message_id: The ID of the message to check.
- * @attributes: A parameter to optionally return the retrieved message
- *		attributes, in case of Success.
- *
- * An helper to check protocol message attributes for a specific protocol
- * and message pair.
- *
- * Return: 0 on SUCCESS
- */
-static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
-				   u32 message_id, u32 *attributes)
-{
-	int ret;
-	struct scmi_xfer *t;
-
-	ret = xfer_get_init(ph, PROTOCOL_MESSAGE_ATTRIBUTES,
-			    sizeof(__le32), 0, &t);
-	if (ret)
-		return ret;
-
-	put_unaligned_le32(message_id, t->tx.buf);
-	ret = do_xfer(ph, t);
-	if (!ret && attributes)
-		*attributes = get_unaligned_le32(t->rx.buf);
-	xfer_put(ph, t);
-
-	return ret;
-}
-
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
 	.get_max_msg_size = scmi_common_get_max_msg_size,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index aaee57cdcd55..d62c4469d1fd 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -31,6 +31,8 @@
 
 #define SCMI_PROTOCOL_VENDOR_BASE	0x80
 
+#define MSG_SUPPORTS_FASTCHANNEL(x)	((x) & BIT(0))
+
 enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
 	PROTOCOL_ATTRIBUTES = 0x1,
-- 
2.47.0


