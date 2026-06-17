Return-Path: <stable+bounces-266625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uNSwJ0QRMmozuQUAu9opvQ
	(envelope-from <stable+bounces-266625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 05:15:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D62696402
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 05:15:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=RyvrvsqH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266625-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266625-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF37E302EA85
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C530C170;
	Wed, 17 Jun 2026 03:15:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58003016FC
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:15:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666111; cv=none; b=MAZr390liAx33f9w++/ItN7aDj9pQsJm7Z2JePHPS3GOg+NtazX0FjZWfg2v7AftUPE93xpEF0JnWBMhS6BB4bVt7biIR2tfN76lUZaxTBw40uV0A8Yaq67DRXCI/MiS/PwcAvlEsppDHwyIQpFEtaISxrBINOOyHIOC5T0V61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666111; c=relaxed/simple;
	bh=Qk/DM4744K7XBYGNbGM3g85QtFLrnbrVNMpF5F9IuE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMpbTxc5TMCR3xXwIIed4IldBASCWVyhWgd3dezf2JOvOOnlwloeejvlahYw6x1Na5l84+JT2+hNMLlryqNlMAZAAUFpqy8treMMPXJxE8BbeQrQC2wEzFRP/ainnrvzqxo6jLpMxVoeOUewGoF/gWwGMl46Y3O7CZDX5OO2Ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RyvrvsqH; arc=none smtp.client-ip=95.215.58.176
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781666108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYheglZoN7ZQINy1Nkai5yf7WMqEaDWpcm1200AttNM=;
	b=RyvrvsqHUQr2/2WVE1SSai7a83FHouvM1ASy/wdoWScK1x0Ub9zIsGQpopfn4pf36Mxb25
	DnpJnpNqv65Zb0KEYBbk16vQR2SLelhUs2cgnPVUw9x+PvqztbxbbfbOsDMaomrwInQBIw
	TbjerRr9NnM+ci/z211zqm2KqH7jzZY=
From: Lance Yang <lance.yang@linux.dev>
To: balbirs@nvidia.com
Cc: david@kernel.org,
	lance.yang@linux.dev,
	richard.weiyang@gmail.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	ziy@nvidia.com,
	sj@kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Wed, 17 Jun 2026 11:14:54 +0800
Message-Id: <20260617031454.29210-1-lance.yang@linux.dev>
In-Reply-To: <ajIBTyWCLDo9RAHR@parvat>
References: <ajIBTyWCLDo9RAHR@parvat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266625-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,linux-foundation.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,oracle.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:balbirs@nvidia.com,m:david@kernel.org,m:lance.yang@linux.dev,m:richard.weiyang@gmail.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:ziy@nvidia.com,m:sj@kernel.org,m:linux-mm@kvack.org,m:lorenzo.stoakes@oracle.com,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4D62696402


On Wed, Jun 17, 2026 at 12:11:14PM +1000, Balbir Singh wrote:
>On Tue, Jun 16, 2026 at 03:07:53PM +0200, David Hildenbrand (Arm) wrote:
>> On 6/16/26 14:30, Lance Yang wrote:
>> > 
>> > On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>> > [...]
>> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> >> index 2ccbabfb2cc1..21635fab209c 100644
>> >> --- a/mm/page_vma_mapped.c
>> >> +++ b/mm/page_vma_mapped.c
>> >> @@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> >> 		 */
>> >> 		pmde = pmdp_get_lockless(pvmw->pmd);
>> >>
>> >> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>> >> -			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> >> -			pmde = *pvmw->pmd;
>> >> -			if (!pmd_present(pmde)) {
>> >> -				softleaf_t entry;
>> >> -
>> >> -				if (!thp_migration_supported() ||
>> >> -				    !(pvmw->flags & PVMW_MIGRATION))
>> >> -					return not_found(pvmw);
>> >> -				entry = softleaf_from_pmd(pmde);
>> >> -
>> >> -				if (!softleaf_is_migration(entry) ||
>> >> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>> >> -					return not_found(pvmw);
>> >> -				return true;
>> >> -			}
>> >> -			if (likely(pmd_trans_huge(pmde))) {
>> >> -				if (pvmw->flags & PVMW_MIGRATION)
>> >> -					return not_found(pvmw);
>> >> -				if (!check_pmd(pmd_pfn(pmde), pvmw))
>> >> -					return not_found(pvmw);
>> >> -				return true;
>> >> -			}
>> >> -			/* THP pmd was split under us: handle on pte level */
>> >> -			spin_unlock(pvmw->ptl);
>> >> -			pvmw->ptl = NULL;
>> >> -		} else if (!pmd_present(pmde)) {
>> >> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> >> -
>> >> -			if (softleaf_is_device_private(entry)) {
>> >> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> >> -				return true;
>> >> -			}
>> >> +		if (pmd_present(pmde)) {
>> >> +			if (!pmd_leaf(pmde))
>> >> +				goto pte_table;
>> >> +			if (pvmw->flags & PVMW_MIGRATION)
>> >> +				return not_found(pvmw);
>> >> +			if (!check_pmd(pmd_pfn(pmde), pvmw))
>> >> +				return not_found(pvmw);
>> >> +		} else if (pmd_is_migration_entry(pmde)) {
>> >> +			softleaf_t entry = softleaf_from_pmd(pmde);
>> >> +
>> >> +			if (!(pvmw->flags & PVMW_MIGRATION))
>> >> +				return not_found(pvmw);
>> > 
>> > Looked at history a bit, and I wonder if this changed something old
>> > here ...
>> > 
>> > Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
>> > migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
>> > including not_found() cases. So lockless PMD read was just a filter ...
>> > 
>> > With this fix, true case gets final pmd_same() check, but this
>> > not_found() case happens before taking PTL.
>> > 
>> > So a !PVMW_MIGRATION walker could race with someone, e.g.
>> > remove_migration_pmd(): we make the not_found() decision from old PMD
>> > value that still says "migration", while real *pvmw->pmd may already be
>> > present again. We return without ever taking PTL :)
>> > 
>> > Not sure about practical fallout, but should these PMD-level not_found()
>> > cases also take PTL and restart if PMD changed?
>> I was hoping that we could so something similar to the PTE case.
>> 
>> In map_pte(), we check whether the PMD changed, which is slightly different.
>> 
>> The actual check happens in check_pte() after grabbing the PTL.
>> 
>> For the case you describe, map_pte() would find !pte_none(ptent) ...
>> !pte_present(ptent) and !is_migration, and effectively grab the lock and proceed
>> to check_pte().
>> 
>> In check_pte() we re-check under lock indeed.
>>
>
>Thinking of the practical fallout, not finding the PMD for a non
>migration worker should be OK. Is there a case where it's not OK to
>report the old state.

I was thinking the lockless value should only be used as a first filter,
to see whether entry looks worth checking.

PTE side is roughly lockless filter + PTL/check_pte().

PMD true case now gets PTL/pmd_same(), but some PMD not_found() cases
still come straight from lockless "pmde".

That mismatch felt odd to me ...

Cheers, Lance

