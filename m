Return-Path: <stable+bounces-106129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E819FCA2B
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 11:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8870C162E66
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605051B85EC;
	Thu, 26 Dec 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="dCbpEZri"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69384A2F;
	Thu, 26 Dec 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735207985; cv=pass; b=NkNX+5FD4FT85UxgvdG9v4j8rGF0vJEH4OiH37BrTAEMGhZ4y/7QCJ8tyqt9HYJGtwcFHpdp1BHt73fTnDeZ/IAJhCd4zy1Sz0oFTkoThL2PFwFRiTNXi9vRm/TgWXJx1E6PUri1yDFPuvJQz1Z9+tsDejxqou0eMP0Jo0S708s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735207985; c=relaxed/simple;
	bh=K65885BdmRPwmAyWH9cIJ1x/UeMztfIySMPsmHTSTKY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uNe9iPAv0zkmdHfSTtN/Zy4LN9+kdp0hAoCyjho/8JegQzWsIlX9hjREujUcAlvBHT6GFPD2S7+ojBp8ZNjoTChfGIT4RNgK3yIlsQpiwwULnDVoMRq6NkkNuCc1Wff1KbTYbNE9+x5mAxZffGAiKxfFIFj9Dw/A29eE2a8ne7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=dCbpEZri; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1735207955; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YZ6vN70O864qwg+p6wBsedZ0rf9Mx11v7hLeCNt1KdfBzAdG1w8pBYUozuaLxf66KZksSmE6lXdLd8YvUZv65zsINcPCFyCQapCeoltwyWHJaOPkG0rFao5DAJm1dMtJzgXdF7uIEMTl/yQmLLO1Gaeo+JSG3SgcOXtN5bEMj6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1735207955; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=enys7Jved0GgY4JgAdx4QIuKxRzC3qY5WFnxoE3GjpE=; 
	b=IeJauLr0+lRUYiqnrPXZ01cDuhnptBlKjknpUQfxTcu2IeUVeBVYHGI6rIyVFAC+QwhAMZTYzt0weow2AlU4gelDYOHSCPrQbkDjY2UnGtYa55YloEz6FpySYF96emK0QGkxslTIbIURKFq730uO6J66wSwbjn7YcP3gBF3PaI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735207955;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=enys7Jved0GgY4JgAdx4QIuKxRzC3qY5WFnxoE3GjpE=;
	b=dCbpEZrioxWxv/xiQyj0ZaZr6qq7CpbATfrLvwRsJktkC58Gsl+PyVYsRrgAFqTY
	tYav3W8gxS9MoNET5WmdlMsOze8UR8VoJdOefGHmdUnw6kYFLIjM3l2jlgPHux2g/jT
	kSJwbR3mXf7Nx4Oqj+R4oTvUTAmGpcdDc/dgoFyc=
Received: by mx.zohomail.com with SMTPS id 173520795258275.01474067221045;
	Thu, 26 Dec 2024 02:12:32 -0800 (PST)
Message-ID: <1266ced4-1989-4a16-9a74-67b156e710db@collabora.com>
Date: Thu, 26 Dec 2024 15:12:44 +0500
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
Subject: Re: [PATCH 6.6 000/116] 6.6.68-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241223155359.534468176@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/23/24 8:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.68 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.68-rc1.gz
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

        Builds: 42 passed, 0 failed

    Boot tests: 528 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.6.67-117-g6a86252ba24f
        hash: 6a86252ba24f89c8deb21b44cb5ffc867d9ab96f
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No build failures found

BOOT TESTS
    
   No boot failure found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=6a86252ba24f89c8deb21b44cb5ffc867d9ab96f&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

