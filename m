Return-Path: <stable+bounces-56295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2691ECE3
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6A9B2255E
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AFC133;
	Tue,  2 Jul 2024 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G2LR8mni"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444D3C38
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719886083; cv=none; b=E6AlrKmYslBI3R6HuliFVFN80PvnxOoNTAiHNYDmeQz3G/RZ3ROFEQJvSRFIq9YA+pAMIwW96zq5V6AKvB7hgSHLyisiNMJr0++9uxtOAtlgoNaBUsCLQzQk96QhVJeWbaMP44O1YXYuE+yYHL9u6bwWyG2RZgqbZYzro8zvY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719886083; c=relaxed/simple;
	bh=mqbuUn8SstetqwMEgJhDzNHBoA2H0/6RZZk86cHB5BI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U88haIIVgZk10TH2Oj9MTlGUYLdHUrbDc1SsbWAxuOXMBd1UXLMn+OYD8DDbghGtWP6/wFApAzs3J6fcP4Ox34U9eEW9gceC4942sXlvq9LJFqn4QoLwikFSyakik6OJ+mRWXnY+e1gU1klJfyAVti5+00kc3UYILx0ZMvrusSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G2LR8mni; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719886078; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=BSjxLx45/dqE76s/WmX8kltJqe/j8keV+TgY0cmK50A=;
	b=G2LR8mni2AHHAheO9xedV3kcRyYPZ4JUuu+iMi+IjNuZ1uU854uQzxkVQIerZfg9mLJanK0ohwRe+ZMbaifwX4PmigbWCfGrSD2ZQikcEzkeZAo8U/sZyz/qGL934GXAXXXoVdJ0JvfI0U+toVScLL5R2po+XRl/XR9xyI+5SPQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W9ghq4X_1719886077;
Received: from 30.221.130.47(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W9ghq4X_1719886077)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 10:07:57 +0800
Message-ID: <e66d3dd0-4d16-463f-a567-b5f5f8da6a92@linux.alibaba.com>
Date: Tue, 2 Jul 2024 10:07:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: Please backport d8616ee2affc ("bpf, sockmap: Fix
 sk->sk_forward_alloc warn_on in sk_stream_kill_queues") to linux-5.10.y
To: stable@vger.kernel.org
Cc: alikernel-developer@linux.alibaba.com, Dust Li
 <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 mqaio@linux.alibaba.com
References: <d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com>
In-Reply-To: <d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/30 20:55, Wen Gu wrote:
> Hi stable team,
> 
> Could you please backport [1] to linux-5.10.y?
> 
> I noticed a regression caused by [2], which was merged to linux-5.10.y since v5.10.80.
> 
> After sock_map_unhash() helper was removed in [2], sock elems added to the bpf sock map
> via sock_hash_update_common() cannot be removed if they are in the icsk_accept_queue
> of the listener sock. Since they have not been accept()ed, they cannot be removed via
> sock_map_close()->sock_map_remove_links() either.
> 
> It can be reproduced in network test with short-lived connections. If the server is
> stopped during the test, there is a probability that some sock elems will remain in
> the bpf sock map.
> 
> And with [1], the sock_map_destroy() helper is introduced to invoke sock_map_remove_links()
> when inet_csk_listen_stop()->inet_child_forget()->inet_csk_destroy_sock(), to remove the
> sock elems from the bpf sock map in such situation.
> 
> [1] d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")
> (link: https://lore.kernel.org/all/20220524075311.649153-1-wangyufen@huawei.com/)
> [2] 8b5c98a67c1b ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
> (link: https://lore.kernel.org/all/20211103204736.248403-3-john.fastabend@gmail.com/)
> 
> Thanks!
> Wen Gu

Hi stable team,

Just want to confirm that the backport of this patch is consistent with the stable tree rules
as I thought. And is there any other information I need to provide? :)

Thanks for your efforts and time.

Regards.

