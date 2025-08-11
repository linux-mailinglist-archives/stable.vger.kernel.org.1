Return-Path: <stable+bounces-167040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE2CB20A76
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591C07A5A5A
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D12DAFA0;
	Mon, 11 Aug 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wdr4T5UH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524241BD035
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919388; cv=none; b=uGJRBv5tK2ivtruiqODW0YLqkVRqxudLuWLRRJzv7agumy33nsHBo+38N8kwxO1q1sUOxxEglFsLjy724tOsVg3mjp6Glnl2ZgFmu+A2/YJ2qFfeyEYqgsd2QMLGQWMT3YuQQ96PPZ3SS5mAtSAe3oA2zZvB13kkReEe/3I+AOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919388; c=relaxed/simple;
	bh=clEggjtaYLzTP4MRCQeAmK7J1GgjIsiD6H0HbmNpPwA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KhKV3E0ENmu7y1bwTwgm503pBz7Fcw+/0wM/XaDnKucaJfOyb2ZBNAE0YVYtGj4bn8oENF8FuXqqBkQ5x8Id6zg6qzqVG5Ny9OEjm1ABSxH9p+Pbd+vqQGaEkxH44etBjEiG+0As2/5xPKQ6Dpdk79w+4tGl5hHTHsWqyHbu8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wdr4T5UH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so40373875e9.2
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754919385; x=1755524185; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mgvgu9N2AijRJyk+Sq7xheAGC9tJFkrvX7b0MouEF7s=;
        b=wdr4T5UHts0li9DvZwvJinCIwc7kcp/npjyaR/0oNCIbiInmXE1lwZ5ZCLu5N3JvF+
         LCCGM8HRgYpyLIUr+0o9veTzxZGXM0aAzhMZM7KifGkfoQyiJR9CaNAUINYUhZm1tPHh
         HQAEFl8/a9/dBV6GfGjbbcD894S+ANcKqGFZSh3BxlF+oKjwrX8MY8rrNJRqPDLfPRFx
         HazeqohJmjWfSQdlcGtfXtS/gl311rjevd8P0hDvxAdCrwQOmostuQYmTRqyuwTtuit3
         ORxukwEPLxWsfbJzMGkazyUpQhO7wiDZL0mh6Z5QFybc98fJicpOFQtC3jRHyqp0IZDK
         jZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919385; x=1755524185;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mgvgu9N2AijRJyk+Sq7xheAGC9tJFkrvX7b0MouEF7s=;
        b=Z9oO3iFBozgW24IclbQQTDg/YJspzkn2GAOKbvRHmWj4T2L9nFB5eAJrz+sXwu8zOm
         gJflRi5OC09IEkKv34Iv3svtmKoqeOVr32dlWrIWymCPZi6a+YeAeYWuoh+rbu7T1tNW
         uarMPhLfQ3/aQ+A9MBSCvjttypZED6iR92/GlOXPMGpUt6ew49h53SyPkTPQGsfp9SdY
         CYcerncV8TcRLvOOgJoPFwkKfvVfCTXvLbuh0SXI0K6W9vNkocPMECAFEzsW0XjckAAc
         Ls0Jj4pyi6Ns4VceM66cqdKv3F8C7egcPAB/tz5ZjwwJhcNybNMZ7X230IkrsmLjCelz
         xt7w==
X-Forwarded-Encrypted: i=1; AJvYcCVIUbWTTyEXjtoeeylg0+4kJyxUSegHOFI4b3m1V02ypn2/l7OrfaqDBbMcfLrtxACuQ2LEGJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9/bZ7wkScXdpuLMV6P9WgksB8UDdWR5rKBG7S+8gABX4AOJY
	67k/DcGqGI9ULP/22wsi76AvPpq64lXJNCkqy/yiXjwEUUkp/ca9HdX2UJvYYGbhWMYqq7ZR6Is
	vWacw
X-Gm-Gg: ASbGncveF2QG3ykLZM+nF7nfMixGWhuCv72uzhXMl2NJSiEljKcUipIFAF18pzUOqE/
	K2aemBjFeE5DRGkm5el4HybZ/jhyTu2CLyXCbwbLBwDUq2xFDs5fRTz7kCbr0tbOUTMucj2v8yS
	MXkiP0CfwR4F05RtEMl+vc83QdHCLD5gkGVxwGkmCWyJCZzGpZvw/00o3zDrDlA6uOhye0FqYCx
	pWc0/WfR07J7rrTV/f09WO4kY5PQs1LB4DfMrbZ3A0mf2xV9q+8qGpiPVpTeRRALJRTlnTqqPyD
	GnFTqRmTfi4Q2PnUFH97JvKs6U35Jt6JUt8hUMyEbojyVilBdiSWELQTG8ShyApIiovUd+GH4Je
	5yY79CasvtHCjpuJQkA==
X-Google-Smtp-Source: AGHT+IHDTCjn6dBu5l+OgcVURiM6ym9RYYUAj/uH7kKQAWn+bxm23Sv86Ag1bxA1de9Pe5NZjNwYrg==
X-Received: by 2002:a05:600c:190b:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-459f4fac94amr103698535e9.24.1754919385351;
        Mon, 11 Aug 2025 06:36:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587d378sm253045105e9.23.2025.08.11.06.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:36:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
Date: Mon, 11 Aug 2025 15:36:15 +0200
Message-Id: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANDxmWgC/x2MMQqAMAwAvyKZDdSAKH5FHDRNNUNbaUEE6d+tL
 gc33D2QJalkmJoHklyaNYYqXdsAH2vYBdVWBzLUm4FG3E+N6P0HZ5FjuNDSwMRuY3YCNTyTOL3
 /6byU8gIfB4mwZAAAAA==
X-Change-ID: 20250728-gpio-mmio-mfd-conv-d27c2cfbccfe
To: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=903;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=clEggjtaYLzTP4MRCQeAmK7J1GgjIsiD6H0HbmNpPwA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomfHUYiAnVmpFO/oZDby6G3Nf5/lruJtO9Yl/L
 PeCjRn8/wCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJnx1AAKCRARpy6gFHHX
 cjlfEACaOEGk18hRDoKJNflCPY4MfFf4GwET0PRhy5JviWpFMYTrtB5tMVk8F4IfPlR0Z+waq/m
 HzKLZfJ46OXxlk/w1UaUfZxPh0PXi2WnO7k/O7q0H4PviNcLql6lrVyWCVqcMm0nS6mD0Xr3+m7
 pGTDTAUMm9EhyW2ANTdFY0NiC0mH0QIE5T488WnHqThXwKZwSPWAmLf/JzuGz35BDu+dxoPAEX+
 IpZwHudbovr04PrPAa2om/LfIUFGv8r0cLL3oATqcRu1HjdRv+qDX6KKq2eeYtJR4KkFq8w4lPN
 GaJAmGdIEb2VEyfLHN2aLS2EggsFOiEz0jyMsxh6JN2XYrHOlZHvXVW/u8uzlXgBPg3Fl6vP4hR
 iPgqd2BtU1puXtWD3ytDPMXkV+UZ1rUT9UhRs9UsbyQAS9uLkEQ7Fl1xtsVF47KS2M2C0vF0mAp
 FjM4WHe+Z/PbXPs2fR0Xj1gKPLQngJRLNmbJ0ltc6EeXCcWgNqB3CJSMDt0unBFzs5hlF7DFpUT
 a9tLk7admLgn3uoAriVVTj8WP/0zbYuQSqViufMoF954F0eaGv7wJnGGejuoaX44pkW7Wcy4mQH
 XFXMn9Odz1ZbuUf9kkFjcxeZytfNhrR9EaTyzQBtLQVG1MLZS0b9Wo6NUWmTnLIYPgRF7Iz66cf
 RcTiCXEK6wyHc4g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

This converts the vexpress-sysreg MFD driver to using the new generic
GPIO interface but first fixes an issue with an unchecked return value
of devm_gpiochio_add_data().

Lee: Please, create an immutable branch containing these commits after
you pick them up, as I'd like to merge it into the GPIO tree and remove
the legacy interface in this cycle.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_data()
      mfd: vexpress-sysreg: use new generic GPIO chip API

 drivers/mfd/vexpress-sysreg.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250728-gpio-mmio-mfd-conv-d27c2cfbccfe

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


