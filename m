Return-Path: <stable+bounces-137019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355AAA0791
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D948422A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB192BD58F;
	Tue, 29 Apr 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtY3vEhV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDE84E1C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919799; cv=none; b=I2jWnTMB+u8n1DuEhVNuC9ekfdmgECJOeIO9MDBw8G7h/vioyi7Oc/qX7ILcIJEqKdzt6yjERVVbKEpy1XGaVYTlqMlXfg1/mno+8sgXwzO3ar+2QjkP5QY+InLzF7qiIWBcEDDI7kD940fCw9vmJDo+5NUCaaPHm+oyC+wj4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919799; c=relaxed/simple;
	bh=Q09MnUkSmU1kJNLenRmUBDgMxvF4hfafHFPtdjI5pGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2jDNMUZVYK75T9laOR4sVsk90gl7Qz6CtLisVtgP/eoLaGJTuc2xji2cFNz/2SyPZwq89tgRdUfy+P6Ks9m4i03VBwgGDVm6hj47oBbpgGDwOM/2+g22e7smaI27AWOJL1ZJSFFW9qOHz3hFoIPtJ7T8pygi+/VLNUUDnvNFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtY3vEhV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-440685d6afcso55215575e9.0
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745919796; x=1746524596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QocFhOILZu7H7ECqeWVM5tXMYpo00r6XD7J/dg59I9Y=;
        b=vtY3vEhVg/WuDXGOPK191tJLc94YEsA3kv1WKoUoR2ernmHmjHb4D6n4xvGvx4B2/E
         vmbtMEdD/bCm98XbezCRoUUNZ0u+/ewIcAS7G2/nHCLy670aRyxiXIx5YlaG8MrOk+Xw
         2NqolbYVbc0BjOdXXnSONq/vvzCQFLmiYzR7EiW4LBiKrwklybvtv+ZCFIXoUz6XhWiT
         yja+yxzeO+hbT3J6/bbgEwN4bqJizF2W67KM/wk7yKLxvYfYP+kSHk6AZJqN1HFVwvWG
         qMazPW4IvzcqkdUivFMvhHcQYL1toOyqdDYEtSzfcuRx2lNGnpju90hJ1RjjaxWNf16W
         4J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745919796; x=1746524596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QocFhOILZu7H7ECqeWVM5tXMYpo00r6XD7J/dg59I9Y=;
        b=Zr6+rk0PbUVw7B5wPtXg3q6ByJJyw+BtkBpe9Cjze2TyQP06NewJZjSTZZNTdJGCzR
         4JZbadYXZ892I/xXNXSmapDuYLf/dybjA1VhHbyAhMK0f64OwchxPrdkrRp5uNP8LdSm
         Zx8J2XMPUWW7PLqz2AGZQqJC9f0O5CrtqCyt0q34wQDpPXjauVT6JN8HCz5Huy8Ta2/d
         JlexGDSLnMRFH+xVAxsSxvVmEhO892qE1Wgy23uH9PEyt1dyy/yX6cfteR+moRd28o69
         XU9B0V0R3RI8sfKXmDzH8VvygH0Bss38q44e3Qz84IjJnU0HSekza3bQoVPao/191Ker
         TA0g==
X-Forwarded-Encrypted: i=1; AJvYcCXhBNwftk7nrSPGv6kTApSNIEnTEMM+bSd9FsO2BrHh2Y20omhypDhNQjiF7FH7v3wiH60wXc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TyuVhMbsNa4mfuzjlxujzN4JunjgdZB+v6PRWtsrrsyKmCWD
	00m5wU+n/TAf3welagTw0EAVm6RN8gw/nEWDpfFpZUUYqPL3e/PK+yb9K7XVd4s=
X-Gm-Gg: ASbGncukX9v8bfx6ZYASXq8fncIXDbpMZoM+CRdEkA2ErHgA93cbw60sFPxwMOfEEU6
	tWEQlagITqFHbg86SatjNlE16/UJd/ruEe+Ef5L8U+tcmLgYM8oKlJuQogHk1CD4LZWOXoq/8f+
	qzltWI+awnutm4WuONnmFdV82fSov+tJ6JZmGZFcbUWn7IEMEzzL6xhA84CezUet77hyzMjxOcQ
	H4RL+hi/NDMEUrXgyGM39JP+G5y7V2xsjfEouj7exLUENINAwynugXVrzPy4UJm7LcAENR3QRW+
	M2mCOJ7wUZz/VtKdrRQaZhAkiLujTmIqpP0ZAERhmCzKBtUPigT1XmLtD0FaYmFYYMRmkvcgofu
	COyyEsQ==
X-Google-Smtp-Source: AGHT+IEuROoKfgnl+2smmGlqkdhXYephIa2Ni3VkuAXlZjKZuio03hMlbFyEqG6IUR7gw04Cbkx2FA==
X-Received: by 2002:a05:600c:83ce:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-440ab8460fcmr97962945e9.21.1745919796144;
        Tue, 29 Apr 2025 02:43:16 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a52f8915sm156545955e9.7.2025.04.29.02.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:43:15 -0700 (PDT)
Message-ID: <a056266e-612d-4abf-916f-3db49b00dbde@linaro.org>
Date: Tue, 29 Apr 2025 10:43:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] media: iris: Skip destroying internal buffer if
 not dequeued
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org,
 20250424-qcs8300_iris-v5-0-f118f505c300@quicinc.com, stable@vger.kernel.org
References: <20250428-qcom-iris-hevc-vp9-v2-0-3a6013ecb8a5@quicinc.com>
 <20250428-qcom-iris-hevc-vp9-v2-1-3a6013ecb8a5@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250428-qcom-iris-hevc-vp9-v2-1-3a6013ecb8a5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/04/2025 10:28, Dikshita Agarwal wrote:
> +			/*
> +			 * during stream on, skip destroying internal(DPB) buffer
> +			 * if firmware did not return it.
> +			 * during close, destroy all buffers irrespectively.
> +			 */
> +			if (!force && buf->attr & BUF_ATTR_QUEUED)
> +				continue;
> +

What's the effect of the firmware not having dequeued the buffer though ?

My main concern here is APSS and firmware have a different view of DMA 
memory.

We release on the APSS side but firmware has not.

Surely failure to release buffers by the time we get to Linux::close() 
is a failure of the software contract sufficient to require resetting 
the firmware ?

i.e. we release memory on the APSS side but firmware writes into it 
anyway ...

?

---
bod

