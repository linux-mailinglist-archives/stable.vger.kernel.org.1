Return-Path: <stable+bounces-38014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E6889FFAB
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 20:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7A2B29B34
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE00A1802AC;
	Wed, 10 Apr 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fw5D3MiJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC117BB2B
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773495; cv=none; b=WH67zGrXtBbrvM523lOT06Yon3Qx+X9ot0BbGvowOAFWuLMnTEV6i8DfGWMAtNOMWzBPiUB6ApTw/kVTkMQpl0xlM1iNsRI2ZL/vIDzg14BI1jFEfnoOD+TyOFWZLXY/N+ZGNZtQrsJhDNHLx1JgQcEFFXDJ7g2PHZ19+Anta/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773495; c=relaxed/simple;
	bh=/QKW9WAuex9cUAhM4JO0r5tGqucqhaJRfg3U5Jv1U6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8bMBlNV6mbnk8f8nNTOmdkhLljkI+rs6IjkILB+263vw6zgK+vf4q5aumV427r0JiJrk4YY7erHzdcMX8DFVJi5VA/j3+eb2uF8M0B3HEi/N9XoNqZJ1mMxkZgM62ogHCAVJZ+oHI1sr0jP7+BSFCC7Q9RT9bp/I9bU9Nd4LhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fw5D3MiJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417d14b3b29so142435e9.0
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712773492; x=1713378292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2aBErsa4zm5lNqitQeDAAwo/XNgbLQMqi0lDOkdN+rk=;
        b=fw5D3MiJMoURs4sDa9GDX0eiB++BBohPWPXzDY1jFUnlAR0Yjpff0fbku8lUxRArzF
         I4wFBpnIJBQwr4LkbixuHY2qC0i8aoO4QGSylQyx/m4vqD14TdLy6e0JmHjDZ1KHwfvb
         sdyHRIlgBlVE1USLoOkDYvXXzu9NcNqrDWTLuxZ1ZH6fuJR+ttYdp/kYO7uLLoD4BPq7
         /9TJ+M1q8TTrVS26mAk3F1vibOtIRGPULlSCXcIVkoAxexyDCXgJoRbzYe/Eq4gDMtu7
         U27vZQWxR0NsxZwKeX1xQkR2pn5OcofqxX/eDdKCPTTF5QOstAbkj7eccCSSzSkprS+I
         zLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712773492; x=1713378292;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aBErsa4zm5lNqitQeDAAwo/XNgbLQMqi0lDOkdN+rk=;
        b=jS41wArlq6JlAS9wj/msOcXVYkctoz1nq/fOZuZC+SguGm3qf+y5x0IX5bl0qUYsg1
         OCAbnyBFrPfN16ZBbKZmiJmtiqNNily5QD+VKEhPhd/F2w41RUGzCB7Ry/76JagEzCA8
         yaZ92P9R11ysvGtiaCDanLetm/d4ri9lAm8BzVAf/0D7V0Qo5n12X7JTEFXq61nbygyE
         0oXxhShWEVZOqpZw2WJzTWeyz+5OWW1pcTrJtazUnTK7InVVAiJWz6u1BazOkPb58ciJ
         rq2Gqc3N5wZWEYdVd9t4vS3nMCcWpge5N619JqPivBasgEDE7L5Ga2pukLbxoGpLwR6v
         l4SQ==
X-Gm-Message-State: AOJu0YznRLdyiWA+aj54NKQQnJag3XEi1UXyO7AOKnMmopmoKoDbuFcl
	EpF06I5ZJ4/d8WAdQJcIQNrGalcVWiUFo8iVo27wyQDLBL1gMy3Ilhul2nDIcss=
X-Google-Smtp-Source: AGHT+IG/QZEeSNG5yIiOs0f4gF7k6jIDcJg9gM9CSJ7rzc2QlGe/82Sv/cSxtXaeHJ8slanDr2OmvQ==
X-Received: by 2002:a05:600c:4e94:b0:416:34c0:de9 with SMTP id f20-20020a05600c4e9400b0041634c00de9mr3302150wmq.29.1712773492283;
        Wed, 10 Apr 2024 11:24:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b00416b8da33e6sm3047475wmo.37.2024.04.10.11.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:24:51 -0700 (PDT)
Message-ID: <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
Date: Wed, 10 Apr 2024 20:24:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
To: Greg KH <greg@kroah.com>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 buddyjojo06@outlook.com, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2024041016-scope-unfair-2b6a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 20:02, Greg KH wrote:
> On Wed, Apr 10, 2024 at 07:58:40PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 4/10/24 17:57, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
>>
>> autosel has been reeaaaaaly going over the top lately, particularly
>> with dts patches.. I'm not sure adding support for a device is
>> something that should go to stable
> 
> Simple device ids and quirks have always been stable material.
>

That's true, but maybe DTS should have an exception. I guess you think
this is trivial device ID, because the patch contents is small. But it
is or it can be misleading. The patch adds new small DTS file which
includes another file:

	#include "sm7125-xiaomi-common.dtsi"

Which includes another 7 files:

	#include <dt-bindings/arm/qcom,ids.h>
	#include <dt-bindings/firmware/qcom,scm.h>
	#include <dt-bindings/gpio/gpio.h>
	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
	#include "sm7125.dtsi"
	#include "pm6150.dtsi"
	#include "pm6150l.dtsi"

Out of which last three are likely to be changing as well.

This means that following workflow is reasonable and likely:
1. Add sm7125.dtsi (or pm6150.dtsi or pm6150l.dtsi)
2. Add some sm7125 board (out of scope here).
3. Release new kernel, e.g. v6.7.
4. Make more changes to sm7125.dtsi
5. The patch discussed here, so one adding sm7125-xiaomi-curtana.dts.

Now if you backport only (5) above, without (4), it won't work. Might
compile, might not. Even if it compiles, might not work.

The step (4) here might be small, but might be big as well.

IOW, new DTS board is not a quirk, but new hardware description which
relies on other DTS files. Only if all other parts are the same, such
backport is reasonable.




Best regards,
Krzysztof


