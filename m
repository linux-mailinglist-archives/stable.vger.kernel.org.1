Return-Path: <stable+bounces-72186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58171967997
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D9D1C209A1
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18188185B50;
	Sun,  1 Sep 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7DwQa12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1A185B4A;
	Sun,  1 Sep 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209124; cv=none; b=RULygfjVCo6FSv/e8Pcc6Ly5/1srHCak6diqUWk8vZOPXkDw7TzBwbWf0EFnkz+AgF+JsAdV1XHc4eUZf1JwGp8KWFaZJc/jQHS/TLxkZQJYQFP8AuJsqf7uBd3hsNx6mCu7awQ1I2kvBY4iZ0Zv5DqGNqeN1QSGQFE9CFaGCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209124; c=relaxed/simple;
	bh=YiF2r43d6Iq7MSgslRPfc3FaPvnmqPgBNso3cQ8/Rq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kar+Jdn0eV2/WnIzUa9MXF3Zi/U0jsWweNtfG4l/5x23Mj8H6NfobzLB5x7Z+ngVsW00nUCB38WQ9qlOrEWNnDwHXVPSfFhJgQw3NacKfemIH5NykYmYZtM4QMBTwTJ/0adPQlLjOhXMEOkvj3n6CCirltZH8gLpMZmbdiizAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7DwQa12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302A4C4CEC4;
	Sun,  1 Sep 2024 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209123;
	bh=YiF2r43d6Iq7MSgslRPfc3FaPvnmqPgBNso3cQ8/Rq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7DwQa12EMaxnfirI8aOyTSSXawX6jBpNbwVn/neT4Z5eM/LbeXaHVjSO9n7SxF3W
	 UBYc3gG7iylJmLlCmJRvCpTiaoRSjL1j+ayBXdGvQl7LV+ALaKQst3OpNYuYZcdg+9
	 wSaj8x0Vcn9fEjaw5B1DAicW2pxFMfhxyxXle5wA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 5.4 130/134] usb: dwc3: st: fix probed platform device ref count on probe error path
Date: Sun,  1 Sep 2024 18:17:56 +0200
Message-ID: <20240901160814.969160738@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
References: <20240901160809.752718937@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit ddfcfeba891064b88bb844208b43bef2ef970f0c upstream.

The probe function never performs any paltform device allocation, thus
error path "undo_platform_dev_alloc" is entirely bogus.  It drops the
reference count from the platform device being probed.  If error path is
triggered, this will lead to unbalanced device reference counts and
premature release of device resources, thus possible use-after-free when
releasing remaining devm-managed resources.

Fixes: f83fca0707c6 ("usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Link: https://lore.kernel.org/r/20240814093957.37940-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-st.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -219,10 +219,8 @@ static int st_dwc3_probe(struct platform
 	dwc3_data->regmap = regmap;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-reg");
-	if (!res) {
-		ret = -ENXIO;
-		goto undo_platform_dev_alloc;
-	}
+	if (!res)
+		return -ENXIO;
 
 	dwc3_data->syscfg_reg_off = res->start;
 
@@ -233,8 +231,7 @@ static int st_dwc3_probe(struct platform
 		devm_reset_control_get_exclusive(dev, "powerdown");
 	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
 		dev_err(&pdev->dev, "could not get power controller\n");
-		ret = PTR_ERR(dwc3_data->rstc_pwrdn);
-		goto undo_platform_dev_alloc;
+		return PTR_ERR(dwc3_data->rstc_pwrdn);
 	}
 
 	/* Manage PowerDown */
@@ -300,8 +297,6 @@ undo_softreset:
 	reset_control_assert(dwc3_data->rstc_rst);
 undo_powerdown:
 	reset_control_assert(dwc3_data->rstc_pwrdn);
-undo_platform_dev_alloc:
-	platform_device_put(pdev);
 	return ret;
 }
 



