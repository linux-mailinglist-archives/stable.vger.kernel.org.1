Return-Path: <stable+bounces-273960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V9w5HpwvVWpTlAAAu9opvQ
	(envelope-from <stable+bounces-273960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:34:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC474E834
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JFcKqaGl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273960-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273960-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59699300BE99
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD81352025;
	Mon, 13 Jul 2026 18:33:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA2335BB4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:33:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967633; cv=none; b=cVLRxJM1nsvBzy/ptUMtNSnEeXLEXld5q75D12RVzd/Uzw2KmVQiP6ZZ94G+VAc/hxfdNcuWOpo8XwYArn/xoinNcfUnw0txLrlHMr7IfmbEgM6Afvf4Uvn+M3lGmf+gU6Abf9uWtdLqsYQF5G9mPUREAGMyISlWDj7tyiOgljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967633; c=relaxed/simple;
	bh=u1YLNUC8PYJdKXzu336gyE8oi0QIO9J2WJ1QD4SmN7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlZYk0nHJBXzUHghqg9JoqZ1UOY9sjpw6JikJEWeeRqor5WWiQC7Bq8z7r5i0JFz9A4+Y8ZC74fPaZpjM3UqT1bjeldW9b7zeKh3+N7WOfIVaXwhzpnn5dxYSq+ODDI4/jrDs2+85tUHuhABMta9zA/W1DKRfZQe9gm0wb1aa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFcKqaGl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1931F00A3A;
	Mon, 13 Jul 2026 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967632;
	bh=B5tj67aFz/QCjhovtik7je4u3RDVA1q9Uw4xIkPJNHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JFcKqaGlBOV5qqjmN1RreowmZvTkCy4u0sclPYOa/HsemltVqVyNPDpF+wJCJuL+h
	 D/p1Iq6AMWior32cYsbRErzr5hcE0B3k6sXWjhhFc9QsuaH0dI3GT9ZEdGpNhPUBzN
	 rsyf6hXNEV+TolzFfWevt3LqiQ/5WxhJv4Evf27poSEOQ7zcEIhlFR2MSGx3YiD/xd
	 cOK0CxShvySh7tOE1lCXIWBXAFrQpT0P0x6551ZVxv+lqbyw0kJwN3gNhXdMbM1kbX
	 k7fJaUTfbfSikbTSlaVa4RMH2qKtxDqeOyKM82TFLjzIFMaGUQ66ykZD1GUZ/eGVWS
	 Itt10SFUkXvTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] iio: imu: inv_icm42600: stabilized timestamp in interrupt
Date: Mon, 13 Jul 2026 14:33:47 -0400
Message-ID: <20260713183348.1951183-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713183348.1951183-1-sashal@kernel.org>
References: <2026071317-seventeen-sedate-4f50@gregkh>
 <20260713183348.1951183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:jean-baptiste.maneyrol@tdk.com,m:Jonathan.Cameron@huawei.com,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273960-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tdk.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89EC474E834

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit d7bd473632d07f8a54655c270c0940cc3671c548 ]

Use IRQF_ONESHOT flag to ensure the timestamp is not updated in the
hard handler during the thread handler. And compute and use the
effective watermark value that correspond to this first timestamp.

This way we can ensure the timestamp is always corresponding to the
value used by the timestamping mechanism. Otherwise, it is possible
that between FIFO count read and FIFO processing the timestamp is
overwritten in the hard handler.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240529154717.651863-1-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 19 +++++++++++++++++--
 .../imu/inv_icm42600/inv_icm42600_buffer.h    |  2 ++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index e6d25844cf026f..be123c2f41131a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -222,10 +222,15 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 	latency_accel = period_accel * wm_accel;
 
 	/* 0 value for watermark means that the sensor is turned off */
+	if (wm_gyro == 0 && wm_accel == 0)
+		return 0;
+
 	if (latency_gyro == 0) {
 		watermark = wm_accel;
+		st->fifo.watermark.eff_accel = wm_accel;
 	} else if (latency_accel == 0) {
 		watermark = wm_gyro;
+		st->fifo.watermark.eff_gyro = wm_gyro;
 	} else {
 		/* compute the smallest latency that is a multiple of both */
 		if (latency_gyro <= latency_accel)
@@ -241,6 +246,13 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 		watermark = latency / period;
 		if (watermark < 1)
 			watermark = 1;
+		/* update effective watermark */
+		st->fifo.watermark.eff_gyro = latency / period_gyro;
+		if (st->fifo.watermark.eff_gyro < 1)
+			st->fifo.watermark.eff_gyro = 1;
+		st->fifo.watermark.eff_accel = latency / period_accel;
+		if (st->fifo.watermark.eff_accel < 1)
+			st->fifo.watermark.eff_accel = 1;
 	}
 
 	/* compute watermark value in bytes */
@@ -517,7 +529,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 	/* handle gyroscope timestamp and FIFO data parsing */
 	if (st->fifo.nb.gyro > 0) {
 		ts = iio_priv(st->indio_gyro);
-		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
 						st->timestamp.gyro);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
@@ -527,7 +539,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
 		ts = iio_priv(st->indio_accel);
-		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
 						st->timestamp.accel);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
@@ -578,6 +590,9 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
 	unsigned int val;
 	int ret;
 
+	st->fifo.watermark.eff_gyro = 1;
+	st->fifo.watermark.eff_accel = 1;
+
 	/*
 	 * Default FIFO configuration (bits 7 to 5)
 	 * - use invalid value
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index eed6a3152acf48..ffca4da1e24936 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -32,6 +32,8 @@ struct inv_icm42600_fifo {
 	struct {
 		unsigned int gyro;
 		unsigned int accel;
+		unsigned int eff_gyro;
+		unsigned int eff_accel;
 	} watermark;
 	size_t count;
 	struct {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 99eb651743f80f..2f9a0e7fada43f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -523,6 +523,7 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 	if (ret)
 		return ret;
 
+	irq_type |= IRQF_ONESHOT;
 	return devm_request_threaded_irq(dev, irq, inv_icm42600_irq_timestamp,
 					 inv_icm42600_irq_handler, irq_type,
 					 "inv_icm42600", st);
-- 
2.53.0


