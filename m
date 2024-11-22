Return-Path: <stable+bounces-94574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE249D59A6
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 07:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4863BB21C9C
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 06:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FE1632EE;
	Fri, 22 Nov 2024 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="HvBdJhfb"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D31509B6;
	Fri, 22 Nov 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258559; cv=pass; b=gLHP62zdqp54yaCY/60imfW4/H+pZn7cWl8EdAVLHbgLYPSPqJgE8MCMJNnRrygApHXsamGN4t765od2Ns0XZeFy2p4ewdLkKpvfDsuDGWV/dO96+jqf2Vgujso1I5vWbfg54D6+Gy2vjUobAHDeoW6aocqO73sRylBPw1dkISc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258559; c=relaxed/simple;
	bh=T/Zt13xnSI9S06gpZyk3yarbECKKw+wZukHD9qHOq34=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cjkSofC0un0BaudpQgCGY7O/TqVA5xi5+9IXdHy94U6L6ui/88qzc2uQdx6QqQgi8Mmpf00ASeycnBrNNGrFSwioUcAdnajgNlTaeBvoui+ObSTGSBbdodJ+TWtNnqvBt9Ms/W74tPfDFX8dOcV+ddmPPk7D9RzLDwyePTPac7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=HvBdJhfb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732258523; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R50vwk3m4SWvsU2H96UvbucJSMtxENkJoVT2oQYqsJJrzqOxIXJJ9I7+wmMj2enmsVo3XxVdMo/8kQhfNjJuiJh16jg+U/rnvXls6GkO26PuBYlUtEav2BJ7BRWwypKXTSHyycMgZKWASvNUbf2nuLRKZ+X6bvl8MSof+41VH0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732258523; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q+2JkKzk1jp46NgS4TyFdM4ETBmYhVEqzqdB8s0TT0U=; 
	b=Cl3UU61HVtmEJKYDOzKcm12GYqhS+9sT6ZggZQFVarSLvJn65l22cafzkcW2wFbCo0tGzengAPi9CsqNLrQfvn0CaAQcEHqZSJTcxwHyUhWBLHLiiEa4fnOfpw3XVWzcplGlv7f4cK0cdxMYVihF9hzpAuZFTwUZBAx0r28eyTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732258523;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q+2JkKzk1jp46NgS4TyFdM4ETBmYhVEqzqdB8s0TT0U=;
	b=HvBdJhfbbUjbEcuR8S+7kMlpZQO2Xlu5NUStWgyaqxBsKWb2RSyfbwNPDMJs7w+2
	rFulbh2x9a2q/GizqRts52klGWfejFeHwUapxwe+iUvcbIzYqZKA9dL4eAI+KF/J4+T
	gfTqIU0SBGYqrePv7dnBQZ1goJzOEc1WE+8O2Dho=
Received: by mx.zohomail.com with SMTPS id 1732258520676116.96159492790991;
	Thu, 21 Nov 2024 22:55:20 -0800 (PST)
Message-ID: <3bc112f0-055d-4390-8998-880d228caa4f@collabora.com>
Date: Fri, 22 Nov 2024 11:55:16 +0500
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
Subject: Re: [PATCH 6.6 00/82] 6.6.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241120125629.623666563@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/20/24 5:56 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.63 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:56:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.63-rc1.gz
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

        Builds: 37 passed, 0 failed

    Boot tests: 482 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.6.62-83-g2c6a63e3d044
        hash: 2c6a63e3d044aa21274c98760650830a22b5d54c
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No build failures found

BOOT TESTS

    No build failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=2c6a63e3d044aa21274c98760650830a22b5d54c&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

