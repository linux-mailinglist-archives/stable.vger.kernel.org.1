Return-Path: <stable+bounces-110190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6115A1944B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD881886912
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E72144CA;
	Wed, 22 Jan 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Y+lICDYE"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7BD215190;
	Wed, 22 Jan 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556917; cv=pass; b=HeJ6fiaDwnFOJHlc/1DAwM7D1JFwDKdqrQL+sP+KmaG3r1gpsPBumx2TkwavLL7XlJW7PZHH8ts4xKLh+LDdaRiUnhEr8BSGnN0979JaUax9l+jud/NLyB7fI/qS+WzZSdVY+T8qzGoMLpgLl/FRrb4yJnbvbGuuODK4NXZWq3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556917; c=relaxed/simple;
	bh=YA+RQM0a5qkAQoUGV++EX1qBWaHNqu6JJKPDEdniyTQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OvSBz4ca09orvO0BcYjgCc6MHfhsUwMQ/O5DYfi7ROnNxiCjS/Ygvh7DqB2NV7Q7tXT7u1vD1umpJXk05OLzg49f7YZmaxiBHzWKmWztgFsUCxmz72vI9tKTQE7t7TU6Oqa+fsbbpBq8f7iSzfXo3RXFNakSNf9a1lLcMfHKLnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Y+lICDYE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1737556885; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ib/RQvh599pytkqKpDRiJVtqcZsG0AECgeVMEi7+lu72SMQvBcren758Tq2H+VUMTB3CbMaaovbTd6zMQ37Covm1ljmHMeni96Y9jzQ/GUA2bPi9k/DvgIkwOUjBhKYHBmGX0ZlFqN6EHMDoHUS8/WSAxSTkJ12HT3sivarzLRk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737556885; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YvaJmiw5hv6alLjsc1pr9qxQCVLsmUq8/2FINskPFiU=; 
	b=fvJXXVIRMn31bvkmpHplKgVUT83Tyja/oBqxhyOiwXWhQ/b0RJ3m48tx4ZtnjmmB+1xTfpAs/mKY51hfo3EjCB3LBQ51Ml/q0LHWx6RylJirNUFUEFs0+TOAsUMvWbsTdoGuUS0xlLgC9rK+3N/V+UFDQa+twZT2Gihl+tkqU5U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737556885;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YvaJmiw5hv6alLjsc1pr9qxQCVLsmUq8/2FINskPFiU=;
	b=Y+lICDYE7vx9/UZEei7zmlpeQ1qhhvPW8GnLD9tVZuDePGhlJI68vLOBvBjuRd8r
	lInyaEwi5ZB1VKxk6ubVwPRbZs5ZECOFK6RWVTc68+fRoyQbeD8NPBN0ALjS7djdEKT
	sZ/PxkeSnMXQYvL2XognLUlHBisjMIQ4/c0KO+oI=
Received: by mx.zohomail.com with SMTPS id 1737556882115818.7757853209004;
	Wed, 22 Jan 2025 06:41:22 -0800 (PST)
Message-ID: <91967262-578a-4b68-8c1f-e013f9f72ac8@collabora.com>
Date: Wed, 22 Jan 2025 19:41:46 +0500
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
Subject: Re: [PATCH 6.6 00/72] 6.6.74-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250121174523.429119852@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/21/25 10:51 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.74 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.74-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

OVERVIEW

        Builds: 42 passed, 0 failed

    Boot tests: 585 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: v6.6.73-73-g429148729681
        hash: 429148729681ff93db022c19a17ce00dff9c04f9
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No build failures found

BOOT TESTS

    No build failures

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=429148729681ff93db022c19a17ce00dff9c04f9&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


