Return-Path: <stable+bounces-191538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24460C16995
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D351A60BA6
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A246934F482;
	Tue, 28 Oct 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FOHMTueG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9733CEA7
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679465; cv=none; b=AI13e++uk/Av/jHvZrFjMz1JOKF+5YSBe5i6PJV2GZA9q3/Ta7nJs0fVKABVbykhJ/MeeJ5rreyilr/CYPQNKFm3/miJz96OXiA7mqIWQCG2bU/C+Z7B4v6Voh3oYn6Kwrt/09GI31rL6dFryB8uHmkX3OO2EmR8LCvOw2fACeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679465; c=relaxed/simple;
	bh=FNuV2ylpbQgdnCFLqngDIR4alG7qnXMuPBXZqxFBQnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGQBQAdn+biDXvV4v8G5nBFksseDhjmW/fXmyHT65UgLfXZ4R6DqWSyKjsR8EaYfTpcEYYazMMBHPqWmH5BNCRm8TkgH85ICiwFAXVN3faMNIoCCTpEpTFmvIMf/mc9HAKfvYVdk02tULrfN1MpsK0QUTvgJYE0LIB3UZZcwKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FOHMTueG; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-943b8b69734so395759939f.3
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679463; x=1762284263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58Awx0bGuwSF6D/6xs0Bpv4Ns1WT5VljbxJNAptjXQI=;
        b=FOHMTueG3amuH0xkQCU6dBB8DgQfFZVa4OpUdW3wkzinGvdqqm1ZsslnKqeRZRklTH
         QYBnyzU8pays29zoxeZ6DBaq6PCschnN9vejNdcYN8OX+5Ev6EePpbkL/OcV74No0I4j
         2CJICanlVP51xHTPOY7feoMYVekRvtURsbIFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679463; x=1762284263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58Awx0bGuwSF6D/6xs0Bpv4Ns1WT5VljbxJNAptjXQI=;
        b=Mm2J9WfxhssdcZBe7CM5gJhKObaiNCA2hXgOZb2xCvIzlvYrWgCoEG2/Q7/DG9v27s
         GgDW7qen9yvtUEa9RgDw2X/PtFvJ28NzV4Zex9BqjxQkOBc2+NTf5FB0gugKyth1n8Bu
         inpDxITyrRMzCFnAlQIOZXiVzVjay49Oz7rywMd1bAca/JDZHtCmdTRKnnGBbAjjMGl/
         OJQmCfgsMnhqsixDlFkiOpqwIqVz/uDfvngFGQkBDd5IO8w9RtKc5nEFYfNRReCGqy33
         7SmrF4UC4+D678MueNlvzKc4H4HcmJL9+jzoEREmN9VaPOFhELqc5AoXdCjR1KD0L5cz
         p84A==
X-Forwarded-Encrypted: i=1; AJvYcCVLmnQrnpIi/oOpqjhspDYb2pGGc+HnFuF/ZNJZ4XVDPxcB/joviPRQKpT6IApotvbrQLdVDMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLfNGB/seYlEOyI7y2s4czk1xFXzbrQ59QzDseaShIA/42q6ED
	k1z/AFlh3tTGUWMc3HDq33pRTocy6EfIso7Snoz1fes7MwVttUjoulvmeyh/RYw9nOc=
X-Gm-Gg: ASbGncs4iHEop/8WQJ4q/FDtSP1Q8wv4gskCOSwoV2ElLfxYZPUCDXY+Q8B0AH/L/2Z
	dghFXTyoE3DtxWuHPhfwhgbIbfETRVS1epVVQxETm0s+N7FyyWYRkfAKzGwx8AJHYYaHfYxSCPK
	/V7EynXHv/jFeRZMs7WC3thEzInP7RLfdL6SsoXQiJzia/StvKa0nxT/XICAcdQqiLR+iVFc1/+
	hL1Atz7h6ceglLMoEyPekeS2GMe9XJPgfr9lpSicR5LDflSoFTq+70PJWEY/Z8mf/q7sQ1asB+a
	yFczO6uGL3hgeOsaJJ2ppxw+thpWQ1/QmhLxJVCbgqpRcLTKyloCci/npgEYO3GWDB1uzPb/Tos
	7Z31PO3cpNsXZDW+EBc80wrz7fR32yY0opP1d+wtCdOv0yIqBUjwIpyj7WGMJdfdiKSiFGKsWwU
	JROyZvA1CjymEINzGQo4Xsl9M=
X-Google-Smtp-Source: AGHT+IGaEFpRntODdNU7RTyaoyOhPbbt53aEcNEoUCMwoRku4C5s3OW5tIb5fHWdKQylLZZKXgEf/A==
X-Received: by 2002:a05:6e02:3983:b0:432:108f:427a with SMTP id e9e14a558f8ab-432f906651fmr5016915ab.32.1761679462694;
        Tue, 28 Oct 2025 12:24:22 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688c355sm45945015ab.28.2025.10.28.12.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:24:22 -0700 (PDT)
Message-ID: <58e41cac-eae7-474a-97ce-2f1a084383d3@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:24:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

