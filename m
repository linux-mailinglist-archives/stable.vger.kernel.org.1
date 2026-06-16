Return-Path: <stable+bounces-263523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NMZ3Bda8MGo6WwUAu9opvQ
	(envelope-from <stable+bounces-263523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:02:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7168B98A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:02:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XdagfdHD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263523-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263523-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83CE8301A50C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590237A498;
	Tue, 16 Jun 2026 03:02:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02C35B654
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:02:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578961; cv=none; b=ifAEDwJPA9jnxkEWhMR2m3cfPwJSwiOcbQASbzWW2eY1NuH2qioEblvME5oslQL4irjppu5dOt79PZQjI5/SGRsCTFLBFfmJujbYQdbHDAm7OfZUZXV9MuCc2ANJCIXAL3vXbeuLMGFJiOQeJb0D+17hJRkfj9tQ3terRii48uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578961; c=relaxed/simple;
	bh=pX3YQIh2irWdgCV26wr/O71UNSQ4BZwWoeNiQi2u/6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7FWEoCUSun4oAThB5JN48zyFYkOTya13zQt9nfDZ6QASlUHPAEeoRY4Zgs9z6x8H9il2DOqRD5SnMXwPukLnj0c9e3oPxnN6KswEp5kD0/+mC/Rr0lBasxi6kyR2iVRyPvg4PfWz2VvU9nLe87NvaqvfvO9bl1Uu8Lnk4rUDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdagfdHD; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5175b6c4e19so41108861cf.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781578959; x=1782183759; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFNqwnkza1PoxaD/AT9BU6IArgU7liUUOXm9vn893kI=;
        b=XdagfdHDrBeNjd+iLGTgxX5l/02fBeeD1gYi6wDW+KSVEc0EEz/EpeiBhrvBy0X/ia
         wxaAOJrkn+X1Cq4ee/MsrQI9GRBMi8w+XI1SMNgCgf8VuU6qVT6uMCluaLju9hhzFWcB
         x5yZUUyxZQZt3nAp3C7eOHbQfRL+RPfLZ6VBrrv5v4HsuZI8EYz6pxi8molyB62sZmLi
         sTAdg5tPIxVMvBvMj+Lg8yuvep5qgm5xUvHr2Emg43LWaoSjutqLye7TAZm2/vCj0jZH
         pQwC04M+4Ml0xfjvqzIZLc+GYq+Xn6POaYc+TnLypJvJJAIB4NHmqUmc0IHE6BHN1v70
         omgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781578959; x=1782183759;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFNqwnkza1PoxaD/AT9BU6IArgU7liUUOXm9vn893kI=;
        b=IpZRAivlMuoD3SwSoaKw5iKG+GcxalYwKHwP87uChx94QFk1aNADpXFDzNerfrwp2E
         B1m/nedmABaLDxDMb8QARjV2aYO4+SvJUGlWKgRABSeYREx8q/iM0yJDAxMN0jMPTh6J
         t7JHzU89GPEecX7EIHiAzN4C7UbnfjbM+5fZDBhOoffkPjV5xiUAWyaJlhO+EtEJdIBT
         B0M2GGHHvPloRF6xiuIs9geL4nwNIFa2yAvLkEYxmRohyj2lplGsaGbD/xSSIdj9stwt
         Jj8TVVYDArxWpzFQRjROqVtx8iksGCH4Ztn6aC5ubSRjUU2UtFSVtkIfAkmBjWZ0Etmv
         KFOA==
X-Forwarded-Encrypted: i=1; AFNElJ9QcScnN2geI3SVYU4lprRAZBIikHELXd38vzUI/MZJI3RR5BDQkvtpQXTM35J2KtVGxTRdk6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0ScXTI3KWYx2yEVp91CGgGT/JoRp/SvwSWu1dzZj0vFjNbDP
	bjZ2+4m/1VHM/SkDBxlpuk+ok0xvPva7eHOr7xChi6LTGfXwiN5/94Yv
X-Gm-Gg: Acq92OE+5zNe/+y7rzZN4PCmomkJfvz3d5NduFKAbFlM7uZhlwzBT8aXl5W2ELSyHVT
	FUaDsWfVQJgAE5/OOewsptITpn9bR2WzuHuXThoH6KbKImf9c6uh2kr3YLcgrPWZaCFeSApsfbY
	mQGvsRJf3wsfjDRhoWtHl+hpOY3IJ9+93fqLcWEx2NlqM9Wiwq7oN5mVuA1oUrYyUpSSrcQ5aMU
	OXjvHzmf5z0XH8ThpSgT7dyRSglfVcVQy0IYS44D2dhMuzlc6g6kUlKl8qIlZyGRBlFsDnUbiGf
	L9N9zH6kBvPDEYeK5e3MI/wMmMiojyUakK9slgvLZOcjcN0sFQ0ayRkamRN/rZDT1F90QlyK9Xf
	lQAfYwfPvgBo2jid+O3A8pvd7cHyRktufYWSYMCnPLz12cWq9PuKbB8O96EWlMx3ETjXw1XlO/L
	MVMMgQ6XMsdlMuLE7SbU9XAA==
X-Received: by 2002:a05:622a:1e8e:b0:50d:9aff:8b43 with SMTP id d75a77b69052e-51953360582mr231759911cf.10.1781578958963;
        Mon, 15 Jun 2026 20:02:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61f596sm127377161cf.3.2026.06.15.20.02.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2026 20:02:38 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:02:37 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, Balbir Singh <balbirs@nvidia.com>,
	akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260616030237.i5azjbfhxppzmkyy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
 <20260512143542.izpp3gu4iqxttw3f@master>
 <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
 <20260612024840.qdw76serbgj67yrv@master>
 <2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:richard.weiyang@gmail.com,m:balbirs@nvidia.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:sj@kernel.org,m:ziy@nvidia.com,m:linux-mm@kvack.org,m:lorenzo.stoakes@oracle.com,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263523-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,master:mid];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,linux-foundation.org,kernel.org,surriel.com,infradead.org,google.com,kvack.org,oracle.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78E7168B98A

On Mon, Jun 15, 2026 at 01:58:15PM +0200, David Hildenbrand (Arm) wrote:
>On 6/12/26 04:48, Wei Yang wrote:
>> On Tue, May 12, 2026 at 08:55:47PM +0200, David Hildenbrand (Arm) wrote:
>>> On 5/12/26 16:35, Wei Yang wrote:
>>>>
>>>> I tried to compress above logic like this, hope it could look cleaner.
>>>>
>>>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>>>> 		unsigned long pfn;
>>>> 		bool is_migration = pmd_is_migration_entry(pmde);
>>>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>>>>
>>>> 		if (is_migration != for_migration)
>>>> 			return not_found(pvmw);
>>>>
>>>> 		if (pmd_trans_huge(pmde))
>>>> 			pfn = pmd_pfn(pmde);
>>>> 		else
>>>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>>>>
>>>> 		if (!check_pmd(pfn, pvmw))
>>>> 			return not_found(pvmw);
>>>> 	} else if (!pmd_present(pmde)) {
>>>
>>> It's more compact, but not necessarily cleaner. In particular, I detest
>>> pmd_trans_huge(), we should phase it out.
>>>
>>> if (pmd_present(pmde) && !pmd_leaf(pmde)) {
>>> 	goto pte_table;
>>> } else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
>>>
>>> ...
>>>
>>> Might work as well. But once we add support for other softleaf types, we'll have
>>> to touch it again. So I'd rather just list what we actually expect.
>>>
>> 
>> Hi, David
>
>Hi,
>
>> 
>> I may not follow you. Just want to confirm whether you prefer this goes as a
>> fix first, or you prefer it goes as what you suggested here as a cleanup?
>
>I guess we should just do it properly when we're touching the code already.

Ok, IIUC, I will prepare the fix as you mentioned above.

>
>Does that answer your question? Will you send a proper patch?
>

Sure.

>-- 
>Cheers,
>
>David

-- 
Wei Yang
Help you, Help me

