Return-Path: <stable+bounces-274129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EGV8Al3LVWrTtQAAu9opvQ
	(envelope-from <stable+bounces-274129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:38:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3275135B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:38:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=dBZA3v7+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274129-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274129-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6DAD300601D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E63403F9;
	Tue, 14 Jul 2026 05:38:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75C33F38B
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 05:38:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007507; cv=none; b=E2ikJ5pYRaH7mCpWcmV7SFX7Y1vhZvvMsH7QhupZGHAXgk0p4504qu0lYOXiVKQeGf8oztYCVmfIIASL41U2kxsPX0EWW0lvfesstO3VW22Gzq4jPQOyZ/tbmnmUOHisaPRUv9X/L0ckmdcaOK6iAtjbOR5EeMTu1Z+NmdD8mys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007507; c=relaxed/simple;
	bh=wsgxB8d0Z97OA5/TGi1FFx1r8lmXJ//VHZT91Rx6Ync=;
	h=References:In-Reply-To:Content-Type:To:Cc:Subject:From:
	 Mime-Version:Date:Message-Id; b=dPm7Jz3H3ezwOAU14n7aC2MFZy0Oqvcv2TE363s/VlmYyzaLanWyhgchHGlfsvmY/JgRZ7Mc+Cq1tJ5w4r15fnLyVCZiQXmocgrqRN566FklyyTaq+ybZa9tTowe+ZG+WWzTGd9IFGzhpJP4MLSrOyzj+KAJkVRfZ2MRwpNuXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dBZA3v7+; arc=none smtp.client-ip=209.127.230.114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784007495; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wsgxB8d0Z97OA5/TGi1FFx1r8lmXJ//VHZT91Rx6Ync=;
 b=dBZA3v7+aGsuoB3duAzisIi3dANAf7WGtd2Z/pLrvkz6tcEVgpLZWpVCPxpx/bBFdOTw0X
 ZaAfV/65CZRIIbRfSgndbycKbL5nGEfIKIa91/ucBFhDXkHco/fCWBf6ZUao2Hrm0Cus3r
 a1O0u4aB0ZFhvaZ3qZhdIHLxcvXtQEvDXLc+FKaVANg3JIBEGq+zfCP7ZYRkD18TksX06/
 re3cvehicW9LOuDmawyor2pWUFAK6aW5HvC6x6nRphrWgEz09K12U//e2qmdAsra3eahXR
 c7wa5sEyOXSLTSbgrALT2d1KXF/6Fg8ox7xXioqxFFeUEHSwANPBMCdj4idAbw==
X-Lms-Return-Path: <lba+16a55cb45+335d26+vger.kernel.org+caixiangfeng@bytedance.com>
References: <20260713171456.300518-1-caixiangfeng@bytedance.com> <20260713171456.300518-3-caixiangfeng@bytedance.com>
	<1C8560A1-1F70-488E-BB62-2407B115F7B5@linux.dev>
In-Reply-To: <1C8560A1-1F70-488E-BB62-2407B115F7B5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Muchun Song" <muchun.song@linux.dev>
Cc: <akpm@linux-foundation.org>, <osalvador@suse.de>, <david@kernel.org>, 
	<richard.weiyang@linux.alibaba.com>, <baoquan.he@linux.dev>, 
	<shuah@kernel.org>, <linux-mm@kvack.org>, 
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/mm: add hugetlb_region_cache_race regression test
From: =?utf-8?q?=E8=94=A1=E7=BF=94=E5=B3=B0?= <caixiangfeng@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 14 Jul 2026 13:38:12 +0800
Message-Id: <bedeaa5bba0bd040e3b7612739f2bb2229e881de.c970df5e.7173.4d68.84c0.4372a6c03178@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274129-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:osalvador@suse.de,m:david@kernel.org,m:richard.weiyang@linux.alibaba.com,m:baoquan.he@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[caixiangfeng@bytedance.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixiangfeng@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFE3275135B

> > On Jul 14, 2026, at 01:14, Xiangfeng Cai <caixiangfeng@bytedance.com> w=
rote:
> >=C2=A0
> > Add a regression test for the list corruption in
> > allocate_file_region_entries() fixed by the previous patch
> > ("mm/hugetlb: fix list corruption in allocate_file_region_entries()").
> >=C2=A0
> > Triggering the bug requires a concurrent reservation operation to drain
> > resv->region_cache while allocate_file_region_entries() has dropped
> > resv->lock for its GFP_KERNEL allocation, forcing its retry loop to run
> > again. =C2=A0As the mmap() and fallocate(PUNCH_HOLE) paths serialise on
> > inode_lock, the cache has to be drained by faults from a separate addre=
ss
> > space. =C2=A0The test forks several processes sharing one hugetlb inode=
 via
> > memfd_create(MFD_HUGETLB); each mmap()s and faults ranges and punches h=
oles
> > to keep the shared resv_map fragmented.
> >=C2=A0
> > Two modes are provided:
> >=C2=A0
> > - default: a safe single-process functional check that exercises the bu=
ggy
> > =C2=A0 line without forcing a second loop iteration; safe on any kernel=
.
> >=C2=A0
> > - --trigger: the concurrent reproducer, which panics a vulnerable
> > =C2=A0 CONFIG_DEBUG_LIST=3Dy kernel and is therefore opt-in. =C2=A0It f=
aults pages in,
> > =C2=A0 so it needs as many free huge pages as the file is large.
> >=C2=A0
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>
>=C2=A0
> It looks like this is a regression test case for a very specific instance=
 of
> list corruption.
>=C2=A0
> In my opinion, selftests should focus more on functional testing with cle=
ar
> expected behaviors and results to users. I don't think it's worth maintai=
ning
> a test case for a minor issue like this, especially since code changes ha=
ppen
> so quickly. Once the code evolves, this specific list corruption might ne=
ver
> occur again, and the function itself could even be deleted during a refac=
tor.
>=C2=A0
> Therefore, I wouldn't recommend adding this as a selftest.

That makes sense to me.=C2=A0 This test is quite specific to the previous i=
nternal
list corruption, so I agree it is probably not a good fit for selftests.
I'll drop it.

Thanks for the review.

Xiangfeng

