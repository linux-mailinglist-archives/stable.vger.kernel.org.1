Return-Path: <stable+bounces-89194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCC9B4A5E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490191C2286C
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C8205142;
	Tue, 29 Oct 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="RSxgNtJ3"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF48BEA;
	Tue, 29 Oct 2024 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206790; cv=pass; b=i6WO6EplMH6cAbj1Omr3WW+0geYhNnQyJV3agbKfSD5NLlRR6Fx5e8QNpiFGlgxgzmKu4z1YwpRj/tjhUskFG+JdPjH7uA1uBpE2bpo+IE1rXdmr8ZBYCLAm1wf7+5BgRlq0gyxpahkkBHGtbHfOSG/iuvLg7u0F5nR6pS2T4G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206790; c=relaxed/simple;
	bh=WwP6rGAJZ3v8EqWtiBROQEBU+P0fMGr0CZmoH6ZTuvc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LilzlkMnbyZWEV1KAcWDYGz2V2Da6JQ/uJ9VPMHs2u1xoipz7fAN+4oipNYdxVron5l3LtBOipQn5DuUUL9tPpmi8w+5d73KJgXd0+bmraBUVHvkWOJIeMKt6oggYh/J09DiecKemRM3ikRl+H+6YyFCQeJaIofIvwcXu9VID38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=RSxgNtJ3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730206756; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FKfDtVkqUmzpgO5CqUUWvTYozPMVOxZ9dkVVx1tLpSSbNfW6A1JsYALYvuD1lPO4pahV88cpdH/r2QIVlzA6zC2tvbfpOGPuomH4QTfnPgidgSJS87BOa+mZUR67G4Lne96fb1chQhNvNdgMthVAYfbliS5gtJAeM1dnktlJkuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730206756; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WM6aoI83udbdyaaKeUJ5PapsjDO2TifoDqtItvcoBd8=; 
	b=jpVdxKBb8WY+4smSvJbER7hRlQBzSzjJua/zLpOzhvu/GkupXFjCW4vnXo6w64mHpG7j/G4vlb7lgsB6FAwolvj2CRvtLN6frLFIjclWTZH+mhiXnyI6g1Mp80WYzII0LveRYjvabezrcT1toDbtk+MLrO7cr0XEFYuchunnf/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730206756;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WM6aoI83udbdyaaKeUJ5PapsjDO2TifoDqtItvcoBd8=;
	b=RSxgNtJ36XQeoCVVhNCP6M1YlBGD4SLy6YYejaeA/H7asvcvkgw7l21yP7kRl/vs
	vUUV4bVduz1MSuANZC8TGhO/JO+8qi4+qqBKokCr/JaAZAZRQCPZtprCrpIBF5+ASVU
	6UcmjgSJMuodUX9ref8+ao+0nOTQN/K55f22eVyI=
Received: by mx.zohomail.com with SMTPS id 1730206752839780.6762877970862;
	Tue, 29 Oct 2024 05:59:12 -0700 (PDT)
Message-ID: <73bda451-4272-4f9c-b4e3-931a28674624@collabora.com>
Date: Tue, 29 Oct 2024 17:59:01 +0500
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
Subject: Re: [PATCH 6.1 000/137] 6.1.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241028062258.708872330@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/28/24 11:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.115 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
        name: 6.1.115-rc1
        hash: 1efe597b37dcd665c9f44a5633eaf6572e74c6e2
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=1efe597b37dcd665c9f44a5633eaf6572e74c6e2&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

