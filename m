Return-Path: <stable+bounces-86607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5929A22B4
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DB82845A2
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E11DD0E9;
	Thu, 17 Oct 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="LEju+Lr7"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569651D8E01;
	Thu, 17 Oct 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169278; cv=pass; b=hGx8nkkrvxkewPr0SS3j70i8L7fekXxRt321z71CTukTDzXuy9zl70Jl7Sh7uepPUrY1/qjhK/329tyrn5y4FVssSDkpz0Cl5m+PVBhReWoApM1XpJ630O676vEfpiGNSBn/tuR9+2KaeBn+y+3LZ6hb4V7iz+fkNvKufpZxqg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169278; c=relaxed/simple;
	bh=AB3ixU4FHKfi/uz1PhlxCNMlD8rXSkmlLAR8gmpMAhs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p/LIpLceo458TUTuip08TuOkJs/7PCu/b9nJc8oaqt90226cpwVC6Hav5G0uNdFdrwPCQ9ffmggh3wE6c1MpHuUFMgdAKd5rlMyT+LpKbiTHdxOe6/gmRdxdy1U5SMC8mon8AZGe8kEP8DH3u5EW0ZFc8vTGLQyvk25w9AHjx14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=LEju+Lr7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729169235; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vitan82VWa0VpuYsbnQE3faj9qcVggHPseswfANHc9KJbwilf4g80vvuLivkHciXkNrdAOENhKrJ3TkF7FA1KsOySg0ZtAIWH2A62fZgA9r25mGPYliQGjcCtC4YzaXZCdlpD1Vb2/VUO0qcPDyMS6iu+G39MaF5IrEHSk0Vo1M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729169235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9RKSSJl4V/xRCGKzVFWhOE3IgVlJP3bRUWHtmpUXoKE=; 
	b=aXtG2nGb9DowApozbXJYyv0TrcMZR/cvscKEet/H0qWUtdduoBKaJfNb7hl0Ulh1uJnF/q1UkVX7KgilcZt94UdrgGCeBZSsLxyUrUdvc8lGh133gNVGafFGhJ5uIomrzz/H5S8yi0MaC8P7zIydAHdOHveL1QKrROFZYZjO4Pg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729169235;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9RKSSJl4V/xRCGKzVFWhOE3IgVlJP3bRUWHtmpUXoKE=;
	b=LEju+Lr7MBwbnqd9DbyjIE3tqQoXAU9R17MpyPPtR504JGMZvgmg1AKAHv6RImy/
	TEa0VK1ZrAN4kpNJxeejuwxOwlQKYtlp2LP7ztw5CAaAwqXfT6HHo3oOHvRnHNKHCNE
	xFDh+py6xncRUbRhLDBk2YIxfMbBNqeV45YPDrj0=
Received: by mx.zohomail.com with SMTPS id 1729169234292227.94396743823324;
	Thu, 17 Oct 2024 05:47:14 -0700 (PDT)
Message-ID: <c1e8265d-f329-4ab4-afa0-218c9f660340@collabora.com>
Date: Thu, 17 Oct 2024 17:46:56 +0500
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
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241015112440.309539031@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/15/24 4:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.168 release.
> There are 691 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
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

    Builds: 24 passed, 0 failed

    Boot tests: 42 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: 63cec7aeaef787deed4608a04b93cf521ddc11bf
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=63cec7aeaef787deed4608a04b93cf521ddc11bf&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


