Return-Path: <stable+bounces-158213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECAAE5941
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 03:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526B53BF085
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 01:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D5A18D649;
	Tue, 24 Jun 2025 01:32:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3B3FE7
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728779; cv=none; b=ghldbURI8rkeBXsH39H/wcw3eDuSYH2UZKyvdqBOQqHlp4DqyjkNHnJHEfoKx0u58GMlBT3sH1sgP/1tZBcUAt58+5fsGDtENoPKRIG6Fp3HknWwhdhHqqIIOsYBbAqCnoYNorFFhDs10TuIPCDWVnkzobe+d/uy0xuD3Mf5mkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728779; c=relaxed/simple;
	bh=LiJ/T8AH9ysrj2kx6lJLyWv0vl1+nPd9U1UzRG+qTTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SYpCoFMF6/fpYH4g3oxOJcxro7XPbSQax83DUoK5Dn2RXnQAptawD8bT9B/pGu2Md4ZKdwuhBrnrIiMtd56FaPZD6zZkApSwVxPdiz04faPVGbz0Na/+jSAU9W+KwPC4CGVtfq99+2J/kFD5Rhkv2eiyDLUpm20efzpoy+0x6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bR6qk1HCTztS3k;
	Tue, 24 Jun 2025 09:31:46 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E23E140258;
	Tue, 24 Jun 2025 09:32:55 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 09:32:54 +0800
Message-ID: <e9fa5e34-eacd-4f35-a250-2da75c9b7df8@huawei.com>
Date: Tue, 24 Jun 2025 09:32:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
To: Aaron Lu <ziqianlu@bytedance.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Luiz Capitulino <luizcap@amazon.com>, Wei Wei
	<weiwei.danny@bytedance.com>, Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
References: <20250605070921.GA3795@bytedance> <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh> <20250623115552.GA294@bytedance>
 <2025062316-atrocious-hatchling-0cb9@gregkh>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <2025062316-atrocious-hatchling-0cb9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/6/23 20:03, Greg Kroah-Hartman wrote:
> On Mon, Jun 23, 2025 at 07:55:52PM +0800, Aaron Lu wrote:
>> On Mon, Jun 23, 2025 at 10:17:15AM +0200, Greg Kroah-Hartman wrote:
>>> On Mon, Jun 16, 2025 at 03:06:17PM +0800, Aaron Lu wrote:
>>>> Ping?
>>>>
>>>> On Thu, Jun 05, 2025 at 03:09:21PM +0800, Aaron Lu wrote:
>>>>> Hello,
>>>>>
>>>>> Wei reported when loading his bpf prog in 5.10.200 kernel, host would
>>>>> panic, this didn't happen in 5.10.135 kernel. Test on latest v5.10.238
>>>>> still has this panic.
>>>>
>>>> If a fix is not easy for these stable kernels, I think we should revert
>>>> this commit? Because for whatever bpf progs, the bpf verifier should not
>>>> panic the kernel.
>>>>
>>>> Regarding revert, per my test, the following four commits in linux-5.10.y
>>>> branch have to be reverted and after that, the kernel does not panic
>>>> anymore:
>>>> commit 2474ec58b96d("bpf: allow precision tracking for programs with subprogs")
>>>> commit 7ca3e7459f4a("bpf: stop setting precise in current state")
>>>> commit 1952a4d5e4cf("bpf: aggressively forget precise markings during
>>>> state checkpointing")
>>>> commit 4af2d9ddb7e7("selftests/bpf: make test_align selftest more
>>>> robust")

Hi Aaron, Greg,

Sorry for the late. Just found a fix [0] for this issue, we don't need 
to revert this bugfix series. Hope that will help!

Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=4bb7ea946a37 
[0]

>>>
>>> Can you send the reverts for this, so that you get credit for finding
>>> and fixing this issue, and you can put the correct wording in the commit
>>> messages for why they need to be reverted?
>>
>> No problem, thanks for the info.
>>
>> I have sent them:
>> https://lore.kernel.org/stable/20250623115403.299-1-ziqianlu@bytedance.com/
> 
> All now queued up, thanks!
> 
> greg k-h

