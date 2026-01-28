Return-Path: <stable+bounces-212128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKUZK2cuemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:42:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB608A43BC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79282302ACB6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25A2C15A0;
	Wed, 28 Jan 2026 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTlVLANK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60C29B8C7;
	Wed, 28 Jan 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614487; cv=none; b=c4S3Y+Yp53pJ73EXmWf4qYJNw1LMwrtdwuHmDpkSGvNHaWU7L56hCXejO1NsmzL+MYcfmLBcvomYCbokB08yWR0YOm0puFdENqyE3kJz0LPR43S/ILWxpJ4JCfOO4WBvqXh7jTGD1hT+qFnkFOqhMtG80btgdw/3a+sjC8kpQ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614487; c=relaxed/simple;
	bh=2xu2eNUsEE5dBIfysc6PoApvdjjyRVfn5VmAcUBTTXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlQobHV0qncM0ODsUSvoCbo12/2qvil3o0fY6nHe9McFsiyVWIAqyUc+xsc4tgNKdmEq+ZJTyfSL0w/oqZOU/F3/rfZLf+08Ujh9QOUAHwNHJxwiITgE7a8ZKP3YV3mcwIc+BbWktHkKC6Hc+hFXA0xeNOvIqa8pfkpIhtf2x8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cTlVLANK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DC9C4CEF1;
	Wed, 28 Jan 2026 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614486;
	bh=2xu2eNUsEE5dBIfysc6PoApvdjjyRVfn5VmAcUBTTXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTlVLANKTupSvJa04qhcGLe2smI8lZDHIt+5PxKs1UeUrP1LikFipV81yHAXvTly1
	 VHufJt99kd88WDZBxM5QDhjnglL/CSj23IijAFDRCRIpt/6B0MdU8j4cYO+NFhDV7K
	 6S/OeJDdyhdTz81ZLYNBxhJCAgsWhN4itQhzQD/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 152/254] iio: adc: ad7280a: handle spi_setup() errors in probe()
Date: Wed, 28 Jan 2026 16:22:08 +0100
Message-ID: <20260128145350.280811243@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212128-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,huawei.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kaspersky.com:email]
X-Rspamd-Queue-Id: BB608A43BC
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>

[ Upstream commit 6b39824ac4c15783787e6434449772bfb2e31214 ]

The probe() function ignored the return value of spi_setup(), leaving SPI
configuration failures undetected. If spi_setup() fails, the driver should
stop initialization and propagate the error to the caller.

Add proper error handling: check the return value of spi_setup() and return
it on failure.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7280a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index 9080c795dcb7e..10cc623bf62a3 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -1028,7 +1028,9 @@ static int ad7280_probe(struct spi_device *spi)
 
 	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
 	st->spi->mode = SPI_MODE_1;
-	spi_setup(st->spi);
+	ret = spi_setup(st->spi);
+	if (ret < 0)
+		return ret;
 
 	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
 		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
-- 
2.51.0




