Return-Path: <stable+bounces-169366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2039B24732
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017C65659A6
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB842F3C33;
	Wed, 13 Aug 2025 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUFJxWfG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7F2F1FCA
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081010; cv=none; b=iCWtV08u7K/ryBjtSQShH2jzS4YDpXm2tXVVWt65Hejg00nXCk11Hw/j1Bv00hgEZDN7VWZg1tp56QjQPTConjBr5OhG/VCmOLxl+1P4BXcx7cnkMxaXD9OZBD24HpJ3QVzoHjwNjAtwSldOxSMkYcZb8Jzuc7AwJ1Gu+15qAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081010; c=relaxed/simple;
	bh=j9nZfVw6WNDy8P2NhYDYq7yIvlQTGbMyRsqF99spDPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UwqyZAQJN/qGVD6P3JZyDrMatvNv0uwyJpf9eU9LuI4p3ho9/d0D6ow8zu7XCwRmc2R/dgyNr7VfKKjWFr0am3O7EVZO3bBbxoRJG0A91pB/9DJVWvziH9bB89mJh++MfaP4JyGv238sM3c4AmCzlUno9UqHCrjRnyGyJANIQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUFJxWfG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61563789ab7so813538a12.3
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755081007; x=1755685807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/uSEHyOY8TPjXVXr20mUPgAnYEaOn2OIFqZC7pMk9s=;
        b=WUFJxWfG4eSFGdYuIruhFLprBSs3OYy9j9FabWpGTd7q2ocK54xvxHDEJJ1dfFkvlJ
         hfUJ61RLp3OIyhZEbcFzLm2DRUtlY6/mISgI6pBwd+ybA1+wEZJst4mMyCPvK8IScmTD
         oaZnS4AJ6/4tNpulm0OZ6wgoG1TBNPrinTktb3mqvDIJFD4ioqQfE8FIcFTHcisfuI6a
         9FHDWjmkdUKbu32XA5vhCw47pfv6dez5Tx9ZD7tPUfezjnxaVPEy0LqVY4QX2mZdvfmx
         ShAzh2JXgqwyFVS/rwYZNY1uDrx9iVfw1JD3YdxkjDDQzfWN4Ub5x/Djy3f+6EKA4ntR
         p9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081007; x=1755685807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/uSEHyOY8TPjXVXr20mUPgAnYEaOn2OIFqZC7pMk9s=;
        b=AD5lnUbbisdITkzRqrosHJbfCwesm0wVVGdvvvKwl6eDnUU/2mpcSiK5sltRBdVHns
         8RlFDRaMimoPItXYpb1EPzKoceBGI3xRLgRSd/UjWdwRSaQ8V84fSwTyFLNzqgcqK2yR
         JL4D2LWRR1Qwg9epWLMX6BBVaUwMonLIemke8MUNK4RSOQ3dIMNQ40OjN61G7UzE9rFI
         qLqExQaM4Ik05BMC6eRh9rV6FgFtc+mb0upD1lN4ubNWjQySmn6dFLNVx1XRMGX6A6iV
         KE0oIM/4d9ig6DzmPXgflat7MwJnDYii/VjDloWOHEjAF/Vl+UvRziMbB19QShCz1WGQ
         PeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhrt72mD9IkJalkSegQG9di2nQZHA1b1SbEcE02lepz+nFIeeI1LJFW7ki7lp8/ttNi/xEFCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0bzq1zq3SO2X/n7460SsJBKePpfaUzfBaqwF2Ga5kCm2+6e0
	2rwP/jMfx20gnn5svnw5UO3OAqAkb+Gg8BJg5Bphqh/8ivJtj1rTWExK60oUhMZRpbeW8t1BMOW
	YU+fv
X-Gm-Gg: ASbGncvBVyMdJegVOLt9MFgZx8v63vH/0pVyrG25j/vCCdoArEYVhaQjkOLDz/xkOec
	UcSQH/6nIjGHWMA6KNhNnH1U91woKru0LfQKkRXyw8PpF8f0NUPDL0XUodDrqlUVjIrRQWxAQQ8
	xGGDF/6Duy1eUxpeVg0GB9bgdJHwnuFr1BaMVw4VflpMukWTd256LmxZfzppvCo8HUu7sJmMdEz
	pBIZLj8AkCfq4yHS/rtozup9dlwiR15MkXZnZZVKzIEKM+nZ6XEPyqTjELgcfD7udzpf95epDWc
	KV9bzAY/awSQPXc889dXIWXva1lgIHptquxUFdbjXKH12c1QJ3z2hTZTEf619LJXt42HvjvExz0
	rEj5jbhnPrmlmeKN5fBO2Z9iL1K3XPHnNnmNRCAw=
X-Google-Smtp-Source: AGHT+IF29cdNPOBhCMcj9Obj9AvGdSJsCml5B5sk74SLW18u0La5OP66JPcnqGI8eEVOZWoaJs2nkg==
X-Received: by 2002:a05:6402:1ecc:b0:612:f2fc:2b9b with SMTP id 4fb4d7f45d1cf-6186bf79c06mr842428a12.1.1755081006695;
        Wed, 13 Aug 2025 03:30:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15d9fsm21466335a12.17.2025.08.13.03.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:30:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, alim.akhtar@samsung.com, 
 Zhen Ni <zhen.ni@easystack.cn>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250806025538.306593-1-zhen.ni@easystack.cn>
References: <20250731083340.1057564-1-zhen.ni@easystack.cn>
 <20250806025538.306593-1-zhen.ni@easystack.cn>
Subject: Re: [PATCH v2] memory: samsung: exynos-srom: Fix of_iomap leak in
 exynos_srom_probe
Message-Id: <175508100520.39785.3470511038407039138.b4-ty@linaro.org>
Date: Wed, 13 Aug 2025 12:30:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 06 Aug 2025 10:55:38 +0800, Zhen Ni wrote:
> The of_platform_populate() call at the end of the function has a
> possible failure path, causing a resource leak.
> 
> Replace of_iomap() with devm_platform_ioremap_resource() to ensure
> automatic cleanup of srom->reg_base.
> 
> This issue was detected by smatch static analysis:
> drivers/memory/samsung/exynos-srom.c:155 exynos_srom_probe()warn:
> 'srom->reg_base' from of_iomap() not released on lines: 155.
> 
> [...]

Applied, thanks!

[1/1] memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe
      https://git.kernel.org/krzk/linux-mem-ctrl/c/6744085079e785dae5f7a2239456135407c58b25

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


