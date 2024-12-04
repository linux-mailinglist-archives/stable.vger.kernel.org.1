Return-Path: <stable+bounces-98197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1A39E30B7
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3848283B4C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A6F567D;
	Wed,  4 Dec 2024 01:21:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4F1078F;
	Wed,  4 Dec 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275293; cv=none; b=RAfGn8SM67PnonqrXM0k7tsznSpiqK51dzooOZxbT+93NBeIcPCtg6nRGasUzh8up7+cdDj9Cawim6P7mEwAW7+bfPnSrSj8Ey+CNh6Nysbh00KpqHUmmlZLBoeOG61ZKOl7deyr8HVMVSETmm/SGzk/3/Afc9WS8NEelBhZPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275293; c=relaxed/simple;
	bh=oGiOSLACjg1+II2qWEoDLwbyn+wnLc5fou8dE+H23q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SIVb8L7DG4OjlVvwmVUFuIwxqpVItGoQgfa0mlconDXG6V0BG4/zdikfh7DAnR6w+lC+7jPjT9vBXc0FVp89PvfC/+2tv23KpDFDZmrMIlgcxhrrQkEqKYugApA57alTTKsr7O3C4j8/4YDsQ0TOgO2i2QkJW2rejLddcJ56bmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y306R2sSPz2GcTd;
	Wed,  4 Dec 2024 09:19:11 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B72D0180043;
	Wed,  4 Dec 2024 09:21:27 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 09:21:26 +0800
Message-ID: <7ef1aa61-1d64-4fea-bb62-c0db50def8d3@huawei.com>
Date: Wed, 4 Dec 2024 09:21:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible wrong fix patch for some stable branches
To: Greg KH <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<stable@vger.kernel.org>, <kevinyang.wang@amd.com>,
	<alexander.deucher@amd.com>, <liuyongqiang13@huawei.com>
References: <2024111943-CVE-2024-50282-1579@gregkh>
 <20241203020651.100855-1-zhangzekun11@huawei.com>
 <2024120351-slighted-canary-12a2@gregkh>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <2024120351-slighted-canary-12a2@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/12/3 16:50, Greg KH 写道:
> On Tue, Dec 03, 2024 at 10:06:51AM +0800, Zhang Zekun wrote:
>> Hi, All
>>
>> The mainline patch to fix CVE-2024-50282 add a check to fix a potential buffer overflow issue in amdgpu_debugfs_gprwave_read() which is introduced in commit 553f973a0d7b ("drm/amd/amdgpu: Update debugfs for XCC support (v3)"), but some linux-stable fix patches add the check in some other funcitons, is something wrong here?
>>
>> Stable version which contain the suspicious patches:
>> Fixed in 4.19.324 with commit 673bdb4200c0: Fixed in amdgpu_debugfs_regs_smc_read()
>> Fixed in 5.4.286 with commit 7ccd781794d2: Fixed in amdgpu_debugfs_regs_smc_read()
>> Fixed in 5.10.230 with commit 17f5f18085ac: Fixed in amdgpu_debugfs_regs_pcie_write()
>> Fixed in 5.15.172 with commit aaf6160a4b7f: Fixed in amdgpu_debugfs_regs_didt_write()
>> Fixed in 6.1.117 with commit 25d7e84343e1: Fixed in amdgpu_debugfs_regs_pcie_write()
>>
>> Link to mainline fix patch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d75b9468021c73108b4439794d69e892b1d24e3
> 
> If this is incorrect, can you send patches fixing this up?
> 
> thanks,
> 
> greg k-h

Hi, greg

I will send patches to revert these wrong patches as Alex suggested.

Thanks,
Zekun

