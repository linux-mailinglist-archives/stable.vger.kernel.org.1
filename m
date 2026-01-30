Return-Path: <stable+bounces-212892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB87MP3XfGlbOwIAu9opvQ
	(envelope-from <stable+bounces-212892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:10:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F0BC689
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A2E301A405
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05B347FE6;
	Fri, 30 Jan 2026 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDCfqAuM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08795346FAE;
	Fri, 30 Jan 2026 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789434; cv=none; b=LSUjRm1ePqGQAqiXeF7xSBgUyOzWjQhMB53DUOKQUGt4MbwyGlaesTsQBfkt+9DZNTtvBN1c75u8rQAlyZROeUMTsHkjpoLA59gbgOv7JL4oAh+vU+YmjC3a4Hzn/QB3NmvhaMddCFFarktzxaOYEiBI66TIO3hCv7LheO0hQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789434; c=relaxed/simple;
	bh=KTuap8kdmVW1GPDaErKGGJn+66swwrDJ78HyQS6jS04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Wrc3gU8pNZbsaxIAUZAfPoFsSKcKXa+badPc2NjdBNNqJ0ga2mj6R3TGQayjn2Oj7JSHV09/aS5xjeg0Yyq2JfczVJuxc28la9Y9o2t0wZXXU9H3nJJd9q2Ai/zyfalaHvyvANB72d2PgizgB7v5NX8Tzs+8WL04aHQE4Cgw678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDCfqAuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF3E6C4CEF7;
	Fri, 30 Jan 2026 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769789433;
	bh=KTuap8kdmVW1GPDaErKGGJn+66swwrDJ78HyQS6jS04=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=DDCfqAuMpAvJR6nkUUhZf89mM1BONa18Y5/pdPFH0emmX82uRqpyQ9+ZmlqJkghju
	 ta7N5XwLHyolV0bo2XS4L+7DkF05V8anBdsv4Sujc63ihkhZ3MQKdGBacbDBWgeYP/
	 rJhOSpw5INaE80EM4e65GodeK0xai0Uu2g7vJDG+siIRh9krVTP1mNIY69Trp16/py
	 WNhid2vHrUxtNk0mtcPqy5mll76lBnFPevj6goe1tVVJ9jD1vcbzFSVb9pc1n7vVTP
	 vpO3+gmhHirv42ZJcCbYQ1tD+gXQCzYw4CMptn7ss3y22B3kmIgiVNYiZTcUwz6E+p
	 V2hs7jwvG67Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD626E6BF1F;
	Fri, 30 Jan 2026 16:10:33 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 30 Jan 2026 17:10:23 +0100
Subject: [PATCH] iio: imu: inv_icm42600: fix odr switch when turning buffer
 off
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-inv-icm42600-fix-odr-change-when-turning-buffer-off-v1-1-f76fc3604bdc@tdk.com>
X-B4-Tracking: v=1; b=H4sIAO7XfGkC/y3NzQqDMAwH8FeRnBeoVpTtVcYOtiaaw9KRTh2I7
 74iHn/w/9ghkwlleFQ7GK2SJWlBfasgzoNOhDIWQ+OaztXeoeiKEt9toUOWH6bR8IpuMyl+F1P
 RCcPCTIaJGX0YfMf9vY2hh7L8MSrN8/X5Oo4/C1dNn4UAAAA=
X-Change-ID: 20260130-inv-icm42600-fix-odr-change-when-turning-buffer-off-3ba36f794cb7
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769789432; l=1938;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=V+V88fAK8S3LRNlRrvLoACHqnirAnUGI3yB4cFHD2YQ=;
 b=g1bZqJfpCPrJ6Njn9UJDzPM2DEnt6LVrFBiX/gWCn7lkV8DGRDW3D+/hYBGwzdGCiIHQzx6oV
 hLdoOSwSX6gBQ0waVHQe8B54J3gyCAmt5WQX/UWURwo/IEMsl/Fc+cs
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212892-lists,stable=lfdr.de,jean-baptiste.maneyrol.tdk.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[jean-baptiste.maneyrol@tdk.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tdk.com:replyto,tdk.com:email,tdk.com:mid]
X-Rspamd-Queue-Id: 347F0BC689
X-Rspamd-Action: no action

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching odr and turning buffer off just afterward, we are
losing the FIFO ODR change flag and ODR switch is blocked.

Fix the issue by force applying any waiting ODR change when turning
buffer off.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index ada968be954d480a2022bc8aa6918f32e5e543f7..68a395758031884792781d6eee748d273a86a22e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -371,6 +371,8 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -392,6 +394,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;

---
base-commit: 62b44ebc1f2c71db3ca2d4737c52e433f6f03038
change-id: 20260130-inv-icm42600-fix-odr-change-when-turning-buffer-off-3ba36f794cb7

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



