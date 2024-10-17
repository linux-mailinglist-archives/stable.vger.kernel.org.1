Return-Path: <stable+bounces-86617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5169A23D2
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE7B229BE
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADF1DE2B9;
	Thu, 17 Oct 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="euxmtI4w"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3521DD865;
	Thu, 17 Oct 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171900; cv=pass; b=Au1ZXBl9hV0VpjHPXbD3eMGr70KmAQhZcQeqIou6V/Ma7B9Mq2wLQIOW52RkIl6R4hBBafz0OOi+IQFnZ7vkAMbA7ajjGpxJhkDVgaFbzTf+oAd8r3mKXf2CmLN6G47erwYdaikB0X5BTf0AQStIlTsQZV0CBuyg9//qu9658iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171900; c=relaxed/simple;
	bh=9DkEOCmrXtQD7nEqOcbDJfP/RBjbw7rE5b+96dGjzoo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AMYJVXZa7FHwIw5qYEe734uij5fSCHimNTKeIfdBnEF6XefMPC4zFJg2fv9kI5nhOLMByb7VFzcW6neQkPgZeVtGRhlmIM7u7osrGHnFBwqLn+Cc2NEPTr5KNEOxL01VLg2vwmo/NDroh+/0ENv1Ka+Ey4g2g+pUto2i3dAYLfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=euxmtI4w; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729171849; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KNRaz+wwXb5teQvBtcZ1QIfv3JAvPlrz/yzpa0tdbctPPXWPq/0Ll1srfwmt0OwaZwSlOrtsgte9FvRbsTn6G9YuWJQqER3RVPLRHHPUNf3zwlgaFhD+zJ3z6ZJio/wGVAYNfl9m/qHjeY3v7cbCwYJNCUobLsgA1UVkpvJjJ6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729171849; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mSoMR0sUB0OKM7ZHE0TAoevDS1sbnz7jCqSJagBCX6Q=; 
	b=UAmmum5gHjNeiLZhuwct9ceQMl57BDSj+GKyllWgMsLHR8EJNjXd+mUF0HtyjI58Hi+VO0HzUpOBtlaQtjS/3HL6dlImOIrDw/L+HLFS9JJf/DIABhKwom7IMhUI+zoOuwPO1+WkZTsQMLWvknhnlxpcQmeYMysBTrhj1MZ+TRM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729171849;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mSoMR0sUB0OKM7ZHE0TAoevDS1sbnz7jCqSJagBCX6Q=;
	b=euxmtI4wvPxGP1Jx9dKzKQyEcnNAsmfya8dKsn2gIBaEwBCd19MKiHEI7/L1+bbA
	4BotRu7EhS7O4XFW70lCJFpfC1p0844HueH1Dh8aeusYIlEFHTjQNfiGiM59c5f6keD
	HeBnzOAsgd+gyxZ1E34hOLd4Y/PDnZC267ZsAW7o=
Received: by mx.zohomail.com with SMTPS id 1729171846638242.53724024989015;
	Thu, 17 Oct 2024 06:30:46 -0700 (PDT)
Message-ID: <959cb2c0-cdb2-4c74-bd6a-76468789d615@collabora.com>
Date: Thu, 17 Oct 2024 18:30:36 +0500
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
 allen.lkml@gmail.com, broonie@kernel.org,
 Gabriel Krisman Bertazi <krisman@suse.de>
Subject: Re: [PATCH 6.11 000/212] 6.11.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241015112329.364617631@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241015112329.364617631@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/15/24 4:25 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.4 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc2.gz
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

    Boot tests: 72 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: 9e707bd5fc5996c97d762a16515399c2afc4d70d
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=9e707bd5fc5996c97d762a16515399c2afc4d70d&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

