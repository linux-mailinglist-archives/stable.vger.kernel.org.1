Return-Path: <stable+bounces-116315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E45A34B6E
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004BE3B33E3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4981FC7DD;
	Thu, 13 Feb 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWc992NO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E7207A11
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466426; cv=none; b=sQmO0uLzRZwUkEGOYR1gOg1Cr+2iO1cJXr18ZOaqiPa/t5h5W5Q+V4EJ6hfzwa0xJmUIXRzjzSmc/p0hqGUl6sQqOj68DlxcLb0mRMKQpUvk0t5DAJYKkDhMKr8XZ+s3JZ3QM4kBseodC+FEUAxL6DqsT8SajFDmUvwwCkPHNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466426; c=relaxed/simple;
	bh=O6x850tKrIqFZVJ54DB0+azfYOe8EjzHVEw4BZInX80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h4F7p8O8O40gxlp9Q/n1EfBd4SemebHuniypUyGEs6edElgItEWrNvnMl1S+RGu2FV7ygyYhi8O/l2GnT8dB/eDbmEcmzXLUBQV8GU2V5F0BUlSED7eSeQpOyqEkYIZefmJz260X4S1J/odUWZKFKoAxUrt90cjVgonlEq/ZP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWc992NO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43957634473so12378685e9.0
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739466422; x=1740071222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtQn4wgBm9cE7XQgLWrBO7BTmTZKoY45YwSnDy4FO4w=;
        b=oWc992NOQf/YBU8BTJcn+VDz8m709AAiAsSfnTC8G3dK3b2bJRdN1Wb6xoArrkQMXb
         qnqqEqDWTVbbpfgRsuLctd2AmVbA2uN7sOzAygDkA5JvqX1+x4xtzWQVpwj5jJTZHhf/
         OPuQ8YTC5FOaBlIkp4IqafBcxkFfGz/7EZg1Y3R36vGbU+Kx4bXvfC4GmhDgrzaERMjG
         CVBP9rdu4zHzNwWbkr6NU1cMG2YwYl+royXJFWkuOnNs+461oqxFwNelp6Ef76rnRoVc
         vXBzzksXQtQIlDYj1H1l6SVDEoCZ2fjfMB7fZphdUGMbeDPiF7yZmVljRsxVEg6Z7dcJ
         gmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466422; x=1740071222;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtQn4wgBm9cE7XQgLWrBO7BTmTZKoY45YwSnDy4FO4w=;
        b=JiR1YDdTjb0g0LPwbRMeUQTMGLdG+3TNqvWByxSmqF2ZOc8MzmmgYu4zcz90HSjOGW
         p/5FnuEbYfAIwXGQfsURme1q9xmbbBuUP71ATR8CcrXi3i02rr1lgCUv4v/Z9lDztbNR
         U4UEhlpeOPNhHgJF9prXvYxfLHD5aINYUFgkp0TZ8lOhs2cA9/msWnSdZIQ+vMO/Dc7Z
         7fByENYaxHsvNL3oyFdGkhe1LyWNURXjqKylrKNT7t5gkN2NHub3eveFTLovXTBFEydl
         MazIqwIGePSmWQbrHSdTvMWU6XrxSSbm3Go65ooD29U8bZDFTfHLf/9FpQyeZpy6BbXw
         c9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUrPu9+epCLWf/FaVgetSEx30l4wGMWXly4LqpVec4jN/EhXcQJNfyV9UnWqTMqTUKZ6e8R6Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuzT0iIyy3IxsWd5YmJerdxYYFvO0foosj6KU+xS0WwoKGWeU
	nRVyQOZ++3kHTpOxw3DHYv6RMujdh7nmqfjOZG6VDUi7bnD3P35zc7OWBXRXAO/hDQuLgemmcYG
	f
X-Gm-Gg: ASbGnctYcZ+2xsKZEzyfuYmwCrKNKqgD2q7wZV+8T3t+XOFve7JWOSLjuNsbtxH+Lxp
	u+h+rQQYHe/+1yQDdeh+oCVhXlmbEZCJK6nF9z+gfFYqCAAUdPdH/f1aWgVin9caDYzKSrwAbC3
	rLaUyoalawZYr0TkV6rYwtc2K6KVVLnymGKLlxQzrFNc/AcU7HcMLcm2srv9sqPyetJ+IMzlnY7
	EWz5nf1vr/cEzTsOym3z2sROeLzQX14DP+sN9vF4hqJpUKHHN5xoAcPAtrcUT4ilp6pFCPNjXqK
	3o0WV4lp8NvTT8OdMAg67zTYRifso0WreaxG
X-Google-Smtp-Source: AGHT+IF8nhcp5YQz9TPZ6YIGpltlu/q9k8/XW67n8eICArykliM83NQmUsrzxgy/G3HVl38kAJ69vw==
X-Received: by 2002:a05:600c:1c91:b0:438:c18c:5ad8 with SMTP id 5b1f17b1804b1-439581cab45mr88901955e9.31.1739466422435;
        Thu, 13 Feb 2025 09:07:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm53525245e9.2.2025.02.13.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:07:02 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@edgeble.ai>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240927135306.857617-1-hugo@hugovil.com>
References: <20240927135306.857617-1-hugo@hugovil.com>
Subject: Re: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity
Message-Id: <173946642174.322382.4123111314998976761.b4-ty@linaro.org>
Date: Thu, 13 Feb 2025 18:07:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Fri, 27 Sep 2024 09:53:05 -0400, Hugo Villeneuve wrote:
> In jadard_prepare() a reset pulse is generated with the following
> statements (delays ommited for clarity):
> 
>     gpiod_set_value(jadard->reset, 1); --> Deassert reset
>     gpiod_set_value(jadard->reset, 0); --> Assert reset for 10ms
>     gpiod_set_value(jadard->reset, 1); --> Deassert reset
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm: panel: jd9365da-h3: fix reset signal polarity
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a8972d5a49b408248294b5ecbdd0a085e4726349

-- 
Neil


