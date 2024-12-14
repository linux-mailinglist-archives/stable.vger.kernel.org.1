Return-Path: <stable+bounces-104177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9F19F1DBC
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 10:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A216170E
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85E13C80E;
	Sat, 14 Dec 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="YjoDe5nW"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E9653;
	Sat, 14 Dec 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167380; cv=pass; b=bdGurjYqzmt7FN15Y+BpTjYq4wCddqF6Y7aVk/rvRpYna819+kkGRGlJuEGJ1Kzy/VCyuzZ/v2LJ0vU33N+Bkapic+ER6dIQ9pdD6xoUI212hEHvOokRe0vu7KS1bs3DZtaOCUiRUrApuyjWYLLmQkn/0G9OCzNQfEMS5nYCxHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167380; c=relaxed/simple;
	bh=WzT2H42suMANIZoCqQsb9u/iwOrytohcYOuYX/upryc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bgnz+EagsUOv4mxfy7zwBkwxHzDZuhpTjhXnZrnaovvGsllppClwHJDGOAUxIw664ubd8TBMc3AQkHgbzGmWfcrwrlS5fXlHUx+q09YVViL+rH1wPbcp76XpSK0gzH8u9fiZJYG/0bD+qVJe5J2K4Byg77zbdpXk0u0mU0eLvhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=YjoDe5nW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734167346; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RQ9RoBBjiuQ3Cf+wmCUsftzHGfX97OAjN0s2SdnycUoEpnwBXKfJHGHBDnfOfoaUZMun1Llx4fzmUF/77wNdlxe3WYDw/5wKadeonGq635vE/B/yO5QTbpKDuZMQ6VbahdKAOrh4LkWaxhK0bQEcBKpHnXwE9u1WUHdOaVJw8G0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734167346; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rMpDg3PqsrHJK6VNXrao1mLWt9EKJHzRUN6KozvsDxk=; 
	b=mkij/zSTLxVBGexVsvgnQhyi7xPvpK0qeiONa9XKilrmhd+515ZET56BnV0K7XXD021cIQdkdBC6hrevyd5ubsRudxiTz1puvPeoEeqXdZyCymMEhJ+ZBgMrY/7NeZItDglTVls9uhDOVYFi0/0Eps666tgPYfkR+wh7NWDQiuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734167346;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rMpDg3PqsrHJK6VNXrao1mLWt9EKJHzRUN6KozvsDxk=;
	b=YjoDe5nWzsHLkYNlCKuVbIFrGH1oKwJO+Yha8y3vBbsCE45UTHAjOABjmTCBrzcK
	2v8IqACxgwQzxtJgRhDVZMtpi0c46UVva1yjqKpAJy2lB40SMyOqWuNcXE1eLy3aRJZ
	tBXiME5GkHjqFRKtUYx+nR6B/EtQb+IjPVODzZ5o=
Received: by mx.zohomail.com with SMTPS id 1734167336646176.72621176386758;
	Sat, 14 Dec 2024 01:08:56 -0800 (PST)
Message-ID: <39529994-9170-42b7-90b7-e203ead4b6a2@collabora.com>
Date: Sat, 14 Dec 2024 14:08:50 +0500
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
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241213145925.077514874@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/13/24 8:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 29 passed, 0 failed

    Boot tests: 219 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: 602e3159e817475bec9784ba359147d8351e90c2
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y

BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=602e3159e817475bec9784ba359147d8351e90c2&var-patchset_hash=&from=now-100y&to=now&timezone=browser&var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

