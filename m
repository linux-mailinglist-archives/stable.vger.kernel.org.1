Return-Path: <stable+bounces-92485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8600A9C5465
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E031F22329
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829221832B;
	Tue, 12 Nov 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASweUF2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C7218D7A;
	Tue, 12 Nov 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407783; cv=none; b=kJ3RdE6jm3z1LpxbFwg2b/hISnTiKzWJVK8avfMNeC4qFZNw2C3olKlyHEm8qZyca0GAYn/LuiHApF3tBLpyrXL1Q3JVS/ABamHUqAzosRaZV/pGVHY3rWxXaaHG73wyjL/V+8SuzSE0J1TG4isXT/HQbQQHWTutphUsOcov+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407783; c=relaxed/simple;
	bh=d+QKuLOd6xlok56LvzraO6xjRjR2hmolkonxh59cC8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyedfCjOfdWEdsQKolNumqoXB4gIv7SsBBPx81QwT9QXkl9zofC+3ISEyqmeInBecE3js7q7TUNU1FKQ6rFXUyGK667/CiN7mog7UgS7XlFgIqcQSExs5/m2Dcbt4ADz7ih/GV6MwKpU+Oh5lNdKQ9/AZPAkGuyZL+PtNnWHO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASweUF2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A30FC4CECD;
	Tue, 12 Nov 2024 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407783;
	bh=d+QKuLOd6xlok56LvzraO6xjRjR2hmolkonxh59cC8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASweUF2sQtwr36cC2iD3fyq3GqujTi8xh6OxNyLO1awfkbmGxZLZvJlbqTs0Edvcv
	 TN+rk8yJanoPukVHSBR4OF63wQyeaAXAg/2LxRR5etpI2YLjSRJb+O1dJNvl3I0p3P
	 mVfUtQS2zOrbwAPYExzS+P6FZ/PjIUMg/A9OjpeR18Iu7cb9V7V+QockMP8Uad3rLc
	 ndOSjbub1LvQn0ipV6TpOS5eukKr815e+jGSOJL6iShVRmmXsoRdYGWg+ibmtRrnYd
	 Tg4GRj3Whie0uDvO2sl2fziTU8eY92QEgxPBgDU8UAKRwY34MZmo8/jqy7a4zLnuMr
	 n43LQphXJSPPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vishnu Sankar <vishnuocv@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	hmh@hmh.eng.br,
	ilpo.jarvinen@linux.intel.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 10/16] platform/x86: thinkpad_acpi: Fix for ThinkPad's with ECFW showing incorrect fan speed
Date: Tue, 12 Nov 2024 05:35:52 -0500
Message-ID: <20241112103605.1652910-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit

From: Vishnu Sankar <vishnuocv@gmail.com>

[ Upstream commit 1be765b292577c752e0b87bf8c0e92aff6699d8e ]

Fix for Thinkpad's with ECFW showing incorrect fan speed. Some models use
decimal instead of hexadecimal for the speed stored in the EC registers.
For example the rpm register will have 0x4200 instead of 0x1068, here
the actual RPM is "4200" in decimal.

Add a quirk to handle this.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/20241105235505.8493-1-vishnuocv@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f269ca1ff7718..10e04424885eb 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7912,6 +7912,7 @@ static u8 fan_control_resume_level;
 static int fan_watchdog_maxinterval;
 
 static bool fan_with_ns_addr;
+static bool ecfw_with_fan_dec_rpm;
 
 static struct mutex fan_mutex;
 
@@ -8554,7 +8555,11 @@ static ssize_t fan_fan1_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return sysfs_emit(buf, "%u\n", speed);
+	/* Check for fan speeds displayed in hexadecimal */
+	if (!ecfw_with_fan_dec_rpm)
+		return sysfs_emit(buf, "%u\n", speed);
+	else
+		return sysfs_emit(buf, "%x\n", speed);
 }
 
 static DEVICE_ATTR(fan1_input, S_IRUGO, fan_fan1_input_show, NULL);
@@ -8571,7 +8576,11 @@ static ssize_t fan_fan2_input_show(struct device *dev,
 	if (res < 0)
 		return res;
 
-	return sysfs_emit(buf, "%u\n", speed);
+	/* Check for fan speeds displayed in hexadecimal */
+	if (!ecfw_with_fan_dec_rpm)
+		return sysfs_emit(buf, "%u\n", speed);
+	else
+		return sysfs_emit(buf, "%x\n", speed);
 }
 
 static DEVICE_ATTR(fan2_input, S_IRUGO, fan_fan2_input_show, NULL);
@@ -8647,6 +8656,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
+#define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8675,6 +8685,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('R', '1', 'D', TPACPI_FAN_NS),	/* 11e Gen5 GL-R */
 	TPACPI_Q_LNV3('R', '0', 'V', TPACPI_FAN_NS),	/* 11e Gen5 KL-Y */
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
+	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -8715,6 +8726,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		tp_features.fan_ctrl_status_undef = 1;
 	}
 
+	/* Check for the EC/BIOS with RPM reported in decimal*/
+	if (quirks & TPACPI_FAN_DECRPM) {
+		pr_info("ECFW with fan RPM as decimal in EC register\n");
+		ecfw_with_fan_dec_rpm = 1;
+		tp_features.fan_ctrl_status_undef = 1;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
@@ -8926,7 +8944,11 @@ static int fan_read(struct seq_file *m)
 		if (rc < 0)
 			return rc;
 
-		seq_printf(m, "speed:\t\t%d\n", speed);
+		/* Check for fan speeds displayed in hexadecimal */
+		if (!ecfw_with_fan_dec_rpm)
+			seq_printf(m, "speed:\t\t%d\n", speed);
+		else
+			seq_printf(m, "speed:\t\t%x\n", speed);
 
 		if (fan_status_access_mode == TPACPI_FAN_RD_TPEC_NS) {
 			/*
-- 
2.43.0


