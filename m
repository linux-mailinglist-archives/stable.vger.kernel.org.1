Return-Path: <stable+bounces-177546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5053B40DE3
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 21:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C84F561611
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB6262FEB;
	Tue,  2 Sep 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUFkS5Se"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B7286D71;
	Tue,  2 Sep 2025 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841439; cv=none; b=UqYWqBd/hiHPvZI4/bZFVI8Nka5QU/iWvAPNdJ8sLrPeQ/y2dXM5TWeG7HJMDEYKigCLSllHMbXywXI5+nzZ8nnr/jdK2UpiMlomunCfSpGSnnRqtvT26GOfoK624/E+JBsJCwnncSoKLnx+WainrVDxpzsFuTA2EC8fuEP8lZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841439; c=relaxed/simple;
	bh=zhmKmgSRp6rGgIpvauN272QRXRL2PSF2pNK78HFL8zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2Sojbx3zJaJomc/1wKawYwRtHisks3WabtBLIeSPC4BRC9J42laXb1yI+OIRV1salK9rewgAoyQD7tOq2SWlTo4YpQKbg+CPL1FVmvBmJN6QL9cuy8smIifwigxKIHKtC/xs+YdWq0jd6vnn2PnyavREzKLLjNnfDXt+q5Q7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUFkS5Se; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b30d24f686so384801cf.1;
        Tue, 02 Sep 2025 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756841437; x=1757446237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2d0M36nflyZ3aVE1/qgBP6oGR8Dano2nz7CS7EcayaI=;
        b=LUFkS5SeV426tKAhQTKfC5B49SxKlEpGJBicwX99UwRznI9C4cxwSrD7LQ0YAFPGCE
         lM8JVG99C5Tp1QGWj98asOHX3pweLoI5EmkkzIMTNinKDDrwbvGbgZHF2nshB/MU0T/N
         uY5cJR6QpX5glRSDWW3xA5zwpP/b4y6iHHkXa3Ofj53DsxOsRsH7CAo3UXrMTcfhBzGl
         lsjrnk06SThKzCvp3BPVVUUX0m06zIB5r0IzGveXkqMdCV8/3+kQoUGAI8kTZAeBkEjh
         Pp/T77IJIBR4Xlso5LPYTQDGskmKWrvAULJQNvYjGsRymUTQbXiKZlqAjw6Po/bkg4+O
         U3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756841437; x=1757446237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2d0M36nflyZ3aVE1/qgBP6oGR8Dano2nz7CS7EcayaI=;
        b=WnjlN7GMVYmBUlzevEDh72ABJXHeYO9BFYr491K27Ms3M8sWJRrgfhJLvg9lC7vjC1
         AFuRwsefZYDGD45B0MhqbOI0mn5F6iswUz+Y2FE/ZwP1Xiexq8I0SWmIV5Huecb3ohYA
         8DFofj5/cR9xmMLTtzaU9OaUtZH9GKSlLLY9h2Hx09Dnl63BsIX+SRzw697GiKIA5Z0z
         kzSfp8A3HgYsu33sw6pnGwYHXozVXrwBBN4cL5RPMcpgVkcF83SSoQNTJA3Fnka6rRFE
         xZLAAeiRFYzPo47PGBqBQVRKKuPOb+XNHPw1fXUx8P0lJggt5BgsPlxD9aLqnJdva9Am
         0Row==
X-Forwarded-Encrypted: i=1; AJvYcCWhjdo8CASKgrOly2fSr+MFZiMpe8LltSh29wtSRBd6k36GjOpxcqIW7gZnkmGQgL/MCq9KM2gqapgdKWQ=@vger.kernel.org, AJvYcCX3ai1R5jA36bUbkWspnLLdFR7OBHQgMWa12tcGp20cW1ssqp7NJTKg1hI5HoLA8+49lA9YXdg1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VqObC4WAb8ySDRdDcmpV+4ZuNyGti8vIRelRyEXq+E1WOvRp
	dcHk2myTbSSnpzZLu8m/JqHpEVus8oUgzs/63rDGe9ycnw6VsEMaPGtX
X-Gm-Gg: ASbGnctrTtBAPz4dPR782esTJ2WlZQRJ0c/622D1BT393QdRG+z95aRDQNvkmX+SRu3
	tyzhblJOjTIXWrkp6D49/HD6h8uoMloOX0MgVvCGdunJLFaNeoNCmpvysaboQPnoiSaHYNftLqR
	kklbMze4cJmcTb4ZRXqW9oz2Ng6R/88JAQdp4tV00NICg61XNNtGkj20q6tRhH6Gp6UJ4KgqeVP
	/uZ6GT7YQUxekMZS+cegLUSgUfGsUD/kMFY7zMatfbUlDwAptsf9S9mSiigWPwzKySXQBWxQfPI
	CwsmYIEQ1puSBPOPnmvQL0FKguqLBDnI/se+Yo3xesUMXEg+AEuMvkg0l3rZDr98MXD9scADZ15
	bNWb10yUm5RkD0bJ/b3vFtdwLZIhag1VMiFI45kZ1D5x2ctJuEQ==
X-Google-Smtp-Source: AGHT+IGAa6i2qXEohc62Y/w9CdrWolz7lKlDfaHVt0IN4mhNJeq4ZdYZ4bJyptmKiahnHXmDvCgSWA==
X-Received: by 2002:a05:620a:4087:b0:807:a4e7:d13c with SMTP id af79cd13be357-807a4e7d2famr343518585a.50.1756841436485;
        Tue, 02 Sep 2025 12:30:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069bf66e1asm179863185a.37.2025.09.02.12.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 12:30:35 -0700 (PDT)
Message-ID: <1cf3dd84-89a7-43b1-ae06-08c36565d422@gmail.com>
Date: Tue, 2 Sep 2025 12:30:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250902131939.601201881@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 06:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.45 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.45-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

