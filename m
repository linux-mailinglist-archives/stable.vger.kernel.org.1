Return-Path: <stable+bounces-107984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0906A05B98
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585451888441
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98291F941E;
	Wed,  8 Jan 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="jc5fUKD1"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA11F8906;
	Wed,  8 Jan 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339269; cv=pass; b=iAdlSxxxCVikeSHKiWdnz1bQd0T9alywupTjZ78czG0MZ6wsmzDsVQm6MkxcyLI25zaGAGsgu7yPSr9pt4HAKzN4MfilR0QBnX/BmNh5nm1NXOasLSReYf/osStpWIvXXSZNEWY3MJ0Fm9eQ2pR9LKaUb4Vcvm1iNkSeqnxrukU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339269; c=relaxed/simple;
	bh=HWTdt1DU9qCpMKRrSvvrH/p1pP5OJXdhC8uGHcMaGKg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nP1sST0Eq9Gy9t4omuRrseQT70xhOGWZE2T0L3YUepT1RLvfYYfsWqLKd4E+bkQGkCOFCl8OK9t9L0Kx0MZmsSsbVQb4Il+1JrJgQB60kqb09b7r0dEl7uDmF08TwpwkqPOfds/quksmsI3L4d/BM1gsJOJ9cIANwStXwLUDuzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=jc5fUKD1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736339234; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JQt0aGGy2fuhIef3U3cntj4rW2QwqjiT6rtne0I4aB4VHl8EDxEkyJzUJlM+FCJaXdlfUQ4ATUdxXc2cJtNE8Oclwe3e+XHLb0A84zzb+14/gBLzk6Ac8V3ypdWxDgRNCjGxi3clRBr2t24YksSIb62YvkN3750yGPdBQHY1VRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736339234; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S5+gnTTvJtTDpVln+yMS3ksSeB/H8kIqzjZctPPJLsg=; 
	b=dB5L3yRQgUP0jftch2biNJY3dCGSehAz9OYuONZzquFW6c3clnfOrt+4EvdTQU2/Pp1bxWThSHBm2a/zGhuUhlNNpLBH9McEPHDxu3ocQuPDEk6iHXa4JyN1pjy9/EPsfUBPqZLaz1U+GrZkoFmKKGrzsNnHDSlJJFXlWllWvPc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736339234;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=S5+gnTTvJtTDpVln+yMS3ksSeB/H8kIqzjZctPPJLsg=;
	b=jc5fUKD1PIlCAD2IhIzR2e72HchRSrxCZ0LQkCmxYJAx7GoUsK3mTWyiL9DMd6QG
	URFpwbwSCjThyoxnjkQzQxZICNebxG1OU6WeWw6Y/+YPg6XABRQtrmTEFyq5aehXQkz
	yOCUldvpJxAD91FJWpWTieVp+pKQhgcmTqLDuMcE=
Received: by mx.zohomail.com with SMTPS id 1736339232110462.21635361600033;
	Wed, 8 Jan 2025 04:27:12 -0800 (PST)
Message-ID: <cbf4c67a-7ca3-4823-a5b9-a0ccb49e7f00@collabora.com>
Date: Wed, 8 Jan 2025 17:27:28 +0500
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
Subject: Re: [PATCH 6.6 000/222] 6.6.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250106151150.585603565@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/6/25 8:13 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.70 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.70-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
OVERVIEW

        Builds: 38 passed, 3 failed

    Boot tests: 358 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.6.69-223-g5652330123c6
        hash: 5652330123c6a64b444f3012d9c9013742a872e7
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    Failures
      -x86_64 (cros://chromeos-6.6/x86_64/chromeos-intel-pineview.flavour.config)
      Build detail: https://kcidb.kernelci.org/d/build/build?orgId=1&var-id=maestro:677c10a0423acf18d2737e91
      Build error: ld: kernel/kexec_core.o: in function `__crash_kexec':
      -arm64 (defconfig+allmodconfig)
      Build detail: https://kcidb.kernelci.org/d/build/build?orgId=1&var-id=maestro:677c10aa423acf18d2737f1a
      Build error: drivers/i2c/busses/i2c-xgene-slimpro.c:95:9: error: 'PCC_SIGNATURE' macro redefined [-Werror,-Wmacro-redefined]
      -x86_64 (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config)
      Build detail: https://kcidb.kernelci.org/d/build/build?orgId=1&var-id=maestro:677c109b423acf18d2737e5a
      Build error: ld: kernel/kexec_core.o: in function `__crash_kexec':
      CI system: maestro


BOOT TESTS

    No failure found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=5652330123c6a64b444f3012d9c9013742a872e7&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

