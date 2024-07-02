Return-Path: <stable+bounces-56594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E6924525
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E951F21DCC
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A61C0067;
	Tue,  2 Jul 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IlA6LGvR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92291C0057;
	Tue,  2 Jul 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940702; cv=none; b=MG8EPKicDAY6sw+NZ25WtovjumvYogK5HjVWhwbTIaFsh2Mjdx/PrqfYJnPuOW3P3MpW0c1NjHwsPpLiV1Ojt7M0EMZWBvwl41qxkLBxYEZ1n/Hgucb5XPj/PXwLulgei6kj7ijieJOKqkp85sJI3BvP9QzVIczmUyq4qN5vtF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940702; c=relaxed/simple;
	bh=wYvsTWB7CBe5hXOQxklPwAgSGTbCi57jbDgy6fvKl4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zbww+dY7iDFY077hcTBmj8XrVqcN4mKUG8O2BFoB5ULYd2zQaRstcWUHuLzidl0mzt8zl5GxMvteqHvT61zl04egTrX3p8WKSGFY+5SVIG3A/6jUSPn67nr0ZzY4NSpZzzpHzju3OqQCWsYTcqkjWhHOe0Qxh9THNMOAK62In8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IlA6LGvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CCDC116B1;
	Tue,  2 Jul 2024 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940702;
	bh=wYvsTWB7CBe5hXOQxklPwAgSGTbCi57jbDgy6fvKl4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlA6LGvRV4TUj28VJg9UA42Xwo02L+kI2+RDbztSe8D/93RN80OUYYGiLXZ1ZBbL5
	 Q+nmBDsmh0x0NyZELukjQoLOQXv7NRneZgmtZxmKFAcN5qzkI8Uy7SM6CNekse42JC
	 JdVt+YLe9Jr8ZN6YT6O++GzyeaY1Mr1L2DwJtlt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Schiller <ms@dev.tdt.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 012/163] MIPS: pci: lantiq: restore reset gpio polarity
Date: Tue,  2 Jul 2024 19:02:06 +0200
Message-ID: <20240702170233.518918073@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit 277a0363120276645ae598d8d5fea7265e076ae9 ]

Commit 90c2d2eb7ab5 ("MIPS: pci: lantiq: switch to using gpiod API") not
only switched to the gpiod API, but also inverted / changed the polarity
of the GPIO.

According to the PCI specification, the RST# pin is an active-low
signal. However, most of the device trees that have been widely used for
a long time (mainly in the openWrt project) define this GPIO as
active-high and the old driver code inverted the signal internally.

Apparently there are actually boards where the reset gpio must be
operated inverted. For this reason, we cannot use the GPIOD_OUT_LOW/HIGH
flag for initialization. Instead, we must explicitly set the gpio to
value 1 in order to take into account any "GPIO_ACTIVE_LOW" flag that
may have been set.

In order to remain compatible with all these existing device trees, we
should therefore keep the logic as it was before the commit.

Fixes: 90c2d2eb7ab5 ("MIPS: pci: lantiq: switch to using gpiod API")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/pci/pci-lantiq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 80f7293166bb7..0dabee7a1c511 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -124,14 +124,14 @@ static int ltq_pci_startup(struct platform_device *pdev)
 		clk_disable(clk_external);
 
 	/* setup reset gpio used by pci */
-	reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
-					     GPIOD_OUT_LOW);
+	reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_ASIS);
 	error = PTR_ERR_OR_ZERO(reset_gpio);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request gpio: %d\n", error);
 		return error;
 	}
 	gpiod_set_consumer_name(reset_gpio, "pci_reset");
+	gpiod_direction_output(reset_gpio, 1);
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
@@ -194,10 +194,10 @@ static int ltq_pci_startup(struct platform_device *pdev)
 
 	/* toggle reset pin */
 	if (reset_gpio) {
-		gpiod_set_value_cansleep(reset_gpio, 1);
+		gpiod_set_value_cansleep(reset_gpio, 0);
 		wmb();
 		mdelay(1);
-		gpiod_set_value_cansleep(reset_gpio, 0);
+		gpiod_set_value_cansleep(reset_gpio, 1);
 	}
 	return 0;
 }
-- 
2.43.0




