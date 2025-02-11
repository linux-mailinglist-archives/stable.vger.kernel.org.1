Return-Path: <stable+bounces-114862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E69A30653
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269097A1B96
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13E1F0E4C;
	Tue, 11 Feb 2025 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0m6pnsN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56161F03C7
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263878; cv=none; b=KmzbwUrXrqrYJuZuQ3uuLGXljZu6XNCYsl7f3SbMH0ozXgHCHJI+stFJEX+R2IfsbCC9AraPc7pCrJoIy+6B8gBtUqGuIeyh41syAu/5PxldYVww7FepIiKADVyl0pcmpiTeGuP6myBjsfNDMAq64EELDKgRxK3tJVVPXKQ/tdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263878; c=relaxed/simple;
	bh=uwOvEKjgbgfkSheXhWF/TM+S9VjTRURKDguxj/FPaIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlDCKRzAKZfjiK+dwgIREz6yIjINAWXjUpZD8GLiPbpvnppkCN5MjKkihscZLy7SXt1e7nxP4G0VjgzgdE8ISLRodBA+wFrHqNgWyEx2Aqkjtf2mdKA+XFkX1/ql2ISmvpNH0SeQS6iMpN0WgI2uCoXYEwx+849YEdZxYRySB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0m6pnsN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43675b1155bso58545635e9.2
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739263875; x=1739868675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBuVpfBGZc5QukwlLAhOoPlDs013WB9zKRqFDryvqwM=;
        b=q0m6pnsNvD08BHOucBX1kSYTIvBNSLzODyqxsTlpHsZObXnQW3MdeGchgJ8x81jSMu
         GMrnxwPnFJgLVBXORKgHFx5ueoxvxNPzxrWYIzQ07r3WXRm7weK67XME1GV6dCSak01x
         v/ooB54Bacc44aacXw5oy0L8URk2k4ZTwK8DD7TIZUt1NSZN8SfIvqzFEXu4aR01/lFG
         CudSrovyme/UgWOn5HIc4qvZgLohffsVwZ6aGc0appLsUPOgD6z3A+fJN5+c0yuqQt2i
         dQApsFfmFPq1NKBRTB0T65yG9KnsoD8bhqqaBcscISfaz5k4HLR3mcGOzoZjWxKcJ/PA
         kWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263875; x=1739868675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBuVpfBGZc5QukwlLAhOoPlDs013WB9zKRqFDryvqwM=;
        b=qrkH7wJ8le+Vyb6RbPx8JQr0SzYBWRZLNHq7ssqfFfCksZQ80f8n/OrKjtOTYka7FF
         uPKUDvWMWU0/bQYGBNW9A6900Xgtiw3aXp8PG2prdgObnB3fl3m/n85P/d80rA2gLSLf
         p5keu5EfzJbGfIp3jQpXNcNQvy2XC4ItRvAfXkEvou/BVD8MjG3KF4I2j4ifK8kV/nzn
         avDQUpWfGHUkkMcuAb5jh13KE/dfqCxqK5JFCglVTs8tYoSR7Sn/P4cCCk3omH1Cxmuz
         UUDvwn5cXxfOzUfgwkolibdr428NT9Tmp/b0UGr1x1aD+AC3LDRH64OuUjR+9jzqt/TE
         dzcg==
X-Forwarded-Encrypted: i=1; AJvYcCW8zBd2N0zPfBemvdOdH+X5GEewRchjbFtLNmT4YB6kHH1l629ir283YvjZsiOCJlzn6XLsq60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKC7bn9tz8hLDPByYqogj/ftL/1rqJdiEjxRUXB2txDy9sbads
	blebAurDGEmyt+IdRdDeYhyVwDEhcXssckCz3LrTwwsQKgzUQLmyoFg+zjzZvlE=
X-Gm-Gg: ASbGncv7pwHio+VAjzYcDGyAeHipRtyzSEEgAFFqLCAjTUIBRwcvZXA1kaNOaYbq1YI
	i0pw7nj34QbEQelxMMZ9nQpbgbeKE96jWPoZBLAtZNrj2oBZUknrcGzCxzGVbe/BaSuZmXrmTY2
	PhwM+u2pp1zHb7ysyQVdEbDsbl0iwJXkbucjo81J2eqOTY7kH0OR13HQyfqwU52OYP+Iu78gqtN
	WLEstsxcK1m3qM/xMA5I3aewh6+JRBWDn8BC7mAalfryBfY0LbgxLw1qres10UB8ya8ROOZ5FM0
	+C8PhG4rU0RI0+imfw2wVEcXfP7KnxCeSt75nZhsvSHDfycfvZEYrpk=
X-Google-Smtp-Source: AGHT+IFO+zzAA08bfzxBeaVgp6Y5tU1Gn5sLS7Hh+RKdG5t/UoXpSO2gVdVDv0cTsXvcW1Ndi56IrA==
X-Received: by 2002:a05:6000:154f:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38dc8d98e9amr11900744f8f.2.1739263875007;
        Tue, 11 Feb 2025 00:51:15 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38dc0c5a894sm13914977f8f.95.2025.02.11.00.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:51:14 -0800 (PST)
Message-ID: <fe0b0066-5f06-412e-b66a-f3cf6ba74e9d@linaro.org>
Date: Tue, 11 Feb 2025 09:51:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/5] thermal/drivers/mediatek/lvts: Fixes for
 suspend and IRQ storm, and cleanups
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> Patches 1 and 2 of this series fix the issue reported by Hsin-Te Yuan
> [1] where MT8192-based Chromebooks are not able to suspend/resume 10
> times in a row. Either one of those patches on its own is enough to fix
> the issue, but I believe both are desirable, so I've included them both
> here.
> 
> Patches 3-5 fix unrelated issues that I've noticed while debugging.
> Patch 3 fixes IRQ storms when the temperature sensors drop to 20
> Celsius. Patches 4 and 5 are cleanups to prevent future issues.
> 
> To test this series, I've run 'rtcwake -m mem -d 60' 10 times in a row
> on a MT8192-Asurada-Spherion-rev3 Chromebook and checked that the wakeup
> happened 60 seconds later (+-5 seconds). I've repeated that test on 10
> separate runs. Not once did the chromebook wake up early with the series
> applied.
> 
> I've also checked that during those runs, the LVTS interrupt didn't
> trigger even once, while before the series it would trigger a few times
> per run, generally during boot or resume.
> 
> Finally, as a sanity check I've verified that the interrupts still work
> by lowering the thermal trip point to 45 Celsius and running 'stress -c
> 8'. Indeed they still do, and the temperature showed by the
> thermal_temperature ftrace event matched the expected value.
> 
> [1] https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

