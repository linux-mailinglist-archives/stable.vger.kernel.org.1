Return-Path: <stable+bounces-145043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825FABD2AF
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4053AF149
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022A264626;
	Tue, 20 May 2025 09:05:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE420D506;
	Tue, 20 May 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731921; cv=none; b=W4fNhCOpxk/gcEgM+biZegWQp3XZkF+YeMXiu59ImdOPAUkXpOwlL7CmilFhRR1Czj3UzyURAFx2FctZK4CixGOSAc5jGxMu4xTpw4JEhEGG6LGhxqHXqj2lR1eXyLG1mh/Nsq1/BQC1A8N9KmA3AJ+8P9wR9jNOgkztNN1lD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731921; c=relaxed/simple;
	bh=aL3yvECd7eGqBVlLj2Y2fQhEK+PDx4Jt8iJ1yYzU3nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpGM3atA9ReH9hTQbJwduC7Bi93NToZUwWwOvL3i3XoFrBa4Jhn6chWdm2vVgTh0M6guYsXqHlAuuECFFHfdriloHBNShS55hEtgTzGdoIkeiwnufbJNWkg0/U75VNjEqkd7/UFGHwTK6WVEJboTXvskHkZfqIyRua/nuZ0J52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602C3153B;
	Tue, 20 May 2025 02:04:59 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 365303F5A1;
	Tue, 20 May 2025 02:05:08 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: ryan.roberts@arm.com
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	david@redhat.com,
	dev.jain@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	stable@vger.kernel.org,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2] arm64: Restrict pagetable teardown to avoid false warning
Date: Tue, 20 May 2025 14:35:01 +0530
Message-Id: <20250520090501.27273-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <df7eb016-bea4-489d-aecb-1a47eb5e33b2@arm.com>
References: <df7eb016-bea4-489d-aecb-1a47eb5e33b2@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 19/05/2025 13:16, David Hildenbrand wrote:
> On 19.05.25 11:08, Ryan Roberts wrote:
>> On 18/05/2025 10:54, Dev Jain wrote:
>>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>>
>> nit: please use the standard format for describing commits: Commit 9c006972c3fe
>> ("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")
>>
>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>>> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
>>> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
>>> a pmd_present() check in pud_free_pmd_page().
>>>
>>> This problem was found by code inspection.
>>>
>>> This patch is based on 6.15-rc6.
>>
>> nit: please remove this to below the "---", its not part of the commit log.
>>
>>>
>>> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from
>>> pXd_free_pYd_table())
>>>
>>
>> nit: remove empty line; the tags should all be in a single block with no empty
>> lines.
>>
>>> Cc: <stable@vger.kernel.org>
>>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>> v1->v2:
>>>   - Enforce check in caller
>>>
>>>   arch/arm64/mm/mmu.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index ea6695d53fb9..5b1f4cd238ca 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>>       next = addr;
>>>       end = addr + PUD_SIZE;
>>>       do {
>>> -        pmd_free_pte_page(pmdp, next);
>>> +        if (pmd_present(*pmdp))
>>
>> pmd_free_pte_page() is using READ_ONCE() to access the *pmdp to ensure it can't
>> be torn. I suspect we don't technically need that in these functions because
>> there can be no race with a writer.
> 
> Yeah, if there is no proper locking in place the function would already
> seriously mess up (double freeing etc).

Indeed; there is no locking, but this portion of the vmalloc VA space has been
allocated to us exclusively, so we know there can be no one else racing.

> 
>> But the arm64 arch code always uses
>> READ_ONCE() for dereferencing pgtable entries for safely. Perhaps we should be
>> consistent here?
> 
> mm/vmalloc.c:   if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))

Yes, I saw that. I know that we don't technically need READ_ONCE(). I'm just
proposng that for arm64 code we should be consistent with what it already does.
See Commit 20a004e7b017 ("arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing
page tables")

So I'll just use pmdp_get()? (Hopefully my reply comes fine, I am replying
from the terminal)

Thanks,
Ryan

> 
> 
> :)
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


