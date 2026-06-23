Return-Path: <stable+bounces-267989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9onuA5G8OmrjFQgAu9opvQ
	(envelope-from <stable+bounces-267989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 19:04:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4C6B8F26
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 19:04:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=YJN4q9Eg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267989-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267989-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55B29301E18B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1E388890;
	Tue, 23 Jun 2026 17:04:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819138887C;
	Tue, 23 Jun 2026 17:04:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234252; cv=none; b=lTsv0f6q3hD75uRgt4AVBm91mSvp8Iskk9OPi/dkuMKlaxDwS6xScdhGKvf09aV0HSM/t4xhctCTm6hNREvKt6yiNL6BZwc9c+ptwomJtL5lOSz0umQCBvgBMerDKiOHvYYxoO1wIGJaxCjvsU0BRW17Th9x871N3d7UENq8eXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234252; c=relaxed/simple;
	bh=qAUPUko/0eP+0ncRRfo01ze6iPzdwOokxduC/d0OeQ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ncVnuesfnpwWydDJXKg3h/X+ARASSPLqHGgDkAFa9uB4RM8Wg7WE0a2Xw0Kz22RhImAHgUbJOEwnTUHfXCTFIOi7WnzEvCgJ2UdjOpW/WWF7lOuaE7HMyiulnEw1amwo/uZw0UanJ8EtalnNdLRS/g7gjaBT8CDhAxv6K21LhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=YJN4q9Eg; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782234248;
	bh=6FwWUfeDNbrDVJef4pRnO+7OmxGA3ye0UB7FxK8Uml4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YJN4q9Eg6ghoc4x1zlCrrp2xc2ihCAFI7ikXGqZFL3pJaqolwnIqS8P5wHeUucyTy
	 BuwoWd9xLTROkLRgpJwRL7PsC2w23T/oYNCOnHzXcMzV5XK9JrpgG1VaXFHEGHuBfW
	 OzaDIUWTFkpQ2LemoEldP8b4kWNZcqDKEZiV/xEs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glBHX0H9mz110p;
	Tue, 23 Jun 2026 17:04:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glBHW4PlKz10vp;
	Tue, 23 Jun 2026 17:04:07 +0000 (UTC)
Date: Tue, 23 Jun 2026 18:04:07 +0100
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
In-Reply-To: <86qzlxqjf3.wl-maz@kernel.org>
References: <20260623160339.15143-1-include@grrlz.net> <20260623163756.4591-1-include@grrlz.net> <86qzlxqjf3.wl-maz@kernel.org>
Message-ID: <5925B41F-0F57-4BCB-9F93-7600878ECA27@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267989-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DC4C6B8F26

On June 23, 2026 6:02:40 PM GMT+01:00, Marc Zyngier <maz@kernel.org> wrote:
>Bradley,
>
>Just a few things to keep in mind for your next contributions:
>
>- If you are sending more than a single patch, add a cover letter.
>
>- Don't send a v2 in reply to a v1. It messes the threading we are
>  relying on, and makes it hard to ignore replies to an older version.
>  Always send new series standalone.
>
>- Don't immediately send a V2, even if (especially if!) a bot is
>  pestering you. 34 minutes between versions is way too short (at
>  least a few days is the norm).
>
>On Tue, 23 Jun 2026 17:37:55 +0100,
>Bradley Morgan <include@grrlz.net> wrote:
>> 
>> pKVM keeps its own mapping list for stage 2 operations. Its flush path
>> uses that list directly, so it lost the PTE attribute check done by the
>> generic stage 2 walker.
>> 
>> Record whether a mapping is cacheable and skip cache maintenance for
>> mappings that are not cacheable.
>> 
>> Fixes: e912efed485a ("KVM: arm64: Introduce the EL1 pKVM MMU")
>> Cc: stable@vger.kernel.org
>
>What device memory gets mapped in an upstream pKVM guest that would
>require a backport to stable?
>
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>> Changes in v2:
>> - Add patch 2 for the pKVM permission fault mapping cache bug.
>
>This is the sort of information that goes in the cover letter.
>
>> 
>>  arch/arm64/include/asm/kvm_pkvm.h | 1 +
>>  arch/arm64/kvm/pkvm.c             | 8 +++++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/include/asm/kvm_pkvm.h
>b/arch/arm64/include/asm/kvm_pkvm.h
>> index 74fedd9c5ff0..d9dd8239910d 100644
>> --- a/arch/arm64/include/asm/kvm_pkvm.h
>> +++ b/arch/arm64/include/asm/kvm_pkvm.h
>> @@ -196,6 +196,7 @@ struct pkvm_mapping {
>>  	u64 gfn;
>>  	u64 pfn;
>>  	u64 nr_pages;
>> +	bool cacheable;
>
>Errr, no. That's a terrible idea.
>
>This thing is already big enough, let's not add a bool right in the
>middle (use pahole to find out why this is bad). Given that nr_pages
>is for a range, and that the minimum page size uses 12 bits, the
>largest number of pages you can have here is 56-12=48 bit wide. That's
>another 16 bits worth of flags you can use.
>
>Thanks,
>
>	M.
>
>

thanks.

I'll go and do V3 with another sashiko suggestion. I'll fix your path too.
I'll park V3 for a bit.

Thanks!

