Return-Path: <stable+bounces-242638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o6X+Ei/O9mkiYwIAu9opvQ
	(envelope-from <stable+bounces-242638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 06:25:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FBB4B4656
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 06:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D68E23001F93
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 04:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170B2D2495;
	Sun,  3 May 2026 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb5XgPwu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00E1D7E41
	for <stable@vger.kernel.org>; Sun,  3 May 2026 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777782312; cv=none; b=Ti75pOQ6mxIwG5JMRGsbmCxhO7zytJMZxvxX6FYZgxjG6MB80A45VsBFX6C8yv2nt90qyg5BDmPANNZU+9uQ0oRic4PSS+bNiUXlZQB6sxL5/IKRE0U8D8TYDiHMcFfjGTm0rivkFH7/3GOlZ4gwjDjNoRRWZdUrUKucZOH+RrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777782312; c=relaxed/simple;
	bh=V+EOqq9qYi4AMv7pFUMpujIl0oVH1GDKkDhe2ojm7CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqnO3htZO0zNcbiKfcpxhHEwcTqQNEsv6MtXwDUsT/2EyyhggdpGHpi3BOGH7C/UrvVepEKFthCEZtJAVK3VO6yyzmLH7PpVVZycoJKcsSPmyfnYqt4N9lXlwc647x66ei1xU/M76aBAgIEbKM/rb/ghmMRPnTqBO7hsgKdX4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb5XgPwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C1FC2BCB4;
	Sun,  3 May 2026 04:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777782311;
	bh=V+EOqq9qYi4AMv7pFUMpujIl0oVH1GDKkDhe2ojm7CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bb5XgPwu/KS1EkHdsXlMKgvmb+tNdJpCZhEshUAcXsq4lpp1Jjl9GDTR+QzXnrPcD
	 uCVm+vmZo7FeD772I99J0PH514u90flJd+5NdwSCZ9sAkx/ygDQc0iQGqQRCxmkjcm
	 /nuaNKLeP0RxKCRfWVAjy5KEtnPOR/B9a3lvUMREKdIXyK3WR+e+PUxsHW3XLKrHGa
	 D/cAgZ36P59vDae+pWlZyHA3P9xan19PmPFKRxdKsSwwL4eyElMxlkkdRrodkCI+Wl
	 K+xdU9p9mUwvYJtpCTGTZdZ07QvyLV5WCg67XzNtzU+1QnksQeu1HGn57yZMM4EWU3
	 N6zjjj8RJUisw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: frequency: admv1013: add dev variable
Date: Sun,  3 May 2026 00:24:54 -0400
Message-ID: <20260503042456.979738-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050123-unsteady-compost-e4bf@gregkh>
References: <2026050123-unsteady-compost-e4bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 42FBB4B4656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242638-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit e61b5bb0e91390adee41eaddc0a1a7d55d5652b2 ]

Introduce a local struct device pointer in functions that reference
&spi->dev for device-managed resource calls and device property reads,
improving code readability.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: aac0a51b1670 ("iio: frequency: admv1013: fix NULL pointer dereference on str")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/frequency/admv1013.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index d8e8d541990f8..d29e288da011a 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -518,11 +518,11 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 {
 	int ret;
 	const char *str;
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 
-	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
+	st->det_en = device_property_read_bool(dev, "adi,detector-enable");
 
-	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
+	ret = device_property_read_string(dev, "adi,input-mode", &str);
 	if (ret)
 		st->input_mode = ADMV1013_IQ_MODE;
 
@@ -533,7 +533,7 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	else
 		return -EINVAL;
 
-	ret = device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
+	ret = device_property_read_string(dev, "adi,quad-se-mode", &str);
 	if (ret)
 		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
 
@@ -546,11 +546,11 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 	else
 		return -EINVAL;
 
-	ret = devm_regulator_bulk_get_enable(&st->spi->dev,
+	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
 					     admv1013_vcc_regs);
 	if (ret) {
-		dev_err_probe(&spi->dev, ret,
+		dev_err_probe(dev, ret,
 			      "Failed to request VCC regulators\n");
 		return ret;
 	}
@@ -562,9 +562,10 @@ static int admv1013_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct admv1013_state *st;
+	struct device *dev = &spi->dev;
 	int ret, vcm_uv;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -581,20 +582,20 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcm");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vcm");
 	if (ret < 0)
-		return dev_err_probe(&spi->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "failed to get the common-mode voltage\n");
 
 	vcm_uv = ret;
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	st->nb.notifier_call = admv1013_freq_change;
-	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
@@ -606,11 +607,11 @@ static int admv1013_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, admv1013_powerdown, st);
+	ret = devm_add_action_or_reset(dev, admv1013_powerdown, st);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id admv1013_id[] = {
-- 
2.53.0


