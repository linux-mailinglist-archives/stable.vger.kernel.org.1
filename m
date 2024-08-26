Return-Path: <stable+bounces-70131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F30495E818
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 07:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E122817C9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F07A15A;
	Mon, 26 Aug 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lq0lJSvk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4529CE7
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651388; cv=none; b=eTZJpICbZ1jklRD/x/G9r6njjqwDVx1E7f/TQ8ni7t/XQyN4yaElN9itweefbNeBrbOMbBX8Kx+7nN3e4Kv5gw/Bliw5Ev5eUIZqWtFG1JP8P2lAAQGlrc88loHI03XbdgWC5wUUf5EPaG/7yIe4K8jAUfHdQvfDqoDuNNxN0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651388; c=relaxed/simple;
	bh=lxJPMcSQgzH6IWaICm8CbsLqpI8iVhJSZfoU/F0D6rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewKIFVwooGD1X83JTcA9ilKKQXRmnzr1ZoWQ6nj6k7P8vDFizzXbK0VSln8NWYISGHZ12jfa1s1Q/t5RuWmfTwzbESsZPjRtgWqUqGWbe7khapCWSjp8UIua9yUrxCQsoFm7CLVVGtKpLEhYBGXEfgr8Gt9TYXhaa+S3DPoRviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lq0lJSvk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4290075c7e1so4856445e9.0
        for <stable@vger.kernel.org>; Sun, 25 Aug 2024 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724651385; x=1725256185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR544WKpOrPO2hZEA827PkxB0Gw4Fd6mIICwFvWkUJc=;
        b=Lq0lJSvkVfddV6sMpoKoGivFTLexiKDUF7I35XK4nn3seUQiHy01IFt4vkZGhoTGHT
         kkb0my0OP4iYd6feSjObwUELDdpxojqI6jyHzvOmF6uZyxcqcfHUm62ig8c1h4IuiZvI
         IFi+JEis8PIldQ95N4LVaZv/8WrCFQplrgC2O+5cjGE43nGMIdsup/SL/KEID9XD+fYl
         fs2kuyKR6E4ubsxj3Vp3ADpRABwXwDk8UfawDIUvdBqqABbilcCk+bGxW2kA7gkhmHUK
         obIEYgCuviELAf1fVXEUE7czvYBF6gufNgvqU9uEboiEN6TL8cdQAP0Lj7DjYIARiMyK
         7UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724651385; x=1725256185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR544WKpOrPO2hZEA827PkxB0Gw4Fd6mIICwFvWkUJc=;
        b=Qfjkf4RhxamdhJdvlMPTVGrfH6dNXjxotZeX6WYXy9Z97+oOiu/6NWkRcFqYb0N9HK
         o/K3+dVce+Iay5TTH2PkyqW27DDP+i8IZgr0I+ZNwvdMipfV+wKkZu5UriBuRrdGSTBK
         WHFmwhQ/CjaUt490knlnAkRsb04v6Xh0fQJTysJ2VGC4BQReZkEpvyqaUd4CpXsz0wDI
         /3zMgDsSSJ1mBDb2NrTDVd4DwJAjisWBkYCMYse5CvvRNmARUVI0gnrQAfWDNfKiY/jg
         uVZ9evydDJgPm/j++DVAHdQa5UX2b1uRp+VuSTXoTHn9OgOcbGnUZz7n+YVRlM3vbRe5
         ozjg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+5kyGsO/OCNtOUOG5y1gsvmay+PT31UcQDjDt/aZQwuN5gVGaDY4/5/Hlt+7K6j+xmUfYu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+iyWqX2XIJFqhuHYjSOcJGvWLwqHncytBI6uRM8C3ZXw1h8C7
	RWIs59WV47HZXgWXblNqLcqGphze68ib7HBhD4QP8a5DaDap52v2c9ZEX9zu8iQ=
X-Google-Smtp-Source: AGHT+IEecqCwvbndqp+gcmElYdt1+EyzERIKZxtyAUJ5mLigfVv6d+/9h3V0MQ7J7rvWLhlJWRf9+Q==
X-Received: by 2002:a05:600c:1c1f:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-42acca112admr37662125e9.5.1724651384702;
        Sun, 25 Aug 2024 22:49:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8d1c9sm177632025e9.23.2024.08.25.22.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 22:49:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] bus: integrator-lm: fix OF node leak in probe()
Date: Mon, 26 Aug 2024 07:49:34 +0200
Message-ID: <20240826054934.10724-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
References: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver code is leaking OF node reference from of_find_matching_node() in
probe().

Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bus/arm-integrator-lm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index b715c8ab36e8..a65c79b08804 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -85,6 +85,7 @@ static int integrator_ap_lm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	map = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(map)) {
 		dev_err(dev,
 			"could not find Integrator/AP system controller\n");
-- 
2.43.0


