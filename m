Return-Path: <stable+bounces-107739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D6A02E61
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2FF164F4C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72C1DDA3D;
	Mon,  6 Jan 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXp5E74j"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34B1581F0
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182523; cv=none; b=o53wl16pFsYBT5ygt3dsIK6bSSmuBs5tjrgQJFhy+UbIA928/ZdYNBA3F5lu2UyMmr0pYkb36e3ChH1WapDZBJKZ5IfZrRDUrzEuww1nsYf2u+4kHY8v5elUIK8RK7KBxY69ohGaFRlGk2vQiL6Sv1VAYqMC7mONn1+/NDsSWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182523; c=relaxed/simple;
	bh=BZKttsrsiWv5JkQfESPeIFAw/pUJecEu7sURrWKCKoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxK63UkDj0Hsd8/FUTJ2TQJfTJA9z70fGCjNAdfnGTFQHKilVX/BZO5cR1tpc23CAm3C7zSW2jp3+bfQ0XiJrPEZHC62ifOj8FvVTr2jbicJ6A0o9jR2oWyskJiq+rE1wRjsYoc4bLlogm2OdibrfiKnhdYTXFdgAtSc23YsVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXp5E74j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4362f61757fso145290625e9.2
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736182520; x=1736787320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xX6thrDvcNDbJJ+XFOttLWUYB3ff08q7bOBIL7y2e5U=;
        b=NXp5E74jJZ+LIJlyLsBO8G4GY/9gBX/oxYjabAmV8Lq9BhB2RPEF/TLo3VSF/0YKlW
         nPe4/aqu9Wld9KAEfOcv159L2umPkdJHfabnWU2MPB7qENyyhdw3UyJBMv7art30SMfR
         EtBBteOIs65PLdBp40G3mjcfvvV6LwusMBPLmpixC4KzYTE+wlEyaAVHi/rIPgKFNXb3
         +0KmCVkefQhoCNCi15mi6fkVfvpqqm0OaSiGtfWtQ3YvkpjUQGzF/5ddrjyFgLy7u0I7
         GilTlzYp+KmSKpGzAj6VNUctybAGAVGQa2hnoZLtvWp0Auv5nv1zy9XDGMEXv2k29fbH
         I38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736182520; x=1736787320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX6thrDvcNDbJJ+XFOttLWUYB3ff08q7bOBIL7y2e5U=;
        b=c3nvuZ2LSZ4wA3sVKviKkBAcj48w8HMaTTnELOr3Q+z1EaSo+1o6+nPSbWejNR+eoZ
         0xhUJ/Vhz8mvcBwQL9us+4M8dNycoKfD4cO7TAVGDNjXa1Ag/CqcpFRRqXiCchbZ34LE
         1rzABGutleW/h2zESpAlmDSFyZMRYuQ2KI+2fb2IPAyRUrRew0lsyvpftS2dzI8Gx05h
         B+CFDTX75GeoEWb7w+ZzJivcB5e7R4NKWZyT0kRrCtT471fXPB7U9zcMdWOUP3Mh14dc
         eRCNGCpCheco81Odgr+5rT3vfGEfdZHsj3CFmdpcgAJtRWqsxiljnV1h441TbO9ZnUa0
         K0lg==
X-Forwarded-Encrypted: i=1; AJvYcCXmbnev26tgXiePhYLJC6jUdrsFaXfqNUJxRGhSI42BF1kawytPOwU6AedisxYTy5YG4rFLqeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwxDLTzOy9eKd2oUj0BTXQSRfFta0QlHfQj3ec0oGZQUEe2vjE
	6Yffay5CX7woRtvYz70MaNUHMSlreA1aWqveX5Z3ui2erWF1WSroY3VqDYCqV5I=
X-Gm-Gg: ASbGncs5p6ILXz1jrOoMo+9HkxsZjsAJ05lUjPY0IgWS1nNieXyiE/GSROmPQLWuo+L
	dTpRxO7NH2GN0mH9qGvZ19yYaYydhyOKmuOt+d9uvWlsFsEhIQp1BmK8GUVcmTT8nRa2yCLEkRF
	KKgj1uHmJOL/EIqY7oCQDHVql0MxvH9HCyT1B6hLp99a/EMvtSPmvkVjibW7KyoOvdASccP78fZ
	PajAauntlAeyYvW1YtDNEVEsz8xEUZZulBYCdjdZqIe6CF2x5oKsGaL5nNtfZtnDnAJyQ==
X-Google-Smtp-Source: AGHT+IFFySc7iKkHxeITf4fGLI5MwQQdm55MnSdPaNSW36sDOWHRxEhzUEd0Xql6oRv0ysUt3lo14w==
X-Received: by 2002:a5d:6c63:0:b0:386:3e0f:944b with SMTP id ffacd0b85a97d-38a223ffbfbmr43730638f8f.37.1736182520354;
        Mon, 06 Jan 2025 08:55:20 -0800 (PST)
Received: from [192.168.0.43] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e31sm47631023f8f.33.2025.01.06.08.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 08:55:19 -0800 (PST)
Message-ID: <c911b6e6-0af2-48f2-9445-0a05dcb1ab5e@linaro.org>
Date: Mon, 6 Jan 2025 16:55:18 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] clk: qcom: gdsc: Release pm subdomains in reverse
 add order
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-0-f15fb405efa5@linaro.org>
 <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-1-f15fb405efa5@linaro.org>
 <3nq6zehelawkkdsxuod32pyntxdgbijsjm5bwk5hu6l3nni7lo@5aeutzvdefku>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <3nq6zehelawkkdsxuod32pyntxdgbijsjm5bwk5hu6l3nni7lo@5aeutzvdefku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2025 16:53, Bjorn Andersson wrote:
> This sounds very reasonable to me, but what's the actual reason?
> 
>> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
>> Cc:stable@vger.kernel.org
> Without a reason it's hard to see why this needs to be backported.
> 
> Regards,
> Bjorn

The reason is it makes the next patch much cleaner and makes backporting 
the Fixes in the next patch cleaner too.

I could squash the two patches together as another option..

