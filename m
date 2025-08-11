Return-Path: <stable+bounces-167041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D55B20A6C
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08293188C385
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379E2DEA71;
	Mon, 11 Aug 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="06MRoUc3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF521B2186
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919390; cv=none; b=IsmKtwKHVBcBEy37Bz+RJ1sDv7AhkYye+oiC4ujLp6o8gHnEjoFybtdU68CnvfRxf8rp1MrUsV1M1jxCcV/STIj2odu/3lXnbxJBvz8wRgAR/5qTqWyJ/LKVHsyNuA4YoUD8e2j7UxiptEUglXGDrwdHk1ZscztdUp3sn4lVIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919390; c=relaxed/simple;
	bh=Cvm3UxwZaIvytNrW2R0gZcHjx1lcF6maKDX+XWI55dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqMWAgXykN7RgLPWC2MYzYglsUv51p/VXzwNdxLFQ418D8m819RVB7Jy7QxL9/WRU/FLbnAc0Y15lOniYFhqh2cByIJYu6zaeSSIT8TxTnYHfN+Sc6EZpqlKsKNdNSpFWJnPn9Kgl9vUmuNBD0lENHONOiPYf9vvrdnZ+uT75TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=06MRoUc3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455b00339c8so27499105e9.3
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754919387; x=1755524187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPC9QjkdXxMejFY4x5ok5uLAPYyJClZcqMLBbaZ87b0=;
        b=06MRoUc3RQriqaf5H6kL/Y6jSC33ZYGZp00YIvwqCD3ZGa21dvuigyDEDkUCnUl14O
         5gyUvRwHgXOoykQjzVoVk8sCJlqzaUSPBer1Mu2EXsSrrE323Lj+jIkNGoJ9WAQuAi86
         m9Z15/nOTfftBhV1nW7i1Xk5IQF+TaBYLdwwku88NiHTe1NECedG9raEg+jrqu6PCo8V
         9DpCy8s3CHKdwO71Wtj9UIxYdZS6pZLbGuBr1oQGscfeLMngmgllIN5qubZF4bztp+T0
         GHJ2bScHYOClmisekLM5Vx18V4rUxQX5JUIeckpS8YXITcfZ3pijrRnE9j7Ysnfai8F5
         x8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919387; x=1755524187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPC9QjkdXxMejFY4x5ok5uLAPYyJClZcqMLBbaZ87b0=;
        b=C/wMommj3X7qnl+4cOPYn+fDoQlCnxWgDNlArFVwLhM9WQKVQ9v2M1Uz1dlx79FbJL
         VRxuwjd+xt+6Ak43VIJ8x416KfAEMdxG4NVyaiEYz6adF902rSc6LXxEZhccyBM2WV8G
         hOqqRDR6NLs2/qGUN2pJ3juadDjWfwIT9Vr9FsbgBlsja5k6qqX0qijyC4Y7vA+L64FW
         0L9X3t9XE9qD5hnID0JiSksO4lQ/5TuMancYl/NEP8495wQtf9o2BXecKhZ2T1yXwxAL
         PR+6Kuy9EVse7Ls6IjVoI4tSPYScSeFDQWzl/+fshelvXSA3y3+kQ/5/Ygu44TTUEKan
         rQMA==
X-Forwarded-Encrypted: i=1; AJvYcCWjaNYDV5f6ajrQWilQWMKTj/BoLiL3NlaysUkL3iLOcPXcejyvwegKCdTjHnojoDv3lWdX4hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/tKc5viHh0k6sLLQSkPab1DnG5ewxp8ZAUUoLay1w9ip9v6C
	oYTbqwUxs8EyL3gZP1+uqcwV7UMkHrtA9j1ePxRmiTM3AA5aT+IDus8tN/mQpYAfWgogFVhDHlJ
	OVfny
X-Gm-Gg: ASbGncu0d0kf7yDvtyFcrheenIh2ddu8shiIfQX8LXdaDRgvAEutJbaqM9QkmY1GIWm
	qPfvOnzDEuHK0fb5Pypr9h6jbFUv7G2/hbPMNeZVUhBKMU7ENTBENs1lni9IsLlmBgUdfVtOR4e
	MIUjaOa/MuvMhqW9989/zmAhvIs6te4FMtQQtJbC3AHAQ6rUgRkGyaA49MESNlKmDVue9MWlmwx
	+X5G9bXzO0AHd870dnt98Q+FZNiek9cc/nAOyP3dVZRJiTLNV/sJkwGsvExllpROoVHhyHV+Y6s
	BpsywSBgOvruBO8o7wMV2Nh+W3h8lUQuyslFmc/iTOpXNI/0cwXKwLvwhmX5tCjrK88CIVwa48L
	60xSlkxghPpZ1BFGvQg==
X-Google-Smtp-Source: AGHT+IGO8tGE6CmpRp8d7Dv8oPbrNyboejFtiyDhBBX2/eeF8sA7SMGla8jnfhdxvPUYVbbA5Sca3Q==
X-Received: by 2002:a05:600c:1c18:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459f4f3e153mr120440835e9.8.1754919386578;
        Mon, 11 Aug 2025 06:36:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587d378sm253045105e9.23.2025.08.11.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:36:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 15:36:16 +0200
Subject: [PATCH 1/2] mfd: vexpress-sysreg: check the return value of
 devm_gpiochip_add_data()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-gpio-mmio-mfd-conv-v1-1-68c5c958cf80@linaro.org>
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
To: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=npVo4x9jWTs/C5oZ+18P177rzmdj25fbWuss0PN0sgc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomfHY3wi3JBmgBHiBE2qvpEWlJzPK24kglGeUX
 xNZz9M+CuKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJnx2AAKCRARpy6gFHHX
 ck4YD/9c0CqewiZHWF6/YFXoIqPUFIkHmddOhFieqmRdmF/yNc5waGN9erdg30PR/wywPs+kh2M
 PjWfHrs1tOet67Q/bfY9F2IqNibNOE9bxDVK+qs+uQZHj4z5f69AdGlLuAhNym++2ff4zHg0lTV
 ZkaSOLnVLDJVP2sLKAyCYxrViDNfbEhZnY2Uu8i5rbtHewxH+ZFDmxHX1ikemAk5Hi9e2HuUIMo
 rnaN5L9J2P4w1GwQTIDn++ml9Ew/BjhUZm+cQt9A91n22y/lWvdzHhnG4GqVTMBiuh8Yx1tRCZW
 dNQK08q2kM+JphEbuSkwEOwYa+CNIeGQ38q1gQpgTwDEQp9Kx0xs796lFX+xMr1sYretdbFiXaL
 4HksGf74zJAwsI5xRnkqLdb0QpAs8D78JNoaAtnMFhbMvwwEd/mWUlMhrmgx7YfY31JytU5teTb
 tW/3BdG+yz7M2Oww16f4xylTWevar1CUxrXfpDSYmmQ+fbO9/YcN5uHt9m3RXVnqsvbOxG0ugAM
 h/UUQy1fha5KHs4hANSsR+ezcPEd1uT0EIxDcHh6dGfcLCO9FkA3yktahT0OvJ7c8DNl6kYxD2M
 v/ZwWMfYppyp30Po+U4Tu1OfAuaQRnlcowPcUL9pisVN03koxnAzPyXJcyq/lN1bkWhIuTBquAz
 WYRMxHmxYqDtGQg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
removed the return value check from the call to gpiochip_add_data() (or
rather gpiochip_add() back then and later converted to devres) with no
explanation. This function however can still fail, so check the return
value and bail-out if it does.

Cc: stable@vger.kernel.org
Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mfd/vexpress-sysreg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index fc2daffc4352cca763cefbf6e17bdd5242290198..77245c1e5d7df497fda2f6dd8cfb08b5fbcee719 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -99,6 +99,7 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	struct resource *mem;
 	void __iomem *base;
 	struct gpio_chip *mmc_gpio_chip;
+	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem)
@@ -119,7 +120,10 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
 			NULL, NULL, NULL, NULL, 0);
 	mmc_gpio_chip->ngpio = 2;
-	devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+	if (ret)
+		return ret;
 
 	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
 			vexpress_sysreg_cells,

-- 
2.48.1


