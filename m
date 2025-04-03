Return-Path: <stable+bounces-127508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575EA7A285
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85ACE1895412
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0424DFF9;
	Thu,  3 Apr 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hlx9jNGy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB24DFE5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682188; cv=none; b=TSLkLnydfk6nY2c+sLwehh8c1X/LsC0CRM3vROIKaajlHdJCrGuaFTw6304VhLiAQnwWJbNE39zXv/nSmJcjsKUsHI0+Qeo3WsAJ6m9fT5ou6Aar3PLzn3g8TDumNTi8c/qL8n2b7UfjRts25VnUfNunraVxx1K7C1/hcSWkprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682188; c=relaxed/simple;
	bh=u+QydgONUJr0Pgq4GMp0nMeH0yflfwhSQuo2N5MBQqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9sHZDP7WJmu4+tbjtgjoOJ/dI+HLSwmj6t9pL5UBAO+jMMCN1Zl4i/nyx9akKMgwRw4wl5YSDFKnSVuzYCpdKYq0EjlFgNqnnxD8I4ZDPVfeOkXpk2Tfcc7+ZmPPpp8L5uJZfWOJulj3KtuRCIuV3XeFutlXaKW6wqgGrL01x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hlx9jNGy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39bf44be22fso590621f8f.0
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743682185; x=1744286985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hptSX/e+wVcPnTsnjXvYnqoZa1uA7tV0UWABvKf2BA=;
        b=hlx9jNGynCImd2KKgJHBNCuPCyW3lRGVtaENcGAaCTqmUZ3ADvO2ro2HV3xC5AeJQ7
         vtZNsEsqghC0yu4e815V9gEwNr1YfDnLXOe6MTQOIstxENYBmsfeCFE2xpk24po/TtAb
         MggZ9+V0LogV4ZW5AfW0s7GV3CpQ+uutK6r8/p62/CejMyM2cLuZc9UttQtlWtrwMxxE
         8wtaaf8vZ6hLB5cPQe50xWcTAe9VPir/cU4H9ytPeTgr/wf36wsfw3eVw+UeMBD3fosd
         +yVmQMi3KVKOX5/qzd2x04FttcVtOhRKp3lV5BfEfTGAkpxKBaGUOED33J3v7JOLLJe5
         FCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682185; x=1744286985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hptSX/e+wVcPnTsnjXvYnqoZa1uA7tV0UWABvKf2BA=;
        b=sDD88G+7rrhBTWzjR3r7AEwC0/LYaBvvK9PXuMB8AiNAGYw0sj1YmPpVlvDRosmp+C
         RtOWW4QSrHD9GbhiK3VRBV05wfCpDjSW7Fio+QkWCuw05c8y54XiP/w0vcbSL3iT36Hv
         xNTwhR//GrkF5q/BeGIxVQ8j/HD3XPTVcOa4JBsKu2z27f6/4yhcgL343LBsaibLMxNT
         uaVgMWcXP3WWHggaScifG92joen9aZ/VR5rZODVQZcJt4cD9QbJeIrcG837ZBubcnNVm
         uLrc9Omxo7Sab4Z9fKwMnzeJ2OxpwWyGgbq6yPV5hg7SyzJRgpzcj2nreGkrPRlifbZD
         q2YA==
X-Forwarded-Encrypted: i=1; AJvYcCXY06+188szuUPdHFuKF2rMMhztFIKWHaHwi0HgN0g9aR1/YM/xt1Q0MKSWuQqaVfn3f/aDWPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTBuflbF5RPXMvOjNHhXAUfsFa72M1H6PT1QgITbLq+AtehfI
	fL2dtwNB2wYJNXYy5rwcec7RNqDhroJe4uciQ5JKvKPyel4/Iy95rAnUgPH/YDk=
X-Gm-Gg: ASbGnct7pQfufPEVZI/DThkxP3GxpoSvOyiGgrokkBjeOfOQJeJvRKwknKxgkDEfWKy
	4P04LN+XZgf0hfnau32MsORUODaiDK+0yWA12dP8zxMlj4WZfDHXydH32pWRqpnuRhV4yDYraZq
	fmhr2X5TD/hKuYfcmsjFf2/nDGQtE5Rbv0TuOgNG8tdgyeOvzgYpVx2Kw6ktalg8f+meRKLU7DD
	L3PbbBNKR5KG1xNS7WA3P0GVro1P1y0tCygpPM/WX9bdBhTiqzCY+ZYrAjFn6Q8y/lOAnhZ81mQ
	ZBK6HOL0x72FIPaIyDbacZFzma+OHs5QkfHQN0lL+y0=
X-Google-Smtp-Source: AGHT+IHLLUD7pDwTg6uhsblFpe0xvqHhHyMGzPKJ/KkeiJ9ysFXJkpnNXvqJTXR+YplK0GjxarW+sw==
X-Received: by 2002:a05:6000:2a81:b0:39c:30d8:a80 with SMTP id ffacd0b85a97d-39c30d80e4emr1264559f8f.19.1743682184983;
        Thu, 03 Apr 2025 05:09:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:298f:3031:1c99:fc5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1663046sm20599155e9.13.2025.04.03.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:09:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Guixin Liu <kanie@linux.alibaba.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] gpio: tegra186: fix resource handling in ACPI probe path
Date: Thu,  3 Apr 2025 14:09:41 +0200
Message-ID: <174368218005.27851.1117630791127381361.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327032349.78809-1-kanie@linux.alibaba.com>
References: <20250327032349.78809-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 27 Mar 2025 11:23:49 +0800, Guixin Liu wrote:
> When the Tegra186 GPIO controller is probed through ACPI matching,
> the driver emits two error messages during probing:
>   "tegra186-gpio NVDA0508:00: invalid resource (null)"
>   "tegra186-gpio NVDA0508:00: invalid resource (null)"
> 
> Fix this by getting resource first and then do the ioremap.
> 
> [...]

Applied, thanks!

[1/1] gpio: tegra186: fix resource handling in ACPI probe path
      commit: 380c913737edb4ec03974f653feee6cbfbb7e013

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

