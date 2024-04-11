Return-Path: <stable+bounces-38056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BCA8A09BD
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FEF2827DB
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0813DB87;
	Thu, 11 Apr 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaQtArRg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD513B5BA
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820453; cv=none; b=M3lNlEU96c7Zt5a4r3lAFlxFVRYSLC+hdo3s1buhyp0ZyH62fm+6Gz4e7nv3rO5Il1P7wtSvq85AVSRf5Bn4NKzjpMo57/tKLBsMJ749mLntrBuCtYRSv+66UcXy+Leegy85Q2JxJdn5BDvn3xK+87pSV94M1VJ9wE4XNc3mSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820453; c=relaxed/simple;
	bh=VdYNO/Z6w0MPevb0U7Q7QEUNgXykANHq6IoIUf/XxIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUFo4DY8F0eFDUx+vfpUBwMW58IYnzylOiWJofL02wHLpaHonIIlfkgE2pExMgl9umNvJA4X4FuFlwyPqDIjqnp3++wLbaiwb0l810DM6fREHarkv9ItO/A3EvwMX8KJoH/HK1TQETJan1LJ262H8rJ9zjn6v+4nfg0yDWpYaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IaQtArRg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-417da6ca440so2067685e9.1
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712820450; x=1713425250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WW0583WXjUX1inScW7BvGMTj2v1XmyEKPqSeb1lw+3k=;
        b=IaQtArRg37H2MiCPzNHZNvfk0PkbmPS09oOjttwoNBxfEEcJKeLPGaFmW1G9GB4UGk
         pS815s8M/TJaIf4eW6VIcOrpORyUalLk+EmxTn5c+7Ihha3FnWleOxJ3e5YPqrXWXEb/
         9OKtTRf0bz1eRJ27E+mtTX9fWCChO73qlY/moicVJehMIi9MQIHgv3wwQ/95TBz1dXlU
         W9Go72CS89botbSY8Z4m3vGu4wIZR0GAchoAqpooLuQjjYqJ8xREE7roQqAKK/UPQXVM
         gy9/NK1u68P+s2V1qGJ4OqeK4z6YASHHRTLwAh/JRNMUXShaMwXgC9N9i4YF8B0PwzHd
         JRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820450; x=1713425250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW0583WXjUX1inScW7BvGMTj2v1XmyEKPqSeb1lw+3k=;
        b=E1eASckr83uouXNDMiOWArAMWrotpreAUeqodsRzwPWN06FRTpxGlwGo0P8LWN3oBz
         rSMNORdFpt3edC7SIcQf5OszZ/2gNGAUsZh0MnLCMUsRg56pgdV0Dbr/zi4HLtEUP+1v
         uG/CAbK40swXd0eH0lBM+80g4KlYBb+zMUV6jEV5h9hfY9NxOXvw0r1eLAURjhoTA1r8
         hGjqUlQx4GlOEkod1XmxdOTS8e3hKIpYXKWopi9mcgGn1jeaj6VYPKW1XIsrwDNNOH9R
         iCJNACZ1vogKBKiRCtNKeVQhfUV8TK+S+9vemZx6Rn34jzFokuPbIPKGs/rDLqs9IV1w
         n/qA==
X-Forwarded-Encrypted: i=1; AJvYcCV5whtXXoi20on5DTd/68kg8xqX8ggGvWcbLiOtlMQcUIlYCgBeTqnSC51fcvkHcOq2mn7sQpSYDUMkB9vTZRS752Zo+TxG
X-Gm-Message-State: AOJu0YzEbyk0WclOAajKzV+ixD4gWq0dWN108C1FKpC84ggIjKRhowUi
	UQ+QJg8qp1Icw6Uxq5fgvAZwKfMSHuFNWLZCb/zNKSNvJpEKwvv0O1qXSYf1MuA=
X-Google-Smtp-Source: AGHT+IFKUjSh/7REU9b5JCa963O/biedFihp/1rxX+VcDkiU0dVCXeo4NuXehHiUnqKMwWTI9csAZA==
X-Received: by 2002:a5d:4b83:0:b0:33e:793b:a2aa with SMTP id b3-20020a5d4b83000000b0033e793ba2aamr4185122wrt.47.1712820450173;
        Thu, 11 Apr 2024 00:27:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id e11-20020adfa44b000000b0034353b9c26bsm1112794wra.9.2024.04.11.00.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:27:29 -0700 (PDT)
Message-ID: <641eb906-4539-4487-9ea4-4f93a9b7e3cc@linaro.org>
Date: Thu, 11 Apr 2024 09:27:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
To: Greg KH <greg@kroah.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org, buddyjojo06@outlook.com,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
 <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
 <2024041132-heaviness-jasmine-d2d5@gregkh>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2024041132-heaviness-jasmine-d2d5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 09:22, Greg KH wrote:
> On Wed, Apr 10, 2024 at 08:24:49PM +0200, Krzysztof Kozlowski wrote:
>> On 10/04/2024 20:02, Greg KH wrote:
>>> On Wed, Apr 10, 2024 at 07:58:40PM +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 4/10/24 17:57, Sasha Levin wrote:
>>>>> This is a note to let you know that I've just added the patch titled
>>>>>
>>>>>      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
>>>>
>>>> autosel has been reeaaaaaly going over the top lately, particularly
>>>> with dts patches.. I'm not sure adding support for a device is
>>>> something that should go to stable
>>>
>>> Simple device ids and quirks have always been stable material.
>>>
>>
>> That's true, but maybe DTS should have an exception. I guess you think
>> this is trivial device ID, because the patch contents is small. But it
>> is or it can be misleading. The patch adds new small DTS file which
>> includes another file:
>>
>> 	#include "sm7125-xiaomi-common.dtsi"
>>
>> Which includes another 7 files:
>>
>> 	#include <dt-bindings/arm/qcom,ids.h>
>> 	#include <dt-bindings/firmware/qcom,scm.h>
>> 	#include <dt-bindings/gpio/gpio.h>
>> 	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> 	#include "sm7125.dtsi"
>> 	#include "pm6150.dtsi"
>> 	#include "pm6150l.dtsi"
>>
>> Out of which last three are likely to be changing as well.
>>
>> This means that following workflow is reasonable and likely:
>> 1. Add sm7125.dtsi (or pm6150.dtsi or pm6150l.dtsi)
>> 2. Add some sm7125 board (out of scope here).
>> 3. Release new kernel, e.g. v6.7.
>> 4. Make more changes to sm7125.dtsi
>> 5. The patch discussed here, so one adding sm7125-xiaomi-curtana.dts.
>>
>> Now if you backport only (5) above, without (4), it won't work. Might
>> compile, might not. Even if it compiles, might not work.
>>
>> The step (4) here might be small, but might be big as well.
> 
> Fair enough.  So should we drop this change?

I vote for dropping. Also, I think such DTS patches should not be picked
automatically via AUTOSEL. Manual backports or targetted Cc-stable,
assuming that backporter investigated it, seem ok.

Best regards,
Krzysztof


