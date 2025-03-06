Return-Path: <stable+bounces-121272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3CFA55006
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B0164B0D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B619ABBB;
	Thu,  6 Mar 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CPGAiIUn"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C75EC2
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276984; cv=none; b=F33E8oUkZZ1OR5jKuWqdEYi4jTkzebSfo0YvnipEpZwf1sfN9eFRbNQk3Qu1dg3EpXSNFWDHdKPCexZDgcRp4c7TQ3DSfBbl6DbyLl3jiLdwkEsQ5hhPEStAASJq3U/pgZJztTnziRj/NZzlE39s8+XwLTKQsozAaRyFkf/3N3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276984; c=relaxed/simple;
	bh=0X8fzsx8XEbpOxpV8HrcWj7hY8lw5IrV7LsB+2rmsE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4qhm23TAGqkP4YXeUfhgMb8SS8hhgf54nNaOh7LQ6yvC+55fnPkGD+ueHIbjUgNus5ZEyIGF29nPQsN/NBTvx6xkSXVgx+wdY1keJNPNUiEVXpdTRlBdMsYB1FeSQlx+MR77GkfzapijgfBREUmLcIMCKVZvnhQrwxTkontAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPGAiIUn; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85ad9632156so62768639f.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741276982; x=1741881782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3XSirLFPAgrsOh899VUHNdAsamjZowsu/g7XQvoJIk=;
        b=CPGAiIUnz7B8Vu6j8kdleD9NkJZPAzxqW9st4RHZOXCvc7oQSfmOkFirPB7XyiFUpL
         bqgwhNC48mbXlR2BUsnTGW+zYTogont3aeHRtlJYQwpamSkYhLcVG9Lc1QVrdFSr4fJD
         DQyuBcZbDFXXt/FlSiD2YbfzB7aq/Vqo9m5AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276982; x=1741881782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3XSirLFPAgrsOh899VUHNdAsamjZowsu/g7XQvoJIk=;
        b=OuxRAwEY+obCBeG/3xQXkS5oZSh9wAVz9H++58dbfYuJlBhujekBR0CAB6/FY1zz1y
         kOliSxnax8aAXGQfsp9Z0BfmfEPGpkRNZPESXR8S216SLWsJrhnJF61o1GTgHbArELfq
         lKnKaGfg3fnwMBWeFhwpsgv3GpdFVdbqGpPqVDHHBiFrGsWaEmzB+iZU1iuNjNrIAvWU
         COvDiV+D7zE93jewUow57uFmroyRNsxdiS1Lua6aEGZaD8DCVK9Orwbxu5aT8XpTpiPN
         i+BzsZPOZ+1rEXFZ/QH6bIwo6M4pdq0hxKNMLHye5ArM4o+9f2RFZQJOjIC1joULTFu+
         n6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWv0Xd+SHtP9QccHGHsHCQdB7/RRlvqawMELLTynbvwrSTBOMppHYvLd6/wJQDdP5SJjsJdzIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyteUzXyEzPvIFW97XE6avjGHWosWLN1JLV171LuvDAfr/THqqd
	HFShnT6zr8lL8ohrh5EF5j3cDfoptQikF5tNIHsbIESmR4VHAIM6J3msrmBHmhM=
X-Gm-Gg: ASbGncvYFhM7dS1mmxaI7L3jwklXCMDcZL/fhR1H/gJunsmHgNIP9zsXb/KpfWVe0Xb
	P/Bxfdij1PycCxr4kipyNyUQkA3+YzT/oafdapFC37QGqTrPMkhFIcmTo1oPvZsR68YB3rBvmsN
	7wKkQ7Bg3KPURXEsO0xfBt2XVEqiK+lxunmqSao17Oi+DSJtzfWlXYBBBLIRIlgkLEFN7YiUGzm
	ObMm4NXyAOjrG8urpsrH3Jbnv65c+lbXwOcvoUmbAHNmVlrru5g0Wf5zcXLvyAVcPQqOIAy/RII
	VnThNcP/5cviFHhqlAJgwnlIuk9zVqK5yS7cc3YXsnWto2Ove9IxYUY=
X-Google-Smtp-Source: AGHT+IGWay0XtX2xEGhlTLVfQE3wwjgEqfmpH+eUSvs/Zkzr9M+ED5qQk35B1GuVVL04/oO707vqog==
X-Received: by 2002:a05:6602:4818:b0:85b:6:fd2b with SMTP id ca18e2360f4ac-85b1cfa9450mr7928739f.4.1741276981997;
        Thu, 06 Mar 2025 08:03:01 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06d42esm397089173.137.2025.03.06.08.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 08:03:01 -0800 (PST)
Message-ID: <74eaf401-83c4-4098-a16c-c72c62127e22@linuxfoundation.org>
Date: Thu, 6 Mar 2025 09:03:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/142] 6.6.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

