Return-Path: <stable+bounces-249520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMIQOyYzDGrdZAUAu9opvQ
	(envelope-from <stable+bounces-249520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:53:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB357BAA6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 763DC3038A95
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C90477E53;
	Tue, 19 May 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjXN07us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827883F0AB3;
	Tue, 19 May 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184029; cv=none; b=XNgOn2+TRnC5pL5o3R1MqwDjxxg10awdMHRdWqgjS3UQlSSuQ5Y8h3UicxMgXee05HjtLDCBhBUJWBA3tXh1mewB/Ttjlme5Dbm/rD6iaaAtFuQga6/FSOBnRZZjD37JKKAfhrLUjW/vxCSrWaUZrJQgRE8u2flwoWVCG8ejbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184029; c=relaxed/simple;
	bh=OH/yfiCu0Mp3b66K0reocEsxvYcepzYQzij9x5dEOxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JvKGX4nM6HKFtUD+gmuhHJqZYJJ0c76C33xi1oVEdwL8PYFo+VehyZ2X08G3XpyYqP4FJ47FqppXDvRCgnTuvgP+nWTqPIlQozde4/57yoahQb9QcV00okJ/XCehsAk4QHgCPi7EHvTjIkWbae29rrkeSnB3wDezqLdBlBzf5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjXN07us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ACBDC2BCB3;
	Tue, 19 May 2026 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779184029;
	bh=OH/yfiCu0Mp3b66K0reocEsxvYcepzYQzij9x5dEOxk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SjXN07usVOFyeVoXxp8t0WX9DMiBCBYdY4olW/q5/kw7SB0rwIn/dNuOEbs82JQ7S
	 uYQjQEt4d94I3CuKzfoEmKLwmVDh2jwstzG5Di4e/QcDmWzbmEM10wWxKnOXdClDGF
	 FUrLQVI5qkIYIFJ8R7z2hvdZcvlXYfx7meNkOZcbqVEj8cVkgHf8dktSiRPTmGiEZH
	 YMiDuZadgB1TZJXR/7X1YGpoWsdfFvFxyMSJoIxeeTZvxY413tX8HAVsw2EVgPYNPh
	 h8OKXNo70DO34FJjlS7LeuRHGlFkCX3zBs2bCjcLWZwdqWIyyAXxHrkbKB8jL8eIDl
	 LTbNSC+jkVlNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09478CD4F57;
	Tue, 19 May 2026 09:47:09 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Tue, 19 May 2026 17:32:53 +0800
Subject: [PATCH v5] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v5-1-1a826cfbc128@amd.com>
X-B4-Tracking: v=1; b=H4sIAEQuDGoC/53NQW7DIBCF4atErDsVAxjjrnqPqgsMgzNqglMcW
 aki3704mzpLd/kQ8/13MVFhmsTb4S4KzTzxmOtoXg4iHH0eCDjWLZRUVmpEyClAvl0gBwZWAQp
 N17HUb+UbroWHgQokfzr1PnxBiL4zqtEyWCkqeSmU+PbIfXzWfeT1+OdRn3F9/WdoRkDoSMkWj
 UGM7bs/x9cwnsWamdWWVjtpVWltlTYutclr+UzrP7pBu5PWK9323vSWOunsM222dLeTNpV2jZP
 RETqJG3pZll9X+str9wEAAA==
X-Change-ID: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, krzk@kernel.org, carl.lee@amd.com, 
 peter.shen@amd.com, colin.huang2@amd.com, kuba@kernel.org, david@ixit.cz, 
 luca.stefani.ge1@gmail.com, brgl@kernel.org, mpearson@squebb.ca
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779183174; l=3788;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=AuJE8naMhN8VuJ0Xkt3hE9rAU8BuKShRUpf+0Ld/H78=;
 b=+nkcf9jeJ6vKQ5w1r1mJahWWd1a9UhYHs8pHNRr6OI7EWQ0ABp+xQ5psnJJzSPb06KK5Gdaqc
 m0/zySMbxyMA8Bphn4KY3AcN9/huCEfkvZaBPiR8o0HFZjkI0SHiQGS
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249520-lists,stable=lfdr.de,carl.lee.amd.com];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,amd.com,ixit.cz,gmail.com,squebb.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[carl.lee@amd.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:replyto,amd.com:mid,amd.com:email,squebb.ca:email,qualcomm.com:email]
X-Rspamd-Queue-Id: 8AEB357BAA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carl Lee <carl.lee@amd.com>

Some ACPI-based platforms report incorrect IRQ trigger types (e.g.
IRQF_TRIGGER_HIGH), which can lead to interrupt storms.

Use the historically working rising-edge trigger on ACPI systems to
avoid this regression.

Device Tree-based systems continue to use the firmware-provided
trigger type.

Fixes: 57be33f85e36 ("nfc: nxp-nci: remove interrupt trigger type")
Cc: stable@vger.kernel.org

Tested-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Carl Lee <carl.lee@amd.com>
---
Some ACPI-based platforms report incorrect IRQ trigger types,
which can lead to interrupt storms.

Use rising-edge IRQ on ACPI systems to avoid this regression,
while keeping firmware-provided trigger types on non-ACPI systems.
---
Changes in v5:
- Add missing Reviewed-by and Tested-by tags
- No functional changes
- Link to v4: https://lore.kernel.org/r/20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v4-1-8580d8e18016@amd.com

Changes in v4:
- Add Fixes tag
- Add Cc: stable@vger.kernel.org
- Link to v3: https://lore.kernel.org/r/20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com

Changes in v3:
- Use rising-edge IRQ on ACPI systems to avoid interrupt storms
- Keep using firmware-provided trigger type on non-ACPI systems
- Refine commit message to focus on regression on ACPI platforms
- Link to v2: https://lore.kernel.org/r/20260312-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v2-1-362348f7fa30@amd.com

Changes in v2:
- Add missing <linux/irq.h> include for irq_get_trigger_type().
- Link to v1: https://lore.kernel.org/r/20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com
---
 drivers/nfc/nxp-nci/i2c.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 6a5ce8ff91f0..266dc231c47d 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/nfc.h>
 #include <linux/gpio/consumer.h>
@@ -267,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct nxp_nci_i2c_phy *phy;
+	unsigned long irqflags;
 	int r;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
@@ -303,9 +305,26 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 	if (r < 0)
 		return r;
 
+	/*
+	 * ACPI platforms may report incorrect IRQ trigger types
+	 * (e.g. level-high), which can lead to interrupt storms.
+	 *
+	 * Use the historically stable rising-edge trigger for ACPI devices.
+	 *
+	 * On non-ACPI systems (e.g. Device Tree), prefer the firmware-
+	 * provided trigger type, falling back to rising-edge if not set.
+	 */
+	if (ACPI_COMPANION(dev)) {
+		irqflags = IRQF_TRIGGER_RISING;
+	} else {
+		irqflags = irq_get_trigger_type(client->irq);
+		if (!irqflags)
+			irqflags = IRQF_TRIGGER_RISING;
+	}
+
 	r = request_threaded_irq(client->irq, NULL,
 				 nxp_nci_i2c_irq_thread_fn,
-				 IRQF_ONESHOT,
+				 irqflags | IRQF_ONESHOT,
 				 NXP_NCI_I2C_DRIVER_NAME, phy);
 	if (r < 0)
 		nfc_err(&client->dev, "Unable to register IRQ handler\n");

---
base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
change-id: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60

Best regards,
-- 
Carl Lee <carl.lee@amd.com>



