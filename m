Return-Path: <stable+bounces-267889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LoreMi5COmqv4wcAu9opvQ
	(envelope-from <stable+bounces-267889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 10:22:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F526B53D6
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 10:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KeN6hTky;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267889-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267889-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4106A3059798
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F273CE083;
	Tue, 23 Jun 2026 08:19:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B43CBE7A;
	Tue, 23 Jun 2026 08:19:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202749; cv=none; b=IxSnKK/4h0rJZDex3mLPeHHC5xhYSKxv9sHASuWMt/tqscDc9zuBm2Emxvbu4QOhPRF+wgIh5D1kBPvWwQRtqZ09m2oiGSPhIp+uJ4Dvimc0UiwgTnLRDKqI7AkzcskJS7wQsBsSdSDpYTYW8ZhOYCBuf5051xCHTdTKTXJyfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202749; c=relaxed/simple;
	bh=qxHlkYpauej8Q8mvZn8qY29TGxQZ89YsK0iffDY+Z94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAU2jdT6ZS7L9dFnj7Dmez1yC7aQKR2Vngpssa6FhVRLeOgJHD+XR8LLOxt7af70/zwwNKYMmH7PXcnqtIHPeK2ykT2gLYMsMxL/ZlMREhynndHE/OGRrUdOswNLzEcraFBqIakVIT8bOLWJThQP5vYLylp6z+zvXmZG6Q92hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeN6hTky; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7531F000E9;
	Tue, 23 Jun 2026 08:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782202747;
	bh=BUQHwxZu+8soINl8NscGOL62ssMYJX5NpGP960zta1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KeN6hTkyM+SruNEXlShOJVdxLmoZbsIgiTn8Yn7+h3UjKVk0/9FStM1Vpunci5w3X
	 EaOJlKpAGTWG+RXcKsdwm370+f4fN035xpD1oBbst/+WvzefcQKfVmoBop6ID/QfP3
	 RMTQgJjmmU159/ZSRHmZYcws6UnBMwBhoPC8VtvQb7PcltMb9Qcn/yCnxBYPQ3QIoQ
	 EUWe+GWE/RIn4ayn/vbIizg4s508nqTrSE2EqtX72U3onnXAf21nrLw3s6PL7DJ1GU
	 0dbUWUAxhDM0kDjya31PpOhWUu2JDcgPu4yqipGO7Xos2A+p2am1hXVzmwLdzKc7z9
	 SImpfQZY+ITgw==
Message-ID: <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
Date: Tue, 23 Jun 2026 17:18:59 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ULHFF9fXbXcUf502veQMDaYL"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-267889-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20F526B53D6

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ULHFF9fXbXcUf502veQMDaYL
Content-Type: multipart/mixed; boundary="------------xv4AXOs7gLhZWtRvpHP1aUpZ";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Message-ID: <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
In-Reply-To: <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>

--------------xv4AXOs7gLhZWtRvpHP1aUpZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/23/26 4:16 PM, Qi Zheng wrote:
> Hi Harry,

Hi Qi!

> On 6/23/26 2:17 PM, Harry Yoo wrote:
>> On 6/23/26 11:42 AM, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> The mglru page table walker batches per-generation size deltas in
>>> walk->nr_pages while walking page tables without holding the lruvec
>>> lock.
>>> The reset_batch_size() later folds those deltas into walk->lruvec und=
er
>>> the lruvec lock.
>>
>> Ouch.
>>
>> IIRC the user-visible impact of underestimated nr_pages in MGLRU
>> was premature OOMs because MGLRU does not try to reclaim memory when
>> nr_pages reaches zero, but there are still more pages.
>>
>> Perhaps worth mentioning in the changelog?
>=20
> Maybe this should be placed before "To fix it...".

Thanks!

>>> The page table walker can run concurrently with the memcg reparenting=

>>> path
>>> as follows:
>>>
>>> CPU0                           CPU1
>>> =3D=3D=3D=3D                           =3D=3D=3D=3D
>>>
>>> walk_mm
>>> --> walk_page_range
>>>      --> update_batch_size
>>>          --> walk->nr_pages +=3D delta
>>>
>>>                                mem_cgroup_css_offline
>>>                                --> memcg_reparent_objcgs
>>>                                    --> lock lruvec
>>>                                        lru_gen_reparent_memcg
>>>                                        --> reparent child folios to
>>> parent
>>>                                        unlock lruvec
>>>
>>>      lock lruvec
>>>      reset_batch_size
>>>      --> child lrugen->nr_pages +=3D delta
>>
>> The problem here is that, while grabbing a reference to memcg
>> (via mem_cgroup_iter(), for example) makes sure that the memcg is not
>> freed, it does not prevent offlining happening, and reset_batch_size()=

>> doesn't check whether the lruvec has been reparented, or the lruvec
>> is going to be reparented.
>>
>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>
>>>     VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>                    sizeof(lruvec->lrugen.nr_pages)));
>>>
>>> To fix it, add lrugen->reparented to remember the new owner of a
>>> reparented lruvec, and make reset_batch_size() charge pending deltas =
to
>>> that owner.
>>
>> Could you please explain why it is unavoidable to introduce the new
>> field and why checking whether the cgroup is dying (and charging delta=
s
>> to non-dying parent) doesn't work?
>=20
> Peiyang tried doing this [1], but it doesn't work because
> ss->css_offline() is called before clearing the CSS_ONLINE flag.

Right.

> I also considered using mem_cgroup_tryget_online(), but that only preve=
nt
> the memcg from being freed. It's doesn't prevent the offlining.

Right.

I think checking CSS_DYING under RCU and grabbing the lruvec
of the first non-dying memcg should work (this pattern is already
used where we use RCU to guarantee memcgs are not freed).

If we do not observe CSS_DYING flag, it is safe to charge deltas
to the lruvec because RCU guarantees that reparenting cannot happen
under us.

If we do observe CSS_DYING, we can walk up the hierarchy and charge
deltas to the first non-dying memcg.

This requires introducing an API to grab the first non-dying
lruvec lock like folio_lruvec_lock_irq(), but it can be called only
when the caller has a reference to make sure it doens't go away.
(I wonder if there are other places that requires similar semantics)

or am I missing something?

> So in the end, I chose the approach used in this patch. Simply adding
> a new field to mglru to track its reparenting status seems to be the
> most straightforward and effective approach.

I think it would work, but we need some explanation on why this
requires special handling compared to other stuff (e.g., reparenting
of split queues).

> Thanks,
> Qi

Thanks for working on this, Qi!

> [1]. https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-
> a53a-1e28cc894f0b@smail.nju.edu.cn
>=20
>>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-
>>> efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folio=
s")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reviewed-by: Barry Song <baohua@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------xv4AXOs7gLhZWtRvpHP1aUpZ--

--------------ULHFF9fXbXcUf502veQMDaYL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajpBcwAKCRCGXBN6rc5S
1paQAP9NwREVzNQHOLbOsFTerap+KpfzuPi6heE+TjYcUtrZbwEA5Pv5vU0w3cic
1ozfD0QNcLIqt8z+hZEeYGE73LDpwgg=
=2TeK
-----END PGP SIGNATURE-----

--------------ULHFF9fXbXcUf502veQMDaYL--

