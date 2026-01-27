Return-Path: <stable+bounces-211855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAO/JJ/jeGlJtwEAu9opvQ
	(envelope-from <stable+bounces-211855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:11:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A678977B3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 014FC300AB01
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240EF1DF963;
	Tue, 27 Jan 2026 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="V9b5kVjE"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AD306B1B
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529928; cv=none; b=eOlBLkFCD6Y0RREpgFT2GHI6hoeTLl01zfnIEB4xr3yN+j2O8XQacq7kiOnMfTtCln/NinKTP/20B0TF580APNJzPccpGUcBGtqXT9pYDd6pMSfsmBYW4BYZ1PEG8bHBnc3e96hLAITfz4FqGnWgvILBI0V84IWwdVu6DqBaGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529928; c=relaxed/simple;
	bh=WyvhLAWRi2HrTThtGboe7xBjhcjaMbZRhzWiqFsw1Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnnjASLvEx2CePBAKEvcCNztIwq6OvUu5KLAgjUWHy4npd0hJwe7cgnJA3U7jOPxaIOnVsalNnPVoGaKNGATWIt9cjFKy3RaxqJL9g4H+oca9T8aHF818aaNX3YzCyZO8zxEYqOxGSYuK5JonRM4rJnwKj/5mGksF/Id1ilrtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=V9b5kVjE; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026012716052043729be9410002078f
        for <stable@vger.kernel.org>;
        Tue, 27 Jan 2026 17:05:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=oQCqsTNT8hrYuZAc2yQgKDdUTceItemN1akukJur82E=;
 b=V9b5kVjE6aXvZ6xUqtyXfBQuci0PWgz0Nl6/2GDmYUrJ25052a22aTIDTyrR9At9T5vHpf
 xjieco7dfyhxg3clSc9b7/0u84DNjKAbN1om9r7eaA59+qnbcPI+/j8u4V/j4AbygTP4X9rB
 M2jdeQxDEoewQmZxiwZRAJxp5LxR3MBE2r5U12RAYYSMDPaoZQ+BMYAi2oQdnAwHrlne94Od
 ToObOxkBXUfPFFVe/JQY7qUfXnG3ahEcMHDrH2QqXbOr5oxJyhserkc0xnY99xihTB0+8Mtc
 8NJvvb7CkYpsL2Qm3V8QJXhmwQ7YdZx5tkCj4J+/3niNrwCuMxbCbjOw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH] extcon: ptn5150: Avoid IRQ vs probe race and drop mutex
Date: Tue, 27 Jan 2026 17:05:06 +0100
Message-ID: <20260127160512.577735-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211855-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.sverdlin@siemens.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,siemens.com:dkim,siemens.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A678977B3
X-Rspamd-Action: no action

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The IRQ is being requested quite early in probe sequence, where neither
mutex has been taken, nor info->edev has been set yet. From this point on
one shall expect the handler to be called. The corresponding test for
!info->edev looks pointless being not protected by the mutex.

Moving the IRQ request to the end of probe sequence avoids the race against
ptn5150_check_state() and other init steps (devm_extcon_dev_allocate(),
devm_extcon_dev_register()).

Finally it becomes obvious that the worker function doesn't run
concurrently with anything else and we can drop the mutex completely.

The change has been motivated by the following crash:

Unable to handle kernel paging request at virtual address 006c727400353434
CPU: 1 UID: 0 PID: 74 Comm: kworker/1:2 6.18.0-next-20251212
Workqueue: events ptn5150_irq_work [extcon_ptn5150]
pc : 0x6c727400353434
lr : notifier_call_chain+0x80
Call trace:
 0x6c727400353434 (P)
 raw_notifier_call_chain+0x20
 extcon_sync+0xd0
 extcon_set_state_sync+0x3c
 ptn5150_check_state+0xf8 [extcon_ptn5150]
 ptn5150_irq_work [extcon_ptn5150]
 process_one_work
 worker_thread
 kthread
 ret_from_fork
Kernel panic - not syncing: Oops: Fatal exception

Cc: stable@vger.kernel.org
Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/extcon/extcon-ptn5150.c | 38 ++++++++++-----------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index eca1b140aeb0f..cb5646bf91c5e 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -57,7 +57,6 @@ struct ptn5150_info {
 	struct gpio_desc *vbus_gpiod;
 	int irq;
 	struct work_struct irq_work;
-	struct mutex mutex;
 	struct typec_switch *orient_sw;
 	struct usb_role_switch *role_sw;
 };
@@ -144,16 +143,10 @@ static void ptn5150_irq_work(struct work_struct *work)
 	int ret = 0;
 	unsigned int int_status;
 
-	if (!info->edev)
-		return;
-
-	mutex_lock(&info->mutex);
-
 	/* Clear interrupt. Read would clear the register */
 	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
 	if (ret) {
 		dev_err(info->dev, "failed to read INT STATUS %d\n", ret);
-		mutex_unlock(&info->mutex);
 		return;
 	}
 
@@ -188,14 +181,9 @@ static void ptn5150_irq_work(struct work_struct *work)
 	/* Clear interrupt. Read would clear the register */
 	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
 			&int_status);
-	if (ret) {
+	if (ret)
 		dev_err(info->dev,
 			"failed to read INT REG STATUS %d\n", ret);
-		mutex_unlock(&info->mutex);
-		return;
-	}
-
-	mutex_unlock(&info->mutex);
 }
 
 
@@ -281,8 +269,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
-	mutex_init(&info->mutex);
-
 	INIT_WORK(&info->irq_work, ptn5150_irq_work);
 
 	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
@@ -307,16 +293,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
-	ret = devm_request_threaded_irq(dev, info->irq, NULL,
-					ptn5150_irq_handler,
-					IRQF_TRIGGER_FALLING |
-					IRQF_ONESHOT,
-					i2c->name, info);
-	if (ret < 0) {
-		dev_err(dev, "failed to request handler for INTB IRQ\n");
-		return ret;
-	}
-
 	/* Allocate extcon device */
 	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
 	if (IS_ERR(info->edev)) {
@@ -366,9 +342,17 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	 * Update current extcon state if for example OTG connection was there
 	 * before the probe
 	 */
-	mutex_lock(&info->mutex);
 	ptn5150_check_state(info);
-	mutex_unlock(&info->mutex);
+
+	ret = devm_request_threaded_irq(dev, info->irq, NULL,
+					ptn5150_irq_handler,
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					i2c->name, info);
+	if (ret < 0) {
+		dev_err(dev, "failed to request handler for INTB IRQ\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.52.0


