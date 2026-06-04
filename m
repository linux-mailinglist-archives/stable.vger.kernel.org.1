Return-Path: <stable+bounces-260504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H133HoyJIWqGIQEAu9opvQ
	(envelope-from <stable+bounces-260504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:19:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5C0640C5A
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:19:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NL6UCx69;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260504-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260504-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C59CB30AE780
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2D480953;
	Thu,  4 Jun 2026 13:54:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5D2264CA
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:54:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581291; cv=none; b=GogtKdtIt8fNyXsZ9kt6qz+2hHCIscWkL4rPkYnmt36mS5cAA477U3EpCo63s762b1903t7NjQISoTEJl4bsH0Yic+eTdHRjErXNcr9SHIVyRUU8sLHxquibvVsPQ+8aKNu0v3fkuR2CVEsBwattS3i6Bkcx0o/ABKW0kfyWs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581291; c=relaxed/simple;
	bh=r/Rjxt2pkqJO/bqu4zokcEjW2uH58kwijrvySqxMhCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6QopgjOYtZybvqsax2tA4MJhkOoupBwAqPLuKSJ1zRhlMnY1FdGxjtrvDoOz7fayNLrTwiuiQMOxiZdF+53wxEsbZ+PgaruvFQLdNXVxGtGux/fGRTZGEoIuu7douo4PS388j7v8iLez8dSAxyHV6+lXE+hRzoYPkaX9xqj77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL6UCx69; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BAD1F00893;
	Thu,  4 Jun 2026 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581290;
	bh=cqmxjqHS37P0XF+EMyudOwTmfpkfMMvxbb/R6x528uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NL6UCx69Ym6kwYmqOnPcWytsemJbVKhmgAY3dwOLP+bQcYs0rEH3fW+GWMc1OAx8f
	 ljUt/vAw/eW9oVvjhU2EhUEtdAhChewCFfh27xel54ahEfI8y0M5JYM+C74wzHtZgT
	 5C4hYbB8P2AQMuAQ+jNpkaWM6xfCjOQ976aqWpeSURreIKxy+9TyXArs9gOQeIpwgL
	 DSxRno+0FZZZgwGjbyPR/MDZ1Tbzm2Vev1kUyRT+k/ZeMUGtGusVb2uDjqNykheIJ6
	 RyvsolxR+9G1NeQeI+gj6OtA31OE1lReUyAZkIox4We+WwivVpnC7xmZAFZNAUCcdx
	 cSUcMOE3+FtBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruan Jinjie <ruanjinjie@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] iio: adc: fix the return value handle for platform_get_irq()
Date: Thu,  4 Jun 2026 09:54:45 -0400
Message-ID: <20260604135447.3493139-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060418-roving-osmosis-79bc@gregkh>
References: <2026060418-roving-osmosis-79bc@gregkh>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260504-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:ruanjinjie@huawei.com,m:Jonathan.Cameron@huawei.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E5C0640C5A

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit c09ddcdd4dd32ee9768dc233ead4b3d726f26d38 ]

There is no possible for platform_get_irq() to return 0
and the return value of platform_get_irq() is more sensible
to show the error reason.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20230727131607.2897937-1-ruanjinjie@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 0d42e2c0bd6c ("iio: adc: npcm: fix unbalanced clk_disable_unprepare()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
 drivers/iio/adc/lpc32xx_adc.c   | 4 ++--
 drivers/iio/adc/npcm_adc.c      | 4 ++--
 drivers/iio/adc/spear_adc.c     | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 44e1e53ada7294..0d6885413a7ee2 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -540,8 +540,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	}
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
-	if (adc_priv->irqno <= 0)
-		return -ENODEV;
+	if (adc_priv->irqno < 0)
+		return adc_priv->irqno;
 
 	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA, 0);
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index b56ce15255cfb5..10a370ca7d5f81 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -173,8 +173,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
 				  LPC32XXAD_NAME, st);
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index ba4cd8f49f66ca..3d9207c160eb99 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -244,8 +244,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -EINVAL;
+	if (irq < 0) {
+		ret = irq;
 		goto err_disable_clk;
 	}
 
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 8fda16dd012f70..602ed05552bfd4 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -311,8 +311,8 @@ static int spear_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -EINVAL;
+	if (irq < 0) {
+		ret = irq;
 		goto errout2;
 	}
 
-- 
2.53.0


