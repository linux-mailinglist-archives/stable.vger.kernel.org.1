Return-Path: <stable+bounces-244818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGg4KyQ9/mlmoQAAu9opvQ
	(envelope-from <stable+bounces-244818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:44:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4364FB39F
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 374BE300A31E
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2319F3CBE95;
	Fri,  8 May 2026 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p40rMahv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361E3FE34D
	for <stable@vger.kernel.org>; Fri,  8 May 2026 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269473; cv=none; b=AzXkajD9u5sdV5T3fVVQVrnAm188gO2l4j7oNeulnoqUePpLTy2AMeDDKAFfBif3xJ8zvFtGrpbhRILG3TS4t7iWNXZtenzaj1RPKC/teQSORnGyzcHFDxqio/v6b0rNp0YENZyPWFS8Y14D4wxCdEX7EZ3NRS9SEH50hHUgOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269473; c=relaxed/simple;
	bh=qyTl2ymgQqX3Kx4pKTOe5UoaJUgK+Hz/XneBslM3Dx0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D90SSmIV9rRJFCbSZc5iUT9+cSKiL6wQJpx+8ihC1eJRkK8SxaB1XSEGHd/mpzpIAmSJSKFNXkSgBI1i444WIB96/fmJ7cXjf/7JolER5FSJ+xqD45JOtsBsAK8JJZ6P4sRC4wcBAXba/WiFNU3v8I0pI1J6bD68/qflcpzTSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p40rMahv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fbd79350dso20563401cf.3
        for <stable@vger.kernel.org>; Fri, 08 May 2026 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778269469; x=1778874269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxZbOgmXVgyW7qx2mNw/iaUaD8Rd/NnI6+5bQxDUCo0=;
        b=p40rMahvh3eZgsZs7MOJeLTRaK6npqoco3w6Bap2T9ZV7YQVsmyRMM6xpx53GgYRZG
         qgrE9RCezpQTGnqOxnjsFG3iftZ8uYQiRUbNl4zHV4qKQZwg6gKf0bYCCLIZ3g0yZo/t
         aoTm6Oh5yyY1tRqbl+/FA/MVXKPDukBjeqiUzZevs30nFjqugQmkNCZrgAIOZ/fND14t
         rwsNay6Crj19XxHkiXLv7xK+Rn9TpJc3x3hFN/2SQfE+FQGs6yzD2Zx76tYyeqHBwVJV
         fRvfjlIU1zxZYPdntN4U88tP7n0nw02z5hZ6EwO4jlpr9Iks7YymOHXn8QtgCHDvtWmm
         Z14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778269469; x=1778874269;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxZbOgmXVgyW7qx2mNw/iaUaD8Rd/NnI6+5bQxDUCo0=;
        b=iDMmvIbD4fQiF0MQv61j59s3XuO2rG9S5Bjlx1Zhf7Ierq1fuFQHTNo+HEFpDzeznr
         DwZSeuvl1enhBTLB7wFrXL0/v6EebfLi16NoLsa0Vax0PD1qfGIxcVJC6OmT5PJc8vR6
         4JpJl5GGzycCtYSTWRYMlTJtSDIFSkimDOD6RFEwcEZZJ3f4YRiA3SQxyWVrAbBI7FpN
         TUAYVxB8yXg/YdKYr3aWYB1rp3QaXLnUMEMLLIl4W4CLqWzawoNE5WHRcWMtwuI2b7Ep
         tIZGJfB3FG/whnDGgUcOKiEjMPQ87eg4IQUXBYywoQLhvBbVDOS2w4U7hErqPyiBBIj1
         27qA==
X-Forwarded-Encrypted: i=1; AFNElJ8VGl2TI5gv/mL+38agUtrtEVCh7R378M0A7jgthnOv0fUcPiQ9H4JsesXY9Qb11G78+xrnkTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxJhJyWxmST/beh8zF5D0nmxq5qkPUMZ8ULe10KfxTcSKaZ2U
	R73yjsfaje7Prk6NTeybDImZ2Lx4D+HIKvt6P4bOl1cyUDlPmItAFVQ=
X-Gm-Gg: AeBDietDBakwD4dH0JMFgu+CFry+cpEV1b2MkC9h2GWftyuta2jCzfqfoRzmH8YgaA4
	aCkVCKRX2ds/EGmuhfaAnTR+QPfuBNXWZmM8vy7ivPQ6/el8j5QfAiTzg4YY2emLtsTaMIULMLm
	IXtM0J8/Q6OdUT6WnP9MHN80w6Io8hwaQ8Crs9ARshgVA9tZDbIAhndLdaBitXLvUM8NPxBpE76
	WcoSMY5cUS0DabJJBHLC+xICBgxPPpLcEMn3nfNtoh4d3Er+WxjZO1eEFIugcPiLOqgXOlS92Mt
	6Iq7NOOl/kP/zLTPkoo7jPY4vFv5/gU6t+nacFWZ5AGM2PlvSSxKddfHb/TJz2Eo/69UCh2NwM9
	uoAqXn3aneXnONZPhtK2tUzwk5Mwa2UBjI9oSQWMOfC4zGiBn1XuMUfYVkycjON0jUh6FAdPi4Z
	PlCex9/oDmg+2QUWnl+RyCtQl0hV6/Oa+EbDUpRRJHiTb7aoW2n1lgdA08vmLNsQ==
X-Received: by 2002:a05:622a:5c0d:b0:50d:a644:699d with SMTP id d75a77b69052e-51461fb988fmr175300251cf.46.1778269468933;
        Fri, 08 May 2026 12:44:28 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e82ad3dsm23954141cf.26.2026.05.08.12.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 12:44:28 -0700 (PDT)
Subject: Re: Linux 5.15.205
To: Ben Hutchings <benh@debian.org>, Ron Economos <re@w6rz.net>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>,
 Dominik Grzegorzek <dominik.grzegorzek@oracle.com>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "lwn@lwn.net" <lwn@lwn.net>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "jslaby@suse.cz" <jslaby@suse.cz>
References: <2026050835-appealing-stallion-a207@gregkh>
 <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
 <2026050829-gladiator-displease-57af@gregkh>
 <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
 <2026050855-valley-slashed-c382@gregkh>
 <CALUEkOfBS7qsN-7ERMS+2wcPEixXAGmquREu7uv8ecXn6d7haw@mail.gmail.com>
 <2026050815-length-yummy-f8b6@gregkh>
 <036ef29e143799f9117792463d640916490fa61a.camel@debian.org>
 <2026050840-washcloth-showdown-b66f@gregkh>
 <f922379b-e8a6-4d38-9589-029a8d52126d@w6rz.net>
 <19cc282f2e3b821e2dc3930cf5207bc251010307.camel@debian.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <cc26b57e-62b3-cd4d-e072-2019da2a232d@gmail.com>
Date: Fri, 8 May 2026 15:44:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <19cc282f2e3b821e2dc3930cf5207bc251010307.camel@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A4364FB39F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,lwn.net,vger.kernel.org,suse.cz];
	TAGGED_FROM(0.00)[bounces-244818-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[terraluna977@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Ben Hutchings wrote:
> On Fri, 2026-05-08 at 12:06 -0700, Ron Economos wrote:
>> On 5/8/26 07:50, gregkh@linuxfoundation.org wrote:
>>> On Fri, May 08, 2026 at 04:38:45PM +0200, Ben Hutchings wrote:
>>>> On Fri, 2026-05-08 at 16:30 +0200, gregkh@linuxfoundation.org wrote:
>>>>> On Fri, May 08, 2026 at 04:07:31PM +0200, Massimiliano Pellizzer wrote:
>>>>>> On Fri, May 8, 2026 at 3:50 PM gregkh@linuxfoundation.org
>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>> On Fri, May 08, 2026 at 03:13:51PM +0200, Massimiliano Pellizzer wrote:
>>>>>>>> On Fri, May 8, 2026 at 2:44 PM gregkh@linuxfoundation.org
>>>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>>>> On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I may be mistaken, but I think there might be a small typo in this hunk in net/ipv4/ip_output.c:
>>>>>>>>>>
>>>>>>>>>> skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
>>>>>>>>>>
>>>>>>>>>> Would this need to be:
>>>>>>>>>>
>>>>>>>>>> skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
>>>>>>>>>>
>>>>>>>>>> My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shared_info->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.
>>>>>>>>> Adding Ben who did the 5.10 backport so he can comment on this.
>>>>>>>>>
>>>>>>>>> thanks,
>>>>>>>>>
>>>>>>>>> greg k-h
>>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> The new released kernel 5.15.205 is still vulnerable to CVE-2026-43284.
>>>>>>>>
>>>>>>>> ```
>>>>>>>> $ ./run.sh
>>>>>>>> === Stage 1 — overwrite 'systemd-timesync' line (89 bytes) with
>>>>>>>> 'sick::0:0:<pad>:/:/bin/bash'
>>>>>>>> === Stage 2 — verify
>>>>>>>> sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX:/:/bin/bash
>>>>>>>> === Stage 3 — su - sick (empty password via PAM nullok)
>>>>>>>> [i] state saved to /var/tmp/.cf2.state — run './run.sh --clean' to revert
>>>>>>>> # uname -r
>>>>>>>> 5.15.205
>>>>>>>> ```
>>>>>>>>
>>>>>>> Does the patch below fix this up?
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>>>
>>>>>>> ------------------
>>>>>>>
>>>>>>>
>>>>>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>>>>>> index 68509e1f89b5..5d8f8a5901bc 100644
>>>>>>> --- a/net/ipv4/ip_output.c
>>>>>>> +++ b/net/ipv4/ip_output.c
>>>>>>> @@ -1443,7 +1443,7 @@ ssize_t   ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
>>>>>>>                           goto error;
>>>>>>>                   }
>>>>>>>
>>>>>>> -               skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
>>>>>>> +               skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
>>>>>>>
>>>>>>>                   if (skb->ip_summed == CHECKSUM_NONE) {
>>>>>>>                           __wsum csum;
>>>>>> Yes, this works.
>>>>> Wait, is this also needed in the 6.1.y backport as well?
>>>>>
>>>>> Ben, I'm guessing you tested the 6.1.y backport, right?
>>>> Yes, but on 6.1 the PoC never succeeded for me even without the patch.
>>>> (On 5.10 and 6.12 it does.)  So unfortunately that testing could not
>>>> show whether my attempted fix was correct.
>>>>
>>>> Sorry for screwing this one up.
>>> Not a problem, thanks for doing the backport at all!  I'll go do a new
>>> 6.1.y release now.
>>>
>>> Releases for everyone!!!
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>> Doesn't 5.10.255 need the flag fixup too?
> In 5.10 it was correct to set this flag in skb_shared_info::tx_flags:
>
> static inline bool skb_has_shared_frag(const struct sk_buff *skb)
> {
> 	return skb_is_nonlinear(skb) &&
> 	       skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
> }
>
> Ben.
>
Thanks for the above confirmation...
Woody


