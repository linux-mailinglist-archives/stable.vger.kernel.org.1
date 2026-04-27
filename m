Return-Path: <stable+bounces-241326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fc1Bfxh72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:17:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FB6473445
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB5C630028D6
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D033279792;
	Mon, 27 Apr 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgJ/SVje"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21313B6C09
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295860; cv=none; b=KkSKWegXksh8CbcR9uE41HTqyGoK6O/kbOp/JHMn/Urj5LlFRJI8A7pQeHRiRdUS8pujA6UUwaXPG7TWZmyseYEwGD3p99y09YGjRf8uG7YuSbltL3d1KAJCx10pO1hYbghh7lMonxVSZ5E/oczNFJAPzK8kd8FOaCHzMxYeTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295860; c=relaxed/simple;
	bh=0V6gosJdoRQNTFQqh2+bD0+xQoMNzeLU3Tbf4QclE5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQS9s2AQVFRfLe4YcmDAKxpTcTdtxKLJLf0RjN1+ND8Ukb+DOEnDaLKPMN/hjLsCQt42cplla1HrMM1eZCQfMGRtuDWTAyg/f9HwZyL48aLDZrNZ0Q1ATkNpbZjxV+IpQfnU1d/h4ikM+eA7ffgR6PqBnU6stoQBz8zPLL1edx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QgJ/SVje; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso2095069a12.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777295857; x=1777900657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdxTgo2BiNPwM4INja+PgXdaGRXgDFW+qwgof2SUt84=;
        b=QgJ/SVjehgPUOlAfdij2CluvHIy4ZtjtHsVas/E0gza32/XP1Qs94wVd+MtIz1zIPt
         tlpbUVGxAnKg5oDXCqzfQsc8KEkw5pfMdqDp+UtsejnBbvNot7H9+iS4hZEnTp2WIIlc
         H3oU7Bu119lA+iMBFlKZG/GF2ocsrZGrmA7JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295857; x=1777900657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdxTgo2BiNPwM4INja+PgXdaGRXgDFW+qwgof2SUt84=;
        b=Uy/0n/NMYraxAa2Wz1JsMjhQ3R3vBn0kAVWbnr1gl+2kedWmgMg/NwWeyJMpKokNa8
         Rl+izlQjx0+zew+dO96Fc6pcuhx9SgsyKGYLKkgRfsUfd6wT4R2s4q0rSmHaIYLWM9hG
         C90KPNKgWSxGluUMSrKtPKr+K63+pA8yTAiTQVLOHlmkGDmcaG82KCbE73wkupC535X5
         K/FT/fsI9bPLHAhy1HTE0e2TqiZB91ZLCOuZ4Uu3B139crquoK/omRfneksTyvMLVG4A
         nALu8KLTyDRnOvP6sDtWPcKbGgSiHPkklZ1d07BXDBJe65ULbEnDiWP34KTTrDiURju+
         Th/w==
X-Forwarded-Encrypted: i=1; AFNElJ8MKO0uFLxH6b8Wz2m/Z/svW7GUAT8+dMZSF+Yrc3AX6cCDoyAN5pvY+8LMEf6H66k563VRMDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYB92wkF+ZNeckmTyPHVkb8t7CFcskPUPk9yuWCAtx8oXXSYF
	3rcJNjyEYBVBghULMyzk7qwuvJju1vZMpWw87EsZh+MoAKHMQiTeRgk+DKaSjuAxuA==
X-Gm-Gg: AeBDietynXjcgTVoj+b76oKwsMxxm2tKuMUSTCTVn7u2AnhSGXegFlWAHrL3U8d1UEI
	iPNfAVs3SoonP+8MsXLkB3VQ9OxwaFkKXmPK7oeIb4mHtjzOHezuzKmFhUjgoGY7g+4VDUv9HrL
	sh72BkqT0Z4YHrz8mfhQancbKdNn++aFT0ogcPaBHWByyoLkJaQRF8G3Sqtp1AQNmSPZYk9CP3J
	FjNo7bwpXuxKDGqcB7J+jdNbViDx7SpI9JPVkDbUF1leju0mJOIKMMsKNde6OGD6/8otzc6wfKd
	2j0/PpWL0aywD6bC3OlwUQYwoLAWfV5KHNcY0dzLMx5N/eg/HZn/mNAg+nr+YhyAUOqlrIKnL+c
	HTbbCPy9jq3QodH6W8JgYyLNgfX2udtKZU3yV2EPZiC+P51gQ2Y2McM5YnbMLoApRUD4scLizhH
	bO45sGQ0Lg8hYvZyP1mzgQyEBz5rkyygpCUx4UsfDbPZoB41SQgZE9nyUuK2xKfC/VW2c6wO41z
	FK5NcN72QjXhRzAPetUMqByaZFQjtsOvA==
X-Received: by 2002:a17:907:3cca:b0:ba6:a05c:ac2b with SMTP id a640c23a62f3a-ba6a05cb665mr1754584166b.18.1777295856940;
        Mon, 27 Apr 2026 06:17:36 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (124.143.141.34.bc.googleusercontent.com. [34.141.143.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1db07sm1135196166b.30.2026.04.27.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:17:36 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: cros_ec: Delay dev_set_drvdata() until probe success
Date: Mon, 27 Apr 2026 13:17:21 +0000
Message-ID: <20260427131721.1165078-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02FB6473445
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241326-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akuchynski@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim,chromium.org:mid]

If ec_device_probe() fails, cros_ec_class_release releases memory for the
cros_ec_dev structure. However, because the drvdata was already set,
sub-drivers like cros_ec_typec can still retrieve the stale pointer via the
platform device. This leads to a use-after-free when cros_ec_typec attempts
to access &typec->ec->ec->dev on a device that has already been released.
Move dev_set_drvdata() to ensure that the pointer is only made available
once all initialization steps have succeeded.

 sysfs: cannot create duplicate filename '/class/chromeos/cros_ec'
 Call trace:
  sysfs_do_create_link_sd+0x94/0xdc
  sysfs_create_link+0x30/0x44
  device_add_class_symlinks+0x90/0x13c
  device_add+0xf0/0x50c
  ec_device_probe+0x150/0x4f0
  platform_probe+0xa0/0xe0
 ...
 BUG: KASAN: invalid-access in __memcpy+0x44/0x230
 Write at addr f5ffff809e2d33ac by task kworker/u32:5/125
 Pointer tag: [f5], memory tag: [fe]
 Tainted : [W]=WARN, [O]=OOT_MODULE
 Hardware name: Google Navi unprovisioned 0x7FFFFFFF/sku0 board/sku3
 Workqueue: events_unbound deferred_probe_work_func
 Call trace:
  __memcpy+0x44/0x230
  cros_ec_check_features+0x60/0xcc [cros_ec_proto]
  cros_typec_probe+0xe8/0x6e0 [cros_ec_typec]
  platform_probe+0xa0/0xe0

Cc: stable@vger.kernel.org
Fixes: 1c1d152cc5ac ("platform/chrome: cros_ec_dev - utilize new cdev_device_add helper function")
Co-developed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 39430dd44e30c..56fb7cceafc6c 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -195,7 +195,6 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (!ec)
 		return retval;
 
-	dev_set_drvdata(dev, ec);
 	ec->ec_dev = dev_get_drvdata(dev->parent);
 	ec->dev = dev;
 	ec->cmd_offset = ec_platform->cmd_offset;
@@ -237,6 +236,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (retval)
 		goto failed;
 
+	dev_set_drvdata(dev, ec);
+
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_get_sensor_count(ec) > 0) {
 		retval = mfd_add_hotplug_devices(ec->dev,
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


