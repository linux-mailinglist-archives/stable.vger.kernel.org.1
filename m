Return-Path: <stable+bounces-273958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZvHoN5EvVWpNlAAAu9opvQ
	(envelope-from <stable+bounces-273958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:33:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A51374E827
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:33:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B+dBFzp4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273958-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273958-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC76A3018881
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27B352C5B;
	Mon, 13 Jul 2026 18:33:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FF335BB4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:33:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967631; cv=none; b=Te4FgWhDMmJzdCRFaKJP+kPmA8+/yXFCL3PNXxwOHXfa2zixzSOm9f0BjRac2j9CKrOjSusx15UahFlCOhnK6PqfRuwUkGmUx6b99oiq5TKKDiJtpO7Lh4bvu13CNhlC7A3qclLg3YB2hhOw7qOQ9fvC+nRwS/2oRx7Ck3zl+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967631; c=relaxed/simple;
	bh=5y2SKtZnnT8/O8JUZQDjrAm77pL4DwNo5+Kqr0YdSo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJWu2M32JUTAN6BRX4SgC1cgFzOmtN/TcI/LqdXQ95nB16Lhpuq+ulr0PA/qN9uJlBdlFQh9c7Kn7LWIE9uN6vq3SM9Y4aWl/nOoqy+auPoYeb15HzJAjuq2ySCLQv/0YI60DhbFiEaUCg9U4a7AIojTW3pX/rN80GZA/sMhB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+dBFzp4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FF21F000E9;
	Mon, 13 Jul 2026 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967630;
	bh=StSp0Fh3i1fsb+9RKFDqqzUv/DBtftlsJd57gXOkeWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+dBFzp4fDgqspwLCz1B52GXRo5hc/mSF7v7yFWIOiCi4iblWSgJOq2SUHsH4gwvC
	 BQ60X2bkb0Bj9qVsnfHOMAmIC90ShHmBV+LnCAQDvyHuI1MON5EWZHzy7/unbakw65
	 gYzjkf7rgeokLu+aX6VR060C4bF0fYknkuZHq4tMUBz458ysJNzp+O0EUeVtl7hxgA
	 YLfmF9oHkPhkXLw5ZKe42CkcW0arWL1LGU8IVx97LBZwEVZm5NsOwi5GTSV4LXawXy
	 d03W3Hog5dZOi16HY3pFCv5zMePUgH1LVLukqS/ltprh12RnqGazQXeNJ6diXHIoxF
	 qt9VFeONxYrQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] iio: invensense: remove redundant initialization of variable period
Date: Mon, 13 Jul 2026 14:33:45 -0400
Message-ID: <20260713183348.1951183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071317-seventeen-sedate-4f50@gregkh>
References: <2026071317-seventeen-sedate-4f50@gregkh>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273958-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:colin.i.king@gmail.com,m:jean-baptiste.maneyrol@tdk.com,m:Jonathan.Cameron@huawei.com,m:sashal@kernel.org,m:coliniking@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,tdk.com,huawei.com,kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A51374E827

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
index e85be46e48d304..5985c99cc0b60a 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -139,7 +139,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
 	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
-	uint32_t period = ts->period;
+	uint32_t period;
 	bool valid = false;
 
 	if (fifo_nb == 0)
-- 
2.53.0


