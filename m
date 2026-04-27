Return-Path: <stable+bounces-241274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAKUDn8r72n98gAAu9opvQ
	(envelope-from <stable+bounces-241274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:25:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B48846FE00
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D78AD3010682
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3763B2FFE;
	Mon, 27 Apr 2026 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBiq1pXq"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDF372EDD
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281465; cv=none; b=gFb5iVgfZ+a8TIhuIsXWx4HUJWKcosuiNrb6QdA6N4RMCs4Z/4zYpAwzt0EnQh1u6L6N+OoKH7/iyvWuoC9xKu43kNt+P/SaamV1nIQZCzyVD1FhQ2y4RBwl7agTpZN+Jy8Kf7f56WnK6fk1vXDHg1yAd82Sc7m4dZrBcFmOH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281465; c=relaxed/simple;
	bh=5gSyueKrFTodcm2zMQHeQOSRw+ArQETISQSNchRRKKs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CvO3i3kOicsKAdKxs9iIqyq0Q/QLKmcnQfnTNORH2V5AHjKW2hSLcJd0HhIJsm8ypqCmQ7rALUF0UXgtaYmwB18ktEJcVycnUv8Ag0/8KEUO6rhdYGpBQyMAvDpxkwgDRj4eXi9YY0rpKLUcCL/4p32+f0K0V2zixRZekNu/XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBiq1pXq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777281452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORHngxvyZgMWhS/hIL5qRYN26UMVGb5ngq+TKZyDg0M=;
	b=BBiq1pXqeKCV203ZvOj67Z/33UqGDuxwcoU8KXnRwokCLX0JGoGrycz9MVzJYt3sNvUY8w
	UItlOVhAetp7joyoDg60oTEh8L6qIGXkVzKLM50YvpODxYKTt9bRTIav1HhkIRprYXXVqa
	xoUBLaui1da4tTR732wtjHotyKLSyoY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 2/2] drivers/base/memory: fix memory block reference leak
 in poison accounting
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <7fe73023-1fd1-0c10-107e-5c0f47383453@huawei.com>
Date: Mon, 27 Apr 2026 17:16:34 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Dan Williams <djbw@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D07C436E-E6BF-4E6D-9431-48C496E350CE@linux.dev>
References: <20260426144447.817722-1-songmuchun@bytedance.com>
 <20260426144447.817722-2-songmuchun@bytedance.com>
 <7fe73023-1fd1-0c10-107e-5c0f47383453@huawei.com>
To: Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4B48846FE00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241274-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,gmail.com,kernel.org,intel.com,kvack.org,vger.kernel.org,lists.linux.dev,suse.de,linux-foundation.org,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,bytedance.com:email,sashiko.dev:url,linux.dev:dkim,linux.dev:mid]



> On Apr 27, 2026, at 17:13, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> On 2026/4/26 22:44, Muchun Song wrote:
>> memblk_nr_poison_inc() and memblk_nr_poison_sub() look up a memory
>> block via find_memory_block_by_id(), which acquires a reference to =
the
>> memory block device.
>>=20
>> Both helpers use the returned memory block without dropping that
>> reference, leaking the device reference on each successful lookup. =
Drop
>> the reference after updating nr_hwpoison.
>>=20
>> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block =
hwpoison counter")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> This patch looks good to me with one question below:
>=20
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.

>=20
>> ---
>> drivers/base/memory.c | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index f806a683b767..6981b55d582a 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -1230,8 +1230,10 @@ void memblk_nr_poison_inc(unsigned long pfn)
>> const unsigned long block_id =3D pfn_to_block_id(pfn);
>> struct memory_block *mem =3D find_memory_block_by_id(block_id);
>>=20
>> - 	if (mem)
>> + 	if (mem) {
>> 		atomic_long_inc(&mem->nr_hwpoison);
>> + 		put_device(&mem->dev);
>=20
> Comment above find_memory_block_by_id says it's called under =
device_hotplug_lock.
>=20
> /*
> * A reference for the returned memory block device is acquired.
> *
> * Called under device_hotplug_lock.
> */
> struct memory_block *find_memory_block_by_id(unsigned long block_id)
>=20
> But device_hotplug_lock is missing here. Should we add it?

Yes. Otherwise mem can be freed concurrently. sashiko.dev reported
the issue as well.

Thanks.

=
https://sashiko.dev/#/patchset/20260426144447.817722-1-songmuchun%40byteda=
nce.com

>=20
> Thanks.
> .



