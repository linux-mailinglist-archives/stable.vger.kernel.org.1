Return-Path: <stable+bounces-160155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E54AF8BE0
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624F15643E9
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 08:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2328C5C6;
	Fri,  4 Jul 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gcsUC30v"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA326A0E2
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617547; cv=none; b=WviPH6mC68oJQSjXqkNB+qG1I2j5xRQ40+C+QFEJ1iyYFvjJ4rCXmIRn5cAgvGM0uMFlTNq2pPjy+fPWC46s2SbSB6klmiDygaVCQ4sAjGW3a6mJRkDly/nG8VuTCAFoeKyDuFB5di2TAiHsvGcyVkaclMqlIy7/9vbX+O3NWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617547; c=relaxed/simple;
	bh=NOtmTRweHr/OUU+oCOxztbTezR/mlwj8/rnE7T2PLzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuK4D4wm+1UHqW4mIc7fUNw9za5CroMDTzr55DIYbclc6oK93RwLY7UdKrBAoG+U7eDOmPXh5Q6PBs9AzR2tJsBe8GqAp8wKT/U3cHVsHrD6PBWLEFCUzZ/rhY3AanNtTT/6PA9V/U834QwV/Cd3JGF7of/Sde0kRBDgcIUjytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gcsUC30v; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso334856f8f.2
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751617544; x=1752222344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8us8p5iwoDYH0rHeULcbB5Hku+K4FAtuFOBzDYvYfA=;
        b=gcsUC30vxAvNwqTf5SGFshWQpQuKe9w3FkorevsuY3luPF3gQrrNnpHVwodhSFc5aP
         5Y+uevAub5UP8Q11A2bXDsp3y51Cfij/qsvilcuyo9c5px8BqiAbed3xoOgQZEqF88Xy
         RcIssBq/YAEMOMsJwuo56lwuyqOY3dnblfd3amO2gF/U8vJtteT3Gj3Msm7BtL0WWBjn
         szhlp7yDJqYoNrDIOcowrXDAMfpFhsdRiRmKFsjiYzZ1KaeCUgmUzhMJ+M0Dv8+Ihqz2
         5zWeCuzPJysPHT8rCskQwtXmdXZZGgz+xuKV6IvZm6XHE/c9DMtK2dbw1TRsU2Z39IVK
         9YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751617544; x=1752222344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8us8p5iwoDYH0rHeULcbB5Hku+K4FAtuFOBzDYvYfA=;
        b=k82hrvFswR5oyb9MWjgggHIHwsChcWG/nhkI+g5BXJd5wmebF3x57d+xBvoeOHVLyE
         TgcDzdL32ReZsoa0gflwsEXqfpVzxfocoQFmVxoRdO9++q+kO7skEfFbEugxyLt/dbQn
         kfjNLTPOnto6+4UVa0o3PWvPLx0IfJx7dJ0/sJ43b39zNjx8QtHn+Axh75SH0CF8uCtz
         EELJqNabdxdlckMXM/cxwLY5IRvs85h41N+6J++NYbuuWT3R0pQllaIl3CbF1GJnPcPF
         9HcPBekGmI5oyV7LF/eHpYhh17EjDCQjN4V9huzkLD9gbvl491swbZ75dzoxhmQAR/4A
         13ag==
X-Forwarded-Encrypted: i=1; AJvYcCWNRN/FEh53LU8PYj/IT1W9a1ioj1WXXrK4W1tIuZ2qOmtuqbqd7OKzwQ1GFGpEq4jfFhajXRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1k+dpJB1OrjmAw5e30tdyk0eTX6SH45YDIoRBvW9saZshPBmO
	SyeKJ5oRDMatpq522Pf8HJ2n9G+1tvUgguQEBtHQ4gNn973pomj7OrWO+4Q8kh4X9VI=
X-Gm-Gg: ASbGncsdSBXjpUHDUMTTAgZ9pZSj5JGlsiZiYhmurWc4dWqoZjgnBtzpVYHNabsyt+E
	MRscJnDgf2Iks15+XwDJ1W39IPAxybrAFkLU+Nb1MxfU/a2sxoRb83I1HdQnCCf7+BB4wx89u/O
	g3PWCciULgk5l/++c/4MXPvMJQDad83pTFCDeZWpVJgG/r+OMiXjvAC4S9m6PtLD13yGrHFf5cU
	URBrSM7ndkLgkT1AoraQA/sZXQLM2AKUypr4wFWKCPmTumsMJ8s8Di9+fquKY0GfjO46SdvEMlR
	p/78sOSnb1jjjrgVNuSHRWmeFmBZ9OSw7nLXtgKOx8wTwSEc3xkEzh2bmKyLEA==
X-Google-Smtp-Source: AGHT+IHB9CgbH7y2/B6BgqylZ4+/SczX8o22ciAlNeGXLSBGAnyxtC4oX9EXigeL9M8BG6a4AbcVWQ==
X-Received: by 2002:a05:6000:4208:b0:3a5:2ec5:35ba with SMTP id ffacd0b85a97d-3b4964f1c9cmr1110317f8f.30.1751617543920;
        Fri, 04 Jul 2025 01:25:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:876:27c7:55ac:40ab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0af7sm1922605f8f.35.2025.07.04.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 01:25:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hugo Villeneuve <hugo@hugovil.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: fix efficiency regression when using gpio_chip_get_multiple()
Date: Fri,  4 Jul 2025 10:25:41 +0200
Message-ID: <175161750676.14835.4100205816792446809.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703191829.2952986-1-hugo@hugovil.com>
References: <20250703191829.2952986-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 03 Jul 2025 15:18:29 -0400, Hugo Villeneuve wrote:
> commit 74abd086d2ee ("gpiolib: sanitize the return value of
> gpio_chip::get_multiple()") altered the value returned by
> gc->get_multiple() in case it is positive (> 0), but failed to
> return for other cases (<= 0).
> 
> This may result in the "if (gc->get)" block being executed and thus
> negates the performance gain that is normally obtained by using
> gc->get_multiple().
> 
> [...]

Applied, thanks!

[1/1] gpiolib: fix efficiency regression when using gpio_chip_get_multiple()
      https://git.kernel.org/brgl/linux/c/30e0fd3c0273dc106320081793793a424f1f1950

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

