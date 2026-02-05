Return-Path: <stable+bounces-214435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGXYOVJphGlK2wMAu9opvQ
	(envelope-from <stable+bounces-214435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 10:56:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511E6F1152
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 10:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD9913012248
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3193A4F2F;
	Thu,  5 Feb 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCa3tlHY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BD2D6409;
	Thu,  5 Feb 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285347; cv=none; b=jr4fpRWJrH9bOZjTueflvLZpCwZ9jBQWE30U4IckIH+DTZ3xJDAZfg84rLwsXI+NC1uI/rDK9FIH2f0Zydjt41ujPSti4nQnntT54NRxtJr5xXP82UDJMUuN5T9qJJGXbonVnwSsjPW1gWn//MF9zH3ZZeiR+WnIMYl1HASw1yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285347; c=relaxed/simple;
	bh=jBuAOB8bdqvBnhj5fUSQazKsMCWV4Cz4HIYyuTqlq/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qKoPNKyksfzHTYlvHbYL/OMoz/UO6Q51HhmUix//N46B9n+hzIHgfd9IuYTtU7KCZR1P/2jnfCMMcBHzwSR+9DsHvDCnIHUe6mfsegq3EWxlkK+SYp0mC5qMzHAGBkCBpIAFiPBXdcY3w/Tus9xNnp+xICphEk2zYFbdSWgN6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCa3tlHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7161DC4CEF7;
	Thu,  5 Feb 2026 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770285346;
	bh=jBuAOB8bdqvBnhj5fUSQazKsMCWV4Cz4HIYyuTqlq/s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CCa3tlHYW74kvgHYRDB0TPc+LPDzkPbaZ6B8rOtFcrro+q53kiRXSvIL1GFk+QjuA
	 zRtLItsY/MjyC8FU1LvbWnNBgv4RvYpaICTFFYz2LdP+7/eHz5uPbuIEaQS2s9SOHB
	 qhasp+FuMo/C7xhFp65jiREGj7n230spo64gTyp8Erfn/tjPVJqgg8uGQuAru0BL97
	 fNWXYPpa0yrUqORtNXgiup8VFzs4bS/7jCKiWl8pGQwzWpcfJogZAKcGCLm5Yab6xZ
	 jrzR1DcuZSxmR3sAxMQI6671cHKChdXnwsiyqsRbUueG7/QJBBQi4ueH31LJHmw0ML
	 2P81/jIZ0PLAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F33BEC1E89;
	Thu,  5 Feb 2026 09:55:46 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 05 Feb 2026 10:55:38 +0100
Subject: [PATCH] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com>
X-B4-Tracking: v=1; b=H4sIABlphGkC/x2NQQrDMAwEvxJ0rkBWmhT6ldBDYqvtHuoGO5hAy
 N8repxl2DmoWoFVuncHFWuo+GaHcOkovuf8MkZyJhUdRWVg5MaIn+swivATuw9b4FTQjBdsfEt
 Bbe5NY1Lyl7WYW//C9DjPH2evK0pxAAAA
X-Change-ID: 20260205-inv-icm45600-fix-int1-drive-bit-7d12ea3e2cd2
To: Remi Buisson <remi.buisson@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770285345; l=2029;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=jonlpc2vCCKoNTffAcqdw9gt54oqvhg5uNYQzxvrOqc=;
 b=5vsMRdNmsBMDk/bEXxMe0CHV8sOVUQ5BP6DYKkfDmmjilUh4irqWX5vYNYJUnCQ06gj6iVmPx
 TmZGs1Xjzz+ADbgOMIgddjMr17moPL0PV9EPmuuF4y4pfMmvp//E53u
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214435-lists,stable=lfdr.de,jean-baptiste.maneyrol.tdk.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[jean-baptiste.maneyrol@tdk.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tdk.com:replyto,tdk.com:email,tdk.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 511E6F1152
X-Rspamd-Action: no action

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Drive bit must be set for open-drain mode and be cleared for push-pull
mode.

Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/imu/inv_icm45600/inv_icm45600.h      | 2 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
index c5b5446f6c3b43150512bcc4357cee385080b634..1c796d4b2a4038203f734f80d7bf7bad138c3497 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
@@ -205,7 +205,7 @@ struct inv_icm45600_sensor_state {
 #define INV_ICM45600_SPI_SLEW_RATE_38NS			0
 
 #define INV_ICM45600_REG_INT1_CONFIG2			0x0018
-#define INV_ICM45600_INT1_CONFIG2_PUSH_PULL		BIT(2)
+#define INV_ICM45600_INT1_CONFIG2_OPEN_DRAIN		BIT(2)
 #define INV_ICM45600_INT1_CONFIG2_LATCHED		BIT(1)
 #define INV_ICM45600_INT1_CONFIG2_ACTIVE_HIGH		BIT(0)
 #define INV_ICM45600_INT1_CONFIG2_ACTIVE_LOW		0x00
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..b028044d609a41f6d4b747383323130ded0d2e79 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -637,8 +637,8 @@ static int inv_icm45600_irq_init(struct inv_icm45600_state *st, int irq,
 		break;
 	}
 
-	if (!open_drain)
-		val |= INV_ICM45600_INT1_CONFIG2_PUSH_PULL;
+	if (open_drain)
+		val |= INV_ICM45600_INT1_CONFIG2_OPEN_DRAIN;
 
 	ret = regmap_write(st->map, INV_ICM45600_REG_INT1_CONFIG2, val);
 	if (ret)

---
base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
change-id: 20260205-inv-icm45600-fix-int1-drive-bit-7d12ea3e2cd2

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



