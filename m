Return-Path: <stable+bounces-212846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBbvEwRafGkYMAIAu9opvQ
	(envelope-from <stable+bounces-212846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 08:13:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2EB7CE3
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 08:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A1903013D5B
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D168C33E356;
	Fri, 30 Jan 2026 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBGItkWb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D9316904
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757182; cv=none; b=JZyrHjPiwbP5VX0RYmOjU0sO0SzPkWoQsxsUpCl/y8DKWp3s6ZGvtAoMv4cmgYW44PI6o+iyK+l3/BvqA/0S75KJUtesc9jPq3BYE/m4goiaacPv1TvaLI4zxhTBlvdhgFzNsatnxg5h7+4nzxmbrxpSXmENkRANxARShxBtGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757182; c=relaxed/simple;
	bh=vVxHFH6Yc8NWRiRG32Mnm8241KHahA48nTKLUwCZR9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcUtPeFg+LnJhuVvG+jPZQjw/9cWba18z5+WLPSA3FBD1cyxG2k+77Y0pw9t3zLWQhjfYCqQsBR15/LrXol7gaOqPrQSBFOtARIHql+d9QEv7vqn9VKkPYKI2GAI4EOjiWlOXex+IROcM/1FlkPjsNURgmh8Y5HY6UzttFGJ6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBGItkWb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4327555464cso1388599f8f.1
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 23:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769757179; x=1770361979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOWxZQdmNaToaPwUEH1k3Iwm/h1XYwVGWPJU1KGWwqo=;
        b=QBGItkWbI6HDwaFF8McF008WgMtJIQZJzk41LQxqenxSxlP4cy0MCRaIcy+/vq4PtX
         nbf7A66rOPLN4PD0j9fUG/iF5Nn/B8Fs2PEwYesh7CHeGKDIB2M4dA9LHBuhURNDGcCb
         5evE63VGZWDCc5hEQeTYCkuQjhd/e7+5MXW8rHdCjr8jltq3HXECgnCCngQd44RoPIjW
         XvRPZYl9Q4naSEFHUVRKLmMoL//lwSXbHLo6wmQrVzabmfn/GwnWf4U0qgRAkUVjtk5/
         RQMZ6Makap6YdiTN0O49cTuOwLD1pTFx9w3j9ICgwVLYk2rNKdX2Gw9FSbddh4zqutmz
         PbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769757179; x=1770361979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOWxZQdmNaToaPwUEH1k3Iwm/h1XYwVGWPJU1KGWwqo=;
        b=tjhYjPwuS4QQuG2/A2e8zK4JuhAkgacmPbvhUJOlmmPhICq5l8sknIt2IyBjfUqDkl
         vmHG6cbAi0QdIp4hrmnUKlCvfxEdj8IaIhgYq2ZWK9AsarfMqLDrEJdSVGGFaN3iC5Ms
         gADEhrnjCBB7zpMDEeGKzNrWVZx0G1vrO85gUDFzHX4RqyJCv/GFLjQPPkDo2bfqYlEq
         tWYCyUe6ZMQ9cconumTbiD8MHpr5Iw8IN0CZpw/wtRYBot/bd4iuEwup0mzf90la+Q5E
         kbtxascZUKSUUePvkWqaA/CxeAGDt0mADWQIm/ZI95/3147egPZpGt4p400MOo98IvrY
         90Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXFJNY9bxLEO8VoFrZqNaxa6TrgoH3XBJHpBnnpv8CO62Rq/yXSJX5wf5hkC7/NqET0neP5/g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyY1z6t87Bks+c+S9qAKiCIGpHYJNwXsXF4F3BtFDA+WEAdvb
	/9fh7CZut2EuopZt1cXJ5FnS8khLjhjzbsyhQxftaS1t2b3W05hXa4VV
X-Gm-Gg: AZuq6aI7HdzJSZQTYHSxoazwHNleqMRVRgyeR3DGl5WrZzX07Ew6UkZ7jIaCy7D16By
	BUUclb7F0+kgtooOWS9DHKaTaTUu7yIf9ljhb01UTwTn0zlMIr06y7qJW8MhS3MRilEB8Af8w3h
	o7ippdpQUKL/wIYIPKPX0daoHCUyFPCAHzM0Lt17wD4sVcDuiHVp3oFryB5jZ7oueGWJFBm2wQd
	KOg2XpgXl1hh731EXtGrfqQxuqJVWT6bUCPM6T7KRQstABgUP1KEP97I+ZD6MuuxAbT3FOvT68D
	xhiSyS00sMFwAYSUU2rY1ks+JvVPJrwpfaYYRsiwXhfd3rIIhJkxoOnIl7FHtzYlvHFhrTnr+5n
	j864vtQh/3HBZZbezyftsvuFwnmnjPIjqvRM9+/uL69i1x1iR6e5ek9F8jkniCYDMQEvrszQlpg
	7P4/IM0/nwKokjDk7Ia67w30DVPSkHbn5PcP1ezp9D969tJ+28h58lf/xLtFhtwQSAXZF2c8hN
X-Received: by 2002:a05:6000:430e:b0:435:a48a:1239 with SMTP id ffacd0b85a97d-435f3a79d86mr2893572f8f.14.1769757179322;
        Thu, 29 Jan 2026 23:12:59 -0800 (PST)
Received: from emanuele-nb.int.toradex.com (93-34-120-147.ip49.fastwebnet.it. [93.34.120.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132368csm18261389f8f.31.2026.01.29.23.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:12:58 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] power: reset: tdx-ec-poweroff: fix restart
Date: Fri, 30 Jan 2026 08:11:35 +0100
Message-ID: <20260130071208.1184239-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212846-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghidoliemanuele@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8F2EB7CE3
X-Rspamd-Action: no action

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

During testing, restart occasionally failed on Toradex modules.

The issue was traced to an interaction between the EC-based reset/poweroff
handler and the PSCI restart handler. While the embedded controller is
resetting or powering off the module, the PSCI code may still be invoked,
triggering an I2C transaction to the PMIC. This can leave the PMIC I2C
in a frozen state.

Add a delay after issuing the EC reset or power-off command to give the
controller time to complete the operation and avoid falling back to another
restart/poweroff provider.

Also print an error message if sending the command to the embedded controller
fails.

Fixes: 18672fe12367 ("power: reset: add Toradex Embedded Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/power/reset/tdx-ec-poweroff.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/reset/tdx-ec-poweroff.c b/drivers/power/reset/tdx-ec-poweroff.c
index 3302a127fce5..8040aa03d74d 100644
--- a/drivers/power/reset/tdx-ec-poweroff.c
+++ b/drivers/power/reset/tdx-ec-poweroff.c
@@ -8,7 +8,10 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -31,6 +34,8 @@
 
 #define EC_REG_MAX                      0xD0
 
+#define EC_CMD_TIMEOUT_MS             	1000
+
 static const struct regmap_range volatile_ranges[] = {
 	regmap_reg_range(EC_CMD_REG, EC_CMD_REG),
 };
@@ -75,6 +80,13 @@ static int tdx_ec_power_off(struct sys_off_data *data)
 
 	err = tdx_ec_cmd(regmap, EC_CMD_POWEROFF);
 
+	if (err) {
+		dev_err(data->dev, "Failed to send power off command\n");
+	} else {
+		mdelay(EC_CMD_TIMEOUT_MS);
+		WARN_ONCE(1, "Unable to power off system\n");
+	}
+
 	return err ? NOTIFY_BAD : NOTIFY_DONE;
 }
 
@@ -85,6 +97,13 @@ static int tdx_ec_restart(struct sys_off_data *data)
 
 	err = tdx_ec_cmd(regmap, EC_CMD_RESET);
 
+	if (err) {
+		dev_err(data->dev, "Failed to send restart command\n");
+	} else {
+		mdelay(EC_CMD_TIMEOUT_MS);
+		WARN_ONCE(1, "Unable to restart system\n");
+	}
+
 	return err ? NOTIFY_BAD : NOTIFY_DONE;
 }
 
-- 
2.43.0


