Return-Path: <stable+bounces-60628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD872938001
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39055B2162A
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE683A1C4;
	Sat, 20 Jul 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQsGO5AB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731426AEC
	for <stable@vger.kernel.org>; Sat, 20 Jul 2024 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721464428; cv=none; b=r5BytEZRUq92J66QSBlKxigSHtf12RCHF3PUW299JVOT1QvGyV7Bn0JlmsrjbGTtKolkn7j05BPuUVSMj5G8l/TOW/myUYGngW549mqRwR+a1j2SFRP7ilBjcO5iTAmKGgmxAGK5dQXEOewNzEebuor5c7L7EM6yPeTeyop9tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721464428; c=relaxed/simple;
	bh=nqrWYQU7W5hDIjZF3fNUNbhLlw4BjHaXyoW1VQG/clE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvIMyYZZqbZTa2BIB25EESsLITUM5ps0Z1t4XGe8JWSrTklQF83JYJV2/7SHc+aCtT9PX8wjfqHEcHc7yDgZbQMmIt2kSEBOkxm8ONVmIlQLh50eoxAaOFkHCMDWhZ1EjBluAUDU3TToFBY+8ntAkgqgEnMv8d0HaBfCKSyeEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQsGO5AB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77bf336171so437377966b.1
        for <stable@vger.kernel.org>; Sat, 20 Jul 2024 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721464425; x=1722069225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SafSONIEoJzZyDytK/reQ3AEKLpvdJTl/uNZNxo24nw=;
        b=CQsGO5ABN7KRj+1n4i7pnhDOQLY/v6YPoEdu8SpL8TiIK7ZU04ArYIQO4EfNPWB1Id
         /AieuwQa6mEPdSihtAhjIYSwlYdw/j9YEfptF6ApytMlGKdXW8d09U1ZXuQREC1ZLQHo
         TtRe/y7Vz7EEpOglVenlhdUUzWheVI+urDGMikYfaaLyoRemu4E8TYUJpVe8w+/6rtHc
         1PlThJYH/bcc5TmfSNjjuQZ7NE9eR9HsN08+z3qXsmoNKbMDup868N0jLqVdsNRnGPIa
         p1cYsUIxjKkpEmlGC7JHieWq1jXqA2qPpxLRwqM2gCuL2laH+8JQKY7bzA90tWtn+Tge
         fOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721464425; x=1722069225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SafSONIEoJzZyDytK/reQ3AEKLpvdJTl/uNZNxo24nw=;
        b=ENkHnbwJD1hGOI2cCnnpIT184tHiiQv1oWk6blkNopF9LxsBCiKTGO1jv19XTcU9Ra
         4c86pjYjqT9Elw+pwIYaePWs9IQ7yWpYwBEa9kd8unSbKlz5Nge7JPnNrlxYHFBYLxQ0
         aPMKFbKF279RC/3KVPj66stcHCRjPeoRa0R6X0kAphXgl0WjrTVnJoLPMJgb0jvfkmIY
         E3cYA4bgtOMTHkLy5LqpcFSwdPYF+YW7rqyKvL8gKvEfZMqLJxbgDX2cM+oo5nAaZYK6
         cGK+zgnsVSrOX/Y1/5iV+wgY/81oK3Crii+O/nOqhZM/WvQdrQI5kD0Ci6Foq8wWYONk
         xcLg==
X-Forwarded-Encrypted: i=1; AJvYcCVATx3ZE+oyq+wSDnzMypAAOKWU/tP9VHZvB1aYf+dRLyO+4Hsf/50OzI53IlT32VoIRWkGsJt7WLlKUbDzOsnipmec49ph
X-Gm-Message-State: AOJu0YwLd2SuEtwxmNKbdVnUOvZWxUIFTWosTne5z0GGlYZEHXaDC4Kp
	ujQhPzJh00P5UmPhYvo2YWY+tmQ4lg8U8PFxQQq8OOQM0ZP001ZrQ/v3i3QZlqk=
X-Google-Smtp-Source: AGHT+IEA12YF0QSCvG5aEc6J8CnkmX3qbqj58vcHZA5t9dq9xmvvs/1oXFehHPsfv4jKAUtnSblLnQ==
X-Received: by 2002:a17:906:4686:b0:a72:afd9:6109 with SMTP id a640c23a62f3a-a7a0f13cb46mr841839266b.16.1721464424948;
        Sat, 20 Jul 2024 01:33:44 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d7265sm2587562a12.9.2024.07.20.01.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 01:33:44 -0700 (PDT)
Message-ID: <610efa39-e476-45ae-bd2b-3a0b8ea485dc@linaro.org>
Date: Sat, 20 Jul 2024 09:33:43 +0100
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
 <ce14800d-7411-47c5-ad46-6baa6fb678f4@linaro.org>
 <dd588276-8f1c-4389-7b3a-88f483b7072e@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <dd588276-8f1c-4389-7b3a-88f483b7072e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 08:25, Satya Priya Kakitapalli (Temp) wrote:
>>
>> What is the use-case to keep that clock always-on unless/util someone 
>> wants camss ?
>>
> 
> The clock also has dependency on MMCX rail, this rail anyway will be OFF 
> until there is a use-case. So the clock will also be OFF.

arch/arm64/boot/dts/qcom/sc8280xp.dtsi

camcc: clock-controller@ad00000 {
     power-domains = <&rpmhpd SC8280XP_MMCX>;
};

> 
> 
>> I've tested this patch on sc8280xp and it works just fine.
>>
> 
> Is the cam_cc_gdsc_clk clock ON after the boot up?

I have no idea. Why does it matter ?

---
bod

