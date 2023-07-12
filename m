Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A0750767
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjGLMCe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjGLMCU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 08:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F71FDE
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689163285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M50K9pHZDJbPCSbFBAjVuTHYjYYq1J4ree9VestSKoQ=;
        b=DlF511JKjf3xYmoIHWfv8+RDap0b6Maiy2+7QBEbrdnjQ1yfRFeHvw/eAYAhb8ZR0oJQjE
        t843hPpW7BWBRndgnEbCvissZidau4WAjRm69niqC3S2ZWWyb7dU1156KHz3IyeQl+mfcp
        Yz90dBqekCKheOEYsEb9x1RwuxNYVkE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-BmCi-lLQN8-NbvA6Rg90zg-1; Wed, 12 Jul 2023 08:01:24 -0400
X-MC-Unique: BmCi-lLQN8-NbvA6Rg90zg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767edbf73cbso13529885a.1
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 05:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689163284; x=1689768084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M50K9pHZDJbPCSbFBAjVuTHYjYYq1J4ree9VestSKoQ=;
        b=fk5m9wCn/iUn9TRBh+vS/apLZUBNgltiIDLIr8BbjtEgMLX4nsMDP1iecM92zywiE/
         TlMFRCuhWzxyX3OEmoP5OIdppgJuc/xoSIuQRZUtGmxmf5esNuY7yrO3Fgna3mgx1iCP
         5WmpvQwXrQfNbC4ee5lwuoYcpa/lyWg7GW7co5TD8AR7pZPvfI89rc4Rwpyi6v6QqTJR
         T5RRBfWAvr0Hu54LjJFqXOT+vCqY537HtWQ5n3BhbbvG3j7pTLdtlazk8AY9SueLOnYQ
         LW6SH1C6YxCZK3TodQY6PCh/ErVjSc3pVLLdBdTa/7e59/SoZeSIfDMvq3CtqrCu16iJ
         jBuA==
X-Gm-Message-State: ABy/qLZZ6LBCEURw8Jwa2jZQDqbXXilOf+pgoZFKF40RBTbc0mWY67KP
        35savIy3lFX9h2Sgp1BZW1H8mJlDD0ZJq+EkobrLJAlRcSReJViD0KmCahqc27iGPxfbd7cU1hO
        bYNYsFd0aDz533PAO
X-Received: by 2002:a05:620a:4516:b0:765:435c:a4fa with SMTP id t22-20020a05620a451600b00765435ca4famr20075437qkp.0.1689163283706;
        Wed, 12 Jul 2023 05:01:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFrmOiSLvKoZMbc2ZYZOP/uHSGo5Z6b/QRPJPNxULdpDoUhJDrm9WxMNDbJm2moFqQgqr2oQw==
X-Received: by 2002:a05:620a:4516:b0:765:435c:a4fa with SMTP id t22-20020a05620a451600b00765435ca4famr20075410qkp.0.1689163283395;
        Wed, 12 Jul 2023 05:01:23 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m13-20020a05622a118d00b00403b1fb1f48sm2188092qtk.17.2023.07.12.05.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:01:23 -0700 (PDT)
Message-ID: <df0eb9d8-9166-ab26-aa1b-0f5243cba715@redhat.com>
Date:   Wed, 12 Jul 2023 20:01:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] KVM: arm64: Correctly handle page aging notifiers for
 unaligned memslot
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Reiji Watanabe <reijiw@google.com>, stable@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
References: <20230627235405.4069823-1-oliver.upton@linux.dev>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230627235405.4069823-1-oliver.upton@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Oliver,

On 6/28/23 07:54, Oliver Upton wrote:
> Userspace is allowed to select any PAGE_SIZE aligned hva to back guest
> memory. This is even the case with hugepages, although it is a rather
> suboptimal configuration as PTE level mappings are used at stage-2.
> 
> The arm64 page aging handlers have an assumption that the specified
> range is exactly one page/block of memory, which in the aforementioned
> case is not necessarily true. All together this leads to the WARN() in
> kvm_age_gfn() firing.
Is there any easy way to reproduce the WARN() in the kvm_age_gfn()?
> 
> However, the WARN is only part of the issue as the table walkers visit
> at most a single leaf PTE. For hugepage-backed memory in a memslot that
> isn't hugepage-aligned, page aging entirely misses accesses to the
> hugepage beyond the first page in the memslot.
> 
> Add a new walker dedicated to handling page aging MMU notifiers capable
> of walking a range of PTEs. Convert kvm(_test)_age_gfn() over to the new
> walker and drop the WARN that caught the issue in the first place. The
> implementation of this walker was inspired by the test_clear_young()
> implementation by Yu Zhao [*], but repurposed to address a bug in the
> existing aging implementation.
> 
> Cc: stable@vger.kernel.org # v5.15
> Fixes: 056aad67f836 ("kvm: arm/arm64: Rework gpa callback handlers")
> Link: https://lore.kernel.org/kvmarm/20230526234435.662652-6-yuzhao@google.com/
> Co-developed-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reported-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   arch/arm64/include/asm/kvm_pgtable.h | 26 ++++++------------
>   arch/arm64/kvm/hyp/pgtable.c         | 41 ++++++++++++++++++++++------
>   arch/arm64/kvm/mmu.c                 | 18 ++++++------
>   3 files changed, 49 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index dc3c072e862f..75f437e8cd15 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -556,22 +556,26 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
>   kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
>   
>   /**
> - * kvm_pgtable_stage2_mkold() - Clear the access flag in a page-table entry.
> + * kvm_pgtable_stage2_test_clear_young() - Test and optionally clear the access
> + *					   flag in a page-table entry.With this change, the description should change to:

s/a page-table entry/multiple page-table entries.

Others looks good to me.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>    * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
>    * @addr:	Intermediate physical address to identify the page-table entry.
> + * @size:	Size of the address range to visit.
> + * @mkold:	True if the access flag should be cleared.
>    *
>    * The offset of @addr within a page is ignored.
>    *
> - * If there is a valid, leaf page-table entry used to translate @addr, then
> - * clear the access flag in that entry.
> + * Tests and conditionally clears the access flag for every valid, leaf
> + * page-table entry used to translate the range [@addr, @addr + @size).
>    *
>    * Note that it is the caller's responsibility to invalidate the TLB after
>    * calling this function to ensure that the updated permissions are visible
>    * to the CPUs.
>    *
> - * Return: The old page-table entry prior to clearing the flag, 0 on failure.
> + * Return: True if any of the visited PTEs had the access flag set.
>    */
> -kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
> +bool kvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr,
> +					 u64 size, bool mkold);
>   
>   /**
>    * kvm_pgtable_stage2_relax_perms() - Relax the permissions enforced by a
> @@ -593,18 +597,6 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
>   int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
>   				   enum kvm_pgtable_prot prot);
>   
> -/**
> - * kvm_pgtable_stage2_is_young() - Test whether a page-table entry has the
> - *				   access flag set.
> - * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
> - * @addr:	Intermediate physical address to identify the page-table entry.
> - *
> - * The offset of @addr within a page is ignored.
> - *
> - * Return: True if the page-table entry has the access flag set, false otherwise.
> - */
> -bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
> -
>   /**
>    * kvm_pgtable_stage2_flush_range() - Clean and invalidate data cache to Point
>    * 				      of Coherency for guest stage-2 address
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 5282cb9ca4cf..5d701e9adf5c 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1153,25 +1153,48 @@ kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
>   	return pte;
>   }
>   
> -kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr)
> +struct stage2_age_data {
> +	bool	mkold;
> +	bool	young;
> +};
> +
> +static int stage2_age_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			     enum kvm_pgtable_walk_flags visit)
>   {
> -	kvm_pte_t pte = 0;
> -	stage2_update_leaf_attrs(pgt, addr, 1, 0, KVM_PTE_LEAF_ATTR_LO_S2_AF,
> -				 &pte, NULL, 0);
> +	kvm_pte_t new = ctx->old & ~KVM_PTE_LEAF_ATTR_LO_S2_AF;
> +	struct stage2_age_data *data = ctx->arg;
> +
> +	if (!kvm_pte_valid(ctx->old) || new == ctx->old)
> +		return 0;
> +
> +	data->young = true;
> +
> +	if (data->mkold && !stage2_try_set_pte(ctx, new))
> +		return -EAGAIN;
> +
>   	/*
>   	 * "But where's the TLBI?!", you scream.
>   	 * "Over in the core code", I sigh.
>   	 *
>   	 * See the '->clear_flush_young()' callback on the KVM mmu notifier.
>   	 */
> -	return pte;
> +	return 0;
>   }
>   
> -bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr)
> +bool kvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr,
> +					 u64 size, bool mkold)
>   {
> -	kvm_pte_t pte = 0;
> -	stage2_update_leaf_attrs(pgt, addr, 1, 0, 0, &pte, NULL, 0);
> -	return pte & KVM_PTE_LEAF_ATTR_LO_S2_AF;
> +	struct stage2_age_data data = {
> +		.mkold		= mkold,
> +	};
> +	struct kvm_pgtable_walker walker = {
> +		.cb		= stage2_age_walker,
> +		.arg		= &data,
> +		.flags		= KVM_PGTABLE_WALK_LEAF,
> +	};
> +
> +	WARN_ON(kvm_pgtable_walk(pgt, addr, size, &walker));
> +	return data.young;
>   }
>   
>   int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 3b9d4d24c361..8a7e9381710e 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1639,27 +1639,25 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   {
>   	u64 size = (range->end - range->start) << PAGE_SHIFT;
> -	kvm_pte_t kpte;
> -	pte_t pte;
>   
>   	if (!kvm->arch.mmu.pgt)
>   		return false;
>   
> -	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
> -
> -	kpte = kvm_pgtable_stage2_mkold(kvm->arch.mmu.pgt,
> -					range->start << PAGE_SHIFT);
> -	pte = __pte(kpte);
> -	return pte_valid(pte) && pte_young(pte);
> +	return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
> +						   range->start << PAGE_SHIFT,
> +						   size, true);
>   }
>   
>   bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>   {
> +	u64 size = (range->end - range->start) << PAGE_SHIFT;
> +
>   	if (!kvm->arch.mmu.pgt)
>   		return false;
>   
> -	return kvm_pgtable_stage2_is_young(kvm->arch.mmu.pgt,
> -					   range->start << PAGE_SHIFT);
> +	return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
> +						   range->start << PAGE_SHIFT,
> +						   size, false);
>   }
>   
>   phys_addr_t kvm_mmu_get_httbr(void)
> 
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511

-- 
Shaoqin

