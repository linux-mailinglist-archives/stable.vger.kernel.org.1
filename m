Return-Path: <stable+bounces-106798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F8A0223C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A541614B6
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102BD1D89E9;
	Mon,  6 Jan 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbAoHQfY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CF1591EA
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157306; cv=none; b=PEkkSMTsKza2+27XCGGmSEU5BL7vao6C3Q68irBotBb9l+jb/fzJvyYcCXbVHAK31NurMWPZ1VIS2QRJ8K+N8is1jVKyBgGgHKxWJyhEAOZS2E9HGD18pcxpluWhFKHUToG79wJMfpwwKVvV20V1jye29Mg31fLakpcChU91T1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157306; c=relaxed/simple;
	bh=hsfv2qQhw8XRex5wRZMxOjS0luK+pUcgyVbIRe47p0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U6aRfy/jrTirIKN68OeFtagZXwPSU8/Wp42g48kOFeXBY5tXbpOGG2oC5Xu+8JdDhoHeTsl8O3z3Ig58NK6Xynv0aaQ+wXVAXuzWPhJxLw0cAsoWfaa3wiKICtjDjPCbyJMZMkLOT4ogsoiGda/3YDwCVa5t1/ajrMh+ZFnoVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SbAoHQfY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862de51d38so730525f8f.1
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736157303; x=1736762103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2iPJI5Pfh78RwJ7NO/ObtKaRz1jBQUIZUPPXGPcrds=;
        b=SbAoHQfYpqUlR/y820afSIUh0LtujNhVQ1Kfvih8Iu8dcYZB3G/lpSe7wgoCDAKscs
         JecL+/YQ9+iy+piSwkuyrrQGsru+IOsdXK6ABcOHLbUC5qfz9BJw0zZUdIIKcUKwPl8h
         BYkHUDDgEGL5VXe0oUaSvsPw9Pg3uQaTg+pjU9etvFwS5mPJ3btyNYhT4EEnDsOy6pht
         //aK7eOkiU2wOq1Evs4tuLgIESgeA22e1giKL/E45RscC1VjUSIG8XMKevnHA9JPjnsH
         6aHVgjVedD3bkAtJZ4Z0Lj1AMCyo1gFiaOfrsiic4tmi67xzkR8VUUyN3SOdHMZ1O391
         bJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157303; x=1736762103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2iPJI5Pfh78RwJ7NO/ObtKaRz1jBQUIZUPPXGPcrds=;
        b=vS56zg7nz/tkN6Dr6SMF6kwiiiBLBaHyEYgFkrmEg42ItoJ8Zqgm7NOWu85R1Ycncs
         Gqks78CR21Y97jw6hV2G0Af4CqfzaoeP6o6goBxiLHag1L9IAQXF8tG7Xm9sjFWMzGIA
         KYAwhyiuCD9vGoG7ahKgVCSHA3OKW90vww3XZ3jH1UHhg0P1k9/c2SlLf9Wk5XxaIsp1
         G18JVS1wAJ8Ux8t8KTt21DLFTuNIjw2ZK2Nl4CjQukiQ3TKy9xJuMpHY44X8txqhXvVR
         6Q/74c+aiPM9UQ4MIGLi6PKEQrKevTTSRjSpE++LsFyoIu3yCHfPHR3d9+410S1m72n0
         EK6g==
X-Gm-Message-State: AOJu0Yyd8/nhLmrxTNmPsrTWtt/lglhwkFZT1zBGTJaPKGg457AYGSN6
	B4ZbI/ZcBoHmtZAX2DgJa95PL2iTGjBPxJ/EctN0Zk7NG/RoKvNsgYan0xSX/Lw=
X-Gm-Gg: ASbGncs649PCxu/ThG3ze19YQ9cgg2vtpUdm1m3cdjJaQjxPZ1AypEuJua2ewAJHPUs
	Ws2Y6zJpo99s7/we9OtumepUybF11DlKNmGLaTqEgcI/TMUxuR/5cDy+6Exv8ymvfiPfv2I3PZc
	mqeTzHt9PDsnNLpm5AETsRLaq6rf9cgT8IoNZBmfhjTb/tAhDEUL+l1DC/EmJcI0FcPs/MKKsMw
	NThCpvu8UiPyofvCnT+F7s909kesmA2vXYv7OtoeT2M4dyAKY32vmZ12N6J1BW3PRr5vMPR
X-Google-Smtp-Source: AGHT+IGhzA81lWQR5haiIkxbk3kEop+JMPG5/OlSuDW4aLrYxnYZOj1Kch9Rz9kWVISox4P5OqqHAA==
X-Received: by 2002:a5d:588a:0:b0:385:f79d:21a2 with SMTP id ffacd0b85a97d-38a222070a3mr16327253f8f.11.1736157303498;
        Mon, 06 Jan 2025 01:55:03 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c6ad3e3sm49080520f8f.0.2025.01.06.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:55:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20250104135605.109209-1-krzysztof.kozlowski@linaro.org>
References: <20250104135605.109209-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soc: samsung: exynos-pmu: Fix uninitialized ret in
 tensor_set_bits_atomic()
Message-Id: <173615730230.114023.7997873261724277424.b4-ty@linaro.org>
Date: Mon, 06 Jan 2025 10:55:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 04 Jan 2025 14:56:05 +0100, Krzysztof Kozlowski wrote:
> If tensor_set_bits_atomic() is called with a mask of 0 the function will
> just iterate over its bit, not perform any updates and return stack
> value of 'ret'.
> 
> Also reported by smatch:
> 
>   drivers/soc/samsung/exynos-pmu.c:129 tensor_set_bits_atomic() error: uninitialized symbol 'ret'.
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: exynos-pmu: Fix uninitialized ret in tensor_set_bits_atomic()
      https://git.kernel.org/krzk/linux/c/eca836dfd8386b32f1aae60f8e323218ac6a0b75

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


