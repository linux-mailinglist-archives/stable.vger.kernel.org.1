Return-Path: <stable+bounces-32345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7F88C95D
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEECB1F81C0E
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC551AACB;
	Tue, 26 Mar 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQCpPJWM"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA381CD2D
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470698; cv=none; b=WzeASxApjoYIjnWeXzXozZBXtTsR521Xy3tsRuuthtMBOmcMNa7mRn2R82SYrSX6RCjBBwYe91ChVGT576Joj0k8JWmkm0Y45h8Ne9xlIqyMnL55srYfswrns4km5QfetI2++yKPJOwKmVWvXlQz0C2xsnhE4V5T9CEAA+VKRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470698; c=relaxed/simple;
	bh=L8F1Vday+FWTauVFASCsmeZfL566744ShzHCrvEoawo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCR114Y6ZN4pGNF3wc0PIreyLnWV45cGJCQO91kCa3pzdl5alwPaS50Y+b9CwtJPhIlIjuYE/w1rHKLTYx13LA/AMePJoendcTmUBy70gghBqEbxYEpmYufW7T3CXJgKwRmQA7P1I1yVFJ0rBz0RUcoPg1wUqa+rZCzrGcu5d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQCpPJWM; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so82618239f.1
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711470696; x=1712075496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfNkAoiSfqoBMHCXTVNDVvy9Q+IeLxX3GnUaU3hi0d4=;
        b=GQCpPJWMQXyquPBuat2ee2x/QdutadD05F6NNONbsn16MB6fqsh/zeWjc5Y7Wrt+FV
         eoAWi96dUTUDltJGy7XlsQpvhjZygAlCd3fligBw1E7jKni5MpD872YO8EnIYpcWBE5Y
         QjDOTI0ggq742mbFClcrS6vemgu+KdFgCr+i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470696; x=1712075496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfNkAoiSfqoBMHCXTVNDVvy9Q+IeLxX3GnUaU3hi0d4=;
        b=MM1qbL2o7cdB+iQ2Lyr8Vt7Yd/1AY3lgWoIkPUERvyQ/hTLEpNa+eXgHSdQUQSWEGE
         U+cyKJl9t9IfS8pvX/Lj681AX2xRu/ldN37JbudS9MjKVnHLKx7NQZbXusXo2VsK1niK
         BQzXNXFQxnuoombNxchtefEg6CnWw0IIpMt1I5koxJMxgHcxM1wH+1JWjHDaZoMmmweS
         AlgeaamKddueokWAtBWfIkrMU7Z0XON5bcRrSf2TKrphG+3zzJI4f6WWq55GWMKSdb4W
         /HX6EEo5pB2shN26V1+ZjjgO7eqPb0zo5ZpwimkBG3cN6a+upjd6m9hoUYKh7fOWpmB3
         hs9g==
X-Forwarded-Encrypted: i=1; AJvYcCXPM0jsyDm327X9jDXkM2XZN1yXnLNegIG5fRVB8hf4PFODibJxdP5DZmsA7NhAEWhaLuSiPR7JxuW+erWc8t9AlBWLUSVP
X-Gm-Message-State: AOJu0YyhWua1BIdplXNHDfokUNf1Fh6RIZ5PTv8GzBOP3a2oTk3jPdpe
	SiWcevx8U2Upfh18J7VtQqHicYUqJQyIp0d+hvzYxLNkDLYKwmFjzuk8Oei2m2E=
X-Google-Smtp-Source: AGHT+IFIOB1uF4sWL7izkguhAPjySDqnZ6uh5l39VZAdtGVMXGjChQ80uyufCBBSqdun6dbA6+2skQ==
X-Received: by 2002:a05:6602:335a:b0:7d0:32b0:5764 with SMTP id c26-20020a056602335a00b007d032b05764mr10760573ioz.0.1711470695931;
        Tue, 26 Mar 2024 09:31:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id dx11-20020a0566381d0b00b0047bf1cc6b42sm2782232jab.138.2024.03.26.09.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:31:35 -0700 (PDT)
Message-ID: <bede7f50-1355-4a1f-8996-04a5c3eff8ea@linuxfoundation.org>
Date: Tue, 26 Mar 2024 10:31:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325120018.1768449-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 06:00, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

