Return-Path: <stable+bounces-124096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C6A5CF90
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60DC1897E01
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A764B264607;
	Tue, 11 Mar 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQG9Xq9E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB36263F3C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721926; cv=none; b=deHLVTW2hZoesnVjS1DHUoG+EXbXLmdGjYLeRxZwfPAVXq3xW1nPWZ7Cx1R24DV9JWXWwn9ozvF3ytvVIl1eRYYqy4RgzE93xe1lsw6tH6Svkh8ttel+DwcZ2ewM65k5LY1tz9rJXdhmH84LhbZIzjbNGmpKOLGbB65Xi/cOKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721926; c=relaxed/simple;
	bh=B1uh6rYksykV9cmassOV5zLeR8dCezQN4Xwwx+1rMT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPrxgH0lPiaU2NHqIVr2tI887SzYJIg4tB7yMIM9DSr3Stiw3wdfqXemetMH9Q/+Sd6cZkm7fYgF45HGz0Y2Q7LX+MH/Qzyuz1wRQy+BPqp8sOcTrhj9l3rDoUGYoD9CguRa+PPThfLJudwuIjP77DSzLhYNzaeXBMI8HvQkbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQG9Xq9E; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0953d3e1so366355e9.2
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741721923; x=1742326723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk8/jRHxFdOn9j6NilUq3fYq1U2KDGu3FX6e3aC3Pvk=;
        b=fQG9Xq9Ec3q3EaxbKAjirOsEhIOKcVuAn5acIoCjjGiTx+Y8KSrJipiaMMHh9M0+eK
         o6GH/s7IYsroeALZLhWzVpr0idJz2+Y2nQgsl05OoHgTIlPVD9c1I/d8GK3ZGu9YZFOd
         SPj9o1g3b1UubQpe05ysJN2Y2G7koucdyf3pPmDf7MR33LMHEdiUtElRb24GfMcwrmXE
         OM0LtjMwPErWkSAeevEDusdBLro8LRFlXJJ6XLC+TI4l8s+FLPvOfWFK7FeXvcFpftzC
         1jJoInrUv2PTnU6bIcbz6EW22l1OUIE/LZnFjW3ilqxfCpISG+TocmYh8DXB+hhZ0Iab
         lSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741721923; x=1742326723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk8/jRHxFdOn9j6NilUq3fYq1U2KDGu3FX6e3aC3Pvk=;
        b=Ok3Mu/iSh1XWPXsyNadVGz1toqyTxj0tavoidvcaCvGMpCaEfoJNhvXss4Rx2Y5Hmp
         Syoe5fpj1RV23zgtk8q9IPDj0tGw5hHWiDgVIhUnqpyzIk35GYB3easApUBHPdNdeLJo
         nM+b8CAaiqDrFYhR9wLZJ07tQIRzXxrzFr5wkRsgYUq8DFm2uWPncGBgRIDjqGeyp5hz
         s4EzGd+spNUfHDWOh0ZmDqRMmoLqzoBaAkYnsLZF1qc3fGWF4xz2oZexx27yH2dHf13o
         YZQ+jgzGxdbre2lY5BKWhS5esLFcfbtD6wv3ef0eWyeL/jFXWEc+It4O4Xi0WrIFDOYh
         5PLw==
X-Forwarded-Encrypted: i=1; AJvYcCWoQLkz1pP7rNSDqWSr8iEA8+9C8vZDAcnxUwHTVIWdnK5qYb6AfMgnf7GeYH1HEaXxgPLkb/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZiyObRnuQeMHtoI/lZ2i044DZ2cuiys2m5ZMyrOj8uvjceq6
	ozhzuZZ7XpDmvkkGmOZ3qmJwJv1f6b6NfaE9rf9IMzeAxC7iVcD6gcX7ZOSRNag=
X-Gm-Gg: ASbGncuh2myvNqGzkW5RUiXO9nNa8x/pYmRKI0Be8V16UI5eKV4d6DzQeWJneUuIhLb
	vT0vh/Qz8pLKeVGrqMTlLKmOWzwjh10ap2PfHIsWVDUEuTIo7mKFalSxoq2yYCGi8TC3pM5REMR
	03urlL6NYrVnxc9pfgORyXcRHMNZAxzs1T4EvGmsY+I9FcQMGql6JJLj3KJJa9iTGVmznr3p37R
	k6itx/jxmOU8ydkba/1pRGlETJutGlznbWzvpOtaD5G10iJZvRo4yMj1kES0Rcauhhe1vcPBnXK
	JaKEOiG3HV1SF2UbOqDGHXBNhITtn/6Rfdc9hsKi7oJF2QiAO5HZylFf2Q==
X-Google-Smtp-Source: AGHT+IEEGrtv+WVqplhsyAIOJvjlmuBCpHGGUDzZq6EETtMUE4CHGK002+5IMzV1Oj/aRdFt9ZT1FA==
X-Received: by 2002:a05:600c:548c:b0:439:8294:2115 with SMTP id 5b1f17b1804b1-43d01c2b40bmr22475345e9.8.1741721922987;
        Tue, 11 Mar 2025 12:38:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf892d380sm81727225e9.24.2025.03.11.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:38:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	jaewon02.kim@samsung.com,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/4] pinctrl: samsung: add support for eint_fltcon_offset
Date: Tue, 11 Mar 2025 20:38:38 +0100
Message-ID: <174172189759.119514.8325135286672051459.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307-pinctrl-fltcon-suspend-v4-1-2d775e486036@linaro.org>
References: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org> <20250307-pinctrl-fltcon-suspend-v4-1-2d775e486036@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Mar 2025 10:29:05 +0000, Peter Griffin wrote:
> On gs101 SoC the fltcon0 (filter configuration 0) offset
> isn't at a fixed offset like previous SoCs as the fltcon1
> register only exists when there are more than 4 pins in the
> bank.
> 
> Add a eint_fltcon_offset and new GS101_PIN_BANK_EINT*
> macros that take an additional fltcon_offs variable.
> 
> [...]


Re-wrapped commit msg to match wrapping style.

Applied, thanks!

[1/4] pinctrl: samsung: add support for eint_fltcon_offset
      https://git.kernel.org/pinctrl/samsung/c/701d0e910955627734917c3587258aa7e73068bb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

