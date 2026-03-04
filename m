Return-Path: <stable+bounces-223045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFBgDr8jqGl3ogAAu9opvQ
	(envelope-from <stable+bounces-223045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:21:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00ED1FFA13
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C94AF303A913
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466413A8728;
	Wed,  4 Mar 2026 12:20:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71280371D0C
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626837; cv=none; b=lcZS05IEr8OvSNV7mnoL6HFhPBDYh0gCTIW6jeVGi5vIk7Gx6wImhTLFS2lGVZpkXE5y4KlfHVGQ8HYz1nTju5ecryjwi1eo8u2YDvlH6GZ0EwzaYImY8KopbLF6fci3lQl5ikbKZ3iBkiIEXn+OQUCYAlY09ANFTVoQreOR20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626837; c=relaxed/simple;
	bh=y6It3wozt+z8yCdP2d70R60B6tv7oe3JA3Nql+cq6Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRVeG1lWmuvCrtpXbaAZs2wHltbIwvcJl/F5Vjun6JjF0X1BPK7ENqqfmfpxePEutr3GX/7JX4qQ6ViS3/0VF5fG6v92ko8mGWwlKDYM2euZHpHWW6P7ADPrByisvY6Ca4Ml1U/nUNbbaAdoYD6iuGQl11UL27wZlEAepbJZOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 917B0339;
	Wed,  4 Mar 2026 04:20:28 -0800 (PST)
Received: from [10.57.82.233] (unknown [10.57.82.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F913F836;
	Wed,  4 Mar 2026 04:20:33 -0800 (PST)
Message-ID: <1080db49-2f83-4fec-ba73-94c6b3a8f7fa@arm.com>
Date: Wed, 4 Mar 2026 12:20:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Breno Leitao <leitao@debian.org>,
 stable@vger.kernel.org
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <0a10ea33-937a-4294-b9a1-9323c706434d@arm.com> <aacohVRfAK46lOjo@box>
 <20260303191217.GD972761@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260303191217.GD972761@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B00ED1FFA13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223045-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid]
X-Rspamd-Action: no action

On 03/03/2026 19:12, Jason Gunthorpe wrote:
> On Tue, Mar 03, 2026 at 10:40:00AM -0800, Piotr Jaroszynski wrote:
> 
>>> If my reasoning is correct, then I think arm64 hugetlb has a similar bug; See
>>> __cont_access_flags_changed(), which just checks for any form of dirty. So I
>>> guess hugetlb is buggy in the same way and should be fixed to use this more
>>> stringent approach?
>>
>> Given sw-dirty is managed by sw, is it correct for sw to ever create a
>> PTE that's sw-dirty but not hw-dirty? 

It's possible to have a dirty pte that you subsequently make read-only by
calling pte_wrprotect().

These are the valid states for the bits:

 * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
 *   0      0      |   1           0          0
 *   0      1      |   1           1          0
 *   1      0      |   1           0          1
 *   1      1      |   0           1          x

But I guess only PTE_RDONLY|PTE_WRITE|PTE_DIRTY causes a problem, which can't
happen.


>> If not, then I think it will still
>> work fine for the SMMU case as sw-dirty implies hw-dirty, and if it's
>> missing then we will set both. But for thoroughness it could make sense
>> to be stricter and add some comments there as it does feel a little
>> fragile. I'm very new to this area though so probably best for others to
>> comment and tackle this.
> 
> I also am not so familiar with SW dirty, but the big thing to be
> sensitive to here is that the CPU can get by with setting something as
> RDONLY | DBM and the CPU will flip off RDONLY without issue, so you
> might not notice it.
> 
> But if handle_mm_fault() is called on something RDONLY|DBM it *MUST*
> clear the RDONLY for all CONT entries, or fail the fault. Otherwise
> the SMMU SVA explodes.

Got it.

> 
> However, I agree the __cont_access_flags_changed() looks concerning.
> 
> I spent a few AI $$ to cross check this and it echo's Ryan's concern
> but did not find a specific counter-example where PTE_WRITE |
> PTE_DIRTY | PTE_RDONLY can happen for hugetlb. 

The table I shared above (from pgtable.h) agrees that
PTE_WRITE|PTE_DIRTY|PTE_RDONLY can never happen.

> I don't really trust
> this negative result, so I'm inclined to agree it should be made more
> robust. I like the look of the patch (below) it proposed too.
> 
> AI ramblings:
> PROMPT:
> Review 20260303063751.2531716-1-pjaroszynski@nvidia.com.mbx and focus
> on __cont_access_flags_changed(), huge_ptep_set_access_flags(),
> hugetlb_fault(). Does it have the same issue as this patch is fixing,
> considering the following additional note:
> 
> A big thing to be sensitive to here is that the CPU can get by with
> setting something as RDONLY | DBM and the CPU will flip off RDONLY
> without issue, so you might not notice it.
> 
> But if handle_mm_fault() is called on something RDONLY|DBM it *MUST*
> clear the RDONLY for all CONT entries, or fail the fault.
> ====
> 
> Analysis: Does hugetlb __cont_access_flags_changed() have the same bug as the contpte patch?
> 
> The contpte bug (what the patch fixes)
> 
> The old contpte_ptep_set_access_flags() (contpte.c:614) used ptep_get()
> which gathers AF/dirty from ALL sub-PTEs via OR, then compared the
> gathered result against entry:
> 
>     // OLD (buggy):
>     orig_pte = pte_mknoncont(ptep_get(ptep));   // gathers across all sub-PTEs!
>     if (pte_val(orig_pte) == pte_val(entry))
>         return 0;
> 
> A dirty sibling makes the gathered PTE look already-dirty, even though
> the target sub-PTE still has PTE_RDONLY in hardware. False no-op → SMMU
> infinite fault loop.
> 
> The fix replaces this with contpte_all_subptes_match_access_flags()
> which checks each sub-PTE’s raw bit values
> (PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY).
> 
> The hugetlb code
> 
> __cont_access_flags_changed() (hugetlbpage.c:400-418) does NOT use
> gathering for the no-op check – it reads each sub-PTE individually via
> __ptep_get():
> 
>     for (i = 0; i < ncontig; i++) {
>         pte_t orig_pte = __ptep_get(ptep + i);
>         if (pte_dirty(pte) != pte_dirty(orig_pte))
>             return 1;
>         if (pte_young(pte) != pte_young(orig_pte))
>             return 1;
>     }
> 
> So it does NOT have the exact same gathering-based false no-op bug.
> 
> But it does have a weaker form of the same conceptual problem
> 
> The check uses pte_dirty() which is:
> 
>     #define pte_hw_dirty(pte)  (pte_write(pte) && !pte_rdonly(pte))
>     #define pte_sw_dirty(pte)  (!!(pte_val(pte) & PTE_DIRTY))
>     #define pte_dirty(pte)     (pte_sw_dirty(pte) || pte_hw_dirty(pte))
> 
> It abstracts over HW-dirty and SW-dirty. It does NOT check PTE_RDONLY
> directly.
> 
> If a sub-PTE were in the state PTE_WRITE | PTE_DIRTY | PTE_RDONLY
> (SW-dirty but HW-readonly), then pte_dirty() returns true (via
> sw_dirty), and the check would say “no change needed” – but PTE_RDONLY
> is still set in hardware, which the SMMU would fault on.
> 
> The contpte fix’s contpte_all_subptes_match_access_flags() would catch
> this because it compares the raw PTE_RDONLY bit directly.
> 
> Does PTE_WRITE | PTE_DIRTY | PTE_RDONLY actually occur?
> =======================================================
> 
> Looking at all the arm64 PTE manipulation functions:
> 
> -   pte_mkdirty(): sets PTE_DIRTY AND clears PTE_RDONLY (if writable)
> -   pte_mkwrite_novma(): sets PTE_WRITE, clears PTE_RDONLY if PTE_DIRTY
> -   pte_wrprotect(): saves HW dirty to SW dirty, sets PTE_RDONLY, clears
>     PTE_WRITE
> -   pte_mkclean(): clears PTE_DIRTY, sets PTE_RDONLY
> -   HAFDBS: can only CLEAR PTE_RDONLY, never set it
> 
> None of these create PTE_DIRTY | PTE_WRITE | PTE_RDONLY. The invariant
> holds: for writable pages, PTE_DIRTY => !PTE_RDONLY.
> 
> Tracing the RDONLY|DBM scenario through hugetlb_fault()
> 
> For the specific scenario: all sub-PTEs are PTE_WRITE | PTE_RDONLY
> (RDONLY|DBM, clean writable), and handle_mm_fault() is called:
> 
> 1.  huge_ptep_get() gathers – no dirty siblings, so vmf.orig_pte =
>     PTE_WRITE | PTE_RDONLY | PTE_AF
> 2.  huge_pte_mkdirty() sets PTE_DIRTY, clears PTE_RDONLY
> 3.  entry = PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
> 4.  __cont_access_flags_changed():
>     -   All sub-PTEs: PTE_WRITE | PTE_RDONLY | PTE_AF
>     -   pte_dirty(entry) = true, pte_dirty(sub) = false (RDONLY set, no
>         PTE_DIRTY)
>     -   Mismatch detected -> returns 1 -> BBM proceeds
> 5.  BBM rewrites ALL PTEs with
>     PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
> 6.  RDONLY cleared for all entries. Correct.
> 
> With some siblings HW-dirtied by CPU (e.g., PTE #3 has !PTE_RDONLY):
> 
> 1.  huge_ptep_get() gathers: sees HW-dirty sibling, calls pte_mkdirty()
>     on gathered
> 2.  entry = PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
> 3.  __cont_access_flags_changed():
>     -   PTE #3 (!PTE_RDONLY): pte_dirty() = true -> match
>     -   PTE #0 (PTE_RDONLY): pte_dirty() = false -> mismatch -> returns
>         1
> 4.  BBM proceeds. All PTEs rewritten. Correct.
> 
> With ALL siblings HW-dirtied by CPU:
> 
> 1.  All sub-PTEs: PTE_WRITE | !PTE_RDONLY | PTE_AF (all HW dirty)
> 2.  entry: PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
> 3.  __cont_access_flags_changed(): all pte_dirty() match -> returns 0
>     (no-op)
> 4.  But RDONLY is already clear on all PTEs, so SMMU won’t fault.
>     Correct.
> 
> Conclusion
> ==========
> 
> The hugetlb code does NOT have the same bug in the sense that it doesn’t
> produce false no-ops with current code. The key difference is
> __cont_access_flags_changed() checks each sub-PTE individually, not a
> gathered view.
> 
> However, Ryan Roberts’ observation is valid:
> __cont_access_flags_changed() has a latent weakness. It relies on the
> invariant PTE_DIRTY => !PTE_RDONLY (for writable pages) rather than
> checking PTE_RDONLY directly. If this invariant were ever violated
> (e.g., by a future code change), the no-op check could falsely pass,
> leaving RDONLY set in hardware and causing SMMU fault loops. The contpte
> fix’s approach of checking raw bit values is more robust and should be
> adopted by the hugetlb code as a defense-in-depth measure.
> 
> The recommended fix for hugetlb: replace the pte_dirty()/pte_young()
> checks in __cont_access_flags_changed() with a raw-bitmask comparison
> similar to contpte_all_subptes_match_access_flags(), using the mask
> PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY.
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index a42c05cf564082..34e091b398123e 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -389,28 +389,24 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>  }
>  
>  /*
> - * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
> + * huge_ptep_set_access_flags will update access flags (dirty, accessed)
>   * and write permission.
>   *
> - * For a contiguous huge pte range we need to check whether or not write
> - * permission has to change only on the first pte in the set. Then for
> - * all the contiguous ptes we need to check whether or not there is a
> - * discrepancy between dirty or young.
> + * Check all sub-PTEs' raw access flag bits rather than using the abstracted
> + * pte_dirty()/pte_young() helpers which conflate HW-dirty and SW-dirty.
> + * This ensures PTE_RDONLY is checked directly: a sub-PTE that is SW-dirty
> + * (PTE_DIRTY set) but still has PTE_RDONLY would be missed by pte_dirty()
> + * but will cause an SMMU without HTTU to keep faulting.  The access flag
> + * mask matches the one used by __ptep_set_access_flags().
>   */
>  static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
>  {
> +	const pteval_t access_mask = PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
> +	pteval_t pte_access = pte_val(pte) & access_mask;
>  	int i;
>  
> -	if (pte_write(pte) != pte_write(__ptep_get(ptep)))
> -		return 1;
> -
>  	for (i = 0; i < ncontig; i++) {
> -		pte_t orig_pte = __ptep_get(ptep + i);
> -
> -		if (pte_dirty(pte) != pte_dirty(orig_pte))
> -			return 1;
> -
> -		if (pte_young(pte) != pte_young(orig_pte))
> +		if ((pte_val(__ptep_get(ptep + i)) & access_mask) != pte_access)
>  			return 1;
>  	}

I think, based on all the above, the current version is actually not buggy. But
I'm only willing to go to 95% confidence :)

The change looks reasonable though, if you want to be safe.

Thanks,
Ryan


>  
> 
> Jason


