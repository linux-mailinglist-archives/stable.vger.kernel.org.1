Return-Path: <stable+bounces-104178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BC9F1DBF
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 10:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCCF188BDCF
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4F149C64;
	Sat, 14 Dec 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="HDBUHmtZ"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E085931;
	Sat, 14 Dec 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167577; cv=pass; b=Nx7KJKXxoFTnGUdfVIz8ziHn7IHb1dFjIdHuGlFNTqamO5F86EEzrtxZvKFmzc7gE7NHSQ/B06EJiRWnuuR6FGn4YEkBPVyKUOhbGb9pazqTHx6J0PFbM79wefkGFjOSelThXJSI1AlZTk9P5FeGAURmMd85ttu+QfnvcYhdliY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167577; c=relaxed/simple;
	bh=rqxhnA8A0KeOgGUnhgwKKXMMFF7IkngepTolrWR8SIo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dIfIgbPUGTL6fyHQGmZ708/juzn3A0FHg1O4h3VFGDfrWEcsrqV2+pIPgvNFN8lsu9ZF/Ke677E+bfcu8cfgDYXZUKmbyLN9Q5RAEowmzpym/de8LQ+4vsMn8Twl2y3pT3o62BH4ZibzF+sEWv5LTus5Icthi3mb1NAWiitsDDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=HDBUHmtZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734167542; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IXyV2BLRWmuvG7SCPi54P0m8XujHk5IfURrsKQOo/aiD88v+zmTfgex7Bi3zfr6GTzUvmYWv8mlbZaO6pfB2ZS67uOPlUx/DDKKKPUcjWvRKCnzpMWg4gU2D2iwXQXw8Fa8BXPE8BO7tuSx8rZJlsf4CCw2I5DjXDE353TlM6PM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734167542; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7AnWaPrp1VKHIV/9CIuxyuxjrF88ogLbUzlWksJedFs=; 
	b=SCKA453JQm+LYc1LNhNXW2oG9IoZ8H+7CsGx0CqSfPZT4fuLv019xc3idSOieFrvfRv5JqQKkEvTTqObWXXrdcFm7wDO2gZe8r+f0Aee0Z5P69+atRfEgu2E8Xfz9ypZrALtDWh9bJA5dQX/bV9yQEBcDhIYXfHIPaP6Z+CdvrE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734167541;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7AnWaPrp1VKHIV/9CIuxyuxjrF88ogLbUzlWksJedFs=;
	b=HDBUHmtZe/nmu/rVsXmgzLvFDu/bZ1PC2htQtyLuP7lgY1JdeYr6qmkZ+J+UJDhO
	mwmWeBNfsiEWyOvH4i+eGyvmvlQnPo92YpIkr8vmsoakR66WIhTNOB+cqX2QR9YhfAl
	XwTYkR85pBOjn6mAaEcEi/0KaT1suoxIqk6NJ+1w=
Received: by mx.zohomail.com with SMTPS id 1734167540627103.68660638617507;
	Sat, 14 Dec 2024 01:12:20 -0800 (PST)
Message-ID: <b8f4e53c-25e1-49eb-8df1-07bf3cbe5531@collabora.com>
Date: Sat, 14 Dec 2024 14:12:24 +0500
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
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241213150009.122200534@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241213150009.122200534@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/13/24 8:04 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 29 passed, 0 failed

    Boot tests: 213 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: cb4fbe91b7b21057b4bc23c91e5fd87c0fb79e47
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y

BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=cb4fbe91b7b21057b4bc23c91e5fd87c0fb79e47&var-patchset_hash=&from=now-100y&to=now&timezone=browser&var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

