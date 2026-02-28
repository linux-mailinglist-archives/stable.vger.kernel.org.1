Return-Path: <stable+bounces-220262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMDEJKsyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1B1C5BAA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677823210AEF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725337D7AF;
	Sat, 28 Feb 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyhI3CFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60637D7A6;
	Sat, 28 Feb 2026 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300165; cv=none; b=XmI5X5WsFMM2wUYEgMi30VZYNZ0zyshFO0NOq7ofe8rqj2SJOnKjTuSw6sNp4bWyVPTWEA7z8V0KxoHkiCxXsUAZDYeAS7LqthPpRLILDoJWBqxxS2NXjaOaDcOdZ/LrA6tOLQhmeeWUfEb6WYOAy0IjISTF+FTHpUVwWgrL2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300165; c=relaxed/simple;
	bh=acyDod6XCOH+jKSFS/GSgVrZwDWwzJ9Uzixv95uaBJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqx4tWPnE2yhxTgaK3qeek92SfVtDApmWJIs+w/k8hNjZtj7rifuWZJTEcUWHLYwKzNrTvMm9sVrjj6KisqIRZL6FJJSO2GQISYjIC5ZJf43VfkcCPjRvNMzIRb06O24r3A2ruOxo/acx9f+oUeyyWTmjIuwLz32G2RO5o3tmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyhI3CFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F19C19423;
	Sat, 28 Feb 2026 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300165;
	bh=acyDod6XCOH+jKSFS/GSgVrZwDWwzJ9Uzixv95uaBJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyhI3CFRp3PTcFKe6MiKXeYKsuhmZgrsh13TIjhe9VeRGEghfl7XkOj8Re98yJue2
	 CbZQU5Oxjz5scWp1mQ0bDT9WF4zjfWxfpb7TDF2YR18jrUy2nEr62iOKgZeZgTcKXJ
	 5fiIcRk/IZdN+mdc2hpNT0HVtOz4doXQzVXRw16WWAeRnWPZh+6LGvRQu+L1QjqRzn
	 d1H1lexLXpBvk+kHonxrOg5qBqPDzQ3OsD3JastnomuGFR13PO841umvD5OwJ9p0CB
	 INnPSKjrJUjUtS+WbBHtryExz06WgqnnimQyOf239LdQf3nui+hub5eI1+h4zxxHgm
	 rDM7vqaFjCKTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 184/844] media: mt9m114: Avoid a reset low spike during probe()
Date: Sat, 28 Feb 2026 12:21:37 -0500
Message-ID: <20260228173244.1509663-185-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220262-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ideasonboard.com:email]
X-Rspamd-Queue-Id: 18F1B1C5BAA
X-Rspamd-Action: no action

From: Hans de Goede <johannes.goede@oss.qualcomm.com>

[ Upstream commit 84359d0a5e3afce5e3e3b6562efadff690614d5b ]

mt9m114_probe() requests the reset GPIO in output low state:

	sensor->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);

and then almost immediately afterwards calls mt9m114_power_on() which does:

		gpiod_set_value(sensor->reset, 1);
		fsleep(duration);
		gpiod_set_value(sensor->reset, 0);

which means that if the reset pin was high before this code runs that
it will very briefly be driven low because of passing GPIOD_OUT_LOW when
requesting the GPIO only to be driven high again possibly directly after
that. Such a very brief driving low of the reset pin may put the chip in
a confused state.

Request the GPIO in high (reset the chip) state instead to avoid this,
turning the initial gpiod_set_value() in mt9m114_power_on() into a no-op.
and the fsleep() ensures that it will stay high long enough to properly
reset the chip.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/mt9m114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
index 51ebbe7ae9969..554f25071cca6 100644
--- a/drivers/media/i2c/mt9m114.c
+++ b/drivers/media/i2c/mt9m114.c
@@ -2434,7 +2434,7 @@ static int mt9m114_probe(struct i2c_client *client)
 		goto error_ep_free;
 	}
 
-	sensor->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	sensor->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(sensor->reset)) {
 		ret = PTR_ERR(sensor->reset);
 		dev_err_probe(dev, ret, "Failed to get reset GPIO\n");
-- 
2.51.0


