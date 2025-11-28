Return-Path: <stable+bounces-197582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC75C91EBA
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 13:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A10435455E
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7F30AAA6;
	Fri, 28 Nov 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RYz2pkfO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCB264619
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331159; cv=none; b=FY1VIhKsV2Dteg1Qvq/zDyWF5B+tWaIeayPU3E8l/meWX8CmbIAdhaGJ4tGkR0Go6A11OcgM6pRFA3UNFJN+9Yr9BiUNB1Vwdl6CzzzIuYkLz76c/MinsdjDxQG9TXQKKG4BdpILXD4pS6ibclpsTLKMOhltEq6K0RVzvTvQqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331159; c=relaxed/simple;
	bh=FlbAgT3Fsp2QFJzt34+r8ldrh8ZXqT2HNPYCtznDzS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9T3JtEqblXAYfpeS5u1zO2p7oHR+4ITOTLnRdc/g0cVZBP8xtpVUOuI+QKKHbYTUW/lbkD67QnjQipuSPCMuA+/tTWsRbX+cbWujTESvtVgVLPvOtlaowS9evFznUyfmo8TxavWH04voCJbquoBoaKrPfkfA5CRJhPZrvLSfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RYz2pkfO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so10600655e9.1
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 03:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764331156; x=1764935956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vzfBzGWa4ODlWjmtVQJGXcxzSl0srJUX999pZiDEZM=;
        b=RYz2pkfOC3r0KSprW4Padgmrs0rX8dI5UmoPz1j2XzZpKqn7l7gM5bHjI+aneNdYCb
         ZasOLjyJrTuVaiO2+50NojV8ldqAbxgVwFKO+LuAnBVKqv6e4NQFVdhVdk2VS+kWKVaq
         prfKfXdabAYpJFy9iPPNS+/dBejuf/Sp9aBS6dZu8ESfY83uOcGR3ZRWgvElxqf7vzzj
         LaGyT1fWMcbqfUz15wtgjkc2m2dNemEjAVhu9mnYHPZFBrjSUdPpGTrNABtli15MOXtY
         DCixrXWz/k+QtS+8E5IAZjRkUeET1MO9LCytWM3Dr5ECt4fbM3y6Rgfe+uyTCfJn1qT6
         1Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764331156; x=1764935956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4vzfBzGWa4ODlWjmtVQJGXcxzSl0srJUX999pZiDEZM=;
        b=A62NWGHVYn8S7GsTxAPe/2q3zy9qp+qwx8Y0UyQ8beegBScr4OjaY6gyz45TFOJ6hx
         m+xsJ0uyoxYr4qFvmmn3RwxgSrxBRZTJZ/R7NultUXdjMjqUwAY4yP7S+ll+yaHFfjVM
         FZGYSv13L7negv523xPuMQ49wyZEth2k1au8pnDkhkcLZ/g85xssxnCJsB+U3gdn+gc8
         a1NqVymIGZ/O19DYwfuN1NUKqwwna7+CYkl6EbrZlJZSu7TRhQ1k0kWvnu29kmbt3tv8
         i/QekpaC5Gx+kXwPdTOqV2eH1fkkKoX0H+CYydMMYrk5GpRwgMBCUPRS84MR1pTVfukD
         ucew==
X-Forwarded-Encrypted: i=1; AJvYcCUc/XEanoe2VaIg/pwcSyiK0pbJuQxq8PWQHpUfoWGABhcCDFVO9ys2KEw3ZbNWTtLhF8mq/SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGodh5GzYebhT3MgCmUeSaVEKVtj8WVDFpFHIkzlszDs4erWkB
	sFwQI4Pj4SjsFf6vqc2EoEVIEuX0ZKUuYzyx7QyCutB/gGCiFS6IfYuYxY+Wjw0WLUU=
X-Gm-Gg: ASbGncuHlU3wQ7H4PizxS34CLKMnyfgz+FBaWutNjqv195wiwx8j+CiOfgnizUUzUIl
	BOKzehL+UXf4Jt264HjAIaTETQRhrUl9a4X+qo5s+7w0c7hYRakNVG8pM6aGbEKCIotWybp5bvI
	AmUg93WB7+QuwBg/x6ZcYRlE/jgIsUJVFpqvsQ0J8KvQoP57/uEnRSZl+rILzFPPy8AmeQH7JeB
	3HIRuBXpoPY8N0FGmvN6zET8GeAEumlQrG0KCZZQtZDoQprU6O2xRGHaOygODHvtw+sxBYCLdPq
	AAAspB0ogRmS9pyOukwDGHEZG0FNsm8HwKoFjTT4QcpvUM+GsOhMUGMoCSlivilwa/9HDa/TZ0K
	253mx4swdpUEik2Bj0eKLzTF384yvihCfCYpZUlwAG3JJY7ljaHvhEERkuAuC5AYMhPwI/JhrpI
	Nqit91
X-Google-Smtp-Source: AGHT+IEblarfzojmnW5H0khhj7fcQLRiTfu2IrK6EsUrlrrVoe2bsVmRXDHPwcSd7mEc/1Ggu5xZRg==
X-Received: by 2002:a05:600c:460a:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47904b1b2dfmr89703405e9.25.1764331155967;
        Fri, 28 Nov 2025 03:59:15 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:f3c6:aa54:79d2:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479111565a1sm81343515e9.5.2025.11.28.03.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:59:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Mingcong Bai <jeffbai@aosc.io>,
	loongarch@lists.linux.dev,
	stable@vger.kernel.org,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: loongson: Switch 2K2000/3000 GPIO to BYTE_CTRL_MODE
Date: Fri, 28 Nov 2025 12:59:14 +0100
Message-ID: <176433115039.40295.3243947969244377474.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128075033.255821-1-xry111@xry111.site>
References: <20251128075033.255821-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 28 Nov 2025 15:50:32 +0800, Xi Ruoyao wrote:
> The manuals of 2K2000 says both BIT_CTRL_MODE and BYTE_CTRL_MODE are
> supported but the latter is recommended.  Also on 2K3000, per the ACPI
> DSDT the GPIO controller is compatible with 2K2000, but it fails to
> operate GPIOs 62 and 63 (and maybe others) using BIT_CTRL_MODE.
> Using BYTE_CTRL_MODE also makes those 2K3000 GPIOs work.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: loongson: Switch 2K2000/3000 GPIO to BYTE_CTRL_MODE
      https://git.kernel.org/brgl/linux/c/dae9750105cf93ac1e156ef91f4beeb53bd64777

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

