Return-Path: <stable+bounces-212566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC01EpEzeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E6A5055
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20C31302BEA7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2D3043B2;
	Wed, 28 Jan 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X+jZVmfJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEE242D7F;
	Wed, 28 Jan 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615947; cv=none; b=s6ytD60DSJWa8V6frnDDnX+4cZRElVX6sdl7xHzw8oX3UHaFbKuDREFgbqiUgbpwGdy/BQnmIBBuO9GkppiA9W7l5pTcdhUwdGnL75sNbbl4ZFUuD/IVLMNfT/Mv1LDTAgKxrKMYP4VG/JH+ttNxVxVfeRXGc9CoqtJb7Gh8y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615947; c=relaxed/simple;
	bh=0IQ06FjQdoK07seCq+FBIWPC7g38VA0rvp90pYfzzi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkJLyoVZTHkmvnZFa0sMJc9EChoJ457wrkM+5VCzY8o7tB9XID13Lp7v94cZ81UZaDs5RRSWfDL8OdCTrsE33+suWGFBIugm8ECQJkiOJmv1KI8lD1cBnOGTRTNC3xIJWrrxidnBpuIEAGYEBM3xX1k8UG2InGOVEDNn5KzFVrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X+jZVmfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18260C116C6;
	Wed, 28 Jan 2026 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615947;
	bh=0IQ06FjQdoK07seCq+FBIWPC7g38VA0rvp90pYfzzi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+jZVmfJXcELlaA+/qs1/0qDw0bt2uOSUInrBx6eBOmg5qX9+JXfcjlTzhgVj4pAl
	 z2QQSwqBfs3z7f/OcqSy0jqJlZl7Bl3MH6iET/iybsuAUrvNbLpdDcANjuSXcXZ4fH
	 gpeA5bqHCV4ZnKJafX/XKrVhmiIOEpR2+WRy2e8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 161/227] iio: adc: exynos_adc: fix OF populate on driver rebind
Date: Wed, 28 Jan 2026 16:23:26 +0100
Message-ID: <20260128145350.247039410@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212566-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,huawei.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: D90E6A5055
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit ea6b4feba85e996e840e0b661bc42793df6eb701 upstream.

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org	# 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/exynos_adc.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -540,15 +540,6 @@ static const struct iio_chan_spec exynos
 	ADC_CHANNEL(9, "adc9"),
 };
 
-static int exynos_adc_remove_devices(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-
-	return 0;
-}
-
 static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
@@ -660,8 +651,7 @@ static int exynos_adc_probe(struct platf
 	return 0;
 
 err_of_populate:
-	device_for_each_child(&indio_dev->dev, NULL,
-				exynos_adc_remove_devices);
+	of_platform_depopulate(&indio_dev->dev);
 	iio_device_unregister(indio_dev);
 err_irq:
 	free_irq(info->irq, info);
@@ -681,8 +671,7 @@ static void exynos_adc_remove(struct pla
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	device_for_each_child(&indio_dev->dev, NULL,
-				exynos_adc_remove_devices);
+	of_platform_depopulate(&indio_dev->dev);
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
 	if (info->data->exit_hw)



