Return-Path: <stable+bounces-114503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DABA2E8BA
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480D518831ED
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056241C5D6F;
	Mon, 10 Feb 2025 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpgejfv6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF061B414F;
	Mon, 10 Feb 2025 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182156; cv=none; b=nxeJ+gr5AYZ/J34Nd02HbIi5kZz1EbaZITtK8stQV2MV/IqYM16U3TOZE9w+q2P/CPb/hZOBBDRPwVne5Y9hsmVU/DC1niooJXAwPG5rUTDNisMyt9Zqm9DYxhvfgxn36Q74G0JcoQKfTC4xxtgyb0vsj6Jn2swfDmqchIrE0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182156; c=relaxed/simple;
	bh=5dzyKtWqZnepXYQlMsqs3T0zFLasKzwLYo+Yn/dRQyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLnDLas9bREASpuIhNgVuxbXiMs8qNIluaWB9iMqCvveaAHZBGIZEoeL5slil5JLrAqkXpebgSIXGbMGeytfnigZJs2N4w0b6p09dpNXgVWIJaCDkGmrwoJyoJYtD0aqWR8r62RmU1T/VpBYJZd6U2yjHmTRWpFch8FGQ4AND1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lpgejfv6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so4900011a12.3;
        Mon, 10 Feb 2025 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739182152; x=1739786952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5dzyKtWqZnepXYQlMsqs3T0zFLasKzwLYo+Yn/dRQyU=;
        b=Lpgejfv6On9powqxnvhWENz+KFE38JVDUyEQ2Tz/Df9UwJDUVzjcK3+Jf6/wq7Z6H/
         uoCobHj0cP9AMwxrplTbacGO4dnoAsLw1i6HeZ7pQtyTDXcZQshCH1ppgZjfMnHiOJNL
         G88CamyxSTPdVegHkdzdtW3z6ncKLIcqps1c7mQ4HZ0/l4mdAjk4RAb44mNqarci5oIe
         0HuL61NbZNSFF7hnkoFwRMYi1f4TBGy7UOeq4OTsDKFrNWSW7Al+jgWSN8+c2oylNFbi
         0VzCFCkEhLvRTwIW5e18J6cp+TOqWVpdo2MniOEAAMu5Z7H0CYLmenpFuHpRYCUNu2iC
         1Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739182152; x=1739786952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dzyKtWqZnepXYQlMsqs3T0zFLasKzwLYo+Yn/dRQyU=;
        b=e+/WhpMFNoAbOjTJDWqi7ZiYc70N4NqAvS4PNCtdfeYIyzbrjy271TVih+r3+C0CnA
         iyCN+YaU3XF5mHeRrdwrgE1b20V1WlXJ8g+XfpebBfE6QkjIft4peO5hxmPU3R+y090k
         VtIuDETqS1g+IuOCvhFdB+XefECcO8L9M7v235q+/fc8+6jA3hLSthMgU9T70moqkWbL
         JpemKi12hM8S5dCq2VFSyvNkxbPSCgSHLGymM0Tfm7+3iwwVbvTkWMgytzuftLjkl+4Q
         g0HBiSLH549s8/GsDmYQ116sb/AYzT0XgeKESonB7AyzbiyKtuvpj3FbztrZeLXtUdsa
         7nrA==
X-Forwarded-Encrypted: i=1; AJvYcCWwf2Sk+0fkHg5s5ODw8u2RJpWy4R+JxO4cp9DR4+gR6gJVJMnoi9qh7LK3JkWImw5BCwSia76q@vger.kernel.org, AJvYcCXI9i9QtFq0hJGpg3Eq/EjWy6mPIk7NSRy31BLI4PtEcyMjhvIwk0mwDAvD4E5QinUWN8A1KxFEGr2hCxc=@vger.kernel.org, AJvYcCXPVEm+c2s73Z4G/j4DcweokSrXjHeABwS5T449yb9YjNU1yjWjmzOqQ4LKN+b7Vdc6mShMFkhm0rYKLFCifl5AY+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhymV3pIbZTsnqhf0X7qPuKXaLYYPNKZTqXE0WvppkjqmT2Z4
	n3O+MXZcNx4d++nGQb2jKWc2rVDcjoypSD675zBlqGpEQkyHEQQQbNV4deXTLRTwkAQaYPjQJXt
	A7QozIyQYL5H3XkHgZSMr8Qi7Pvo=
X-Gm-Gg: ASbGncuux88gdgY4niWul+JSZR3SluEgCeWbrWPml93YRUdeQLKzagl1THha3DQ4N98
	8K0Yc4rLedAIdVrZX5OnfCs5LQCkbkRnDyev7za6YMebRXDqgJqya5v61DNI68TuuplxSqg6J
X-Google-Smtp-Source: AGHT+IH05m3EGDv37NgCHa7r72kurcQ8bsVSV4tB6ZTwaZHVAXVKJd9j8KrWy0sZ6Kd7oDJwTcHKTTZ7neMq4xpHZUE=
X-Received: by 2002:a05:6402:42ce:b0:5dc:73fc:2693 with SMTP id
 4fb4d7f45d1cf-5de45023654mr16526726a12.18.1739182152139; Mon, 10 Feb 2025
 02:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209-exynos5-usbdrd-masks-v1-1-4f7f83f323d7@disroot.org>
In-Reply-To: <20250209-exynos5-usbdrd-masks-v1-1-4f7f83f323d7@disroot.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 10 Feb 2025 15:38:57 +0530
X-Gm-Features: AWEUYZl-ymjB7hMb8tRQlI4jusE7F1xxvFV_L9geMxys9qNgTR3hdyKQc5pas2k
Message-ID: <CANAwSgQAfwq2tmqB=+896YGhFFa1hJ18W-cAes2o2bseJiLUsQ@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and
 SSC_REFCLKSEL masks in refclk
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Vivek Gautam <gautam.vivek@samsung.com>, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Kaustabh,

On Sun, 9 Feb 2025 at 00:30, Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:
>
> In exynos5_usbdrd_{pipe3,utmi}_set_refclk(), the masks
> PHYCLKRST_MPLL_MULTIPLIER_MASK and PHYCLKRST_SSC_REFCLKSEL_MASK are not
> inverted when applied to the register values. Fix it.
>
> Cc: stable@vger.kernel.org
> Fixes: 59025887fb08 ("phy: Add new Exynos5 USB 3.0 PHY driver")
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks

-Anand

