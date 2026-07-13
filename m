Return-Path: <stable+bounces-274010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NRoYGSZNVWpUmgAAu9opvQ
	(envelope-from <stable+bounces-274010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:40:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80C74F1AD
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:40:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aT77MioV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274010-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274010-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C49C33028C30
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08635DA6E;
	Mon, 13 Jul 2026 20:39:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F135CB66
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:39:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975191; cv=none; b=EZ3u7z2oPoNDJCOVFXWohp3c0nuv2W8zOJPlEeNZVOQOVGxGUc3qD2RFxOagCmRMQGhvEafBcVKtvI0np69GAkMYofoIPhPLI6sVqposuNNF2qwbWPjXcJdfOc0Eklh6bJrX1HLz6zPlrlo4jNS/x+W71ijSqKQF2GLK7yCVcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975191; c=relaxed/simple;
	bh=C0b8YQMYrkxz96S/FlxVqcWnu75kU5R99j0CWjf1P1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCQG1/XmRzHa96H5ie7fQuSymNoqZDbSOSJ8SkRLpTAVvLavywOU4NAofCxQT3/VQ4lhKoCNZS14Z/GyPe48Rp6njPSxVb6rVt8MhGUzJL7iWZGN65P9Y17OWL2zs2PfL3Ea7hyQdrWLJZHjIzCCzbxAO5PjsmTf9qGqETGrKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT77MioV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B151F000E9;
	Mon, 13 Jul 2026 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975189;
	bh=wgij119h4Ic3aKxvCw/XenO7sElbW5RWT2PD5i53sZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aT77MioVW9kNC49Vd6Cd2Q/g2WMWt9NbdB0YA3qn5ineMor3/4/tY8uBZGgbicw2J
	 HQam3+u0KG7GkEKDsZSurYzPmwLpGyAFllOAF9m5ru/79y9taIyKrPw7/84T6e7Oll
	 XPUlc4O1rJHJpVpeAnadyeNJk7Xx8hgvi3umc6shnpZC4rJDYett4Fmi1rGkOwLK2P
	 xv5Oyi68dwaqqEbAIy3F+baIPCET0n1Hsa+Btq8dvWJYG2pWGJhqOnRN4anjhMTE3l
	 a/fSOujuxgdnnMgFTVRP5cGHo6+h+FraJGT0skn0r6ej78raMm2Mr0PRMo8cOgZ943
	 2gYICcAYyd5/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 8/8] iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading
Date: Mon, 13 Jul 2026 16:39:42 -0400
Message-ID: <20260713203942.2144352-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713203942.2144352-1-sashal@kernel.org>
References: <2026071317-shortwave-thrift-0c90@gregkh>
 <20260713203942.2144352-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:jean-baptiste.maneyrol@tdk.com,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274010-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tdk.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E80C74F1AD

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit affe3f077d7a4eeb25937f5323ff059a54b4712c ]

Timestamps are made by measuring the chip clock using the watermark
interrupts. If we read more than watermark samples as done today, we
are reducing the period between interrupts and distort the time
measurement. Fix that by reading only watermark samples in the
interrupt case.

Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 9 +++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index f05b4d840c5b5c..cb4520b184b01b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -257,6 +257,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 
 	/* compute watermark value in bytes */
 	wm_size = watermark * packet_size;
+	st->fifo.watermark.value = watermark;
 
 	/* changing FIFO watermark requires to turn off watermark interrupt */
 	ret = regmap_update_bits_check(st->map, INV_ICM42600_REG_INT_SOURCE0,
@@ -476,11 +477,10 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 	st->fifo.nb.accel = 0;
 	st->fifo.nb.total = 0;
 
-	/* compute maximum FIFO read size */
+	/* compute maximum FIFO read size (watermark for max = 0 interrupt case) */
 	if (max == 0)
-		max_count = sizeof(st->fifo.data);
-	else
-		max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
+		max = st->fifo.watermark.value;
+	max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
 
 	/* read FIFO count value */
 	raw_fifo_count = (__be16 *)st->buffer;
@@ -592,6 +592,7 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
 
 	st->fifo.watermark.eff_gyro = 1;
 	st->fifo.watermark.eff_accel = 1;
+	st->fifo.watermark.value = 1;
 
 	/*
 	 * Default FIFO configuration (bits 7 to 5)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index f6c85daf42b00b..933dab828d9486 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -34,6 +34,7 @@ struct inv_icm42600_fifo {
 		unsigned int accel;
 		unsigned int eff_gyro;
 		unsigned int eff_accel;
+		unsigned int value;
 	} watermark;
 	size_t count;
 	struct {
-- 
2.53.0


