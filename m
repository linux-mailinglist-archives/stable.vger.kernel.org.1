Return-Path: <stable+bounces-114164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF005A2B17C
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06C9188431B
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4419CD13;
	Thu,  6 Feb 2025 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkztWE5L"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3419CCF5;
	Thu,  6 Feb 2025 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867440; cv=none; b=jcm01Zo192+lvHMDDi26r5+l2WRBZWr5oQhMHTk+NvUY/3W9Z/YyYqv9AqhzAtFN4lMEnJoOl1mSksTsQly6251i/T6z66oeh4NTlzgELDmHB6dsoWZqKsuJZ0tomled8aZu5vamfJpmiDTwPuhCZsjL12+W0W5v+GwyBVKsENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867440; c=relaxed/simple;
	bh=VPe4UJJcpjekVm25gnlpFuv4nVzcY1hdRs2dtDlJh5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3iOHEZ6i9y49LoUS2fGrE3eU+CMaCaay3QJ2XQ6ozjGYBgLBD3K8OJy2Hlx2De/gizbn4YD/98684BlmBUROMgsoFqRgQ+86wcVnSIl5iZMVn8ZqeKVn0DlDE8SNJAPMqqSfHpSYckK/ImRWWOtuSD8pW/ZNh3dMGlgUyHssBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkztWE5L; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30797730cbdso12250811fa.3;
        Thu, 06 Feb 2025 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867437; x=1739472237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSz55NNBL/wEB/+zq8CAk9tThzNZKLGSMn0AQs8qIXo=;
        b=EkztWE5Lp1AgMxG0ZOnaFEl9rFjYJXftzKRmq/t3TpSDSMYbX0HfGbaXSevaGEvAOR
         RS+5JMOWBDCsyW7wwi9poR1bGsIhCxVpx5aM9QaGwDJhLhzeBbKY1+2byvk7f5KeR96A
         iA6xX1th4P9YBesK6xu/rKrGu+i/9kqMGep+pbtVQzPcHn65QaXD+WHMfmmbwD//o3X9
         GhRWokoZZRO+uxhsJGEU7swtbr37qHIe8PRC+jui3xwthbQ1Zfq8juMJiMa4KKEIFbHM
         er2vz6z4kll6SLwQ/ZgiurDdWAmDDTXJqgJfQzfeDqq88jBtmFk6PPRBk3pDmowm/tUU
         7QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867437; x=1739472237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSz55NNBL/wEB/+zq8CAk9tThzNZKLGSMn0AQs8qIXo=;
        b=j5P/sC9dlcriBn3xZpy90Gtp8H3bs99seeMkGex7A2V+zDCLDIEtYaGhQCFH/Okl+8
         rjwJDLIikVO3sD3gk/1bJybZe2/2X2gOzRMtH4XlOUJTTnFd199eCmvj6HJfZ71f8KQT
         0MliIwH7qb8pJwqi8BgjozqpHDuM/wrR8VFo7hgjd435CdkRx454m7Ny7b8Waj/x/2K7
         AyBcT7MQUeDY5tggyBxI603K0KVkXUA3T6XiBoRHtqhnhlMHKXENR3dPf1XMqdg1GCKl
         Flpg6jgLmCeERHNJ/9E/yZft9boajO5N1c813SB9lrjthBWCZ86lApSNhS4rKy5qDSNT
         v7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWetuesIi7v9NzOS1pHn5+ZLopHPURjGVpQo6hVCcP1ZWvW2SbauxW0CPFR4rEQ3PnGol/yoxer@vger.kernel.org, AJvYcCWyTMWRgECCF9yv/GfeJvLAv0DD8CDxwBpKKx3uDz+wgR5PGoSxGKqcRGlUk1JBOACwWN8iSnc/AJbW@vger.kernel.org, AJvYcCXzApZThNqrEpyx6wLAxZJES3Ia/7HWcJmVTavutDMpQkNng7R/RlFqAo153Qrjuld8ffK2GTc2NzcLHl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhCDtWf0/PKFKKE/xLai5J4jB2D04lvtTK3PhrQRWLhaC7yF2
	WQNO2hUb1PJQLyp+Y02zuJhjLgQHkTDCzrPQCUWQnPt/NpT8xPly
X-Gm-Gg: ASbGncstpykWycqgLhbJ94Q1SRwQ9L3uWSKnk0XgM+uZP2cpXcGVttXwpV8+DuAIIZR
	NZUTAEqMrvesrMkL6Obrc0buhnGylQTkCQ13mEnd+q2rDOet50Pp7dFl2uSfiYlipxFBXiLWEXy
	ExUn5GEHCuskUJTI2X6FSqOqZgeHOgZ8jf/RpkkFyWJM+eOhgY/pZ8ZGIQCK9VwRQ7qBf0H86QN
	vMWyv7hdUYxUqmrVedjlmzO4KszjIOn7z4pU6euKbzRJvjZl3lg1NetIivQjDMbJRCM6cCehTyp
	bg+YR+ATSQ/hAnfQmf9eHk9B3CHS9OrDxXZeLw6qGRSuubOBKpvIRA==
X-Google-Smtp-Source: AGHT+IElyC2jVmeR7BzH1KpwsN3wlI42ippMtkEeAeDRj5504+O6/v3Y72ZOF5SYnyC6OcKQNHMP9g==
X-Received: by 2002:ac2:544a:0:b0:544:e86:e60e with SMTP id 2adb3069b0e04-5440e87025emr1306437e87.41.1738867436362;
        Thu, 06 Feb 2025 10:43:56 -0800 (PST)
Received: from fedora.. (broadband-5-228-116-177.ip.moscow.rt.ru. [5.228.116.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-544105f31b8sm198394e87.204.2025.02.06.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:43:56 -0800 (PST)
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Cc: Fedor Pchelkin <boddah8794@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: [PATCH RFC 1/2] acpi: typec: ucsi: Introduce a ->poll_cci method
Date: Thu,  6 Feb 2025 21:43:14 +0300
Message-ID: <20250206184327.16308-2-boddah8794@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206184327.16308-1-boddah8794@gmail.com>
References: <20250206184327.16308-1-boddah8794@gmail.com>
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
---
Add the explicit WARNING splat and slightly increase the length of text
lines in the changelog.
Original patch: https://lore.kernel.org/linux-usb/Z2Cf1AI8CXao5ZAn@cae.in-ulm.de/

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


