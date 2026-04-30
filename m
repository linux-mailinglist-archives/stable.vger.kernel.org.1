Return-Path: <stable+bounces-242048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOMMJ1AM82mSwwEAu9opvQ
	(envelope-from <stable+bounces-242048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:01:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 520DC49F009
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD190300F794
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA14389101;
	Thu, 30 Apr 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqGR0kT8"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC84321457
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536048; cv=none; b=ehBsN6F2Y/3HnfguN1cwKKyqPW7qTCxav7ygJWQ1T6HMKefdl+PcMzURrHaKVeHUSBuJzkDWiA40L/4vRw6W8wqJWSut32Jrjvtvl2q+JQxQe6yd/3ovTAM6oXvH56AQ3C8pKP7EB+Z0yQaGzych+DP9P0MUJQJDAyKrh6mDt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536048; c=relaxed/simple;
	bh=A4A6wwPd/ZSj0TC/HEHCOyDVduWypr9xbHHX7OGSc38=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bPj2jszkfpAXpzoeXJP7+lVctSNVfGwDXVsEBh6Lz1QJ0jewf45LYo/olSiRxHi1M6Xij7cz5+0eiOnvE/YmHBR957+8dq6r3ituc/w6PbCqSNbzPvnX9N4OQgA+RjMFaoUYnQudO6DdDru/8x+iS7IEGv45EZsCYrn8lvVAGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqGR0kT8; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777536043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4A6wwPd/ZSj0TC/HEHCOyDVduWypr9xbHHX7OGSc38=;
	b=cqGR0kT8YoGyTPyfnvPFCbwserdf1FLjN/yQXTPkocffUQHDm3U+VUtUUu2fiuMlqEYSSv
	cnVkEmse2/Cj/svvt+OdUgzyZ8kaVKh+Cohi2PlJ2Dx3BSPWqgqDwaYBpaHZCBSQn4JO8m
	Miq9YpF5ZyjrSAJTnBUrQRHoscQNybo=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <b67ff3f9-8661-45cc-b408-6a7b611d31c1@kernel.org>
Date: Thu, 30 Apr 2026 15:59:33 +0800
Cc: Usama Arif <usama.arif@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Dan Williams <djbw@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rafael J Wysocki <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2C5188E-76BF-444C-BF2D-8BDC1410BC61@linux.dev>
References: <20260429101134.1358607-1-usama.arif@linux.dev>
 <b67ff3f9-8661-45cc-b408-6a7b611d31c1@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 520DC49F009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242048-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[sashiko.dev:query timed out];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,huawei.com,bytedance.com,intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,linuxfoundation.org,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[muchun.song.linux.dev:query timed out,david.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



> On Apr 29, 2026, at 18:44, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/29/26 12:11, Usama Arif wrote:
>> On Wed, 29 Apr 2026 12:18:08 +0800 Muchun Song =
<muchun.song@linux.dev> wrote:
>>=20
>>>=20
>>>=20
>>>>=20
>>>>=20
>>>> lock_device_hotplug is a mutex lock, and we already take other =
mutex locks while
>>>> holding lock_folio in other paths, so I am not sure I see what =
should be special
>>>> in this case.
>>>=20
>>> Hi Oscar and Miaohe,
>>>=20
>>> I saw sashiko's report [1] related to folio lock and =
lock_device_hotplug.
>>> Seems it is possible. You can correct me if I am wrong.
>>>=20
>>> [1] =
https://sashiko.dev/#/patchset/20260428085219.1316047-1-songmuchun%40byted=
ance.com
>>>=20
>>> We could fix this by calling action_result() without holding folio =
lock.
>>> What do you think?
>>>=20
>>=20
>> Hello Muchun,
>>=20
>> You could end up in memblk_nr_poison_sub() while holding hugetlb_lock =
spin lock
>> from get_huge_page_for_hwpoison(), right?
>>=20
>> Lockdep would flag this as sleeping while atomic when acquiring mutex =
I think.
>=20
> Another thought would be, that we always call the inc/sub from memory =
failure
> code while we hold a folio reference and the page is not poisoned yet.
>=20
> That way, memory offlining cannot continue and the memory block cannot =
go away.
>=20
> So we'd let out page reference keep the memory block alive.

It seems unnecessary to hold lock_device_hotplug if the user already =
holds a
refcount on the page. I'd like to drop this patch.

Thanks.

>=20
> --=20
> Cheers,
>=20
> David



