Return-Path: <stable+bounces-268250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uSRuDm2XPGqqpggAu9opvQ
	(envelope-from <stable+bounces-268250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:50:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C936C276B
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:50:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=DykFukn9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268250-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268250-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FF94300EC9C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF82F691D;
	Thu, 25 Jun 2026 02:50:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47827B340
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 02:50:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355815; cv=none; b=Jbq0MP32BWj9eeCLJrgMFQsouJOTb/4+GpFfaP1M/mhh3aJU+6DCGfziVHLxmI+DTBN108hKYZB+WmCLuT3a5prFN90mBfg+nebWtTAvAUU2ibmOC5Fp7HQjJp3412sjHmy5A5qN9+z2W067jYmS8Ze6WMUn2JVaHWUmdRkmrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355815; c=relaxed/simple;
	bh=+RMxs6WouMV+QBrd2CzDNYOlwIYPMhCQnwNtubPoCSE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h9IJQhESV0RVlwcO7QV2wnwxNedl74FgV45QJhUT4QRQcLjbfYMSPq/owdNzMaSXpqsOMxi6bc0iiXF/m82ZtKUzEH8qvU4JVY3bSJvDn8kY5ffT4pGAhykI+6C+MD448rmoK/qKnL9BBVzAYACJ0BqNntFxfC47mTsujozWHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DykFukn9; arc=none smtp.client-ip=95.215.58.172
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782355811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MicaSn+z48usKhojf8188nP53q3d4Jw8leQ7MwI5jT8=;
	b=DykFukn9zpbYGSheo5bRdVmxZg5okx6GYR+9olh/n0MGcLKMlo1w2+tT5dR5jKAl/98osG
	eWwKJtTqNZ1y2uAoaMa4wSH5P9rgTL7DrF/FKxA8rO3Aaut7L5qPOpDthT6+Jw+W+K/KJG
	cQOX0XMTR3IgF0mOtkB0hrdHkiAg/TI=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: + mm-hugetlb-init-tails-before-init_migratetype.patch added to
 mm-hotfixes-unstable branch
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260625005458.9F75F1F000E9@smtp.kernel.org>
Date: Thu, 25 Jun 2026 10:49:25 +0800
Cc: mm-commits@vger.kernel.org,
 vbabka@kernel.org,
 stable@vger.kernel.org,
 osalvador@suse.de,
 kas@kernel.org,
 david@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6C55A66-5225-4C1C-9E4C-988EEAA960D0@linux.dev>
References: <20260625005458.9F75F1F000E9@smtp.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 mclapinski@google.com
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268250-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:stable@vger.kernel.org,m:osalvador@suse.de,m:kas@kernel.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:mclapinski@google.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0C936C276B



> On Jun 25, 2026, at 08:54, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
>=20
> The patch titled
>     Subject: mm/hugetlb: init tails before init_migratetype
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename =
is
>     mm-hugetlb-init-tails-before-init_migratetype.patch
>=20
> This patch will shortly appear at
>     =
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patch=
es/mm-hugetlb-init-tails-before-init_migratetype.patch
>=20
> This patch will later appear in the mm-hotfixes-unstable branch at
>    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>=20
> Before you just go and hit "reply", please:
>   a) Consider who else should be cc'ed
>   b) Prefer to cc a suitable mailing list as well
>   c) Ideally: find the original patch on the mailing list and do a
>      reply-to-all to that, adding suitable additional cc's
>=20
> *** Remember to use Documentation/process/submit-checklist.rst when =
testing your code ***
>=20
> The -mm tree is included into linux-next via various
> branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there most days
>=20
> ------------------------------------------------------
> From: Michal Clapinski <mclapinski@google.com>
> Subject: mm/hugetlb: init tails before init_migratetype
> Date: Mon, 22 Jun 2026 12:19:01 +0200
>=20
> Currently, if you enable HVO, DEFERRED_STRUCT_PAGE_INIT and VM_DEBUG =
the
> kernel will crash with the following stack trace
>=20
> get_pfnblock_bitmap_bitidx
> __set_pfnblock_flags_mask
> hugetlb_bootmem_init_migratetype
> prep_and_add_bootmem_folios
> gather_bootmem_prealloc_node
> gather_bootmem_prealloc_parallel
> padata_do_multithreaded
> gather_bootmem_prealloc
> hugetlb_init
>=20
> on this code
>=20
> VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
>=20
> This code looks inside the struct page which will be uninitialized
> for hugetlb tail pages, which will cause a false positive.
>=20
> So let's initialize the tail pages before this happens.
>=20
> Link: =
https://lore.kernel.org/20260622101901.223961-1-mclapinski@google.com
> Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Michal Clapinski <mclapinski@google.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Hi Andrew,

Just a quick heads-up =E2=80=94 this bug was actually already fixed in =
my patch #1 of
patchset [1]. Since both patches address the same issue, I'd suggest =
picking
mine to avoid unnecessary merge conflicts when the rest of my series =
gets applied.

Thanks to Michal for also taking a look at this =E2=80=94 always good to =
have extra eyes
on the same problem.

[1] =
https://lore.kernel.org/linux-mm/20260612035903.2468601-2-songmuchun@byted=
ance.com/

Muchun,
Thanks.


