Return-Path: <stable+bounces-107985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48FFA05BD4
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 13:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7AD7A2418
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21901F9407;
	Wed,  8 Jan 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="QI0HdITU"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF31F8AD3;
	Wed,  8 Jan 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340122; cv=pass; b=i4n8SNwYYK32Ji16ELANO9DGjQYp86o0G8yy83e843wKnIJ2D28ukaUjJrwjqu6VPaDzsGz8eXqkrhvK2kYrZ8/bed1A9A8gjJJZZpFAOjDddquc7fUAS7E+ICkmkIjzOGdDDthuASY9jOkpG1XvrchlgQK8ldWuglMcfMUjDwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340122; c=relaxed/simple;
	bh=Eh6IoMaEqIiSvQZ+S+lg8uUaPbB67/KY2m2MNqRRGCg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ueuOQGqjBVo0zbVUvQXzlcV90VB0CpLMgaOcCY8QAoXqwXr36sLkufhj05pabL16QkPweXml0saijR1+Olt74jZfP/58s1C0MQJtCS9sLeCSu7clmXiBl/C/PuOHxoGICAL9zfEbuZF5pHKrRIkhevHsOXoDiixXoD5/RHYIC10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=QI0HdITU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736340091; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oFFr90s0d2qA2/rh/JSN5tQwYntDr6ik7npOQt1wjIGb59LutaGJ7PpoIoaO1bPL0VpXsBxr3d2FFC6C7rxAO+LJXzTeFpX8SRtD6nfpYFwx02+VekpYnqa7mnku6oz/g9Vt2dXfQy4V5I5vIeiPRGb4flamXnow1Ddm/dWXHs0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736340091; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DLCfpulaIKfxYWB9wJrvD7WzNlXPcqzh7bHz1Pjxxjo=; 
	b=NqD0XGX7FyyeUVPlnqXdGyfj4dABBmAB3DxIbBRnnIY55fCjtogQ6COL1SgmBqNDpVFxuyHUyigAdJTCfja20ApfFeoMtfHt/iptuBgksdfQxwv92ucVY4SAe/GYipMwYj8kZY/kr2OxN6p1cDods6DpJttfSkJrwkHYeWCuToM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736340091;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DLCfpulaIKfxYWB9wJrvD7WzNlXPcqzh7bHz1Pjxxjo=;
	b=QI0HdITUksF83bGErLMPZAycWtFN5DfbnYRc+n3QvvC9dmbj1TbWnhNc5dOs/xvh
	5m/LkLGf0Tb5uUr1LRlAju/KRK5SnNE0rOVBL5WDNX8pG+FUn2hy5Gq9bTzYFOb6oCY
	tlD6g2XAeRgYlBLWNOJ31kqvaMTSe/Zd2xoLm7J8=
Received: by mx.zohomail.com with SMTPS id 1736340088461877.8704431353802;
	Wed, 8 Jan 2025 04:41:28 -0800 (PST)
Message-ID: <fd58d60e-1031-4e81-a0aa-d611eb4c22e3@collabora.com>
Date: Wed, 8 Jan 2025 17:41:46 +0500
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
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250106151141.738050441@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/6/25 8:14 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
OVERVIEW

        Builds: 41 passed, 0 failed

    Boot tests: 592 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.12.8-157-gcab9a964396d
        hash: cab9a964396de70339b5d65f9666da355b6c164e
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y


BUILDS

    No build failures found

BOOT TESTS

    No failure found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=cab9a964396de70339b5d65f9666da355b6c164e&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

