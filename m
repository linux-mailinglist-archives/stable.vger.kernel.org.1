Return-Path: <stable+bounces-108638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DC5A11023
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 19:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB823A28F2
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44611FC0EF;
	Tue, 14 Jan 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMJaW8yP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77221FA8DB
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879436; cv=none; b=o/DT/LrtW+IhEs7ISIqBaKWgUPeK+Xov31pAJT8gahJCSfVImaQSsojT85Ernp3zbUubUE0XZABn85ZoXfm7cXZK+LZ5LGzsmqOFWfgwCYIClM0HZeMaskzYG4auS17zV+9coGvxQZ5qJmPRmzE6bmlNzBkNefhcc9oEKt1NB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879436; c=relaxed/simple;
	bh=iPnisaLwyn4uRPEB7WDrZKm+oOwdziGvVmNWYObjYxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u92BiGGpcDIhNg1JBhB9mqx6y+MGp761itWs1c+ufzGqVi8+yVbE2fKhl3SGny8hMWIydjPaw+uSKVtpJcBRMykI3YlrMDfKFaH47wbIhqWUOahKYREoLBm5jPNzqDE5ylvSNzF+MS4TEtyYHSf72xSpfYanfm2XoX0uWXYrWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kMJaW8yP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4363ae65100so61651825e9.0
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736879433; x=1737484233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWXRGYqIYfAFCWYGR5cc8ElnhXv1e/ZNViY5lKk/9zc=;
        b=kMJaW8yPRv8X4zaUbVBHAP5OQmUfkdnaFTyP7w0M5dDIwBr0GsjckEDDIIHo9QxJBG
         s0wqC4ofd0q7jDhobybdUjfMc0edDKl3x44coof7CsyDUT+ZzJ58r1Csl884aU6TLZ5o
         C2qln8ecBjXRFzyJVNSNlrqMECMh9GV9Q1/t8MjdLFtaPKuSecnifjefnBrf+EgU5jgK
         bq4JZV/JSmoz4N9zGHEkMr3ivTOCwoxK5d/O3+EOad6F+LSjtUj0Skzoql62MD5NlQ+3
         CnLzlP0kArjypX5MbfOM414hpNBDnCxcuMeypX8QFfW7knJquIt4aE0LMzzs3Nid3zZQ
         Ky4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879433; x=1737484233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWXRGYqIYfAFCWYGR5cc8ElnhXv1e/ZNViY5lKk/9zc=;
        b=qhNeOGdiZHAGD73BI2xuwGO2r1/fBG9WTpt4sOAzQgqHz3KvedHWCaozB/8vM0mJrn
         QxqksVoWNqHeKPyAD71/gVkrRKc7AQEd2dt1LWPVi9WTkv5xWX1ed45Ut/GwdGA9Le0B
         7gHNMf+CaJ71PMfOwoi7mAxOrgdYe4M3rp/2O/mycfMn4yQh9Y7DPo10pDN/Ow2pQLmp
         MZUmdbslBwxt9lkCH3H0Hsot+jESBd1qi6UoF2vSoPB0y6Xk3g5Zy5B6FoaMarsz39Vg
         QldksLNEbIskMNNXZ/kfujaBJa3ZPIXkS0+9Hyi7+XVERRtrhs0lvQ182gADaE1YIsBm
         0z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/rE39iAAOtHouVN/C1gR1HT/D2yV8j0eAROiaKth5qUoaVqzVQTLjoVBWLwXVqzzzmlF7xSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc20rcA3LRPt9vcMG0B6vk5Z3m8kQ2eZiZ+mKjhT6Yn34k9xF8
	UhaiLF0dYWJWNBaX7d9tLJzJBL1RIqLRgfwi9oPuaYbd+v9UrFZIHRh4ru2xz9o=
X-Gm-Gg: ASbGncvFcubBVQsy7Oia7Sosq6ZgTJnmXm9pX89V0MiDtV1fRyUmN9ggxbON/FVWsot
	GkoZ4drC0/jl1YVtGhQ8ZBjMpidk+7yfMwXwcSoF8+8u1HfwEwWIq5ngP3RnOea6wmunX0TGq9t
	93OIJkqqEgjhZ/pZGqDneFG+9YiCmYAAEX9kTIxdU1khgLCazDrb/I3ORBYLTGX3feVSGsm10Hk
	CFDFC/odM+aU/4LO06fP02jfn7n1rT/Q+YexbTV5LRZqDPqRBOkuRWPGEPCN7XoTTwX1KCpxFht
	Qfh1u9bvWbAyFz0zNO84
X-Google-Smtp-Source: AGHT+IEw8eHOips+m7BEL7pSk31Buqsgjf/0/YmNKYluWgMpJRjDHqhoLciiG4fuvyVDzaS9gJVk8A==
X-Received: by 2002:a05:600c:46d2:b0:434:a1d3:a321 with SMTP id 5b1f17b1804b1-436e2679db4mr237168165e9.3.1736879433323;
        Tue, 14 Jan 2025 10:30:33 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e2e8bea5sm217789155e9.31.2025.01.14.10.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 10:30:32 -0800 (PST)
Message-ID: <90dd8d93-5653-47f1-8435-f03502e4c0cc@linaro.org>
Date: Tue, 14 Jan 2025 19:30:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/5] thermal/drivers/mediatek/lvts: Disable low
 offset IRQ for minimum threshold
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 stable@vger.kernel.org
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-3-07a25200c7c6@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-3-07a25200c7c6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> In order to get working interrupts, a low offset value needs to be
> configured. The minimum value for it is 20 Celsius, which is what is
> configured when there's no lower thermal trip (ie the thermal core
> passes -INT_MAX as low trip temperature). However, when the temperature
> gets that low and fluctuates around that value it causes an interrupt
> storm.

Is it really about an irq storm or about having a temperature threshold 
set close to the ambiant temperature. So leading to unnecessary wakeups 
as there is need for mitigation ?

> Prevent that interrupt storm by not enabling the low offset interrupt if
> the low threshold is the minimum one.

The case where the high threshold is the INT_MAX should be handled too. 
The system may have configured a thermal zone without critical trip 
points, so setting the next upper threshold will program the register 
with INT_MAX. I guess it is an undefined behavior in this case, right ?


> Cc: stable@vger.kernel.org

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

