Return-Path: <stable+bounces-111843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1DA241B7
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D57E166D26
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484A1EE7D9;
	Fri, 31 Jan 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="LeftFOaa"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D091EC00C;
	Fri, 31 Jan 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343726; cv=pass; b=Sw4RyFb64D5H7CDoLqzSgYB2gsWYb3Y+LQ4hA2sH3VDgVjY6FMBOjlybZCo3Ce/kjvZkbCbMd7f39CgUmYSqmDR3LG7ojH+LSgZUeodGmfVCEQSruhwVghgcWdfng8OCjboVD8yeddlie5+HZQ0ZpK/bsZxnjx5+jpCyi429Sw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343726; c=relaxed/simple;
	bh=oK1k3rEWrJmRR4OPtJz4C1rlVLLBu1Vzh9ut0mr4Kbk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=thGTtZCO5/z8BOLX+qT05t6LMigUAk4is+mp+XbD5QpK2dWyjyMPSW3i2AU2oBRK6CCAUjrTpsQ4KsYJVbMTP7jFD2s2mjt1EANwiZjxaahq9dwPXOLM6EhJQ7Y4Q1DTZVyyUDKMg0EeKD74MucCOy1He30XMyTPJWBzVIHht14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=LeftFOaa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738343691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oBfFf7YS+9DM1wSuZx46qHBPGEteeuSNFmKktsL/9vZJiEjo/EeP4go+8a9Z1HryUfRAxvTSgjLupFrM5VVRYeGx1rVmJzVq/U3eW7fcJ2nE+xoyOOvcosnCCjtdhRRIRhtna8IibGllWAU2SRIsHEHJa9MIwbXxbHuXN50Ls+g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738343691; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wMwHeEjetWELU3ewH8V8bdOBFfw6fj+ETIzH3dhS8Pw=; 
	b=JG5MbuRDvch7lXvIdp5PinwUVikMuX76d/o+Yoth6n6jvY0bEy6cNZyPXuiZ9W7OCz8xBHR1k5WmZTDGWnzZne24QV7ER/Egsp7oO57EbbPeTVCq9QS9YcsVeJJKrRHmsWOabiBx0KghWDfjyBesY3cbVgOtJqucGkKJwD66hdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738343691;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wMwHeEjetWELU3ewH8V8bdOBFfw6fj+ETIzH3dhS8Pw=;
	b=LeftFOaaedobAJnZeKpDrYsv2CxSy03WhoQnpk5bA8n2EF3G4vf2Sei4ldA9evVv
	6kSacW4yCzJrjRcQjDzbRvnmjcy+AcQbpXVnP71Kxsd3A1vYlRc/YGmYA/iFW6cNaml
	pn1cle5WNif/0HbS4LihylkK/GL7ZBJYSdx9os7Y=
Received: by mx.zohomail.com with SMTPS id 1738343685182938.1558923456199;
	Fri, 31 Jan 2025 09:14:45 -0800 (PST)
Message-ID: <d6717b2e-4138-425b-b8b1-daa40d30bbf3@collabora.com>
Date: Fri, 31 Jan 2025 22:15:01 +0500
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
Subject: Re: [PATCH 5.10 000/136] 5.10.234-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250131112129.273288063@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250131112129.273288063@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/31/25 4:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.234 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Feb 2025 11:21:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.234-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
OVERVIEW

        Builds: 31 passed, 0 failed

    Boot tests: 420 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v5.10.233-137-g99689d3bdd980
        hash: 99689d3bdd980ed74fed764babc35d90522391ac
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y


BUILDS

    No build failures found

BOOT TESTS

    No boot failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=99689d3bdd980ed74fed764babc35d90522391ac&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

