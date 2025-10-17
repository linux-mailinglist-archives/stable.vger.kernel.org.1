Return-Path: <stable+bounces-187715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCCBEBF81
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444916E77B0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E73831329A;
	Fri, 17 Oct 2025 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="mFCHNQ4m"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB42D3750
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742269; cv=none; b=bsM80931dqPVp2vUxx9/Gt96dN693g9KLdNuwLIzitocVAThLpRHqNo5eKPJYHZWHRSqwrRmc59KwdyjuUuGjzPJoCh7vfie9UUtyMjfmEYXDlX5IDSYomq5C365ntC4cZWMNkq5oE7BxWUhLeF1COAaRN3+NaiuEnkDBJM15N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742269; c=relaxed/simple;
	bh=Jq/H+/b1GArkCNQOxIQJRBTfifohop9pfe++XjDov1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOubazPnHIsOnO7QiSDf5Z5k9C5Dsbn/tj5cTxyNqWDbpA6aYta4ipLaPbKHVdY1F6BjbEvsgiF92kpHj6U43U8dx1zMo2sh171VTKQuqyIKD3DIaD70aAOIVBkFrvHrSoGLUBduBNOkpgu/hwQwIdoI9qtPJKYc92I23x3kmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=mFCHNQ4m; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id 9pGIvVdoBZx2i9tUovzENy; Fri, 17 Oct 2025 23:04:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 9tUnvhpWSt4eL9tUnvfP2n; Fri, 17 Oct 2025 23:04:25 +0000
X-Authority-Analysis: v=2.4 cv=FN0bx/os c=1 sm=1 tr=0 ts=68f2cb79
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=TfA6R2l6Ho_dUAMD9YgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q30APisvJzq6aSX98cdE30C6F5BhW+o0cOfsgqyy9YA=; b=mFCHNQ4mDeLhcfyHalwstifybz
	MI01e26lOhKrVa/9H/NfD84j0Oe6H6grBDhaovdd0wmGgP3mkKhS+4Ye8O+ammc3sWB4Zep7WcMze
	fqjspB5NKHsN3ptar73bvUV7SnIZJPpO3AvVAjWYuUngJlR2S0C3zMd7Aj5VH98YdYxxaDNOfeT6G
	Kj2IRN428IxniTv36TL8XBaTjsZeRyN0C0cASBy0giJUVewmNYeqpOlecdH9kLow8OK1vdcIkBzyz
	wJ5zSP5iAZa3GlQroektpt4PBHPh8VyscnJhA29Or42brNN93OZ4CX8hdfxeO7BOOCy9BpyEHTQ2E
	e11CNG2Q==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:44386 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v9tUn-00000001Xiu-1FXj;
	Fri, 17 Oct 2025 17:04:25 -0600
Message-ID: <90bc04ea-e7ec-49b9-ae6e-d0e2c85bbf96@w6rz.net>
Date: Fri, 17 Oct 2025 16:04:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145201.780251198@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1v9tUn-00000001Xiu-1FXj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:44386
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIJ4ZbUPg+98XUeEjG7VhQAjPAD2Tj5+TFhSxFjfEP3tzTGlhEK48CfYaOEZj9ipne7CukLL4F0aalKhLwR44WkkAWnNx3mnxkO/DIKYqq3zgvFm8Ucj
 hJutXZt7mV6JpGaiTjabUIB+RwPvgkc3sGkmsrSwvU8I9dFCbetQRHMvL+lO9LgCORWE0ieiiG/Snw==

On 10/17/25 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build fails for RISC-V with:

In file included from ./include/linux/pgtable.h:6,
                  from ./include/linux/mm.h:31,
                  from arch/riscv/kernel/asm-offsets.c:8:
./arch/riscv/include/asm/pgtable.h:963:21: error: redefinition of 
'pudp_huge_get_and_clear'
   963 | static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
       |                     ^~~~~~~~~~~~~~~~~~~~~~~
./arch/riscv/include/asm/pgtable.h:946:21: note: previous definition of 
'pudp_huge_get_and_clear' with type 'pud_t(struct mm_struct *, long 
unsigned int,  pud_t *)'
   946 | static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
       |                     ^~~~~~~~~~~~~~~~~~~~~~~

Reverting 06536c4857271eeb19d76dbb4af989e2654a94e0 riscv: use an atomic 
xchg in pudp_huge_get_and_clear() fixes the build.

The problem is that this patch was already applied to 6.17 just before 
release, so the function pudp_huge_get_and_clear() ends up being 
duplicated in the file.


