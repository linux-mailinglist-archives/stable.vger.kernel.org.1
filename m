Return-Path: <stable+bounces-116908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F44A3A9C5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DC718975D4
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F523315E;
	Tue, 18 Feb 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it+tY6Wc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C941DEFFE;
	Tue, 18 Feb 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910515; cv=none; b=LJ4K947rG76GFmeN+7C75n40Wa0tpOAXFkKy/6aPPLPGgjsvSgXPuCWc5idd4MUUzQAwxZCf3UVIqfqTWqUvpOu3FwMqqG2MBoWAq135d5jAXADsgKUW6VZZbDjlAzqFZInwLQbvmhs9TOT4u2nx5hzmNjqEv5A7G3w/jPbc04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910515; c=relaxed/simple;
	bh=91Vw30920RXqmRoW9VIj3ZwHD89SfRnXQFfAsBa4lHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUSIj8MKd7lbAqGvwx42z2rIpDelcSmNC9MnNTkfcYR9/OSOMpI/vkM4oveFJ5z0Wm4hdgCckkMtso6tmWT0/p1HPKDa9DQQCSXgp+e9LjKrXGMbJvNl3UAbO3EzaJeCKJ+Fp+FKIVZZEJolqMUaPg4qv0pwXq1E7Qp9pXnEG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it+tY6Wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FD6C4CEE2;
	Tue, 18 Feb 2025 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910515;
	bh=91Vw30920RXqmRoW9VIj3ZwHD89SfRnXQFfAsBa4lHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=it+tY6Wc2JF+MatgLqaaMXnGrqyFbfrg/h0LrfwZIwgoKFmDrv7BYPUA8UvrrswR4
	 6s4+taIHIy7R6glmxS1Wl+c6OArx8z+skTVGB/QcR/PaGDJ6QXM1A5j3vmtdJ2tTWL
	 Hs5MwViG1ZyubkGlu3apnBW24fsQnvtsGUa+UmGwYzYycmoIzr5kvrw8n9o3PNdoaa
	 3VdJ053R0bKFvXZM9rWBYJGmKrWicKdeifKwPCWomgGkFtEwFq28k1aKynbqncQXEq
	 PqiOFt/glmgp257Yb/by6+2YKdJANsIireXZNnGwWGZF9syfuKUUjSl1j3km+NiXvJ
	 s1MHgFP5o3ZSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sybil Isabel Dorsett <sybdorsett@proton.me>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/13] platform/x86: thinkpad_acpi: Fix invalid fan speed on ThinkPad X120e
Date: Tue, 18 Feb 2025 15:28:11 -0500
Message-Id: <20250218202819.3593598-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202819.3593598-1-sashal@kernel.org>
References: <20250218202819.3593598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit

From: Sybil Isabel Dorsett <sybdorsett@proton.me>

[ Upstream commit 1046cac109225eda0973b898e053aeb3d6c10e1d ]

On ThinkPad X120e, fan speed is reported in ticks per revolution
rather than RPM.

Recalculate the fan speed value reported for ThinkPad X120e
to RPM based on a 22.5 kHz clock.

Based on the information on
https://www.thinkwiki.org/wiki/How_to_control_fan_speed,
the same problem is highly likely to be relevant to at least Edge11,
but Edge11 is not addressed in this patch.

Signed-off-by: Sybil Isabel Dorsett <sybdorsett@proton.me>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20250203163255.5525-1-sybdorsett@proton.me
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index bedc6cd51f399..0955624572316 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8161,6 +8161,7 @@ static struct ibm_struct volume_driver_data = {
 
 #define FAN_NS_CTRL_STATUS	BIT(2)		/* Bit which determines control is enabled or not */
 #define FAN_NS_CTRL		BIT(4)		/* Bit which determines control is by host or EC */
+#define FAN_CLOCK_TPM		(22500*60)	/* Ticks per minute for a 22.5 kHz clock */
 
 enum {					/* Fan control constants */
 	fan_status_offset = 0x2f,	/* EC register 0x2f */
@@ -8214,6 +8215,7 @@ static int fan_watchdog_maxinterval;
 
 static bool fan_with_ns_addr;
 static bool ecfw_with_fan_dec_rpm;
+static bool fan_speed_in_tpr;
 
 static struct mutex fan_mutex;
 
@@ -8396,8 +8398,11 @@ static int fan_get_speed(unsigned int *speed)
 			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
 			return -EIO;
 
-		if (likely(speed))
+		if (likely(speed)) {
 			*speed = (hi << 8) | lo;
+			if (fan_speed_in_tpr && *speed != 0)
+				*speed = FAN_CLOCK_TPM / *speed;
+		}
 		break;
 	case TPACPI_FAN_RD_TPEC_NS:
 		if (!acpi_ec_read(fan_rpm_status_ns, &lo))
@@ -8430,8 +8435,11 @@ static int fan2_get_speed(unsigned int *speed)
 		if (rc)
 			return -EIO;
 
-		if (likely(speed))
+		if (likely(speed)) {
 			*speed = (hi << 8) | lo;
+			if (fan_speed_in_tpr && *speed != 0)
+				*speed = FAN_CLOCK_TPM / *speed;
+		}
 		break;
 
 	case TPACPI_FAN_RD_TPEC_NS:
@@ -8959,6 +8967,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
+#define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8981,6 +8990,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
+	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -9044,6 +9054,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 
 			if (quirks & TPACPI_FAN_Q1)
 				fan_quirk1_setup();
+			if (quirks & TPACPI_FAN_TPR)
+				fan_speed_in_tpr = true;
 			/* Try and probe the 2nd fan */
 			tp_features.second_fan = 1; /* needed for get_speed to work */
 			res = fan2_get_speed(&speed);
-- 
2.39.5


