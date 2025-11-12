Return-Path: <stable+bounces-194627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92BAC5325A
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C64427616
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F612BEC31;
	Wed, 12 Nov 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAxdrjkp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470DF26A0DB
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960944; cv=none; b=PxQRJWABO8LQg7FPnV1HzDcbpjEx1T8sjXCDDPJwW0nnUCdzuEiAARUpl//33MRgGcmwmzVKVGgdrXe8pU/iBzsLB/w1TolZ4dxqkoB90Ytp/d1s0mS44W0Pfd4fAdcbfllquRr1z0rErDqU4bNwFIMCA1j92A85oQaMPBN2Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960944; c=relaxed/simple;
	bh=WFyfDv8/VQhqxulaMv35/Nawd/nWvOcExPHLxYi1pT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQhx2NJAZ36ZTJwSKZ32ZYNQlWau1OkMNMVGcxPf+Hxd7DrVd4TYXOCHwa+qWTp7a1aPQLAnSu9YJuZo2Jv1Ni5gpLfV/OI7nZOhfdqp3xad7e7Nb1O/gNEpshdKwc+Oq37KH0zPuzdY+MHwOEzeGz0XNGoJ+u6dni4El9wRCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAxdrjkp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47728f914a4so6310675e9.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960940; x=1763565740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5P9hVRbx4wPte33M7hcHk6+oIwViC0UGSmzBYhFHLI=;
        b=bAxdrjkpkrks+YHlSWXXCG3Q9xdoXRxu0N7K/BV9v+tMmLmW3ZdtQmWlYTBfDF8FL5
         JX95iH2XmaBcmAzNJCjoAJ5/Tmf0rhc7PEs1cl7Gmr+29MKmuaTrKJAYsWUF/6/LfJ6g
         J5ZpDpA6EpjZZksI3VRBe7aATBcMJe7DCjR0lmrQ4YJ2SWfkqu5N42vz14W8SfQjo7dc
         KpMwMLiIX5O6hyNZWo+r/FEAH5jzM2uDszMpOEvayG3X65vxQsjuFyDh2MLXqYdZ12T0
         odSfbJctJyvJc4kNwbrP0crwNesecz2pAbjXebpF92ECIYkRy+x1HSV2y7OiC9Hg2hTw
         HZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960940; x=1763565740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5P9hVRbx4wPte33M7hcHk6+oIwViC0UGSmzBYhFHLI=;
        b=S+yMA37SRx1bFShOA4ANieNJXtsnjNa/Flboed0+dvKfXKlJ3Lo/HTz4i9l282UOLf
         xbiQcxBrGEJTSivS9OnpULF9fMjarnw4Yca8OzVZnRNg2ccxcAAG0H5MG/HsmaxJ8HDR
         2BR5ccW1A12mTRETxoIYGES1SEfueEt2LTudx+WIAF9iRf4m/Ddw++Th92kuAJDaVR53
         gBGzTPAqbWyYlNUHfHRwR4z+LZp11nf8aWhHrppQxSM8urZWEU8izLUrn08LslYGg0gf
         +Q2ZASw/Aq6+DnYAi1TIaXiv/Tb+FmI63yOWnC6Ttbt1QWzIBGw8WyMLETRNRAGd8l4h
         faxg==
X-Forwarded-Encrypted: i=1; AJvYcCWUzoJcLYy21a2KHVKZwmGNW1vYO1/fgGUo7rMTqWtuwrBqXdo68zRu8co1JuiVS8kwzV8DZbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAB7eWlYJNzbzcJa+gPGDIBr0hgRkSkwSJvffR6Uo/oOja3bk
	BC1KzZM1+rA2YBgH50TDh2TeuMe8S93tOaI3tJzvqCew3ys0WvY6v5e2xgw08KYEThk=
X-Gm-Gg: ASbGncvcqTgvPIPVmuuOeeQ4vpfKx0rviwmyZyMHdFwau7T4CFkFJZRc80BY697L8Ip
	1dPwjtG8RSUNfaJ89/Owww7Rchvc1pIXRgDCpgtNLMTVioX4b6NIGKCC6EMmLPz+ABGPRmcgTbW
	QDBV9+YGLk4N8an9Z2Z4Rmfv2DoG9cejHiuJ4IA4pSBFcklAxvTBkbBbAiA9KdUKF+wIqj+6dyp
	+Qu6K5au+MkUKJYEmab2BbJZer/FduzcjbrlOBzpRyz9XswiuRKRNQXhMjnV8N9rX7lzSkx/jCG
	x7S8/hqkY8Dfcpin5OEDLlnzJF7olpyUexDlBHbniM7Kualjqh+nLzIQhf0p8ktIYbGSoYBtHv+
	fvtMkvRmuztC161JLSHSB1eXk5+BuwN++DvWwoEROH8D2mlDw8+axboBwcPlsznK9CJu3rDgbXt
	L0HruztXpzaPzty78BA0z7WPh7TN41XxJ0lVg5Rj+u7phsxZc9GXTo
X-Google-Smtp-Source: AGHT+IGwwenUJ0F/WO/zgoeG4aEMiYIBCD7Bc1kw4/Qbk5pV2u/UjSyruuNtKsuqPGua+pTCng6lWA==
X-Received: by 2002:a05:600c:4f12:b0:477:639d:c85b with SMTP id 5b1f17b1804b1-47787061d42mr35222465e9.2.1762960939616;
        Wed, 12 Nov 2025 07:22:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d? ([2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47788932374sm16400975e9.0.2025.11.12.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 07:22:19 -0800 (PST)
Message-ID: <c0714d56-72e4-499d-9f81-7676628c4453@linaro.org>
Date: Wed, 12 Nov 2025 16:22:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251017054943.7195-1-johan@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251017054943.7195-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 07:49, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function must not live in init. Device managed resource actions
> similarly cannot be discarded.
> 
> The "_probe" suffix of the driver structure name prevents modpost from
> warning about this so replace it to catch any similar future issues.
> 
> Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

