Return-Path: <stable+bounces-152261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A123AD301A
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 10:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7094D7A3431
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BA284663;
	Tue, 10 Jun 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEZC9Q1T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCA283FD2
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543838; cv=none; b=kHMkXIrqL/nPSEUWJCSmCqvdEcgH8LriwWq+puuTQf/hX2zo3Fd7Kw/+jYVqcWKlbrhTxJHA653XbdVnZKGfkjwthAG/ylV0YBV39u0PM4eujx6OVJEv72/9cmH8JOmwLYirZEM+QRLXqiSm337fcdMk9y9Omic+TMeq3LUbFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543838; c=relaxed/simple;
	bh=yyhzPDdF8NeOOeZr2SZOX9HHHQ5D7bOqPKd37iQiSFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GzhFlrsDHaQ8p3hVRYHcSTj6RnVimK+pq+CaaB8Lsw3lbB02clhYuhwPBrZyeisLN2x/pRGGaIbFwtioNw/L8wkefKdZ5/VHLhsftTKE7i9znfXxLH4C1KZ3egWrh/SXFuVvJtPAm7PpntSn94Tb020jW60cWls0blPUUhJ6Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEZC9Q1T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4eb4acf29so648480f8f.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749543835; x=1750148635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9WGI4IbP//61XrnIlM+natAC7ecS9zG4vex6G78gZY=;
        b=hEZC9Q1TgiXTu95oc+6NtCo1BRbnOHrDqPXM+MQe97jPplFgtUdf13p/+l/jivtpqn
         AVEQjBzDe0FJXPE6Qt6a8uqrNr2fPd42ABmxo+Ea3b2F/O2bpgYVKdN+pbeS5ePPw1cm
         akKeS/vsivEpT4A4OhOoE989960LD37RLNNrych+3AkFBsAUaYDYEI8fWIB+kyRCdOYs
         LHNItha/qRFBQeNZEdhYjhtgiFYAGupfM9a1F8cMJL3gN3y8zWcjShQ6qS+/8UxWnLa0
         WdUy5IvMd8OPHPs55WlLsoulOhhLt1FIAQwpR257JdBImWFyg/7ZWBilWCccOvj0herZ
         M3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749543835; x=1750148635;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9WGI4IbP//61XrnIlM+natAC7ecS9zG4vex6G78gZY=;
        b=JDsTGH0IjqFyTmMSq+8QR2D66HXOBy3I1E4B0txNeEQ/WGyynm6TIvFg60Xp+9Xavc
         6RyxS5gqjoabgCTGpq4sAxG9YXy3lCewS8Ah3s9AFHNxOR+iwPW81d6UMiMp2MA4N4gz
         vcCvqmqIGffIjyC6X+ZDuaTBjd2IA44aPeioVVP10hzpQrxtBqftmFhxlc8CFmOIZdq4
         WgaKpSsW2y+ZRlrY2eENu3RQdA/6r9tdUmKyPLihk53B/1kFkgSf5X5SHbD+FFy5PV56
         /0kWiNaNQVSguA1y/qBBSGjJrNM1yIaoBm4mDOnc8+vPO56TFrZbgww9cjtss+ZFUswi
         xXIw==
X-Forwarded-Encrypted: i=1; AJvYcCVB3Rkq6/eYTC0L92XjN9NdhTRrNMZ7+SCpGodZIibxPuRBuv+QvEWS8Ee2/NKxNtiI/Bzg7j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVVtxo94WfT4sBjsXYxO1G1A1cuQrqSUq9PAqtSZYmakdLcJC
	qOvDw3IWyCzRsfYa8CbYvN4vrloQw2anDbire4Nkilfr+8bOWMaWF62gcof1sgNI5I0=
X-Gm-Gg: ASbGncstYmkYPyYvKYjYJaCJdRdWdwgZiOsKWh6W4XCyRwN1Ez0GMUbxe7US85VapyT
	KpTbxKcD4YBnVT6eZxEb/grLixzFEvTRaeIuOcSNK9tm4+TCgsX7NboZxeRRVgV0jNy5JbbeAfu
	lBemx+h9dWJtwMUghg251sQ7U+WZG9r7UUm747U/Q/dlE+hNS6ZGQ2c/Nrze4yJHjmCzKn0mg0S
	n1hv6ZeG1y3nuX7td1YVJkOREK//1wAsGjdlmz2WVzExjXMAppiouaPfgUQ9yVK6KcjCw/eo5V/
	/0nIqwm3EktS5O1qkzUKjhRCz3wXLR1rApLAT1vWUuM2oF29g0L+Nf86qXAWse8mEP49LR2gZ/3
	l2P6wXg==
X-Google-Smtp-Source: AGHT+IF3umgoC1MXVewYqSd6NXb0BxRbXdgsSHg+n+0cmqeui+0FYUC+7otmqctsYZrl7Ig6A8Aq0g==
X-Received: by 2002:a05:6000:2409:b0:3a0:782e:9185 with SMTP id ffacd0b85a97d-3a53313fa5emr4137414f8f.2.1749543835438;
        Tue, 10 Jun 2025 01:23:55 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532450b08sm11378980f8f.80.2025.06.10.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 01:23:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250603-samsung-clk-fixes-v1-0-49daf1ff4592@linaro.org>
References: <20250603-samsung-clk-fixes-v1-0-49daf1ff4592@linaro.org>
Subject: Re: [PATCH 0/3] clk: samsung: gs101 & exynos850 fixes
Message-Id: <174954383375.117835.6950854237763688291.b4-ty@linaro.org>
Date: Tue, 10 Jun 2025 10:23:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Tue, 03 Jun 2025 16:43:18 +0100, André Draszik wrote:
> The patches fix some errors in the gs101 clock driver as well as a
> trivial comment typo in the Exynos E850 clock driver.
> 
> Cheers,
> Andre
> 
> 
> [...]

Applied, thanks!

[1/3] clk: samsung: gs101: fix CLK_DOUT_CMU_G3D_BUSD
      https://git.kernel.org/krzk/linux/c/29a9361f0b50be2b16d308695e30ee030fedea2c
[2/3] clk: samsung: gs101: fix alternate mout_hsi0_usb20_ref parent clock
      https://git.kernel.org/krzk/linux/c/ca243e653f71d8c4724a68c9033923f945b1084d
[3/3] clk: samsung: exynos850: fix a comment
      https://git.kernel.org/krzk/linux/c/320e7efce30e2613c2c7877acc46a8e71192cdcd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


