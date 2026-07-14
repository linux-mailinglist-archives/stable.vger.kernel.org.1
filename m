Return-Path: <stable+bounces-274093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PemYNranVWrBrQAAu9opvQ
	(envelope-from <stable+bounces-274093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465EB7508ED
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:06:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ktmLrVr+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274093-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274093-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E26304CE8E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155937F8A1;
	Tue, 14 Jul 2026 03:04:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3F36C9D0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:04:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998291; cv=none; b=atixNz1E6T/XPq7ORV7BqptqvD6hZLxrv6ezfqXdOQ2785j7I7eNJUeyUm2A63C+VXWKUkLKaXbEsreFO8FezoVSZv2JDSo3/GHMvrXaABjW1Nfd/tEdKk2lxZlQa5ayus9ysKPXJvcSpgTJtgPWn3okzIe8WVCXnpKcqW+mq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998291; c=relaxed/simple;
	bh=y9Tx4O4Kh7/Qy6StTSTQcuqiwyc11VYYBjAz6Es0UOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSn6QPkWaJLNM6Wh+Nthqzjl60rF8JA+dvM6sgxyE2q3PZuWU5qvLhitqLZNrXGm0FpwyEZA09MCY9pKc9ZuiAny4yUFAciCZxU0gU0qJQOWrI8ZnheKCo1q9EtxMX8AuvQ3BQ/6Duka5x9T6grtzyyGmhcfjpsNSqIYOjRqzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktmLrVr+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B289C1F00A3D;
	Tue, 14 Jul 2026 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998290;
	bh=SbryL8lRD5vxlaZlIgmZu6POLaVLtYTK41V1nV9Zq3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ktmLrVr+fifWiyqdk/AEdb15utff9a4KhvyNzhSY6BjLM5IkO3gq+8yT0iPEe7vJC
	 3qG/ROmJhjrUk2BTnYCkaUZjTeVyiMVxVFffaxfzkxD/JqPUC7QbVyzvrQiO9bnv2h
	 vP9eGAreFW/A4TByDBeycOQ743ZRW+QW2qpc3X/104eiwSMCkleH+NOvCjcx3r1lmb
	 wqeBJH95DLvO7+oGCtS2M5bzFrfXohVrtRbeIGPVzeoqYs4QdfUHbeRzYHU67bHj2U
	 N1pvBUt+YyUQFONHGU7FK8tBFXt0+eUSmJ84z4tTJ500vsPgRJzWb8nZ/stYOEyXLJ
	 7/ErmDAvBWdkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/8] iio: invensense: remove redundant initialization of variable period
Date: Mon, 13 Jul 2026 23:04:41 -0400
Message-ID: <20260714030444.2382550-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714030444.2382550-1-sashal@kernel.org>
References: <2026071317-litmus-defame-e23c@gregkh>
 <20260714030444.2382550-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:colin.i.king@gmail.com,m:jean-baptiste.maneyrol@tdk.com,m:Jonathan.Cameron@huawei.com,m:sashal@kernel.org,m:coliniking@gmail.com,s:lists@lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,tdk.com,huawei.com,kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-274093-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 465EB7508ED

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit b58b13f156c00c2457035b7071eaaac105fe6836 ]

The variable period is being initialized with a value that is never
read, it is being re-assigned a new value later on before it is read.
The initialization is redundant and can be removed.

Cleans up clang scan build warning:
Value stored to 'period' during its initialization is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240106153202.54861-1-colin.i.king@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 033d3788dcf73b..77ab578ee1698d 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -105,7 +105,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
 	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
-	uint32_t period = ts->period;
+	uint32_t period;
 	int32_t m;
 	bool valid = false;
 
-- 
2.53.0


