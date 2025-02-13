Return-Path: <stable+bounces-116319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8CA34C7B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04884188CADA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B823A9BB;
	Thu, 13 Feb 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Gow7KwF1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2F23A9AE
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469242; cv=none; b=YbEas1AkYg8g7FPL74c8RSPKSxl5IqmzvxDaRhhokyqow143L6JC6KthnXjM59uHVuYI1TjmXp7zahH3aj3n5bp9ldGlhYp4hWxBJBrgWfpl7O5w8fp7XkrXDkYsLqhLf6DGouWGy5+sPvbEagy+hxIM6Y24dHUBMdQP4IK0VOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469242; c=relaxed/simple;
	bh=+269OY7EaDipCh3onm8DEanHmFliIp3h0+vp7uAa798=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etizmcgzu/Kmg7E1ejKckYB3zYcwmK6DrLF2GXwIYUWzXVMD0ELCBAHwMfNz2QlU8LrS1YUMz2ujXmBfiBDOid0AGXOSPeBD6xVtBovOCVJOyj0nPqUfvffrRKgtedDXEoFaPeo4RXZF2lWmhrQeyVk5T5VgCrzlWnDC7QP/Sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Gow7KwF1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43963935585so8948555e9.0
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739469239; x=1740074039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AASLEmG4hHg23vluDlbgkllPBBiNPcd+6WwxQkkx/88=;
        b=Gow7KwF14bVZsUVIKSxUfucaZlTh3/avUJbZxPcZ84lO2c/rvAfKMIwgn2SI3NCDY+
         9fWo7FivfdU2cn4NhMWh3nHQSigqTk8abG7BSqFjW0CnXmxq0Kmn610sifpm5Z5xt9GW
         YpZBc1yUrAFPXYZtCCcAK21xueVj8/kadhj9nhqhBpAb471WCp8CnZkjBuGoL71EvVpG
         oQdnfQJFIekNYqTuj/Oy84APLTHWhWxUyQ6WvJW3VJCzE/AHP9C5g+8ltknTjDfadQL/
         5w7s9aGPNIgfPIKwF+i+VnwO52NZwk8iEkvSuTYUqfP1bWTJjqPXlA3e+JxKlqqsTyHn
         SGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469239; x=1740074039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AASLEmG4hHg23vluDlbgkllPBBiNPcd+6WwxQkkx/88=;
        b=RjHxGAP5mltG2H702+89GLnW+MSC4pJSCatR/Epi34jp6LN2QTnJi42Xit7bPL+zkK
         oChsjUlqxiVMD1FN/bb66Y+5VOo8JpuvYmWZ8Jv44AvcZH1NHn9SEqWLTdQr4z054hNK
         gzQbznz0elNzU/PJyIeC4oum4Vqh39jggx3y2s83mGbBsZognaxkf9KtPTztYtN9mgV6
         MLDCT/9vktj3rVtXphEAVM9KTi6rirEA/d525kZ9mlDQXsb2/qwltbt9uhvvIzgGopcd
         O7j4qUkK9l1b664wCIWnYB0818d+2w4Eprb6IfbJtqNCFw/xRwoL9xleaSwt3nCMqe8H
         PjNw==
X-Forwarded-Encrypted: i=1; AJvYcCWZAn/lOtD/MCPakxf3Rznn2lwLuvUmcEU3WbrnyfXUhPmIQMOHlQqMeU8LQS7caQWc//fYypU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcn3y6V+7fcrBNBHrJC/WJ8EQQ6oqg3BnpmvA7riSnPIGTS/ps
	7Q3I3vzODeTTzpX3RRUdt2xbZv0rXu/KTeuSqpciHD6q+sG+gpb/nGLSNfb40Zk=
X-Gm-Gg: ASbGnct7mXdKtJQ1OKINX6Jv+mt8TEpMDZLUHfZ0m4ftru0JH9pI535wGnTKlPiWw6x
	Ih8WyLzVxcQ2p8nJOCpxH3GVJfVPcpPvnw5PzsabP2xr0AFA+pVtsaWfftG8fpwkJP96pqW3W2i
	CgaAyJWstn//zfuzfv9RcU4jaLzz9w3YqxGOatl14Ltws+gAezvRhveUNtkb8BjO2r56yPSH9e2
	74DcP3PyowLy8Wq+pApHKRCY3LTrYnklLDuXsLozrWsf31fe+ZYzGUJx31NPwbrBdbpAlpuDfpA
	1Ow1TsSoIMjHPBA=
X-Google-Smtp-Source: AGHT+IG42/S+tsvaljYDR6/SRyicTAxV4SHDiyz2AP6YClUGY82Q4xoEFmMDivThTYJ91m0TxC66AA==
X-Received: by 2002:a05:600c:1d9b:b0:439:60ef:ce88 with SMTP id 5b1f17b1804b1-43960efd0aemr43983675e9.23.1739469239541;
        Thu, 13 Feb 2025 09:53:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:affc:1fb5:fa08:10e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm55390325e9.3.2025.02.13.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:53:59 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: protect gpio_chip with SRCU in array_info paths in multi get/set
Date: Thu, 13 Feb 2025 18:53:57 +0100
Message-ID: <173946923528.103541.37570270811887464.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250207140640.57664-1-brgl@bgdev.pl>
References: <20250207140640.57664-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 07 Feb 2025 15:06:40 +0100, Bartosz Golaszewski wrote:
> During the locking rework in GPIOLIB, we omitted one important use-case,
> namely: setting and getting values for GPIO descriptor arrays with
> array_info present.
> 
> This patch does two things: first it makes struct gpio_array store the
> address of the underlying GPIO device and not chip. Next: it protects
> the chip with SRCU from removal in gpiod_get_array_value_complex() and
> gpiod_set_array_value_complex().
> 
> [...]

Applied, thanks!

[1/1] gpiolib: protect gpio_chip with SRCU in array_info paths in multi get/set
      commit: e47a75fb5b139233bdbb889995edda4dffc3f0f7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

