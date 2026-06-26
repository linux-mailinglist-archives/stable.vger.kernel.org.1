Return-Path: <stable+bounces-268718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C0i2EhjzPWpQ9AgAu9opvQ
	(envelope-from <stable+bounces-268718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 05:33:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D005A6C9EEB
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 05:33:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lpdVZb7d;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268718-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268718-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827AF3044F1E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2223507C;
	Fri, 26 Jun 2026 03:33:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17718FC80
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:33:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782444819; cv=none; b=jFC8pwlUIEq/zxRmaZcFx4iSYC/geQmeYMdtZ8S3+S6i/xWXTtE5Hc0PwBlTCSNq6UYUil7RfGjTE/FH1clpahGl3WYjy3Pq7H/U+TcEjfVJSCXvW6WeG8+skZ8XKQai87XWT9ESFxtXawd8eQEkSP+8UMTxA/z4LdEMLn/GLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782444819; c=relaxed/simple;
	bh=0HCGQZ57BsFjU/yjnNeadFJo2JebiPKo37EWE7E6eNU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YM+pSwqagrZb8w6V6y7l6vdxflSBnPYY/cTuCVSot58FAvH4XQu3gqkKSsj0rdX9cpuRe4pc6jX4MQXPtWKgDLAJbZ82GKRF+fgCxGL9GWrhplRF/YlJHIRgvfCr9JQFKUa8ErQl3X+R2BOJ6hU02NY/L98k53nqNHghPqNo3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpdVZb7d; arc=none smtp.client-ip=91.218.175.171
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782444815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HCGQZ57BsFjU/yjnNeadFJo2JebiPKo37EWE7E6eNU=;
	b=lpdVZb7dYZBVQfZG9ALV8QZZPn5pCWrHjojmjbeGjIU4iPSQOMA0ewkkkcghYLsUKx63Fm
	FoGY+IQM4XOitUE4lPfMPkCtzcm8hmMBnJ7uP/l4sNIDU4BIqK3VLTQRPgIQLuwoydkHzj
	J4haBNrsxLdlCOvXEsR5ZnsgyWgo3Nk=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 3/5] mm/migrate: use huge_ptep_get() in
 remove_migration_pte()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260625112955.3254283-4-dev.jain@arm.com>
Date: Fri, 26 Jun 2026 11:32:03 +0800
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
 rcampbell@nvidia.com,
 apopple@nvidia.com,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 gourry@gourry.net,
 ying.huang@linux.alibaba.com,
 mel@csn.ul.ie,
 nao.horiguchi@gmail.com,
 ak@linux.intel.com,
 j-nomura@ce.jp.nec.com,
 pfalcato@suse.de,
 dave.hansen@intel.com,
 tglx@kernel.org,
 jpoimboe@kernel.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E9EBE58-C2D0-44F4-8797-D8077E26AFEC@linux.dev>
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-4-dev.jain@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268718-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:dev.jain@arm.com,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D005A6C9EEB



> On Jun 25, 2026, at 19:29, Dev Jain <dev.jain@arm.com> wrote:
>=20
> remove_migration_pte() converts migration entries back to present PTEs
> after folio migration completes. For hugetlb folios,
> page_vma_mapped_walk() returns the pte pointer to the hugetlb folio in
> pvmw.pte, but the code reads it with ptep_get().
>=20
> On arches which provide their own huge_ptep_get() to dereference a =
huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(),
> pte_present() etc to misbehave.
>=20
> It is not clear whether this has a trivially visible effect to =
userspace.

We are dealing with migration entries here, so the issue mentioned =
shouldn't
be a problem with any of the architectures. Semantically speaking, we =
definitely
should fix this.

>=20
> Use huge_ptep_get() to dereference a huge pte pointer.
>=20
> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks


