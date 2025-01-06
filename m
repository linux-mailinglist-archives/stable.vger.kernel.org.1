Return-Path: <stable+bounces-106852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F6A02783
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CF218822D3
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178F1DE3A7;
	Mon,  6 Jan 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6ubN1eH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B621DE2DA
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172533; cv=none; b=sWlF7Y+2xcMTisM4kEBlFWzz7rXO2MjgVgLI85Ud27QtMCSpy/UJT4/YoLeKW4u5+knPA068sOGRsubqVqeyGxbwllZadpnVBqgJHg48yLrgDmULUabN2xvEeYu9Wb2sh4eFExkTcoCL06iECL/VOy6k+WKfXV7UVO/2uH3VBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172533; c=relaxed/simple;
	bh=tbZDcAHgBPAmgkU05bxJQHp5wnDiBANbUfwHcrvnQxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM73WxyZ3OBqjHwQdLo7eQ/ELkQKt/BQrDu/FIqYCqcY5vhpGIhRw92D2JwvAFDj7Vr2jyLfP9QH2IocvYFye0InY44ZGMX0QTA0ue3Q9A/UjPtIIJ8akiJc3kNpwZ1Vnq4l+5j6p2Mn/PZHHGXukhPOiIHRDrvCendUQded5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y6ubN1eH; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e2bb84fe3so7600036a34.1
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 06:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736172531; x=1736777331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tbZDcAHgBPAmgkU05bxJQHp5wnDiBANbUfwHcrvnQxQ=;
        b=Y6ubN1eHwOeKeWqTZcjbA3WAAB2Fsznx1+Gv24RzOOf4v6+qkhPSB5ReIwBczEQXcC
         Pyb2rr8D9W+5SKk5jcD/N5yIHEyJGBlQP9W1lC9QHkHmF+WCpdSKPorXkx1B+JrjwSWi
         Bw3ztFEFKoOk+tTPyi4Rq5/So8LPfsPmzgGe7ZM92CxBxaN0ExKDSKRJWmUnM85WTN1S
         66S1iRYeCDQVQMbUlaVG7PZmF4VUb12zmqs6etIwsYVsGJIxcO1pxu5hElqOW2yWnxy+
         wtGTG+k6VB3YPL79MnpEWQc4eIsuLeKoPhswL9f1qpXlYhip4iddzH2dN4IGIgYT3p0C
         JW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172531; x=1736777331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbZDcAHgBPAmgkU05bxJQHp5wnDiBANbUfwHcrvnQxQ=;
        b=iv7mVU3g6KSDD5RK/NSVRoK8FE5HUydIEBXk5kzLmcTDKfDBN2xfxBS2de0T0++A+K
         +en7uFpCxnrlj4RxKhlg/kq74k6iQoYU7KYf1LkRyo1leuOdIWmq+yI7aE+lkZ/KrRC4
         u2fT8+AfjZaw6MrAchURT2imQ5wIYvqeo0r8qSWs074yUCtvoq8gIEGgqto42hOGZ0Th
         sl7+1LPA9dejs0fuTylyi2DNqb69LV6dptbM2yr9NJJQKmF5bkoVCY/M2SvoE+g8bVUz
         2a5y8Lx9YuOz3Tq7bPpbu9oT4JIKtDOfK8/S0Q48i7xaEp6s6+OuD1Q1u3ymlZ4b4Mb7
         ty3A==
X-Gm-Message-State: AOJu0Yxukfvc2rFwi4Hcbxn911VQZnRkdG4iHqC5iE4gd5dlvAE2Xkil
	Ku0yOZqgS88r4XYTT83x0rTUV2s5d2cbw/5qiJyelMSTB7hQD3ZQ7khGUOsB6uK2CE30v9Th9oF
	Ks6VSbKG8qXMbCWdNUda08EfBLh0+ff0DCDbY7A==
X-Gm-Gg: ASbGnctvOcua9hV5Mx2f3uevn/YXc2+f/10/HdbsS2817iwK6AMdT3mMCguhyAyfNXV
	TAuFbjtw7+Q58GMDnMmfp8iNypVVNADpAoDH+Szc=
X-Google-Smtp-Source: AGHT+IGAkaBZlNY9VngboPF+eheC4Yc8noNMlZqFBZLxX8frESJbZBHf76+UZ6tozxGudqxoz4GhoQ4srwSQvNLU2rI=
X-Received: by 2002:a05:6830:6c85:b0:721:b7ab:262e with SMTP id
 46e09a7af769-721b7ab2694mr5457036a34.14.1736172531311; Mon, 06 Jan 2025
 06:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103004519.474274-1-sashal@kernel.org> <CADrjBPo_oiqboE4jAemR_2AjxJtSgMLpS8_ShWcX8wJLB4rszg@mail.gmail.com>
 <2025010457-runaround-wriggly-d117@gregkh> <2025010616-exemplary-had-8699@gregkh>
In-Reply-To: <2025010616-exemplary-had-8699@gregkh>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 6 Jan 2025 14:08:40 +0000
Message-ID: <CADrjBPqKzFGdMkQ_6f4g5Ua+WwPFx+pYMErrtF4d0k3CnQhMpg@mail.gmail.com>
Subject: Re: Patch "watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle()
 for PMU regs" has been added to the 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> >
> > Ok, then we should just drop both, I can do that if you want me to.
>
> Now dropped.

Thanks Greg

