Return-Path: <stable+bounces-152725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62767ADB64D
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CA53B8952
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A52857FA;
	Mon, 16 Jun 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCS/55hN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187848615A
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090101; cv=none; b=EHRO1BgDq5gJBNNN+zaX2/PP5071GWzaQyOdWyCYJG05QaNAZouE/RGLoJ1g6FwCbM7Znn1xuiBPe6ALhsS+ttw+SzFbCSXg+F6F7ULODuxMclRWa1uPUBi9Ch5py8WjS9QKh4idquvSts3GJL32RrMX1LECUKKJLEtcNa2oUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090101; c=relaxed/simple;
	bh=hRBgOq4APKw2y8RYVbZ1gYWD7szlzHz0G09X13KV7qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+WSunX7PNShMGzjI8XjF6eiMlmBF/vlbQiB6btFM8Ifgldhk7kP7KjK2xi7MHhsEbjFp9RM+EKrLkwW8yp6/InRF6mS8vyKXHKy42XQJ+RaS9f/vinDOTkUc0pMwjkulACsxfsNlAk35yfcI71jQD22gwYZljSe5rDU32EDrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCS/55hN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4531e146a24so29306745e9.0
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750090098; x=1750694898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5x30H0yIc6HW7ib5oxYVmHAekW/AqIC/RAZDFhWWGM=;
        b=ZCS/55hNlkd4E3ABvHjuL2k/lcwa2B72q4u7hhnQDvpvn5rQb4ypwJepn6GjeruMDR
         ypH3+YuNB5EpOlmBM6XtfT1TiWWNIpWtkOxmAOKG6Ieg74vZE1gPgfKzp5GCnCzII1Kn
         nWKzriCvHrjkirJ9PAt4QfZAmqc23faMQ928lyZp0dBtZERIkijwrshUPkqATqWTyIra
         /bdHrmJs0bcmjqWUTK5h/C+dTgk2yVsjAGIwMu+gOI/hL7eQdB7d/va0CBj+8tdeF9sp
         kMzRyTJxiUNBKIX63zjt/74sWJxH0wGuA26ucbx5/uaWFo2DX2o0eY+kbHvwGJl+zeL5
         NnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090098; x=1750694898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5x30H0yIc6HW7ib5oxYVmHAekW/AqIC/RAZDFhWWGM=;
        b=c7BcncP+1c5L10T7YrzGgcH1mQxFvLGFD4NPYNvTa0BxlWxX3d4Wdh9tfEmk4JHi2e
         M9RDkkdo/fv5ZtzVN4rdGbMoTwjRGDBWmhlgFE5Bvp370YHziz15CSZYaUkJ0C3w7hZ3
         x1RhtM3lV8vKBKrC3hD6+0yozd7Nwl4OfLUdwxC/pueWoCAeG8ZKscBM0KUV8QGX6Yv6
         CIAaMHRmQDExM17vDrz7t0tVELx/I9coYvvnaGissKNUIAyBQgvv01GtR64hTR1G4vst
         nC+OGQ1cl2mTyFrrOfa7rBGtXoZC4rgMGPR+e4lHcbY9TtLvEwzQx2HSzPRdGpgVB+eq
         qM3g==
X-Forwarded-Encrypted: i=1; AJvYcCVnVQFKNRHneDg14gqwV7EYQM5P/XfTutfkWBnw84yukCjUQIoEvosNV98Z/YHO7H00ldt1F3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYiDpbVdfiwt37cBZpS27iLWT90U555SxGdc4VYS9R0Z8SuwMx
	11+W84QbYzpkLsMO9fy1AaRZWB0kGv2wbCkqo0UrhRRNRbAPgHZ77RR37jKFmynr0As=
X-Gm-Gg: ASbGncsuz6qCaQ6cwgieqqF1VQc7EHebtPTusYz+pZHnD2yv0JuaZvx04XNoHnpGnOK
	I2Kl1tbJlIfhaKqYXUPeFhoYPk+P6yv1BCiErpebuS/3ubILYofRBcJfQF/nLi9czNpG9q/UvqV
	+j2h6jEXzGyXZSzBFzhpKJ281WZbdzp6uy0qXHlV5940WTFnPHl16uytipwCB3RZNSMkQdy+mgT
	okEXOEkjFpHYqLP79XJd5BPO6rIkbOIR/mNbXHy5JlBkxYFst34WhZ/Up8NMshTovOwt40HtUcm
	Ddi4of31D3LEwUuq6CxWyz0FA5wQc9oc60FABr32ZpGKL0cXW8q+0dUhU9ArtKX8LRlKA98osnM
	JlB1c2i/1I7ilfw5RpBxTQbf20XY=
X-Google-Smtp-Source: AGHT+IFprAWkawH42OL4Sz9tt4KKrYG6bZs86pGWjUVLMBCA8Vbyzc5s6Wod8JkjjmaDSK8H+pKM+w==
X-Received: by 2002:a05:600c:500d:b0:450:cabd:160 with SMTP id 5b1f17b1804b1-4533ca46532mr100521395e9.3.1750090098474;
        Mon, 16 Jun 2025 09:08:18 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm147563205e9.4.2025.06.16.09.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:08:18 -0700 (PDT)
Message-ID: <2df8eeec-406d-4911-9c1b-1aafcc8be8d5@linaro.org>
Date: Mon, 16 Jun 2025 17:08:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: qcom: camss: vfe: Fix registration sequencing
 bug
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Johan Hovold <johan@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Depeng Shao <quic_depengs@quicinc.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20250612-linux-next-25-05-30-daily-reviews-v1-0-88ba033a9a03@linaro.org>
 <20250612-linux-next-25-05-30-daily-reviews-v1-2-88ba033a9a03@linaro.org>
 <c90a5fd3-f52e-4103-a979-7f155733bb59@linaro.org>
 <21bc46d0-7e11-48d3-a09d-5e55e96ca122@linaro.org>
 <fe113f83-fbbd-4e3b-8b42-a4f50c7c7489@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <fe113f83-fbbd-4e3b-8b42-a4f50c7c7489@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/06/2025 16:00, Vladimir Zapolskiy wrote:
> Hi Bryan.
> 
> On 6/16/25 17:09, Bryan O'Donoghue wrote:
>> On 13/06/2025 10:13, Vladimir Zapolskiy wrote:
>>>
>>> Per se this concurrent execution shall not lead to the encountered bug,
>>
>> What does that mean ? Please re-read the commit log, the analysis is all
>> there.
> 
> The concurrent execution does not state a problem, moreover it's a feature
> of operating systems.

I don't quite understand what your objection is.

I'm informing the reader of the commit log that one function may execute 
in parallel to another function, this is not so with every function and 
is root-cause of the error.


>>> both an initialization of media entity pads by media_entity_pads_init()
>>> and a registration of a v4l2 devnode inside msm_video_register() are
>>> done under in a proper sequence, aren't they?
>>
>> No, I clearly haven't explained this clearly enough in the commit log.
>>
>> vfe0_rdi0 == /dev/video0 is complete. vfe0_rdi1 is not complete there is
>> no /dev/video1 in user-space.
> 
> Please let me ask for a few improvements to the commit message of the next
> version of the fix.
> 
> Te information like "vfe0_rdi0 == /dev/video0" etc. above vaguely assumes
> so much of the context
Sure but this is a _response_ email to you and you know what vfe0_rdi0 is.

The statement doesn't appear in the commit log.

---
bod

