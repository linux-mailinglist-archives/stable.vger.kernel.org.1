Return-Path: <stable+bounces-220076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C7vN9who2mC9wQAu9opvQ
	(envelope-from <stable+bounces-220076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:11:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F941C4D0C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4883055E52
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5373325491;
	Sat, 28 Feb 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="bWeBd+Zd"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC27233D9E
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298703; cv=none; b=YHyfycn7Wu1NK2MNeEOPdM0n1sUqewrp5MHZkWWT6hBslAcmi3B7I5b+5PT/xV+iATxhdI+Oo9+iRPXWJk3GjhTw4y9ZFLn7TqHUDTrLroV48vs+pm8kdR10/rdqDzlG4wWU5K/aletVrU1fu6mTIQMZBc4PFX59oEuh6RpWHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298703; c=relaxed/simple;
	bh=CP3WQ0c8wk0eTw9ZQ6vdaKj71BUpNMX1BWrOsXF6Vy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rv2IlhverhksEk6GLJ506tuDtXHAiESAMjcghZKBsDzZ4aTojvUf87DviWirtN2fZPRCQAunGV8NIw0WWAhhz8KYP/sSJIBD0WOhtAlfdpH/1kTeNxq03iSdOSJI7Zj9XHx+Dtgox4zhemDCpbUW1aTWeeaoQVynkFi3QGrgPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=bWeBd+Zd; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail; t=1772298684; x=1772557884;
	bh=jGTkcenrVLfQX3737mxS9UiiM58Ed24FDZSmQdR2lKA=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bWeBd+ZdgIajEXAuQ3Psfgb+AT8nkoOy7DA4n7d5YJCupe8NFcIEmwiI5YJsCtMCe
	 GyhyAK22vRxhKgmHWahSN0GQ0oJhsrQHTcsQndBQlJZKwL/81cdh4oGS2E5bz0PRuN
	 b13y3KwATP5tol8GhTPBXqwkWJYkhZIAARye9GEdShS11UKv/kU1TblfMbmQrwen95
	 qQudpJL8NXBNuGKm25D3zPBsgiws/gCdweNrTZdIRF18QHOUezKodLT2GPFrhi7EyQ
	 TOWIeZTxfIoL8UvDKyNrWWOjw57sar4O3e+oiobGzHhlSnhaSx6UqzehMSNqvX8bQY
	 2qboDjMqfn8AQ==
X-Pm-Submission-Id: 4fNWty5xblz1DF7d
gpg: Signature made Sat 28 Feb 2026 06:06:17 PM CET
gpg: using EDDSA key 8BFCF5668AA29DAD00D728F6EDAE71A20F500310
gpg: Good signature from "Aleksandrs Vinarskis <alex@vinarskis.com>"
 [ultimate]
gpg: aka "Aleksandrs Vinarskis <alex.vinarskis@gmail.com>" [ultimate]
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Sat, 28 Feb 2026 18:11:02 +0100
Subject: [PATCH] iio: st_sensors: fix trigger allocation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
X-B4-Tracking: v=1; b=H4sIAKUho2kC/x3MPQqAMAxA4auUzAZswKJeRRz8SWsWK2kRQXp3i
 +M3vPdCYhVOMJoXlG9JEs8K2xjYjuUMjLJXA7XkWqIeU0aRiFklBFbsma0nO6ydc1CjS9nL8w+
 nuZQPD0RsumAAAAA=
X-Change-ID: 20260228-st-iio-trigger-8ee1f219b566
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=CP3WQ0c8wk0eTw9ZQ6vdaKj71BUpNMX1BWrOsXF6Vy0=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDJmLFXcJt9b8SbRv5nJani0/r2nCEq3A2s1PVJ0C6me/9
 brOEVXbUcrCIMbFICumyNL952ta16K5axmua3yDmcPKBDKEgYtTACaSHMrI8EckstmXyzv5Xc3P
 j49+Gz1/sPrXs5Y4/ZsvfLQap25SPsnw34Hp+0LtUz+Sp2o6Zyh9XvNh/4nnKm7b43MvJ3Ku1Dm
 Uzw4A
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vinarskis.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[vinarskis.com:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220076-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[vinarskis.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@vinarskis.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vinarskis.com:mid,vinarskis.com:dkim,vinarskis.com:email]
X-Rspamd-Queue-Id: 44F941C4D0C
X-Rspamd-Action: no action

Current hardcoded name prevents adding multiple st-sensors devices
on the same platform. Fix by aligning trigger name with other drivers.

Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
Some platforms such as Dell XPS 9345 contains multiple accelerometers.
Fix st_sensors that currently only allows one device at the time.
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 8a8ab688d7980f6dd43c660f90a0eba32c38388b..3b5615d1b6dd66ee0af6ccc83eb2fbd7b2c64d29 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -124,8 +124,9 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	unsigned long irq_trig;
 	int err;
 
-	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
-					     indio_dev->name);
+	sdata->trig = devm_iio_trigger_alloc(parent, "%s-dev%d",
+					     indio_dev->name,
+					     iio_device_id(indio_dev));
 	if (sdata->trig == NULL) {
 		dev_err(parent, "failed to allocate iio trigger.\n");
 		return -ENOMEM;

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260228-st-iio-trigger-8ee1f219b566

Best regards,
-- 
Aleksandrs Vinarskis <alex@vinarskis.com>


