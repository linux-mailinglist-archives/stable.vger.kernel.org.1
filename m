Return-Path: <stable+bounces-43098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DA8BC68B
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 06:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878661F21F53
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 04:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735124436A;
	Mon,  6 May 2024 04:21:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFB3E462;
	Mon,  6 May 2024 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969314; cv=none; b=LTy+D6U/KhjQ2YggDaAJ2Eja+/2gvTbTZFSqmrV/CwtxAiPY8nJvSt1v1fk+1jnpGf0QFuNc8Eb4nkWr3RMQKED7INJttQwlacPyabayv2UDwXGqasf6xIeRSA6vyaeDRjZJpPjzPmABNB/qq1NWz+UcPlAVw+CkNwvbkyZDarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969314; c=relaxed/simple;
	bh=Bn+hNDyy/tAVyS/zj1Z2DkmRSYXU+4+yKNfGyfrkVSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AwF5cVwcNsfE6QvrPa48BhhwRrU2/XmrBx4SnjvE+1dIludrf/s/a7NUhTf21JKLp29oUMrrBUOCkXjKW0dA6pDpmZZkVRNycQwjWksRV9QNSgAV2ucu7Cw9Vw53QSiACfTkH07PmvXTK91KlhgxWU+fEkG4AVp2Nr31zsGrLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VXp6c5rmxzcnSm;
	Mon,  6 May 2024 12:18:00 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 19A07180080;
	Mon,  6 May 2024 12:21:48 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 12:21:47 +0800
Message-ID: <ae814090-a184-164f-7391-f46c02b5d807@huawei.com>
Date: Mon, 6 May 2024 12:21:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH stable,5.4 2/2] Revert "tcp: Clean up kernel listener's
 reqsk in inet_twsk_purge()"
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240506031750.3169282-1-shaozhengchao@huawei.com>
 <20240506031750.3169282-3-shaozhengchao@huawei.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20240506031750.3169282-3-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)


The patchset's format is incorrect, please drop it.

On 2024/5/6 11:17, Zhengchao Shao wrote:
> This reverts commit 53fab9cec2cda43d7161257dad5b546ea4be0018.
> 
> There's no "pernet" variable in the struct hashinfo. The "pernet" variable
> is introduced from v6.1-rc1. Revert this patch.
> 
> Fixes:
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   net/ipv4/inet_timewait_sock.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index 04726bbd72dc..c411c87ae865 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -268,21 +268,8 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
>   		rcu_read_lock();
>   restart:
>   		sk_nulls_for_each_rcu(sk, node, &head->chain) {
> -			if (sk->sk_state != TCP_TIME_WAIT) {
> -				/* A kernel listener socket might not hold refcnt for net,
> -				 * so reqsk_timer_handler() could be fired after net is
> -				 * freed.  Userspace listener and reqsk never exist here.
> -				 */
> -				if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
> -					     hashinfo->pernet)) {
> -					struct request_sock *req = inet_reqsk(sk);
> -
> -					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
> -				}
> -
> +			if (sk->sk_state != TCP_TIME_WAIT)
>   				continue;
> -			}
> -
>   			tw = inet_twsk(sk);
>   			if ((tw->tw_family != family) ||
>   				refcount_read(&twsk_net(tw)->count))

