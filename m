Return-Path: <stable+bounces-165823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13224B194D3
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 21:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB3F3B48D8
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FD1DE896;
	Sun,  3 Aug 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iVrpSb8N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513135C96
	for <stable@vger.kernel.org>; Sun,  3 Aug 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754247935; cv=none; b=qb6Z+nC8c+eqY1+JS8vAkTjh89EOoNy+i2YLJU9u780qwFvIIPEetuQRIvnZjc9Y5HjyGiyE0PXZHBcTipN65nRnpmUQzu7jKnktu9IEXVBu0ZIVBR74/qJ8x3ut9/NQ9fjEVRPN4d7oy/mjx2y/GU94UhMk2j985h5If5goq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754247935; c=relaxed/simple;
	bh=BwBmtnv/BpaSXrA8JVdt3hc6pH4difSzYPixxu8akJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd3A2brmW520IibOZjw1FSlXfTgD6q+k0zUfQlMpo4Ttci0IxOYH1DMQgNUEpq6XKBUgQYlOQuwU5Juix26alozttPS3P3G7+tOkGL24OqAvmaPHRZ7nEq3S0vNree9sb7IkzzWg1u1KA2do31wpBH9Dvo1Z71nefeW6DlFhH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iVrpSb8N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458ba079338so8705315e9.1
        for <stable@vger.kernel.org>; Sun, 03 Aug 2025 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754247932; x=1754852732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up9M/4hUY4Zre3/HEDOm7wwnikDuaJtzpmpnD4b0pVk=;
        b=iVrpSb8N8MvN6nWxkBBV1RyLLt/msq6AZbGDDPSm37ZtoB5X1Bj1S+IrFJY/5BjQ0A
         xXsIYPB9dWjJdoYXeam88pybWUWBM2yz+zCZak/Fk7QJ/S6voaML2hky/y6ROPYcDWNV
         XNTzLnSlJwXbpVXUGXdH/3pzLtUJ63B0Q7uljQ81vqwoZSqKHgB0cFDD4AcfDD2DkUG8
         wLykUpqvlH7Hyzx7P67dC51qpWeBBok4N5Dsgtn2qVG1sBTttn4sSjl+YdOn0x+D8vge
         BbEvf29AkYXFqIhZO7taAJITyAhJNXcD6Q4JNizTELfjztDB4I57o8r13ito31pCRX/t
         UX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754247932; x=1754852732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up9M/4hUY4Zre3/HEDOm7wwnikDuaJtzpmpnD4b0pVk=;
        b=FuzSvwPkm5Os6V/EISZ++g2hR35vfBKuRaIjaxM5e5UtKbI8sZsCT9DXOeRn3iJUtH
         TosBY5EFXbRJL6vzbgefDIeSeheTEfk+MKL8pGIhuxXmZ2++k8uBPbcwjcEpob4UoZIU
         Li1hwaiY5Fk8A6t5d/GWhcmoPIe8qAXyTsbU+6P41xGeIL0JL1yZadWFV71LctUO7EVw
         fxe1oKQH7eJrFV1XQnEi2ApNmWxUKTNHSmEIMaQoG4FK0jqKQAB+6NRswC5siXyVfCP+
         ZKg6vpcapc/swxOCfHrLgEOOtX3TiXBQft0wXEs38WiJGexJ4FqFXF+wZeUihvjLdC83
         9ncg==
X-Forwarded-Encrypted: i=1; AJvYcCVCtb+VSsx65Tjk4eoSPEsYad1GLT5nkCxxZKtYvOgP2kiErL565O1q5JmvwPF3WCYlOIa1Nvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0xWXZ8HOA7ZSivYbbf8IAp4rQXjB5LShYbAl/tZQ1zVPbAgN
	Wh+WfVsh0z9zV2dcIwOGITREtRsOrn7bdkbrBLeby6ySr3kS0cpgU5iFXi4yG7jlSn0=
X-Gm-Gg: ASbGnctz5AE+TEWQmKtVUp5o9tRvp6fl6n6baibZz1rAR6VqE8GbkcetnpibgHUkjiO
	TZQVzO5RXGTPxZuTZEgjSYTN5WY36S4+ODfbwqOIuj55YRPI7J21k0OGBoCnSOveMbWxdrCY0CL
	cpim6m46Ugam4FocqmrfVu+3TcohVMPaaqFZywgeajt8BCkfcNwDtXFXW+Om6xVW2qaPscZ8CvC
	qC1M8kjIgFTPA4KycN0o+KJncdfEIYj/tSXNBGUOMz/W0oMT16WhnC2Nfv9WJ0LiZLBtJ3qWjzQ
	veikr+g25TqaM0g3k+6ovXwYPgmRMn7RWHgEYKdjwLRh+8UrfHX1OG5dJeX8rD4fAzYb/SA14ma
	caZ10o3rcvL8pNvIN8Usoy+Zu6NlobGcyg03UNkzhSYQkiAOtg6iquD83wm1WMZKehPI8IxkfNs
	uK/xmzjw==
X-Google-Smtp-Source: AGHT+IEZ0V8vkr0azlFyjnANX82PwFUs8FOonbF7UBmw34xohUJLsmAV3egOIPJEYGsTVHJlXcZaDg==
X-Received: by 2002:a05:600c:1f88:b0:456:189e:223a with SMTP id 5b1f17b1804b1-458b5f0ac7amr52599785e9.10.1754247931531;
        Sun, 03 Aug 2025 12:05:31 -0700 (PDT)
Received: from brgl-pocket.. (2a02-8440-f501-a968-a175-e139-72e5-a366.rev.sfr.net. [2a02:8440:f501:a968:a175:e139:72e5:a366])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm12948486f8f.47.2025.08.03.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 12:05:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	davem@davemloft.net,
	asmaa@nvidia.com,
	David Thompson <davthompson@nvidia.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: Re: [PATCH v4] gpio-mlxbf2: use platform_get_irq_optional()
Date: Sun,  3 Aug 2025 21:05:24 +0200
Message-ID: <175424788066.7115.11334819523801488773.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728144619.29894-1-davthompson@nvidia.com>
References: <20250728144619.29894-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 28 Jul 2025 10:46:19 -0400, David Thompson wrote:
> The gpio-mlxbf2 driver interfaces with four GPIO controllers,
> device instances 0-3. There are two IRQ resources shared between
> the four controllers, and they are found in the ACPI table for
> instances 0 and 3. The driver should not use platform_get_irq(),
> otherwise this error is logged when probing instances 1 and 2:
>   mlxbf2_gpio MLNXBF22:01: error -ENXIO: IRQ index 0 not found
> 
> [...]

Subject should have been: "gpio: mlxbf2: ..."

Applied, thanks!

[1/1] gpio-mlxbf2: use platform_get_irq_optional()
      https://git.kernel.org/brgl/linux/c/63c7bc53a35e785accdc2ceab8f72d94501931ab

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

