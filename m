Return-Path: <stable+bounces-120180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3376A4CB99
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F263A101D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE2217F56;
	Mon,  3 Mar 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CZHc6xZI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE222E002
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028837; cv=none; b=i4P/a6JLJ7XHhiunPI619cXv2lMaKJWxiFv+8gVcig8it5S80ljpIW9Zsuqm+PYvGehtSdZFvDwdtT3EG5GwCv1uZzePmyBbZpAXhsZRyjHGyQmIwJkfD5xYK1QCQH8a8rcUARKEWmVaZTNZc3pNgvmByYBL0jyr1oNWRuMH8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028837; c=relaxed/simple;
	bh=C5LwrENTwH2Tgw+FAGkSdZC6DUqgfwq/ejX6RuFexBw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G1xTuECE9vcFxN0ktDLdJmEHZ3joQwzPRL1gQePqBxHyD0QxMJTnQ0sYgbZEdWLmhvxV4oo5BmrIe2rkz/DaI3LdUofIaajJoCdYWL4tJeeD0WoBf7yrgPv7NYExP5eSlBioR11nzUwYNg45klOYL2DbRXVt9nQhIPADX7xBqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CZHc6xZI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-474d7e43b44so16340501cf.2
        for <stable@vger.kernel.org>; Mon, 03 Mar 2025 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741028833; x=1741633633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjLrrjbGelu5EpoDPa36UkPc3emrxmZFTLwM+KeGDFs=;
        b=CZHc6xZIykauGXj/jLM8hTQpj7qEHEKmcWNWhoe6NqxrK6EkeVpx2ZD+ZVlIerngAm
         NzIdkncxwxdbLbIDpKUs7tNUbiN8fq0rxvb+31EYrZwFQurrvI+wJM0ezoK/yFBBa1FK
         vDA/PNwPbAzh8EsQ1XBpxhy/0ey2WOQLxtVl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028833; x=1741633633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjLrrjbGelu5EpoDPa36UkPc3emrxmZFTLwM+KeGDFs=;
        b=HL03siEtmaCUR4BReu6p/7cfJUJbgkoHJhqgZBkbW932oGVDAweq89Y56mVI78jk41
         EZUTE6AkA/EcJzhEu86/06+0gs0E/FTgxOFKAsndQP4GB896SXW/9W8G8Jd5q+H4T93c
         mD+ZXRuesw+yLsC5xkDwhqVMrAxZYyh34hzpptDuSpNQdKW3LCfbji4/VvMKwmZa5Wen
         NApx4OofebIXjEQdUhmW5jYm0LNROTy0+/cSM473aZ1Ed0QhgHPDgVbb5yyfRaGjdU65
         oFsvoaWKwTDo2HJAtZe+IRcvHa/cKJwTGpdVM78fKzbSkx7K24/LXfvkk81VURjQxzm8
         Wykw==
X-Forwarded-Encrypted: i=1; AJvYcCWdCB4H/rYxqoNown7BXxNtmktAtcGQ4g0K6yefTLlq5VOdfuVa4v71/QyUo9ibR/y7EvD+N6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EkHAXdub/KEcOGXm2r67ry+aJUlSGHly8bXG3vrlzeI1wlET
	QxVJ/4lxu7txMXTtRIurOf2PIv5w+w7BhgCR7YT8Hvc+flwIx2/fRwPe+jX5c/5bmrXgnrWGhhF
	otQ==
X-Gm-Gg: ASbGncsxOMvUwsJ4D3XIwP6UXfEFJwwsnczV63/u9RMCc8WB2xfEod4MAOVYIGmLlZB
	huCxhv5OEie3ByOwK1FZk/7UFLGQtrX9x5GZBP+Nd1xCOahqEYjo31M8eSdzrv4DGsDkdvFaDHM
	KHxpOFjgYeDG3+iHWVAEKQI3S1ZRVohW+/kkYdokmu9Bpyteynrx/T/DRUump4k5j54SqdHQa6u
	17AiFYNA4j3lICPrUgwGjfFfGNOCF9jp13POPna5y8Qf0iPY3RyYnjka6aRL91yFekjF5WQClo1
	omINyI1doxTcmyecACI4RTo1tVlP7SkD93QSod3QKa4OoJ6C1MeygN4tENwMSKSVDauXDxhdWvR
	8QVwBT1objcrOAyWjAkPiJw==
X-Google-Smtp-Source: AGHT+IF2YGuMuEJXlAWgencJXcpvywOSAGbUxQNItha2yT6pQgTAh5PRfqEvcqmkUYsgz8PpDfkaLA==
X-Received: by 2002:a05:622a:594:b0:472:744:e273 with SMTP id d75a77b69052e-474bc0ee60emr176696081cf.42.1741028832932;
        Mon, 03 Mar 2025 11:07:12 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f1b76856sm10218651cf.16.2025.03.03.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:07:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: uvcvideo: Fix Fix deferred probing error
Date: Mon, 03 Mar 2025 19:07:07 +0000
Message-Id: <20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANv9xWcC/3WNOw6DMBAFr4K2jiN/wFJS5R4RRWwvsAUYrcFKh
 Hz3OPQpZ6Q374CETJjg3hzAmClRXCroSwN+ei0jCgqVQUvdSaVvYs9e4MrRYcABWbgOnWuDs8Z
 7qKuVcaD3WXz2lSdKW+TPeZDVz/5vZSWUsK1x2krjZdAPP3GcaZ+vkUfoSylfq9p0bbEAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.1

uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
have not yet been probed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Add follow-up patch for using dev_err_probe
- Avoid error_retcode style
- Link to v1: https://lore.kernel.org/r/20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Fix deferred probing error
      media: uvcvideo: Use dev_err_probe for devm_gpiod_get_optional

 drivers/media/usb/uvc/uvc_driver.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)
---
base-commit: f4b211714bcc70effa60c34d9fa613d182e3ef1e
change-id: 20250129-uvc-eprobedefer-b5ebb4db63cc

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


