Return-Path: <stable+bounces-111840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA5A24169
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3572918824C9
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42961E883E;
	Fri, 31 Jan 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Zv2cqTY8"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF492563;
	Fri, 31 Jan 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342736; cv=pass; b=sawfrLaJdQvCsUMVPeDTt+GFTJXbo5xk+S6vLsxSaw1dMd0TeVy9aDPAIAdk+U3hE+UcbLa+aoCs8Hr+wi2MfQimv1jqPV9vpFfIpw+CYp1vXEHdpn71mUeW2n3/9mn26M0VzECeCP2iqGWtJkQWdcoA6v5m31dAfkGd2vPmBj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342736; c=relaxed/simple;
	bh=Z0/uvBM1uLCruURORrh8CcBoNSWIv2Rw/zvyjTHE1XI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bJVH6WonTrQu+RRGX3LLqZ6Bp8Ub11lyk4O34RcuFatj5HJwG6o5xLnEbdawWIrFrJrS8Jupr9fG2F8eypJfeYYB7Txt6YD37jdxOGTNl3x12obIhQ/NY35zcifwkLHdsNuZWDIPN7SzQdzPZa8L4lD4VaPDyGgCqF7mh3kIaWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Zv2cqTY8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738342701; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bbr3DBjF0vcWguNtBN7/23NcD+MS7Q98KvssLkgDxW81EIBDZB2Oe2rkLfPv/N8D3zADBS+5XX8WQGraGcjt++l2IZ/cbnK2yU1ZL8ol4Hqw8DZJDVTXt/2JfcGLWkFJUo+IlmLQjKWLVXiLOvQoWm5tfIeWkgdeXgO3AZmUSKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738342701; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dXN1KgLRi3fL15qmkgMOuwcW79Xetrl527huOTLWtcI=; 
	b=XcprMYoS0PmD/vNYYOLKqQP3FAvJpLpBMYqKd+1ZNXuZZEPxYQV5e4KtSz+3ncL9rw3YIqUD2BGv+cfqvJ9EC+QPwHbfv0sEUH1Poz/oEgU5A7qA5byd3EV5rbj2SHJyskT6CVXUw9UjcT8isSVbBTt8vqxTsGGc/qLSVv/szRE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738342701;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dXN1KgLRi3fL15qmkgMOuwcW79Xetrl527huOTLWtcI=;
	b=Zv2cqTY8wsRUOlYQZouAvSU9rlPkgzeV5gG4c4H0wsudlSXcQI494P/MEhFVsjAn
	Z35v+xRXD8nmwyBPbqyREeHEDOXLprr3EdjnpYS7YlX5DEPORQd9irsI4QCVB3yuJT3
	SQqNuU6Zki5LVk6Xw0SZ3/QahKwrEyLlct3pBy5c=
Received: by mx.zohomail.com with SMTPS id 173834269531525.416120751365952;
	Fri, 31 Jan 2025 08:58:15 -0800 (PST)
Message-ID: <d5dbdce7-20b2-4317-9d2e-bd7653c3910e@collabora.com>
Date: Fri, 31 Jan 2025 21:58:34 +0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/49] 6.1.128-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250130140133.825446496@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250130140133.825446496@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/30/25 7:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.128 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:01:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.128-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
OVERVIEW

        Builds: 40 passed, 0 failed

    Boot tests: 593 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.1.127-50-gda19df6ebb6c
        hash: da19df6ebb6c09ded78f67e201f202979c1a5727
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y


BUILDS

    No build failures found

BOOT TESTS

   No boot failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=da19df6ebb6c09ded78f67e201f202979c1a5727&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

