Return-Path: <stable+bounces-249500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHxFNGwwDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:42:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C057B787
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ABA13049837
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3B3F23C4;
	Tue, 19 May 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU6V6Rs4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C53F0759;
	Tue, 19 May 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182479; cv=none; b=MEpaiZMxt0iSD+9V9hNeH+cmEF09JLB9+cbRk5z5doWdOBfnM2o0ehJ+vKBrKh5Z0+BI1pqvDgxEDnwD9Y61IDr62G2st5N/xIydEwV+eLRJP9PKuo+uSRhpouC+3GN+ycCXN6dmT1bf5yBVa4MCjPJl8FRzILpL67iN02RM5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182479; c=relaxed/simple;
	bh=GRAKj2Ib8S95YESwx1eZ8spnsRs+B52kf5emJu29s5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pValBtAl1hGlDk8Qu/mjnu7EM3CQDglqzwZJREHc+nbYgKhLfbvOeR8kYlhl83paYTxL6lrSLqKsQpY+imwBzfD3kYtHEOxRmgLPMnGGsI/FJlOsh8wpRYE0XmhZtJLXe0WyhOv/D3fEkaN50KrnAnq393u7JfYyhkk49zJMkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU6V6Rs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D8EEC2BCB3;
	Tue, 19 May 2026 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182478;
	bh=GRAKj2Ib8S95YESwx1eZ8spnsRs+B52kf5emJu29s5E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sU6V6Rs4o93t21TSs5hknCXz6HLxJuDBo4ccU3HY63KzstqOh2mWZ82ZUESMTFCk2
	 NVIDYGPGasZRnAod+sqrZ4lJmhhm6tBV5xFrYZJBB0vkjisnlDLH3BlRbQ6FhZQXHq
	 o1f4wWL1BuayP6UUry4UzbR561WRYYLe/Et9wBAwYUQV0hsHincKK9pP8tks0BQaK3
	 FOrqtxpoNDiu77id8c5IRcm8kyEogan2J3MlyJ/DRCSeXQx8vTSshjU+zTquhkt6Se
	 aoSz1OYGv3NbsHwXGPFNROxo0zksmPdGShzkygPYkNn4klZoJ4p+Suhtll6quY+fFP
	 FuGdtxu1FnreQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85185CD4F5B;
	Tue, 19 May 2026 09:21:18 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Tue, 19 May 2026 17:06:42 +0800
Subject: [PATCH v4] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v4-1-8580d8e18016@amd.com>
X-B4-Tracking: v=1; b=H4sIACEoDGoC/53NQW7CMBCF4asgrzuVZ2wcwqr3QCwcZxxGBYc6K
 AqKcnccNrRLunyW5/tnNXAWHtR+M6vMowzSpzLsx0aFk08dg7RlK9LktEGEFAOk6QopCAgFyDz
 c+ly+5R+4Zek6zhD9+dz48A2h9bWlrdHBaVXIa+Yo0zN3OJZ9kvX4/qyPuL7+MzQiINRMukJrE
 dvqy1/az9Bf1JoZ6TdNb9JUaOPI2F2sojf6L21e9Bbdm7RZ6arxtnFc65170cuyPACQvfTdnAE
 AAA==
X-Change-ID: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, krzk@kernel.org, carl.lee@amd.com, 
 peter.shen@amd.com, colin.huang2@amd.com, kuba@kernel.org, david@ixit.cz, 
 luca.stefani.ge1@gmail.com, brgl@kernel.org, mpearson@squebb.ca
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779181624; l=3416;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=I6n0L9eb1IHalW1YqScUbq1aaruqpfXyz2Bqif4BPPQ=;
 b=P8Fx4sPh+ns6A89txt1r/WXw111Hu3eAigKcHtshKjOuTKAHXR3UaAD8xjES+guySNyh+Mc1u
 gDBXvJ5gbWyBARyuV+wH6mdOPO0+cNlj5ewKezTP4b364v4sK2rZli+
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249500-lists,stable=lfdr.de,carl.lee.amd.com];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,amd.com,ixit.cz,gmail.com,squebb.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:replyto,amd.com:mid,amd.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: CF5C057B787
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

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Carl Lee <carl.lee@amd.com>
---
Some ACPI-based platforms report incorrect IRQ trigger types,
which can lead to interrupt storms.

Use rising-edge IRQ on ACPI systems to avoid this regression,
while keeping firmware-provided trigger types on non-ACPI systems.
---
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



