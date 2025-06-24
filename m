Return-Path: <stable+bounces-158399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30774AE65CF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486F04083E3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC07291C0E;
	Tue, 24 Jun 2025 13:04:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10E182BC
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770291; cv=none; b=Pf4whW/OY0i9KgRTwBJeXtVoXfmBuRkoW86MW8NnzJfCRsZmC7jq6vAYPga/XBSkmGcuytD8JfIPyVRQndtbaWRr34ZTHrcgIowJRX92R14yQ+tPy/729REbNpcqKehjOdAl5pfFLM+VfuWo6fFEgv+bzhahQXP042WYET7l/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770291; c=relaxed/simple;
	bh=L2gLNiuQiiY4szPQeyEGh/WkZJcRfv3yom+Q7jzy4OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIHCS0gq4sPhjatpqvwrAg8CBq4Z+za/gGu9hmR5xHCPqWoHQo42qZ92a5dGPWVZP9/ulCCT3US1wdB3L29Ms1Txom5HRGWB+lZi/weglAB5QEtdWJcac5xHD9D1+5dzy7ur973VOM3R1qh6wniesRQVucwM+xHy3NxHP0cQ7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 591E1113E;
	Tue, 24 Jun 2025 06:04:31 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 214FB3F58B;
	Tue, 24 Jun 2025 06:04:47 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 6.6.y 2/2] firmware: arm_scmi: Ensure that the message-id supports fastchannel
Date: Tue, 24 Jun 2025 14:04:43 +0100
Message-Id: <20250624130443.1338155-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624130443.1338155-1-sudeep.holla@arm.com>
References: <2025062017-daybreak-patronage-a6b4@gregkh>
 <20250624130443.1338155-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sibi Sankar <quic_sibis@quicinc.com>

[ Upstream commit 94a263f981a3fa3d93f65c31e0fed0756736be43 ]

Currently the perf and powercap protocol relies on the protocol domain
attributes, which just ensures that one fastchannel per domain, before
instantiating fastchannels for all possible message-ids. Fix this by
ensuring that each message-id supports fastchannel before initialization.

Logs:
  |  scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:0] - ret:-95. Using regular messaging
  |  scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:1] - ret:-95. Using regular messaging
  |  scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:2] - ret:-95. Using regular messaging

CC: stable@vger.kernel.org # 6.6.x : 637b6d6cae9c : firmware: arm_scmi: Add a common helper to check if a message is supported
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
[Cristian: Modified the condition checked to establish support or not]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Message-Id: <20250429141108.406045-2-cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 76 +++++++++++++++------------
 drivers/firmware/arm_scmi/protocols.h |  2 +
 2 files changed, 45 insertions(+), 33 deletions(-)

Hi Greg,

Sorry for the delay, was hoping the author would pick this up as it was
issue on their platform. I assume they don't have interest in stable tree
backport though they do run android stable kernels.

Anyways, there is a dependency patch which I have added just to keep it
close to mainline.

Alternative or easier way is to squash them into one and add the function
in this backport to avoid adding the dependent patch separately.

Also, even with dependency picked up, it needs backport as the patch won't
apply easily. So I am sending both though dependent patch applies cleanly
without any issues.

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 24babf87adb9..d1fd2e492909 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1547,6 +1547,39 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 	return ret;
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
@@ -1688,6 +1721,7 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	int ret;
 	u32 flags;
 	u64 phys_addr;
+	u32 attributes;
 	u8 size;
 	void __iomem *addr;
 	struct scmi_xfer *t;
@@ -1696,6 +1730,15 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
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
@@ -1820,39 +1863,6 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
 #endif
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
 	.iter_response_init = scmi_iterator_init,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 9fc2f1e293d4..095b14a2d0a3 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -29,6 +29,8 @@
 #define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
 #define PROTOCOL_REV_MINOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x))))
 
+#define MSG_SUPPORTS_FASTCHANNEL(x)	((x) & BIT(0))
+
 enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
 	PROTOCOL_ATTRIBUTES = 0x1,
-- 
2.34.1


