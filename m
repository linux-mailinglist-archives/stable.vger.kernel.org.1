Return-Path: <stable+bounces-204580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9BCF1781
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 01:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A88E3009A96
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 00:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E73A1E97;
	Mon,  5 Jan 2026 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="emmKnoUm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC618834
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767571354; cv=none; b=I/+Os6Oi+85Iz8NMsXvkML+BmX8ScrVjibBae+/9+KbNGRvzXK3qEnh1qNDcc+y3MezscGfG7OuG47/UpSrjDhQTqHcISuP4m0MjzTQrF0fe1PErFIaRg5BTp16VDiDqGLq2zdUqoWOS0kAoxK83hxXxEQRGo8vxW6h5QNxQ00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767571354; c=relaxed/simple;
	bh=5Pd8XHirDAvBeGnaTQQoB4X3T4keVMq6ZwvkHBRkwKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za5daRhPRUdBUhvUnI/j7b2NlIsgIJeBTDNWAORZxAbURZgDAutk6ApPsq/nCFYLiMRrMyVbadidDkToENui7todErG3jXJFDkzOeBr4oQRcjsJhcP/nwVKA5DCEUg7g5sZNXDYIT25NXXLZOkU69y2IZqoFWU42ocW/kl7ef8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=emmKnoUm; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso115481285a.0
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 16:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767571351; x=1768176151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+jSiPWTak82xdkGqmhBxUT/Rw7weH7GEOHsr3Ick4Q=;
        b=emmKnoUmWyUMPTZnoiMQ2YplhNwQ4YrMV2CTkgvY75AZb7tEVNxHGroI1FPmSnx5D3
         hDWaZYAFW4XHMGlccEOpeCRmgWsLoQOyrvvYa4PBy8bki/RomRSnT4yHAuJNOMEvr73P
         +IYULscK+k0h5QFac9hE/sXqN9+E7uLxFxL+21zw4gc/ktGo7/ZgO1OOrE93dSLUi1e3
         gDVaxAxzd/xsALH2vsF7zp9OY5fVaDPDSxWVqHoZRVwvgh9RBJMxnebcuAtJ7Nt/LkjB
         7XzLaZkQqpGmLNTIibDLLH7NspR3wBc5vkqWofTUknHCe7CRBW2T5QkqCpBZ4GnXmKHD
         R4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767571351; x=1768176151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+jSiPWTak82xdkGqmhBxUT/Rw7weH7GEOHsr3Ick4Q=;
        b=iGT60T/2SBxMGAPtxhmPtAnveeg9MXIPLVjeKxo9lJxt29FubX+5EMfIV9C1EE84RP
         7e+p9mqB0wNC6l+42ezFjjAten+jIBd7iZjFuFB3NQt+JdhIC2JehSoydseg6bSQHX7D
         dev356m12j64FcUY3WjophflfBBAkw9GEq2nBTulr5K3XJyar+UItqCHCMgOL0FFOq/5
         bdzaJ9trDMjs5ZaGv3zkAtOxCnfvffMFZAZSDLIoAPWHiuyKVnqmeu4xE7ApUQ1jdbgL
         DzVm4luVHNRn9x7zLPWQvqLazvtm1LBh1f7NW9D/Axyc0/AP+cOh3BAEr8zXU5/jOlBL
         Bzmg==
X-Forwarded-Encrypted: i=1; AJvYcCXXvdTxFerpVlWlBp6BlEFJOZfqQfU9LJ38aOMJTKvp/QEwzCjV7FKvjILpX9G9rj8sjuG9gt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkt5WyEhAPndjxzge2sWtRgDya8hr7jf2RqN7jEwgy4jwK5Dxw
	cQ/FMekPoGrdZIhYvLO9e40T41s/8Kxy422/rnQA5CtYhn36cO56eF2i578sG9sw0BA=
X-Gm-Gg: AY/fxX7pLy4XUbEbkS5yDwvqS73mt0QJtVnoAo0QaxDcgWHAeCvJevVCjS8V8rS1Uhc
	qRa6VJib+gIkrEBd/1NZgXjuTU2rqyKqgI36OdUwARF0vwRr/Dq3oawZiNMDAeF/vGI+1+2IkwB
	QeBTvb1vbbq5W7y9xJ4XWwoiJw77bU5oXNpwMw4jbk9QuL2qLcp8UwS1MT/XpaT1am5pixp/l53
	mCdHZhy6VS7WSdplIF1s9j5/iT7vO4B7/t26CzjVQl6kILwWQXLPlRUo/KRhV/eOPxpMy4E26ay
	9CNHkOmM59ogJGq6zHgF7yVDhlIzG8Xgejrx42OZQCCqrhd9qQXUYokexz2LTPSEbjzkKTmoG2t
	UzvyH8ci7Sfi4NeD5eug8U2nRheH+MxcpJGe1WQ8NXR0uiby3gZvwq4CtGhqS5Dkk0rJnKHOXpw
	fN4D8gf+Lm2fe5PTi/ta/wFs09H83jeOLbfhwWAuv0CyfnMx0LPEApl0+zCVAhhNZUL04=
X-Google-Smtp-Source: AGHT+IGiRum5OAeqK7KwLoeA3fYC8uB4/qk0h6ByodkxfauKgGSblQTUCpTabkdDEAjM1i6E2aZiIQ==
X-Received: by 2002:a05:620a:440b:b0:8a2:595f:657 with SMTP id af79cd13be357-8c356f10068mr814244585a.21.1767571350945;
        Sun, 04 Jan 2026 16:02:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm3545746985a.13.2026.01.04.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:02:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcY3J-0000000156c-2OeL;
	Sun, 04 Jan 2026 20:02:29 -0400
Date: Sun, 4 Jan 2026 20:02:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dawei Li <dawei.li@linux.dev>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260105000229.GC125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <20260102184113.GA125261@ziepe.ca>
 <20260104133532.GA173992@wendao-VirtualBox>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104133532.GA173992@wendao-VirtualBox>

> >  /* DMA for "CMDQ MSI" which targets q->base_dma allocated by arm_smmu_init_one_queue() */
> > 
> > > @@ -1612,11 +1624,18 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> > >  		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > >  		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
> > >  
> > > +	if (smmu_coherent(smmu)) {
> > > +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
> > > +	} else {
> > > +		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
> > > +		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
> > > +	}
> > 
> > This one is "CD fetch" allocated by arm_smmu_alloc_cd_ptr()
> > 
> > etc
> > 
> > And note that the above will need this hunk too:
> > 
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > @@ -432,6 +432,14 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
> >             !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> >                 return 0;
> >  
> > +       /*
> > +        * When running non-coherent we can't suppot S2FWB since it will also
> > +        * force a coherent CD fetch, aside from the question of what
> > +        * S2FWB/CANWBS even does with non-coherent SMMUs.
> > +        */
> > +       if (!smmu_coherent(smmu))
> > +               return 0;
> 
> I was wondering why S2FWB can affect CD fetching before reading 13.8.

Yeah, that table is super useful

> +               if (!fwb) {
> +                       val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
> +                               FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
> +                               FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
> +               } else {
> +                       dev_warn(&smmu->dev, "Inconsitency between COHACC & S2FWB\n");
> +                       /* FIX ME */
> +                       return;

I prefer we block it as I showed instead of printing a warning, cache
inconsistencies in virtualization can become security problems.

Though it is probably good to add a comment here about s2fwb also

Jason

