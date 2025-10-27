Return-Path: <stable+bounces-191325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B4C11946
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 22:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E4618805BE
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F412312835;
	Mon, 27 Oct 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgsjh3NI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD52E5437
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601871; cv=none; b=Bgk6P+5tsecWNk1aa13nk9W0MjpoyewrsF9Z1hHwnJ9ckUiMaz3zhvNktG+5hZotMhm7zTLUp4MCC8C26Iez7k/twqk/muCnOkL8Ix44E/WNAxB8uqbUB0fXM0ejBjI3bSyYwfwC7OlcCHDdJjb6objge1dpOVSh6m1DKQcoY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601871; c=relaxed/simple;
	bh=Ihe7iMGeY3MaWfpghNgRKj16o/BXEhA4IQIEAteLWFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc2elUvWVfruEnuUsviMDEiI5KflzjjuHpGI2AE5QEYQ0dFPZQhFt8C3FOIvTANZ022vURx7g6lHJjsHaMKb+DPdlL/fnbgYUquqo18ac4NXvcoUNZyXVTL5l9J74FSJg2f2Dm9fNr8nFM6nJ9qLLUpHdjsL7g3VLolBxA+vmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgsjh3NI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed08085d17so2500081cf.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601867; x=1762206667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVNnHyP2kvRHu0KNHL4DYJenS905nS8x/EseI8qNXgs=;
        b=bgsjh3NIyR030PiLYEN81FIMGaxlPGfN12h3DyeetUAZ+RJIVRjOkIZBj7egYEY3Mq
         sPnkgim+WdGZ8aooe4UOBGQ4PMGsq9RLnu6bbZm7GPfSz/u8SJ6TiZ3gaPymnMYw5/j4
         OEGCDXmNmpwGecWfFkHhPqzE7kK2EFHxdECqdnlKmDp2p5bwUP6ZbVWIW2SguiY1wB4r
         Or6XVHSUexeUbbsieqq9Tjx9WpKxX3Ji/jkQ6sBBrcw04JONRR75K6m7EBTzdGdXi8kN
         WTPh6socvih2t9lvdnS93IeofkcBP0l6ckVqKRsS82yLk8Nx/SwegS3A/KSwveMafa3J
         MJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601867; x=1762206667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVNnHyP2kvRHu0KNHL4DYJenS905nS8x/EseI8qNXgs=;
        b=SFCwpvawTZMB/KLYE00tBifWiIFYVWEhpPoNjjaiuTSL+WP/xpUKRuCThdG4sJxAti
         ljuFUY5AfoPySBi7cNnkItd9yP2XQ4K/mLDo+sDHCA/PqoSx2j0Sa1V2+B7ZEczXTug+
         0Fy1V2NnvnE6IjrE5KugdjoLaTVBs6kHmU+0y874PxMm4Ms5FHinZbaYiQnJg+8tiXXO
         stut7gDyfA6rx0a3ysKqJMB4f9fi+9oym+1WNb/5hv/N3XY6tbMoSfQavFHTLMnUyryI
         c27/T4X7jH9ulWStUzMhrd/of5TRlIHIm+2iZXP/DK2BCQO7XbahGr6HyVBifKR+CbxR
         SARg==
X-Forwarded-Encrypted: i=1; AJvYcCVBz2HnEwhkNYD1PmzpImRsPcN2VyVJUZ01hp4BVaXJ7yrx/jRGa6FFDfYc/U2ImEt161MEIVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOpRb4jgUyDZYV0x+F5tuu9jlyMQOmb5zhkSj1mVECmy1iQd1
	pL4GguLzxZM4lo8Q25KfJdGxvG/1dSB9/y3ePIfxkvTY9PkZBxXQHWsS
X-Gm-Gg: ASbGnct3v1tpOvfbRzN/yGqHNAAPQXGG54py213gvJAMVaZLXpsfnFUujXijy0mMMpy
	3kZBiCvkw9gYRk1CD+nJCmGVkVvmyLWcS9tX5xCYC8e4bOxYMu8KWFSHoY2xDypJlefh5h3uNO5
	pt4V0Hp/Jp1aZvGkFZw/4h8yznJaQhAs0TEe9foF9rtlcJv2oLCzOAh9vlaHyGsASIlV3ZgGrUc
	cHTgV2k7WX0DNm65L2FJQmJmKWU57w5gzg2rYKkdffLiuFkZDHH0gC0zqZ8QzdwoIQLfu9uOwGh
	yoeC6eVxd7nk8uRZ+vNx7+rZlcqobLGc0KY9TWjRlu8GaaXkbwlBJx1KgzhWidzzTHon9K+V9SQ
	BBo1Rf7C7B2Z9Cs/p6nhF6kuag6eq5DH1VosD1RAHB83Gh1nbTOQ/FToIJJagFv3bRDxdHZYZzX
	rPJ/UfjeV1PRHGn9d6/Q4FZjAIgVY=
X-Google-Smtp-Source: AGHT+IH9Cj1acWdK8g+zx9f3zGo9gHf7/2+ldMTysUUzxIINsdMd7G/Ku9++UeRXutjL0OKbUCJtlQ==
X-Received: by 2002:ac8:6f0f:0:b0:4ec:f0f8:22f6 with SMTP id d75a77b69052e-4ed074da1ccmr25283401cf.19.1761601867150;
        Mon, 27 Oct 2025 14:51:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48f7323sm63559206d6.29.2025.10.27.14.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:51:05 -0700 (PDT)
Message-ID: <939799e1-615f-4246-869b-03ca162bc49f@gmail.com>
Date: Mon, 27 Oct 2025 14:51:01 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183514.934710872@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

