Return-Path: <stable+bounces-127506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22557A7A279
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962371888273
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDD924C097;
	Thu,  3 Apr 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BAT8qsuT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080224A04A
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682031; cv=none; b=YKymEJ8L4ZJvgtgB8Gt4VZ1W0W3QiEzRYKfDXR+cjB9XAnb3RqVoPHV+rmpycmftxOazaqNuOxdJ3wWN/Ss+6/98eJDUIjR/moKObszrM64U6Dq7dnn+87NUJbqC+JSi1dtUx/KEsYSR3CUntKDy4SVhswrKKtOZurA4z3bjZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682031; c=relaxed/simple;
	bh=AUGwc8vNaMx0xMpLyypn8iC7Ralu2FuIKpZSHAykq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8KPQy70qUANipOD4YYMSnHARSr5mDN8M6cRJJwShY4csu36FrNfGD7rSNAp31LG/TYNs99rrMIO+hhUAskBLyWBncTlX6ex7yPk9T26zO2kVxLWVC++1wVpvKARQURVC1AERw+uSWpgE+H6p4prAxFEwSl+opmy5waa0rqqfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BAT8qsuT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso7887645e9.1
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 05:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743682028; x=1744286828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyWeHio5rUlPWWMN0PJ6IWQ1QQ/CGysbg+GQWLUUSf4=;
        b=BAT8qsuTcCr9c79Rfo9Fk+aWNwbLz2KM66IcYPjc31QX8D72yZDnCbmdP8nICpDWKj
         ywc3HDtjSvM1LzPVHoZ29Fl7Bw6Ht9FthPLhycZEmRrxmaWOCwRxO6vN/+FKhSl/z+G2
         vTEuTFbH6Mxl/rQkW0ila50cJ8paLNh+f3rx0QghQEOAb6lzuwWul1013DTUO69Hyg6S
         a5oBtX6dsR9YrQ9ToHNz3RAl7vAURiaJeABM8s+GUfAygfP4OKztpGTbLOJRpmMS8yZ0
         5PNT/VLGHlWCy69ruog7tHDdGqoUM8qOs8eeviZgjMjyMqhTEnu/uB5sXJIWHIfgTOeZ
         7eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682028; x=1744286828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyWeHio5rUlPWWMN0PJ6IWQ1QQ/CGysbg+GQWLUUSf4=;
        b=Dsop6Q79TZMUUC0oTKpGLA7ITzyqSrFn/yO120W9Wn6F7Ar0o0sEl4TNgn4WZKXv9A
         oljSukz56dzN4qYeSsDXcXAsn6+2LBsMx3IhYLz9QMRGu9oOyPGs9/Lq0SgqiltlvGpY
         Ts2g4aN6+aVL6fbEUM7YsrgPXvm1xB21y/a9r52OqagnCnXRnY80B29d/wRsbhzN4PCA
         ZmZH7oalIsqaYjztzfWsxLceYXHx3SXGI+034wwj3sdkCDUzOwEyf6kffP9/5HzAw2wY
         yO0VZfj3t3Yy1atvTSCJlTNLAptPmYQLPKpo/Pb9HozjMdVlx2pj1geZqkc6R5NiwWbJ
         KJAA==
X-Forwarded-Encrypted: i=1; AJvYcCWzM8KpKq/an1bU0/8YJ08IcEMRKGFDempPuU1+QG9vPRYScnygSzjuzERNfem8vWBcnm93A30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0yC+ZFUOceTkGnnKo0wti4Fd1sPl8M+xES5gPKKuj2UdR7y8
	NQVMhMM5HsMjZXJh1mQcbLnXRZoxsKBuj+qsHuldEw7NVH+eBPV1akZKwn1ihgg=
X-Gm-Gg: ASbGncsvkvtqh5cyctK+UpKbT443YvbnAnYxEJxIeSddqnwGQMUrXZu4kxXgQiAU2cA
	QWCgOWj3pWap0ttpIyxFTcG2JLwh16GytzNa0jqJvJZJ1e0NK8v/T9cKLYa5pd4mNndUt8d2HXQ
	2pa2tGc9A3uKfgynaUo5QIPxr7e1mh2uFmj0wND+5fpj3iea0ABAR3uyJgJkBc0tKITz8u4Dx6J
	puvv5JqY3wKnzGcJ6oExEN64S5JVTQ3hySts5R0yu/JC8fk0EQOd+hndRK+qcwJ6ZxM3cYvqtZS
	c14rOqOulBynxwOYpmFdO61l7qSfCmUXwYPFn7eFa5vM2g/oz4Tawg==
X-Google-Smtp-Source: AGHT+IEq8jwy0FRZPvdikp5/fC/RjWsCA3+i9c2Jlli3ODQyHjXIXByQoGwyhWK1t7ABx0W5Gw6Rjg==
X-Received: by 2002:a05:600c:3b9d:b0:43c:fe15:41c9 with SMTP id 5b1f17b1804b1-43db6227a09mr184515495e9.9.1743682028242;
        Thu, 03 Apr 2025 05:07:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:298f:3031:1c99:fc5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d980sm1645357f8f.61.2025.04.03.05.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:07:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek Vasut <marek.vasut@gmail.com>,
	stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] gpio: pca953x: fix IRQ storm on system wake up
Date: Thu,  3 Apr 2025 14:07:05 +0200
Message-ID: <174368202234.27533.1000100252310062471.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326173838.4617-1-francesco@dolcini.it>
References: <20250326173838.4617-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 26 Mar 2025 18:38:38 +0100, Francesco Dolcini wrote:
> If an input changes state during wake-up and is used as an interrupt
> source, the IRQ handler reads the volatile input register to clear the
> interrupt mask and deassert the IRQ line. However, the IRQ handler is
> triggered before access to the register is granted, causing the read
> operation to fail.
> 
> As a result, the IRQ handler enters a loop, repeatedly printing the
> "failed reading register" message, until `pca953x_resume` is eventually
> called, which restores the driver context and enables access to
> registers.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: fix IRQ storm on system wake up
      commit: 23334dfbeec89bf79f2ab893034b50612d039594

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

