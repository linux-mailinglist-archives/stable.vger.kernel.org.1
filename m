Return-Path: <stable+bounces-232838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH0oEFxezWlncgYAu9opvQ
	(envelope-from <stable+bounces-232838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:05:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90B37F017
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0953730451F9
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 18:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F32FE071;
	Wed,  1 Apr 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWEX0hUj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317B2FD66D
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066665; cv=none; b=JkCfpBxR8I63qhX9fW3Pzstve9nmCqHY1Q/NP3MI/4dshc92h4Wg6oGIlLbIXSt69CrWVy7HZdcEYXqce+tucK8bxDDUpHNsGXE9YeOsa4h7/c5NTCv8YjqJySBJUDk3GuBxCKDjrYhG6VggVPvYy6wANZ8EtShBGGisj5ZnXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066665; c=relaxed/simple;
	bh=n+y42mHTikwUyqvxWweJBElPlT5cA/NkDtOvB9ABQ2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YD1wpCfXcYVQvzFM63Lstoz2Rui4jr5OZUWYwYQ5rhCtKIVdDxENM5PNB0Qi7itdLbzuVb1EZ3VYc+fv81D22dfbFdNsUQwbJTyiRiTdfbcBe4S7KhWIy7sK8/V4oK30sYFiMYQGCKoGiLRp+NKrbUPmFy1mj+9+Ovqi9IGNYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWEX0hUj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775066662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHfausQ4IwtvMkybG2aXvWsg8wsDkjntzxDmbQVjIVI=;
	b=QWEX0hUjon6AFU+HMNzvfpFSzQ0FiVbZDk+HjXQOYAVHEgN7+L6yMq1Ztx3rpjWSS53PF3
	XuQSyXKfc0OECscWiAOU5xyzqRatC6JupnSm81dLhOyD6/thijkjsYNZOGkNtbb1ksG9my
	JmfEjCdxo67LmA4JgOT4rlOdFUD6kmY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-kqARiL1nPcOtGWdsxsHEjQ-1; Wed,
 01 Apr 2026 14:04:18 -0400
X-MC-Unique: kqARiL1nPcOtGWdsxsHEjQ-1
X-Mimecast-MFC-AGG-ID: kqARiL1nPcOtGWdsxsHEjQ_1775066656
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6223A1800372;
	Wed,  1 Apr 2026 18:04:16 +0000 (UTC)
Received: from [10.22.81.104] (unknown [10.22.81.104])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0A5630001A2;
	Wed,  1 Apr 2026 18:04:14 +0000 (UTC)
Message-ID: <55434043-ec42-4c3a-a534-4f7a46f4fb17@redhat.com>
Date: Wed, 1 Apr 2026 14:04:13 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list
 when unplugging multiple inactive works
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Carlos Santa <carlos.santa@intel.com>,
 Ryan Neph <ryanneph@google.com>, stable@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
References: <20260401010739.1053192-1-matthew.brost@intel.com>
 <8eaf9c5e-70fc-4d68-a919-df371bb38283@redhat.com>
 <ac08UdszEeEI2iJj@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ac08UdszEeEI2iJj@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,google.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232838-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: AF90B37F017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 11:40 AM, Matthew Brost wrote:
> On Wed, Apr 01, 2026 at 10:44:55AM -0400, Waiman Long wrote:
>> On 3/31/26 9:07 PM, Matthew Brost wrote:
>>> In unplug_oldest_pwq(), the first inactive work item on the
>>> pool_workqueue is activated correctly. However, if multiple inactive
>>> works exist on the same pool_workqueue, subsequent works fail to
>>> activate because wq_node_nr_active.pending_pwqs is empty — the list
>>> insertion is skipped when the pool_workqueue is plugged.
>>>
>>> Fix this by checking for additional inactive works in
>>> unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
>>> accordingly.
>>>
>>> v2:
>>>    - Use pwq_activate_first_inactive(pwq, false) rather than open coding
>>>      list operations (Tejun)
>>>
>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>> Cc: Ryan Neph <ryanneph@google.com>
>>> Cc: stable@vger.kernel.org
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Fixes: 4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqueues")
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>
>>> ---
>>>
>>> This bug was first reported by Google, where the Xe driver appeared to
>>> hang due to a fencing signal not completing. We traced the issue to work
>>> items not being scheduled, and it can be trivially reproduced on drm-tip
>>> with the following commands:
>>>
>>> shell0:
>>> for i in {1..100}; do echo "Run $i"; xe_exec_threads --r \
>>> threads-rebind-bindexecqueue; done
>>>
>>> shell1:
>>> for i in {1..1000}; do echo "toggle $i"; echo f > \
>>> /sys/devices/virtual/workqueue/cpumask; echo ff > \
>>> /sys/devices/virtual/workqueue/cpumask; echo fff > \
>>> /sys/devices/virtual/workqueue/cpumask ; echo ffff > \
>>> /sys/devices/virtual/workqueue/cpumask; sleep .1; done
>>> ---
>>>    kernel/workqueue.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>>> index b77119d71641..bee3f37fffde 100644
>>> --- a/kernel/workqueue.c
>>> +++ b/kernel/workqueue.c
>>> @@ -1849,8 +1849,17 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
>>>    	raw_spin_lock_irq(&pwq->pool->lock);
>>>    	if (pwq->plugged) {
>>>    		pwq->plugged = false;
>>> -		if (pwq_activate_first_inactive(pwq, true))
>>> +		if (pwq_activate_first_inactive(pwq, true)) {
>>> +			/*
>>> +			 * pwq is unbound. Additional inactive work_items need
>>> +			 * to reinsert the pwq into nna->pending_pwqs, which
>>> +			 * was skipped while pwq->plugged was true. See
>>> +			 * pwq_tryinc_nr_active() for additional details.
>>> +			 */
>>> +			pwq_activate_first_inactive(pwq, false);
>>> +
>>>    			kick_pool(pwq->pool);
>>> +		}
>>>    	}
>>>    	raw_spin_unlock_irq(&pwq->pool->lock);
>>>    }
>> Thanks for fixing this bug. However, calling pwq_activate_first_inactive
> No problem — I think this one has been lurking around for a while, and
> we’ve just papered over it in Xe for a couple of years.
>
>> twice can be a bit hard to understand. Will modifying pwq_tryinc_nr_active()
> I actually think it makes quite a bit of sense, as it matches what
> __queue_work does if two items are added back-to-back on an ordered
> workqueue — the first one updates the nr_active counts and activates,
> and the second one updates the pending_pwqs.
This patch works because only an ordered workqueue with a max_active of 
1 can be plugged. Perhaps you should put the note above into the comment 
too.
>> like the following works?
>>
> My initial thought was that your snippet should work — in fact, it does
> for a while (drm-tip hangs almost immediately), but eventually I do get
> a hang when running my reproducer, whereas with this patch I don’t. I
> can’t reason exactly why — maybe it’s because
> node_activate_pending_pwq() can find a plugged pwq, but that’s just a
> guess.

That may be the case. Thanks for checking it anyway.

Acked-by: Waiman Long <longman@redhat.com>

> Matt
>   
>> Thanks,
>> Longman
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index b77119d71641..b35e6e62e474 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1738,9 +1738,6 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>>                  goto out;
>>          }
>> -       if (unlikely(pwq->plugged))
>> -               return false;
>> -
>>          /*
>>           * Unbound workqueue uses per-node shared nr_active $nna. If @pwq is
>>           * already waiting on $nna, pwq_dec_nr_active() will maintain the
>> @@ -1749,13 +1746,19 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>>           * We need to ignore the pending test after max_active has increased as
>>           * pwq_dec_nr_active() can only maintain the concurrency level but not
>>           * increase it. This is indicated by @fill.
>> +        *
>> +        * If @pwq is plugged, we need to make sure that it is linked to a
>> +        * pending_pwqs of a $nna.
>> +        *
>>           */
>> -       if (!list_empty(&pwq->pending_node) && likely(!fill))
>> +       if (!list_empty(&pwq->pending_node) && likely(!fill || pwq->plugged))
>>                  goto out;
>> -       obtained = tryinc_node_nr_active(nna);
>> -       if (obtained)
>> -               goto out;
>> +       if (likely(!pwq->plugged)) {
>> +               obtained = tryinc_node_nr_active(nna);
>> +               if (obtained)
>> +                       goto out;
>> +       }
>>          /*
>>           * Lockless acquisition failed. Lock, add ourself to $nna->pending_pwqs
>> @@ -1773,7 +1776,8 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>>          smp_mb();
>> -       obtained = tryinc_node_nr_active(nna);
>> +       if (likely(!pwq->plugged))
>> +               obtained = tryinc_node_nr_active(nna);
>>          /*
>>           * If @fill, @pwq might have already been pending. Being spuriously
>>


