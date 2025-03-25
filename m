Return-Path: <stable+bounces-126594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5004A70856
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BA31889272
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199C125F989;
	Tue, 25 Mar 2025 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN3Wh71v"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046925F7B7;
	Tue, 25 Mar 2025 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924298; cv=none; b=ZzVpkCU+5H0pGyLlFNO/sift3z0+62pDYlw/ALWEWgekRXx+a/QgzGxAmOH1wir6JfImCpHJlzNbJpbzam2bXd4ZI1ONIqdLPovXtTavZ4IVDCLLdlZZh9YB+1cFpuAkQEBFe+R0djT27kqzzuOL3QJlTFZggLIVFaWyM/h9cKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924298; c=relaxed/simple;
	bh=ZnwOuPQszgGFnJ7ASTrb72w0n4+MF6tVe4dX5uRrVUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awrHXzhF36asbhKx/gJ6NQqPK7TuLRPAwdBwS93ZL+NXr9MEIWwxRsmCVncMw0EW9pD6nnyW+L36npy3AlKP8cAPDBkU9lVD4KRDXZoEeV3PY3dA9Dgvsrcj2TX5R82c1HQO4LuSRa1PDdah+GSL8EylCX001JWOD2DE+qnq7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN3Wh71v; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b8e2606a58so2983542fac.0;
        Tue, 25 Mar 2025 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742924296; x=1743529096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pwqYH740eHfa7nr66Oz8rz112QvEfxlqWsjIWzeytTA=;
        b=CN3Wh71vQxKhCrCPRCGB2SdVya+WkUTZZvrQWOj2u8XB3OFICkQWh9Q5QybbDm8l9d
         j0mRsZwe54yZJLZdWaiTWKfFYTAJawY/WKyZ93cad6gqa3lcLZZY33NdrueTNzQESUSd
         SvnStWp1Yc9cF62v1A9Wtmjr3IMyjajpcWUcS3flIyNfkphCZOklTvrKfLhTGCsnRkDa
         pepYwYQVawioX63In6UKXKbcDxRr6dGbWO9P09fPjUdhLUpbMIT8wdKyQH50tLtMmmOs
         PpFCx9n+UTPrvKyvCKmGYZKcxXCFZo/Z8Hu4/0LTfSkkNhy5L2JlIO1c/n9b8vnOFFMC
         CAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924296; x=1743529096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwqYH740eHfa7nr66Oz8rz112QvEfxlqWsjIWzeytTA=;
        b=U6pQkltc23b9SRT2TGnH79DdGdtNyXfdOEOymYpAYrynXf5GQJW9E/hUQfkDOzpa6g
         NVVEuTpraQDU3tViZJdD3thWllT0qfuZwzMT8ATEjqEteziItDUWb7plsAMA++HLL84m
         g/cPVwiMnnUkudCtGo+ofX/WZcFdZC0n+bUW5xXG7r7u3LXetW3z2/aQy86MC/dCwfRi
         wQ6Ht+bTmTYHxk2mktkOo0Aje0uoJsRLpJDntYLuX2nzlohaOoxAi6j0ByGp4CFN50nZ
         pEbXcCsCjkHoGRMr2veaA2Ks8SMZI0I/l7qiUzpvV0tgqeqzwA3Qas9Eou9ePAQNYrCk
         mh1g==
X-Forwarded-Encrypted: i=1; AJvYcCXNqEb1YNv/2v0XzE67DfXYHDrsoR8M/Oq3K3ekL8Kbvhq/XyMwrF66Oylrg81SxIuOBHxHKk0O@vger.kernel.org, AJvYcCXTDTX6cHocKFHO57xjKAgM2fouTHd0/DZx/R1aMUIXPpKqruo39fRzxMhhGwd//AZp+RNDDIc/2Nz5vNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gztTqLbfN2rapqbtC2bLk019eHWztDCmZh7LmRJrrbYkMUR5
	0BqEpCtpvyofsbjylmjgLpeif6MAi0952u87dOhCsu8wi37tkVLA
X-Gm-Gg: ASbGncvnubHMwc2tK+Q1OanBxRsvK+QKF29GnJA/9/dfc1oq5eaNWviYTrH4QlGjtHy
	YZywq/BmjVOcSydsg6TOlCci9m16bylUghLmWkltU+cwew3DsgLgJuBKNoKK5+igoCljRByVWmt
	2m/9b/HpW0lLTMgx5/8YiMbSr5wDjMqGN42CrmsLiwbOkAm/XYLyp9ikJTy3zBuEMREVAUnA2/z
	AHV9MNDcqb9G6ePKRMUGV/n0tOrzhZ1u6tU6G4zbTRaYr4db0OIxeJmFzG22YxyuKbsoRe0eSfn
	dsoujW/IVHXOQyaGBNCUF/prTwb5nKyVxcruezXGxHLFRVLxNU64R3LAf9wxbYwSq+ytJyHM
X-Google-Smtp-Source: AGHT+IF91Adb740CaBkkzjchwnIb0t1PYPF6DMBIepjROWrzdPfXlPqlaH3T+uBSaaRR/gfP31TwDg==
X-Received: by 2002:a05:6870:ff94:b0:2c2:3eb4:e53 with SMTP id 586e51a60fabf-2c78054aae4mr10641137fac.37.1742924296229;
        Tue, 25 Mar 2025 10:38:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77ec50cfcsm2572389fac.15.2025.03.25.10.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 10:38:15 -0700 (PDT)
Message-ID: <55f9a6c4-9248-4a34-9488-d09a543a4a23@gmail.com>
Date: Tue, 25 Mar 2025 10:38:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/116] 6.12.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250325122149.207086105@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/25 05:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.21 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.21-rc1.gz
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

