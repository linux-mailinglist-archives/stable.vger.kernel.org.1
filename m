Return-Path: <stable+bounces-268205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NjRLK1wWPGrLjggAu9opvQ
	(envelope-from <stable+bounces-268205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 19:39:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A916C0665
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 19:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=ciwM3wOz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268205-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268205-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1C88302D191
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E050B3DD85A;
	Wed, 24 Jun 2026 17:39:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDA3DD52C;
	Wed, 24 Jun 2026 17:39:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322762; cv=none; b=KubtuwOTPewEBWKnmIKgXVUlYFxfPTTj1cHfGWvg48Z1RiBTj6qNcsi4Y6ULvgqpBf9uoIvyPYVxIcM1c8pTLL/WP2qksZR+wBGRkczYQzUQnB1KJGZQ1qoT3bynvlSPmAdA5tdaVtWgpFOQTpi0r8FqqS2gT8gnxPr3sK43U5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322762; c=relaxed/simple;
	bh=D8aUp4dSTtnGkUeXyqOTVQT5OY3uZCW5aN+rjBL9vQI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z8h2EQ+sLf47BJNVIWODUJxj5PMfBFKdiy/6t+wfYEbxsIsDIkrv2d4duiRPmGDV1Fhi2hR4oYZWlr4wKV2A5Q8jQ+E5AtLhFbrJnxwbSVIG9Y9tKHczq3VXjnEqwhskkS4ZpqGSs618y3zKdcICFyVXYLKidggAaTToWUOclpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=ciwM3wOz; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782322757;
	bh=TDjKCkoTg3i3GJZfWXyR5+GUBGu//vlWsGB4F0dmV4Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ciwM3wOzJiNUs9hD46zOJThBt7YPMtL/k/p9dVCqH1KYu7qZoemAdmdruaiiUvu48
	 9o7H9pb8nWu5/BilyRLbEobRRVaHbB+AuVdfAZp6+xmgHDqfqbqHKkHKlPV3Hc359s
	 ydlPyM9DdLtAqKgZhkjV9s/nyFKsqe1Ujx2sjnh0=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glq1d5z0sz10sb;
	Wed, 24 Jun 2026 17:39:17 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glq1d131zz10sH;
	Wed, 24 Jun 2026 17:39:17 +0000 (UTC)
Date: Wed, 24 Jun 2026 18:39:16 +0100
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
CC: Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>, Gavin Shan <gshan@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/3=5D_KVM=3A_arm64=3A_top_up_s?=
 =?US-ASCII?Q?tage_2_memcache_for_dirty_logging_faults?=
In-Reply-To: <20260624160028.15591-4-include@grrlz.net>
References: <20260624160028.15591-1-include@grrlz.net> <20260624160028.15591-4-include@grrlz.net>
Message-ID: <9FCEC7E9-DE50-443F-8E82-9FA22CA15ED6@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	TAGGED_FROM(0.00)[bounces-268205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:oupton@kernel.org,m:tabba@google.com,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:qperret@google.com,m:vdonnefort@google.com,m:gshan@redhat.com,m:alexandru.elisei@arm.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27A916C0665

On June 24, 2026 5:00:28 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
wrote:
>Dirty logging forces new stage 2 mappings down to page size, but
>it does not always remove an existing block mapping before the next
>fault. Eager splitting is best effort and is disabled by default.
>
>A permission fault on such a block can still need a page table page
>to install the smaller mapping. Top up the memcache for any permission
>fault while dirty logging is active, not only for write faults.
>
>The issue was discovered [1] by Sashiko.
>
>Link: https://lore.kernel.org/all/59984F6D-06F2-4302-BDD7-92DF334E8FA0@grrlz.net/T/#t [1]
>
>Fixes: 6f745f1bb5bf ("KVM: arm64: Convert user_mem_abort() to generic page-table API")
>Cc: stable@vger.kernel.org
>Signed-off-by: Bradley Morgan <include@grrlz.net>
>---
> arch/arm64/kvm/mmu.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>index 3f57f6825a33..8911e319e6fa 100644
>--- a/arch/arm64/kvm/mmu.c
>+++ b/arch/arm64/kvm/mmu.c
>@@ -2122,13 +2122,12 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
> 	 * Permission faults just need to update the existing leaf entry,
> 	 * and so normally don't require allocations from the memcache. The
> 	 * only exception to this is when dirty logging is enabled at runtime
>-	 * and a write fault needs to collapse a block entry into a table. With
>-	 * pKVM, they may still need a fresh mapping object if the fault turns
>-	 * page entries into a block entry.
>+	 * and a fault needs to collapse a block entry into a table. With pKVM,
>+	 * they may still need a fresh mapping object if the fault turns page
>+	 * entries into a block entry.
> 	 */
> 	memcache = get_mmu_memcache(s2fd->vcpu);
>-	if (!perm_fault || (memslot_is_logging(s2fd->memslot) &&
>-			    kvm_is_write_fault(s2fd->vcpu))) {
>+	if (!perm_fault || memslot_is_logging(s2fd->memslot)) {
> 		ret = topup_mmu_memcache(s2fd->vcpu, memcache);
> 		if (ret)
> 			return ret;
>

Note: Patch 3 seems to conflict because of patch 2 (the comments)


Oops! :(

V4 (after people have their review go), will contain one commit (patch
3) with the updated comments.

Patch 1 and 2 applies as usual.

Apologies for my messup. 

Thanks!

