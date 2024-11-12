Return-Path: <stable+bounces-92534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FFB9C572F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE26B26F0D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3012259C6;
	Tue, 12 Nov 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srcSC2l6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612822461F;
	Tue, 12 Nov 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407851; cv=none; b=oPWvIJN2ZzQd4qFFUc0R2+9cALZAoi91KAxDDDpeGazbtl+hDO+fCedsd3Rdy33IRuu7gv+Akt4agVcLSJjK4i4WBfX/CXABt+3u/jrqL8j5CoDJSxbhBtUVidjsQAB9a60seBGvIRuihyBXbRmWAOemYwZBZ1HX2SOcVCTZNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407851; c=relaxed/simple;
	bh=6oXqxVNzb22esr4Pq/c2HABoV5wcIRYCadwjZZPLfiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLDKrXx8iHDcKqMx5esEQhDtUFOQ502Bu08tAVNyqjT0k95exo8d9mg5hD1a8iZ0dDN7Y3MDhfJCa5JVaqW2uzCH7C7jqX2gekdheDi6Mb87FMzlKZo9tXAWsR+AFvMRxbL0e/o0LXi6KFiCVAKbFV1XS82bheGMzzn6jti1DkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srcSC2l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529F6C4CED7;
	Tue, 12 Nov 2024 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407851;
	bh=6oXqxVNzb22esr4Pq/c2HABoV5wcIRYCadwjZZPLfiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srcSC2l6y5wFr0Fx0zUa9IbpPrDQlq6DN9VLLhS3Qx/fAFbq10d1Ur63j4IRfkkji
	 2wrQAzYgVZKg24X76g+0tKd0sPRHiO6ROfsz3WhWsJgw8J9ra8uzEc3BpfVNjr0p2Q
	 hwfNeui9F/meuzxH1SqBek1gyAPpKd2z4i/LDrX6IcPYQIanAtZQKEp4diXQIdlOqu
	 uT6dYwiSwCy06HlTq1o71Viw1lclVfUQuyGQcFgurq902kaZlsAoW5W/C3DaloG8u3
	 kcCVC5t0P8kIMWxXU/aa4kcT39L7xZsGHtqsdt5PEe1Yc6XNpF595yIJfJn6cbGR0w
	 4dBJgT643g+bA==
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
Subject: [PATCH AUTOSEL 6.1 07/12] platform/x86: thinkpad_acpi: Fix for ThinkPad's with ECFW showing incorrect fan speed
Date: Tue, 12 Nov 2024 05:37:09 -0500
Message-ID: <20241112103718.1653723-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
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
index c2fb19af10705..bedc6cd51f399 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8213,6 +8213,7 @@ static u8 fan_control_resume_level;
 static int fan_watchdog_maxinterval;
 
 static bool fan_with_ns_addr;
+static bool ecfw_with_fan_dec_rpm;
 
 static struct mutex fan_mutex;
 
@@ -8856,7 +8857,11 @@ static ssize_t fan_fan1_input_show(struct device *dev,
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
@@ -8873,7 +8878,11 @@ static ssize_t fan_fan2_input_show(struct device *dev,
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
@@ -8949,6 +8958,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
+#define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8970,6 +8980,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
 	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
+	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -9010,6 +9021,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
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
@@ -9221,7 +9239,11 @@ static int fan_read(struct seq_file *m)
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


