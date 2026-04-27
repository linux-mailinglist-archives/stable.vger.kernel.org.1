Return-Path: <stable+bounces-241258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODMAEl0Y72mB6QAAu9opvQ
	(envelope-from <stable+bounces-241258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:03:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898E46EB72
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6842F3003EB3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616C36403B;
	Mon, 27 Apr 2026 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R9TE17hN"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B662264A7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277016; cv=none; b=Bl1F0luPC9QZ/81Mdbd1A6FgJUb1fku4tZrLDWYbuLSFV5JTi0pNrUhR8nyLwb4FY3icAxQSOnuB0ZkqcZQdMCncOpeDgX8eILcS1e/atNqBIZ6EP2cffGlwOZzBLlCVTP03g/KfUsjnkHZiwg9pmlps+rur4Max1c1w40Ov7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277016; c=relaxed/simple;
	bh=Gi2HbGF+myhiwjyvazdCnmlP6nvM5zc434Fm2MBS8N0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n0tUWJnGOyf0Vzxo7pP6AxIrpqOvLEf8xJvNO1PN7Qme+FSLBnuvZ5YpdHKktld9u7vTkRvobBKjmzBKa4luGvD0Ayv35ZGCH+0gm2lzi/ClrzgJ+3sVG/Iw+Wss+ONyAXlVHhHql7Rsko+NXLpLRoZKScq4/UqmUJ4Ly6TT/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R9TE17hN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777277003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F67ZdaDpjQQ9ZQiBFJStgZjfeCxvByxk+MVNwDskpX0=;
	b=R9TE17hNB3dUDAgpXvp0H2Kc6X2wK1PO3oZsQe0mGQJ1v8l9nixxv+AcfB+GHGRRfmkltS
	UplpfiTNaZMlFiMihyhzhij0rvpjIS4kecGyyczoKq9dreI2THiOh/+zXHbX8lC1fm27ur
	Dgl6SLpGQOKusEhAzJO72dmGcSymILw=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 1/2] mm/memory_hotplug: fix memory block reference leak on
 remove
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ae8U73RyTE2a6bdp@localhost.localdomain>
Date: Mon, 27 Apr 2026 16:02:17 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Dan Williams <djbw@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev>
References: <20260426144447.817722-1-songmuchun@bytedance.com>
 <ae8U73RyTE2a6bdp@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9898E46EB72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241258-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,kernel.org,linux-foundation.org,linuxfoundation.org,gmail.com,intel.com,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,linux.dev:dkim,linux.dev:mid]



> On Apr 27, 2026, at 15:49, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Sun, Apr 26, 2026 at 10:44:46PM +0800, Muchun Song wrote:
>> remove_memory_blocks_and_altmaps() looks up each memory block with
>> find_memory_block(), which acquires a reference to the memory block
>> device.
>>=20
>> That reference is never dropped on this path, resulting in a leaked
>> device reference when removing memory blocks and their altmaps. Drop
>> the reference after retrieving mem->altmap and clearing mem->altmap,
>> before removing the memory block device.
>>=20
>> Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory =
requests across memblocks")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> The change looks good but some comments below:
>=20
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>=20
> The outcome of leaking the reference is that the final call to =
put_device()
> in device_unregister() leaves the memory block device linked in the
> system under /sys/ ? (besides not deleting the struct I guess)

I think so.

>=20
>> ---
>> mm/memory_hotplug.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 2a943ec57c85..4426abb05655 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1422,6 +1422,7 @@ static void =
remove_memory_blocks_and_altmaps(u64 start, u64 size)
>>=20
>> 	altmap =3D mem->altmap;
>> 	mem->altmap =3D NULL;
>> +	put_device(&mem->dev);
>=20
> 1) Six months from now we might not remember why we need to call
>   put_device() here.
>=20
>   I would put a comment like remove_memory_block has:
>=20
>   "/* drop the ref. we got via find_memory_block() */" or something =
like
>   that.

Make sense.

>=20
> 2) I kind of dislike having an internal put_device() lingering here in
>   memory-hotplug code, it feels like it does not really belong here.
>   Ideally we should have a high-level function in =
drivers/base/memory.c
>   that calls put_device itself.
>   Something like "put_memblock_dev", dunno, names are hard.
>=20

I share your perspective. The current naming of find_memory_block_by_id
is ambiguous as it fails to signal the internal 'get' operation. To =
improve
clarity and reduce errors, it should be renamed to =
memory_block_get_by_id.
Pairing this with a new memory_block_put function to wrap put_device
would ensure a more robust and intuitive API.

Thanks.

>=20
> --=20
> Oscar Salvador
> SUSE Labs



