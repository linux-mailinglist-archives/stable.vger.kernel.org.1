Return-Path: <stable+bounces-94575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52DB9D59B3
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 08:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0CBB21FDF
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD716EC0E;
	Fri, 22 Nov 2024 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="QoMr+OYf"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EA16F0EB;
	Fri, 22 Nov 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258826; cv=pass; b=oUosYxDlPfu6SPe4eaILNM7AvVR0M0t7rXzSinXlnzk/C0YImp1LT2obm1TY3gmEOfsFEpadlHaEAuJwkEYnHRJRso49w2vVwoSlbGbwllWHlbFXYI9xOU4zGJQhIpaxn673xIqipvhrn8aIfz4u5xtjJjJmHlUfhfoRckhlX54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258826; c=relaxed/simple;
	bh=eSeFTulBtts7nfuhadd3eaVMxZpMLRhc3/vREVFRuko=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yqp1LCkeSKvvJ1SAX9X2a0rsM2DjTgGZaWCrN0HFShvcTjDowbviduM2PFIs2FLnhFmhyWAmh2ORMWh2csN7aU/ntFmI5UD2u1QxjyIn4L4PLcSsT+j9PqfP7HyPqCfSXpMlbx9zeOHCgTGndhFZlhxVxnkumEMENIjFJXy4cn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=QoMr+OYf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732258780; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KzHD/mzezclQxmoqXuRAQjqsT/Oa60wxummgWgSBYCIpbPXcbvwr7MHWGspvXDai+HGKIznglKLxTnhV4lWBhJwazyRxywtqLzFiTZF9k+teH6GOjl/LVnZTkOAsDpi0NejmYOTGkFMcI26J39JOzzzMrukdl0Z9K+KLx9Z0FF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732258780; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EbebJ7zJF9htxvvbOcbKM4iUv7HRLB5ji80RJ6IW9cA=; 
	b=a2QjB8TbInWd2EmRq2uDCv7OST6Q92VFwnJIwUG5Tg7doe4k1QExMvCEipbYexqVeBep0jbBSQTI1gtWaxxdSOIwLRPE3bf/wukVO2t0hKjhuteDvLmJbWirUrTI0JcJJsBy3j7qoSubWgI4YQICnduwATm14zThtiKJVoqQZHM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732258780;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EbebJ7zJF9htxvvbOcbKM4iUv7HRLB5ji80RJ6IW9cA=;
	b=QoMr+OYfBCbvDr+8kzg1rT3NY4lrADTJPr/udqcyN7kXSpjIWNfEmWpcgmSFEUVd
	/4RvdCyT4pCfbjmWL8flkQ5lrSF/wPCA5c0+P4dMEQJcwxI7Ay/Y7b69PHydiRz0htN
	p3LQ2W+8cxWqLVjMXcjznBMaeILkQE2+kb4f/l68=
Received: by mx.zohomail.com with SMTPS id 1732258779261569.9028590518776;
	Thu, 21 Nov 2024 22:59:39 -0800 (PST)
Message-ID: <af6ff01a-c1f1-4edb-a891-7ffa2657ce94@collabora.com>
Date: Fri, 22 Nov 2024 11:59:34 +0500
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
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241120125809.623237564@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/20/24 5:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
OVERVIEW

        Builds: 36 passed, 0 failed

    Boot tests: 476 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.1.118-74-g43ca6897c30a
        hash: 43ca6897c30a8511928abff403a2977ca7b33ab8
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y


BUILDS

    No build failures found

BOOT TESTS

    No boot failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=43ca6897c30a8511928abff403a2977ca7b33ab8&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

