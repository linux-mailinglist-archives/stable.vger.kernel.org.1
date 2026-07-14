Return-Path: <stable+bounces-274116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XzLFNWG1VWpfrwAAu9opvQ
	(envelope-from <stable+bounces-274116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:04:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0B9750BB3
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:04:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Uk1WSl1b;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274116-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274116-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D443027944
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272B2D3A93;
	Tue, 14 Jul 2026 04:04:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC473101B0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:04:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001886; cv=none; b=b5Z8EivtRPC4FWz2x1LYFwaJ/3JdDNMDNNI2y3RqFIK5LhqOlqLa5eeagxTDHwgcbN54XgYd6MT4dwIN3/WCR5QGFFrHQwGypmEwS2mJHWwSXa0RX3by8ZujpqnHc7DFm6F1ObyPjXSZOEtN0TWjUDCGt+A5dSQQEReQCiBJYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001886; c=relaxed/simple;
	bh=AugSZYsFMggDMCIziB5aYKV7JU4P5TZdNwMEd+h310Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aAQ3rYUdz2onXbOEEQddd2TYjGTmtYQzmERkgw8CQHqcFgTLsaSTGmXKXEnMaCD2IhLaJozIE2edg5/bpo2wYlACPvHfrtaollSIKvS8g+IFIWGnE4x5oqDhvZaRzRWI11K3tLNiJuIym4PsQrvki5SMd+tkoa575lI2SVCwTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uk1WSl1b; arc=none smtp.client-ip=95.215.58.181
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784001873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8e5QwFzOEE3DTcxaJFQ4C1se1WuaDb4/2mYW5ZmvOI=;
	b=Uk1WSl1bZgrN/S9B8wc/UXqr44eSqfDcnIkTgpqhfZXIea2daRtcBrV6YEWiD+ncupy3Sy
	P51KVc1qBaBq4zNfWTsAVu0tQ9b4laiIUJnvW20yBO64PFn3kKUqz3R5qvA3N8sUY73GTQ
	EU/RG6SaY++MB26rPfL5CHwVamUlFEk=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 2/2] selftests/mm: add hugetlb_region_cache_race
 regression test
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260713171456.300518-3-caixiangfeng@bytedance.com>
Date: Tue, 14 Jul 2026 12:03:49 +0800
Cc: akpm@linux-foundation.org,
 osalvador@suse.de,
 david@kernel.org,
 richard.weiyang@linux.alibaba.com,
 baoquan.he@linux.dev,
 shuah@kernel.org,
 linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C8560A1-1F70-488E-BB62-2407B115F7B5@linux.dev>
References: <20260713171456.300518-1-caixiangfeng@bytedance.com>
 <20260713171456.300518-3-caixiangfeng@bytedance.com>
To: Xiangfeng Cai <caixiangfeng@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274116-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:osalvador@suse.de,m:david@kernel.org,m:richard.weiyang@linux.alibaba.com,m:baoquan.he@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:caixiangfeng@bytedance.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B0B9750BB3



> On Jul 14, 2026, at 01:14, Xiangfeng Cai <caixiangfeng@bytedance.com> =
wrote:
>=20
> Add a regression test for the list corruption in
> allocate_file_region_entries() fixed by the previous patch
> ("mm/hugetlb: fix list corruption in allocate_file_region_entries()").
>=20
> Triggering the bug requires a concurrent reservation operation to =
drain
> resv->region_cache while allocate_file_region_entries() has dropped
> resv->lock for its GFP_KERNEL allocation, forcing its retry loop to =
run
> again.  As the mmap() and fallocate(PUNCH_HOLE) paths serialise on
> inode_lock, the cache has to be drained by faults from a separate =
address
> space.  The test forks several processes sharing one hugetlb inode via
> memfd_create(MFD_HUGETLB); each mmap()s and faults ranges and punches =
holes
> to keep the shared resv_map fragmented.
>=20
> Two modes are provided:
>=20
> - default: a safe single-process functional check that exercises the =
buggy
>   line without forcing a second loop iteration; safe on any kernel.
>=20
> - --trigger: the concurrent reproducer, which panics a vulnerable
>   CONFIG_DEBUG_LIST=3Dy kernel and is therefore opt-in.  It faults =
pages in,
>   so it needs as many free huge pages as the file is large.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>

It looks like this is a regression test case for a very specific =
instance of
list corruption.

In my opinion, selftests should focus more on functional testing with =
clear
expected behaviors and results to users. I don't think it's worth =
maintaining
a test case for a minor issue like this, especially since code changes =
happen
so quickly. Once the code evolves, this specific list corruption might =
never
occur again, and the function itself could even be deleted during a =
refactor.

Therefore, I wouldn't recommend adding this as a selftest.

Thanks.


