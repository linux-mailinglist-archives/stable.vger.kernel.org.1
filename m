Return-Path: <stable+bounces-87808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA85F9ABFB1
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 09:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254DA1C20D24
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 07:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A694149C7A;
	Wed, 23 Oct 2024 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="ZIptjTDa"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AADE1448C1;
	Wed, 23 Oct 2024 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667059; cv=pass; b=FdMzf39sXRpOLfuKZBtY5Z9PZa/fjbouMcXyYcFQRHgGuiKVSp2/ulaDgcnWksvwg0QYoZ2MGb19LcDpz/rt0CFQx1MYlRdy6/toZ5H/VO0CtjtQUTnnmmrAEVymOJaoibljQrZRptQQwepGcT9kJCdAsJfWXxzW5ZcxYrXMaEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667059; c=relaxed/simple;
	bh=xpckz667ECUV5SqYy6i40SypV2TRZYJrg8Ltbh0tDbo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PI6R6ZB0L5TCZODt+JG0MwB4l5+R+ewleCi0h/JiXp2bGTMc2jLMI4/TZ0H8uBO2bH54jgSMRS8/7eq8hf5pJr7dAx515IdVUOjTGopJojUQQHpOxsAdCcEmTJLGbI62NZOzOQd7dS3gLqWTQTrFSbFTdR0/YzCv+8IdzxoBhVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=ZIptjTDa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729667011; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i2dBqxVEL25f57hIMwkSAqcEQ0YCse9Gmbsa7u5TdnZNVx+CLKTGXVh8c3b0SWbOIbEvpzoDZyZezVlhJ64KCD3MDkwZ/Vpd8Pp3qewW/UkueeLZr6qU8XNVwMiCwQuTI0D2Eim24nRPJleGYPtD0Mn9MGzkguofjiBp8UDxHh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729667011; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fc8IEdKD9REzwJIzIqKTlg94QTjRn2ZW2QNsLPievH0=; 
	b=ItFMlo0EKrMERUpSyFbJ1eL1DEwCWJqk8kbuQj8qjWIZl8aN09Vk5+RfWNTEDhwWRdyJo1m53QDre6r5i5VyJLaVyuBm7qhg9NA5k/BFSY2afVFYtsZXnJbsQCua1K3Kmw9fHHwOSPB4AtYbBPbPa236Wj6iA7T432CZmMfQmBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729667011;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fc8IEdKD9REzwJIzIqKTlg94QTjRn2ZW2QNsLPievH0=;
	b=ZIptjTDaA7YlF2NPRyAy9rzKa2uPNkMPaWrQAvT4I7TIc6WyotM4zNtWNxvYWeoR
	0AaqOr6Lfc88WOCpK7sL+CoHfCZ6m2ZHSwsz471iLpqTHd24xhJLm2wNvWABa8Cq8lD
	xpM0Lr16YZV1fqKhds2kV07cETIsddBNkWJ5iJV0=
Received: by mx.zohomail.com with SMTPS id 1729667009606741.3329161747271;
	Wed, 23 Oct 2024 00:03:29 -0700 (PDT)
Message-ID: <24a31123-2c84-4dc7-87e0-c6f960a31e5d@collabora.com>
Date: Wed, 23 Oct 2024 12:03:18 +0500
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
 allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/135] 6.11.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241021102259.324175287@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/21/24 3:22 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.5 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 25 passed, 0 failed

    Boot tests: 76 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: 96563e3507d7fd82e448c6803ed8e07bc6e5ec86
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=96563e3507d7fd82e448c6803ed8e07bc6e5ec86&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

