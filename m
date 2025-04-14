Return-Path: <stable+bounces-132425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97495A87DA1
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B5D163640
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5F926B2CD;
	Mon, 14 Apr 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTCW/Sp4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6D26B2B6
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626373; cv=none; b=FLA78F/uQ5613zKUHhBABMQe8tZOK/XY0mE+XGZBtKCqoMxUBDiZxsfpTa7Y+hZtScn/Xk8Og0Y/txF6Q056KUpM8hp82zl7485KrrbthbaQpfwY+UmcDgbIS07gYn8yZZykaPC28GSR/rSlDUTEmF0x+2r93/N0xCeP4E5RKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626373; c=relaxed/simple;
	bh=axOkP6NTc205XhOa9w7TMVlJ2Ruy5u08gJeU2uxBXGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hDHlhlIWgtyomUxX1uqr9P+/X78Wq2YYP+zLvlqR599PqGVBp234IbrSp8ZBJxViPhNU/zpzAZPDAf0jjszk6N9BnNByNkhQqdw+ERgcFqXkgUWudjW707MH8RXzLaAIu9gaQ8NRJmI0dMP2r52p5hmti6rriJDr8fCx/xJbZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTCW/Sp4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso47413885e9.3
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744626369; x=1745231169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAiRw+6AEMtqu5XLeIz/zqxIIUJ+4yNnfRZDXY2auok=;
        b=kTCW/Sp4xkfGdgBLOkHxvnhPuoF8FllcyVkTew7Zr4gKS24HP9qst5DftWUilXqq27
         OBOpZ4X0yWDQG6H/e1xa5NqXtFS2BIpaF38PGYFluRcEBq0VL/vcJhRvOJI5MH6KphgU
         H4cZxTdT0Oi+VBx482CFLRqbeYZG07SlzYf6WiYTKeLEGS96ptEcQ0+N64JDmmGTpIvt
         sm3xCmtcywFZoGVdpNL0vZrWt2OJuoVEVGGRT1GS26ZDPKfg4K4iaH1w1qkqPOfspQPw
         gnXzAeeWT55iyRI/roQHfFu0X4zLiC+zsYjRAWNoKubk+CyJplLhl7FgVvklEYoy43SQ
         UHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744626369; x=1745231169;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAiRw+6AEMtqu5XLeIz/zqxIIUJ+4yNnfRZDXY2auok=;
        b=rfFDZ3P2vDxW3D0Uit0PcIbc6CM3M9LI4hX4lsF5qSkY+BbZyagaVi9RjLfJ+Tl3TD
         FOsEDnyOWCbgiMNXSKeH7yWX6yh4qlJbLbtdV33aXOhZniaOtUpafkfsHT7uLtHA7aCZ
         nb1mAlCe1XolaVgAZ4Uc5XR1TjzDm+CdgpAUDY0qicU1A3AmVgGtNsKJk32NjKm0+CjL
         6Okhvt4FEDSyYeNZzple5GuZVHDhnUoJwvUXaHv5XvPdryT8K3Psg9v8G7aEckMnIecU
         6a3FflBHGE2UMKoSRaZn/qVscAGkDenl6t8fckLX9dIPU0MNHdpUvKU1kjxVh9N5jMJx
         GC8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJLOeMwpepReJbvAYBgxC/6h0U9ML1lqUjNI9lehnIZdQD7YPwyN1VCNvQUoYKcoGwZDtr47E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/+jVG2FNC4fct9Y61Ja0Of2V6FBYXkZ1KJqJPwjYpYQd7Odq
	dl3vKiZrcSg4hzCYA8ZNG3SOAe+j9AnG9CuSse8vmXL2RhXlEFbDTN2IYh+0zYk=
X-Gm-Gg: ASbGncv+yqOpGBFa1N2p8JWZAcYL1OW9YfiXIAcXGPxE0HCjoeJ/wBuywXdshFCDB4U
	QxeymFP02SyOGFxm2ZsTAjhaT4Fu15B3aYZrN9yScruIADob3DjqDASPF9dfuhF7trWDnQ4W6sU
	rt+3AOHJz34eJaBKPV0VPcPQIbbqjN5kEIoyeZbtc/vwx1PcYK4M8D3/SgiLvPj95QiTKM7UxHP
	UARxiUGLMvFFqK+mB7qIECe84ChAE2AJPaKJNoob7P2o5YAD9QHJIhjRp7r7rsc8KP+hM2XOh63
	Jy8VR4qH3d8oC7TvDIdxydsXMQ8cIvAa/gpnPqc05WkfX7O3M0q7H9rCLo7Fm9GE/aUawcdDyFc
	gh84W9ips6aFriKMD
X-Google-Smtp-Source: AGHT+IF3yfPKg4s1qCnN4GnM/8MBvLAVhWgFCy6k4OXusWu3X8aq2b3tylwXbrCicC8DSWVM4b6URg==
X-Received: by 2002:a05:6000:2812:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-39eaaea70d6mr6538663f8f.34.1744626369174;
        Mon, 14 Apr 2025 03:26:09 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d6e8sm180459745e9.23.2025.04.14.03.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 03:26:08 -0700 (PDT)
Message-ID: <137c68d5-36c5-4977-921b-e4b07b22113c@linaro.org>
Date: Mon, 14 Apr 2025 11:26:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] media: iris: Skip destroying internal buffer if not
 dequeued
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20250408-iris-dec-hevc-vp9-v1-0-acd258778bd6@quicinc.com>
 <20250408-iris-dec-hevc-vp9-v1-1-acd258778bd6@quicinc.com>
 <811cd70e-dc27-4ce0-b7da-296fa5926f90@linaro.org>
Content-Language: en-US
In-Reply-To: <811cd70e-dc27-4ce0-b7da-296fa5926f90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/2025 13:10, Bryan O'Donoghue wrote:
> On 08/04/2025 16:54, Dikshita Agarwal wrote:
>> Firmware might hold the DPB buffers for reference in case of sequence
>> change, so skip destroying buffers for which QUEUED flag is not removed.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 73702f45db81 ("media: iris: allocate, initialize and queue 
>> internal buffers")
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_buffer.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/ 
>> media/platform/qcom/iris/iris_buffer.c
>> index e5c5a564fcb8..75fe63cc2327 100644
>> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
>> @@ -396,6 +396,13 @@ int iris_destroy_internal_buffers(struct 
>> iris_inst *inst, u32 plane)
>>       for (i = 0; i < len; i++) {
>>           buffers = &inst->buffers[internal_buf_type[i]];
>>           list_for_each_entry_safe(buf, next, &buffers->list, list) {
>> +            /*
>> +             * skip destroying internal(DPB) buffer if firmware
>> +             * did not return it.
>> +             */
>> +            if (buf->attr & BUF_ATTR_QUEUED)
>> +                continue;
>> +
>>               ret = iris_destroy_internal_buffer(inst, buf);
>>               if (ret)
>>                   return ret;
>>
> 
> iris_destroy_internal_buffers() is called from
> 
> - iris_vdec_streamon_output
> - iris_venc_streamon_output
> - iris_close
> 
> So if we skip releasing the buffer here, when will the memory be released ?
> 
> Particularly the kfree() in iris_destroy_internal_buffer() ?
> 
> iris_close -> iris_destroy_internal_buffers ! -> iris_destroy_buffer
> 
> Is a leak right ?
> 
> ---
> bod

Thinking about this some more, I believe we should have some sort of 
reaping routine.

- The firmware fails to release a buffer, it is up to APSS/Linux
   to run some kind of reaping routine.
   We can debate when is the right time to reset.
   Perhaps instead of ignoring the buffer as you have done here
   we schedule work with a timeout and if the timeout expires then
   this triggers a reset/reap routine.

- Since Linux allocates a buffer on the APSS side, you can't have a
   situation where firmware can indefinitely hold memory.

- APSS is in effect the bus master here since it can assert/deassert
   RESET lines to the firmware, can control regulators and clocks.

So we should have some kind of watchdog logic here.

As alluded to above, what exactly do you do if firmware never returns a 
buffer ? Accept memory leak on the APSS side ?

Rather we should agree when it is appropriate to run a watchdog routine to

1. Timeout firmware not returning a buffer
2. Put the iris/venus hardware into reset
3. Reap leaked memory
4. Restart

I see we have IRQ based watchdog logic but, I don't see that it reaps 
memory.

In any case we should have the ability to reset iris and reclaim/reap 
memory in this type of situation.

Perhaps I'm off on a rant here but, this seems like a problem we should 
address with a more comprehensive solution.

---
bod

