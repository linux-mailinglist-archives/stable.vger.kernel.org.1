Return-Path: <stable+bounces-98784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D59E5378
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8264E18811FA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123C1DDC1D;
	Thu,  5 Dec 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Qgs7hT/j"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8AA1DACBB;
	Thu,  5 Dec 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397294; cv=pass; b=gqK8I2E3GFo0HVnpQxtpv5BsyRJI9142l/+RdmLRYKFUdLWukzjvS5YWPFDZGBnXjNgLzH/oAdMqfuFrfsuyg5BYwspEkVs1ERg2iBcdi37i1ODyizWDviU6tI1Pwg5H5CWPjYj4Cx5MEoVPakqpmIMvse5kwI16ljdGHKowz30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397294; c=relaxed/simple;
	bh=rg3J+ZZWfsJ3fwzm2g2qHBQx9+dovu37cl/ttdV+m6M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GIHjvv/PTPJDpEVs3b2M6nwmkfUny1pk1rIqqCQqEtS2LFqWGjvVvrcChBlMeBR44Z8A0+yayWVp/n3tPodQl8QuBt6yZlluUhpjMvVOc07pspzucc99QOOwxy0xGYF/sDyL2JebFlqYhaSidJZYfW32IN197ovUXzXoASPkwO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Qgs7hT/j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733397256; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oDk23DPaH3vL64kk2I7na725Vc1uDHUNKmHGisjTN1Xm9If6gAkL9iKBXDuj1zEI0/wiGGvtlynWDi8fHBfB1fwt0PwWyQbA7NKcimZB8DfDi6h72U3ZbkCIoDzFzwOBrfIrwHg4kqQX+XLsJrr/pa1xBoLX3vh42BiJcQImkmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733397256; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N2Kgp6Iv5arHlEU8AzDJOsTKVF7rNqCadhKEDeV5n+8=; 
	b=bEjxEuHku/sSiY8PLOgPly/soZUlmBc6vmYR/DZxtT6+X+g8YPYw4XE2ovdZHdUJuw6rX1fWf94CNcLsn97ETnslzmatxdrOFnO2VI1Yri6XPpzcelIV+M3VhJVOWF66VbdoNUZEh9SKy6gmbIwJpjpsA8xyzCFadtHEJ0RI72g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733397256;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=N2Kgp6Iv5arHlEU8AzDJOsTKVF7rNqCadhKEDeV5n+8=;
	b=Qgs7hT/jLioryGsqNYXFxl2GJDIj4U0TwJK3I01vISSnIrndT8XVHG9z/8ZbIxkW
	9aTzkx+ILklZD6REytzkDlE+C8MVUU6cOpDFNy3mzT/6dbfyUm9kIZAfvUWSl2UCsPm
	xLrl0Q7o36MfXuu/kh1hCfDzS7wo1vxLIxW9opxA=
Received: by mx.zohomail.com with SMTPS id 1733397253468337.895873806812;
	Thu, 5 Dec 2024 03:14:13 -0800 (PST)
Message-ID: <f271db2d-9bb0-465a-95b7-02c1f6cb58c2@collabora.com>
Date: Thu, 5 Dec 2024 16:13:06 +0500
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
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241203144743.428732212@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/3/24 7:35 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.2 release.
> There are 826 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:45:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
OVERVIEW

        Builds: 26 passed, 0 failed

    Boot tests: 57 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.12.1-827-g1b3321bcbfba
        hash: 1b3321bcbfba89474cbae3673f3dac9c456ce4b9
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y


BUILDS

    No build failures found

BOOT TESTS

    No boot failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=1b3321bcbfba89474cbae3673f3dac9c456ce4b9&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

