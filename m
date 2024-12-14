Return-Path: <stable+bounces-104176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349439F1DB3
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 10:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C020816882E
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFF9190477;
	Sat, 14 Dec 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="XBT+EA/G"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2418D65C;
	Sat, 14 Dec 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167094; cv=pass; b=eo6tOLHrgFsZ941cMQ7FmxIg+ZaAV0mD0n1Z0q9mM+BCUVTDvF9cnvVXMJjsLjuN4fPAo/jH+bgUxgDurEna6Ok39477X4woYmRqJcD9w2oZ6DSMUA/4lhJJWrxDXJDdkrpnALbrdVjMgJyhHdCZ3iA+yq6L4ifov/dS0VazECc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167094; c=relaxed/simple;
	bh=1He9VPyzzGAt/8vkD2zd/BuXMB6nP91bLzaUmhS3Gfo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sCorSkrd+7rJzAAW4PlZfqOV8oi0m+Aazeyie4be7MBq1pQA+ee4EgR9rrB/HvJyiVColyUMbSGedGYYKcfKhYahEylRuGj0K52rBPa/OiID4x72YcU95uFTZ9OZqUHlGkz1l1cX1gOWazdy4NJ1Fjay+Hm9/k6xWMoIaQf/iW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=XBT+EA/G; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734167055; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B7l1lH1qKwdSNoYCP1SPZLpKmRmu3FjOpXI/6dtV4zLmsfNoMBSWpcxnXd192LTBIxRKOXU6fm1nHeepgQ2Za1SSYqKe0J9cruJgVuWhmYABGrUp3FYDLiEoYclUhbkcrtES3wlzEEzT+Ie46CfOnhaxxDixARkeQBy3v6L3C0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734167055; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5X/qMK8uWDwJEEr5QG+O2Mwg4z56SzMX6ttnOEu4AiQ=; 
	b=JCF0d+uM+SxkSKiuf5MSaSpgxT7VU2oD7U2sxGZr9SipGKpJl+kptXHqB7Ob0NIiIwOGKLi1oxMX15+1npbj760nKkeIqPKrbdGZFuW3fQ/lVZkNrQ+kw38+oFQ3RfL0pYfS4Duu6XOd5DRCV0E6ojO58qkh7OA9Os3hcAvmcLg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734167055;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5X/qMK8uWDwJEEr5QG+O2Mwg4z56SzMX6ttnOEu4AiQ=;
	b=XBT+EA/GhJNqRH+n5xL/nwcZK+PBSUj7zPCoQmwtIkvMXj/JgnbhKelDkYjo1+Gl
	rYMka6zMZXG5/mxtqTIzS0OPZsKkaAx1aPDroq7rPsTuE5h9BV6xLohFNWOP0NcOx6a
	yBOQZtMI/x6fKBVjLVbApcBDZtZT7d4eOAdxpoY0=
Received: by mx.zohomail.com with SMTPS id 1734167053567164.33484110014615;
	Sat, 14 Dec 2024 01:04:13 -0800 (PST)
Message-ID: <73fda05b-a89f-4dbd-988f-487f2fb9c773@collabora.com>
Date: Sat, 14 Dec 2024 14:04:16 +0500
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
Subject: Re: [PATCH 5.10 000/459] 5.10.231-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241212144253.511169641@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/12/24 7:55 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.231 release.
> There are 459 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.231-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 28 passed, 0 failed

    Boot tests: 154 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: 26bbc21725ae44d2b10994af6d0fe6b3a2bb9d8b
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y

BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=26bbc21725ae44d2b10994af6d0fe6b3a2bb9d8b&var-patchset_hash=&from=now-100y&to=now&timezone=browser&var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

