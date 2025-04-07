Return-Path: <stable+bounces-128600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298AEA7E9AB
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96ACF188E13D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AF253B5E;
	Mon,  7 Apr 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKcv9nm1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802821B9E5;
	Mon,  7 Apr 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049472; cv=none; b=VHjHhaXIr/r1o3jvOXcu7lhHsXJwx7MSWxHPyLGWNI6+qojmJv7DKUn3jGPJJc9ivHHB7NpDquvfed5EIhKGprihzdtTOaN9riyAc4qTaxKa50RbOWBDOGf99jnWEw/WiyR3fD8eheKQ1KEcLvkifmAKiKMJ8a8Tuw6xQGbGadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049472; c=relaxed/simple;
	bh=JoP37eI154QXI5o4dy1WjsbE8/dB4FiBGagGIPtkntI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPbZ8R/R5CJMDa3XlZ7vhb985oe1nbxQ54Ccr8QHz/IepSedRTNI8ZQZ/kjuYG/NmoUieGQcjmSwErEXjEDM5JTl+n3DeyhL4bnaYiRaDMfnFgwFeckVFtgtXN1ukHrCtxpHU8xkJlBpY32w1dUqUXt9XygKCF6GbL8vBSbFWsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKcv9nm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB98C4CEE7;
	Mon,  7 Apr 2025 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049471;
	bh=JoP37eI154QXI5o4dy1WjsbE8/dB4FiBGagGIPtkntI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKcv9nm1+iBmkZPe+r6JBfFK1nOorX+qeQKVbcG5MXNbFsBpU/qbKg7QrdMj9FRTG
	 B8aWbJiGo9ysKFKJgly7bjWBX+LQhr4qCjma80vpouy2qkCSIs+GW9ry8nuLtwzKZk
	 rbzHp/b2HjcVF/wDDatrog48P62DTPeA1Mi98IPvFWhRDHqiHu9Tl2s3Y3QTQOTjcW
	 /qCCfiyxKwLZoXzhDGyN2x+n4DvpjQ7Zia+qbSXbv7kWbU1hfuIa9a2kHUb/jPNIC6
	 uiGIIWAWTvGAUg7vUBY1j9dCDpx/Whh2d/w0plHh5Qau0fhMfEnzOUESCirXubLxy3
	 73kI5o6XDN78Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	abhishekpandit@chromium.org,
	jthies@google.com,
	akuchynski@chromium.org,
	heikki.krogerus@linux.intel.com,
	bleung@chromium.org,
	lumag@kernel.org,
	pooja.katiyar@intel.com,
	diogo.ivo@tecnico.ulisboa.pt,
	madhu.m@intel.com,
	lk@c--e.de,
	saranya.gopal@intel.com,
	u.kleine-koenig@baylibre.com,
	dan.carpenter@linaro.org,
	mario.limonciello@amd.com,
	gongruiqi1@huawei.com,
	chrome-platform@lists.linux.dev,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 03/31] usb: typec: ucsi: return CCI and message from sync_control callback
Date: Mon,  7 Apr 2025 14:10:19 -0400
Message-Id: <20250407181054.3177479-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 667ecac55861281c1f5e107c8550ae893b3984f6 ]

Some of the drivers emulate or handle some of the commands in the
platform-specific way. The code ends up being split between several
callbacks, which complicates emulation.

In preparation to reworking such drivers, move read_cci() and
read_message_in() calls into ucsi_sync_control_common().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://lore.kernel.org/r/20250120-ucsi-merge-commands-v2-1-462a1ec22ecc@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/cros_ec_ucsi.c |  5 +++--
 drivers/usb/typec/ucsi/ucsi.c         | 19 +++++++++++--------
 drivers/usb/typec/ucsi/ucsi.h         |  6 ++++--
 drivers/usb/typec/ucsi/ucsi_acpi.c    |  5 +++--
 drivers/usb/typec/ucsi/ucsi_ccg.c     |  5 +++--
 5 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
index c605c86167268..744f0709a40ed 100644
--- a/drivers/usb/typec/ucsi/cros_ec_ucsi.c
+++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
@@ -105,12 +105,13 @@ static int cros_ucsi_async_control(struct ucsi *ucsi, u64 cmd)
 	return 0;
 }
 
-static int cros_ucsi_sync_control(struct ucsi *ucsi, u64 cmd)
+static int cros_ucsi_sync_control(struct ucsi *ucsi, u64 cmd, u32 *cci,
+				  void *data, size_t size)
 {
 	struct cros_ucsi_data *udata = ucsi_get_drvdata(ucsi);
 	int ret;
 
-	ret = ucsi_sync_control_common(ucsi, cmd);
+	ret = ucsi_sync_control_common(ucsi, cmd, cci, data, size);
 	switch (ret) {
 	case -EBUSY:
 		/* EC may return -EBUSY if CCI.busy is set.
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2a2915b0a645f..e8c7e9dc49309 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -55,7 +55,8 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 }
 EXPORT_SYMBOL_GPL(ucsi_notify_common);
 
-int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
+int ucsi_sync_control_common(struct ucsi *ucsi, u64 command, u32 *cci,
+			     void *data, size_t size)
 {
 	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
 	int ret;
@@ -80,6 +81,13 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
 	else
 		clear_bit(COMMAND_PENDING, &ucsi->flags);
 
+	if (!ret && cci)
+		ret = ucsi->ops->read_cci(ucsi, cci);
+
+	if (!ret && data &&
+	    (*cci & UCSI_CCI_COMMAND_COMPLETE))
+		ret = ucsi->ops->read_message_in(ucsi, data, size);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
@@ -95,7 +103,7 @@ static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 		ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
 	}
 
-	return ucsi->ops->sync_control(ucsi, ctrl);
+	return ucsi->ops->sync_control(ucsi, ctrl, NULL, NULL, 0);
 }
 
 static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
@@ -108,9 +116,7 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 	if (size > UCSI_MAX_DATA_LENGTH(ucsi))
 		return -EINVAL;
 
-	ret = ucsi->ops->sync_control(ucsi, command);
-	if (ucsi->ops->read_cci(ucsi, cci))
-		return -EIO;
+	ret = ucsi->ops->sync_control(ucsi, command, cci, data, size);
 
 	if (*cci & UCSI_CCI_BUSY)
 		return ucsi_run_command(ucsi, UCSI_CANCEL, cci, NULL, 0, false) ?: -EBUSY;
@@ -127,9 +133,6 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 	else
 		err = 0;
 
-	if (!err && data && UCSI_CCI_LENGTH(*cci))
-		err = ucsi->ops->read_message_in(ucsi, data, size);
-
 	/*
 	 * Don't ACK connection change if there was an error.
 	 */
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 28780acc4af2e..892bcf8dbcd50 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -79,7 +79,8 @@ struct ucsi_operations {
 	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
 	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
 	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
-	int (*sync_control)(struct ucsi *ucsi, u64 command);
+	int (*sync_control)(struct ucsi *ucsi, u64 command, u32 *cci,
+			    void *data, size_t size);
 	int (*async_control)(struct ucsi *ucsi, u64 command);
 	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
 				struct ucsi_altmode *updated);
@@ -531,7 +532,8 @@ void ucsi_altmode_update_active(struct ucsi_connector *con);
 int ucsi_resume(struct ucsi *ucsi);
 
 void ucsi_notify_common(struct ucsi *ucsi, u32 cci);
-int ucsi_sync_control_common(struct ucsi *ucsi, u64 command);
+int ucsi_sync_control_common(struct ucsi *ucsi, u64 command, u32 *cci,
+			     void *data, size_t size);
 
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 int ucsi_register_port_psy(struct ucsi_connector *con);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index ac1ebb5d95272..0ac6e5ce4a288 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -128,12 +128,13 @@ static int ucsi_gram_read_message_in(struct ucsi *ucsi, void *val, size_t val_le
 	return ret;
 }
 
-static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
+static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
+				  void *data, size_t size)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
 
-	ret = ucsi_sync_control_common(ucsi, command);
+	ret = ucsi_sync_control_common(ucsi, command, cci, data, size);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 4b1668733a4be..254c391618521 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -628,7 +628,8 @@ static int ucsi_ccg_async_control(struct ucsi *ucsi, u64 command)
 	return ccg_write(uc, reg, (u8 *)&command, sizeof(command));
 }
 
-static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
+static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
+				 void *data, size_t size)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	struct ucsi_connector *con;
@@ -652,7 +653,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 		ucsi_ccg_update_set_new_cam_cmd(uc, con, &command);
 	}
 
-	ret = ucsi_sync_control_common(ucsi, command);
+	ret = ucsi_sync_control_common(ucsi, command, cci, data, size);
 
 err_put:
 	pm_runtime_put_sync(uc->dev);
-- 
2.39.5


