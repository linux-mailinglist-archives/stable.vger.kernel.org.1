Return-Path: <stable+bounces-241515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YErAHNt88GkaUAEAu9opvQ
	(envelope-from <stable+bounces-241515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:24:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C5481525
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D6403076D4B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F9C372EF3;
	Tue, 28 Apr 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMOrnfeR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGnA+kXX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904A3750CC
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367663; cv=none; b=fAvK3Bagxkig0H2p7iT4UMi+gRpFm4mxkRy3M/LZ6emvb0hefYcRdTZqf6y+/6tbSBr7Tik5TMExZw0BW3znOj3pZ7r1Evfku7DxDT+Nnh/mIa+Px1OuUw9rOJvKnIBvWf9hYFDKTdBdb0crgyQTvMCmBjPLHNkg+lrafur+Emo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367663; c=relaxed/simple;
	bh=4GkDVVEv08AkmrNXJY3nxp8e2TsLCNnF8yTHag+O6bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOA3Aad5qkZJincqIfE7MIXBYkb9wn9WV4EdeNRiPEJmdxDg8mG1gNbWQUqF+ayf9CE4SQoe+yA7f9k6RhUvm1InOxQhc6zYshPNfyGrWi67GKsjezFP6groiHLUEaqhthpaFHi+5GG+gnwLwKWDD6SFH4IXR5Ctrc+tYx8UvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMOrnfeR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGnA+kXX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777367661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
	b=HMOrnfeRG71sV8y5jDg7KVt1unMmcKc9ITRD6VP5u6Y1TleWve0uj2D/EXa4i4vxEClN7o
	dWy4FLIk8H2Ip698rheu4fjRla3MVANu3YAk6M/S+tsu0nWWmPDjYrTfyt1KhZnY4f7xXR
	V6v3MLdk2tFLxQytFoWVfJIO+G26WYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-srtZBWIHNpGO3xvYM84xNg-1; Tue, 28 Apr 2026 05:14:20 -0400
X-MC-Unique: srtZBWIHNpGO3xvYM84xNg-1
X-Mimecast-MFC-AGG-ID: srtZBWIHNpGO3xvYM84xNg_1777367659
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43ff0eb2b2aso8302182f8f.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777367659; x=1777972459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
        b=JGnA+kXXFTQCh1znoikaAsEly669RudeuB8YNBsLio4363kypED6u0iGkbTW7ludzY
         VpiNSGMzKiKWhEcgx5tQ5nYNvGl79rjnY90gyuBRh9w1ambS2bk+q4DaHggPExp0vr3k
         FnFWfzbKswgIwK+XYBtMTlfT0kLj6HWkQQyGNsveg4w8f7Kw+vLv+wQmED/bQZfUSIDR
         m5poowyKmFnQq2zy5QHuVdKz1Lqc85+BvuHdY2FRBOyCTtNS2mPYt1LqXYoEcGGRshCX
         Kmf6JyEomS/WS1JPvARMbSyvKSeSNZMk4B+WFlPkigY/PmQXmufc6+Ot8fI+3LV2I7W7
         UGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367659; x=1777972459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
        b=VmZ0T9mRTcmXIx95GX5iYmPt4Ancqw1fG0Kk/oJI5VB8UG+O6o0ubFHi62MZYF3VoM
         zJVcUp/PCyrPFUpqXdTQTDUn3OWKJZxLQ4BRD/PCtAyR+y7IJ01tI/uEVoFkYs414nTe
         bLe+FcjTTM7MZ27pLTJ2LdGDWvbRe8ZcVGisENi74dO2Xq4dtoOokP5oLYJ+tt2hKkwc
         tV1Ro81jOoGRgLWrJIaqvpgD5ArP/mJJx+HrCg3c5W55gKyksNvV4HnUhU7MSzjt7dnH
         mF7KyE19I7lCAZSLAwu3wXggtH+i/Hb5un4tvIC0/ZvYOg2/A/7+We0fQBto3ICLlBcR
         /BNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UjQKkFslqCzn7XFYPDWOhd48wwwp3wjlqbi3gIYEYk9YyohOP3DwMWzUQbZvNEljVA5StH1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4jW1Ss7vibee9g04nGQr04aHmEbKB5bdWNCUqH3+qwf5GP3X
	EJVmYiIThpPA+PQw5StAeGnl3wls93AGTI4T387sTVaDji6FOm9v5NuON+IF+yHCwm8HGuSuLUZ
	+DSq3BnkE++OxYmyQgMnCXN62RDC91utSLQtVOq/IkK6Tkv+qWeCOlyHa5Q==
X-Gm-Gg: AeBDiev3zBvLd4bHgso0O3MqIQVal9B5JeniQSpwePHhWtRxnUo1xpQfzgghCrG2/XG
	MZNeQHG7WUsIughFseRH4KS5QdMxKxsvpWtegUE5qgWhpoAqO7FrvQW3wlYk718x/zls8Y98Ije
	WobwoA0nXh3i36E+h7AmzIYr6rg3gIazmPCTOJHdJawDB58PzuqNd7Z6Qo43Ys2IDvn41ISZ0NL
	zSHfULKqb++b5ZCOBMFP2L3CmWYSgnNFq08+epJdg3jmmLPrdMJ33P99aF7haeS/ObNHseJqI3M
	Gs4yFvrhnJEIC/Nj3rt7TH19o8hYHRVXvz2SDLRG5Xc+9cDaRUXHU2Lh1V/pj5fkHURHvSH5Hsu
	uLI6NDezjypIomHBKugkRoiSoWqESDh/8Bc5tyjuvaIBtJZHoIjIAkcrlpCfI+a0oOw==
X-Received: by 2002:a5d:5f51:0:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4464a070032mr4183702f8f.42.1777367658520;
        Tue, 28 Apr 2026 02:14:18 -0700 (PDT)
X-Received: by 2002:a5d:5f51:0:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4464a070032mr4183660f8f.42.1777367658030;
        Tue, 28 Apr 2026 02:14:18 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fa89140sm4764422f8f.27.2026.04.28.02.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:14:17 -0700 (PDT)
Message-ID: <efe42959-81c4-4d35-a3d0-fd084c9cda25@redhat.com>
Date: Tue, 28 Apr 2026 11:14:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, clrkwllms@kernel.org,
 rostedt@goodmis.org, david.lebrun@uclouvain.be, alex.aring@gmail.com,
 Justin Iurman <justin.iurman@gmail.com>, stefano.salsano@uniroma2.it,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
 <20260423080056.KgHlh9Oa@linutronix.de>
 <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 375C5481525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-241515-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]

On 4/25/26 4:08 PM, Andrea Mayer wrote:
> On Thu, 23 Apr 2026 10:00:56 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> Hi Sebastian,
> 
> thanks for the review, and to Simon and Justin as well.
> 
> 
>> On 2026-04-21 11:47:35 [+0200], Andrea Mayer wrote:
>>>
>>> [snip]
>>
>> So the dst passed to skb_dst_set_noref() has no reference count. The fix
>> is to use skb_dst_force() to increment the refcount on it. But this
>> requires that we are in the same RCU section. And I guess we are since
>> none of the warnings are visible.
>  
> Yes. lwtunnel_input() holds rcu_read_lock() around ops->input(), which is
> where seg6_input_core()/rpl_input() execute. The skb_dst_force() is called
> within that RCU section.
>  
> 
>> Doesn't this make ip6_route_input() on RT fragile in general due to the
>> RT6_LOOKUP_F_DST_NOREF usage or here something special about the two
>> files that are patched?
>> Based on your explanation it all makes sense, I am just not sure if this
>> race is limited to those two are if there is more to it.
> 
> seg6_input_core() and rpl_input() cache the dst via dst_cache_set_ip6(), which
> invokes dst_hold(). The dst_hold() calls rcuref_get(), failing on a zero
> refcount and triggering a WARN, but the pointer is still stored in the cache.
> After the RCU grace period completes the dst is freed, and a subsequent
> dst_cache_get() returns a dangling pointer.
>  
> The other callers of ip6_route_input() (e.g., ipv6_srh_rcv, ipv6_rpl_srh_rcv,
> ip6_rcv_finish_core) consume the NOREF dst without caching it. Even if the
> pcpu_rt's refcount is concurrently dropped to zero, the dst memory remains
> valid because dst_release() defers the actual free via call_rcu_hurry() and the
> caller is still inside the RCU read-side critical section.
> 
> 
>>> [snip]
>>>
>>> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
>>> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
>>
>> If having PREEMPT_RT_NEEDS_BH_LOCK unset is the requirement then the
>> right fixes: would be
>> Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
>>
>> as prior this commit the race is not possible, right?
> 
> I built and tested kernels at 3253cb49cbad and its parent fd4e876f59b7 (both
> CONFIG_PREEMPT_RT=y, without the fix): no issues at fd4e876f59b7.
> At 3253cb49cbad, a pcpu_rt cmpxchg contention in rt6_make_pcpu_route() shows
> up, which was addressed in 1adaea51c61b. I also tested at 1adaea51c61b, and at
> that point the dst_hold() race described in this patch appears.
>  
> The seg6/rpl code obtains a NOREF dst from ip6_route_input(), does not promote
> it via skb_dst_force(), and passes it to dst_cache_set_ip6() which calls
> dst_hold(). This pattern has been present since af4a2209b134 and a7a29f9c361f,
> and the current Fixes: tags point to the commits where it was introduced.
> Does that seem reasonable?

I think the above is correct, but also pointing to 3253cb49cbad4 would
be correct, since the latter is required to exploit the problem. I also
think cases like this one it's better to avoid the repost (since the
constant ML flood) and to err on the conservative side (older hash). So
I'm applying the patch as-is.

Thanks,

Paolo


