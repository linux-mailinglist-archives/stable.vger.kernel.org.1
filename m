Return-Path: <stable+bounces-244990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dMgRKWfd/2lP/gAAu9opvQ
	(envelope-from <stable+bounces-244990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 03:20:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D7502192
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 03:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789E23020D5F
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3132C1922F5;
	Sun, 10 May 2026 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJiNByA7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7D54768
	for <stable@vger.kernel.org>; Sun, 10 May 2026 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376034; cv=none; b=E6l3UyHn0CMzfWi9qNex0wfRxtbWzOKVSWqdiBU/V3Bk/Dlsj1gcqHdInpBeSj6xeVrBFHJa23Z85/7KdHXe6iSAGV2y7GXlCxqDKb9Q2+XmjstzCO2cZFwQR3N0wlN4/ePMKm7AJBpM5kQEVv9kRWyxBmiNWUQTXZFNRFShxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376034; c=relaxed/simple;
	bh=3kpe19e/LCI6ZhqNQio5TTPduzokaZx44qToJmUrPdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1R5JMqnE/JqF6jLblfV4XfHWhKOoEIgVfaAbWEcrm0NyAgtHJ0RtdfY6KKBrMeW400kNde0pmh1R/C1QlZuvGj5qRFrs4E+EEdnZN5F7qyYpE/AzBfHSYosgWOk4W3pvrBD2REPrJa8FippHa9UGEQQLqqh1wJHee1DMPQ7oss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJiNByA7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9382e59c0eso502965966b.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 18:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376031; x=1778980831; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPeyCSpilgNhYSZ9AJzQNjhonaLltjeBimOAJhldfaA=;
        b=TJiNByA7UaphNOMMOUTNSQ9EhhDEAl7wMReayfQstHaSZzcVecocBtS+yk1BOa98lF
         Rw3IT2wQLckiwPCpMq9gIFkAY5rsS9rkrwT3wchfI7Ok+vMvhp+SYxE9p97gN/q1if6A
         pOvCZ6dVPz0XgbA8I8/KuMqv0D5H9+WYNpXysD5ydbiP90K+csvY82vYs7TtphULdmYr
         j4PORMqLz3OFaXKyzhLHCoAUeDVDRmZoph13O+4qpEuV9JIJYbIILCeFweOAqjhdS6Fv
         ad/b9nst9TGiRisNhcCFH8d0x8sHjEDf4oAfoy/aEG9A7FB6TFCk8ADL5CNsFLcumEJT
         zyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376031; x=1778980831;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPeyCSpilgNhYSZ9AJzQNjhonaLltjeBimOAJhldfaA=;
        b=Dd9B3+MZvUY/57ioAJzx3OqRDvbJuqDtVfQUx9/GjDvMvX5NxpQK+KHBepBwpsoH36
         hUc/EUJAgXuWk4dtHNshRQ72re9DSdi0BpBR19W4Hsu2gFsOxqINEtdh6vefufo+bDyr
         fkw3U/Xz4xigWA9MXdIm1wUutSmB1Wgg0Gh/6gyXqA7AAXWwzLncT2rhIPekD1vL5uSR
         FyFNz+8GmvUrY6SLrjh+7iyXK8sij7ycXDH0WmRh17FjJhMBEwXWXyJ05/GVDR8ZvXTN
         ECJpCKSDlEHGRZmiDjjRicnY6W1Cuh9n1u8xdlesQc9IoJ8Zkeey5VLD/PzlS3oWBk4B
         hxZg==
X-Forwarded-Encrypted: i=1; AFNElJ/kp4OF0bnmSBZ3OV+rbjXZqYuFva+BXpUgg9ywt3ErZbEwa9QbnL6l8CD2Biyfr0iWmH3WII4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5BZl/iQNMGhtb3A7zxcnvcBGUgcuL2hd8BJtsgmr0snLSm1V
	G4M5+dfumizmRehydQ1CqTqyEB1RD6y1dYA4j2/L5thWcHRuq1tZo7p8
X-Gm-Gg: Acq92OG9BcvEPGNp8NcI38aAmVRl6cxoOKeswZ9N2LsCj94oobzlInBsGBzExB7X8kE
	/+hJMFG53HD9WDJxCE0Pes9ENLzQ++h25z76A/idMhvHH+DYNXfk4PHJmo2zyUL+vtIBomxDtb7
	Gvl7ETurMbd6ONFyxLhHooK7/EDH+w7eTE07JACs6bEBF/tqixqju3lPIKQjo+MvRIYHQm8CVLA
	fFwTAo9emjEP1EyYeIPTJ46MhfQohU+qCzcoym9p1qWv/YX/Qz5Gf/JnZTGHzWdG/ylzyXOz3H2
	cFnkGsopB5BqCGl3j8pl8i9YohjdgDyP79zIvpFjgKI2ynMBdre/kZBOw4gBAqjHmJYp+6+QAIu
	cXMxZbvj5xnaARECrHR7TF/423aYc3Gt+PpbrL8bkE2yvZ2NYkmF98FflKdC6WuVKw2zzy2f5r2
	ZQzKXLBbMVcIcT+vi0rZk1JA==
X-Received: by 2002:a17:907:9305:b0:ba7:7f6d:be4a with SMTP id a640c23a62f3a-bc56d132a0amr1076366066b.26.1778376030451;
        Sat, 09 May 2026 18:20:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac02c82a3sm285137566b.13.2026.05.09.18.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 May 2026 18:20:29 -0700 (PDT)
Date: Sun, 10 May 2026 01:20:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260510012027.rez7v33w44rkbtyx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Queue-Id: DB2D7502192
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244990-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,oracle.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 08:48:37AM +1000, Balbir Singh wrote:
>On 5/8/26 11:37, Wei Yang wrote:
>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>> before return the pmd entry:
>> 
>>   * re-validate pmd entry
>>   * check PVMW_MIGRATION
>>   * check_pmd()
>>   * handle on pte level if split under us
>> 
>> But for device-private pmd, we just return after pmd_lock(). This may
>> lead to inproper situation.
>> 
>
>Could you elaborate a more on the improper situation?
>

For example, in remove_migration_pte() page_vma_mapped_walk() may return true
on a device-private entry even it is not a migration entry.

>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>> support device-private entries") by following the same pattern as
>> pmd_trans_huge() and pmd_is_migration_entry().
>> 
>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  mm/page_vma_mapped.c | 34 +++++++++++++++++++++++-----------
>>  1 file changed, 23 insertions(+), 11 deletions(-)
>> 
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index a4d52fdb3056..5d337ea43019 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -269,21 +269,33 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  			spin_unlock(pvmw->ptl);
>>  			pvmw->ptl = NULL;
>>  		} else if (!pmd_present(pmde)) {
>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> +			softleaf_t entry = softleaf_from_pmd(pmde);
>>  
>>  			if (softleaf_is_device_private(entry)) {
>>  				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> -				return true;
>> -			}
>> -
>> -			if ((pvmw->flags & PVMW_SYNC) &&
>> -			    thp_vma_suitable_order(vma, pvmw->address,
>> -						   PMD_ORDER) &&
>> -			    (pvmw->nr_pages >= HPAGE_PMD_NR))
>> -				sync_with_folio_pmd_zap(mm, pvmw->pmd);
>> +				entry = softleaf_from_pmd(*pvmw->pmd);
>> +
>> +				if (softleaf_is_device_private(entry)) {
>
>Do we need to check softleaf_is_device_private() twice, can't we hold the pmd
>lock and check once?
>

We discussed this code on [1], which spot the difference between
device-private pmd and the other two pmd case which re-validation after
pmd_lock().

Do check after pmd_lock() share the same pattern as the other two pmd entry
case. Also lock is heavy, check & lock & re-validate seems more friendly to
system. Otherwise we always need to grab lock.

And David suggest to use softleaf_is_device_private() again, [2]. 

>> +					if (pvmw->flags & PVMW_MIGRATION)
>> +						return not_found(pvmw);
>
>Double check, do we want to skip migration pte's (from remove_migration_pte)
>

Do you mean skip device-private entry?

remove_migration_pte() looks for migration entry, and tries to replace it.

The semantics above is: if it looks for migration entry, return not_found()
for device-private entry. Since device-private entry is not migration entry,
IIUC.

>> +					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +						return not_found(pvmw);
>> +					return true;
>> +				}
>>  
>> -			step_forward(pvmw, PMD_SIZE);
>> -			continue;
>> +				/* THP pmd was split under us: handle on pte level */
>> +				spin_unlock(pvmw->ptl);
>> +				pvmw->ptl = NULL;
>> +			} else {
>> +				if ((pvmw->flags & PVMW_SYNC) &&
>> +				    thp_vma_suitable_order(vma, pvmw->address,
>> +							   PMD_ORDER) &&
>> +				    (pvmw->nr_pages >= HPAGE_PMD_NR))
>> +					sync_with_folio_pmd_zap(mm, pvmw->pmd);
>> +
>> +				step_forward(pvmw, PMD_SIZE);
>> +				continue;
>> +			}
>>  		}
>>  		if (!map_pte(pvmw, &pmde, &ptl)) {
>>  			if (!pvmw->pte)
>
>
>How was this tested? Did you run hmm-tests? Is there a broken user space
>that caught the issue?

I didn't do device-private memory related test.

IIUC, device-private memory is device related. I don't have such devices.
Or we have other workaround to test it? Glad to know if so.

BTW, this fix is from pure code analysis and discussion. Maybe it would be
better to include you in the discussion first, then I could get more
background on it.

>
>Balbir Singh

[1]: https://lore.kernel.org/all/c71930ae-19d9-4b3b-a74d-3de3261c4d43@kernel.org/
[2]: https://lore.kernel.org/all/413feed4-6aab-43d9-b7e5-a9386fa79f4b@kernel.org/


-- 
Wei Yang
Help you, Help me

