Return-Path: <stable+bounces-32251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E245788B06A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118791C3D0F6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7C224DB;
	Mon, 25 Mar 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lyVdiL5w"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF491C6A6
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396110; cv=none; b=QElOVypeZDXOMAzl3wK3MNnhVvy//khmq9qPsYGwIh1Jol+3Wmj1m7BFLTFwF1dAys5EsaRUjsPfwub+gaiEnPBfyc4DScRvtsPmJbGi8zO03GpEXfvZ5zIwlligrhfd0YUkA//5XrggGvJWZdLRqd3LBslBe643yKoY5BHRefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396110; c=relaxed/simple;
	bh=KClceAiTx50PmEj45jOUs8Pxb/WPzW5nVVqPr0ifJXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT82bMuefwkEPXk6JdOldnkQSeY3JEsmBjmAC7G6KseHRl/GKxfYKum1AYT4DJkx3c7YAAKli6Ekd33T701EeZCgIFqj/dU2+beyxgzASairlLyyKnWcMOGJBMiSaaLcM203UIBg3AOe86wWc9WEQNydovtAaRbOOF/bXCnokXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lyVdiL5w; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46cca2a979so277952566b.3
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711396106; x=1712000906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S6rqeKaNGqBYxhYJKK3a8zmfD1iSFSJpl8wBKkIyphM=;
        b=lyVdiL5w6TttTfJMu2eKLrfUJhiAMpGKOL562z7dYIQ132tMin9FbfGAQ4HupthMwv
         M+2HcrdTd9rLZYiH76luBptohFsfLZxxvKqLD49LLkUuiG2Pu18AGC++FvDoiArkJJgs
         QM6n5Dq+af2YLToBRLmij1zS0YhNQVPcJb23CjwyRFLfxwlNj5uPADtFVHoWhbaFk+r5
         t/UhiXU+LIKPmxNrtpp0BubslZ8CKYIlc5Pns+gyZxdg2ApGtwLUK1POUKLMLr9srcCK
         wcWQ+ad+ChY1mNRQyW3KJCF8T+2UvLYhmZ8OaKpxmfGVVzwcLbGoQlvoJSDM+QAWuK2C
         dgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396106; x=1712000906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6rqeKaNGqBYxhYJKK3a8zmfD1iSFSJpl8wBKkIyphM=;
        b=kMhVcuDwUAMfWJhJsETNEx1tBsstOoud/qLFnnKHGJbwfa9UULZJHG+sh5PdokCmN4
         ApY2Y1GBmYYRe7XIvqhy1PNVUy4AQB3MEi7XnP57ooXr4QNpkUsK15RrJogHddMu/trO
         ugkoklWnOp9YUGXC0I9ANanjSDDJLeiZj08UF6Ui0pz/XlIgW+IVz3ZHoHhkFrrL0xa8
         BZ2XZk81wyfdLlP5mPzMYC2ZL4YxiIETdydvRtlpzFHk5KF3a3+jU5FCioymm9OkIUwa
         vDxVA4RBZqvAKFCky55Fm7JkCi2/ZIi0Gmru3yZ0WTT7FBQWT2gm7kqHWyEGSdsPXYFN
         4q8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQcWiklusnvmNHrff1UJZDWcWG8sqUP6knfutp83EWy6KZYr3fojlBi8Q+ekt5/2lwOvtD3y29xEV4iuhzWTJm+qps32d2
X-Gm-Message-State: AOJu0YyswjnbmmS8dds8RtQCPkF55HQbvMgb9qCQRf7O0iWXRENXXd+k
	g1i9eOM4Dr5yrutU2wWLMN6738ML4Gwk9/zd64veezRNc9Cg1ca6Y8cmtD43w0s=
X-Google-Smtp-Source: AGHT+IHrYqHgrd0OjrA4X1d+flYknuft+irR9Y0HPMjL6dRJwgrza42uiyXAM5kq8hxb2PXhOq9RWQ==
X-Received: by 2002:a50:99d6:0:b0:568:a792:276 with SMTP id n22-20020a5099d6000000b00568a7920276mr7023386edb.7.1711396106143;
        Mon, 25 Mar 2024 12:48:26 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id t25-20020a056402241900b0056bd13ce50esm3259265eda.44.2024.03.25.12.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:48:25 -0700 (PDT)
Message-ID: <2311d5e6-8ef4-4ce3-8a6a-7731f819b05e@linaro.org>
Date: Mon, 25 Mar 2024 20:48:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] QCM2290 LMH
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org,
 Loic Poulain <loic.poulain@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.03.2024 8:08 PM, Nícolas F. R. A. Prado wrote:
> On Sat, Mar 09, 2024 at 02:15:01PM +0100, Konrad Dybcio wrote:
>> Wire up LMH on QCM2290 and fix a bad bug while at it.
>>
>> P1-2 for thermal, P3 for qcom
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Changes in v2:
>> - Pick up tags
>> - Fix a couple typos in commit messages
>> - Drop stray msm8998 binding addition
>> - Link to v1: https://lore.kernel.org/r/20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org
>>
>> ---
>> Konrad Dybcio (2):
>>       dt-bindings: thermal: lmh: Add QCM2290 compatible
>>       thermal: qcom: lmh: Check for SCM availability at probe
>>
>> Loic Poulain (1):
>>       arm64: dts: qcom: qcm2290: Add LMH node
>>
>>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
>>  drivers/thermal/qcom/lmh.c                              |  3 +++
>>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> Hi,
> 
> I've started tracking the results of 'make dtbs_check' on linux-next, and I've
> noticed that on today's next, next-20240320, there's a new warning coming from
> this. The reason is that the DT change has landed, but the binding has not,
> since it goes through a separate tree. I thought the binding was supposed to
> always land before the driver and DT that make use of it, but looking through
> the dt-binding documentation pages I couldn't find anything confirming or
> denying that.

Yes, that's the ideal way of things happening..

> 
> I expect this to happen again in the future, which is why I'm reaching out to
> understand better how to deal with this kind of situation.

..but due to the kernel dev process, doing that across multiple trees would
either require constant agreements on immutable branches containing bindings,
mixing patches across trees, or delaying dts changes by a cycle or so

Konrad 

