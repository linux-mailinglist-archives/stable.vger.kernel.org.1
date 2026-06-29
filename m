Return-Path: <stable+bounces-269802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W5FtJGWgQmp0+wkAu9opvQ
	(envelope-from <stable+bounces-269802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 18:42:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0816DD6F6
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 18:42:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="K//c09xG";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269802-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269802-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C88FC3034038
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6DA46AEDF;
	Mon, 29 Jun 2026 16:40:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52800466B79
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 16:40:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751234; cv=none; b=ZRNqdf1C3iLVu3P3Z3vtgYu7yY2oK8QJhvwOxDsd1TBcU0hBa2rj4637Wo8uVOffusOD+bgEx2l74fNDiI6hvjQsQXWQa+ls18T7JVfHEybE0E7VWwSU9cHZyb2zMNeOIqAyjIhBiZRAIhmd4EK3sgeMTgJf5SW7JOwnX3Z7uAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751234; c=relaxed/simple;
	bh=R43X/mwoYLibYf/258eRf+1TRx5cN7H4nWibbzSz+FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK1EITCjLadtMezOAIs3PHX8zW/QYw+JXxYkFWDEKx0+iGWGSVUScyRR3sNRd7ev0jRRDRqH+l9rt61J/Fd2ttdJD/K8LuTdb8kFo/KDR32ckHZDjkmTle4pUqZfmLioluMAXxcqRYWxtLCdbM6qhii97k+oNlIIslma1lG2I7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K//c09xG; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9df229032so54125ad.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782751228; x=1783356028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5GdEv1gYkrutMa/9eRDoSEN3dnm0xb5aQFmw17wydw=;
        b=K//c09xG53Hqb2wjgu1IFg9/hXUYGYbHBpat1ToJWZlRFNL35tCUnIsuBxasPqHXCS
         FHovi9mubHcgRFcuUgyaC48YkLFOCc69TmdgD5kK68X+qX2EYjHY7PgyNWqx74Uxd58P
         Ux8gqL1PPOAhEXmfEl8XwU40jntpskDIVFxgvGvEPIjAetVE9wFm3pbWidZ3UDq5ToxW
         +1iWnyiC3RauHLz7KzdhF336emAUKPyqq6NQ8xKUXxl5JwYoKBS5Agtlxhct19XzvsrM
         Z2ErRCu5B/fHQSxvXEZLuOQm0EuhqvJjaa9t/EZh/sR6aNLxz6jRXHDAIpdQ+V69Ec6H
         Ec8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751228; x=1783356028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5GdEv1gYkrutMa/9eRDoSEN3dnm0xb5aQFmw17wydw=;
        b=Y+InbUQahtSd/9F7LuaJlmf5PvPYT+Jht90zjZgQQv2Zwv6sLTJ/e6ABm2CBgvGjri
         FoBgOY3bYDLgInPbPx4AhGkYFnWpJwonUOuKJ3F4qTcgPMIv22iaPaegjtrrmdVldbDH
         TfRL5cv1a17GDGArB816DWmvprcHiKztpuJZfJn4+XlZ0O6qCyD1LenLi27Rx6O7BdEW
         Dr4Z3nR+5HxAaD14S1p0G9JAkb72VvcXPIX1NpM1U/o5Bx8ynLoGQPBNP6s5ZP162c3p
         yNB+clBtG0LuIKO9iziXO95WJnl5A8ACuIoC9yrcITXRNYeLPl6C1lvOQwwPSbUoswve
         y9FA==
X-Forwarded-Encrypted: i=1; AHgh+Rrv0EBu2MmsymBjgyeeXEA42jb+z1HlTXwHBNa0/fb9u2br/Tb4FZQksbPHiD3e/nd+BcHS11A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuvTI+87K/V1RM9t3sy6dOOOxeMDmtMXP8LAIZcUnJhzMNoZ9
	KXTleUGZ7RN898+RRdCduHb5VI8tDiDcHDcckYNgNTpuy3sfWfZwZIriF8G1x7XP9w==
X-Gm-Gg: AfdE7cm3F24rsbrpdhl0lt2E2vECOoLmApSUD5taX+SvT64mapL3xaxbHV03ysoZ8xw
	Of4HyOy918++uhFUCFKKrHWPN7D99pvQoZiXjCpGm+n4fFMF53AOFBO9Ja2oibYj7pK4PasuneF
	aQHgpwmZzMsfHoQ+3Fj9qomh63fOAvd6wHOVK8G9qACNbo2syTHsdlmzDtbz2gMyafcheXPuyU3
	0O84QfGRqsFrkrvDEjy7Xo0+VoFCSxiWnQKbM0uqgY7Ez4/6n6Ccb0pBEGV/2Xjr1M8zN0OJ6J0
	Odp6ZCQHOAQ0WNY03c6HkVXpbKIGVvx8ctolJkNB9YYgFZ4+aNFPZBJdnwyta08m/sOUcAZ4Cf1
	VrpQN7ZIXOVCDM7Ds0s87T56p+7TRjBY1jZUvbZXDqBSXyLxkMPmW+gmMtxEDAqh0vraRXtz0xS
	f7LuQ3rmxHdeEaalaV2KQBiUnM5d2OQL0qfEctUuVbmvPc3wc=
X-Received: by 2002:a17:903:1844:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2ca2cff7977mr338545ad.13.1782751227357;
        Mon, 29 Jun 2026 09:40:27 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm35570b3a.20.2026.06.29.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:40:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:40:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 7/7] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Message-ID: <akKf9S1TURJJq6em@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <8f43bbe920466359465f2083cfd09a15ee8e5ff1.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f43bbe920466359465f2083cfd09a15ee8e5ff1.1779265413.git.nicolinc@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269802-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nicolinc@nvidia.com,m:will@kernel.org,m:robin.murphy@arm.com,m:jgg@nvidia.com,m:joro@8bytes.org,m:kees@kernel.org,m:baolu.lu@linux.intel.com,m:kevin.tian@intel.com,m:miko.lenczewski@arm.com,m:smostafa@google.com,m:linux-arm-kernel@lists.infradead.org,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jamien@nvidia.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E0816DD6F6

On Wed, May 20, 2026 at 10:03:24AM -0700, Nicolin Chen wrote:
> arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
> natural to decide whether the kdump kernel must adopt the crashed kernel's
> stream table.
> 
> Given that memremap is used to adopt the old stream table, set this option
> only on a coherent SMMU.
> 
> And make sure SMMU isn't in Service Failure Mode.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 851bcebfdb3d4..fb34c3ffee9fe 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5353,6 +5353,33 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
>  			  hw_features, fw_features);
>  }
>  
> +static void arm_smmu_device_hw_probe_kdump(struct arm_smmu_device *smmu)
> +{
> +	u32 gerror, gerrorn, active;
> +
> +	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
> +	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
> +		return;
> +
> +	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
> +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
> +		dev_warn(smmu->dev,
> +			 "kdump: non-coherent SMMU unsupported; reset to block all DMAs\n");
> +		return;
> +	}

We seem to be checking it here right at the beginning, let's remove the
redundant checks downstream?

> +
> +	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
> +	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
> +	active = gerror ^ gerrorn;
> +	if (active & GERROR_SFM_ERR) {
> +		dev_warn(smmu->dev,
> +			 "kdump: SMMU in Service Failure Mode, must reset\n");
> +		return;
> +	}
> +
> +	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
> +}
> +
>  static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  {
>  	u32 reg;
> @@ -5567,6 +5594,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  
>  	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
>  		 smmu->oas, smmu->features);
> +
> +	if (is_kdump_kernel())
> +		arm_smmu_device_hw_probe_kdump(smmu);
> +
>  	return 0;
>  }
  
Apart from that nit,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

