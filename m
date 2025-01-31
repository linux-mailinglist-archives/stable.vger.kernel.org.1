Return-Path: <stable+bounces-111837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31779A2406A
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3743A5C2C
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2871EC00C;
	Fri, 31 Jan 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="VSksCWQM"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C61E570E;
	Fri, 31 Jan 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340942; cv=pass; b=BEgQUukirLiOF1zwzDYhYaSEkMGW5Kx0+92GqsnRyfQRRqp/+1cw6WI6uJJiUvUXAnbvftP+ZTDtq52WnSAbgw7ibkAT9yaO2uKPS8xoAolSjzQiz29g3t/wAoJLYkRbyLN42Yi+gP6QO8PRi94SQSn1tyDpjjhZL/FzpQJP+N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340942; c=relaxed/simple;
	bh=vxK8aVrGDL0bFyVeaG2LzeAMSVvILSsE5sfgi+kS7O4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dWOlukJklPhCv5zoJNJDA9HP0zTBmbC3fdqrKi0HUeEtD+q9mp5YoyNy4q0wP8/R6J2yzsygJINLbvK8uPZgkiVkeKXH7QbQzaGS0e48ciWIaJsOXvmHDyCHwGLUVQ+AtELrffCBwn/TZ8lh6XJiSwuO2uiqrJkSg/WZW4TWH+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=VSksCWQM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738340900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a5jhE1ewYSoH4rOwbHGRbqAw+ZDs8XaS6rYFyLpVN4vZd9P+hvFHUzJnSCOLsmXBzs5rD8xCrMxjO1+QRIbRnLDdIO0MtpRwSTnj3VpjFcA352Zox36ggb80F5dYAOV0pJpDlYqf4MQfbyODUmg62Z2TAQ2twXGvYM4tV2QgyxM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738340900; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XwyXo+m4gxT9FHkLb6GEX6WVel68pkAv/9osZAs4I8k=; 
	b=AtkndBHqd98HLkzYzHYfDZq8YT5JdJlcCp3umtR34QYdOvsilDiut2fFrU0eS54WzvQAvSh9oDHPjYzn+QBArByMrlcIf3UHWPz4zAcFT3PBTm193Dfn72lFqy5JNBbG4IDhg/rBAMjkORUhUFuzju6IfY8yK8yUvuOqVcu9jY8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738340900;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XwyXo+m4gxT9FHkLb6GEX6WVel68pkAv/9osZAs4I8k=;
	b=VSksCWQMWVyHEhbgMPUgbjoAaLgL7Hbw2cwKrQ+Bwk3kb1tKmSJl6r6eKHNdE44g
	aHB6qVsabmj43G8/nbXWpicYQniOBENB97p6d/j8Zld/5wgWYc0QBux9zj/7WDrYnuC
	iNBQaMlkHN9t60CSHSEtlQckw+Z4zmPWqajg4Rww=
Received: by mx.zohomail.com with SMTPS id 1738340892419531.964495853025;
	Fri, 31 Jan 2025 08:28:12 -0800 (PST)
Message-ID: <2a79eca0-1cce-4534-942c-030b65a3a606@collabora.com>
Date: Fri, 31 Jan 2025 21:28:20 +0500
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
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250130133456.914329400@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/30/25 6:58 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
OVERVIEW

        Builds: 11 passed, 0 failed

    Boot tests: 0 passed, 0 failed

    CI systems: broonie

REVISION

    Commit
        name: v6.13-26-g65a3016a79e2
        hash: 65a3016a79e2da6e613c74c51e580ff1b3ad1225
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git


BUILDS

    No build failures found

BOOT TESTS

    No boot failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=65a3016a79e2da6e613c74c51e580ff1b3ad1225&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


