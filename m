Return-Path: <stable+bounces-254234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKCNC0D/FGp2SAcAu9opvQ
	(envelope-from <stable+bounces-254234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:02:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B205CFA7C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7A1330055C4
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F92DB781;
	Tue, 26 May 2026 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VleIy6jc"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3A2D63F8
	for <stable@vger.kernel.org>; Tue, 26 May 2026 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760952; cv=none; b=BNpJ/sBmw4/cWNXLZdqo9l1W+YzUTOklmJUTaNXIQkS4OmFq/4ZwFtKLHYKEoaWRHfdaZjTYqLWvtJxqMr7vufQgZOpREgiwoQwKBkGlJN0NOzsa6u4+Aiw4ErifXjY+phyN/JOU9HBIQeFRWdWDtfG0tivUtQGGeE1eUjEeQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760952; c=relaxed/simple;
	bh=/dHNtdB6AIwF6xLJL6cSkut9/T8GooCTJc73NmdNRaI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f702eI77IETQQ6h1BSmaI9b0cR61MtSgjVRbCaViBtHtMOVRG1uf7sh3knWG7sjML0Cjo6nH2O7H7CUgaMALY1Pi7U1D9Shx/VNtRgouFoE3snKlaDP2JPrnNkBn1NREjvl33rzMmQg3EBQsxGB2Myx85aoELluTNxHO4Mz6NHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VleIy6jc; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779760947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2l47BrYScQshlVVpnfejRoIHDV7lZjQV6i+sxvNhsb4=;
	b=VleIy6jcOIoP//PzdyTCaRBCUqgKHI1OHcJmPwHohQck4caGTynRXes3PiXueQHwzOpcCM
	IDqKxzFK00oHWhpMek8it8Ea8azPClVinHQ8W7Xz2qzzBUcefDixHbTXBgAa6Vp+82QUby
	u9mG6VYrlxcjS2MCK9SWAEYYI2LUOjM=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] mm/hugetlb_vmemmap: fix incorrect vmemmap restore in
 rollback
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260525144948.15e51eb81151e498cc2af999@linux-foundation.org>
Date: Tue, 26 May 2026 10:01:30 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB43864F-28ED-417F-98AD-D6726FBB067F@linux.dev>
References: <20260525025213.2229628-1-songmuchun@bytedance.com>
 <20260525144948.15e51eb81151e498cc2af999@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254234-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,linux.dev:mid,linux.dev:dkim,bytedance.com:email]
X-Rspamd-Queue-Id: 22B205CFA7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 26, 2026, at 05:49, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Mon, 25 May 2026 10:52:13 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> vmemmap_restore_pte() rebuilds restored vmemmap pages from a
>> tail-page template derived from compound_head(). This is wrong when =
the
>> current PTE already maps a page whose contents are not tail-page
>> metadata.
>>=20
>> In the rollback path of vmemmap_remap_free(), the first restored PTE =
is
>> backed by vmemmap_head and contains head-page metadata. =
Reconstructing
>> that page from a tail-page template overwrites the head-page state =
and
>> corrupts the restored vmemmap page.
>>=20
>> Fix this by copying the full page from the page currently mapped by =
the
>> PTE. Also pass vmemmap_tail to the rollback walk so only PTEs backed =
by
>> the shared tail page are restored, while the head PTE remains mapped =
to
>> vmemmap_head. Add VM_WARN_ON_ONCE() checks for unexpected cases.
>=20
> Queued in mm-hotfixes, thanks.
>=20
>> Fixes: c0b495b91a47 ("mm/hugetlb: refactor code around vmemmap_walk")
>=20
> A "refactoring" patch caused a regression?  Ouch.

Yes.

>=20
> This patch caused Sashiko to identify a possible pre-existing mem
> hotplug race:
> =
https://sashiko.dev/#/patchset/20260525025213.2229628-1-songmuchun@bytedan=
ce.com

I think it is a false positive since hugetlb pages cannot be freed to
buddy allocator, we cannot race with memory hot remove.

Muchun,
Thanks.


