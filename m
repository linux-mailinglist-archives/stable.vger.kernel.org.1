Return-Path: <stable+bounces-34323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C21893EDC
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A833B224F7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49814776F;
	Mon,  1 Apr 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vOa0kOKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D601CA8F;
	Mon,  1 Apr 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987733; cv=none; b=gQ+kyZcUmWaOwVglVcmtpcxPryJMe8L0qJBLvPqVBe3kI07Lavp/Jq3dzcACGBNin7Lq3uGM05r8+UoOImYEoNXXOD0DBUCq0TMzv7NL+Nl6iE6z/Y0GjL/mUPjSL3ufJZxamPPnLqgbUXATVkC4hO1n1624hbqZpRcRw8sauBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987733; c=relaxed/simple;
	bh=NEzvoli03+x4g6z/vxg6NhGXukT/wjs6ZBkqJ6uCVPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUYc602VLoxOZhdaXfFx+w7eVMKhbEoZFk+xUTejSs46ZCYLMNLKxn/TSym6gIk+jYPklwwi3rD2c+F2Mh4WtjzzXxBfuXqzuNt1q8oj9i+5kUdzxmlDN9FBaDSOycTQqHgAH4RKDmTBDc6QjtbP55Zai1+xc4ZFUbCRL1tuE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vOa0kOKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8781BC433F1;
	Mon,  1 Apr 2024 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987733;
	bh=NEzvoli03+x4g6z/vxg6NhGXukT/wjs6ZBkqJ6uCVPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOa0kOKDMel7EqlOAIzS996qS7bM1JI0SBMkGa2QUh9JgZGE7bt1qqb5JsciaRxLu
	 3locddjW+VYbgaojW59Ty23Rd1+9Jd+HbhT/0X6rt+d3ELbhtTK9GApdZgTzrdZJAS
	 SgeWYYtbF8rvonOa5WSZsMUlKxOSVxSc/VjjYlHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 6.8 375/399] usb: typec: ucsi_acpi: Refactor and fix DELL quirk
Date: Mon,  1 Apr 2024 17:45:41 +0200
Message-ID: <20240401152600.373342298@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <lk@c--e.de>

commit 6aaceb7d9cd00f3e065dc4b054ecfe52c5253b03 upstream.

Some DELL systems don't like UCSI_ACK_CC_CI commands with the
UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
bit set. The current quirk still leaves room for races because
it requires two consecutive ACK commands to be sent.

Refactor and significantly simplify the quirk to fix this:
Send a dummy command and bundle the connector change ack with the
command completion ack in a single UCSI_ACK_CC_CI command.
This removes the need to probe for the quirk.

While there define flag bits for struct ucsi_acpi->flags in ucsi_acpi.c
and don't re-use definitions from ucsi.h for struct ucsi->flags.

Fixes: f3be347ea42d ("usb: ucsi_acpi: Quirk to ack a connector change ack cmd")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Link: https://lore.kernel.org/r/20240320073927.1641788-5-lk@c--e.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c |   71 ++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -23,10 +23,11 @@ struct ucsi_acpi {
 	void *base;
 	struct completion complete;
 	unsigned long flags;
+#define UCSI_ACPI_SUPPRESS_EVENT	0
+#define UCSI_ACPI_COMMAND_PENDING	1
+#define UCSI_ACPI_ACK_PENDING		2
 	guid_t guid;
 	u64 cmd;
-	bool dell_quirk_probed;
-	bool dell_quirk_active;
 };
 
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
@@ -79,9 +80,9 @@ static int ucsi_acpi_sync_write(struct u
 	int ret;
 
 	if (ack)
-		set_bit(ACK_PENDING, &ua->flags);
+		set_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
 	else
-		set_bit(COMMAND_PENDING, &ua->flags);
+		set_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
 
 	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
 	if (ret)
@@ -92,9 +93,9 @@ static int ucsi_acpi_sync_write(struct u
 
 out_clear_bit:
 	if (ack)
-		clear_bit(ACK_PENDING, &ua->flags);
+		clear_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
 	else
-		clear_bit(COMMAND_PENDING, &ua->flags);
+		clear_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
 
 	return ret;
 }
@@ -129,51 +130,40 @@ static const struct ucsi_operations ucsi
 };
 
 /*
- * Some Dell laptops expect that an ACK command with the
- * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
- * ACK command that only has the UCSI_ACK_COMMAND_COMPLETE bit set.
- * If this is not done events are not delivered to OSPM and
- * subsequent commands will timeout.
+ * Some Dell laptops don't like ACK commands with the
+ * UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
+ * bit set. To work around this send a dummy command and bundle the
+ * UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
+ * for the dummy command.
  */
 static int
 ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
 		     const void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	u64 cmd = *(u64 *)val, ack = 0;
+	u64 cmd = *(u64 *)val;
+	u64 dummycmd = UCSI_GET_CAPABILITY;
 	int ret;
 
-	if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
-	    cmd & UCSI_ACK_CONNECTOR_CHANGE)
-		ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
+	if (cmd == (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE)) {
+		cmd |= UCSI_ACK_COMMAND_COMPLETE;
 
-	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
-	if (ret != 0)
-		return ret;
-	if (ack == 0)
-		return ret;
-
-	if (!ua->dell_quirk_probed) {
-		ua->dell_quirk_probed = true;
+		/*
+		 * The UCSI core thinks it is sending a connector change ack
+		 * and will accept new connector change events. We don't want
+		 * this to happen for the dummy command as its response will
+		 * still report the very event that the core is trying to clear.
+		 */
+		set_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
+		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &dummycmd,
+					   sizeof(dummycmd));
+		clear_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
 
-		cmd = UCSI_GET_CAPABILITY;
-		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
-					   sizeof(cmd));
-		if (ret == 0)
-			return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
-						    &ack, sizeof(ack));
-		if (ret != -ETIMEDOUT)
+		if (ret < 0)
 			return ret;
-
-		ua->dell_quirk_active = true;
-		dev_err(ua->dev, "Firmware bug: Additional ACK required after ACKing a connector change.\n");
-		dev_err(ua->dev, "Firmware bug: Enabling workaround\n");
 	}
 
-	if (!ua->dell_quirk_active)
-		return ret;
-
-	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
+	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 }
 
 static const struct ucsi_operations ucsi_dell_ops = {
@@ -209,13 +199,14 @@ static void ucsi_acpi_notify(acpi_handle
 	if (ret)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
+	if (UCSI_CCI_CONNECTOR(cci) &&
+	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
 	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
 		complete(&ua->complete);
 	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(COMMAND_PENDING, &ua->flags))
+	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
 		complete(&ua->complete);
 }
 



