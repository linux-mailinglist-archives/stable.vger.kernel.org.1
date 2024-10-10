Return-Path: <stable+bounces-83314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCCE99817D
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4710B1F212A2
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C641A0718;
	Thu, 10 Oct 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Wv0FeDLf"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91919F429;
	Thu, 10 Oct 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550894; cv=pass; b=sT5hIQvV6h889mD7aMo0mxkSMRIu2LW5ino/BB8dv05YNWAJLAc1er0GxSLgCkfOKN73dHBPIIaD8q2qCle3W7ef73PwTJ420l32mfiZdLs4Ky+aqzhZA1bHzfvB8KejqZ3ko94JRso7qIOlAXzwuX+XCDbzv5sUuQAByf3QPqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550894; c=relaxed/simple;
	bh=xgF7sCqeUMl0IrSMhRE6DttHPbYSdCK9qDDci2Nr64o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mtksay284hpKDjRUcTptC4NmHk35P6x3WjNuKVc+0d/uecQBiWqtWmspdghZtXB0d65GnfnbYsU5t8/+LDteDUlZHnLv5P2qmWG0dm18zLZc7WwSmaGJA6Zs/p1z7hOnq3jznqBVP69QzqFL2YR7Go3BzR1yElWRFkPB7VY7ODQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Wv0FeDLf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728550851; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YPbK7AhJ5RktqOduk83IE0jI5qf/fxxVlgpoew/Qj8I5n+/hxEmI2uOmCzfBGCKdFAeFOU4JCYN9dEAfeRnVUPD9Sqv5O68gkBSd3DtQK5DRIuFg1jkfx7MJmbG2t2kaoohs4xXWEgR2KyisTxIKBmw60ipp9mJTF4g25CoSGls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728550851; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yfpUUBn5TZz3J881pNCxTGR41pfQaqdQzQmQ+Db7TpU=; 
	b=ZrCk84mZqdke/SNJrtajioUYTKy5YcXioJmcO5bMIO+WkHMGbsDNjpLmlbCUcmKFh7lyP+CmgsOJ2MV5xu0vFYV1CAZEMR453/R5n9pLBTR2IU6Sdp0V3UEySbULUs8l7f5/cMROoVE/QZUxiWIs1xQoi+y2nELbgvEOCLj81TI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728550851;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yfpUUBn5TZz3J881pNCxTGR41pfQaqdQzQmQ+Db7TpU=;
	b=Wv0FeDLf4u3tro3I4B0Ii/mus+nEArgBrxIC0I38anG6FjWopY1nGJUJlyVbi3AC
	rJuupl90GUcV+ozvzXNnNOfgRgcFGMVEA8A54Y9oPiYZhAbj+quYccV1DyB4/V1vicc
	AhnSVoWTcwk0k+YDOrHuAZxI5rkT/PUUczpUfllE=
Received: by mx.zohomail.com with SMTPS id 1728550848740328.09819726957926;
	Thu, 10 Oct 2024 02:00:48 -0700 (PDT)
Message-ID: <64d10da3-09d1-4a46-be70-8111d664d290@collabora.com>
Date: Thu, 10 Oct 2024 14:00:38 +0500
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
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241008115629.309157387@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/8/24 5:04 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Hi,

Please find the KernelCI report below :-


OVERVIEW

        Builds: 25 passed, 0 failed

    Boot tests: 510 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: 75430d7252ba967f7ca3d11dffa4b90ff5aa0ccd
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


