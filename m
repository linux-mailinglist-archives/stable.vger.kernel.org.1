Return-Path: <stable+bounces-78545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24898C0DF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0CB233D9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0C2199381;
	Tue,  1 Oct 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LkD8XUAv"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1541C1AD9
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794606; cv=none; b=Jn64UR0gNzHvhpPr658yFxWfyqv37Aiz+7sz+3R3ntMnB8lXc2R/VlcEK0LzBnZsjiKAwh7nv+3428SjRg+aJtl1KuCi3al8O4js5QGWfSEsud/zKUcwwEdEWEE7aJ1UvdKYPAwyNbCx5an9MB9YtoTmZRY+Cr1ZJXLiWmIHYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794606; c=relaxed/simple;
	bh=Bi2bgraB+xyUTSQjk7loVE+U53I6BkbjJ1TbVaYAatc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elFnnbCj0DG7UMOXwEeAfg1QaXZzYetPwv+PK0RJAnwzx5poEcnDSDG3lAwKmaFZeIjOiz7X9fKIRCDZNqMXVYqZJvZVTVQJWoPqNFYoK+vqUzhd04eVXUkciG8+unz5n1vvK9lBweNTvNn8rK276Q4BABLTl1u4JKCsaEZpvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LkD8XUAv; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so19068085ab.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727794604; x=1728399404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wpF1duCXeA6WFvNHcb/twA7nXT6yVsEV7PlRWb2HaA=;
        b=LkD8XUAv5NymYpCF08NW/2Cc0/ghVvHS3BJAVcAadySzfoHPKffjcdT6ooSNq/8Uro
         EMP1ujwGGy/ZHRuAdo2IN9v4EBN5hy/dBNvrE83FxLCgbk20e1WefXXRfROzGE4m8b/N
         vrEYZqykslBMuPdFxmyRdR1cNa6c58g7ueYkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794604; x=1728399404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wpF1duCXeA6WFvNHcb/twA7nXT6yVsEV7PlRWb2HaA=;
        b=uipl0Q9rM3DvV9/bwSmjyi0yZmTsD6ImQQCWSuqQV0ba+HKtwovNkP+31ZAU9ZfFhB
         rs5/oOy96s6H5Z27HbcpBQsCtNPJq5EmwYPhp0mAknpl1PVlkn5KJa4aovRQ8jFTO55J
         rd3goRUA44NSXYldCx18RzqPoFR7TFAm1LuXFO2lg8yq7hyz3z9tpnD5527RhUte+E9y
         5c7XkcxGQLe+rfrJK5a185A69d8gtAcAxqI1h94giXEZrVD7y9huK4QCGGMSRmQUqlAN
         ABwgRBelPksaowTaTyUnvp8uGj70nIyVIXKeGxLbK0G8MsQ8C8kFbtTgrB/Hyeyid4vV
         +Bew==
X-Gm-Message-State: AOJu0YwYtRvWjZBM9NJh6pb4Qn8s0hl5JF4Tdsuoun4xLYUnOPD1xIg6
	jyZ9ULxqVeQtxpCHrd63bZzjdsU208/HW0GwVo0ip0U5WuOTMAoxhO7vmHURoOH/3ZZ+l8TkCnF
	2
X-Google-Smtp-Source: AGHT+IFuAuicC+fFc7eWa+mRODktuB+48U8+cjFLakEP3UaxLXMB6jKEHEyLbj1e80jvv95NJtFwZA==
X-Received: by 2002:a05:6e02:1c24:b0:3a0:8eb3:5160 with SMTP id e9e14a558f8ab-3a34516a29fmr144456705ab.11.1727794604220;
        Tue, 01 Oct 2024 07:56:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835412sm2653792173.31.2024.10.01.07.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:56:43 -0700 (PDT)
Message-ID: <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
Date: Tue, 1 Oct 2024 08:56:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZvwLAib3296hIwI_@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 08:45, Jason A. Donenfeld wrote:
> On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
>> On 9/30/24 21:56, Jason A. Donenfeld wrote:
>>> This is not stable material and I didn't mark it as such. Do not backport.
>>
>> The way selftest work is they just skip if a feature isn't supported.
>> As such this test should run gracefully on stable releases.
>>
>> I would say backport unless and skip if the feature isn't supported.
> 
> Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.

Not sure what you mean by Nonsense. ENOSYS can be used to skip??

thanks,
-- Shuah

