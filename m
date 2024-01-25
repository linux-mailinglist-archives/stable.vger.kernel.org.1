Return-Path: <stable+bounces-15792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDFB83C031
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 12:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DBB1C2349A
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2234F5EB;
	Thu, 25 Jan 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgLBp3qM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C012C689
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179656; cv=none; b=TIMA4Wz6n+z99i0qhofKNpUguFkJk2BV5yCa8tXZF44N1+3RXBBQ3Z+g5HjOrB3g++nSBC7kI+v5NcAUjIhiKyccwyoyKHXxt+5WG2kA71R13tVOjpaQBMIjKMvYoV9dBUCgD5mm0kw+MLIuuV2UzontDxYFGQZGIR26FvjDEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179656; c=relaxed/simple;
	bh=qJIg0nvxYKMBKmg9Lhg6zXZeiFWgXvu5JEPYYVLhYxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY1x31+cjjG8M/haNiYoSynojQyh0wZHf8hFZAg5Ymp9jyz/6RcjOhrrGGy2wQTDIakOSxMu6eWhljKYRArdqbpsfarAT6tAEOguuR8KTvLYcc48AJwXHKBvrgt1dyvvokKRI+MZRtAICY84Ao8hbv59bMhVYKt6DEfYCae2dZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bgLBp3qM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-559f92bf7b6so1246185a12.0
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 02:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706179653; x=1706784453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUFAOyfRItBatkmptoSKoqwFpaIM1BAzd3p4SNYrB6U=;
        b=bgLBp3qMDn/NKigV0lqh9fP3GrnOCCLK+I9v+MA76a6JDT9pvrLtKvwHUPECtvDwWO
         MDYqA4cyO9rk6mV5xngQZ2n3LEO4IIjuH+Pz0vWeOMUZmeEQariM2AKU/TY+Tt5KqFsp
         cjiHe9VGCpm9UngKeQr+J2RcJ1USYxETB79iZ55u9HweXcmWl8nrlAmyn7VDGIk8prrC
         JBF5n7ZtoGNvUhndyrkvsnFixm6s27PzkEiQqSsBgldQI86x6xxVVSxzSHm6pP6pYcDo
         n12QcSzCkOOuBOlLmCa4vDJ4vmqQsL4Y1+SHPjMlIEoF6hlc8EQc/ZNGC3UaAyuQuGOK
         eSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706179653; x=1706784453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUFAOyfRItBatkmptoSKoqwFpaIM1BAzd3p4SNYrB6U=;
        b=s9GLzxmzAvK+pkPf1mq1F05XBDKygzVEMX+34oSwIqSiWjpXIPoMwie1m1/wkPxPn3
         jmwxDsNiIWMa3E9SYsIRjKRm7FFnn3r8Vj3Dbjhdt3lukWhTpWhub4B0N4xGkayKz06I
         OqkUQMcCl+cr6uHsLAT9zxrlMy/CxNaSKqfy6ZjO37ZXm6resEQ5aaE9ZvtGfQd+IPY+
         vFiCQozDPUDDe+XirquNGEBJeJEpR64qDrW2efrqhHyT36JnO8dXXZXdP+DA7ubQblqz
         rZGRW9K9qzSZVt927ib9LLRv0/jow2Og5GXSdHbH61SgLhUwPENUwMsG6cRxBMY/dur7
         ZjpA==
X-Gm-Message-State: AOJu0YyxDgWt422URGHd6eLNITSLvE5xRWIov8ZvaQCkLSjtp0PeDhrA
	Uy6zBv7gBK6nKgvCCM7uMv3jTOm6U0sWXMPa8e2kFSU0s7VT5RRdEJ97M2MO92k=
X-Google-Smtp-Source: AGHT+IGGj4vSRzfftcEVG6rM3xZqRkxzdcFtwoOvKC5XBbaTa6FBjakxOvxN8g0kvbtWCTFNOwVYgw==
X-Received: by 2002:aa7:c158:0:b0:55d:1615:4bd7 with SMTP id r24-20020aa7c158000000b0055d16154bd7mr9510edp.6.1706179653252;
        Thu, 25 Jan 2024 02:47:33 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id ez15-20020a056402450f00b0055a82fe01cdsm6389475edb.67.2024.01.25.02.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 02:47:32 -0800 (PST)
Message-ID: <8819b406-34a4-48ba-8d69-25cb4cbcf3e1@linaro.org>
Date: Thu, 25 Jan 2024 11:47:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port
 mapping
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
 <20240124164505.293202-2-krzysztof.kozlowski@linaro.org>
 <d1cde782-c223-4400-a129-18e63a10a415@linaro.org>
 <3f03ebc4-c67a-40cb-8863-d9c800af54fa@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3f03ebc4-c67a-40cb-8863-d9c800af54fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/25/24 11:43, Krzysztof Kozlowski wrote:
> On 25/01/2024 10:59, Konrad Dybcio wrote:
>>
>>
>> On 1/24/24 17:45, Krzysztof Kozlowski wrote:
>>> WCD9385 audio codec TX port mapping was copied form HDK8450, but in fact
>>> it is offset by one.  Correct it to fix recording via analogue
>>> microphones.
>>>
>>> The change is based on QRD8550 and should be correct here as well, but
>>> was not tested on MTP8550.
>>
>> Would this not be codec-and-not-board-specific, anyway?
> 
> Yes, indeed, it should be.

Should we move this to the driver and drop the then-uselesss
dt property?

Konrad

