Return-Path: <stable+bounces-110278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4CA1A52B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C86D3AABCA
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A720F98E;
	Thu, 23 Jan 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="eM1KfWAA"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD68320B;
	Thu, 23 Jan 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639749; cv=pass; b=BM5T2F/LLYlBuToL1U8TM6K58nmZWgJ9Ou1gZ48hCO7fpvNL1t53tzG3IBh36vd3Oi6kEomOnNgDL6OvnUfsBplEj89Q4nIdqJr0dvvu4HFetjgQXNy0FyPf/SMTdJszIGcGhJsf1cEP5Nz5y/RTwy1V3lVskw5VajCuDrgOsrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639749; c=relaxed/simple;
	bh=zb52plhhpG97x9+fLMA1zvPEbWHuvd7b09ZY188XepY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XUUb5XQICvbEo0nA7ER7KTXotXljQFEENw8d8StxCfLhwAAWlqbpu6wwWBDUz0RIBlnTz/xjy/o/m/rUnN0tFgB5DG7SIAk0iit1YXjY+Si8p0EuW4a2Hx1ZkTeJS4woWA+9SXBDkB5V8uJVEs6LalC9HywPLGSzq0eo29OhIbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=eM1KfWAA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1737639716; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AAqworgE75vpPDMyJyyEu7fW9p0GP50TgQMJrRa7QynF9OhUMn8b6oGsBBzDFMJKSjEI+wlT1DgbMeekSLc/MGptShe/rLodL4yS1n1Wj/gPkU7TOfjsy6edo7tVILDn5grMOLMK2jXEouJrtsSXj9DDX6Hyr0fGOZUvYQ9Gq3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737639716; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0XUElGNugRDuLIKHlQXSokKY2Ws3jPy8Fm6nuH0Ud98=; 
	b=PSy2BiVWuyFXgRVFR2x2JQw6feUZbQtw95h3gWTGNKSegTRN4fW0Zlk6SMvtNwXtzFpiDzV8Te7k6/BpQ8m8J73JU9lCUDLpVDIjsMkVcApgDu1qj+2DcHaN8waixxr4jMvUkjY3SmxId54aIApZ4ipXKiDznEzKTQm0CsRiPUk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737639716;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0XUElGNugRDuLIKHlQXSokKY2Ws3jPy8Fm6nuH0Ud98=;
	b=eM1KfWAAsyQa8eVqPk3FDF5MIRUlMFXdMGTKhzMtKcU2VyO82m4TY91kSKjfuorR
	hMdWi8bg1g6/CmAhYJ5RhbHBld3atSlNouf06wmEyIernp1PR07rY+ZG3aWbfdmhuSH
	z0g5J+S0uVrMGxAvt4FhdL6GtN+ucGFTRNEoH6YM=
Received: by mx.zohomail.com with SMTPS id 1737639709008252.96416316737213;
	Thu, 23 Jan 2025 05:41:49 -0800 (PST)
Message-ID: <c7f148fb-9d3d-4af0-ac19-f375f64a46f4@collabora.com>
Date: Thu, 23 Jan 2025 18:42:13 +0500
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
Subject: Re: [PATCH 6.12 000/121] 6.12.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250122093007.141759421@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/22/25 2:30 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2025 09:29:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
OVERVIEW

        Builds: 41 passed, 0 failed

    Boot tests: 693 passed, 1 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.12.10-122-g0bde21f27343
        hash: 0bde21f273434bad90411f296c22f02c62c07b2e
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y


BUILDS

    No build failures found

BOOT TESTS

    Failures

      arm64:(defconfig)
      -mt8195-cherry-tomato-r2
	BUG: KASAN: slab-use-after-free in __mutex_lock+0x6dc/0x8b4
	https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:6790e14309f33884b18dc40f&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=$__all
      CI system: maestro

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=0bde21f273434bad90411f296c22f02c62c07b2e&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

