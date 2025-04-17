Return-Path: <stable+bounces-132929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11022A91687
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816DC1907E9C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27689225787;
	Thu, 17 Apr 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H03mvwnR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425102185BE
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878908; cv=none; b=bx0wMyZT0CrsijO7GX4/QXdZ5/uIT486LCWtQxPgOw4eEtT1MTqeoJkCwWMkXuFkfjLTwCOzhojIhPLo4kz61QW7KRZ026q+nqdfqbpvspYzZfLl9Kib+na2+lLKOWAqeJIfg+YS1uxhpeTq7zi2AgNyax0gqvAc1r8UWobgygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878908; c=relaxed/simple;
	bh=v7Beki1wx0pFxToSPLRFkM034OQKjMUf3qDwIahY5NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clcDKybG5IOsm+ngDfvQd4gV0vGHz5/lMvcNUlZl6Y5erIz5MflzOvdUR7mefN9Vadqtn4Bx6/LSeVw4XVUPeeiVIcmE01WLJ6OzPpefRGBMArRcj8+8+koXQF4oSj6O8CC7PxUjXH97morE8P5evojZXNg2YHADhTG+rYaZ7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H03mvwnR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so3219455e9.1
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744878904; x=1745483704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bFwlWCS6Kk0bCLYBtfT5ejGrulPH1qXFNrU5XO5/8E=;
        b=H03mvwnRiYcbZYS1DZNrmt5AS6xuF+vkG/VOBFyTlmX0CzDZdfOZqlT4mdWIHGd+7H
         u8s4w0fEXI53qwD4GNx4ONdXdvU/KRbIsV9YdbfdbnX2SJM+i8xnfLvWdtT4IX8CPv8t
         5URndPnbDjPuip5eXJ/JiG3J0m4lCev9Twjjpfmrm1emLomRMlJ1Fa1vMN2S0ZTsXLn5
         G1tpCVHswCqY7NwyDzvVCiLztkjT0QmdZihrDtB5P5/3/+T05VxWxmAleWU1pmhMD8Po
         r//58OPVdZQgwkC/7X4akrwL0vUnjiGXlxRmNHRh2cn/Om98YJ+NZwRFBG3md7eFDaBk
         cExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744878904; x=1745483704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bFwlWCS6Kk0bCLYBtfT5ejGrulPH1qXFNrU5XO5/8E=;
        b=vKFyrJOQMdhtG0L1cbv4qPxci3cc74cGQ/jwldRIzM7QVw21+ffvUVvYAgyHQih2YB
         0v9duXxCCczIWoRvNRJIUigIwoKT3/PF5IiI1wRgoXz/oe3I62ZGAVFB/J5k/SJvI53d
         aw5aJCUlrLHTtDW/qcF1aIRMv5fUTn0SH5K2o2bkskOXV8ljIKOp0lj43/PLcy7vtQN/
         Vs4Silj3eM6t8r/iKjUcG6kDAXMR/+8pdl+IwVvK3laYAp2s5mBLiNm8hsOZIW5zb3vo
         D18537aZAdwSYPbQ4Xwbotrv9iuXD2VslfIROctmmGN7aOU1xN60HeI+O0/0SsiWWbW6
         qUug==
X-Forwarded-Encrypted: i=1; AJvYcCXBkTxdkOCH/2q2nNF4zqY8BbmPRwuhFAq/P2WcxubAj+DkGFdjQjrfho77PkgXFGD5cJDGQRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EjttQ49S6GQF6J5oVxLY5AN/BtnAlFyH8Qm2nB8e57Gtph+6
	CclK7An5bMQJMifKV0am5fdw45zHQmAGHuH08DcmeAZp1N2vJx+/JGHp0g9lV/k=
X-Gm-Gg: ASbGncsdOINqvQnUG8CPL5Xr9KcLcFYDETQiys+NieZrsMQDwH0RiDsD7Ye3PS0QQEC
	QPq7A4j0inIxdiqxWJRSD1YExjBqFWdAimeTlv/E1RTle5N03F537CO5+QM7X5U+KSClOi4LK/o
	tpFH3uBx6TL0bLGPEgg+aT3jGdIr/xbHGuuGrg66enVD0hx2rxqfzNY3G3sF8okdd+EV+NjcRdl
	MoCuMjWzON6ozlwqFSuRamOpUgEdWLgVNZLtTyC0fA0FOG6w/DNTKGWmw6D9WQfCDuEEVeHp+8Y
	ONqq3zDGi5Y9KTcuffz8xlR5GoeMWzDeACRtoHXubdS3DWwxWMcpe0yBWLxVJqCQa6RRcVIqcBk
	tqio47g==
X-Google-Smtp-Source: AGHT+IEB3uiv9d12q/gsfhCkq1pih+E/njAdV0CZuqhp7+y+hbWHDbSN03BGf2xjAj3/8S3g6KwzKA==
X-Received: by 2002:a05:600c:5127:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-4406351b084mr16091615e9.10.1744878904468;
        Thu, 17 Apr 2025 01:35:04 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ee411dd02sm4256434f8f.55.2025.04.17.01.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:35:04 -0700 (PDT)
Message-ID: <b9e232c9-ae06-42f1-9fca-a8c5d7d64a86@linaro.org>
Date: Thu, 17 Apr 2025 09:35:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] media: iris: Skip destroying internal buffer if not
 dequeued
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
 <137c68d5-36c5-4977-921b-e4b07b22113c@linaro.org>
 <96bd9ffa-94f6-0d1f-d050-5bec13b3328f@quicinc.com>
 <70a630cb-06ad-403c-b2e2-ae6d26e0877e@linaro.org>
 <30ebc1b7-5746-59a3-0155-7a7870544622@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <30ebc1b7-5746-59a3-0155-7a7870544622@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2025 17:40, Dikshita Agarwal wrote:
> 
> On 4/16/2025 5:40 PM, Bryan O'Donoghue wrote:
>> On 15/04/2025 05:58, Dikshita Agarwal wrote:
>>> Although firmware makes sure that during session close, all buffers are
>>> returned to driver and driver will release them but still we shouldn't rely
>>> for this on firmware and should handle in driver.
>>> Will fix this in next patch set.
>> Shouldn't we reset iris in this case ?
>>
> Not required.

OK sure.

Could you at least add an error message on close() if any buffer is not 
released ?

That way we can "trust but verify". What makes me suspicious is that we 
have one instance where a buffer hasn't been released which we expected 
to have been released - that may be reasons for that which we can't 
interrogate from APSS - fine but, then how can we be sure the software 
contract on close() is respected ?

So yes, I accept what you say that its not required but for peace of 
mind we should at the very least be noisy on close() about unreleased 
buffers and if we start to see kernel logs about unreleased bufs we 
should revisit resetting firmware.

---
bod

