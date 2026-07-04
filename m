Return-Path: <stable+bounces-271921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DO0LJFtzSGrLqQAAu9opvQ
	(envelope-from <stable+bounces-271921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:43:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FC706802
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:43:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Z6AXqHVA;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271921-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271921-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B186C301BCCB
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97072D3ED1;
	Sat,  4 Jul 2026 02:43:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F10228CB0
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:43:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783133013; cv=none; b=dU9mmrekOdlugCn3OjDEK7bF/O9PoFe1cGja0dJNCmB+WDvAF5D9yM1wSEWW12gsuIxZAuzTKDXcKnXCuSJ6C2etMDKX7obwA7sBbzRt+NB1b3Xg2Z+qKAUnlEpTzT/HL0T2ANvY7O+kq3lmM7N2L/gHP0qzgbwpJzhvJOtad9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783133013; c=relaxed/simple;
	bh=y/w2//o9tLFu8D1YyHGm3x2nl7TT2wWydLVFSqS1msQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CAn/8xW1KTwJjU0R3n0aXptvjvfVyi8JDXRqA5w1PMH6WNTWwDCxs+DIHjNjA0SMnT7qRl+TvVIubP3wZ1Lk+F95Urbk13neZ/PMXQCaPri/e6XbofkbE/pcLpXDy/RjDkJTThTS3OATdjg6F1vL7iGH26QBwRK/Yb3gbAAC+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6AXqHVA; arc=none smtp.client-ip=95.215.58.179
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783133008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/w2//o9tLFu8D1YyHGm3x2nl7TT2wWydLVFSqS1msQ=;
	b=Z6AXqHVA+9nAVYfSa3QbdfPfvb43qNaCDbGVGpDJitxEZRu/+WHXiZt1uJm2m9gWRYnLBn
	rrMBGuwNRW8WoE+9qA6G/xghPUPVLiysithLQ4EAtBTx6p4nsscEq1kQqKczHWOE40wXsn
	Q29B2m+VxuTz6Z/bm0e5ix4C/1bn3MQ=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 1/6] arm64: make huge_ptep_get handled unaligned
 addresses
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260703114202.365553-2-dev.jain@arm.com>
Date: Sat, 4 Jul 2026 10:42:45 +0800
Cc: osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 david@kernel.org,
 liam@infradead.org,
 riel@surriel.com,
 vbabka@kernel.org,
 harry@kernel.org,
 jannh@google.com,
 lance.yang@linux.dev,
 kas@kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 apopple@nvidia.com,
 rcampbell@nvidia.com,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 gourry@gourry.net,
 ying.huang@linux.alibaba.com,
 ak@linux.intel.com,
 nao.horiguchi@gmail.com,
 mel@csn.ul.ie,
 j-nomura@ce.jp.nec.com,
 pfalcato@suse.de,
 tglx@kernel.org,
 dave.hansen@intel.com,
 jpoimboe@kernel.org,
 catalin.marinas@arm.com,
 will@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <58500686-A4A0-45FD-872D-AB0EE2AD2ACC@linux.dev>
References: <20260703114202.365553-1-dev.jain@arm.com>
 <20260703114202.365553-2-dev.jain@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271921-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,linux.intel.com,csn.ul.ie,ce.jp.nec.com,arm.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:apopple@nvidia.com,m:rcampbell@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:ak@linux.intel.com,m:nao.horiguchi@gmail.com,m:mel@csn.ul.ie,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:tglx@kernel.org,m:dave.hansen@intel.com,m:jpoimboe@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:dev.jain@arm.com,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 244FC706802



> On Jul 3, 2026, at 19:41, Dev Jain <dev.jain@arm.com> wrote:
>=20
> huge_ptep_get() can be handed a virtual address pointing to the middle =
of
> a contpmd/contpte mapped hugetlb folio (examples of callers are
> pagemap_hugetlb_range, page_mapped_in_vma).
>=20
> The arm64 helper rewalks the pgtables in find_num_contig to answer =
whether
> the huge pte we have maps a contpmd or a contpte hugetlb folio, and
> returns CONT_PMDS or CONT_PTES, so that it can collect a/d bits over =
the
> contiguous ptes. We can falsely return CONT_PTES instead of CONT_PMDS
> if the addr is not aligned.
>=20
> Fix this by aligning the pmdp pointer down to a contpmd base before
> checking equality with the passed huge pte pointer, to correctly =
answer
> whether the huge pte is the base of a contpmd block.
>=20
> Fixes: 29cb80519689 ("arm64: hugetlb: Cleanup huge_pte size discovery =
mechanisms")
> Cc: stable@vger.kernel.org
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


