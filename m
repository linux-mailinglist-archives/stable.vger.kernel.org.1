Return-Path: <stable+bounces-60428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B316933BEA
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20FA1F243A1
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9C17F4E6;
	Wed, 17 Jul 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sn/9Q3tV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FE17F38D
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214666; cv=none; b=Q6EUpAAch1bkxudAJNcXEcoNUHh7j2jWBxkMJsGq0LMItnT9KEnTbhHpOsTYz1mC6Hp8dTVFk3SOx1RoK5seMG0PkhjES+P+4/m5FByR9zTRZfh7n9jr8DSzLiuHSoFqcuzNe/xuJ4C7qgYAIOaDHgsv9PAAg/ulXW1taIl3r1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214666; c=relaxed/simple;
	bh=hhutUiK+ldZmbrgZE8Dzx0T70pv9+3yHYglk4hnsQuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOtUQJh2vyRwlUjbfKpbzbGOkPc/fQB0x0oiPf6zoX5kfCRyiQXm7bfg9yQFSYvjnaUgYcIj0iJYZqa0oV5Mktk3XSf/b+pHEx731kiivuXgQ1UzBGNH7ceVgCBZVU9Xj0Ja+cedg0J3X1Qm9DmeoeoAuqb4dNVaXKNCp9IgBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sn/9Q3tV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so8006463a12.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721214663; x=1721819463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OdeLjPoqRmUlYr25okuYc8K1yPtbJFc4x5bOz0ESpo=;
        b=sn/9Q3tV2y8D5NljrD1M4k5h51yxGuYK2ztENjPHvWgCCLDaWxsmclqb3sfwIj4Nvn
         cKDiOWg/A7CxC2n0ALQ0tySOE+uLARTZNWFTwuFqOo05aCMzgV+kaMUMlv7BRuqxWaw/
         k5B0sJUXSPiDXu/RR2lCxjN+6IWRa9JSqP45rrNsHQrNsHWs7yqmRWkABHjfIlQpS7OZ
         2A02PrQFIxjIzzub+h1eHcTHG6D5+p5JmH7aE3Sb+R0YeqtfcIrcIpMBDQbISd3jXr9f
         GTU+0RBfdj6Tr68hu9sxARmTbbtL2hqMMyBM9EoVpQyAAjvrsYVcThZATmfY5O+zu//0
         JLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214663; x=1721819463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OdeLjPoqRmUlYr25okuYc8K1yPtbJFc4x5bOz0ESpo=;
        b=HM7O1D84kmSLg4a3ZWomQK9/Droc/ZOwZTFlohZkgTSJjlbyue/mmT5fr/DdqrZH0D
         b7cqABYKv6k8ZQUzCdKnp1SEe7AToS7gfoDKcVz/JbpzDMdOPCMQwlOJCfoY/Y0HgvHj
         rT7uQom/OeaSv6fhucTukWvTxEvqTFKATBCrXm/zwp0Ftsz1vmGdYpfqUHFfMlF7iBbH
         A+HueJ9gKthT40uKrScrDxHHwdmIkxNjLgGCayFfnIidPpddX2AyAcUX3TnewiGm1Oxq
         0sxavTWL8wB226VcUrGOExqoLgNr7n5JX/AzLGNRDVDQJ5XvRbiBGSRMCbaVhr7RxnWn
         bp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP7lSRu5i+k5kXH1rMfLbZhQ0zaNHWv+5rERcYBn349ou0KZzGUhXBaYkvFS6Uo0Xfe9rvN4VD2SD09mS/X1GC1AM3t/eK
X-Gm-Message-State: AOJu0Yx1WQXkq+cvPmFAeajh5vy0K7u1Btph9gwoCYjuRxkZ9YWTJuU3
	vGl48x2se+nhqpFpvy7GhJmVRJCpzniDt5eHn1m5n5n2cnmy0EojtZTqfX47QJs=
X-Google-Smtp-Source: AGHT+IF/SD5/dNu9jj11HFGPBp5Nm6wXSVMHns1m4v4DrAtWWsNwrOpe57aeSit2bIQ3BRxkaPO4Ow==
X-Received: by 2002:a05:6402:268c:b0:58d:836e:5d83 with SMTP id 4fb4d7f45d1cf-5a05bfaae65mr1337759a12.22.1721214663479;
        Wed, 17 Jul 2024 04:11:03 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a28e8sm6733080a12.63.2024.07.17.04.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:11:03 -0700 (PDT)
Message-ID: <ce14800d-7411-47c5-ad46-6baa6fb678f4@linaro.org>
Date: Wed, 17 Jul 2024 12:11:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: camcc-sc8280xp: Remove always-on GDSC
 hard-coding
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dmitry.baryshkov@linaro.org, stable@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1@linaro.org>
 <f0d4b7a3-2b61-3d42-a430-34b30eeaa644@quicinc.com>
 <86068581-0ce7-47b5-b1c6-fda4f7d1037f@linaro.org>
 <02679111-1a35-b931-fecd-01c952553652@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <02679111-1a35-b931-fecd-01c952553652@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 12:08, Satya Priya Kakitapalli (Temp) wrote:
>> How would it break ?
>>
>> We park the clock to XO it never gets turned off this way.
>>
> 
> Parking the parent at XO doesn't ensure the branch clock is always on, 
> it can be disabled by consumers or CCF if modelled.
> 
> If the CCF disables this clock in late init, then the clock stays in 
> disabled state until it is enabled again explicitly. Hence it is 
> recommended to not model such always-on clocks.

What is the use-case to keep that clock always-on unless/util someone 
wants camss ?

I've tested this patch on sc8280xp and it works just fine.

---
bod

