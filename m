Return-Path: <stable+bounces-111839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4AA2410A
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C7D163DAC
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEEB1E570E;
	Fri, 31 Jan 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="JdVYhf/b"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D40335C7;
	Fri, 31 Jan 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342316; cv=pass; b=dVPmCyzO1C3okr2MWRpVzEvzsgRI32GDnLdyC0EkXQdL3qWKFkll5fWlUdIc5QNN8iOym2lk9iEYYMCQJsoQIGeq2PscKeP0LC9JMo6VkYBV+sDIgJqEsP6icQ8zHZ27ErTsGYKEeLC6sSxxOEz6lG5jIFRkrygtGdi+84ZclJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342316; c=relaxed/simple;
	bh=x1iGMUUcu6wW19i38W2Ur4xL3NEUn11Mon/ruDx06w4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=adUGl8+faGcISP1LAFUvW6y9pm/Sqg9udF3O4yQ6iOds2TMPVPPvJrHgN0koSqi+IudbXA4OXjpz+ejPJj1cRuHRRgscGPsA9d9ahT6iJJ4cbRyDWPoTLGvOL19pTsqsxrr3SVdPotIH6EdHsws66Qpxcp1Di7NtdGx47hj7F0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=JdVYhf/b; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738342281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UKyPXxorTljd50l3LPX8kNLdeMYZ96RAImkSFORSFwI+AkJd2aWJgYY8nHi44zRA9Oj9at5JVF43dkm8Q812+bU4ujqqzml889LVbi5t2o968Rbxq/djpJ1i3WCJt9MlRzwNoKLSlwi6gnQ06U4OWb9Wk5SIhAwVUk0D2LPCE/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738342281; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AkBxWUIcT550OcxCFzVpvE5imOg6AQ2vl9Nfme++Cjs=; 
	b=KOpave80XJxye8HUI/YBzj1IBFYvO5n/LK+eGiq0qi1RXd2r7X4RNf/OPRqCukwEF6rwdsXZsHQgMRkZV9xqKDiigmKv0nsG+3UOFp26F+XVfTrFO+nU9UiD9x/JW0VYsKOquv/jEt3XyCFSOc4OYW/SAiz0ojf47EuyEZo5ZRQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738342281;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AkBxWUIcT550OcxCFzVpvE5imOg6AQ2vl9Nfme++Cjs=;
	b=JdVYhf/b2uwkeydaEbsvLMGaFS+sXiidlRg5T2Dy7bGBUcq6XNpBjhCTVX/G4GmB
	fCvmR6tUmnFwo4rcYRGGXT3Wr65aMJ65UP2SQhfnhw8HGGLCmleJ1SsBrw5yutxNW5S
	dOhoPebMZ75U/OB2rbedhZvhwDD/t4PqmMqoxN6Q=
Received: by mx.zohomail.com with SMTPS id 1738342249812409.59874149103837;
	Fri, 31 Jan 2025 08:50:49 -0800 (PST)
Message-ID: <c9a01789-278b-4590-853f-9012a33541b2@collabora.com>
Date: Fri, 31 Jan 2025 21:51:05 +0500
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
Subject: Re: [PATCH 6.6 00/43] 6.6.75-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250130133458.903274626@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/30/25 6:59 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.75 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.75-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
OVERVIEW

        Builds: 40 passed, 0 failed

    Boot tests: 625 passed, 1 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.6.74-44-g2c44b59139a8
        hash: 2c44b59139a8bd89a50d82ca7f695ca18d867362
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No build failures found

BOOT TESTS

    Failures

      i386:(defconfig)
      -hp-14b-na0052xx-zork
	https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=$__all&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:679b96be65fae3351e30f0f9&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=$__all
      CI system: maestro

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=2c44b59139a8bd89a50d82ca7f695ca18d867362&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

