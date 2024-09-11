Return-Path: <stable+bounces-75846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F397564F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D50B20F56
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF11A7AC6;
	Wed, 11 Sep 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CUDBZQdb"
X-Original-To: Stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506C1A2C21
	for <Stable@vger.kernel.org>; Wed, 11 Sep 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066576; cv=none; b=pHoG0TGl6T24/6/dVRGT7r3AEjrYSfyyy8XwpfYVmi0ArVgl2/Y75YXNaRuK/QlN3bIJtFABBMj2z0U6ch0qkF6tPuiSAJM3zC4R9ESTNvUvK7KcmjFS0dZY6YZIe9piIkdBCG0rCQBfvvcjMSjTWryOYNAiKrRgT3bTwBF0uQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066576; c=relaxed/simple;
	bh=5y6hlVFNZ9ghFAZ/dOgsxCt/q59tWWK+iBtItb690SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkKodpp1l7jIUEEb2toj3Z4+Ri8TL9La0sl4FreC+a17hNcCTXXeQb4Upd2zAstTO8PC7M4PjbITqnEjlGWMqS2IHKdDQelOpxklG9p8kgUL0Xlqyl379dwkRC+QRAnPxJT5Aibaf4cqz25/H7xnqEy71eHgyshChLgviIouE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CUDBZQdb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so3621405e9.0
        for <Stable@vger.kernel.org>; Wed, 11 Sep 2024 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726066571; x=1726671371; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5y6hlVFNZ9ghFAZ/dOgsxCt/q59tWWK+iBtItb690SU=;
        b=CUDBZQdbJSXU5H0c05OvytdyQG2ctYFHXVJyWto0hYCduHRsYVfC1cbZ6pRidEOzaU
         4AARucgZIX6HyXXc12JKac97DUvf01IGFbySFISs2sLOkeakv614aql3PoKoOzkX7rxI
         hiVYGG81JAg6iGq/IEd2tlsHK/9BoPH+8r0v2zT0gyAoQLrJiAdP55J1NX0Fl8D6uqrk
         5hCwvseiZZ2BNDWfg7Z+TPdCSLjarUKdI/gKk/elB+NZGSl645ALbiQ6kMPVaJk0JEyA
         roaeqlQ4Uqg/rUg39A3ZJsXCz1kRMgLV37n2FwypSfRRmddNnmEM7H/aUxBmZ56uW4i7
         fFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066571; x=1726671371;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y6hlVFNZ9ghFAZ/dOgsxCt/q59tWWK+iBtItb690SU=;
        b=sUjh/y8vbcFE5xa/0LxM+Y5cPoukae7wGPLp4LfMFHfO+MGgyGYkz7puenaATu2KTK
         f0+phJ6mh7rN0FdjFSOInrwn1Anp8Pjoi7YaSizEVPG4+fn1R7U21qZD5ghWdJ8NlYtT
         5SXnJTFk7/tM55CS8x1CYWDAE1FOswmRshmOxuBp1UxVHKcYNK6lZcAadyAZ09LqNfMg
         w1EgSlrqPl+Ri9I2bkqBqF8Jy7+Yaodkj0c0ywQTri2kaFRzCFZkKp53fQ4fKGHrYS+M
         hGm0+Q7zx6ErgKC5B7wWMQd/Buh0UT6S2G3YNuUxlY8dOl5GgP8EB8XDAi/IiYd5m/9v
         0/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgDHUJrF9z/EZjqwD5DFtDmrwMvbjKabJZWJJz50taXj6h0fG77cgp2HVNgC+XurHS93zM4fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/2MLEMyOy2gqBNnUuvKpSv3Zymib1GX7C3AYLvAWEzAF4LiV
	cYaEoc25AhB2O+A/1dsBhJqp3JDw1QvCe1KwR5nKuzhC5XKvcXn+T2q6ye19zos=
X-Google-Smtp-Source: AGHT+IGXbGreRimd0uqLh23FCjFV/446HYpWf16uni3SRkxonRMyp0eon2FdyilvNaU/tKo5u9ETgQ==
X-Received: by 2002:a05:600c:3b9a:b0:42c:aef3:4388 with SMTP id 5b1f17b1804b1-42caef34492mr123874855e9.6.1726066570926;
        Wed, 11 Sep 2024 07:56:10 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:7388:2adc:a5d5:ff63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb77afd5asm105511255e9.17.2024.09.11.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:56:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,
  Jaroslav Kysela <perex@perex.cz>,  "Takashi Iwai" <tiwai@suse.com>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  "Kevin Hilman"
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  <alsa-devel@alsa-project.org>,
  <linux-sound@vger.kernel.org>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-amlogic@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <kernel@sberdevices.ru>,  <oxffffaa@gmail.com>,  <Stable@vger.kernel.org>
Subject: Re: [PATCH v1] ASoC: meson: axg-card: fix 'use-after-free'
In-Reply-To: <20240911142425.598631-1-avkrasnov@salutedevices.com> (Arseniy
	Krasnov's message of "Wed, 11 Sep 2024 17:24:25 +0300")
References: <20240911142425.598631-1-avkrasnov@salutedevices.com>
Date: Wed, 11 Sep 2024 16:56:09 +0200
Message-ID: <1jo74uqlx2.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 11 Sep 2024 at 17:24, Arseniy Krasnov <avkrasnov@salutedevices.com> wrote:

> Buffer 'card->dai_link' is reallocated in 'meson_card_reallocate_links()',
> so move 'pad' pointer initialization after this function when memory is
> already reallocated.
>

The title could have been a little more specific.
Anyway

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>


