Return-Path: <stable+bounces-212487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP/zAuszeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A63A511E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB0E30AAF05
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEE30274D;
	Wed, 28 Jan 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3MDl79n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092973033F4;
	Wed, 28 Jan 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615682; cv=none; b=CpeeFu646oniwsvZgXS9Gqm0/L1JZPjdbalKAh4No3uiHX5vLSTzEisJVWupzztl1iZvN99RMN2yH2fTKqMDdwvyJetcnhYWznsdsMjRBbgJYrxQLYzrBBE4pVxZqyTLcVLGXPGQJ+wAxdNfIsdrTQpfS0yqnX6Sec2Fa+LwOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615682; c=relaxed/simple;
	bh=C8K3LrlWfrtqKvkD144qdJ/+O0gyk1Qs/C2xJY3npiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlDS4m7e7ObT2C++ZNhaMrRXvQhm80KzcR17l+EpxjWeDBBTFXOoyrry3s9EBXHESto4cO3XvrcWZJiG395nzCDTdh2+Bffn8k4fwWucg2pSjrrIvEQbGGZGsudLbGazM8sm9bN1Mo6EesGYgioLGCczc53eA2ICSFz1YbIQw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3MDl79n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3DCC4CEF1;
	Wed, 28 Jan 2026 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615681;
	bh=C8K3LrlWfrtqKvkD144qdJ/+O0gyk1Qs/C2xJY3npiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3MDl79nsnmZnK/b0ePjTnbQ6uVl0T4tQHyQa4zUpzrvPL3N7FDblsT2dXvTCsj+B
	 JVEKTvknQ3Htvuga7ARGzq5esI+2aXg73KwV03uETcw+L3DkUGcngdWIMIgHf6c9uj
	 86cmrbFupcJnbNMNavvhZd8LXYES0jHqgx2s6kCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 082/227] iio: adc: ad7280a: handle spi_setup() errors in probe()
Date: Wed, 28 Jan 2026 16:22:07 +0100
Message-ID: <20260128145347.293258379@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212487-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,analog.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kaspersky.com:email]
X-Rspamd-Queue-Id: 66A63A511E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 50a6ff7c8b1c7..ba12a3796e2b1 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -1024,7 +1024,9 @@ static int ad7280_probe(struct spi_device *spi)
 
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




