Return-Path: <stable+bounces-132361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC4A873BD
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 22:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE583AC579
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057641F428F;
	Sun, 13 Apr 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rkTQcgXG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49A1F3FDC
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744574423; cv=none; b=g30yYS4+XuNudkBnDbBPaTC4lEble8nV6pcNwbXNsJLY3UdsU/rxGJrxIaUh9P85ULQJxNwVGaDsZNqW6wtac82l88leb5TILoMTrFZy2n0iwR3WnN5MDglL/g9Vz19kgb2Kll8L2f2LtPzOClroX0v+ZYvT601gbELy/PwjlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744574423; c=relaxed/simple;
	bh=QJ2echnBKmP1Tc0MPNN5Qs/cA6RJIbwCOvfk2b6xdjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7qH1p7UyjCGTbCsVU/cbZvRgxrZi3J9335xrjy1XJqHTE5lvse69/bFmkjwWfLiXPS48uClx3w9GSOq5lRbn46FOjGA3MFLYbkgDBUgFb5YQwb+KwBR829ysGhwY9EXvtd0v3RMMkbFTmGFr5QPT1l79eFjqWP/2tUZX7gXyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rkTQcgXG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso25164615e9.0
        for <stable@vger.kernel.org>; Sun, 13 Apr 2025 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744574420; x=1745179220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRXcjlCuBBWXh12lLPtZTq+NKWPipRgLKhuCTXh5/1M=;
        b=rkTQcgXG8jjTiFwH+FSfUA0XIp5wl2xUDG7/bMz2DCsRDGEv6PQjD9nNOss4a4xwC1
         tVhi8tPQgu4QdpvtW8piDZkYtpR8GZO3l+EQ0FEx2h2Ygu3ieYtSF97vtw+d4f5ZQ1hw
         ZTSl+Sg/O+7xqz6FbvlLvH+Rpxk01WDg/jkWkg8OsqEz4EjTdxXB68hkk8f5WZWEXhl0
         KUO8nv/R/WloqdHK/6wDXPHzZ+Zo0+4Kl7g1FBPc+m8IEBeumI4Nq9l/Wkb6Do0WmMdX
         0GkjmojXWLCkMZLZ4wgTdlc9J6+xZwvV651WFX3U1qJ6o1XPSNgUmpv0CjwgR02jdwJU
         I7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744574420; x=1745179220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRXcjlCuBBWXh12lLPtZTq+NKWPipRgLKhuCTXh5/1M=;
        b=GjUQW4edfofrCe5BSoMiYLrhd427ZPGfMn+qpHV9u6MIAd/L9kj/0J66ZyADQASJo9
         gKAaNfLzEygMAI7o9Hy9WxiRhew2ZSKzgfo9kWkhluP1bMl2cqAp47tkPIFS3pKBt99q
         r15fOLquramp60NSWKIGwdI+Xwhn7QT3079CQ5d+pP9Tefj1tmcc3YF8bYiPE/I8Kbn1
         y3MlwJ/q4rrjN3g/bQKErMBlgmx6bwyetujHGHnCEk+pJ4/r4uDB3rcqTv+cYswSeixN
         Rt8lkkFYtQbdYSd51F6ZCfFZ21x6Y7oaevC4NRX0aWdsAhTnXFEwx2NBFoT+SexSMtiv
         82YA==
X-Forwarded-Encrypted: i=1; AJvYcCXyd0mzgN+LCivenLIr3Qffcm+WARMZeKpyB1H6umRSQet1zsYwnBVRKlEV167+Hn4K8pzwRlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1u7mY4pt8oEfrgvcXA3EGOsy3PNwNNIZ5mg1UUPqVd6pb+ZH
	CCum81cglQ03KxT4/+GRSWdCv4+NLwgvJpDcekYv3x5jzXfzfr4d9N9c+MDscvY=
X-Gm-Gg: ASbGncsYHnbQyWo8gXwa2eWkfze7BOou2Nq6sSDWi53Uf76CeprUmL90kX1ase5Pof8
	dMCwKyvvz2UWvtbQlWR5TLA0Go/J7WljnVQxr6BWet/zVrnis+wS2E8Bs+og9ItmtTUnvEUSbDn
	Namrac8kSZLen6UvCpsnJW3WRybhBSXcrQoHJ6IM4UxRd/qsXwj0WvcDcIPFkwhzOaDaQZm0W49
	TcCpeqrStgRgy9hu+gZgrGunPtweD7APwBRTkOffk1/BB5xxVhviF1r9KoKoBG5CuZD8Ej/bZyi
	HbTLusSapRK3axnfjqJN4DHlRjD92kWKMD6y
X-Google-Smtp-Source: AGHT+IG6aXB8MfFdxS06qXTQl7E0SZ9Bu9T+Rnn8pWyPvB1ogSH7Ry2LHZj1Y9t+Z1BdYzRzo+8lFw==
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr7164305f8f.2.1744574420199;
        Sun, 13 Apr 2025 13:00:20 -0700 (PDT)
Received: from brgl-pocket.. ([2a01:e0a:81f:5e10:e852:1f2c:a4b2:8e89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce0asm8810540f8f.70.2025.04.13.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 13:00:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpiolib: Allow to use setters with return value for output-only gpios
Date: Sun, 13 Apr 2025 22:00:14 +0200
Message-ID: <174457440298.11196.9277089690698361995.b4-ty@bgdev.pl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250411-mdb-gpiolib-setters-fix-v2-1-9611280d8822@bootlin.com>
References: <20250411-mdb-gpiolib-setters-fix-v2-1-9611280d8822@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 11 Apr 2025 16:52:09 +0200, Mathieu Dubois-Briand wrote:
> The gpiod_direction_output_raw_commit() function checks if any setter
> callback is present before doing anything. As the new GPIO setters with
> return values were introduced, make this check also succeed if one is
> present.
> 
> 

Applied, thanks!

[1/1] gpiolib: Allow to use setters with return value for output-only gpios
      https://git.kernel.org/brgl/linux/c/93eb2c1249eadce4bbc1914092f34f5988be13af

Best regards,
-- 
Bartosz Golaszewski <brgl@bgdev.pl>

