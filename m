Return-Path: <stable+bounces-190023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389EC0EF1F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E4B4F5D84
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876A3090E6;
	Mon, 27 Oct 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AkHuYLsS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEB2C0286
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578359; cv=none; b=rGehh0Jmcgy9weWBD8pv0kxJ0Z18dUU/TS0sRRXe76cjLB94JWQ+YwvpNfKc0KXiU3sZcTuJkZmGxB7KOuzDpdA7IqXHjkWoe2YpFqn8FF0bm8cIh/QE2ALCxZqkjSxwbJwskARYx4fZ0jQYejubYqoXlwaOGhJmk7UWDV2cLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578359; c=relaxed/simple;
	bh=KixK2y+JDj2jpYzeklb+J7CuSxEOJKGpkz49v27WZzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnPURs3sR0tqlEWKc8xHH1kYpl9wseBqkOao9TDPbgSJT0LCEdYMn93cU0wl9kvDOHCQKOYGHxzQ6zOwQRHrjsVGs5izIFKxHDaZNWhIMFjIPUr5WeqL4V7oN462SOvU2h5blTvEqjvm1tmrytW15x4kob/Hv/Nk3K+QZASqge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AkHuYLsS; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4491510f005so1175079b6e.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761578356; x=1762183156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOEpFoGH59PM/ywxUlp4N3kjMG7XFuzAFXwRgcemaNY=;
        b=AkHuYLsSvNKHLktPzVrPstr0klzNEz01NL13g79nQmNPcly/Z07qvjCI8edqfCwONy
         AGVWtbn5Bj5GucX25v4Y8pGXuDNa2Y85TqUR+zM/tu2lh7ib5jFMVAC+xYfwzri4XLKc
         OWWIuLYy7ch/RrNi/532T/urjiSXFAofGva1YPz09uwvLOruta+wQ83gTL8xJqjjvcLJ
         bS4ckwDaCBUyjfYGsjngIzzgbCjk7ggb58lvlFAEpOckKCE934lGfSXxhLZw0fOudjPJ
         XNSB3d6B1+ZnyAvvbuqG7Qh9qDpJ6ncda8OQgEd+5BlLxm6KoxY/zbmLXB8zFQhSPFzy
         3ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578356; x=1762183156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOEpFoGH59PM/ywxUlp4N3kjMG7XFuzAFXwRgcemaNY=;
        b=NdjZkNwBuABqnTlfBM7rjXYfG5scZiqKKUS2y1u1/qt2w8TvEd/XZ2Cgtw0a29Axy3
         ZE6ZNd0u5Rl7sN+FG8vwj1P3Nriiwd0/O/9NlyUXn6KZImAe23qiLqzcS+AJQL06ha6y
         m+hw0IqJolcB7hx9JNdMTmgWdrFGiKmqWNea6fc/afOIupaF+ABcOXUp1QRJfG8jAyRJ
         8g1V4/CF/cSBpC0lY9yG//3kRAjvkmlBSNY82YNAg/0KfdnDGwQiIxGRzqIQPqCNBA4G
         12BAKSrlAXfhOUHLe7OHkJuiE4DACq5stGvWSxt7e9I0FjgviBqBFPWBdHjI+2fieFSq
         NHzQ==
X-Gm-Message-State: AOJu0YyJt0XvqpY454SarZNHsCsGCd0OMVc/s0srFAplnshfF5CFsryO
	aHp6Sl3IyDUxxDBbbluhpDcgZK508do4Ov3dL8CS2LA4zeUBF4kYyFdt1q/ftbx4tuI=
X-Gm-Gg: ASbGnctNij/RXTI/nz3TwphZodJlGzdvMEZi5vOWa4XPiI25n5oddIh/zfBmU1lQVzJ
	Q3xkJOhno6CPkLjl0cli39wVhywfKje9z0ENR2X4nxnXI6xBJ8DBN/g5qwC8vSCLHkJT2q4hdcw
	RGSefhY1UOwLiuHivT7kO/0T4sArKp/4id5PoU5OmeS/bT+Jg00s7FPU03kjGFwJtC9NsJol4qT
	BYg/QSEVbgkr3LBqkv6Lebd+jbO+38FFvWV4VJ6J38fwYFpxUCL7U2aWMaoxnwmBTUIea8SjPt2
	JM7X4Btf5MUlal5Ow3eK2eHxXcyyFqDK1a0lC4b3y9waUa3REDuKjPWkwJ71Kx0E6CouE5jHFDa
	9hv9a7iN99yfcgb7l98NKaUdJ0CjhMkR2TmGtiVZmtWmgl/jj1N4KL9brRcOa+quZHET8JfTp1t
	nLfhG/FeP+2Ir2Ew55WNUjzakDzPelj8VYXTebitSkncTjQGHf+A==
X-Google-Smtp-Source: AGHT+IET1m0Og168FNkiHiiqS/dkK0Q1Ob1wq3rotBlVC0PelMHhFuKEOpxhv9FYgyGB4FjHQFu58w==
X-Received: by 2002:a05:6808:21a6:b0:439:ae49:9159 with SMTP id 5614622812f47-44f6bb045aamr63228b6e.36.1761578356367;
        Mon, 27 Oct 2025 08:19:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef272326sm1909058eaf.2.2025.10.27.08.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:19:15 -0700 (PDT)
Message-ID: <0d423afe-9aa5-4423-935e-1acf71f457ee@baylibre.com>
Date: Mon, 27 Oct 2025 10:19:14 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
To: Miaoqian Lin <linmq006@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251027150713.59067-1-linmq006@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251027150713.59067-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 10:07 AM, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer, which may be less than the requested
> 'count' if the buffer size is insufficient. However, the current code
> incorrectly uses 'count' as the index for null termination instead of
> the actual bytes copied, leading to out-of-bound write.
> 
> Add a check for the count and use the return value as the index.
> 
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")
> 
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


