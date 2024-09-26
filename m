Return-Path: <stable+bounces-77815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BED98790F
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC021C211F7
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531F15B122;
	Thu, 26 Sep 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="kZXB2ijs"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391E33C9;
	Thu, 26 Sep 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374804; cv=none; b=laIoQt1O+0ozisdmnjYpwhtDm+3jQ65T3B4uW8HXAXKUBE5t1fqxGBQBH9DRhDvHcTWaEhy7t4s/zJFOTOMNJFIQeshQ57Lcnjz6lQrJCT4dhcW8jYzQyDHeFX9QYBemKqpQJSYdn85iLa0f2A5vUzGOA/HNvB7RzYqkqzWodXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374804; c=relaxed/simple;
	bh=7ZkVs4nnPjI2rQNTwm1YPPKVuKiehcF6zYAYQDzWh6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mskzji5aETh5uxUucz/skp3nDm3Bp/W+br8XKEeKKNKXDd+Hnc4Q4cc6VYOiExzC6YKUp8oktiEXTQoLYjWEOZB6TqYm93XV++KqF/1vLvWtG/lAZmkE6r8aQPfLqOVyMt10F5EzpLFmTIGIQnYIz1dlmKhUXLelfZVqgEJMAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=kZXB2ijs; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 67B18900082;
	Thu, 26 Sep 2024 18:19:54 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id CA17F13C2B0;
	Thu, 26 Sep 2024 11:19:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CA17F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727374793;
	bh=7ZkVs4nnPjI2rQNTwm1YPPKVuKiehcF6zYAYQDzWh6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kZXB2ijsLWGDLsP25yfUog2aOOI95nX/MExqjaEWp62KqRKfV5UPpX6RrcEfIT00v
	 TOwmS39GhL0/wwJLyBAF7k5ApUOd4Nf56YGrnj2KJtKICf0Mt0+l6oem7z+/VYxlW5
	 vA47YLUhi4fi2Zxgft27+Bp5qKS4hLT9eh4pPp34=
Message-ID: <1a2b63a4-edc7-c04d-3f80-0087a8415bc3@candelatech.com>
Date: Thu, 26 Sep 2024 11:19:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] Revert "vrf: Remove unnecessary RCU-bh critical
 section"
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240925185216.1990381-1-greearb@candelatech.com>
 <66f5235d14130_8456129436@willemb.c.googlers.com.notmuch>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <66f5235d14130_8456129436@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1727374795-yu6jrAICfM4r
X-MDID-O:
 us5;at1;1727374795;yu6jrAICfM4r;<greearb@candelatech.com>;d4f8116933a659757d195155729f2361

On 9/26/24 02:03, Willem de Bruijn wrote:
> greearb@ wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
>>
>> dev_queue_xmit_nit needs to run with bh locking, otherwise
>> it conflicts with packets coming in from a nic in softirq
>> context and packets being transmitted from user context.
>>
>> ================================
>> WARNING: inconsistent lock state
>> 6.11.0 #1 Tainted: G        W
>> --------------------------------
>> inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>> btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
>> ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
>> {IN-SOFTIRQ-W} state was registered at:
>>    lock_acquire+0x19a/0x4f0
>>    _raw_spin_lock+0x27/0x40
>>    packet_rcv+0xa33/0x1320
>>    __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
>>    __netif_receive_skb_list_core+0x2c9/0x890
>>    netif_receive_skb_list_internal+0x610/0xcc0
>>    napi_complete_done+0x1c0/0x7c0
>>    igb_poll+0x1dbb/0x57e0 [igb]
>>    __napi_poll.constprop.0+0x99/0x430
>>    net_rx_action+0x8e7/0xe10
>>    handle_softirqs+0x1b7/0x800
>>    __irq_exit_rcu+0x91/0xc0
>>    irq_exit_rcu+0x5/0x10
>>    [snip]
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(rlock-AF_PACKET);
>>    <Interrupt>
>>      lock(rlock-AF_PACKET);
>>
>>   *** DEADLOCK ***
>>
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x73/0xa0
>>   mark_lock+0x102e/0x16b0
>>   __lock_acquire+0x9ae/0x6170
>>   lock_acquire+0x19a/0x4f0
>>   _raw_spin_lock+0x27/0x40
>>   tpacket_rcv+0x863/0x3b30
>>   dev_queue_xmit_nit+0x709/0xa40
>>   vrf_finish_direct+0x26e/0x340 [vrf]
>>   vrf_l3_out+0x5f4/0xe80 [vrf]
>>   __ip_local_out+0x51e/0x7a0
>> [snip]
>>
>> Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
>> Link: https://lore.kernel.org/netdev/05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com/T/
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
> 
> Please Cc: all previous reviewers and folks who participated in the
> discussion. I entirely missed this. No need to add as Cc tags, just
> --cc in git send-email will do.
> 
>> ---
>>
>> v2:  Edit patch description.
>>
>>   drivers/net/vrf.c | 2 ++
>>   net/core/dev.c    | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>> index 4d8ccaf9a2b4..4087f72f0d2b 100644
>> --- a/drivers/net/vrf.c
>> +++ b/drivers/net/vrf.c
>> @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
>>   		eth_zero_addr(eth->h_dest);
>>   		eth->h_proto = skb->protocol;
>>   
>> +		rcu_read_lock_bh();
>>   		dev_queue_xmit_nit(skb, vrf_dev);
>> +		rcu_read_unlock_bh();
>>   
>>   		skb_pull(skb, ETH_HLEN);
>>   	}
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index cd479f5f22f6..566e69a38eed 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
>>   /*
>>    *	Support routine. Sends outgoing frames to any network
>>    *	taps currently in use.
>> + *	BH must be disabled before calling this.
> 
> Unnecessary. Especially patches for stable should be minimal to
> reduce the chance of conflicts.

I was asked to add this, and also asked to CC stable.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



