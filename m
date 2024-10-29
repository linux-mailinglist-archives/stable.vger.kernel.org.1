Return-Path: <stable+bounces-89208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748AA9B4B3E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B6A2852B4
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB27B205E1A;
	Tue, 29 Oct 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="LATJN8O+"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4920110B;
	Tue, 29 Oct 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209798; cv=pass; b=nzm0Dzq6juj4ghvwoj/0iNQZ5al0pcrRzmdLTyz3+cMJ6xroL4wTepqCr6WnL0BKUTseamis5r/mNVi4rYdRFeAmY1iSqXIvaHGFBORJiQUhTX4mNY/+ozYRmzPzsn7ytTu6J6HKNMtCEPxXjCF6zMi2wds/KwE61FxSLwGuEzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209798; c=relaxed/simple;
	bh=F39Zxt52/uYIVPs0noJon70t9/prHhMkYYK70Fp7PpI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T/2I1APCaof/QeIlmfuEIgiBZQcX2yN7J+zHhIT6NNKYnXcO/X7pdrM/pQ0vgiBN1+rlDNyjiP+lUlN0V18ahRl3pXWQVUrNm1A813lu/lpS9LLoTciojiCK4pPRdfX9q/yF97WNNOHig1qEAQLy4Vrq2TnFmWCDTk0Tcp1Vf0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=LATJN8O+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730209759; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IKjbnpKnedHPwU63t/TG3uQIMr5Bvhy4WlULsaFWsr7uuyT4kHXZP1QMzV7nxOaEVqSB/5EpS5VRiCKwBSOti67lytFmMa7odfFyPCzfEdpY+6Ul41sxgjVIgRCqTrXxsyMT8Vg0FthdOpU58uoPD+MM2uG/ZgpPv5j1BSNCIsE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730209759; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W2t9ORfbeHQkxlu0Wwgx514p3UZMGd3XrzkyhczjnCE=; 
	b=hhffQynpiHgSE5F1idt8pIVTrHqaHHTHQAiwuWqQMexVAWbLV1G35XB8N2DqTQ1LanrS/FKv6hxc61lSUMDZ8fNxNUx3TqNgUNWsDgAuibrjY8t7KtTBQyLaqD0njWJdPNEbOQ6X8pvtngFAioxPToftrdX8WakLt1F+ZzCYMHc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730209759;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=W2t9ORfbeHQkxlu0Wwgx514p3UZMGd3XrzkyhczjnCE=;
	b=LATJN8O+AnfQuNFax+W1MMvkIoJ0YWKWOkB98TTCf+ix0JA3RjKNvSBGIZh7BizV
	HMm4ec1vZrGmjfMR6HeIhx/3dT6UZ+R6MMQjgIgc6wCU2zbyyH+IizterJ9hEJdLYVQ
	2RvNt8NIe6jkU0Yz8LnWg/zNjva1mA41HDzptCoM=
Received: by mx.zohomail.com with SMTPS id 1730209758314303.6390804850106;
	Tue, 29 Oct 2024 06:49:18 -0700 (PDT)
Message-ID: <5ab6b534-81e7-455f-8494-58e1fccb84c0@collabora.com>
Date: Tue, 29 Oct 2024 18:49:07 +0500
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
Subject: Re: [PATCH 5.15 00/80] 5.15.170-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241028062252.611837461@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/28/24 11:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.170 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.170-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

    Builds: 23 passed, 0 failed

    Boot tests: 39 passed, 6 failed

    CI systems: maestro

REVISION

    Commit
        name: 5.15.170-rc1
        hash: a203ce258bb66ceea0d88b41de9b16cd41a6895f
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y

BUILDS

    No new build failures found

BOOT TESTS

    Failures
      - i386 (defconfig)
      Error detail: BUG: kernel NULL pointer dereference, address: 000002fc
      Error: https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-id=maestro:67203122aaccbda536603534&orgId=1
      - i386 (defconfig)
      Error detail: BUG: kernel NULL pointer dereference, address: 000002fc
      Error: https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-id=maestro:67203125aaccbda536603557&orgId=1
      - x86_64 (x86_64_defconfig)
      Error detail: BUG: kernel NULL pointer dereference, address: 000002fc
      Error: https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-id=maestro:672030c9aaccbda536603435&orgId=1
      - x86_64 (x86_64_defconfig)
      Error detail: BUG: kernel NULL pointer dereference, address: 000002fc
      Error: https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-id=maestro:672030cbaaccbda53660343a&orgId=1
      - x86_64 (x86_64_defconfig)
      Error detail: BUG: kernel NULL pointer dereference, address: 000002fc
      Error: https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-id=maestro:672030cdaaccbda53660343e&orgId=1
      - x86_64 (x86_64_defconfig)
      Error detail: BUG: kernel NULL pointer dereference, address: 000002fc
      Error: https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-id=maestro:672030cdaaccbda536603440&orgId=1


See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=a203ce258bb66ceea0d88b41de9b16cd41a6895f&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

