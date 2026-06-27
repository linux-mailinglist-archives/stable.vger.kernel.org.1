Return-Path: <stable+bounces-269324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lTArKmAwP2p9PwkAu9opvQ
	(envelope-from <stable+bounces-269324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 04:07:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696F6D0C5C
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 04:07:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PWoop4Db;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269324-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269324-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7827A301830A
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 02:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C032609E3;
	Sat, 27 Jun 2026 02:07:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362333C2D
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 02:07:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782526044; cv=none; b=qcN80QZg3Qyo03MJZrDk0UfmCR9KRZu4m/AgMV/Wt/7SyKT8IdXPVjQDQJ5IoOgD/ekCpQAxMBHPW7wF1LANn6XLunaQKTks+S2Z7ZsI4b5l0qGCdMWBlAs/C7oo9584Xj+PBRqiFSeSacr9zdXQLVm+tH5JgMFose94KYLgiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782526044; c=relaxed/simple;
	bh=Nia5mSquo5QApccc3grRDb1T8/RN6yVBNcsYMwqpsmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLARrSbgpUjn2upFCzRMPrbl31hOecDR1ZHzvVDLlWPuuy8DlSO5p3d0YpqHr588FK+QGHK1RKp77WZB/l3G000DxmVVCnJwWODWtzXcoIugm216eweMT/FBm2NFzsQiO2avbeP8Rr7QBQ38wcul73ebqePB1roaakXDO5cVDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWoop4Db; arc=none smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so2961750a12.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782526042; x=1783130842; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6iWoHyT3Z02ic2G+1Q8eT2akEj38fCKCoF6qFakARc=;
        b=PWoop4Db9QDc3rIOjk/SuvDgKnvOs8MoVY6vvZM0ppX6LplnY83u5LbXmANA3z6Ke7
         mc6f1QdfnLvzrHsbPg9ts/rwxFx+Isiu3nHbIKOqbTN4B345BpM7hsu43X9eUvlLLftX
         n8SZd8oWoOGpN7NgPSGNUK+fJQoe44DokPk11l8vGg+wwiu4yI1tM5uf/I8MCWHVyMAu
         DO1jjxggYP3EAh6J5WRMmXqjSyN1ZC29t6xkQRAgvndM1ym7XcHoVLfg4bnKmmPSyWyK
         poObKFT+SEmMhU8smYXqRnh4v5kVSVvOstjyN+nbXNethOQ4XwqmFeAVRyYsBshsU5E/
         RZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782526042; x=1783130842;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6iWoHyT3Z02ic2G+1Q8eT2akEj38fCKCoF6qFakARc=;
        b=E6vp44Ckbiwmm+xWnXkx9/vLujJZEJCKnRT9LhTyVvnihN6fnxWC1cdoBYkBmIeF0e
         eBmdLiN+3iQKpS4lHMFw9wVFxXhyqePY0ty1k3xEeSkjyK4eGIkhox1CQKvzmrFgDfZJ
         ogLU/vvzAIjPp1fABvkgDNt/uxL8Wqg58Mk/lr1eK2ZALHn1Uu7pM6SbQVbG0qHh+7RE
         9CCKzDsljMtUgkLNNlNsFbeSlTmEM65kNIi9EDWl/rcwNwaf7UMoajyi2X7UQmcXtf7a
         fHYAflR/JZw+p3WUZRLiuI4Sw/Mln5UUHeYJU6fhkqtee954nT/HuHC9mObl1aZyT0zt
         j95w==
X-Forwarded-Encrypted: i=1; AFNElJ8EMeUi0EY8P2OIZn3oLoQ55v9YLe5BdeO6vQjKlwSWlhrdZVgsa2rc839PfgXQUBfvXVuJmps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQDnAX32J1+ovwfPVqTzgbmKpmSZnwn319G8QvjuS3gk/+Adp
	V1vDXc7xrSQJbf4qzCz+KJ8vXBoG0ATx19isnF5fzvpH+A7/OjaLBY3D
X-Gm-Gg: AfdE7cmCUmy1EcE/GAiRztjXFq6VOl26jlWfWGGmzavLw6UwMIsLXC8Maw0znTsacCu
	IoX2m/ePgfaGvaBPMXmdvn0CxQ69px6ooZJTa2UimvHFmijtTzTKsUxYuVBJrLij+BDgtpqN4AN
	3UZir9+8nEwu+Y5GTaogXI15Tr6DqSOFRQBA/h1i1A/DhdIMjjx8GBBaA1zDp2YLubaYLYjwfn/
	a76jV2nw61V6JtD1QH79YsLZ0whV0Lv+csDEWKAUwHLUK6q7AJbOZwpknehkkGofy+Lw43xI4mJ
	/yaaszrDhaeGYmA4E4Z1nZIscoRxPcHCyRUWlpsRlakMj8TJ/y8/rNaOmyQm+yO/Yc3Yfi/Hfpu
	X7BadEOYRWiLl+4oCcC0ysrIfgVf3Xox1HHBRwccToT9JVAIHJDpUy3PCHeEBdYSiD3qqpCOn+w
	pXePguVa76pao=
X-Received: by 2002:a17:906:e10c:10b0:c12:222a:9864 with SMTP id a640c23a62f3a-c12222aab9emr224537366b.51.1782526041535;
        Fri, 26 Jun 2026 19:07:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1226a58d0dsm163048366b.35.2026.06.26.19.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2026 19:07:20 -0700 (PDT)
Date: Sat, 27 Jun 2026 02:07:19 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <20260627020719.ipzfrlhfbvr6ac35@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269324-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:richard.weiyang@gmail.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:ziy@nvidia.com,m:sj@kernel.org,m:balbirs@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lance.yang@linux.dev,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,master:mid];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,vger.kernel.org,linux.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3696F6D0C5C

On Fri, Jun 26, 2026 at 12:07:56PM +0200, David Hildenbrand (Arm) wrote:
>On 6/24/26 08:53, Wei Yang wrote:
[...]
>
>This is extremely hard to review given the existing crap handling here. I'm
>really sorry, but it makes my head hurt (I'm not kidding :) ).
>
>It's completely unclear why we only have to check for a subset of the cases
>after taking the lock.
>
>Could we simply extend the existing migration pmd handling and leave the
>!pmd_present() case for pmd_none()?
>
>That leaves no question to "which transitions are actually allowed", including
>"could we accidentally assume something is a page table when really it isn't".
>
>
>So what about something like the following?
>
>The "thp_migration_supported()" is not required when checking for
>pmd_is_migration_entry(), as that defaults to "false" when not compiled in.
>
>Untested:
>

Hi David

I did a little adjustment like below. Want to check with you at first.

>
>>From 048ecd33673ec649e168fbbb97749a7c0e344fcd Mon Sep 17 00:00:00 2001
>From: "David Hildenbrand (Arm)" <david@kernel.org>
>Date: Fri, 26 Jun 2026 12:03:40 +0200
>Subject: [PATCH] tmp
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/page_vma_mapped.c | 29 +++++++++++++++++------------
> 1 file changed, 17 insertions(+), 12 deletions(-)
>
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 2ccbabfb2cc17..ed2a23a90e8dd 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -243,21 +243,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 		 */
> 		pmde = pmdp_get_lockless(pvmw->pmd);
>
>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>+		    pmd_is_device_private_entry(pmde)) {
> 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> 			pmde = *pvmw->pmd;
>-			if (!pmd_present(pmde)) {
>+			if (pmd_is_migration_entry(pmde)) {
> 				softleaf_t entry;
>

How about:
				const softleaf_t entry = softleaf_from_pmd(pmde);

>-				if (!thp_migration_supported() ||
>-				    !(pvmw->flags & PVMW_MIGRATION))
>+				if (!(pvmw->flags & PVMW_MIGRATION))
> 					return not_found(pvmw);
> 				entry = softleaf_from_pmd(pmde);

could be removed.

>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+					return not_found(pvmw);
>+				return true;
>+			} else if (pmd_is_device_private_entry(pmde)) {
>+				softleaf_t entry;

The same.

>
>-				if (!softleaf_is_migration(entry) ||
>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>+				if (pvmw->flags & PVMW_MIGRATION)
>+					return not_found(pvmw);
>+				entry = softleaf_from_pmd(pmde);
>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> 					return not_found(pvmw);
> 				return true;
>+			} else if (!pmd_present(pmde) ){
>+				return not_found(pvmw);
> 			}
> 			if (likely(pmd_trans_huge(pmde))) {
> 				if (pvmw->flags & PVMW_MIGRATION)

How about merge this with above? And put at the first case?

Below is what it looks like:

		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
		    pmd_is_device_private_entry(pmde)) {
			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
			pmde = *pvmw->pmd;
			if (likely(pmd_trans_huge(pmde))) {
				if (pvmw->flags & PVMW_MIGRATION)
					return not_found(pvmw);
				if (!check_pmd(pmd_pfn(pmde), pvmw))
					return not_found(pvmw);
				return true;
			} else if (pmd_is_migration_entry(pmde)) {
				const softleaf_t entry = softleaf_from_pmd(pmde);

				if (!(pvmw->flags & PVMW_MIGRATION))
					return not_found(pvmw);
				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
					return not_found(pvmw);
				return true;
			} else if (pmd_is_device_private_entry(pmde)) {
				const softleaf_t entry = softleaf_from_pmd(pmde);

				if (pvmw->flags & PVMW_MIGRATION)
					return not_found(pvmw);
				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
					return not_found(pvmw);
				return true;
			} else if (!pmd_present(pmde)) {
				return not_found(pvmw);
			}
			/* THP pmd was split under us: handle on pte level */
			spin_unlock(pvmw->ptl);
			pvmw->ptl = NULL;
		} else if (!pmd_present(pmde)) {

Test with split_huge_page_test/khugepaged/hmm-test/migration in selftets,
looks good.

-- 
Wei Yang
Help you, Help me

