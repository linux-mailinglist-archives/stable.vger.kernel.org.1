Return-Path: <stable+bounces-47539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF28D11D9
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0D6284883
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 02:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5198219F9;
	Tue, 28 May 2024 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA+9oh26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E36A33B;
	Tue, 28 May 2024 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862759; cv=none; b=fdEl65yH1FYDpzEdLiPdlucrMY6ckXC7ycIDE9M8uTggdJUb6/lP2EjxrQtn5RKBHIxW7bj2jtsxW9Dg2uXQJ+Ad9HwHNSb1pPPx5WdoBDhrY/low+vlWV6y/2M0se3c3cR5Bt9eQUHfooEWQ3RUOgVYPCXUjeGWW8tHsjH5ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862759; c=relaxed/simple;
	bh=FZCY3iTAJh1S9EP9/Qn1j7myPIFxD/sPPvDvlpMXCJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLOjTkUHVYXN6yFgIcj1VzpriSpEkX/jAeGfSvzC7kKYZcKoaoBxLFZi4XgFqmTRSVzxQ3qA1FSJfOieVCkt85Ko2PfGzk+V+THuONjOyGxYJVQ9tUNanTae4LKpZ/jkUh2QwtB+PLxLzZ1q9dro/dMHkJkCogCAwErbYUMMFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA+9oh26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A08C2BBFC;
	Tue, 28 May 2024 02:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862759;
	bh=FZCY3iTAJh1S9EP9/Qn1j7myPIFxD/sPPvDvlpMXCJA=;
	h=From:To:Cc:Subject:Date:From;
	b=cA+9oh26Gf7hQZEyhiH7EFDBKi1xAeUnU0CEzV1PMcFyZxOFJt8G26F1lmhtL52QT
	 +KBx3u9PjqAIXhJt4/PwH1S/2nQOFM5Io8N5B7rfKbJJXfE8/cSbPx6K9lHqCnLsVS
	 ouBp4ZRzs19sAaxWnx+ZvKb4i5noTlOfYanCUhUYRhfZoLsKfkrVuBjp34ISlg93Ze
	 yhPuauGxZ3mE6U6tPg5DcMeLZeUbUPDzg7A0hrYUR0UsMcKKZ5Zib8KL4pgA5WOrQs
	 z3apg/PhLzgEjKNN8PKVr+CEUjkAsvnDAVh5OinRM3U0BP59EmbDsAtbP+oSfTO5vQ
	 Mv+GhiggCKPkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/2] power: supply: cros_usbpd: provide ID table for avoiding fallback match
Date: Mon, 27 May 2024 22:19:13 -0400
Message-ID: <20240528021915.3905424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 0f8678c34cbfdc63569a9b0ede1fe235ec6ec693 ]

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20240401030052.2887845-4-tzungbi@kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 0a4f02e4ae7ba..d7ee1eb9ca880 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014 - 2018 Google, Inc
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -711,16 +712,22 @@ static int cros_usbpd_charger_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_usbpd_charger_pm_ops, NULL,
 			 cros_usbpd_charger_resume);
 
+static const struct platform_device_id cros_usbpd_charger_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_charger_id);
+
 static struct platform_driver cros_usbpd_charger_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_usbpd_charger_pm_ops,
 	},
-	.probe = cros_usbpd_charger_probe
+	.probe = cros_usbpd_charger_probe,
+	.id_table = cros_usbpd_charger_id,
 };
 
 module_platform_driver(cros_usbpd_charger_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC USBPD charger");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.43.0


