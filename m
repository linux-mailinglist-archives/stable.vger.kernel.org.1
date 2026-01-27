Return-Path: <stable+bounces-211771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNqPHjK5eGlzsQEAu9opvQ
	(envelope-from <stable+bounces-211771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:10:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60D94B2C
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E472C301981E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA66355044;
	Tue, 27 Jan 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BOUYohEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52892355024
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519408; cv=none; b=azaElTYQlZdi3KH6rB8Jmau8PiYNRaoU8Dei/nEC/wZSVmMaPO2pl4nFwA8zEqOTmklE91Fe8HTN18GiKCsyltcbH/80jzgXUp80wZF4cFXJUxalqbUZzPMIuYUNf2wvEYSbBJ+nQVx9zIScnNt8Gu/AEDu0oQB2ZbLzFFpskTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519408; c=relaxed/simple;
	bh=cWTCq4rLPYogrx7t5Y67+cxWgwWCqXBXE34j5+rf2yY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lY8qHiIgnl6KnRQGPD7hz2MvEfBkxJBdNAv5BoEcfYUNi4l3Sak3QJtLGFVeGs6BDi2q2lAjfSRnCnjoG27UY9N6QgMjdylkYSDzvf1lOgME+pdTZX6xzNN0GDtnn6/CE72O0CTNeInz5lFf7dKTomVTWe0hU2ldR6UzReKL8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BOUYohEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5AEC116C6;
	Tue, 27 Jan 2026 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519407;
	bh=cWTCq4rLPYogrx7t5Y67+cxWgwWCqXBXE34j5+rf2yY=;
	h=Subject:To:Cc:From:Date:From;
	b=BOUYohEYVI19SeMQy6WB0lq71V7lNnYIeGA3t6yEeaG+PHOAUQOKsyGQOjSNw6E8B
	 63cmzFINHoLl/7cMk/kXVFk6sYmEXs+HzEkbIWiNpPBoce2orHqeVfg12N1GUwVfsA
	 i9YYG1s5/1E/UXdE3NUDfv/01PYlBUYSlLgeS7ks=
Subject: FAILED: patch "[PATCH] iio: adc: exynos_adc: fix OF populate on driver rebind" failed to apply to 6.6-stable tree
To: johan@kernel.org,Jonathan.Cameron@huawei.com,krzysztof.kozlowski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:09:53 +0100
Message-ID: <2026012753-astonish-posting-f234@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211771-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,huawei.com:email,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: EE60D94B2C
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ea6b4feba85e996e840e0b661bc42793df6eb701
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012753-astonish-posting-f234@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea6b4feba85e996e840e0b661bc42793df6eb701 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 19 Dec 2025 12:05:45 +0100
Subject: [PATCH] iio: adc: exynos_adc: fix OF populate on driver rebind

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

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 1484adff00df..f2400897818c 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -540,15 +540,6 @@ static const struct iio_chan_spec exynos_adc_iio_channels[] = {
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
@@ -660,8 +651,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	return 0;
 
 err_of_populate:
-	device_for_each_child(&indio_dev->dev, NULL,
-				exynos_adc_remove_devices);
+	of_platform_depopulate(&indio_dev->dev);
 	iio_device_unregister(indio_dev);
 err_irq:
 	free_irq(info->irq, info);
@@ -681,8 +671,7 @@ static void exynos_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	device_for_each_child(&indio_dev->dev, NULL,
-				exynos_adc_remove_devices);
+	of_platform_depopulate(&indio_dev->dev);
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
 	if (info->data->exit_hw)


