Return-Path: <stable+bounces-60422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6425D933B50
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957301C21E65
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F317F368;
	Wed, 17 Jul 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T16oisUv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB314AD20
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212987; cv=none; b=HYo7PopumUzr5joP91s12BaThnGEcRtjMHkO0/YeY2O9DO3vcBFU8nQV3lEWaVfF9qIKLKdfJRkqNPXagYmK/+wj4CCjK1CWwGMfysf4SPz28VSqr82pc/V+D5NimvuUuTJO0loexsldWMbfj75G0PJTc/X+W5/ge5zQvNOIIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212987; c=relaxed/simple;
	bh=jDYIVpkI2wrskYjogiULwXKO7ktZv1aJ7DZ3Nb1BvBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6JHWrdkH5iBEQne2Oe5WllXIkHafwOyJ3OqeYq2tmFVWcEjCAepKxmJLEPvaLB8V/0Ju57iLEtY4v4LHDm/mxBSVViwIIOiskv+GNZKoDRFYIOoL88Q2cZB2LNJ0FL4vz7GCvBAyjEU0iSsUAQBi9PyjT1p3glUI1IIRuxFPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T16oisUv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c349bb81so668218266b.3
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721212984; x=1721817784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDYIVpkI2wrskYjogiULwXKO7ktZv1aJ7DZ3Nb1BvBc=;
        b=T16oisUvxmtCSzkNI7xBOX0/YgRwBRxzjro5YbOIduudpSw7joiQQK5ve4r9rm+H+k
         rNCFDnhBwBnS9YRhh4Hlnc0uvvzlHh+mJwSNohs1hnooYWoTk7+5oGgDqLCYI1zZVAVU
         FzNR7UT6FCU1b9ArL2gIaj1vuYhL5P+cniBnpJ7FlXzu36h/O7A98a2spIpUR7D6CrGW
         hb4AC7l7WaiEa5ZKesmmoagqBVXNMe6TznlOhPIqowiH93uKfzK4IVH4uNYaYQMNrVbi
         JXJk3sfvZRrBPJeJvEtHDZ75MtB0+mf4InRhtXZKY+JR855ZByzbgknqhS2CjqW//gJv
         meqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721212984; x=1721817784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDYIVpkI2wrskYjogiULwXKO7ktZv1aJ7DZ3Nb1BvBc=;
        b=p63UJsfgc7Aq0oECjbixyE0W0OuiAOZUWUkwxBXpklAi5Uv2k2U7UkW1skLQe0wOzL
         Rb9HMnd0dYyAT9ImRUT0KeI9xaCGzEt18ZPmnbxieKF2+xyoFEXSQym/rn5B6DH34p4O
         XQ/SBU/WIWqh/mWYhTOHtmsMiZ7cccqsN3JLX4dmumXpS0vpQ5OQpVZkw5AjhexzkRnZ
         BDEZXs5BA5dgX7z9jCU4kpNEoERke5Gbt/EfpjKSuk4Dz0spW4XisO3lrxGYmPpqzG2t
         nwg1yzfwoy8dM1SOYzmvQ6Ocfx94Z3zHxzAHztyxr7KjBnB3bZJ5wDTMCwgRfHJfpu5d
         4+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWrtonm5MLOjm89qA1H3krgc6DRZS8eefPRJM1r93WHrqaPHxBSXfQXm3tmFQgVYoOEe3oFNW/ebkA79PqnGk8uPYAjYJKV
X-Gm-Message-State: AOJu0YzXa+c32Vmt0KoCktNdDZ1Ka28Lht5MkLJRBm6XuW6GIVHT1+QI
	A/mTwEb71Pz2gxM/BKGDiNh0HDVvqCeJM/R7qwsc77uUzOyo4Ng8lNNAR4WVQmY=
X-Google-Smtp-Source: AGHT+IFACSw0wcYk59/gj6GZBVlzplPmhNUj87R9Hfdq8QZPBr1o+WVmHKWfiYT/gpdP86UdBlCbXQ==
X-Received: by 2002:a17:906:2b4a:b0:a75:25ff:550d with SMTP id a640c23a62f3a-a7a011557b2mr86405166b.26.1721212984397;
        Wed, 17 Jul 2024 03:43:04 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f27cesm429797366b.124.2024.07.17.03.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 03:43:03 -0700 (PDT)
Message-ID: <2d8ac288-da60-490a-a6ac-ebe524e3fc21@linaro.org>
Date: Wed, 17 Jul 2024 11:43:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: qcom: camss: Remove use_count guard in
 stop_streaming
To: Johan Hovold <johan@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Milen Mitkov <quic_mmitkov@quicinc.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
References: <20240716-linux-next-24-07-13-camss-fixes-v2-0-e60c9f6742f2@linaro.org>
 <20240716-linux-next-24-07-13-camss-fixes-v2-1-e60c9f6742f2@linaro.org>
 <ZpeJmWTfZGUXsc7K@hovoldconsulting.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZpeJmWTfZGUXsc7K@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 10:06, Johan Hovold wrote:
>> The use of use_count like this is a bit hacky and right now breaks regular
>> usage of CAMSS for a single stream case. As an example the "qcam"
>> application in libcamera will fail with an -EBUSY result on stream stop and
>> cannot then subsequently be restarted.
> No, stopping qcam results in the splat below, and then it cannot be
> started again and any attempts to do so fails with -EBUSY.

I thought that's what I said.

Let me reword the commit log with your sentence included directly :)

---
bod

