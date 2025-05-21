Return-Path: <stable+bounces-145827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2742ABF421
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2854E707E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C5267B61;
	Wed, 21 May 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0amhZpW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E9267B00;
	Wed, 21 May 2025 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829830; cv=none; b=DuJm8vu0LR8oXnHQEkbQpE0nGSUztxa+CI358putfRhJcE8O+6AYfEWRHoCUtSZrm0d6qZYxmRWtjrpwmh52H0BUUbovbEgkUafoqub2vXFCd9N250vvKj4ffRQx6hmla1BnLVt5KlDcBZpAqFluH0yBLjElfSOI+GAD8Ihw9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829830; c=relaxed/simple;
	bh=c3ubuxlNGg+Ji+wcS0AvojNc40TamrkIX8Wle4MHPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edo1b4mGTuf+oXtIeXVi8X8nTqCD36aHcg8Vn/kRz/LpCMju4Q0hIPf/8Q0bwF+fskExBd0K5aJTxVi2z6sK+C5unWg66s803IbtV0GHKuokPgweW9BPfiLIMQfTnAfXt24kkj3dkJIrAM/8+/q6S3ys5UzWaCQTTWpZj6r9CpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0amhZpW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so43632695e9.0;
        Wed, 21 May 2025 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747829827; x=1748434627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfuPOLZyIK6X8T/dJ1EwKYVAFAe+RVKQ4JBOq0cMKGw=;
        b=O0amhZpWLa+0URzw4aBM1BHzLTUfH4BLi5IMNZeP0j7qCzetWFHGZn3HNKOLP85IXP
         R6XKZU3n4t0rWGd2B+LQCiiV4A53/3d5jW5KuRk1dDae2wd7St1Cd7O5nBuSO6UHxD9+
         /sWAEDHdzJLRJ0gKPaHmqN8bRo5USsKJcuO5pkshZ/Px8AFQn2dzhFk9aobuJIiG1Rkd
         BQqumLU/LEoQfhHOTDp7oacN9crtmruT9N/nte6pIsz3nvg8+ZHmS9JWvLSG2GVmYPsT
         uwDmISXFXqzwP54nqxCZBEw1BVb7p0zTj/1wOM5TrNsjnt5D76qa3/EpM7OM9VNkVPBu
         Md/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747829827; x=1748434627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfuPOLZyIK6X8T/dJ1EwKYVAFAe+RVKQ4JBOq0cMKGw=;
        b=MWGWe68jBgwiRfPz1JTV2wzXly3v1zrAFZz9XMg4frf7WFbb/4dHuB6h0dieiUTlRH
         Y6H+Nzq0l3BWYNBYdnlmfWeYlphaoLn9ePwVoVs4X1stPiPELz+X6uVXWwjRcm+9nVRt
         +Vtxxb4vGSXp9Zxdzj3Z+E7Y0cXjqn2cah/yNDITZpiNo90+7M8J+Im8XOwLIQNwxuHQ
         d4I1fXpMzHt/ztahahgR9BzkCX5BtKQaTKT8eJ83Cdjdfx+RtHYv9sN68Kljg6QSc+QV
         l/pIpXllvZySIgNbmIPmgIctfEOozHDYDkNSCKIMyEI/C/PbN9mpjy/lbocXGq5zYnXx
         pexA==
X-Forwarded-Encrypted: i=1; AJvYcCWF3DWw8q9FUU24Qf8cLoJxd8FP+BkDjbj7hNtY4Dy792/s6Te2jQQa1ZVIBIxP0SUKYLiiYsiwpSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYtdbkkTDJqhc8HF0VU9CRgOGwYDUn9VJHPZ+7eibvgfhGf5E
	pS/m86KbGnNwa5QSl7j73ydGBK4FwbCPYccBV/ON65g4mEcny/Am4E8g
X-Gm-Gg: ASbGncvt3UNXUdOeyiMvwCE1ArL3RB4skVmamWovIt0rtuw805Yic4WJRSFuJnc4eEL
	Jwe7J7jCMwntYRpXuRM6k1lYi4LRjU4kyVuW+GDnvuj4ir28McyaV5KCSQDWAHKLu+bJma9csLZ
	W82YnavsHvszavr8QyxcEPnPWvoaMbAzLE3ynDHHtRUUCFCMU8x2D7jOdLb3DjEBmQLSiluh+gf
	rLRP0K2bS7+MKHBVJlMlAoRn2ASHEHrRGCEm1xFWehYvveyg2bLD4Q/XmbBO61jd7zaM18q3R83
	C4J2q9y8GWDXXxWpHX6HcVmaGSlYnxd+uuvOA052GfZeZixohFLO4WRoTlZWx3ooL4IUe1X6ueh
	CiNTtKjt/Ve0=
X-Google-Smtp-Source: AGHT+IHck+ta3qJXiJyGnlJDCq0Sp6cw4FhepgHjhhxa3i5Fs7DAXuuFKfLLyOzbZhxUpruei3Uxxg==
X-Received: by 2002:a05:600c:1f82:b0:441:bbe5:f562 with SMTP id 5b1f17b1804b1-442f8534e53mr242693275e9.16.1747829826683;
        Wed, 21 May 2025 05:17:06 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0552esm66327845e9.11.2025.05.21.05.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:17:06 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	guido.kiener@rohde-schwarz.com,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/2] usb: usbtmc Fix read/get_stb and timeout in get_stb
Date: Wed, 21 May 2025 14:16:54 +0200
Message-ID: <20250521121656.18174-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521121656.18174-1-dpenkler@gmail.com>
References: <20250521121656.18174-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1: Fixes a regression introduced by a previous commit where the
         changed return value of usbtmc_get_stb caused
	 usbtmc488_ioctl_read_stb and the USBTMC_IOCTL_GET_STB ioctl to fail.

Patch 2: Fixes the units of the timeout value passed to
         wait_event_interruptible_timeout in usbtmc_get_stb.

Dave Penkler (2):
  usb: usbtmc: Fix read_stb function and get_stb ioctl
  usb: usbtmc: Fix timeout value in get_stb

 drivers/usb/class/usbtmc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.49.0


