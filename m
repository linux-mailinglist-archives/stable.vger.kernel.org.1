Return-Path: <stable+bounces-211851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEWQAJrgeGkXtwEAu9opvQ
	(envelope-from <stable+bounces-211851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:58:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA089740A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 294E8300AC1E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086FA33D4F3;
	Tue, 27 Jan 2026 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+Y1qTAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6420B810
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529125; cv=none; b=TgiyhJjV3yi62EXX4KO/uOUFe2pN5gZ1dgnV0KMv/0dOlH3Jiu21CTPsgDqp4g/Yk5DBX12VRA5qV7pL+kwoVI8X5RNzvKh9tgyE39uzGD2noa0OUimMSQQzgaK9ln/r1/LlM8p/VeeZqDuiHcq/upXA1h7yVyskZjdKY2p+oZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529125; c=relaxed/simple;
	bh=5FJU4OgCOpfnzWdCyGfS8jDDD+283hQoX0yrU9QKiXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+vCQRzPPFOmCASo7QL2zV4cpUPx5fqOLB1y28DmbSbF/cwiSSDWq2KhYe5Ri31IdyVbq4SBQ6ziI3ji8uY1v94qE+lgSrYbbtEKQ/vKG1D6sjHrWlXn2ZuNh0FarhY6ja8Tqd2D43v9b3nP+oJc0OkbKFNsZF98pA4yiHmZCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+Y1qTAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DFBC116C6;
	Tue, 27 Jan 2026 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769529125;
	bh=5FJU4OgCOpfnzWdCyGfS8jDDD+283hQoX0yrU9QKiXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+Y1qTAIUKjkgnLS99VJbxyI2w6GMNoZK979j7zQQ3BehfjdpUR49oDgjFMephJaW
	 hJF5dK7C/ic1+TE/KYX2OO4+bmb9D4gEx7o9RTj4lPdxJunloPVunfpjeNhpSnQi8z
	 jsF7pq41BJR4EJx/yG2nYHrb/QfjBLf2YJahcaKQAFH17e531j6V8HVPHcrUkea/e8
	 AHPnDO6pE2Xe/LgKyN9mhvFc2CDUIJsySXlPpTyNlqqrAhdHACOq+Q5A/onGYicaT5
	 R7w5rLQXtrD7bNARD4F0+o5tJn+zagpaXWgG7wSr0dHlR2R4SfKhNmD2orq/Gr0Ky+
	 lDlJhsZZgE1bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fiona Klute <fiona.klute@gmx.de>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: chemical: scd4x: fix reported channel endianness
Date: Tue, 27 Jan 2026 10:52:02 -0500
Message-ID: <20260127155202.1927098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012713-ethically-lily-296c@gregkh>
References: <2026012713-ethically-lily-296c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,baylibre.com,huawei.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211851-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,huawei.com:email,gmx.de:email]
X-Rspamd-Queue-Id: 7FA089740A
X-Rspamd-Action: no action

From: Fiona Klute <fiona.klute@gmx.de>

[ Upstream commit 81d5a5366d3c20203fb9d7345e1aa46d668445a2 ]

The driver converts values read from the sensor from BE to CPU
endianness in scd4x_read_meas(). The result is then pushed into the
buffer in scd4x_trigger_handler(), so on LE architectures parsing the
buffer using the reported BE type gave wrong results.

scd4x_read_raw() which provides sysfs *_raw values is not affected, it
used the values returned by scd4x_read_meas() without further
conversion.

Fixes: 49d22b695cbb6 ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/scd4x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 54066532ea458..690c70b94a57b 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -518,7 +518,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -533,7 +533,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -546,7 +546,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 };
-- 
2.51.0


