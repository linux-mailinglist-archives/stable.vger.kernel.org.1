Return-Path: <stable+bounces-55085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C914A9154C3
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B3928637D
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7619E82B;
	Mon, 24 Jun 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uP+yKkBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12F19E80F
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247763; cv=none; b=Oq1cjD7ckcR1UXtgHKPmVVlLRxdhWU5rk9rzB6PB//pJA4XR+UPbs2A+r25lbVuY3RXXLJ1ct09MDk3GzcFKaDSx+Je5461U8SYGgsG7iZ4w9fDmgml/bb5N+FMrfxg6h1EV34AW+5ct4074GVkyTGln5BcL5xz9SA+5N8fpJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247763; c=relaxed/simple;
	bh=KcrbH8aV9ZFZ4QvY42z4U0Cb6KUFnfDik4+nbOTpcpc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Csq5pO5bm1X4eBtrO17lYc3k8Po9IKjLGN2Sd+7ZAlUIY6LRjpJzJMXkzwQLqbpqx5GIUzeass72ZLKU2QwedmrLeDq3edcnCQIB3nhFoMC4/IyUIBTLvpxi8t3L1MGfq2fQL/smlgrNAK2krb5CS3Y1AitHR/cfgYbPggQ4htg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uP+yKkBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB43C32782;
	Mon, 24 Jun 2024 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247763;
	bh=KcrbH8aV9ZFZ4QvY42z4U0Cb6KUFnfDik4+nbOTpcpc=;
	h=Subject:To:Cc:From:Date:From;
	b=uP+yKkBtwpidEJAFbNFjVYvwvJGVBRXTdvO+6f4wLRu8x814EiqJ/LGP28+GZgv98
	 KMjmM38HECa9SgFsFRgvv2UekQb1qLFwMrE2rf82FuUMevAd22KrxGHFErL9QDWTsY
	 Tnwuatl9hQEBoTKeHBpv0BourAjtzcWiNqDkX19Q=
Subject: FAILED: patch "[PATCH] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz" failed to apply to 6.6-stable tree
To: ckeepax@opensource.cirrus.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:49:15 +0200
Message-ID: <2024062415-acquire-poise-3326@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 60980cf5b8c8cc9182e5e9dbb62cbfd345c54074
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062415-acquire-poise-3326@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60980cf5b8c8cc9182e5e9dbb62cbfd345c54074 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 7 Jun 2024 11:34:23 +0100
Subject: [PATCH] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz

Some internals of the cs35l56 can only support SPI speeds of up to
11MHz. Whilst some use-cases could support higher rates, keep things
simple by dropping the SPI speed down to this avoid any potential
issues.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607103423.4159834-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 902a0734cc36..8b618ef0f711 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -54,7 +54,7 @@ static const struct software_node ampr = {
 
 static struct spi_board_info ampl_info = {
 	.modalias		= "cs35l56",
-	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.max_speed_hz		= 11 * HZ_PER_MHZ,
 	.chip_select		= 0,
 	.mode			= SPI_MODE_0,
 	.swnode			= &ampl,
@@ -62,7 +62,7 @@ static struct spi_board_info ampl_info = {
 
 static struct spi_board_info ampr_info = {
 	.modalias		= "cs35l56",
-	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.max_speed_hz		= 11 * HZ_PER_MHZ,
 	.chip_select		= 1,
 	.mode			= SPI_MODE_0,
 	.swnode			= &ampr,


