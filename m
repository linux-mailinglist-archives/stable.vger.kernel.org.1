Return-Path: <stable+bounces-212977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eeKzEfy1fmlydAIAu9opvQ
	(envelope-from <stable+bounces-212977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 03:10:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB0C49E4
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 03:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7F413006020
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 02:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E11CAA7D;
	Sun,  1 Feb 2026 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSX18CEz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD813D539
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769911796; cv=none; b=GpGbRJiZZ2YAcxcgQEGFT2As0YBm6JWL2iSjAhEtXgXHMuJOrodLz/tupeAjcvfT6XxnJTTd+Mx5T6EIxXiu2LDcFZhWZaM4DC18RDPV6GR7HpE3DGzYAcaxr6ut9okClOeeecSQrZ+p+Cw1/d8czedYQBSRTUJKklUpvVBnTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769911796; c=relaxed/simple;
	bh=PonQxHx1L/gi8nvyVpv78CzFGvgyWGE4uVhJbKpim5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al1gKpFSshG/Io/c9+xDVMGSMg9G9dCmpho3bYCJgVJZCdR7B4znC9q8TAHzDkDMC2RY7EJhis5bKq66KgQ6dP5g7fle52p5ZgYlurQSRC/esF8XzrjG6u6BQmTowdAhceSByok64/1ZF/nC8VH1DSsR1rRypf7f4ul2nbJ9utA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSX18CEz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8837152db5so528140566b.0
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 18:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769911793; x=1770516593; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH9+VhZi02lAA39xreUK3oU8BE/RF3ammaD/BPdU02Y=;
        b=CSX18CEzLR1FzQprLmZ8jfUNOfK1ndVp+5dHaCmmhUoz0LrkFdJ6qE51IYQBHdJo0b
         Bg38V7gayLH0M/1TP1MaKhTKycLcYVNpTLbZoD5lFl3D7WVpQJFGQCaVjJTOY66lWB8D
         YZktMSp9Ve2IHzyYCTAgwlROsX71gZTrdl2r+M2XZmjMo+/95aFufb78/9mHDz6/Bcd9
         GrwJzP8k+d+sjTheIVzlB6Lgzry0OqPN1O/oiK6Gbj+YcZaKFMIncpQp6WTkA52pQAiJ
         33zbz6a9qK8TfFOdsbHjWVkcZkXkuqPqTpe7Cj+93dKOzAetQFx2YM7zOcw2btSUfC+d
         LAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769911793; x=1770516593;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH9+VhZi02lAA39xreUK3oU8BE/RF3ammaD/BPdU02Y=;
        b=WoxEIqXtSVTSlr9NgbifEdR5fvZeQj1C7lrTm9wWj/izgEs87uwQOrKfN9pHLL6kaO
         d+uVs3ttA4vOBDKzkl+THaww0z8K7O484zmAwpx1o36w+5V2iFmo/QTN3+84RmWHO09q
         BaCwWZLJFSYZcjbRlnw3Xn4d3Tz8W3YXfxXdHhN5zMTYz6JqeVjl5JlEwWYnkns0BsBX
         +AyaWv058EjCJHcznPKEyoc0Cq4E5aPOCc/yDWWbZtRg/ZPCm+zI+wgZF/Ju/TpRg/GX
         FAkRJn4SVA1vA3MvHKPhE66N0UJ52lM/C0dDRsINGr5qYNuqq9QilDrrShBaLpSYu8VP
         4Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCVjgf5PaNt6equJ56uJtZrDrNer+WveJi9B+AbIImt/RqYYc6hlyYFO7iHr1HI+6jMln3DyESk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Wy4lnN+ZcFcoeTx5KgfwPMy49Im4xxh1B6Dzw5rgYQHHOQuB
	6CkowoqB0S3GZZHqPRAebT+sslS6O/v608KH+sxvWatBcS5aYHU2SzOr
X-Gm-Gg: AZuq6aI6fDUY07UqnjwxocyLnGc9iLV/Bv2jtPU+JhxPL11ZIqyh7tIhx8RWJnqW82Z
	l2JtFATIp11KBZKYZdegpisrnM3uD0GWrmyVhVfmB4scb0yU/aY3gG2s5TL9E5P/ubVxvc0whc4
	GS1AgNfcPdO3b8IPNPpkmoXcfVimyVQftrbJ0rPfDuzv011F5M3Pp3NhThD0WTv98ROOp3+jsiw
	c3z8cCXf57/vNMBWGreDaSd0jsQ5xLvsDpI3wnserA0RrdrQ3cW3q501srtiWpZnGuivgXRvtPo
	KlsEw2Sv0CWAEG/YoFQQlKvrRYQKnh6HJbvpUu/cN9LXZ/TzogCZYSBxqck+DDGwu8UpXLbHukx
	ig+Q0ZaeaR6kJsFkcSpNG96RKeHxmo2AQSbixkuc5ToAFn3kJB+BxP8JHFGiNW8dq+rpckCe0O5
	HyETb59FlpVw==
X-Received: by 2002:a17:907:968c:b0:b7a:1be1:983 with SMTP id a640c23a62f3a-b8dff8071femr411615266b.63.1769911792464;
        Sat, 31 Jan 2026 18:09:52 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8df8465cb5sm388178666b.40.2026.01.31.18.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Jan 2026 18:09:51 -0800 (PST)
Date: Sun, 1 Feb 2026 02:09:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
	jannh@google.com, gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Message-ID: <20260201020950.p6aygkkiy4hxbi5r@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-212977-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,igalia.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,oracle.com,surriel.com,suse.cz,google.com,igalia.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 54CB0C49E4
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>On 30 Jan 2026, at 18:00, Wei Yang wrote:
>
>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>> split_huge_pmd_locked()") return false unconditionally after
>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>> shared thp. This will lead to unexpected folio split failure.
>>
>> One way to reproduce:
>>
>>     Create an anonymous thp range and fork 512 children, so we have a
>>     thp shared mapped in 513 processes. Then trigger folio split with
>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>     order 0.
>>
>> Without the above commit, we can successfully split to order 0.
>> With the above commit, the folio is still a large folio.
>>
>> The reason is the above commit return false after split pmd
>> unconditionally in the first process and break try_to_migrate().
>
>The reasoning looks good to me.
>
>>
>> The tricky thing in above reproduce method is current debugfs interface
>> leverage function split_huge_pages_pid(), which will iterate the whole
>> pmd range and do folio split on each base page address. This means it
>> will try 512 times, and each time split one pmd from pmd mapped to pte
>> mapped thp. If there are less than 512 shared mapped process,
>> the folio is still split successfully at last. But in real world, we
>> usually try it for once.
>>
>> This patch fixes this by removing the unconditional false return after
>> split_huge_pmd_locked(). Later, we may introduce a true fail early if
>> split_huge_pmd_locked() does fail.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>> Cc: Gavin Guo <gavinguo@igalia.com>
>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  mm/rmap.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 618df3385c8b..eed971568d65 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>>  				split_huge_pmd_locked(vma, pvmw.address,
>>  						      pvmw.pmd, true);
>> -				ret = false;
>>  				page_vma_mapped_walk_done(&pvmw);
>>  				break;
>>  			}
>
>How about the patch below? It matches the pattern of set_pmd_migration_entry() below.
>Basically, continue if the operation is successful, break otherwise.
>
>diff --git a/mm/rmap.c b/mm/rmap.c
>index 618df3385c8b..83cc9d98533e 100644
>--- a/mm/rmap.c
>+++ b/mm/rmap.c
>@@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
> 			if (flags & TTU_SPLIT_HUGE_PMD) {
> 				split_huge_pmd_locked(vma, pvmw.address,
> 						      pvmw.pmd, true);
>-				ret = false;
>-				page_vma_mapped_walk_done(&pvmw);
>-				break;
>+				continue;
> 			}

Per my understanding if @freeze is trur, split_huge_pmd_locked() may "fail" as
the comment says:

		 * Without "freeze", we'll simply split the PMD, propagating the
		 * PageAnonExclusive() flag for each PTE by setting it for
		 * each subpage -- no need to (temporarily) clear.
		 *
		 * With "freeze" we want to replace mapped pages by
		 * migration entries right away. This is only possible if we
		 * managed to clear PageAnonExclusive() -- see
		 * set_pmd_migration_entry().
		 *
		 * In case we cannot clear PageAnonExclusive(), split the PMD
		 * only and let try_to_migrate_one() fail later.

While currently we don't return the status of split_huge_pmd_locked() to
indicate whether it does replaced PMD with migration entries successfully. So
we are not sure this operation succeed.

Another difference from set_pmd_migration_entry() is split_huge_pmd_locked()
would change the page table from PMD mapped to PTE mapped.
page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw->pte), but I
am not sure this is what we expected. For example, in try_to_unmap_one(), we
use page_vma_mapped_walk_restart() after pmd splitted.

So I prefer just remove the "ret = false" for a fix. Not sure this is
reasonable to you.

I am thinking two things after this fix:

  * add one similar test in selftests
  * let split_huge_pmd_locked() return value to indicate freeze is degrade to
    !freeze, and fail early on try_to_migrate() like the thp migration branch

Look forward your opinion on whether it worth to do it.

> #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> 			pmdval = pmdp_get(pvmw.pmd);
>
>
>
>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

