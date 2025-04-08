Return-Path: <stable+bounces-131842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7108A815A6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 21:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E788854D0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4924F5A5;
	Tue,  8 Apr 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCsWHMxB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E723F273
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139213; cv=none; b=WbcXXB5i2LwJ+RBQvcOTiANNPiGbbxETJ2dC6v7St6EGnk9hxYSDHLymTuw77EqLJao0EQqDb0XPJmyBtt75rJANLqAa+NC9qlAAznS/8Sv1g3YXCud1Pq4fAaI+vCflkuRZbm8nqjz5/nMTXhqfsZPiYJQ7X+IG1JaWMsF1Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139213; c=relaxed/simple;
	bh=XDO7GZgIXZbIuvcgx0MtmUVNnpEHDttID7IaGMbJf/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RGtuIJen1YKd+svSg0xEz6IHV98f1QGdJ1uf1ueef5ihHWhZ2BF5deCjux197tlZHaxIWf+i2GoYnYAI9K6NFSHUvNDz76g7q32ASbNoFSbL0qC3xvXR1LNRt3y5gikwKgSHTyJqt+BMTa3pGhhdSKvhAhWHFWhPOGI3jVRrCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nCsWHMxB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913290f754so653945f8f.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744139209; x=1744744009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26BZYOZea4bfw7CNCFKawdkyJnG29aqqnfgcKzudge0=;
        b=nCsWHMxB5lf12q3hAcn3iKQHC+p2PIBTwTv3HsESAajJeiKAPJOWxUFsd9DrebpWtw
         3E1tVyXPnfZgpSPM//j6H9q8oe2HPARv6UW4HzIwfCxG5xhk7E9vnJdMQKR+Iobs94/U
         XdhNLIJ5grTj4/KQXGGnMb+mS1B+O5SDMy0DjtR84rgIRTxyZP5knmMX9msQuGYWVi5C
         btVU8DFwbqQ1RrhbupRBZQq1oI+8SwwaF/wKyAuiyfIiZyO6QkwcNhwZbzTnMcW4eyf7
         D/Fj9HWbVsoDAidtF+Mcl7LEShs2vcxN782FDPaYG2KcUXCQrMJPgsG6+LrEmSA9RUEg
         EKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744139209; x=1744744009;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26BZYOZea4bfw7CNCFKawdkyJnG29aqqnfgcKzudge0=;
        b=V5ztylvph8QhxM6MbbEbB4iGXsIFF2BZx4Q9jfXcwNuEjkztctUFsMi5GzbZvglFfb
         P/xwLevjrHMfdLRTdl8mdKct56Qhb/GyjuGYZ+/ywR7+Te0aYmBVx5ghv5XIBlUe/TWl
         TkbakGJWLQkBBIniRky02m8sqJfg8r0XVheut2KlBnaZV9BPFywngqqwfU0bWue9ZZA4
         1t9QlaQTBxU8LlKBJ0/yy0Zyawxwa2jnPXu6wWRF1/3wsJLke8d3nNQML65uckfpbFAx
         nVM0WC5Y8ssg3coXnUxSA1gu2smUPw6+MgjHarrv1a4+Cm+C/V3fy1dY2l87rgAbXwDg
         Dq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXxsQ7Dt6p2cS+xF1LEkX/KCHbaUkqEHc/IFuhGH6o1bfTB1rii8Huy5wD3cCZNVRZ27PrPS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdH/HRDCIKaw9v0na3bCvUM080UGxEg7rEe5AVfbAcgPi2BU5
	3m/pCVxM0jJDubMlZDI9HApms2hfvc5S26xavNTrZMCzpU3yDhw/j8SwoYku6RA=
X-Gm-Gg: ASbGncvTcxXTLKLKNLuoMtRqObiGYa5gPK5xHVQAWIfmyQTxRNoIR1y/2QNT9rj0Ozm
	UPgEjBBHEt0sgOdjMT3UkoWswzevbdJF0cPsY8ZhWImQwvAHvwZ0m47nw3XKGgJCIoxitQ/MYnx
	ShDELlUO5yFIQW+3IVJ8+KTs3uucFAR2Pc6lBC5gqp6zR5HdaaHmcFzrkBygiUjIr73kj1We5yW
	3zELWyPrmPScIvKqOfXjnBrMDfq/lqielMxZqWnL7W/UIdCcv2haOwZYLP5Qy/xXtr40+A65OTW
	ybodgEiLu8SXDpaoYZ7832MqWPuNHa6U1Fz90Nd2mNmL9sV/kZJfu6CA9fE+Azs=
X-Google-Smtp-Source: AGHT+IFEmj19Sjp6m7XUEA3vyo+E8QmKaZA1qZbfv2jh+SPPFex3IJzzYfOY3+icqIou7/aTD5sG1A==
X-Received: by 2002:a05:600c:a016:b0:439:a3df:66f3 with SMTP id 5b1f17b1804b1-43f1ed660damr1024815e9.6.1744139209570;
        Tue, 08 Apr 2025 12:06:49 -0700 (PDT)
Received: from [192.168.1.26] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020da17sm15853743f8f.64.2025.04.08.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 12:06:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 jaewon02.kim@samsung.com, stable@vger.kernel.org
In-Reply-To: <20250402-pinctrl-fltcon-suspend-v6-0-78ce0d4eb30c@linaro.org>
References: <20250402-pinctrl-fltcon-suspend-v6-0-78ce0d4eb30c@linaro.org>
Subject: Re: [PATCH v6 0/4] samsung: pinctrl: Add support for
 eint_fltcon_offset and filter selection on gs101
Message-Id: <174413920812.155881.15584409813277033669.b4-ty@linaro.org>
Date: Tue, 08 Apr 2025 21:06:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 02 Apr 2025 16:17:29 +0100, Peter Griffin wrote:
> This series fixes support for correctly saving and restoring fltcon0
> and fltcon1 registers on gs101 for non-alive banks where the fltcon
> register offset is not at a fixed offset (unlike previous SoCs).
> This is done by adding a eint_fltcon_offset and providing GS101
> specific pin macros that take an additional parameter (similar to
> how exynosautov920 handles it's eint_con_offset).
> 
> [...]

Applied, thanks!

[1/4] pinctrl: samsung: refactor drvdata suspend & resume callbacks
      https://git.kernel.org/pinctrl/samsung/c/3ade961e97f3b05dcdd9a4fabfe179c9e75571e0
[2/4] pinctrl: samsung: add dedicated SoC eint suspend/resume callbacks
      https://git.kernel.org/pinctrl/samsung/c/77ac6b742eba063a5b6600cda67834a7a212281a
[3/4] pinctrl: samsung: add gs101 specific eint suspend/resume callbacks
      https://git.kernel.org/pinctrl/samsung/c/bdbe0a0f71003b997d6a2dbe4bc7b5b0438207c7
[4/4] pinctrl: samsung: Add filter selection support for alive bank on gs101
      https://git.kernel.org/pinctrl/samsung/c/a30692b4f81ba864cf880d57e9cc6cf6278a2943

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


