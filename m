Return-Path: <stable+bounces-43942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C58C5059
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635301F2176C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CDE13C821;
	Tue, 14 May 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brEOsD58"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B385A79B;
	Tue, 14 May 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683226; cv=none; b=Xstuj4XyALxI827wb8k+iQmOHUvsUuXkkUJ+uFN+ZRYolPAFRfFgeo3IzrqD9e1HVbvbvr0MjA+EKLAJUWICwUC3QwH2TbAoGU2Fbkw7gLFBevXviYmP7hwjfmnc36KzZ1ujwTu1K4cwQuN25jQFZC1k9pgSPlcezFUAnkQ3oFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683226; c=relaxed/simple;
	bh=VytvdWUwR48hnMNRloLXoYs5bTCP+K8nlejv+NMST/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuNMCt4TM6t/fSs/BseoORzNOWpc6Oth1xEEDF2al2bDiS0WMxQradeypdVg3dL3N4uwA1oH5QTXfHTVocQQVV1c9a9WykUQw2Qn+kbthN1GNON6gtAAOjM1kQ0pXwpL+JUPK+e3ogj/2gn6TTGdp3UtefrIHw/bceJdjSkdLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brEOsD58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F358C2BD10;
	Tue, 14 May 2024 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683226;
	bh=VytvdWUwR48hnMNRloLXoYs5bTCP+K8nlejv+NMST/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brEOsD58xSXQkUh1Zc64dQWdCmso7X29IQlumJupNP5IqOUFOyoW7KCIbumnkqo60
	 p58HCoM2N37EDikW1ED3ZQjfk/fSz0ORyjlUJedQCKktAIWb7w9AcJ5d9ot65T4Iv1
	 anRT9ryhFc9BJEiLagQmiU5uh+g90wGQHbkO0JRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 187/336] gpio: lpc32xx: fix module autoloading
Date: Tue, 14 May 2024 12:16:31 +0200
Message-ID: <20240514101045.660418056@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 11baa36d317321f5d54059f07d243c5a1dbbfbb2 ]

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-lpc32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 5ef8af8249806..c097e310c9e84 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -529,6 +529,7 @@ static const struct of_device_id lpc32xx_gpio_of_match[] = {
 	{ .compatible = "nxp,lpc3220-gpio", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, lpc32xx_gpio_of_match);
 
 static struct platform_driver lpc32xx_gpio_driver = {
 	.driver		= {
-- 
2.43.0




