Return-Path: <stable+bounces-124278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A42A5F42A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80F93BC8D2
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C47267704;
	Thu, 13 Mar 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2WY8X+1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41562673AB
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868444; cv=none; b=SyVd/Ln6/4k/9+mcLKzlLbe4OMC7/mTqTV9D9qBxHEyCKc7OPewsThMEa/BQKLa0VKlcCW5uiHwsvlLeCvZFosYNG269B1TJFua6+IoeVt4sZDpl0dipeICNe4q9Ef9SNgvmaqJ5/a3ZPkKRGfmpMRLxiKwuGZPr/E7E5bQnyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868444; c=relaxed/simple;
	bh=vWTi3LR9hJZNwt3nMvFrGfBx1tozG7F0KblReapEJjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hGNGzTzu9x6dAvjMUcOXPF4/SvgOLTX+i53DaMs5wkH95PmehYRRiogBundvUUK/XKTp4PDj3AqQmhUiIT6SkFlNKexRxy/E/9UYnmaYXTL2fLTIfuxMWa9IJWbvkTuxFoXDux7t7ncTVY2EDpakhvULjN2EK8jivnWDDlY1wkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U2WY8X+1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e91d323346so9884256d6.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741868440; x=1742473240; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eABKFzeZYScxgYja+KDOHU4gTOLr6uHZM4XhISuduUM=;
        b=U2WY8X+1+8hBKhqS2d5jL1tVE+XJVgGeNker7Z/pO/NpAj7R9tuG+EH2la979IWLUe
         P8b6M1S3qpZgg2Q16pxnCKETRdAvGuMciVbmk/G4/SJch7ypnHXeJUUp/AXtYkLwIz4h
         x1ObV+qKEGlN7A4cYVFZKJKJk89vZlS6ZTYFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868440; x=1742473240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eABKFzeZYScxgYja+KDOHU4gTOLr6uHZM4XhISuduUM=;
        b=M5y6uFYurisYRgkhWPI5tGx+6iBD/55NqUz6x6LUnUvensOdcVeNpaC8HqViJGYC2c
         ANiUiHO8J8tWpMrwBDThWeFtqEX/+LvCCuLcE+4IuhcPAf3HZSKCCFxzTyTZz/0NORam
         MTLGuGMZkDoPqqLXBtQz6U1MGSwPjFLLwPPLfOjeYUMJQbSDgQ7/outL+3IYZn+pG3dD
         xjkZ2khKG8ZOyVfgd5jc5f9zuVZtOSor+GJOAXTlQCNmNfLtIWBt6EBt2PJ/kKU1rrMc
         KYn/zDzHfGtjWfTfeQzMLHLbFvz5SZqNLp2Yh5QCuilMdQtthRzUnMpvwP8EcAXZBOgt
         3YdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW71wbwC+XtUDKNDGyJSWZ2I2O9Q4jwNGyoYjzyUbgcwEZlQy1iEJfTMpczOsarT3KLJmnDjP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwepMP7bsohjce//y0beI5T8O/d6RI6rej4L6Zd5HRfnWsXde6Q
	6vZgqX7x5lXHVRRqK86cFCN8zD6ttDE4LqKHI2/h7+c82K3NPriElUbiHHguXQ==
X-Gm-Gg: ASbGncv/ceMfejXUfRD5aWUf4M90h4GnUXn2NuV+VtuoPBUgzYZz/m+/gUniDlp4Pr7
	ERxKtABjMOLWUe0p2/9Ddg/qkkV15yXE8i3iXJH3oxc1D3b2QVfgBRdl2zEQ5fxNa8q9DGLaZQ7
	cvdL6uP7htKmxKfc2zr760E7hLm9VvrFuOVWFpdzbTh66W9ptlPjLBZbmV0KTpW0F/i3u6K4OkC
	lTIj/yHyHofu/lGchmW+6LSAFWF5YSxHnaHGJtBp8jnMHnozLvfsNEErPoHh3iZoVsxqLivMqIg
	76qFT03VaRqqSia8lpKSIMgxpvhJ+uyN4nzMmxqHPX9LR4fc82IQli6lHcHMTSsA55nnjeDRvm5
	30I0Hyg84TNMCMMpTuPBZyw==
X-Google-Smtp-Source: AGHT+IFbg5j8PXxdID945dtHure5/GdfhUiyt/sO6UjxT+wwZ4ooK4hNtTzwXvCSsIxBoX2VJ0H9mw==
X-Received: by 2002:a05:6214:3c9b:b0:6e8:903c:6e5b with SMTP id 6a1803df08f44-6eaddf21d4cmr36484256d6.9.1741868440714;
        Thu, 13 Mar 2025 05:20:40 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade235f9bsm9038616d6.29.2025.03.13.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:20:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/2] media: uvcvideo: Fix Fix deferred probing error
Date: Thu, 13 Mar 2025 12:20:38 +0000
Message-Id: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbN0mcC/3XNTQ6CMBCG4auYrh1TWn7ElfcwLuh0gC6gZCqNh
 nB3CxsTjcv3S+aZRQRiR0FcDotgii44P6bQx4PAvhk7AmdTCyVVITNVwxwRaGJvyFJLDKYgY3J
 rSo0o0tXE1LrnLt7uqXsXHp5f+4OYbet/K2aQQZlro0qpUVp1xZ794Obh5LkTGxfVh9BS/xIKJ
 BiqsD5XiBqbL2Jd1zesVZ6g9AAAAA==
X-Change-ID: 20250129-uvc-eprobedefer-b5ebb4db63cc
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.2

uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
have not yet been probed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Remove duplicated error messages in uvc_probe()
- Link to v2: https://lore.kernel.org/r/20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org

Changes in v2:
- Add follow-up patch for using dev_err_probe
- Avoid error_retcode style
- Link to v1: https://lore.kernel.org/r/20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Fix deferred probing error
      media: uvcvideo: Use dev_err_probe for devm_gpiod_get_optional

 drivers/media/usb/uvc/uvc_driver.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)
---
base-commit: f4b211714bcc70effa60c34d9fa613d182e3ef1e
change-id: 20250129-uvc-eprobedefer-b5ebb4db63cc

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


