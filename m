Return-Path: <stable+bounces-56348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D840923E2B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED171C21894
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9416C6A6;
	Tue,  2 Jul 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eaeRNxun"
X-Original-To: stable@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8616C695
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924916; cv=none; b=Te4Bq+BOTrKqUXYFXCYdKWcolMPpdRpmNbgL5Z3BsI5YerczM9LctQga9hbr6kHJuMdaPpw1twYN+0BGAFFbnfM4P1ACc3Vz4MQCR4TJ2nKQn2K3rk39dQ1jD2HQVHKQljWWvKjnMweHHVCALmotigHQa0WndbmoMUQC6xjxG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924916; c=relaxed/simple;
	bh=1evMwTbUB6uGBPGpFVIQ+uOPwVKefHecikYKqR1tmpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHcOBbwAnmfTYcVuel7Jt6CAr91szLODdMwQ9XNO6+RgzG7OXcMFe+Q77Tu/AlKhLtVe3+OC+KZb/5859svManLzoRrBEozrZwHrFC5mdOiX4IGBvS8/AFSgBPbByLTl6Nc6bJdiLPa7MfqSABWF5aRP4Yv9bw8P2kNQD0LyygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eaeRNxun; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719924911; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tNdrriyktGVxxLE77tQWhyAIF2L994vn4q6J6QZYFZo=;
	b=eaeRNxun7jJq6lqOvUehAfZsZcOjpCQgjt7VhE8boAXhUMBPVZbPOm1p9PrfpchBem7GRMDWhskcPGxvrBoOJaMN2r0DuJm0btjg6JJf67k3DeYah9Ls/Gklv88Szk40HVUAMJAenOxJgLtv4KjqZpNabBlFvGrHg+aKqS3pkBw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W9iwnTs_1719924910;
Received: from 30.221.130.47(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W9iwnTs_1719924910)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 20:55:10 +0800
Message-ID: <bf61a368-6b1a-4b85-a51b-e1343132578d@linux.alibaba.com>
Date: Tue, 2 Jul 2024 20:55:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please backport d8616ee2affc ("bpf, sockmap: Fix
 sk->sk_forward_alloc warn_on in sk_stream_kill_queues") to linux-5.10.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, alikernel-developer@linux.alibaba.com,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 mqaio@linux.alibaba.com
References: <d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com>
 <e66d3dd0-4d16-463f-a567-b5f5f8da6a92@linux.alibaba.com>
 <2024070221-clergyman-oversold-d24a@gregkh>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <2024070221-clergyman-oversold-d24a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/2 16:22, Greg KH wrote:
> On Tue, Jul 02, 2024 at 10:07:56AM +0800, Wen Gu wrote:
>>
>>
>> On 2024/6/30 20:55, Wen Gu wrote:
>>> Hi stable team,
>>>
>>> Could you please backport [1] to linux-5.10.y?
>>>
>>> I noticed a regression caused by [2], which was merged to linux-5.10.y since v5.10.80.
>>>
>>> After sock_map_unhash() helper was removed in [2], sock elems added to the bpf sock map
>>> via sock_hash_update_common() cannot be removed if they are in the icsk_accept_queue
>>> of the listener sock. Since they have not been accept()ed, they cannot be removed via
>>> sock_map_close()->sock_map_remove_links() either.
>>>
>>> It can be reproduced in network test with short-lived connections. If the server is
>>> stopped during the test, there is a probability that some sock elems will remain in
>>> the bpf sock map.
>>>
>>> And with [1], the sock_map_destroy() helper is introduced to invoke sock_map_remove_links()
>>> when inet_csk_listen_stop()->inet_child_forget()->inet_csk_destroy_sock(), to remove the
>>> sock elems from the bpf sock map in such situation.
>>>
>>> [1] d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")
>>> (link: https://lore.kernel.org/all/20220524075311.649153-1-wangyufen@huawei.com/)
>>> [2] 8b5c98a67c1b ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
>>> (link: https://lore.kernel.org/all/20211103204736.248403-3-john.fastabend@gmail.com/)
>>>
>>> Thanks!
>>> Wen Gu
>>
>> Hi stable team,
>>
>> Just want to confirm that the backport of this patch is consistent with the stable tree rules
>> as I thought. And is there any other information I need to provide? :)
> 
> Please relax, you sent this on Sunday and asked about it on Tuesday,
> barely 1 day later?
> 

Sure, there's no intention to rush, just confirming this backport requirement is reasonable. Sorry for the noise.

Thanks.

