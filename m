Return-Path: <stable+bounces-57033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C02925A45
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC7A1F20FC9
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8FD17335C;
	Wed,  3 Jul 2024 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2iD65KXc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F2186E27;
	Wed,  3 Jul 2024 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003635; cv=none; b=OUFnnYQ6NqKnZT32vfjv4mYP2WYA+Inn8Aw4r5xfmpw3vp7RcFLL8KII1uf+KDIGimPiPn2SLlPZsXES1cwbFwFVDQJeCUtuYaK6DoWRP5916d7XS67Gu6co5dVxmIbU5v0HDjGQtnZlmToYIBhB69soUBCBNBVyu5Cd7yPi0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003635; c=relaxed/simple;
	bh=fD2I3ZQtVYkoKKuVURo7KmQP90Wen9ZxqEpbP1S+MxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSA8C1nwEDKVJYIlfrZ7h8cDaQwWielQ2UXiigxZ5XBO+xolQ19BpLDEm12ZwxKvwmAypFLvcCpyp12gdODCEP7ocgZT9jZ0CUu84rPDyCQy8iXtjgSK5XjbAe8ZuHorHIKMpsbHDjIxS512GlsLAzxOy14JQgSBwm/CZzXZTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2iD65KXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA3FC2BD10;
	Wed,  3 Jul 2024 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003635;
	bh=fD2I3ZQtVYkoKKuVURo7KmQP90Wen9ZxqEpbP1S+MxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2iD65KXcsTsAsfEtA9GYqK5njRpI3uIvl/s54tYOHaZ/9zRCVbDh5hbP22ynl7Wtp
	 NdIicOrOavOYfWeKGbs+CPiSeQSyNKFMuG0lgQd9HwPX1Yok5c2v8dz7bwSAI5GcoB
	 Qr9lxKvfOhl+3LHUL2XA9gPHMq6xECVMYZsHK/Ro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 113/139] gpio: davinci: Validate the obtained number of IRQs
Date: Wed,  3 Jul 2024 12:40:10 +0200
Message-ID: <20240703102834.708374991@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit 7aa9b96e9a73e4ec1771492d0527bd5fc5ef9164 ]

Value of pdata->gpio_unbanked is taken from Device Tree. In case of broken
DT due to any error this value can be any. Without this value validation
there can be out of chips->irqs array boundaries access in
davinci_gpio_probe().

Validate the obtained nirq value so that it won't exceed the maximum
number of IRQs per bank.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Link: https://lore.kernel.org/r/20240618144344.16943-1-amishin@t-argos.ru
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-davinci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -207,6 +207,11 @@ static int davinci_gpio_probe(struct pla
 	else
 		nirq = DIV_ROUND_UP(ngpio, 16);
 
+	if (nirq > MAX_INT_PER_BANK) {
+		dev_err(dev, "Too many IRQs!\n");
+		return -EINVAL;
+	}
+
 	nbank = DIV_ROUND_UP(ngpio, 32);
 	chips = devm_kcalloc(dev,
 			     nbank, sizeof(struct davinci_gpio_controller),



