Return-Path: <stable+bounces-20498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8F859EB7
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3161F219D4
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3E2377E;
	Mon, 19 Feb 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiSb1HW8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6D23766
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332437; cv=none; b=tPBJS4p/JZ2CT4kxa1IxKrKi8dRGoMLhRXFPI2vT5tXEZ1FLvB/BD4OKCHn+iL/aBYIHhdSD8d9vL3VM7rBVwKV/DHC7Nh1mIYG6f+gg050ugI2qhgmt/Yhave8xNl9iFFz+NCSjPMtNXG14OOQyTmHKVCbrKK/+FIzHsXP0/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332437; c=relaxed/simple;
	bh=FlUNJTSGS5Zv86dfQYNzWLrOEh3bLI3CTYICDi+G4pU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SXCSSKxWNVpSn4aD0HxrijAVqzpfDyOS9d+fsYyQCMXDjfN5ELH/SjyW5IL9qWrkq5ATasRrB9ND4khzut7xJoC+KwzqPizQjIqiF9+96NmALRGvyBZzi14AjB7mvnd2cVEq1pvdmmdEiZyM4cjYRmEv/D3MX4k/9rY1DelDAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aiSb1HW8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4125e435b38so13784815e9.0
        for <stable@vger.kernel.org>; Mon, 19 Feb 2024 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708332434; x=1708937234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkKhuvKsEed9Py7C2fiWGDe+5remAmNan/P66AVdUhg=;
        b=aiSb1HW8XuTYP2tXyXYich31OB0hDUWOfUar+BN6e+HCq+0XBE1bL/Au9cXxzsHe0w
         C1Ft2QlBV1frov7sQ5otZS1R0HkQlKy4OsfLm9UjtlQ3qNxf6kVvj2L5KSyHEwdXhYD6
         IIN7bHuRAJjSQAZBHmgWsQs4E/YuOo+Jd65EL5HMuNJdupJi3p6guFoJnYtlGmPlVtjo
         wFgunwuNKF1uf3+zLfaKK1+1I/riT631F6+8c92tvVy1jPdCKRwPE9xOOoHFS1le9gjZ
         ENr7eB/l56SaiT1h271A/eRF+lQh6lO8+8Wra2iCU+hVntg/JfdD8vgHf3Z+bEmh3Yx8
         J49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332434; x=1708937234;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkKhuvKsEed9Py7C2fiWGDe+5remAmNan/P66AVdUhg=;
        b=u8LI1+2VKMuZDqGXrRxboeoILr0D9f4DoIqdQRulv/6OkAeiUfNZ3ntC86bK4vwFs4
         rGeio4v9inudP9mGtAqrJIo0fPVG5lIrgmaRlRgFYOLYszCA7L/ltxcUzz+gfSrPiZht
         bqFysuUd+wEi1itniye5WJpZNmCzAlNdYbzk2YOVJ1M328Eucc4jyFg7Zducy2OPl593
         xDr39n19OYbWUPduXB1IMlJOKHvASY075S4A1NQQuPapG4CuFWDllD7q7k7Mjj+SxShW
         kWT8KC5pibiN5QKBC6ud6yTSb9Ul/OadpAiyblRdZvlQmIutA4uUkie8JvxLU5rZwxOJ
         y5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW7aE5oLjtDoGNTSu3REm7HNN3zpxYYwG8jY06a9wBU0Wx9T4M80Va3XTvwBqBWv1KBjdvDY69dpCvPLPMwSdZ2h0b55HaO
X-Gm-Message-State: AOJu0YxxQpZi2k61XNxffZLdrfckeVRmIqQ301ExISaDzrUlHoB4RT5F
	oaAGdX5j8T0uF3XX5a5fmR5HyZGF4y24bqsyu71M2R0kutsYXGlNmNt8Oc15Wow2nyRWpoFSG/v
	wOArMKA==
X-Google-Smtp-Source: AGHT+IEOJaRgLUfw1Fy36Qpxf45JsPYnzvIpHgy+e0TCI3oFwEedoWRDKzdVN3pgzb2tsjofWGis/g==
X-Received: by 2002:a05:600c:198f:b0:411:e5c1:e573 with SMTP id t15-20020a05600c198f00b00411e5c1e573mr9008685wmq.7.1708332434066;
        Mon, 19 Feb 2024 00:47:14 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f5-20020a7bc8c5000000b00410bca333b7sm10499211wml.27.2024.02.19.00.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:47:13 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 khilman@baylibre.com, jbrunet@baylibre.com, adrian.larumbe@collabora.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Steve Morvai <stevemorvai@hotmail.com>
In-Reply-To: <20240215220442.1343152-1-martin.blumenstingl@googlemail.com>
References: <20240215220442.1343152-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] drm/meson: Don't remove bridges which are created by
 other drivers
Message-Id: <170833243318.1719293.16562400747417002919.b4-ty@linaro.org>
Date: Mon, 19 Feb 2024 09:47:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Thu, 15 Feb 2024 23:04:42 +0100, Martin Blumenstingl wrote:
> Stop calling drm_bridge_remove() for bridges allocated/managed by other
> drivers in the remove paths of meson_encoder_{cvbs,dsi,hdmi}.
> drm_bridge_remove() unregisters the bridge so it cannot be used
> anymore. Doing so for bridges we don't own can lead to the video
> pipeline not being able to come up after -EPROBE_DEFER of the VPU
> because we're unregistering a bridge that's managed by another driver.
> The other driver doesn't know that we have unregistered it's bridge
> and on subsequent .probe() we're not able to find those bridges anymore
> (since nobody re-creates them).
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/meson: Don't remove bridges which are created by other drivers
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bd915ae73a2d78559b376ad2caf5e4ef51de2455

-- 
Neil


