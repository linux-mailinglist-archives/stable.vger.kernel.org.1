Return-Path: <stable+bounces-108588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBCA105F8
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 12:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F751672B8
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C48229614;
	Tue, 14 Jan 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0BU05vq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BC234D00
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855687; cv=none; b=aXYIpsrOgC4a3jVfjKmXi1y2dGQ4+nOUeySfdOSo81CEHKTsQ3kKPXxbZ1gmzZHffBnfAmMekSr4pR9qoOIq+PcIAJpG8B1XqXlJ2aliEilCCU0ryrTHhyfs+zOkfUCQJUDMjvFZUxsq4GQLDG43oqBuqSXK3BX3PtrgZzRHH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855687; c=relaxed/simple;
	bh=fEDej9nAUZIT3iZUHPHO5YoBQzGTiWDJOevOdtjt7NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaGPTpwPCWTZ7g+dbLjb34Lq6mvxjUWa9F2cdg5LQmfObfcB01HMosAhfXRI5LwkjIDj6ukzdSu49+Py3qVIvQEmJRo5lu14b0qsnDXypPtHMUrwqsq3l4E/Ez7PIytEaPM/LMiOis/IxEEm8pETpR0wVWacB6gxfmPZioKC39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0BU05vq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso38394155e9.2
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 03:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736855684; x=1737460484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbJZNH3I2kHSJ3p3lZHpAuzG4uICLJvj/AiJ0Ww5yMA=;
        b=r0BU05vq0UG9S/cKonr0ojd4GQYt9tp1ihp6z/PQXI15eL2WJ15jbGzuQ1IzmpWmf9
         Nj2geYIoKgLpJKO2BLpYep4OU6uP80jMEiioLLRkJWuKiGPO9M1E/nVsj4d3RVn0CRR4
         XcHs9qS5kZFdaAzzN/hmeAfpiue/wW6caDKJC9xKjmox4zCZoahuF0ld7lgtkMnq2d0m
         M3mloHq3rTF0BY4lg1yWBzfgGr14xfsSAjrU5OQ7cv+70tc+9DN3EZqBr+wb1L3NfqGC
         D94cbvjdskoOcv/sfANOshoSLyatqVMqNE7lOdDWIGAbQx2FvCqSLCxWymul67ukwWrE
         o6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736855684; x=1737460484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbJZNH3I2kHSJ3p3lZHpAuzG4uICLJvj/AiJ0Ww5yMA=;
        b=m/P58YHOD06cfZwoRNKB+Z1Gh6Z+jSV8wR2zUTUHn0qn4BMqCiLt7CEiylPBh5MSxj
         osSaXj39C678HoBCISxZWNgwnT+lwvH1TPc0D/28xwz/SRr4zaX4TQ6nZAMkXtcOGqyJ
         CCH3RN6zaUWolMY1JOmZzGAi/6touk+wWSsubs0aSCXyCMOx7Gt7662u914AZC2CuWfb
         IfC/B8En9MF3VJNlzbFsoUBpitTDmO5zyHbhItteOpl8YOoGExSmVUGyEUZ6QAy8vH7+
         jtue5W4kzKtA6I3jthhoxa3cWWUaGyOdZz5K5ljcBih1q1cgawSYtDhwhKh62hr7CFTF
         DW2w==
X-Forwarded-Encrypted: i=1; AJvYcCWu2gbcbTiRILM6Ui1K6LVCsnWj2Ln4+LP8JW5aBrGJvCV9bgspiDWXqyQS6Yv0gV5r19R7zdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdSAdZmsrY1ce5hXWoh3rFlgO0U4jarPdYjVJgFPtby1terzr
	suLT4X3OUWDcFdhPbUKOtyxOqx+xaEjIGhAQxoAQLSTcaQlZXuJV1KtKGY+5JFw=
X-Gm-Gg: ASbGnctO0JCXsTqOc3T9vvkI+UpZtH06HygNox0895ODRxuMRniPZl6c/gSTCJ8Cjbe
	BhtNYF/E0Z1Ym1cWmK/woF+7mreQEgUYI6BXF1Ur5CbZNYfYxa5CIiGpCFXXk0cBGb2PCo2UL/Y
	OHHUM7cgbtGzU3Vqu0fKhipASk0a5mKHU4+QU4v2eI2Nb/HJ8v6NMgkt0Z6PhzmifHMN5WAjL4K
	CovfXcPwjI0MO2LHXoQDg1zg6yPgBpwZ/uoo5QAernE5JSMlZzLCCtxpGMnbgdk/q4J/u1sgIBd
	5GumB1LeRgpviJYn6zO4
X-Google-Smtp-Source: AGHT+IFlWMbt6nrzrirx/rDmydW/pVj5xprtbzyuAVBQY0lAHuDRdBjo+/B7yttkEhzKPsZ0JknC1w==
X-Received: by 2002:a05:600c:283:b0:434:f1e9:afae with SMTP id 5b1f17b1804b1-436ee0f8783mr124040565e9.1.1736855684496;
        Tue, 14 Jan 2025 03:54:44 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c0f03984sm13710775e9.0.2025.01.14.03.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 03:54:44 -0800 (PST)
Message-ID: <53f3803f-c6ef-40db-9794-6c90b37659c1@linaro.org>
Date: Tue, 14 Jan 2025 12:54:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/5] thermal/drivers/mediatek/lvts: Disable
 Stage 3 thermal threshold
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
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-2-07a25200c7c6@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-2-07a25200c7c6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> The Stage 3 thermal threshold is currently configured during
> the controller initialization to 105 Celsius. From the kernel
> perspective, this configuration is harmful because:
> * The stage 3 interrupt that gets triggered when the threshold is
>    crossed is not handled in any way by the IRQ handler, it just gets
>    cleared. Besides, the temperature used for stage 3 comes from the
>    sensors, and the critical thermal trip points described in the
>    Devicetree will already cause a shutdown when crossed (at a lower
>    temperature, of 100 Celsius, for all SoCs currently using this
>    driver).
> * The only effect of crossing the stage 3 threshold that has been
>    observed is that it causes the machine to no longer be able to enter
>    suspend. Even if that was a result of a momentary glitch in the
>    temperature reading of a sensor (as has been observed on the
>    MT8192-based Chromebooks).
> 
> For those reasons, disable the Stage 3 thermal threshold configuration.

Does this stage 3 not designed to reset the system ? So the interrupt 
line should be attached to the reset line ? (just asking)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

