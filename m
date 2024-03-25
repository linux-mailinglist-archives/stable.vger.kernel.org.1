Return-Path: <stable+bounces-32178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1369188A528
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 15:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443C11C3B69E
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158716B459;
	Mon, 25 Mar 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2wn1aZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8A142908;
	Mon, 25 Mar 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365167; cv=none; b=FdrwFxDeniydD9vy47bfSo4mvb4G5G/xED8vs8kNkfVCub1gOL/57PHDGMsa9x4zJJaKKhVQUmYH1QCjbFT9sT+rWZ7fwAUQDdKUT/jhdpZy1PrHGcp65Y7CAXCWAp3uySkJ8KtNEwNAkprRzradUsctucdzrrjf71Zf7jUua0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365167; c=relaxed/simple;
	bh=QAWLXr7KUQBDlU74c54bSKWFmoEFP68Vbq2uO99skjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3+DRaSQrt5fzSK+Q9HorNsAdhIF3sw8q2DSZ3zhF5n+soPWqLivjsa6sV3P1QddKTS4S854L3F2/62xxa4bhSnAnBL87oOw+u/elcXZfXgzkUC76B19driWPcLZZlIVIUYFL6bHs4/tJQdamAEJpQIonmZzRVUXP+pRahV5gy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2wn1aZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F936C433F1;
	Mon, 25 Mar 2024 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365166;
	bh=QAWLXr7KUQBDlU74c54bSKWFmoEFP68Vbq2uO99skjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2wn1aZCqPiajHHsfzrts8IFjV++Rby11B2fHZ8s63JyM6Gl5V5squt9LsheR2Mw3
	 0Wh3Fc/GoMsHa1d/P/UMlDGFwB4NpFAPpH8cDLKIpd1tDnKpUXCiZfjP8v5jJJ4BYE
	 5snGeraEZ6TtooP2I6VD0Jb7aB809h3X3OPBd6Cd4fAMp1pzM9jWqtW4jpeNncu563
	 uNIJsZb5iRDB5Rq9KhQ1IRmm9iVNReiNx5PXgAPHqbiBOscvDoBim3yZ3xrhgZLB0y
	 M2k2tFE5rxsjpEh+fRW+Z7sJ4HceLm0wdGdD2TJpHt2Wq2lP+n2Reb98R/xtg/zm4y
	 UbBeQQgSWvSPQ==
Date: Mon, 25 Mar 2024 07:12:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
Message-ID: <ZgFcLRM6bnenuYa8@sashalap>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <CA+G9fYu1G1+LKu0mOhppUbVcAJ2DaC-zSh2GBhfShR_No9T=9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYu1G1+LKu0mOhppUbVcAJ2DaC-zSh2GBhfShR_No9T=9g@mail.gmail.com>

On Mon, Mar 25, 2024 at 03:44:41PM +0530, Naresh Kamboju wrote:
>On Mon, 25 Mar 2024 at 04:05, Sasha Levin <sashal@kernel.org> wrote:
>>
>>
>> This is the start of the stable review cycle for the 6.8.2 release.
>> There are 715 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue Mar 26 10:34:31 PM UTC 2024.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
>> and the diffstat can be found below.
>>
>> Thanks,
>> Sasha
>
>The Powerpc ppc6xx_defconfig build regressions stable rc branches
>
>Build details,
> - ppc6xx_defconfig - linux-stable-rc-linux-6.8.y - gcc-13 - Failed
> - ppc6xx_defconfig - linux-stable-rc-linux-6.7.y - gcc-13 - Failed
> - ppc6xx_defconfig - linux-stable-rc-linux-6.6.y - gcc-13 - Failed
> - ppc6xx_defconfig - linux-stable-rc-linux-6.1.y - gcc-13 - Failed
>
> - ppc6xx_defconfig - linux-stable-rc-linux-5.15.y - gcc-12 - Failed
> - ppc6xx_defconfig - linux-stable-rc-linux-5.10.y - gcc-12 - Failed

I've dropped the offending commit, thanks!

-- 
Thanks,
Sasha

