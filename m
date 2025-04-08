Return-Path: <stable+bounces-131856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C895A817BC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC1019E81EA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B02550BC;
	Tue,  8 Apr 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIb67fTx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023021DA60F;
	Tue,  8 Apr 2025 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148539; cv=none; b=I2mbREHjramXdrKuGvwyv9UUKnFZ9X3FOlA6hXWEsY17ajHFyI884/TH6T0AoNjt2aMyKKBVuAjHscru/kMYnrfU1rO+YB/AM5+Nj3/g/5/E3zZDQL2Fnvo65XnzVRj8GmLu4CoCGXRZItogH6kgPJx0horHlwVyNiKKWDl1EZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148539; c=relaxed/simple;
	bh=qpYrioj0w5URFSCWL4NtC4H6LpG04tzfAhxwoLHm8Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLC8+K3Neh4WbIMm+wGMShhxISKIKc4Qez6Ocb9W3bKzHt2IxXEUuRfRRGKHN6fW486Pm8JiBfulN8qncEthXHIXWT1lP+BJbhbQUxju135OpjW3Z9sLNmYDnw+FptuS3smVIJdW+VnZtOWwaMqo1Yolc9kklNwcU1E45HUcPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIb67fTx; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c173211feso1604970a34.1;
        Tue, 08 Apr 2025 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744148537; x=1744753337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zfw1IwlJyEYWGuWoKKEXeWT3ILXzuhKNh7fIJ9f4X0M=;
        b=RIb67fTx6LzlD+BanuPj2AsCu1TxWHO/UAsJ1YWJoVAk+6EIEsrtPAD+Gf3Z7egwtn
         m0rqR8Bs5yrimbDxS9wal45u+Wg51ZNRjaRgO4cJqjChDmwiVEOGirf4Rip3gFWKBYDB
         zIaQVf8eJA7W/n1R5bxZkOEfYjyQCtTG/hh2zBiH1sUeHGl0efmK/GqzU96oSlYpkfdw
         AmJ4g4nhyeKEqbp295AtvmQ3MTPhAL9Mv/vSo6IbYm6PxG2GCKZXl8mmFwLq+lH2qsLe
         CkxDAnsyrZdFE+bdQmgNnc0cXoyWL3bIvj9XYE6gnSFnJlB4QOIPMUmu2OH6++v5+sb6
         OYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744148537; x=1744753337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfw1IwlJyEYWGuWoKKEXeWT3ILXzuhKNh7fIJ9f4X0M=;
        b=dfhjqGmTx+pdFCkq+82UrlIAxFLvXe+E4hJWOq1giLTCgEOtaouyT8v6i9jFKWshBo
         6X+XhzGuQN+XcSoHZ180xxDf/raRbaU5hEcz95ok79NUQwv1SmmnSypwdHts+4VSCBbV
         IRTpikAYvgdDSfU1HGm5J78HfOp3/hrByAefqKm4+GxO4NNTQu3V29DIc7HYk+HEsA22
         Wo1VtnLNKJNgZY7bXrfle90r65esPBs/jqJbA6Sa3EMhFz8lln/5+hUyhQ0QVqenNODc
         IrRHYyipElsgRYq9s9+TtYW5DT31zKFkTQI+2cdXta6p6oyWBTreFLILHIwOCxaxPBMe
         UFPg==
X-Forwarded-Encrypted: i=1; AJvYcCV+3ejDpMPm4rcwf2G2yE6i/qiTNM9q76EvQ+Xb2wEodhiapQ043urSiZZ4+aKW03xI8WA33Knc@vger.kernel.org, AJvYcCVvl4hciFzX9Jb5VGgIOyxI/Pgt49safIEpRrmnBATg9liuVBqaeuu3DYUCewUI/2E1TrptNA+3OLa07/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPujftQO62t9hwF7nrKEyFPK/MSg/5d3ZZscbY0F9zFEt4kcUH
	zmyb1JU7PJpCXYQ8D31Y+O86hts2+sB8/qExLu2D+xf2yvoXWUm5
X-Gm-Gg: ASbGncsjefbDMN9p8SccX0kb7wALXTB6XWgcP8XgrpetLbMAzFNA0GCDe+Z5ryDrWv4
	legoZ2szGJBbFLr4u1nWRfD0sRF9Lh2zRNnrh4DBnJwjz5GF70lECKxZt2NjUM1JNB/QC1fhzPb
	dY1A4dWIyfDJmYvtm8w44ZzbxMUMdSLEsUPdr+06WS7hgfk5gaTmd4S6EU+u0KXPDgQdGrCOSE0
	MV5Bl7uXROMyJ+eu3Nlr/mCMlW/pZ12DHWu8s7bPnR2ktABzEwqmWu18KjtQC36Gz/jT5GaKpIM
	c3GB4WLa4cLm3TSWd6gRE78TKl41U4PASde6QsErBTjH66UQeXqqPNLG1f8D9IcpwTii2z3/
X-Google-Smtp-Source: AGHT+IEMPB4A4P4D4RFqo/hLDRmh9WFPcg33JXZU1FvwYXLvfWEQ4fH0VkcivVV83sOlmFosexuC6Q==
X-Received: by 2002:a05:6808:244c:b0:3f8:30c1:ccc6 with SMTP id 5614622812f47-40073ffc89fmr134925b6e.8.1744148536919;
        Tue, 08 Apr 2025 14:42:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6044f48f26csm599830eaf.1.2025.04.08.14.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 14:42:15 -0700 (PDT)
Message-ID: <e3b6db92-f518-40fa-b6cb-7b5d9285ab9d@gmail.com>
Date: Tue, 8 Apr 2025 14:42:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/279] 5.15.180-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104826.319283234@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 03:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.180 release.
> There are 279 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.180-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

