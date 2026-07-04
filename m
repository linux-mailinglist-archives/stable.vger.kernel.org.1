Return-Path: <stable+bounces-271922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RRiNDdhzSGrkqQAAu9opvQ
	(envelope-from <stable+bounces-271922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:45:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA670680D
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:45:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=mswa1nkq;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271922-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271922-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DF053007B1B
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C71A9F9B;
	Sat,  4 Jul 2026 02:45:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE578125AA
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:45:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783133136; cv=none; b=RQsb4/yfoY2+pqo8pvxctTQhKp+jqSLUX0APsvlAANNPV028C/2ylBSnDpiI3QgYxjrw7KnlJ7lTU+sH0E31qD9uMSM5E5lfLLdEf3PcNFJLH4GP0C+MFts1bPrNam4MzcmNtDc3oThUiqstYII2Kox4FKtI+twHzaSr9r8TD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783133136; c=relaxed/simple;
	bh=WqonFV7bjnqVXMcdhLtm8/HTIUbK1zFVwxuknNkA4QU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BCgHp74iQF8fqobpBFM6mzWq55XbRu7yNzmL7suXz3I5b3aGvEXaEtWIOlWignfhnKExAgge0DtzVSRahMJLNc/D0qKcBapTDfnaLZsG2PwoXHahtvFD07w4PDKLtUOh7OZP1Mc6P2SaDyLQZ/ZF2cx5b1JxywuggH9H3dgVPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mswa1nkq; arc=none smtp.client-ip=91.218.175.182
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783133132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqonFV7bjnqVXMcdhLtm8/HTIUbK1zFVwxuknNkA4QU=;
	b=mswa1nkqFQ9QtW9ww/AdCHgZCDLOSfbp5ZssYIQod1f/1WXquwt1AqR9FlNcbAM/qByYWC
	WDeKoy6TZu+m5xdVk3qMyxSAIX//ii+S0Ykra0/6NZBU3aK0O9n0LuIUzYcARqr7E/+b1Y
	xBXBaea+LO3bZ0it+TyRYp/BD2E/NAc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 2/6] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260703114202.365553-3-dev.jain@arm.com>
Date: Sat, 4 Jul 2026 10:44:39 +0800
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
Message-Id: <EF4E3F78-CC4A-45D4-84A8-9F1A16BB752D@linux.dev>
References: <20260703114202.365553-1-dev.jain@arm.com>
 <20260703114202.365553-3-dev.jain@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271922-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19DA670680D



> On Jul 3, 2026, at 19:41, Dev Jain <dev.jain@arm.com> wrote:
>=20
> try_to_unmap_one() handles hugetlb folios when memory failure needs
> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
> case page_vma_mapped_walk() returns the pte pointer to the hugetlb =
folio
> in pvmw.pte, but the code reads it with ptep_get().
>=20
> On arches which provide their own huge_ptep_get() to dereference a =
huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(), =
pte_present()
> etc to misbehave.
>=20
> It is not clear whether this has a trivially visible effect to =
userspace.
>=20
> Just use huge_ptep_get() for dereferencing a huge pte pointer.
>=20
> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use =
page_vma_mapped_walk()")
> Cc: stable@vger.kernel.org
> Reported-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


