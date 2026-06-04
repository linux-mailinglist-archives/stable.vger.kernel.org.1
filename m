Return-Path: <stable+bounces-260587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bHG7NFwPImovSAEAu9opvQ
	(envelope-from <stable+bounces-260587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 01:50:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A9B644061
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 01:50:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QC7xqhSH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260587-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260587-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4260C3018096
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E728533B6EA;
	Thu,  4 Jun 2026 23:49:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84123D2B1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:49:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616944; cv=none; b=EO+02dse74H93RtSjUVurd94WC8SfVdaWT4fkgBQBOfphwVxOmW6WXBLXuZ0VhJpbPFfJ3uJPpOYCfQ7+/RiEDDjOa48jSY0uMxiObrqUORHGOn9nPADFIR6Frwo93QNabOsKt/HnLEuYJKRhioDLIAsA8hj8qG7RuRkQqPgwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616944; c=relaxed/simple;
	bh=O4PDZbDnXWuNAYquRFCuqIe7IszbssvURL9HaT1KG5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWoI935rs31bJe5ZBlcYIImKcnsfRLn8nhtutteKiYDVt1ksnRe5KJM6E+01Hy8+W48kHRqUgoEdbt2/iLMydUmECkna8KbR5Sl4AM3v9K1+SZNg9jgfHqCLXvusHk6MvCSZsFCXHiVJoluJSo8b49QuIm7BXU9xCyS2pi2csyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC7xqhSH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283441F00898;
	Thu,  4 Jun 2026 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616943;
	bh=gAtqo9cjLqEFmXHTps0e0su8tHFGAIt/h9zkXch/fZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QC7xqhSHUKFWEhSOoa+kMJ+KcU1MtGyRGcMLOtq4rCuu6tWByr3Vc3/J8RIr95GhY
	 foXZGnYpImoOGVKMbSqyHrHRzZVJoNvjHy+7nUG8uRgFtS2pjhXaviyApiH4T3qiYb
	 WSdpCFdBK1OkPY4Fw8zzsIQ6UNIwiVZfXS0lMXKuwc71Mck0+jLwF5GKkRZ4R6ZJwQ
	 R9peAA5PyirYpQU6RRzLNS2ENCQygWk4FCccOOeV/UFbAR6tp3+frvfeIXZ3tuPSCU
	 KcgeFr4Cm29b/GDnLehuPPT1fp4YYEktWmHCWSMhFo5guXmqBdFuV0hDj/IBaNiyV9
	 WGzBnL5AEuqWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] iio: chemical: scd30: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 19:49:00 -0400
Message-ID: <20260604234900.2467781-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604234900.2467781-1-sashal@kernel.org>
References: <2026060457-rubdown-rival-345e@gregkh>
 <20260604234900.2467781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260587-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:antoniu.miclaus@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35A9B644061

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit 5aba4f94b225617a55fed442a70329b2ee19c0a5 ]

Add a zero check for val2 before using it as a divisor when setting the
sampling frequency. A user writing a zero fractional part to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 10d44a14ac62f8..1f1b93f722cd2d 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -257,7 +257,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;
-- 
2.53.0


