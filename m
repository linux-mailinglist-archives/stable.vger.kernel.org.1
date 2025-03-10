Return-Path: <stable+bounces-122164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5BA59E57
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472BB3AB842
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132792309A6;
	Mon, 10 Mar 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FM2xos5b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573C22B8D0;
	Mon, 10 Mar 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627711; cv=none; b=pifZmvrvsw9y/4g66jPuJzKQPyhPHU8wqez/qn/PD28N6Yoqt/NO7dPQBHXLcqrngvrJWNmCdcTcq6TMRq5zT5iSRwBjmsK3Wiq9LBIc30lxNUZ6mksNN8K5fyxYC6abPRngnU+KG6D4m14IVGxC763ZWX3exIUqCcB30tpF0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627711; c=relaxed/simple;
	bh=geCKoQEW9SP6N/xVyenK4/HX8IHxS7nOsFcw2iOqFtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA8NGrZ3TNw1vu5oHNdcbuD5wWsDTM8ZzjSTJTDT76sYDVaTKSx+4gCKUui4xkGTLTM8m18wwr8Q+Pn0ns/M2CdvXi2aRPJslHVwK4YLeyjjXOJJ5njINOiwyeNm5Ec7bBpSZ5IYRzbvrslQHKB/qHAQxWJgdhiWxy0eI23AbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FM2xos5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5378BC4CEE5;
	Mon, 10 Mar 2025 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627711;
	bh=geCKoQEW9SP6N/xVyenK4/HX8IHxS7nOsFcw2iOqFtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FM2xos5bhXrJLOznq4dDFA60G0p7Jyl+mepeEp5r8w3xa52CWVqAmbJWv5Lq5UY2b
	 j5IQDCxSc+sFfHemdEsKohUrIh8wqLao8s4YCQJXj1DVqwvC5QdZr3ZR/2XKAjKmaF
	 MeWMZB/k+yOI2iXZHSlDADsFecvzCG8+NFBLOC8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.12 224/269] acpi: typec: ucsi: Introduce a ->poll_cci method
Date: Mon, 10 Mar 2025 18:06:17 +0100
Message-ID: <20250310170506.609727756@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <lk@c--e.de>

commit 976e7e9bdc7719a023a4ecccd2e3daec9ab20a40 upstream.

For the ACPI backend of UCSI the UCSI "registers" are just a memory copy
of the register values in an opregion. The ACPI implementation in the
BIOS ensures that the opregion contents are synced to the embedded
controller and it ensures that the registers (in particular CCI) are
synced back to the opregion on notifications. While there is an ACPI call
that syncs the actual registers to the opregion there is rarely a need to
do this and on some ACPI implementations it actually breaks in various
interesting ways.

The only reason to force a sync from the embedded controller is to poll
CCI while notifications are disabled. Only the ucsi core knows if this
is the case and guessing based on the current command is suboptimal, i.e.
leading to the following spurious assertion splat:

WARNING: CPU: 3 PID: 76 at drivers/usb/typec/ucsi/ucsi.c:1388 ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi]
CPU: 3 UID: 0 PID: 76 Comm: kworker/3:0 Not tainted 6.12.11-200.fc41.x86_64 #1
Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN45WW 03/17/2023
Workqueue: events_long ucsi_init_work [typec_ucsi]
RIP: 0010:ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi]
Call Trace:
 <TASK>
 ucsi_init_work+0x3c/0xac0 [typec_ucsi]
 process_one_work+0x179/0x330
 worker_thread+0x252/0x390
 kthread+0xd2/0x100
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Thus introduce a ->poll_cci() method that works like ->read_cci() with an
additional forced sync and document that this should be used when polling
with notifications disabled. For all other backends that presumably don't
have this issue use the same implementation for both methods.

Fixes: fa48d7e81624 ("usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read operations")
Cc: stable <stable@kernel.org>
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Tested-by: Fedor Pchelkin <boddah8794@gmail.com>
Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250217105442.113486-2-boddah8794@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c           |   10 +++++-----
 drivers/usb/typec/ucsi/ucsi.h           |    2 ++
 drivers/usb/typec/ucsi/ucsi_acpi.c      |   21 ++++++++++++++-------
 drivers/usb/typec/ucsi/ucsi_ccg.c       |    1 +
 drivers/usb/typec/ucsi/ucsi_glink.c     |    1 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   |    1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c |    1 +
 7 files changed, 25 insertions(+), 12 deletions(-)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1330,7 +1330,7 @@ static int ucsi_reset_ppm(struct ucsi *u
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->read_cci(ucsi, &cci);
+	ret = ucsi->ops->poll_cci(ucsi, &cci);
 	if (ret < 0)
 		goto out;
 
@@ -1348,7 +1348,7 @@ static int ucsi_reset_ppm(struct ucsi *u
 
 		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
 		do {
-			ret = ucsi->ops->read_cci(ucsi, &cci);
+			ret = ucsi->ops->poll_cci(ucsi, &cci);
 			if (ret < 0)
 				goto out;
 			if (cci & UCSI_CCI_COMMAND_COMPLETE)
@@ -1377,7 +1377,7 @@ static int ucsi_reset_ppm(struct ucsi *u
 		/* Give the PPM time to process a reset before reading CCI */
 		msleep(20);
 
-		ret = ucsi->ops->read_cci(ucsi, &cci);
+		ret = ucsi->ops->poll_cci(ucsi, &cci);
 		if (ret)
 			goto out;
 
@@ -1913,8 +1913,8 @@ struct ucsi *ucsi_create(struct device *
 	struct ucsi *ucsi;
 
 	if (!ops ||
-	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
-	    !ops->sync_control || !ops->async_control)
+	    !ops->read_version || !ops->read_cci || !ops->poll_cci ||
+	    !ops->read_message_in || !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -60,6 +60,7 @@ struct dentry;
  * struct ucsi_operations - UCSI I/O operations
  * @read_version: Read implemented UCSI version
  * @read_cci: Read CCI register
+ * @poll_cci: Read CCI register while polling with notifications disabled
  * @read_message_in: Read message data from UCSI
  * @sync_control: Blocking control operation
  * @async_control: Non-blocking control operation
@@ -74,6 +75,7 @@ struct dentry;
 struct ucsi_operations {
 	int (*read_version)(struct ucsi *ucsi, u16 *version);
 	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
+	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
 	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
 	int (*sync_control)(struct ucsi *ucsi, u64 command);
 	int (*async_control)(struct ucsi *ucsi, u64 command);
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -59,19 +59,24 @@ static int ucsi_acpi_read_version(struct
 static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	int ret;
-
-	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
-		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-		if (ret)
-			return ret;
-	}
 
 	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
 
 	return 0;
 }
 
+static int ucsi_acpi_poll_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+	if (ret)
+		return ret;
+
+	return ucsi_acpi_read_cci(ucsi, cci);
+}
+
 static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
@@ -94,6 +99,7 @@ static int ucsi_acpi_async_control(struc
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_acpi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_acpi_async_control
@@ -145,6 +151,7 @@ static int ucsi_gram_sync_control(struct
 static const struct ucsi_operations ucsi_gram_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_gram_read_message_in,
 	.sync_control = ucsi_gram_sync_control,
 	.async_control = ucsi_acpi_async_control
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -664,6 +664,7 @@ err_put:
 static const struct ucsi_operations ucsi_ccg_ops = {
 	.read_version = ucsi_ccg_read_version,
 	.read_cci = ucsi_ccg_read_cci,
+	.poll_cci = ucsi_ccg_read_cci,
 	.read_message_in = ucsi_ccg_read_message_in,
 	.sync_control = ucsi_ccg_sync_control,
 	.async_control = ucsi_ccg_async_control,
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -201,6 +201,7 @@ static void pmic_glink_ucsi_connector_st
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read_version = pmic_glink_ucsi_read_version,
 	.read_cci = pmic_glink_ucsi_read_cci,
+	.poll_cci = pmic_glink_ucsi_read_cci,
 	.read_message_in = pmic_glink_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = pmic_glink_ucsi_async_control,
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -424,6 +424,7 @@ static irqreturn_t ucsi_stm32g0_irq_hand
 static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.read_version = ucsi_stm32g0_read_version,
 	.read_cci = ucsi_stm32g0_read_cci,
+	.poll_cci = ucsi_stm32g0_read_cci,
 	.read_message_in = ucsi_stm32g0_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_stm32g0_async_control,
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -74,6 +74,7 @@ static int yoga_c630_ucsi_async_control(
 const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read_version = yoga_c630_ucsi_read_version,
 	.read_cci = yoga_c630_ucsi_read_cci,
+	.poll_cci = yoga_c630_ucsi_read_cci,
 	.read_message_in = yoga_c630_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = yoga_c630_ucsi_async_control,



