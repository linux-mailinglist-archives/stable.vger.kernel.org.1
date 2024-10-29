Return-Path: <stable+bounces-89193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647459B4A0D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207EB283D00
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0C204F6C;
	Tue, 29 Oct 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="UeRzOsV2"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81263206065;
	Tue, 29 Oct 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206007; cv=pass; b=Aeo3w7Yj4T49UqS5hZUPHOTt/+dljYs0dCuozhCcyB00GtjDuy7td2au+t6SiX8goEsSudkQwClhfECVV82euKH39pz0Oa6RMeDR+TvJhjWnqOq82YvTw7egLmos7/HMbTjHKK2BNGdzWMbab0cDz9/qV7qUb4qJgrU6FXF8+wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206007; c=relaxed/simple;
	bh=02O9OLW/g9ApFOsRDAht4QzW3rppeXYmBfHe9bZLecc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mdFkM0fq9VjSMf+hkw4Aa5Y/XY1OQdlVJ+kL3Pv314QWM+N8fMEev9WmxsQRqTT2LDfSL5G14Jri68umy3Cwpl6dAFnWP/ETb2KWyf0H8wh1nLaTwGnvZu/RbxsOgHdQmIe6b+7hRma6skivPQf9xY8EL3HdUy+60ew8IcJ7Xy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=UeRzOsV2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730205970; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cDlOP1p7NceXi8MBxpKNC28xiNDRPlp4fv20r0PUMrEAAgK5umH1hAiv3jI/fXfg96zZf1Ywco2Lyq2eTulzWqSi4+oYLD4H7b9iPMzf48ri7qdt8VXceYyj7R/2NXooWUvbQh8AYZaKkhP7HdIEAYno758MfE6lt1CKOC2vt6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730205970; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NhuvYhWtyx8/keKVS3fcnmffHIOcZ9CkEtjr4NvLsbM=; 
	b=FfWV30bmLYDpmM90KgvGAPP3xnL5O2cKimX3qmpmM+NfUnGqzn7zk6vf5yeVH5YjXyq5DJsqwA/9a0EOaYF6oiTEjyNfuzx7hOBdlHZ8sc0SCla7RCindvD58BYsJ0E9gUQA0dlmRc8ELiXrfWkn5vau1vglCav17hYzz8u/bYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730205970;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NhuvYhWtyx8/keKVS3fcnmffHIOcZ9CkEtjr4NvLsbM=;
	b=UeRzOsV2oEVqgpCquWQp5Dmr0kNSkJw/9cBSv0QQJ9O19nR4u5mlxuwk5y1Nzck4
	i+PC/wnUpOwEtf0bXWr34h5GmYHZWvTviZ3xaQY2cUc2HOiQzcsL9FGf9lE0R/jpw0v
	/8qj3pHpwEk1agkA+K07afkzS08gAQ8gtPF44h6g=
Received: by mx.zohomail.com with SMTPS id 1730205969715872.2644885507135;
	Tue, 29 Oct 2024 05:46:09 -0700 (PDT)
Message-ID: <f5ae659f-a6ef-4305-9f6b-280a8892a565@collabora.com>
Date: Tue, 29 Oct 2024 17:45:58 +0500
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
Subject: Re: [PATCH 6.6 000/208] 6.6.59-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241028062306.649733554@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/28/24 11:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.59 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

    Builds: 24 passed, 0 failed

    Boot tests: 48 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 6.6.59-rc1
        hash: ef2696e271126e75fbbeba63c906736842815c4e
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=ef2696e271126e75fbbeba63c906736842815c4e&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


