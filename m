Return-Path: <stable+bounces-212890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJcTBZ/QfGlbOwIAu9opvQ
	(envelope-from <stable+bounces-212890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 16:39:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8DDBC1C3
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0962A3011B72
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A0F32E6BF;
	Fri, 30 Jan 2026 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSYHkMnH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3533ADB0;
	Fri, 30 Jan 2026 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787539; cv=none; b=oNrJRDJwUOHAYPyCjTH6ckeqDTQDCF8hwjAqf2/Gy5Gw6Gb5FWpCaf2eB4xN2Jh61iSEXzJTGY0pdYbZVDeUycbbyZn/7KKz8hhglsiamFebNvDa6GimU4uBpS35Jc008240Ihgwm5NfD0wVj0XwSJ2Ueu/pnNy5SSfAJpJypFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787539; c=relaxed/simple;
	bh=iHiJRrjTly3jAX19XuLPgUXslc9svIoVKTSGZtd3tF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PciZy1XueEQwVXNjncwm4Sol8Dw/ZxDGBuX/fQNJgvFg9ZjJan5zlaGbOLLLuLUDu59m2oDBt5ADDE+sjqedGvHjoY/+lp3gXbWGckMiM7xtl5j66GEuXOoQEHJOYXx9PX07UjR+2enAtYVWE12A0PAlNyBAIDsuC5LY7p7wqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSYHkMnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE97FC4CEF7;
	Fri, 30 Jan 2026 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769787538;
	bh=iHiJRrjTly3jAX19XuLPgUXslc9svIoVKTSGZtd3tF0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CSYHkMnHV6UEcDoRGjoNkOZNiFFpFERcMXL4OZnYGkW6tyELpjdTH5dNhHzhUDK4J
	 ll6jYi4bsiid6qdeJXKj2Ws8TWufZ0vfUPRY96YCCXHxvClob9zHe3hGxL82LYs9Ko
	 SExe2YuPTY3flWa3xF9kedfrWL6c1VMhZiVqZSvLsuLcVTlD4CnG/A8QG7ahiWuiXJ
	 rIr8X6LuXhxJlVns9H4H6IA5Yg36i4pRKgTfoucpFwLMNeMNnMeLreyco7an09B3u9
	 rfhxJkGCiMoke9R6bgme18WLrCcMsaEWsFkswpg57eBagaDLhAXDbH9yw6n/MB9hPB
	 lERXt/nw2rSRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF536E6BF20;
	Fri, 30 Jan 2026 15:38:58 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 30 Jan 2026 16:38:47 +0100
Subject: [PATCH] iio: imu: inv_icm42600: fix odr switch to the same value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-inv-icm42600-fix-odr-change-v1-1-347a03a57fa1@tdk.com>
X-B4-Tracking: v=1; b=H4sIAIbQfGkC/y3MSwqAMAwA0atI1gb6Q9CriAu1UbOwlRaKULy7Q
 Vw+GKZCpsSUYWgqJCqcOQaBbhtYjznshOzFYJTplLYKORTk9XRChRvfGH3CP+0NuU0vnpzVIIc
 rkRTffZye5wVAScWLbQAAAA==
X-Change-ID: 20260130-inv-icm42600-fix-odr-change-92e4f1bde431
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769787537; l=2088;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=rFQH6wdMXA8+FMQIBC/54JO8ilgcnHM/BrtDPx5h0/I=;
 b=EGAnytWi+eEGCX/Rq8LlqGxsO1BaSuO5nPpnqPMeEIYUH+ECk/7ptVeJpA58dvB4B6wHh2hYK
 p3BOUUpf/rXCBzfZtxlYUknVBw8p6piQ2na0IwiDZ1HBUYkFY1pPYd1
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-212890-lists,stable=lfdr.de,jean-baptiste.maneyrol.tdk.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[jean-baptiste.maneyrol@tdk.com]
X-Rspamd-Queue-Id: BF8DDBC1C3
X-Rspamd-Action: no action

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching to the same odr value, we end up waiting for a
FIFO ODR flag that is never happening.

Fix the issue by doing nothing and exiting properly when we are
switching to the same ODR value.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 54760d8f92a279334338fd09e3ab74b2d939a46d..0ab6eddf0543feeb51170271d766a732d1e45544 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -651,6 +651,8 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	conf.odr = inv_icm42600_accel_odr_conv[idx / 2];
+	if (conf.odr == st->conf.accel.odr)
+		return 0;
 
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 7ef0a25ec74f6b005ca6e86058d67d0be67327df..11339ddf1da36c85e56de6c4a95486713cbd182a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -358,6 +358,8 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	conf.odr = inv_icm42600_gyro_odr_conv[idx / 2];
+	if (conf.odr == st->conf.gyro.odr)
+		return 0;
 
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);

---
base-commit: 62b44ebc1f2c71db3ca2d4737c52e433f6f03038
change-id: 20260130-inv-icm42600-fix-odr-change-92e4f1bde431

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



