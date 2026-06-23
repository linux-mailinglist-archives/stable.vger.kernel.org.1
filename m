Return-Path: <stable+bounces-268016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qRDQIwblOmq9KQgAu9opvQ
	(envelope-from <stable+bounces-268016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:56:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FB6B9CDE
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:56:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=a5e2Xxlx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268016-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268016-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC02A300EA94
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02653955E4;
	Tue, 23 Jun 2026 19:56:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B53955C3;
	Tue, 23 Jun 2026 19:56:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244591; cv=none; b=i3Cf9EiSoEoYNSNrLq96/rOGjCvrrvG9CGAN65zy8JPMIeGojdPQal5vV16Km5tRE3cRlptxKg3WuDrzGllE1DHhK9fLi3cIKb5nUY1ldZ10Zrp2krYEx+2jf+ocGGZvFZAvWW2aHQMsdCQjaq1vC71YiARfJf/CJQqlNwi2zPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244591; c=relaxed/simple;
	bh=vK9oCcG5cTm27IB1LvOBgN6BQWOegBMaomXG0ASyceI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FORgox49Mon1kmgYrKVApeEPbzGbFU9sFJQzXxTfFhXm84Lodkkg/qC/+ZxEJRHJXx5FBtlDOlnyMs8OKnIsZhoRV+93S5He2zHqvp/3eihfiZFc04lFpZW67Uiw6oAR/G4ZR036EX7/MuNYhS/gUIzk7UYB3o641Drso1jPmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=a5e2Xxlx; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782244587;
	bh=RChInjm+nWyVKGXO+685PTvBLIJb+A7HVHd2yzP8uK0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=a5e2Xxlxl5qmkQ5VwXVRiczuK8Gb3nzAFcO4LEOZygqP+qpkAU/d6QumFBVoV5e8/
	 3gZoh2j7ba3FNeEnwBJn421EfXTkB5TKGnVzSi+140d22onj9X5+rN104Y0sSPnTQU
	 BFlIeGt3bWxlybGxvsuI84DgPVIpdcKfzQorP2nc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glG6M10V9z110m;
	Tue, 23 Jun 2026 19:56:27 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glG6L5SR3z10vW;
	Tue, 23 Jun 2026 19:56:26 +0000 (UTC)
Date: Tue, 23 Jun 2026 20:56:27 +0100
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>
CC: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_KVM=3A_arm64=3A_skip_pKVM?=
 =?US-ASCII?Q?_cache_flushes_for_non_cacheable_mappings?=
In-Reply-To: <95A8722F-D486-4030-BA51-9117434C6E63@grrlz.net>
References: <20260623160339.15143-1-include@grrlz.net> <20260623163756.4591-1-include@grrlz.net> <86qzlxqjf3.wl-maz@kernel.org> <5925B41F-0F57-4BCB-9F93-7600878ECA27@grrlz.net> <86pl1hqiwj.wl-maz@kernel.org> <95A8722F-D486-4030-BA51-9117434C6E63@grrlz.net>
Message-ID: <B6379439-829E-403B-845B-2259A28526A5@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268016-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:oupton@kernel.org,m:kvmarm@lists.linux.dev,m:tabba@google.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:qperret@google.com,m:vdonnefort@google.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[grrlz.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF1FB6B9CDE

On June 23, 2026 7:51:05 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
wrote:
>On June 23, 2026 6:13:48 PM GMT+01:00, Marc Zyngier <maz@kernel.org>
>wrote:
>>On Tue, 23 Jun 2026 18:04:07 +0100,
>>Bradley Morgan <include@grrlz.net> wrote:
>>> 
>>> I'll go and do V3 with another sashiko suggestion. I'll fix your path
>>too.
>>
>>Before you do that, please verify that whatever Sashiko spits out
>>makes any sense. I'm not convinced by its reply on v1 at all.
>>
>>	M.
>>
>>
>
>Marc, 
>
>hi, I have verified sashikos concern.
>
>I am out right now. So I will give a very short result.
>
>
>Sashiko is being bit dramatic with the whole "Critical" rating, but it
>is real in another way
>
>
>I'll explain it in the code in about 30-40 mins.
>
>Thanks!


hey, I'm back now. Let me explain

For the dirty logging report, I agree the bot's wording was not the
greatest..


The issue is not best described as a *guaranteed* -ENOMEM guest abort.

The actual failure path seems to be:


user_mem_abort() skips topup_mmu_memcache() for permission faults,
unless dirty logging is active and
kvm_is_write_fault() is true.

For an instruction permission fault, kvm_is_write_fault() is false.

Dirty logging makes kvm_s2_resolve_vma_size() force max_map_size to
PAGE_SIZE.


If the existing stage 2 entry is *still* a PMD, then kvm_s2_fault_map()
has mapping_size == PAGE_SIZE but perm_fault_granule == PMD_SIZE, so
it calls kvm_pgtable_stage2_map() instead of relax_perms().

The generic stage 2 walker then needs a page table page to split the
PMD in stage2_map_walk_leaf().

So the real issue is that this path can enter the split path without
having topped up the memcache. Eager splitting does not make it
impossible....
since it is best effort and the default split chunk size is 0.


About the V3, I won't send the V3 yet. Until more people review / or 
it's been a few days

Thanks!

