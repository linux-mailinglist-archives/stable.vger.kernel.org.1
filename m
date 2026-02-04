Return-Path: <stable+bounces-213911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKctIe5rg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-213911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:55:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88872E99A4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56306307E933
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8164219EF;
	Wed,  4 Feb 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xh1eeeOd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128603D994;
	Wed,  4 Feb 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217926; cv=none; b=csFDHslT8/cimU7QtZL8c16IZvjXADiVuUudzUWcfVyakDzavBVKpPmvmnMMsGZHATOhqvFlsbcQYxLxvLizu9ZSFNe2E+g06qysTgpd2P6+f/6tJqP0hqBPr12AcaN1G0nDnfAA6sXsZjCWfXIVdzgjCZaWwOeBeETiMaaVjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217926; c=relaxed/simple;
	bh=QrY7Mj5AKqaLwBO7ly2fg1nBp9f2ny7VQr25fq64i7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojOVQsOOKJzQULZTYgaS7Y9OSPL1GekssMicVFfsWJzyc9/DTm1lQsIcaWWIvwuREXhbE0sUmLcTyYSqabMfQAUFQ0kTxTU360krpKjxb2gNQZhsbNxTDrvjSBbuDYHHV/ff9xPLEg6fK40nakzuQHijYmpUnLQpkOhkCctKPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xh1eeeOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769B5C4CEF7;
	Wed,  4 Feb 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217926;
	bh=QrY7Mj5AKqaLwBO7ly2fg1nBp9f2ny7VQr25fq64i7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xh1eeeOdGC4UA4/+WyZs/SGSsz+Ir0gO1NsOgajvz9hSHu61XO7ZlGaD1LeVgmtUQ
	 w4jB+cItdLJIEZNW5n/Hxg26xyOQ1nv57AIrx08BQ97QUMSPSMGjLCcVPfA33CcTGb
	 uOir3JId2UbT6K2a4E2mtKnlOfVpAAtPjIYjRrvE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 127/280] iio: adc: ad7280a: handle spi_setup() errors in probe()
Date: Wed,  4 Feb 2026 15:38:21 +0100
Message-ID: <20260204143914.206822501@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213911-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,kaspersky.com:email,analog.com:email]
X-Rspamd-Queue-Id: 88872E99A4
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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




