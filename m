Return-Path: <stable+bounces-158324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53461AE5D04
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB54A69F5
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96E1F463B;
	Tue, 24 Jun 2025 06:42:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6224676F
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747325; cv=none; b=D4bC5A4E+7mfjaKpXZWYOxnBMyA6+QuSpfTzei8FgbSYMDoCGF2GrV8VqESyLcaq+TkANlo3BkS43Mc8P9DtxNHHG100/AMrnwzd//o55sOBUY7/EsaWqbs1F1AaGiDPpE5D7WspuwCT3cI4ZAKVtLM/ob+mNRw+kigmcqAHQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747325; c=relaxed/simple;
	bh=3ITYC0/uVuy4WYGiNh71AbLnZJlpIkYkRGPyq3VaDRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hBWCi+Go3c+wGv8L5TL0Fiyxsu+pno2IijYixtgtsQWoyfVcTepzyzUDnLzcMCAQemnKyrGp3gYWM3bKvRWYYn4fykH6fjGKpor4dubb74pHEHq7YJOfGq/8E9mKuqBA4FQe9+7iE73X3fwOryId7lQ7FPCwdLqdGf/K0LfpfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bRFd66W95z2Cfbr;
	Tue, 24 Jun 2025 14:38:02 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id E6E6F1402C4;
	Tue, 24 Jun 2025 14:41:59 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 14:41:57 +0800
Message-ID: <2ed4150a-e651-4d10-bada-57bc3895dbe7@huawei.com>
Date: Tue, 24 Jun 2025 14:41:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Content-Language: en-US
To: Aaron Lu <ziqianlu@bytedance.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Wei Wei <weiwei.danny@bytedance.com>, Yuchen
 Zhang <zhangyuchen.lcr@bytedance.com>
References: <20250605070921.GA3795@bytedance> <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh> <20250623115552.GA294@bytedance>
 <2025062316-atrocious-hatchling-0cb9@gregkh>
 <e9fa5e34-eacd-4f35-a250-2da75c9b7df8@huawei.com>
 <20250624035216.GA316@bytedance>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250624035216.GA316@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/6/24 11:52, Aaron Lu wrote:
> On Tue, Jun 24, 2025 at 09:32:54AM +0800, Pu Lehui wrote:
>> Hi Aaron, Greg,
>>
>> Sorry for the late. Just found a fix [0] for this issue, we don't need to
>> revert this bugfix series. Hope that will help!
>>
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=4bb7ea946a37
>> [0]
> 
> I can confirm this also fixed the panic issue on top of 5.10.238.
> 
> Hi Greg,
> 
> The cherry pick is not clean but can be trivially fixed. I've appended
> the patch I've used for test below for your reference in case you want
> to take it and drop that revert series. Thanks.
> 
>>From f0e1047ee11e4ab902a413736e4fd4fb32b278c8 Mon Sep 17 00:00:00 2001
> From: Andrii Nakryiko <andrii@kernel.org>
> Date: Thu, 9 Nov 2023 16:26:37 -0800
> Subject: [PATCH] bpf: fix precision backtracking instruction iteration
> 
> commit 4bb7ea946a370707315ab774432963ce47291946 upstream.
> 
> Fix an edge case in __mark_chain_precision() which prematurely stops
> backtracking instructions in a state if it happens that state's first
> and last instruction indexes are the same. This situations doesn't
> necessarily mean that there were no instructions simulated in a state,
> but rather that we starting from the instruction, jumped around a bit,
> and then ended up at the same instruction before checkpointing or
> marking precision.
> 
> To distinguish between these two possible situations, we need to consult
> jump history. If it's empty or contain a single record "bridging" parent
> state and first instruction of processed state, then we indeed
> backtracked all instructions in this state. But if history is not empty,
> we are definitely not done yet.
> 
> Move this logic inside get_prev_insn_idx() to contain it more nicely.
> Use -ENOENT return code to denote "we are out of instructions"
> situation.
> 
> This bug was exposed by verifier_loop1.c's bounded_recursion subtest, once
> the next fix in this patch set is applied.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/r/20231110002638.4168352-3-andrii@kernel.org
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alright, this patch should target for linux-5.10.y and linux-5.15.y.

And better to add here with the follow tag:

Reported-by: Wei Wei <weiwei.danny@bytedance.com>
Closes: https://lore.kernel.org/all/20250605070921.GA3795@bytedance/

> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---
>   kernel/bpf/verifier.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e6d50e371a2b8..75251870430e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1796,12 +1796,29 @@ static int push_jmp_history(struct bpf_verifier_env *env,
>   
>   /* Backtrack one insn at a time. If idx is not at the top of recorded
>    * history then previous instruction came from straight line execution.
> + * Return -ENOENT if we exhausted all instructions within given state.
> + *
> + * It's legal to have a bit of a looping with the same starting and ending
> + * insn index within the same state, e.g.: 3->4->5->3, so just because current
> + * instruction index is the same as state's first_idx doesn't mean we are
> + * done. If there is still some jump history left, we should keep going. We
> + * need to take into account that we might have a jump history between given
> + * state's parent and itself, due to checkpointing. In this case, we'll have
> + * history entry recording a jump from last instruction of parent state and
> + * first instruction of given state.
>    */
>   static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
>   			     u32 *history)
>   {
>   	u32 cnt = *history;
>   
> +	if (i == st->first_insn_idx) {
> +		if (cnt == 0)
> +			return -ENOENT;
> +		if (cnt == 1 && st->jmp_history[0].idx == i)
> +			return -ENOENT;
> +	}
> +
>   	if (cnt && st->jmp_history[cnt - 1].idx == i) {
>   		i = st->jmp_history[cnt - 1].prev_idx;
>   		(*history)--;
> @@ -2269,9 +2286,9 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>   				 * Nothing to be tracked further in the parent state.
>   				 */
>   				return 0;
> -			if (i == first_idx)
> -				break;
>   			i = get_prev_insn_idx(st, i, &history);
> +			if (i == -ENOENT)
> +				break;
>   			if (i >= env->prog->len) {
>   				/* This can happen if backtracking reached insn 0
>   				 * and there are still reg_mask or stack_mask

