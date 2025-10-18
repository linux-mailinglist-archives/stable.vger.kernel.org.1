Return-Path: <stable+bounces-187806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9608BEC666
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166CE1A60C84
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828982836A6;
	Sat, 18 Oct 2025 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR/CS80L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76A1B3923
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760757394; cv=none; b=doIVhfqyv3rn4PkEihjIZe12EHQqQYMq/zrnH/kel1DleQTtyaKZOF/lqRjMZT3DnsaZGsFz89/0laVh1U1uWS3eCgkp3GINRnJ4rztTPF6TGg3hbRnztzB9dQ0nVtZawhZ7yhRIYCdAjVs4PYINLL5izPl1GNUQN8ehPsB3V/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760757394; c=relaxed/simple;
	bh=3wqEQjGVhmexMMNO6iz9PsnEYDiNYzXnxmnJPClebZk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gQ+DE+O8Z0Dnoi0mxiXReEDdOB1ziKI9a+WdNba/9uTCm+KFFK0tAM+Tz9awBESJMM9ar2oIkmhUK0OmNkawDSZAMp8FiZ5D93V/wBByhZkEWqVGJFzlHYeWxxhlAmUhJ2HiucINiKc5JbQBis6ZvW/vkjOjhCPILbmsC4yYPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR/CS80L; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b60971c17acso2089012a12.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760757391; x=1761362191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CngrJsnwfVz5Z0uglJuuMx3gx6jUeZ2x5IS2P/yOwoQ=;
        b=gR/CS80LjwryuZNHudCAi7HdsjgeHZnv7JWdgehz1m260vjmxwaR6Wp4k2IAKWgVfw
         bTLm0/R5asfUsI/z4glb1S9r3cTXOrZkP6+DhxjrxkSUB4XwvGzIpVrGkusvifCi1Rv4
         9zF4Uns59Stv1AaZ8oR3UhWqdjmwvwE7mnyoFNmY8iIl0XL760vF47GMxt/ZK4n/3yAv
         eidS8fAFQXy9pN90fO1rJq8WTBJx0r2Mkpd2/I4IvtZu/D4/Avno9uw6XDRBykor9Rhx
         knbmydFQUcGaWD61Ue1TT7KMTIHfMRjSDqQNbefNV52yC2UMJMwfHiHHoqbASS+Qaq52
         78ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760757391; x=1761362191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CngrJsnwfVz5Z0uglJuuMx3gx6jUeZ2x5IS2P/yOwoQ=;
        b=EEwJSDbbHOo8Ke5KY74dZy69K6AHAks399r64k8CZiworvMfeFrxvOY3nVGkDXk6CE
         sCLCVXyQUwj5vIioTa7wmV9KsDMO2ZplU16dcKrLoAWfUGHFDkOPO1DhGd1a9YdVhS5A
         /xRtXpnjUvF5sHlmO9Clnpp2HbtSNFpo4hHinJs4JHmT3T8Z8QqYT0OlhQBA1Nc3p1j9
         xz62K8DeXNRupM0oiwqDSRhVsooXVBQQSL0Ia1BXdaYftPnE0cJzBC69hr+XhVGo/+Z1
         bIBHv0ic4zhhFvsK/0UDpqjatMWNzq6tQyPFtiB/fEMJx17BhOJssCJHCAT6jgoaqccv
         b+mw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJqsQm4VZ25xwZk1PeXlaMrkEKNohtjOCruAZoD+EAVChv8AVKl2xldp3JuIW+VFR03cfrUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TtewpSAghZV7W46KJlasHShJNXsaDUvZcJUJd3+aQzHFg0el
	4kFjSwI2LCopj7f8WWS9FawNx5SODNYkIJYjMivR2oLvlrm9pznrGWvo
X-Gm-Gg: ASbGnctF0Rbx2L9summX+kkEM6X3NvJw2pAvH6zHbtLDkSlnX58cjnSsedZvVF9PR63
	MZ0NgyXTyX9G2HDHKnucDNJpIxEQnSoy5ZBuR3oHSTLdGH/j2oWVhBsWiO1KmA8JpTC3TAaNWKY
	vaLI4d5iMu02AoqeEcCx3R50gWJHxskissM/OKEu9vNhWZpZ0KjUNVnCe2g9zydSTeVcszB/h4c
	m1bY9ZFPZ67FL1kXa0kfIo2Kw6xRli63uekFJLo2uHBh4KafzoR+5SJPAzO+igDFZVNf++JiTvb
	/2POs5qBZd23H9R/a21pX5tb47YZ4nEyDvDXCN2/v/ptDZN19ipzmG79/sb4vFAe0xuzczZg5kT
	HCw1k3O6F+bY7/dK2pwzsFPZY7tCiku3j3rcsweDHOt9ZIgFMkKVO5L/tuIHgMGaQ1zT96FqSXP
	hWiG6ctmGHIlxEiQGq2JRi5qBx0zHH4kYacFAl1EqAglLLWLPLYisj
X-Google-Smtp-Source: AGHT+IGF6g1VgS+2PdOdy2+M9tUOsUipAN1cyuL9NAJ+Yq6EnSQf09Cwm1hQzI6MsDSu/Ika2xwH0g==
X-Received: by 2002:a05:6a20:72a4:b0:2f9:48ac:c8ed with SMTP id adf61e73a8af0-334a8534251mr7721301637.1.1760757391312;
        Fri, 17 Oct 2025 20:16:31 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df5c2e3sm977960a91.11.2025.10.17.20.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:16:30 -0700 (PDT)
Message-ID: <1b17c6d0-98b5-4456-a586-918d6533ca12@gmail.com>
Date: Fri, 17 Oct 2025 20:16:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145134.710337454@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

