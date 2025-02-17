Return-Path: <stable+bounces-116563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AEFA380F3
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857CA3B61B1
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A885218AAA;
	Mon, 17 Feb 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc5HlNTO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C821771D;
	Mon, 17 Feb 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789787; cv=none; b=MY87s/p4Nulqqr6/xRdiEGOfunTFBPA0gSofcecfGkwBxBCfNy6bnzTXkmfUSDnXYory2o+Pvf+0dqXKrtVaba9adf63Uxpt6frf0EONKPsLJJcoKco1uGytDSZcBa6iMFNh5+UuGJB1uDcIEa8d737C94Wi+JM0Epzeswz354k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789787; c=relaxed/simple;
	bh=g6XUoDbtOOrLMmlRcVU9S96CHR9EodhpFMZEOvyWlQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qScnay0TxKJqwbpRW8xKoGk0YhR0YJ9vLNZgLlTTZndDoi1FEEve18j33hRyuMlBHBTUXyu1c/DIfCbGcoaQkyfh+IQoVod4g9xe9IxcwhwhcH03H7b00W6wr2JzMrMtzH/vEM3k3l/mEvtaE1QEAOy5tZoXXqSes35hBX1+8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc5HlNTO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so8954971fa.0;
        Mon, 17 Feb 2025 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789783; x=1740394583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3By9sonPtM2Kb9JLhuZt9Vr+3R8iGYJK7cqIfDuA4c=;
        b=gc5HlNTOx+6QdyYw3S/zJ3uJn06dO0jdYv0EkeTSfv6PeLLRn8wn9arlX84xOuOpSf
         ++C+dNf5QHDFqFZ5CP4lb4R/IuKpnDM/Mc8Zo7f0MOFcmjY2defjf35FMpRrvHtk7xE+
         +xEdeHBntTBL4vqycDBTxRTqWTZLAHQ+Y8QLC8l9CAnWMybpn7uxg+hMrkijYKweIhRN
         pPSwlGFaqXImueMwKmWPqokjaSBnaAp5/7kPq0lIaTIPRT3CGNNHoyq+y7REckdaRoLR
         lTJtBIfpFci0cZRLFe+z41GGwFgLspHEI6fj3ACc3ZCQ7rXFzTPLtktgv3euapriRpPn
         vcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789783; x=1740394583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3By9sonPtM2Kb9JLhuZt9Vr+3R8iGYJK7cqIfDuA4c=;
        b=TZfy4ib672Xackw95joGYGm1czk7tkYPwEE8GhOvTbb55QuvZy7JQ2cwnUL3uJXAQa
         ZZMX/5dQsou5TKOZtxkxHZx3N8nYMmmiQqKe/GwVmd+54fXGc+d4rwFNrgUVlCNEA+vC
         ZfsuPru+yiQh6o2Cm51RF2C5oJd0AdMdeTgmOpZBoLDOMTos8/MOghhOHD3BXVrTSJxP
         pV5I7+jAWHdps9/CIIiPUHktLjxolKGkTSQ6ndvufnQXRkMyVMVkYnvuPh6xKLEaJzBE
         XnsF4SQZ1mnBnhsc+do210yBtyRx3FA0yzcKh22SqpZurjw8k8mkG/l/y7Y+QGtVCscm
         B2mg==
X-Forwarded-Encrypted: i=1; AJvYcCVOI6iNv/U/EKn78AB8ZewvK0AYGbYNejPbu/u4B3mhSl/t+R7g1gUgASn6og1jLEbrO4umpcYR5taK@vger.kernel.org, AJvYcCW9oo3FCm26PkHzgyWD12bp+Yf8Ko1bu6d4UAueRhC0jcjSl5vIY26kkUNUmXmrOnqnWzgJ8QU2zaOs2Lk=@vger.kernel.org, AJvYcCWw19n690DbB62aqWs9+72eVOj122jy9pGl2B2Ww0CySL2dUYSrrc+k/IJ3tzRFCOxPq80MDnEB@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmDmADWgZR0HttsKAgf4BbynOjkT9FAMEphg14NivupwNLPVN
	1iT+5P1JJSCp7sz8QbyuTEAXHVxLAsL7UNnjd+BC1MMpY0OPCJiy
X-Gm-Gg: ASbGncvHPk/cGwnXK69QRHVg7aWTGx70JKklmxjaK53VjybcscXMU0bin/ST1s1IUSL
	gjpvpkvrsejoTDhiievPq3whpwRVi2ffluZPEYW+gWuYvILnH0Wm4R3Uuah9IFnCzXfIVzUNQJS
	c0kixNdNek+YF4v4ezaNecXg4kQh/cA0pvZ3jAeTtXnbr8C+NKrz5x2T94+nN7RiOK+OMF39mMG
	z3w2qJrNHHPOPFLPwgCViwqucIebwm+7zoYR18LBmwDoWqLuFsX5dCfR12jj5BfJsLKaUU7u6z0
	taa/zntAq5L06GGBAzc7n5VRS1NotpjRR7zeb9u97w==
X-Google-Smtp-Source: AGHT+IHZaKIxxXRv+f2gUlLAI1aAgaeiroHrpF+ooCK6WJAzTEDixVjJFJDOVb3UMRQSpWtS093kBg==
X-Received: by 2002:a05:6512:15aa:b0:545:646:7522 with SMTP id 2adb3069b0e04-5452fdb44f7mr3001652e87.0.1739789782928;
        Mon, 17 Feb 2025 02:56:22 -0800 (PST)
Received: from fedora.intra.ispras.ru (morra.ispras.ru. [83.149.199.253])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452b496aafsm1157086e87.29.2025.02.17.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:56:22 -0800 (PST)
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fedor Pchelkin <boddah8794@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] acpi: typec: ucsi: Introduce a ->poll_cci method
Date: Mon, 17 Feb 2025 13:54:39 +0300
Message-ID: <20250217105442.113486-2-boddah8794@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217105442.113486-1-boddah8794@gmail.com>
References: <20250217105442.113486-1-boddah8794@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Christian A. Ehrhardt" <lk@c--e.de>

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
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Tested-by: Fedor Pchelkin <boddah8794@gmail.com>
Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Add the explicit WARNING splat and slightly increase the length of text
lines in the changelog.
Original patch: https://lore.kernel.org/linux-usb/Z2Cf1AI8CXao5ZAn@cae.in-ulm.de/

Add Heikki's Reviewed-by tag.

 drivers/usb/typec/ucsi/ucsi.c           | 10 +++++-----
 drivers/usb/typec/ucsi/ucsi.h           |  2 ++
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 21 ++++++++++++++-------
 drivers/usb/typec/ucsi/ucsi_ccg.c       |  1 +
 drivers/usb/typec/ucsi/ucsi_glink.c     |  1 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   |  1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c |  1 +
 7 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index fcf499cc9458..0fe1476f4c29 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1346,7 +1346,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->read_cci(ucsi, &cci);
+	ret = ucsi->ops->poll_cci(ucsi, &cci);
 	if (ret < 0)
 		goto out;
 
@@ -1364,7 +1364,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
 		do {
-			ret = ucsi->ops->read_cci(ucsi, &cci);
+			ret = ucsi->ops->poll_cci(ucsi, &cci);
 			if (ret < 0)
 				goto out;
 			if (cci & UCSI_CCI_COMMAND_COMPLETE)
@@ -1393,7 +1393,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 		/* Give the PPM time to process a reset before reading CCI */
 		msleep(20);
 
-		ret = ucsi->ops->read_cci(ucsi, &cci);
+		ret = ucsi->ops->poll_cci(ucsi, &cci);
 		if (ret)
 			goto out;
 
@@ -1929,8 +1929,8 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	struct ucsi *ucsi;
 
 	if (!ops ||
-	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
-	    !ops->sync_control || !ops->async_control)
+	    !ops->read_version || !ops->read_cci || !ops->poll_cci ||
+	    !ops->read_message_in || !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 82735eb34f0e..28780acc4af2 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -62,6 +62,7 @@ struct dentry;
  * struct ucsi_operations - UCSI I/O operations
  * @read_version: Read implemented UCSI version
  * @read_cci: Read CCI register
+ * @poll_cci: Read CCI register while polling with notifications disabled
  * @read_message_in: Read message data from UCSI
  * @sync_control: Blocking control operation
  * @async_control: Non-blocking control operation
@@ -76,6 +77,7 @@ struct dentry;
 struct ucsi_operations {
 	int (*read_version)(struct ucsi *ucsi, u16 *version);
 	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
+	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
 	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
 	int (*sync_control)(struct ucsi *ucsi, u64 command);
 	int (*async_control)(struct ucsi *ucsi, u64 command);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 5c5515551963..ac1ebb5d9527 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -59,19 +59,24 @@ static int ucsi_acpi_read_version(struct ucsi *ucsi, u16 *version)
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
@@ -94,6 +99,7 @@ static int ucsi_acpi_async_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_acpi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_acpi_async_control
@@ -142,6 +148,7 @@ static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_gram_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_gram_read_message_in,
 	.sync_control = ucsi_gram_sync_control,
 	.async_control = ucsi_acpi_async_control
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 740171f24ef9..4b1668733a4b 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -664,6 +664,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_ccg_ops = {
 	.read_version = ucsi_ccg_read_version,
 	.read_cci = ucsi_ccg_read_cci,
+	.poll_cci = ucsi_ccg_read_cci,
 	.read_message_in = ucsi_ccg_read_message_in,
 	.sync_control = ucsi_ccg_sync_control,
 	.async_control = ucsi_ccg_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index fed39d458090..8af79101a2fc 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -206,6 +206,7 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read_version = pmic_glink_ucsi_read_version,
 	.read_cci = pmic_glink_ucsi_read_cci,
+	.poll_cci = pmic_glink_ucsi_read_cci,
 	.read_message_in = pmic_glink_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = pmic_glink_ucsi_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 6923fad31d79..57ef7d83a412 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -424,6 +424,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.read_version = ucsi_stm32g0_read_version,
 	.read_cci = ucsi_stm32g0_read_cci,
+	.poll_cci = ucsi_stm32g0_read_cci,
 	.read_message_in = ucsi_stm32g0_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_stm32g0_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index 4cae85c0dc12..d33e3f2dd1d8 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -74,6 +74,7 @@ static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read_version = yoga_c630_ucsi_read_version,
 	.read_cci = yoga_c630_ucsi_read_cci,
+	.poll_cci = yoga_c630_ucsi_read_cci,
 	.read_message_in = yoga_c630_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = yoga_c630_ucsi_async_control,
-- 
2.48.1


