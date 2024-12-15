Return-Path: <stable+bounces-104180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6FA9F1DC4
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 10:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF58188BD99
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1915383B;
	Sat, 14 Dec 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="YktAS6f3"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36F126C10;
	Sat, 14 Dec 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167865; cv=pass; b=OKO/PdDktNtaWojA8BwjIHccntwSABwk2mpAr04BE4LMASVR5bkcpy0evFM39oe4oe5BnMkXE1HoVMI7uwpYdFY245VL4xmG4MI+ugoYVnkcuH/QGdOsbxbRiM+XTmmy1N+6u0id95eN/i6P/cqHceQ2AJLCnJ0DTIbtxZR1uE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167865; c=relaxed/simple;
	bh=3yQWs93OsT5foCFOxASMVoLXO2ADman8M923fVuDV+U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z6Zrgk+esQBD59Nrs1PR+SU2P5MBt9qtLxwFaAPsByE2Lk+p9S0fvivDIfBp8qpEib0a9sQyaUWQqb2zgcdapAgqoFtHo0WL0Mwvgozr7h7B3mxqO5+abrOBG4D/rFUhxQVWLAWDW5NrjytPtThkPGH9q0vnLymWWLCnFv7xXEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=YktAS6f3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734167828; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MfmXIIJq8HMEE2EkgH6+FVYxhW/hBFSKQlLuj1AKmzyqFaSXy1RJzJ5bv9AbZGSObkAuB/tcaETJI7fwmanxzNYpqgi3hNnNG9QrDkhv0aQ3Vwznh54AyOOSuhFx1KtODZeMHA4Sb7Y4N9AD7E6yZbfER1NHLaCy3EkzRSHqxp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734167828; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UnyxacEJSTEgdFNIKKqgMJvx6u7/uWoG1+Uqtvejpd4=; 
	b=h9OiLi9ZDGkBRvbqRb8nUR01AdAG7PvxUQMdow8tcBl7KMXmoZCNPCvZLSh9q9aTsB5dVmZD9HSR9fN3yIjGUR48ok/F8U3yPSmzmcP20T0JgnhO0fUucghYzTJhV7edEEp/TfbT17LjaehN4bPSE/oSHfsJDNMBmJt23Apjn6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734167828;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UnyxacEJSTEgdFNIKKqgMJvx6u7/uWoG1+Uqtvejpd4=;
	b=YktAS6f3IGo5UstMWQ2FBk+R/QIX3T0CYdRCYY0K13zifQy0GAkf5G44qNKQz7qo
	Nrp6hKMZ9LZ4cGQOoe1oDQOtoviUHXKYNdpSvFHHSffsCuJtN7xjJC5xQdQB+aPvpz9
	inJZ8FRVCbWTJPgNC8py+GvLXTktvSkpdQ/G1d8E=
Received: by mx.zohomail.com with SMTPS id 17341678253140.36163794351750767;
	Sat, 14 Dec 2024 01:17:05 -0800 (PST)
Message-ID: <2a8cd083-46e9-4ba9-bca7-710d743f4e1f@collabora.com>
Date: Sat, 14 Dec 2024 14:17:08 +0500
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
Subject: Re: [PATCH 5.4 000/316] 5.4.287-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241213145847.112340475@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241213145847.112340475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/13/24 8:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.287 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.287-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 25 passed, 3 failed

    Boot tests: 153 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: ce5516b3ce83b6b8b6f21d8b972e509420b4b551
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y

BUILDS

    -arm64(cros://chromeos-5.4/arm64/chromiumos-qualcomm.flavour.config)
        https://kcidb.kernelci.org/d/build/build?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:675c5836ca49c97d299f2a45&var-test-path=boot&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=yes
    -arm64(defconfig)
        https://kcidb.kernelci.org/d/build/build?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:675c5870ca49c97d299f2a7b&var-test-path=boot&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=yes
    -i386(i386_defconfig+allmodconfig)
        https://kcidb.kernelci.org/d/build/build?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:675c5877ca49c97d299f2c3c&var-test-path=boot&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=yes

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=ce5516b3ce83b6b8b6f21d8b972e509420b4b551&var-patchset_hash=&from=now-100y&to=now&timezone=browser&var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

