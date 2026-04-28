Return-Path: <stable+bounces-241674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFOGFqXC8GloYQEAu9opvQ
	(envelope-from <stable+bounces-241674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:22:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE023486D81
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4701B320D0BF
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F1436377;
	Tue, 28 Apr 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLvWtj2K"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9A3FB7D3
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384374; cv=none; b=odETkBXFLpUr0fxCDkEeDz4KFOYpjKFe+eyq8i38hZu6ZH6leMXLK9PlVyOM+yOpkWPPb6P/VEKlcm5Pfo8s5s2NNwl+euM7oVU0mcnleWhWZiRo5i2yiCqlVXreQgvJ1ziU9/Rqk97epEr4Mba5JQH8Ti3z9s1JuRMsgaOmNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384374; c=relaxed/simple;
	bh=wkjR01BepCnVnaMjug35GZEThZ0Qh8AtsLMqcKixOwA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=UYV+JF83lmkyydq0wWGjRbR6qjenPaS8XBkWIE6L2OQUdVRvcIdXpg7ndiKTmbOY/hcu0TQJD9xQe4G9w1Gti7u/mV0hbD0wxkguwItOAgvJi0bLfCHM1lWVygiEEbvmlbJmZQwF5MXItibWDd9MI2JQRX5zc3QPH7yHLhihGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLvWtj2K; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777384360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fSaI5CrYdlz9JeGFiodMZfSS16RBwlLh/md29GdDRjs=;
	b=PLvWtj2Ke2MahB3td0bSGKYKjTzfkG+IvdHc1FUgCX5pZrEliuin0HPmkbSev4lLE1xuZ5
	91c8CAMRZ0kVk2DQQYcrCZ6+kVutWaRLe9qP695l/CbKNZBaIi7FtiDooLIuzfl5nTt5wO
	JurL+V4bVaPPf1q+1buipgPYlsOsd5E=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison accounting lookup
Message-Id: <94F5B89A-008A-4EDB-920F-31B4895C2699@linux.dev>
Date: Tue, 28 Apr 2026 21:52:23 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>, Dan Williams <djbw@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rafael J Wysocki <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DE023486D81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bytedance.com,intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,suse.de,linuxfoundation.org,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email,linux.dev:dkim,linux.dev:mid,huawei.com:email]

=EF=BB=BF


> On Apr 28, 2026, at 20:34, Miaohe Lin <linmiaohe@huawei.com> wrote:
> =EF=BB=BFOn 2026/4/28 19:40, Muchun Song wrote:
>>=20
>>=20
>>> On Apr 28, 2026, at 19:37, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>> On 2026/4/28 16:52, Muchun Song wrote:
>>>> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
>>>> find_memory_block_by_id(), which requires device_hotplug_lock to
>>>> serialize the xarray lookup against memory block removal.
>>>> Take device_hotplug_lock around the lookup and nr_hwpoison update so
>>>> the memory block cannot disappear between xa_load() and get_device().
>>>> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison c=
ounter")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Thanks for update.
>>>> ---
>>>> drivers/base/memory.c | 10 ++++++++--
>>>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>>> index 6981b55d582a..f76aee29e9a5 100644
>>>> --- a/drivers/base/memory.c
>>>> +++ b/drivers/base/memory.c
>>>> @@ -1228,23 +1228,29 @@ int walk_dynamic_memory_groups(int nid, walk_me=
mory_groups_func_t func,
>>>> void memblk_nr_poison_inc(unsigned long pfn)
>>>> {
>>>>    const unsigned long block_id =3D pfn_to_block_id(pfn);
>>>> -    struct memory_block *mem =3D find_memory_block_by_id(block_id);
>>>> +    struct memory_block *mem;
>>>> +    lock_device_hotplug();
>>> memblk_nr_poison_inc() and memblk_nr_poison_sub() are both called from m=
emory_failure() context.
>>> I'm afraid if memory_failure() is triggered while lock_device_hotplug is=
 held, it will lead to
>>> deadlock. Or am I miss something?
>>=20
>> I am curious is there any place where memory_failure() is called with hol=
ding lock_device_hotplug?
>=20
> Sorry for dumb scenario, I was a bit too presumptuous. But there might be a=
nother possible deadlock:
>=20
> remove_memory
>  lock_device_hotplug <-- first called here
>  try_remove_memory
>    remove_memory_block_devices
>      num_poisoned_pages_sub

Passing pfn =3D -1 here.

>        memblk_nr_poison_sub
>          lock_device_hotplug <-- deadlock here

No. Can=E2=80=99t reach here. No deadlock.

Thanks.

>=20
> Hope I'm not mistaken again. :)
>=20
> Thank.
> .

