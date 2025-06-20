Return-Path: <stable+bounces-154982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2924DAE159C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C6189A8CF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05D2235BF4;
	Fri, 20 Jun 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ay96zTms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AE2356D0
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407193; cv=none; b=Bp9H8Ava9678zoCKBVi1HnYLlLk6/us597IAngFDeCq+Sis4h96wyf3UYxdIvmrXIeF9oSzE7uZjKWeE0nPF3SwMVKCpxln8SwSKu7U2nL6kTgul0p7ZtMC4mkZQ/8gPwK9icuJLejZNN7/igPRz76zZ86lmXQhwuLVMy6XigSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407193; c=relaxed/simple;
	bh=zUO8Ddn3ptFKa2Ko0i2nANxdyytBC4tZtah7uSNq+OE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iaqMmYkbWKl26ulhmZqnfQofyFdHQfuw8ugt/DvKryyFWkDSBtiMIeOX31r643n8Enhqg1etsJ4JAkQZXDjk744r5E9bYOOPzwdteY/N2g6vptGRkemhhGG74LTmz5L/TU5wV117rqkikxu9pIM2RkzgXjeK3HpB6JcISqKUcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ay96zTms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EE4C4CEE3;
	Fri, 20 Jun 2025 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750407193;
	bh=zUO8Ddn3ptFKa2Ko0i2nANxdyytBC4tZtah7uSNq+OE=;
	h=Subject:To:Cc:From:Date:From;
	b=ay96zTmsRSLhXFiEYH71OxHtaauh/lHiKzuPFiLVhYYRbJhSFPPECQrvmuoVsOIez
	 BCaOmZ9oVixKR2hVk5bflvHLpNBSNnKRF7/puqScU4WYptu32Kwjm+HGyp8mz1gStl
	 O6qAguK+jwrrLVarQ9hxsNft4AbS2cOwLfeURCek=
Subject: FAILED: patch "[PATCH] can: tcan4x5x: fix power regulator retrieval during probe" failed to apply to 5.10-stable tree
To: brett.werling@garmin.com,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:13:10 +0200
Message-ID: <2025062010-scarf-shopper-8220@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x db22720545207f734aaa9d9f71637bfc8b0155e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062010-scarf-shopper-8220@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db22720545207f734aaa9d9f71637bfc8b0155e0 Mon Sep 17 00:00:00 2001
From: Brett Werling <brett.werling@garmin.com>
Date: Thu, 12 Jun 2025 14:18:25 -0500
Subject: [PATCH] can: tcan4x5x: fix power regulator retrieval during probe

Fixes the power regulator retrieval in tcan4x5x_can_probe() by ensuring
the regulator pointer is not set to NULL in the successful return from
devm_regulator_get_optional().

Fixes: 3814ca3a10be ("can: tcan4x5x: tcan4x5x_can_probe(): turn on the power before parsing the config")
Signed-off-by: Brett Werling <brett.werling@garmin.com>
Link: https://patch.msgid.link/20250612191825.3646364-1-brett.werling@garmin.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index e5c162f8c589..8edaa339d590 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -411,10 +411,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv = cdev_to_priv(mcan_class);
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-	if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto out_m_can_class_free_dev;
-	} else {
+	if (IS_ERR(priv->power)) {
+		if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out_m_can_class_free_dev;
+		}
 		priv->power = NULL;
 	}
 


