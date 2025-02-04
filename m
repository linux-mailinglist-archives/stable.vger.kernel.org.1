Return-Path: <stable+bounces-112123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4DA26DAC
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA369164A65
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04394207A27;
	Tue,  4 Feb 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3NVP4Bk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC920765F
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659058; cv=none; b=bfL5HAJ7dOMEO1tXDv//q9z70i6fpTt5ZiEBFGK36knHSEPcFai/blDG/sBOiS5OFDRxLRk+iOvPo2IZudpZFwbJhEn+qiMPRhg1GGAnU5eZmM6yFAHqthIoChrHxBDP2aBqHIuRpgdR3zxv0sSaOJ7CxEk1/LWWKCmNCp0WtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659058; c=relaxed/simple;
	bh=kqmMsjbCNiclb8j5uBxumVvyp3UHeWEC2xIcNL1SHNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N1bC72L9NZ7rgt5C2D5tKH3Y444XBSkFDoX1oR+7cDRgSxCKWAAC/1SGVtrWPTHR5MEDVWgUVsJsnZBQhhTrAzkGL5ljXk/KyY45SFtysVeB0sFTe/j7jJ7Q1pLK+uMsL79wZdvtnlhS4VX1kwzNqGAQFBNpD0jDSrgK3nYdBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3NVP4Bk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38da7198064so9537f8f.0
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 00:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738659054; x=1739263854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SL4WrTFt01P5kb4nbA+mR/wAIuzdlMsYyVAk52AYWQ=;
        b=G3NVP4Bk/vFi4d9MZxtyx+0yInbv5O3cVWBtJvGMBI2MhNo6C17PteyJSGezzqNbbi
         U9YtRzwE8e8ZTjFO6b4mSSDKMbA1wtoJzJ9duJ3QXmaxKfiDICxedOeLp4jfFSycNJ5e
         kn6bDBH65MSFzP8YZ01i0dBsxtt9dkZIdSnM7HZiWXSCs/QZIsFlOTRmVtE7We7v4xZJ
         /SzYjbG212KorzFCV1ZHHJUUlBIvQ4sPE42Ie47Px8q1AXkxjNikwwv/oFSpy2NHTITT
         pAUHKvqgHQ7qnP8XcVH6ggC9tQ3jWFAeBhcmEcsQArMsm4Wju/jZ9dEuxLcxgyLtO7rj
         gPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738659054; x=1739263854;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SL4WrTFt01P5kb4nbA+mR/wAIuzdlMsYyVAk52AYWQ=;
        b=K+edMn1jNMWtctcuz7AQsjqDYDXpKYFr18fO19U4nF5OQdGePWUTXlMKx8Xvz+kwL/
         RMDPIYri30xCDq/hwCujPFwF6m+RC3qHv33NLjtgtk4xoklfVqtxhhhCkdaQzZe8YOHU
         unKta6JaDF+DhE7rziQuFcRcTSlUEcjF+OBTIwp+IgMyMyflH0sQJuNX+eacBy2Zw0rI
         er3CpgR3pu6hw4k+7KIgSiYvBEmsrtyYI6bM9vNQ+MfypmZ/S+BO0nDW/BNYqRt42rK0
         sNAI5fFkpTzA1yLIbWJyrhqK4SOO3hvQpiH1KBFCAuiEIGVrQfKuQ382vrNt0CjpVN/2
         fmbg==
X-Forwarded-Encrypted: i=1; AJvYcCX1v+7/8KcZsUVslOlvesUl0tUcvYrc2aTfiZdOW1l243X2GCs2x/dxMjkjJRemoDqLQnb4Khc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1hDTCehe/7mCwQcrchUmH4kPoghgq6a7Pp7V2NGmT/WolYnL
	id9GoVD4dBUe1slyL2QgutiLKMitH0kTlAolWNSDeiRBQk5KLOZshj77iEypNbg=
X-Gm-Gg: ASbGncuFMPgPUKzV5wkd7Ky0ow/l5rHPhE/GKUjwpavwCzbLfNwggIDJyi0iW2OtCUf
	RcINTGFchRzkBEun0O3zpJaPKYiSZUiFtquzDTDCvuatBXOa8vh12trw+nMSe1xHApkgtGcUDXw
	PocL3QNKXTiT75JYy0QNabkr0OifNPa8gKf8oiHstDj1moDr/eS7x8etDdVIaAqLPcL0svjuOAD
	l/b2x+faIG51zL4oV/a5pSvTa2eoMWfhlSXNyRiu6XBkL5f1O4DFOqbyhiZ9q2XQdpgus5fpE0j
	y/rbnwS53gEJ9DTakRi7Bl5iRT7StUY=
X-Google-Smtp-Source: AGHT+IEiM4BEwyj9kJjGaATYMGTVdtTyQJ6Gai0nJrlUHfZWE9a3z3Pca5QvAuf1g0u3xA6mvsDd9A==
X-Received: by 2002:a05:6000:2a9:b0:38a:69a9:af95 with SMTP id ffacd0b85a97d-38da4e1c7a1mr784380f8f.7.1738659054614;
        Tue, 04 Feb 2025 00:50:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38daf27bbf5sm503066f8f.48.2025.02.04.00.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:50:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, kernel-team@android.com, 
 willmcvicker@google.com, stable@vger.kernel.org
In-Reply-To: <20250106-contrib-pg-pinctrl_gsacore_disable-v1-1-d3fc88a48aed@linaro.org>
References: <20250106-contrib-pg-pinctrl_gsacore_disable-v1-1-d3fc88a48aed@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: disable pinctrl_gsacore
 node
Message-Id: <173865905338.26600.2847324274342938346.b4-ty@linaro.org>
Date: Tue, 04 Feb 2025 09:50:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 06 Jan 2025 14:57:46 +0000, Peter Griffin wrote:
> gsacore registers are not accessible from normal world.
> 
> Disable this node, so that the suspend/resume callbacks
> in the pinctrl driver don't cause a Serror attempting to
> access the registers.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: gs101: disable pinctrl_gsacore node
      https://git.kernel.org/krzk/linux/c/168e24966f10ff635b0ec9728aa71833bf850ee5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


