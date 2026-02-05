Return-Path: <stable+bounces-214380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1lHTCp8HhGmgxAMAu9opvQ
	(envelope-from <stable+bounces-214380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:59:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74083EE295
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B36300C5BF
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 02:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24852D663D;
	Thu,  5 Feb 2026 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0xSoJst"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C053EBF11
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770260378; cv=none; b=siGNw8X69faTFWpIz7lqjoyWuQ8s8UdHxIW0bGyoIN88gJni0K1m864gBEONO2QReyukg5YYWrZBRbLRJe7QlvgtEM37KEhUgE2djZB4OtVwNPpMOeLfxNaSbLE1KM42j+MJlIi4HUHOAF9vlqqOcdY+fPqvCf3TS8+jUa9nxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770260378; c=relaxed/simple;
	bh=iZYUUpa7tzccYiZoBEm9xJ01bvxfzadGU5IntbSgab0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYwXZTO21Y0NfQId75G1qeyo+iwlmQFTbbPSuN4q8zXEQ1+XYm1imevxONQCcn50vPUf6/tKDtRRrpp67HpBdRQfbFlFzLZl/thscTgXgcKLLEt3G3SM0T7fGRj5NCm6MkG+ANqKQGdCLzLgbreRdHrhgxM5MENg4kdwq2aNYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0xSoJst; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-659428faa2bso826267a12.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 18:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770260376; x=1770865176; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xk0CQGxo+dLLTG7hkwaZpo/ZD3J9X7WGXohQku4MYc=;
        b=Z0xSoJstu0vpGUMFUdzPNh1cAVhWnHVUOtfO1RUVfFCDE97j2/sAMjbUXbkoc7XZmR
         cHs30ukjKqq82d8cTUkyaDgcgqWq99bT80ieP/yZ1KzP2DGknMRlMCRFpHID0ckJ0K3a
         FfI9Tw/MslbU1dGNnGFgDdYmMKJdWv6EXafH4LKovaOyyfZCzN/Tfz9fuu1l2bEsMP7C
         nmFcnRDCWLCreXuoWpZdbcvt+zwRVtPeR4mn24Vmw+SkTkXLyTuqcPuA28I+s8vJ3wVE
         emkKZZw8yDErcxL2lJbAD9lxwlW7DLodW4z6lDdoWcgUB/BZeQaN+QPklmrNRWQ4+Qp0
         7Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770260376; x=1770865176;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Xk0CQGxo+dLLTG7hkwaZpo/ZD3J9X7WGXohQku4MYc=;
        b=hidwfbKOKwn2d8oE9JxXM7YV0CyI4/q/qlQIeCPcmSLTh01En61qr23Hy9yXfxLrs0
         b8zECUrgyOz3migNKC/21rFPqjjJTTAHZJadssr3TqgUTR22iPsPKOmi+go1JeNADarS
         zfjPumfnlWt3Kace5gJvUkk9iWL6/lP1SphgqqsE4UkRPW9IAfL8akwmSG+bhEUYOpj9
         YYUpy+ydpOr4IUcfOdUTtRI663cTa2OXCsSfzWdBtV4U4Hv9IgF07OhYVRfMHrZWSHTO
         xXnCcSh23gaw1VaK7KxxPpIgt/0aFuDcmVXl/7BIwAFeotE2FlW+CJz6XixlnxPbk1mz
         rdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNXyJQ8TcCzE4QOVbrkw4MqCNMIfoedC7tbTEW5fJ39rIwkHWRs14S9h7YD7ZOREh5RntRWRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8MEIA2wWuQUhlj590cm4w4A2T2hHpv9TyAKwM3zLkSwohApP
	UdD0h71ckCAD3qsa5ewS575Wipgt4sXriH7mz7xM7uzdCDi9qI8YIGT+
X-Gm-Gg: AZuq6aIQK34VNKUtdg+ilQCLCppgoyO+oVGBStq/sLyV884d+D8uGLkHXQt1ZjUTWNy
	Zto1s/8Wq6eYh0t4GUWYhZidOvuBI3jSTLUAfGG/qhxAM61cui47wfUlAMw7p4ghrpIjx7Ys+WN
	cBOM7KpRFIFe4GI0SfvucJzVxOL6hRCetnXDCkfPze37VhmLUUI5f2GvlKsvbQTVzbyorY03Ilu
	4dlZT8koXAh/LJC8zPG9ZmjV9fLXNcxMgfzlsosMMVe+zNs623qc0W1vK1U5WyaCN3MwsXNWnF8
	2YiSmYWSfvVrJihg/Z186Yje1dCK+eU+LHjv7AshRJpwnufP2NRfsgTaUzvLZQcPGGIJhvHABah
	eH0kXAGx543UDdEfA+V7pdQUhgrc6l1dGZnw2wruVlWcFzFWsgxSFZjOHbvS9ekLEWb0xsMlDwK
	L84WrjM87pyw==
X-Received: by 2002:a05:6402:1445:b0:64d:2889:cf42 with SMTP id 4fb4d7f45d1cf-65949bb6e2emr2943802a12.2.1770260376191;
        Wed, 04 Feb 2026 18:59:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6594a216abasm1700370a12.19.2026.02.04.18.59.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Feb 2026 18:59:34 -0800 (PST)
Date: Thu, 5 Feb 2026 02:59:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	harry.yoo@oracle.com, jannh@google.com, gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <20260205025933.6fzalv6demj7tpfs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260204004219.6524-1-richard.weiyang@gmail.com>
 <d3f4456d-f2e1-4d8f-aa92-77ccd1606d59@kernel.org>
 <E4DA2E02-DE3B-4D26-A427-5D53FCA36A58@nvidia.com>
 <df86ccfd-68a5-416e-81cc-02858e395b70@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df86ccfd-68a5-416e-81cc-02858e395b70@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214380-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,alibaba.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,linux-foundation.org,oracle.com,surriel.com,suse.cz,google.com,igalia.com,linux.alibaba.com,kvack.org,linux.dev,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.948];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 74083EE295
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:43:42PM +0100, David Hildenbrand (arm) wrote:
>On 2/4/26 21:02, Zi Yan wrote:
>> On 4 Feb 2026, at 14:36, David Hildenbrand (arm) wrote:
>> 
>> > Sorry for the late reply. I saw that I was CCed in v1 but I am only now catching up with mails ... slowly but steadily.
>> > 
>> > > Without the above commit, we can successfully split to order 0.
>> > > With the above commit, the folio is still a large folio.
>> > > 
>> > > The reason is the above commit return false after split pmd
>> > > unconditionally in the first process and break try_to_migrate().
>> > > 
>> > > The tricky thing in above reproduce method is current debugfs interface
>> > > leverage function split_huge_pages_pid(), which will iterate the whole
>> > > pmd range and do folio split on each base page address. This means it
>> > > will try 512 times, and each time split one pmd from pmd mapped to pte
>> > > mapped thp. If there are less than 512 shared mapped process,
>> > > the folio is still split successfully at last. But in real world, we
>> > > usually try it for once.
>> > 
>> > Ah, that explains magic number 513.
>> > 
>> > > 
>> > > This patch fixes this by restart page_vma_mapped_walk() after
>> > > split_huge_pmd_locked(). Because split_huge_pmd_locked() may fall back to
>> > > (freeze = false) if folio_try_share_anon_rmap_pmd() fails and the PMD is
>> > > just split instead of split to migration entry.
>> > 
>> > Right, but folio_try_share_anon_rmap_pmd() should never fail on the folios that have already been shared? (above you write that it is shared with 512 children)
>> > 
>> > The only case where  folio_try_share_anon_rmap_pmd() could fail would be if the folio would not be shared, and there would only be a single PMD then, so there is nothing you can do -> abort.
>> > 
>> > Returning "false" from try_to_migrate_one() is the real issue, as it makes rmap_walk_anon() to just stop -> abort the walk.
>> > 
>> > 
>> > So I suspect v1 was actually sufficient, or what am I missing where the restart would actually be required?
>> 
>> The explanation is not for the shared case mentioned above. It is for unshared
>> folio. If an unshared folio’s PAE cannot be cleared, try_to_migrate_one() return
>> true, indicating a success.

Thanks Zi Yan for the explanation.

>
>Oh. You mean that should be something like
>
>"This patch fixes this by restart page_vma_mapped_walk() after
>split_huge_pmd_locked(). We cannot simply return "true" to fix the problem,
>as that would affect another case:
>split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and leave
>the folio mapped through PTEs; we would return "true" from
>try_to_migrate_one() in that case as well. While that is mostly harmless, we
>could end up walking the rmap, wasting some cycles.".
>

Change log is updated accordingly.

>
>> Yeah, since it is an unshared folio, the return
>> value of try_to_migrate_one() does not matter. This fix makes try_to_migrate_one()
>> return false.
>
>Right, it's not really problematic. We could end up walking the rmap and burn
>some cycles.
>
>> 
>> > 
>> > 
>> > (maybe we should get rid of the usage of booleans here at some point, an enum like abort/continue would have been much clearer)
>> > 
>> > > Restart
>> > > page_vma_mapped_walk() and let try_to_migrate_one() try on each PTE
>> > > again and fail try_to_migrate() early if it fails.
>> > > 
>> > > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> > > Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>> > > Cc: Gavin Guo <gavinguo@igalia.com>
>> > > Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>> > > Cc: Zi Yan <ziy@nvidia.com>
>> > > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> > > Cc: Lance Yang <lance.yang@linux.dev>
>> > > Cc: <stable@vger.kernel.org>
>> > > 
>> > > ---
>> > > v2:
>> > >     * restart page_vma_mapped_walk() after split_huge_pmd_locked()
>> > > ---
>> > >    mm/rmap.c | 11 ++++++++---
>> > >    1 file changed, 8 insertions(+), 3 deletions(-)
>> > > 
>> > > diff --git a/mm/rmap.c b/mm/rmap.c
>> > > index 618df3385c8b..5b853ec8901d 100644
>> > > --- a/mm/rmap.c
>> > > +++ b/mm/rmap.c
>> > > @@ -2446,11 +2446,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>> > >    			__maybe_unused pmd_t pmdval;
>> > >     			if (flags & TTU_SPLIT_HUGE_PMD) {
>> > > +				/*
>> > > +				 * After split_huge_pmd_locked(), restart the
>> > > +				 * walk to detect PageAnonExclusive handling
>> > > +				 * failure in __split_huge_pmd_locked().
>> > > +				 */
>> > >    				split_huge_pmd_locked(vma, pvmw.address,
>> > >    						      pvmw.pmd, true);
>> > > -				ret = false;
>> > > -				page_vma_mapped_walk_done(&pvmw);
>> > > -				break;
>> > > +				flags &= ~TTU_SPLIT_HUGE_PMD;
>> > > +				page_vma_mapped_walk_restart(&pvmw);
>> > > +				continue;
>> > >    			}
>> > 
>> > The change looks more consistent to what we have in try_to_unmap().
>> > 
>> > But the explanation above is not quite right I think. And consequently the comment above as well.
>> > 
>> > PAE being set implies "single PMD" -> unshared.
>> 
>> The commit message might be improved with some additional context. The comment
>> above pairs with the comment in __split_huge_pmd_locked()
>> “In case we cannot clear PageAnonExclusive(), split the PMD
>> only and let try_to_migrate_one() fail later”. What is problem with it?
>
>With your explanation it's much clearer, thanks.
>
>I'd remove some details from the comments about PAE like:
>
>"split_huge_pmd_locked() might leave the folio mapped through PTEs. Retry the
>walk so we can detect this scenario and properly abort the walk."
>

Comment is updated accordingly.

>
>With some clarifications along those lines
>
>Acked-by: David Hildenbrand (arm) <david@kernel.org>
>
>-- 
>Cheers,
>
>David

-- 
Wei Yang
Help you, Help me

