Return-Path: <stable+bounces-56593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713E924524
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B32D1C20D41
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B941BE858;
	Tue,  2 Jul 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="irBIkE2B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A401BE257;
	Tue,  2 Jul 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940699; cv=none; b=H8MNSf4vMsot0G2VCt/yB/rixSupcSzDTLTGGy2Tobo3hjOBc79EogD6P/GLRYzfKNJNJfdht46opD6CZZ+cM9Jxjk3O54XDB9zpxBMXqRkOZaW6DRCkiKJIooBMZVykEoqOVBKiZoktRuflB0QOYmgD/PuoxE3CBOzPLWw5dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940699; c=relaxed/simple;
	bh=HG9843NN4s8eIwd/UPv1IC5b2ei3PZDKr/yAP/E+7F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBxWpyqff3pOF385yI9XYbZOhnfU0ssoSvNevN+If+/NzAaVR0IRbZXcbChBHMMXqdQRGfJXwVCB4lXlSUK+HpgDwuAQQYT9f1X6Jxyh3aazeAmwt0w/ujbRcu8zfpL7yLIMEIcIXxhtmxU29odazfkvRGPGffrO3/xwdgjbMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=irBIkE2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C642BC4AF07;
	Tue,  2 Jul 2024 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940699;
	bh=HG9843NN4s8eIwd/UPv1IC5b2ei3PZDKr/yAP/E+7F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irBIkE2BCxOxlKlfxQg9bBOnMVgpjoB1NJwoOGcyvff5fu3KoyjLgwY5hK/S40L/U
	 Nb4zCtrLeIAjj8jLxos7eNkepNmD3E283zWOdmWg+qrpiZPYRKHPgimw/stlg/n+vQ
	 78hz95qNrqIXgxcNRgpsytbMcbY+1+Yj1td/ejio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/163] usb: typec: ucsi: Never send a lone connector change ack
Date: Tue,  2 Jul 2024 19:01:57 +0200
Message-ID: <20240702170233.181685116@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <lk@c--e.de>

[ Upstream commit de52aca4d9d56c3b2f00b638d457075914b1a227 ]

Some PPM implementation do not like UCSI_ACK_CONNECTOR_CHANGE
without UCSI_ACK_COMMAND_COMPLETE. Moreover, doing this is racy
as it requires sending two UCSI_ACK_CC_CI commands in a row and
the second one will be started with UCSI_CCI_ACK_COMPLETE already
set in CCI.

Bundle the UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
for the UCSI_GET_CONNECTOR_STATUS command that is sent while
handling a connector change event.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240327224554.1772525-3-lk@c--e.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8bdf8a42bca4 ("usb: typec: ucsi: Ack also failed Get Error commands")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 48 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7f575b9b3debe..9b0ad06db6dab 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -49,22 +49,16 @@ static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
 	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
 }
 
-static int ucsi_acknowledge_command(struct ucsi *ucsi)
+static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
 
 	ctrl = UCSI_ACK_CC_CI;
 	ctrl |= UCSI_ACK_COMMAND_COMPLETE;
-
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
-}
-
-static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
-{
-	u64 ctrl;
-
-	ctrl = UCSI_ACK_CC_CI;
-	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
+	if (conn_ack) {
+		clear_bit(EVENT_PENDING, &ucsi->flags);
+		ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
+	}
 
 	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
 }
@@ -77,7 +71,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	int ret;
 
 	/* Acknowledge the command that failed */
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, false);
 	if (ret)
 		return ret;
 
@@ -89,7 +83,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	if (ret)
 		return ret;
 
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, false);
 	if (ret)
 		return ret;
 
@@ -152,7 +146,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 		return -EIO;
 
 	if (cci & UCSI_CCI_NOT_SUPPORTED) {
-		if (ucsi_acknowledge_command(ucsi) < 0)
+		if (ucsi_acknowledge(ucsi, false) < 0)
 			dev_err(ucsi->dev,
 				"ACK of unsupported command failed\n");
 		return -EOPNOTSUPP;
@@ -165,15 +159,15 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	}
 
 	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
-		ret = ucsi_acknowledge_command(ucsi);
+		ret = ucsi_acknowledge(ucsi, false);
 		return ret ? ret : -EBUSY;
 	}
 
 	return UCSI_CCI_LENGTH(cci);
 }
 
-int ucsi_send_command(struct ucsi *ucsi, u64 command,
-		      void *data, size_t size)
+static int ucsi_send_command_common(struct ucsi *ucsi, u64 command,
+				    void *data, size_t size, bool conn_ack)
 {
 	u8 length;
 	int ret;
@@ -192,7 +186,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 			goto out;
 	}
 
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, conn_ack);
 	if (ret)
 		goto out;
 
@@ -201,6 +195,12 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 	mutex_unlock(&ucsi->ppm_lock);
 	return ret;
 }
+
+int ucsi_send_command(struct ucsi *ucsi, u64 command,
+		      void *data, size_t size)
+{
+	return ucsi_send_command_common(ucsi, command, data, size, false);
+}
 EXPORT_SYMBOL_GPL(ucsi_send_command);
 
 /* -------------------------------------------------------------------------- */
@@ -886,7 +886,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	mutex_lock(&con->lock);
 
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(ucsi, command, &con->status, sizeof(con->status));
+
+	ret = ucsi_send_command_common(ucsi, command, &con->status,
+				       sizeof(con->status), true);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
 			__func__, ret);
@@ -938,14 +940,6 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
 
-	mutex_lock(&ucsi->ppm_lock);
-	clear_bit(EVENT_PENDING, &con->ucsi->flags);
-	ret = ucsi_acknowledge_connector_change(ucsi);
-	mutex_unlock(&ucsi->ppm_lock);
-
-	if (ret)
-		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
-
 out_unlock:
 	mutex_unlock(&con->lock);
 }
-- 
2.43.0




