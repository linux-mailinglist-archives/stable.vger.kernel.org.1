Return-Path: <stable+bounces-104174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C09F1D92
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 09:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4EC7A05AF
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A414884D;
	Sat, 14 Dec 2024 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="b/UOZ7sn"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77B130A7D;
	Sat, 14 Dec 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734165780; cv=pass; b=nhcCczXCgfAGQuiOlgSPz5nprNe52qw1YBjukYBCuCXvX9vMMUtLMi3VAUfO2VIgcbe5zL18gEydI2jLsHVEKYTYa6XQ3Mag4STcBVkPYTSSG4D2iUjCqdiBc8YtIhmlxxtnpcvZYIH+m5uB6/VBHpz9AnBe/XovjrDLW3WWgcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734165780; c=relaxed/simple;
	bh=6AlhKAx/1iHoUMPGCdg5yrqxj9sHnH/tjN/KBU+blDE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p6/mJw6HnFLkUQ1xJBTDxmyiP9evZOtjU7O1YV+h4ghc+D3bO+K3bDT8pa3NteeB66BMqiE4w8A6+H/pCjl/LfSgjCcnBeB91XWWKqSChlHRMCvoa+n4gdK7bMUyPnkHGUoVOh3WFV+nYI1rGgHriMYjnJ0nyLP4oqbq6lqPs9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=b/UOZ7sn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734165743; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QKfxdgxLjaRYnb2pHBXr1aPg+CCCwuLW0A4tly2uBK4iHuC7DRd/AaTPfTjYXNZuPl1Zf/oJcUh8zcMd/cktlgSxKA6juJYaxbz/t4b3qjw9PdnnI3+u6lJg4NlhOutScJI8dvqF9ftfMs0+bbUHvIzQrRxk4nVC734f2KjWvpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734165743; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n8XHznND3mecvXcSXbHtaGq3xtRw1Tf/k5yZDvCddkA=; 
	b=C3t0tps2+gD2YnK96Fo5HM6EV0b+eqVuf0RiWHJ72VqAjJLL/+3RCTZHAtcUXcDLjzXHGUAGPFgmstcBGvin7WC8UElsGtluSI/U2+4o8AYaBivHMWjWAD3Iw53PX1w7PRJm2Y6nvtkPXJoq4uhYSYTUDxDTsPQSROn5PKXk1ao=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734165743;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=n8XHznND3mecvXcSXbHtaGq3xtRw1Tf/k5yZDvCddkA=;
	b=b/UOZ7snydCggikbfUuVsVrwROwvNJvLxInkVhUl4H8UeuFRNzIS5GR7k6hErIfx
	6t0XX+XcJVGY6QJPxTd/9rDAs1vpBLqyPmSBuJdmyjT9o06oCUlbG0ATRKfvaPdlaYe
	loCf3SBlwgCM7oPbum/JAMOzu0Gp+L1Gn+DBiMRg=
Received: by mx.zohomail.com with SMTPS id 1734165739581496.37692639463216;
	Sat, 14 Dec 2024 00:42:19 -0800 (PST)
Message-ID: <64035f44-0ef9-4eaf-b2eb-0a83b0fe3748@collabora.com>
Date: Sat, 14 Dec 2024 13:42:20 +0500
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
Subject: Re: [PATCH 6.6 000/356] 6.6.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241212144244.601729511@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/12/24 7:55 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.66 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.66-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
OVERVIEW

        Builds: 23 passed, 0 failed

    Boot tests: 210 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: v6.6.65-357-gae86bb742fa8
        hash: ae86bb742fa81e7826a49817e016bf288015f456
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No build failures found

BOOT TESTS

   No failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=ae86bb742fa81e7826a49817e016bf288015f456&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

