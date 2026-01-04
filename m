Return-Path: <stable+bounces-204562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46250CF1003
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 14:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 475BD30050B6
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A730DEC4;
	Sun,  4 Jan 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSrjK0At"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38F30DEBB
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767533751; cv=none; b=H0i2oG03+AeJ4b5bVdv7byLjPwtR0WkWTEihJ8v6AQGBG8lII0CjyDaYFGCvQ8oTLkbANt7NcEl7CZrCTeO2bXgLY4hI8O7JBt5eWdOhvTOD5DtEnuxjeQ33cmiMu0dsJN4m+XaTAn3r9i4xk/tjXw30lLkrzJmsZtpoSeoXU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767533751; c=relaxed/simple;
	bh=FCjQtwwAR4ikxiwOX77mn/0eJCznB7IM8lsCtXn0iBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsnst7NCuHfirtLdSsWFI9YVb+xNqrqGl6Hp0ctHtBzI2KSv3bF85p3Jf6Zw80CAxXlWXx0reQ5VC0vFOVe3L7TSm1TBjCebAGM6i6+6iZFejrQ46jT4JizAWRqPgE1bS42JD/NKI5tlnDNYKy1NN7BWa2JdcX22Z3h7ENYrY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSrjK0At; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 4 Jan 2026 21:35:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767533736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tnzMXDHXXL9NNS4k3AnnQ9myHIZaZb8uzsVSt6dVi30=;
	b=qSrjK0AtRce/nc9H7pvBQSyTFKoO3HjCKs8u1Dp8B/5zTb+WB183UzOMgQAjXjSzwlVeNt
	ZgXqTmXFAvn7vS84wsvtHHjM+zDYs0g6WyWdcPK3oqmgajD8MJbjZH9uCJaIIwd+MuUZ8w
	z+LdLGNtOXOHa+kmLYDUeorMT+9ZZh8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dawei Li <dawei.li@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org, dawei.li@linux.dev
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260104133532.GA173992@wendao-VirtualBox>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <20260102184113.GA125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102184113.GA125261@ziepe.ca>
X-Migadu-Flow: FLOW_OUT

Jeson,

On Fri, Jan 02, 2026 at 02:41:13PM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 29, 2025 at 08:23:54AM +0800, Dawei Li wrote:
> > According to SMMUv3 architecture specification, IO-coherent access for
> > SMMU is supported for:
> > - Translation table walks.
> > - Fetches of L1STD, STE, L1CD and CD.
> > - Command queue, Event queue and PRI queue access.
> > - GERROR, CMD_SYNC, Event queue and PRI queue MSIs, if supported
> 
> I was recently looking at this too..  IMHO this is not really a clean
> description of what this patch is doing.
> 
> I would write this description as:
> 
> When the SMMU does a DMA for itself it can set various memory access
> attributes which control how the interconnect should execute the
> DMA. Linux uses these to differentiate DMA that must snoop the cache
> and DMA that must bypass it because Linux has allocated non-coherent
> on the CPU.
> 
> In Table "13.8 Attributes for SMMU-originated accesses" each of the
> different types of DMA is categorized and the specific bits
> controlling the memory attribute for the fetch are identified.

Turns out I missed some of DMA types listed in 13.8, thanks for the
headsup.

> 
> Make this consisent globally. If Linux has cache flushed the buffer,
> or allocated a DMA incoherenet buffer, then it should set the
> non-caching memory attribute so the DMA matches.
> 
> This is important for some of the allocations where Linux is currently
> allocating DMA coherent memory, meaning nothing has made the CPU cache
> coherent and doing any coherent access to that memory may result in
> cache inconsistencies.
> 
> This may solve problems in systems where the SMMU driver thinks the
> SMMU is non-coherent, but in fact, the SMMU and the interconnect
> selectively supports coherence and setting the wrong memory attributes
> will cause non-working cached access.
> 
> [and then if you have a specific SOC that shows an issue please
> describe the HW]
> 
> > +static __always_inline bool smmu_coherent(struct arm_smmu_device *smmu)
> > +{
> > +	return !!(smmu->features & ARM_SMMU_FEAT_COHERENCY);
> > +}
> > +
> >  /* High-level queue accessors */
> > -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> > +static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent,
> > +				   struct arm_smmu_device *smmu)
> >  {
> >  	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> >  	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> > @@ -358,8 +364,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> >  		} else {
> >  			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> >  		}
> > -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> > -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> > +		if (smmu_coherent(smmu)) {
> > +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> > +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> > +		} else {
> > +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_OSH);
> > +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OINC);
> > +		}
> 
> And then please go through your patch and add comments actually
> explaining what the DMA is and what memory is being reached by it -
> since it is not always very clear from the ARM mnemonics

Acked.

> 
> For instance, this is:
>  /* DMA for "CMDQ MSI" which targets q->base_dma allocated by arm_smmu_init_one_queue() */
> 
> > @@ -1612,11 +1624,18 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> >  		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> >  		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
> >  
> > +	if (smmu_coherent(smmu)) {
> > +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
> > +	} else {
> > +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
> > +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
> > +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
> > +	}
> 
> This one is "CD fetch" allocated by arm_smmu_alloc_cd_ptr()
> 
> etc
> 
> And note that the above will need this hunk too:
> 
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -432,6 +432,14 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
>             !(smmu->features & ARM_SMMU_FEAT_S2FWB))
>                 return 0;
>  
> +       /*
> +        * When running non-coherent we can't suppot S2FWB since it will also
> +        * force a coherent CD fetch, aside from the question of what
> +        * S2FWB/CANWBS even does with non-coherent SMMUs.
> +        */
> +       if (!smmu_coherent(smmu))
> +               return 0;

I was wondering why S2FWB can affect CD fetching before reading 13.8.

Does diff below suffice?

@@ -1614,8 +1619,12 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 {
        struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
        struct arm_smmu_device *smmu = master->smmu;
+       bool coherent, fwb;
        u64 val;

+       coherent = smmu_coherent(smmu);
+       fwb = !!(smmu->features & ARM_SMMU_FEAT_S2FWB);
+
        memset(target, 0, sizeof(*target));
        target->data[0] = cpu_to_le64(
                STRTAB_STE_0_V |
@@ -1624,14 +1633,24 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
                (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
                FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));

+       /*
+        * DMA for "CD fetch" targets cd_table->linear.table or cd_table->l2.l1tab
+        * allocated by arm_smmu_alloc_cd_ptr().
+        */
        if (smmu_coherent(smmu)) {
                val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
                      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
                      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
        } else {
-               val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
-                     FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
-                     FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
+               if (!fwb) {
+                       val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
+                               FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
+                               FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
+               } else {
+                       dev_warn(&smmu->dev, "Inconsitency between COHACC & S2FWB\n");
+                       /* FIX ME */
+                       return;
+               }
        }


> 
> > @@ -3746,7 +3765,7 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
> >  	q->cons_reg	= page + cons_off;
> >  	q->ent_dwords	= dwords;
> >  
> > -	q->q_base  = Q_BASE_RWA;
> > +	q->q_base  = smmu_coherent(smmu) ? Q_BASE_RWA : 0;
> 
> CMDQ fetch, though do we even need to manage RWA? Isn't it ignored if
> IC/OC/SH are set to their non-cachable values?

My first thought was "why don't we just whack them all?", yet the spec
reads:

"Cache allocation hints are present in each _BASE register and are ignored
 unless a cacheable type is used for the table or queue to which the
 register corresponds"

You are right, gonna remove it.

> 
> etc..
> 
> Jason

Thanks,

	Dawei

