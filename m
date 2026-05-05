Return-Path: <stable+bounces-244076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJr8C+bJ+WmgEAMAu9opvQ
	(envelope-from <stable+bounces-244076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:43:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867944CBB1F
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27C613117BA4
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BEF42B73A;
	Tue,  5 May 2026 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkUioSuA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DEC428467
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976091; cv=none; b=lqNF3BdHeubKv1RSYknc99ZyYksrPGXqqrfSo3IuITwtoATO1Vd4k8kOc1D2L/71Aap446R2slGyqbU5gq6ZLFEBcIyEwspaezEd6JH8Ch7O8j+RD1mV9P+sxY0WNAQzRGTVf7g57HffABpAb2hhY51o/e39fzl5VNFC7+Yebxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976091; c=relaxed/simple;
	bh=xqux/Fd5buH+CzIcqbYSn/lGJjrhMtUoi6ppmBWbEJw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rPJ73RDIIZBeSn6ujd3nCsPHNuZLh5OJtonnXbIrklMCNSM8wv9n8UCLW89DyYsvMMN5wCG07NCegYm3wyKcNQLs4Eb3FLLIu/5Wycgnpz+FtEJkUoyVWnUvS79NAag2AA4d7k+0XEvlUmE20J87wDVteAk1zBXt871k0Lealo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkUioSuA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777976088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ygfuYqoarx7W9ynFu+RmzkMb+Wwwu56seaguP6G/dYM=;
	b=YkUioSuA4ATaOIpFF/Rm3+Z7stO5lLnJTMnJzsQdnyTO5mxwlu2CzN4VNtl1yF4wVTxFi1
	4pK1dJCV68s0yd80Zv/9mOaq+bQUr/LsfI9vPifXLuQGEjVFrOrcr8KYkJsbkBlcn+4Y93
	usNagg5iOpa7GsKK+b2XQomhTzyOt9Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-zAKHCovCM-OeH5_ufHa6yg-1; Tue,
 05 May 2026 06:14:45 -0400
X-MC-Unique: zAKHCovCM-OeH5_ufHa6yg-1
X-Mimecast-MFC-AGG-ID: zAKHCovCM-OeH5_ufHa6yg_1777976083
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0086D195DE5C;
	Tue,  5 May 2026 10:14:32 +0000 (UTC)
Received: from [10.44.50.148] (unknown [10.44.50.148])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A771F196B0A4;
	Tue,  5 May 2026 10:13:37 +0000 (UTC)
Message-ID: <62bedd23-a9d8-4c05-bf39-662c2d37b793@redhat.com>
Date: Tue, 5 May 2026 12:13:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: stable backports for "KVM: x86: Fix shadow paging use-after-free due
 to unexpected GFN"
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Alexander Bulekov <bkov@amazon.com>, Fred Griffoul <fgriffo@amazon.co.uk>,
 stable@vger.kernel.org
References: <20260503201029.106481-1-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260503201029.106481-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 867944CBB1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244076-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:email]

I have started sending out backports for stable kernels up to 6.1.  For 
5.10 and 5.15 I have identified the required patches and backported 
them, but I haven't tested them yet.

I'll get to testing and sending them out, but it will take a while; if 
anybody wants to help testing, I can provide my tentative patches.

This is the list for 5.15:

     27a59d57f073 KVM: x86/mmu: Use a bool for direct
     86938ab6925b KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
     2e65e842c57d KVM: x86/mmu: Derive shadow MMU page role from parent
     7f49777550e5 KVM: x86/mmu: Always pass 0 for @quadrant when gptes
                  are 8 bytes
     0cd8dc739833 KVM: x86/mmu: pull call to drop_large_spte() into
                  __link_shadow_page()
     0cb2af2ea66a KVM: x86: Fix shadow paging use-after-free due to
                  unexpected GFN


and the longer one for 5.10:

     b37233c911cb KVM: x86/mmu: Capture 'mmu' in a local variable when
                  allocating roots
     ba0a194ffbfb KVM: x86/mmu: Allocate the lm_root before allocating
                  PAE roots
     748e52b9b736 KVM: x86/mmu: Allocate pae_root and lm_root pages in
                  dedicated helper
     6e6ec5848574 KVM: x86/mmu: Ensure MMU pages are available when
                  allocating roots
     27a59d57f073 KVM: x86/mmu: Use a bool for direct
     86938ab6925b KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
     03fffc5493c8 KVM: x86/mmu: Refactor shadow walk in __direct_map() to
                  reduce indentation
     f81602958c11 KVM: X86: Fix missed remote tlb flush in
                  rmap_write_protect()
     65855ed8b034 KVM: X86: Synchronize the shadow pagetable before link
                  it
     2e65e842c57d KVM: x86/mmu: Derive shadow MMU page role from parent
     7f49777550e5 KVM: x86/mmu: Always pass 0 for @quadrant when gptes
                  are 8 bytes
     6e0918aec49a KVM: x86/mmu: Check PDPTRs before allocating PAE roots
     0cd8dc739833 KVM: x86/mmu: pull call to drop_large_spte() into
                  __link_shadow_page()
     0cb2af2ea66a KVM: x86: Fix shadow paging use-after-free due to
                  unexpected GFN

Paolo

On Sun, May 3, 2026 at 10:10 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> The shadow MMU computes GFNs for direct shadow pages using sp->gfn plus
> the SPTE index. This assumption breaks for shadow paging if the guest
> page tables are modified between VM entries (similar to commit
> aad885e77496, "KVM: x86/mmu: Drop/zap existing present SPTE even
> when creating an MMIO SPTE", 2026-03-27).  The flow is as follows:
>
> - a PDE is installed for a 2MB mapping, and a page in that area is
>   accessed.  KVM creates a kvm_mmu_page consisting of 512 4KB pages;
>   the kvm_mmu_page is marked by FNAME(fetch) as direct-mapped because
>   the guest's mapping is a huge page (and thus contiguous).
>
> - the PDE mapping is changed from outside the guest.
>
> - the guest accesses another page in the same 2MB area.  KVM installs
>   a new leaf SPTE and rmap entry; the SPTE uses the "correct" GFN
>   (i.e. based on the new mapping, as changed in the previous step) but
>   that GFN is outside of the [sp->gfn, sp->gfn + 511] range; therefore
>   the rmap entry cannot be found and removed when the kvm_mmu_page
>   is zapped.
>
> - the memslot that covers the first 2MB mapping is deleted, and the
>   kvm_mmu_page for the now-invalid GPA is zapped.  However, rmap_remove()
>   only looks at the [sp->gfn, sp->gfn + 511] range established in step 1,
>   and fails to find the rmap entry that was recorded by step 3.
>
> - any operation that causes an rmap walk for the same page accessed
>   by step 3 then walks a stale rmap and dereferences a freed kvm_mmu_age.
>   This includes dirty logging or MMU notifier invalidations (e.g., from
>   MADV_DONTNEED).
>
> The underlying issue is that KVM's walking of shadow PTEs assumes that
> if a SPTE is present when KVM wants to install a non-leaf SPTE, then the
> existing kvm_mmu_page must be for the correct gfn.  Because the only way
> for the gfn to be wrong is if KVM messed up and failed to zap a SPTE...
> which shouldn't happen, but *actually* only happens in response to a
> guest write.
>
> That bug dates back literally forever, as even the first version of KVM
> assumes that the GFN matches and walks into the "wrong" shadow page.
> However, that was only an imprecision until 2032a93d66fa ("KVM: MMU:
> Don't allocate gfns page for direct mmu pages") came along.
>
> Fix it by checking for a target gfn mismatch and zapping the existing
> SPTE.  That way the old SP and rmap entries are gone, KVM installs
> the rmap in the right location, and everyone is happy.
>
> Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
> Fixes: 6aa8b732ca01 ("kvm: userspace interface")
> Reported-by: Alexander Bulekov <bkov@amazon.com>
> Reported-by: Fred Griffoul <fgriffo@amazon.co.uk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 24fbc9ea502a..892246204435 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -182,6 +182,8 @@ static struct kmem_cache *pte_list_desc_cache;
>  struct kmem_cache *mmu_page_header_cache;
>
>  static void mmu_spte_set(u64 *sptep, u64 spte);
> +static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
> +                           u64 *spte, struct list_head *invalid_list);
>
>  struct kvm_mmu_role_regs {
>         const unsigned long cr0;
> @@ -1287,19 +1289,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
>                 rmap_remove(kvm, sptep);
>  }
>
> -static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
> -{
> -       struct kvm_mmu_page *sp;
> -
> -       sp = sptep_to_sp(sptep);
> -       WARN_ON_ONCE(sp->role.level == PG_LEVEL_4K);
> -
> -       drop_spte(kvm, sptep);
> -
> -       if (flush)
> -               kvm_flush_remote_tlbs_sptep(kvm, sptep);
> -}
> -
>  /*
>   * Write-protect on the specified @sptep, @pt_protect indicates whether
>   * spte write-protection is caused by protecting shadow page table.
> @@ -2466,7 +2455,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
>  {
>         union kvm_mmu_page_role role;
>
> -       if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
> +       if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
> +           spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
>                 return ERR_PTR(-EEXIST);
>
>         role = kvm_mmu_child_role(sptep, direct, access);
> @@ -2544,13 +2534,16 @@ static void __link_shadow_page(struct kvm *kvm,
>
>         BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
>
> -       /*
> -        * If an SPTE is present already, it must be a leaf and therefore
> -        * a large one.  Drop it, and flush the TLB if needed, before
> -        * installing sp.
> -        */
> -       if (is_shadow_present_pte(*sptep))
> -               drop_large_spte(kvm, sptep, flush);
> +       if (is_shadow_present_pte(*sptep)) {
> +               struct kvm_mmu_page *parent_sp;
> +               LIST_HEAD(invalid_list);
> +
> +               parent_sp = sptep_to_sp(sptep);
> +               WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
> +
> +               mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
> +               kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
> +       }
>
>         spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
>
> --
> 2.54.0


