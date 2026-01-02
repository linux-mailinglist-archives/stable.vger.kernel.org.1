Return-Path: <stable+bounces-204499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C04CCEF32F
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 19:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B3B301CEBE
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8CB314D26;
	Fri,  2 Jan 2026 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XEm80rH/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC052286D7C
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379279; cv=none; b=q7XNWW8Jiu3+N+f60avd0tu+oPtC60/tZkcm9Z957WRMFxLgA7nzk2JzlRpJm84VVWrdixLISM4akxNOvpspIMILiJ6Kc3+70mIX1nOiuV8dyIQdL+ocaR0rVBcH7N579/fobeUNbIkwReAygbUljgTTQK+CxQ/6sDackzTJ9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379279; c=relaxed/simple;
	bh=bXmVqZi5/XxGwHoRNC2qo8trHPL/JUWYt6dxPjrbbI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C959q4kNItx0ZEPFKxl2gLc0x1SdHfwzXWpl2MuTJI1tFAkR+a1ToTNgqUNfQyZj8ZrcTNt/FGoulS6kc67QDQjjOAZGH3aKQDNsCMCFk0rTdVX3JKdQbxavcHUXSPAxvq/rFo2kIZLb3uywSeXyP7TcBqHQ/uhleff6CaFBzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XEm80rH/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso15343985a.0
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767379275; x=1767984075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbKNq3OzvNgOXwfOYEfmEuaPS05vXN54NlE6TZcUdp4=;
        b=XEm80rH/f7ajg/ABVoHYzDA8sIgm6xlGcxnhG2f0hdkom1SGb0cE0nkVasqgIe0B0+
         BIFw9IbtoYI6qODNUx3EfM0fhXr39MO9/j+p09Jey7uVqee2lZm2Ubc9BsNs6z06BcPf
         RsKl3Rv9um4zoMQD111N6s71gm+duh4XTb1d/oupq1ClwBFjU+7CE82qHQDIv5nqIWYq
         OW8SR16+NPp5T0+3JfccAS/MQAiY6jHaqYOK3icGgbwILEjjmfHFNJKxd4NAa6ldsvrK
         Z7DMTGGohcmCMXp8wbb2PyX9BRqPoDSZMPGgUkTL7Nv7hrJfAd6ddoKbSxe2l9kxLCYR
         xXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379275; x=1767984075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbKNq3OzvNgOXwfOYEfmEuaPS05vXN54NlE6TZcUdp4=;
        b=uR95birBC4V5WORP7FrTE+bSvpeqtL3hvCzobPniLxEjN8lcfAtYgt3YW5xl1pRr8V
         TKmGA1bQoTkKeam7LIed/sNkyLPTO4g/9ghvh/1HU5u8c8c52DvsNXD3G5zJSfRWUUuk
         eX4KxLZeapu0SguRvY2eh6vvXdWFNebSRelBSw9/x8ar6aiXAsRjKUNVJVvk1nKL5S6H
         n/pR1sdSuJDJXNKjyVhs07HujIGALg3sLDZQhXI+cIAauCHUsxe3SDdvWvKE7trKd6pi
         nUU6MwcH3Pun0fYC7Nx9EXafWTgvmahnz9YNsYrBsyQb5/DzV90xzISnqgfkc85JuHBQ
         pToQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkG1l75ZR+Rz6xMUousCt74kRas52248kpKIjgCJwyaBPGzVSqYg+E6cwmoq7+6Ebh9wdPGB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWmPSZok42u6IRoTUgCXJM6KxtpbEHTtTI0zy7SGGFrpNrgmF
	d8XleTdL2ecnqe2t/R++91J1bnPYPv7aBFiyxvFoq9vgUXbj/54+2sA6b6iLEgBimbs=
X-Gm-Gg: AY/fxX4X0lhigePEGlbxMRCX6Gs1F/iZULIFpuO+RXgVpYfijXDUoWqxRfEFuv8cDtY
	8o2oh7jBl9qAt1bLyEerKzLhs0PojmsrHiXbh9GwgGli0dgZjKZluTRTsGHTgyj+exJEXK4Lf4t
	P9aqaEGh37rPdfFNdXrbCt1l5wCa4ChWD7ufIHI2oDRo5hJhTkVzDCfd13cfYoko8skpAm9BpRX
	VJa6zY7g6a+eH5ShBV5kTyurKkCwDSrkXZcFLBGQLBH3QDxvMQRKVjeKsDhPg29T2KiG4lzrrfS
	YjeUs7vAMcBmCrBY0vFBJizZVfpYLAU+6fp15GklxQzfAOepjGXOUYLjjhWDSK8wO0jzU4ZUWBp
	oN81TUzxflGe0WrE3zaYgKRByS7b9kRz2ykOIgBnbUbdscKtwdnmueaeOszhVDiztSo5dugJOdq
	OHedFAcndB7bOQ/HnKCkcLPbOZ1Cr2IiydaEFhgjnOUGtGcsZu4QEUXrprLr1Bh3GiTK4=
X-Google-Smtp-Source: AGHT+IFf1uKGIwRHqgDuPoJHVm8is9Z+z+ElqpNBRFLqGHyGLWLw+ECPqzKaTxkx0tZNT3guYluMgA==
X-Received: by 2002:a05:620a:7111:b0:8a3:90cb:9224 with SMTP id af79cd13be357-8c3568a0131mr102879985a.2.1767379274814;
        Fri, 02 Jan 2026 10:41:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09678afa6sm3293504685a.2.2026.01.02.10.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:41:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vbk5J-00000000neJ-2b6O;
	Fri, 02 Jan 2026 14:41:13 -0400
Date: Fri, 2 Jan 2026 14:41:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dawei Li <dawei.li@linux.dev>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260102184113.GA125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229002354.162872-1-dawei.li@linux.dev>

On Mon, Dec 29, 2025 at 08:23:54AM +0800, Dawei Li wrote:
> According to SMMUv3 architecture specification, IO-coherent access for
> SMMU is supported for:
> - Translation table walks.
> - Fetches of L1STD, STE, L1CD and CD.
> - Command queue, Event queue and PRI queue access.
> - GERROR, CMD_SYNC, Event queue and PRI queue MSIs, if supported

I was recently looking at this too..  IMHO this is not really a clean
description of what this patch is doing.

I would write this description as:

When the SMMU does a DMA for itself it can set various memory access
attributes which control how the interconnect should execute the
DMA. Linux uses these to differentiate DMA that must snoop the cache
and DMA that must bypass it because Linux has allocated non-coherent
on the CPU.

In Table "13.8 Attributes for SMMU-originated accesses" each of the
different types of DMA is categorized and the specific bits
controlling the memory attribute for the fetch are identified.

Make this consisent globally. If Linux has cache flushed the buffer,
or allocated a DMA incoherenet buffer, then it should set the
non-caching memory attribute so the DMA matches.

This is important for some of the allocations where Linux is currently
allocating DMA coherent memory, meaning nothing has made the CPU cache
coherent and doing any coherent access to that memory may result in
cache inconsistencies.

This may solve problems in systems where the SMMU driver thinks the
SMMU is non-coherent, but in fact, the SMMU and the interconnect
selectively supports coherence and setting the wrong memory attributes
will cause non-working cached access.

[and then if you have a specific SOC that shows an issue please
describe the HW]

> +static __always_inline bool smmu_coherent(struct arm_smmu_device *smmu)
> +{
> +	return !!(smmu->features & ARM_SMMU_FEAT_COHERENCY);
> +}
> +
>  /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent,
> +				   struct arm_smmu_device *smmu)
>  {
>  	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>  	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> @@ -358,8 +364,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  		} else {
>  			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>  		}
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> +		if (smmu_coherent(smmu)) {
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> +		} else {
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_OSH);
> +			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OINC);
> +		}

And then please go through your patch and add comments actually
explaining what the DMA is and what memory is being reached by it -
since it is not always very clear from the ARM mnemonics

For instance, this is:
 /* DMA for "CMDQ MSI" which targets q->base_dma allocated by arm_smmu_init_one_queue() */

> @@ -1612,11 +1624,18 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
>  
> +	if (smmu_coherent(smmu)) {
> +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
> +	} else {
> +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
> +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
> +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
> +	}

This one is "CD fetch" allocated by arm_smmu_alloc_cd_ptr()

etc

And note that the above will need this hunk too:

+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -432,6 +432,14 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
            !(smmu->features & ARM_SMMU_FEAT_S2FWB))
                return 0;
 
+       /*
+        * When running non-coherent we can't suppot S2FWB since it will also
+        * force a coherent CD fetch, aside from the question of what
+        * S2FWB/CANWBS even does with non-coherent SMMUs.
+        */
+       if (!smmu_coherent(smmu))
+               return 0;

> @@ -3746,7 +3765,7 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  	q->cons_reg	= page + cons_off;
>  	q->ent_dwords	= dwords;
>  
> -	q->q_base  = Q_BASE_RWA;
> +	q->q_base  = smmu_coherent(smmu) ? Q_BASE_RWA : 0;

CMDQ fetch, though do we even need to manage RWA? Isn't it ignored if
IC/OC/SH are set to their non-cachable values?

etc..

Jason

