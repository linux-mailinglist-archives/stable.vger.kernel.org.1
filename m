Return-Path: <stable+bounces-268256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tJxzFaarPGosqQgAu9opvQ
	(envelope-from <stable+bounces-268256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:16:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6476C2A85
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FpHe8Xbp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268256-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268256-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 637533008FE6
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B123183F;
	Thu, 25 Jun 2026 04:16:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE082F3600;
	Thu, 25 Jun 2026 04:16:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782360990; cv=none; b=LIABi2IY5Z5BZ6P8pLk62/6ugOd0jdRbUX7+s3ylC2v1VDkpb647Ri3C+GPVEoTY4gdF7JxP5laIpXs7cAPv1lCC4nxDkzjyZVkJ14iGFH5WumwkN4pCZEtoKVltxtKJWRjV93g8Z0W+FrAdMmEZujswhrPjmstOGhxvhIp6Jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782360990; c=relaxed/simple;
	bh=grocmI2oFWlDxunDXYvQW1yYV5SXqYE7Vk24nZuZr2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiiyPJXaYEnKbaGFJIvG8BuYFTeHtWDLShLYyl2vVRs7yopmJTZR4lHU+lesFxtM13aayEb6y+AyM4iD/iPRMI9KZVLa/zsp2dfBqRpTEpROUrZUGPSOWYjXsQG2YWb5rZrZ6BzKagTi1UI4Ir6I/4J2oMmaFv6lo8yIbLsi4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpHe8Xbp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D112E1F000E9;
	Thu, 25 Jun 2026 04:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782360988;
	bh=AiN5oVYDkvToeVAoDXhpX8L4SOwM6hG76+pNbHn5Akw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FpHe8Xbp6Y5I74KzZO+2qeKc73fP1HBUFJJa0yWbRlq5rqQ5FaHySku1wSFlFUASU
	 7Uzhxaxbpiq6I8j1tzpjuZS+vvK2FX2V8VuzCwPdrpabgSo4g8EljSeL3WpVNdwH5i
	 FZDO+1ZhgCkbKTEomAjhYsb47sa/vleBuXCsoIWmp1KeiX5UQQCw6JB/WG1TpoW3t7
	 HHWs4rPIjqIidmejtqa9TH++f0BZz9AuatlL+x+j7QgqLXXurb1tIpAmdAGBsylh/i
	 fYuLgaYUodk/EpOfStrc43GPtbfXPXlCxr+66oGupfIN8kT6nnlH0EO0AkeXrB1Wmt
	 khUS/Ec1AtOPg==
Message-ID: <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
Date: Thu, 25 Jun 2026 13:16:19 +0900
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
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
 <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LxQQ5OPbtD0ywAOp0mjeioxs"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-268256-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bytedance.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D6476C2A85

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LxQQ5OPbtD0ywAOp0mjeioxs
Content-Type: multipart/mixed; boundary="------------06RF0h870Fk6SH6J3RTvV02N";
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
Message-ID: <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
 <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
In-Reply-To: <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>

--------------06RF0h870Fk6SH6J3RTvV02N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/24/26 4:11 PM, Qi Zheng wrote:
> Hi Harry,
>=20
> On 6/24/26 12:29 PM, Harry Yoo wrote:
>> On 6/23/26 6:14 PM, Qi Zheng wrote:
>>> Hi Harry,
>>>
>>> On 6/23/26 4:18 PM, Harry Yoo wrote:
>>>> On 6/23/26 4:16 PM, Qi Zheng wrote:
>>>>> Hi Harry,
>>>>
>>>> Hi Qi!
>>>>
>>>>> On 6/23/26 2:17 PM, Harry Yoo wrote:
>>>>>> On 6/23/26 11:42 AM, Qi Zheng wrote:
>>>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>>
>>>>>>> The mglru page table walker batches per-generation size deltas in=

>>>>>>> walk->nr_pages while walking page tables without holding the lruv=
ec
>>>>>>> lock.
>>>>>>> The reset_batch_size() later folds those deltas into walk->lruvec=

>>>>>>> under
>>>>>>> the lruvec lock.
>>>>>>
>>>>>> Ouch.
>>>>>>
>>>>>> IIRC the user-visible impact of underestimated nr_pages in MGLRU
>>>>>> was premature OOMs because MGLRU does not try to reclaim memory wh=
en
>>>>>> nr_pages reaches zero, but there are still more pages.
>>>>>>
>>>>>> Perhaps worth mentioning in the changelog?
>>>>>
>>>>> Maybe this should be placed before "To fix it...".
>>>>
>>>> Thanks!
>>>>
>>>>>>> The page table walker can run concurrently with the memcg
>>>>>>> reparenting
>>>>>>> path
>>>>>>> as follows:
>>>>>>>
>>>>>>> CPU0                           CPU1
>>>>>>> =3D=3D=3D=3D                           =3D=3D=3D=3D
>>>>>>>
>>>>>>> walk_mm
>>>>>>> --> walk_page_range
>>>>>>>        --> update_batch_size
>>>>>>>            --> walk->nr_pages +=3D delta
>>>>>>>
>>>>>>>                                  mem_cgroup_css_offline
>>>>>>>                                  --> memcg_reparent_objcgs
>>>>>>>                                      --> lock lruvec
>>>>>>>                                          lru_gen_reparent_memcg
>>>>>>>                                          --> reparent child
>>>>>>> folios to
>>>>>>> parent
>>>>>>>                                          unlock lruvec
>>>>>>>
>>>>>>>        lock lruvec
>>>>>>>        reset_batch_size
>>>>>>>        --> child lrugen->nr_pages +=3D delta
>>>>>>
>>>>>> The problem here is that, while grabbing a reference to memcg
>>>>>> (via mem_cgroup_iter(), for example) makes sure that the memcg is =
not
>>>>>> freed, it does not prevent offlining happening, and
>>>>>> reset_batch_size()
>>>>>> doesn't check whether the lruvec has been reparented, or the lruve=
c
>>>>>> is going to be reparented.
>>>>>>
>>>>>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>>>>>
>>>>>>>       VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>>>>>                      sizeof(lruvec->lrugen.nr_pages)));
>>>>>>>
>>>>>>> To fix it, add lrugen->reparented to remember the new owner of a
>>>>>>> reparented lruvec, and make reset_batch_size() charge pending
>>>>>>> deltas to
>>>>>>> that owner.
>>>>>>
>>>>>> Could you please explain why it is unavoidable to introduce the ne=
w
>>>>>> field and why checking whether the cgroup is dying (and charging
>>>>>> deltas
>>>>>> to non-dying parent) doesn't work?
>>>>>
>>>>> Peiyang tried doing this [1], but it doesn't work because
>>>>> ss->css_offline() is called before clearing the CSS_ONLINE flag.
>>>>
>>>> Right.
>>>>
>>>>> I also considered using mem_cgroup_tryget_online(), but that only
>>>>> prevent
>>>>> the memcg from being freed. It's doesn't prevent the offlining.
>>>>
>>>> Right.
>>>>
>>>> I think checking CSS_DYING under RCU and grabbing the lruvec
>>>> of the first non-dying memcg should work (this pattern is already
>>>> used where we use RCU to guarantee memcgs are not freed).
>>>>
>>>> If we do not observe CSS_DYING flag, it is safe to charge deltas
>>>> to the lruvec because RCU guarantees that reparenting cannot happen
>>>> under us.
>>>>
>>>> If we do observe CSS_DYING, we can walk up the hierarchy and charge
>>>> deltas to the first non-dying memcg.
>>>
>>> Checking CSS_DYING looks feasible, but the rcu lock alone cannot prev=
ent
>>> reparenting. We should recheck CSS_DYING after acquiring the lruvec
>>> lock, otherwise we might run into the following race:
>>
>> Haha, actually, I was thinking of checking CSS_DYING under both RCU an=
d
>> lruvec lock. (because that's the pattern)
>>
>>>    CPU0 reset_batch_size              CPU1 memcg teardown
>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>    read !CSS_DYING
>>>
>>>                                       set CSS_DYING
>>
>> Oh, I thought the entire critical section is covered by RCU.
>> (I see lock_batch_lruvec() you suggested below doesn't do that)
>>
>> Isn't RCU enough to prevent reparenting because RCU guarantees that
>> all readers who read !CSS_DYING complete before reparenting?
>=20
> Oh, I think you are right.
>=20
> I forgot that offlining is executed in the rcu work context.

It's confusing :)

> Let's walk through this again:
>=20
> cgroup_destroy_locked
> --> kill_css_sync
>     --> css->flags |=3D CSS_DYING;                    1)
>     kill_css_finish
>     --> css_killed_ref_fn
>         --> css_killed_work_fn  <-- RCU work !!     2)
>             --> offline_css
>                 --> reparent memcg
>=20
> So while holding the rcu lock, if CSS_DYING is not observed,
> css_killed_work_fn() will not be called until rcu_read_unlock().

Right.

> So lock_batch_lruvec() can be implemented like this:
>=20
> #ifdef CONFIG_MEMCG
> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> {
>     struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>     struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>=20
>     rcu_read_lock();
>=20
>     /*
>      * The memcg can be NULL when the memory controller is disabled.
>      * Otherwise, the caller keeps the memcg owning @lruvec alive.
>      */
>     if (!memcg || !css_is_dying(&memcg->css))
>         goto lock;
>=20
>     do {
>         memcg =3D parent_mem_cgroup(memcg);
>     } while (memcg && css_is_dying(&memcg->css));
>     lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>=20
> lock:
>     spin_lock_irq(&lruvec->lru_lock);
>=20
>     return lruvec;
> }
> #else
> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> {
>     lruvec_lock_irq(lruvec);
>=20
>     return lruvec;
> }
> #endif
>=20
> Does this make sense?

Yes, looks good to me!

--=20
Cheers,
Harry / Hyeonggon

--------------06RF0h870Fk6SH6J3RTvV02N--

--------------LxQQ5OPbtD0ywAOp0mjeioxs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajyrkwAKCRCGXBN6rc5S
1oqlAQDfPXFk35QdbxUI3Bm7GIChdTiZa17jWOW965OuLuKNPgEAiwRuBaHrZiUM
mfCqJuZfGYrjhjtTFkDDPZtk9GBpGwg=
=qcnt
-----END PGP SIGNATURE-----

--------------LxQQ5OPbtD0ywAOp0mjeioxs--

