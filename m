Return-Path: <stable+bounces-232760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAW2E7kDzWnhZQYAu9opvQ
	(envelope-from <stable+bounces-232760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 13:38:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469B3799A3
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7EEB30FD8AC
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278D3F99CD;
	Wed,  1 Apr 2026 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2lw5rKz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC433F20E2
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042618; cv=none; b=VTtXczilurW13uzqlC1WMuhclRU6PEP2ieejpzCIZcpRJBetmXxclb3ISRrccKXcxJ5NIR1bHnxoDb4F8ZTHBrX2WCGqDcmlviFCIDj54mM0EEY9bBDpQ7mTT58hND7X+SERdeu4e/yuKZHQRTtR4JxwuQCWDwKajbOAvFQWL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042618; c=relaxed/simple;
	bh=tZ1qpc9jFWedWE8AwUzwx8Nqnc2oEi5R0JG7PTZIt4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7Be6tCY/K7Vwdy0uCL+9e2qxA0izXup3la/r4mcanv2lGjfpI4yzOTlQ6MxVvTopD7RXFDobuYiGiTGZyhQdp75J7q5OIbzDAiEXVvywI2cIXRVPqV5pq7qAeio1bXjgqELFEN04cPTEiVSfp5P65VP7zGRYKECpek5Fh9Xuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2lw5rKz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0b260d309so166085ad.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 04:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775042616; x=1775647416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wLwW3RwfZlMNchucl4Q1BjkgKkbbVmuqcbZXsSlons=;
        b=O2lw5rKzv5GpIGsoYjagOB45bkJh4I6JgxIli2awfnFsT4t1c1hSmMgmvdMgOMnbBz
         fac3oVn3+cPk/wgYD/paypKWKshVQ3jW+Anq1DNfujtYscj9oc4gFEe4UmN8H2vLQFLd
         7R19rZxz+bD42Ax4Z4gtobCRM4PM5pFNSa5+/mulVOkKrrVMrv5XofTCNTphAq92ajn8
         LTPc5Jt9Y0uxNfv4/2aC6ILm+/N3n/tFOjZRtBa5XJr1oBQpUtKS6NzA4rAXq79zOJjU
         4pHuRh86tdRXZpbznTW2n6784yHtHCr1GPvK+C7Z35eni6kIfPyW2bxeHxhynIQ5aGz3
         SclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775042616; x=1775647416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wLwW3RwfZlMNchucl4Q1BjkgKkbbVmuqcbZXsSlons=;
        b=atGhSJagHh5AwAT3y3xVFxyInrysls0C0HR62NOxXlFtMqFOZmul13lmuhv04frZ2u
         Tm/7AV0TBBOGZC337m/GGDrFddERtBikxl443TDTxeKcn0JRXESq3JU6VlMSBgXLkQvs
         NM09rvfwSnQrj14xnWXAoTQ3G3VKd2kb2PhccNE2JKEReskFzydOEN69bdFNq1zKbYl4
         OjVO8PZiMJaDnNPlHv46n7i2hmvNgPqJf44fct7RKvdHWBtkGLo+xQ1GMRxjPa9b1Ms5
         xQVbZwntDmFv487vbAAkVsxhupZi+dekYxhGQOz6w0MrwZqmYVPeM9TwcR343F+4RHwI
         AUIw==
X-Forwarded-Encrypted: i=1; AJvYcCWS5HaDN0czRtnbEyTmkoJ+IqaQOzyOVSZ/ixn9NBXl1+ljbxAJdCblXL99wSIe/DBqEOD/r7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHV69tCVzHNGp0w3j3aW3ZgCkK1rKuKAgtHRIMBb6jclQ1kWSF
	98lFD9GrkgIuOEvoPKWUR5WiuH+uQA/9Law3r03c0wVMHqflnVzD5FUzQWCumc8idg==
X-Gm-Gg: ATEYQzxbnRz3i4SL9uHva83L2UP8+Nhsyb3CuedHjqEwFmPsH04r6EFLZjc1AcUNNMC
	W1e9xdCDsAntVnm9+qKxvoB5FdJvgz/yHSoEz5SDCslx+yQK305zrvP2DoDBmFoZWQVJWHFUcde
	nshYpT6sqHLXizxPUzpD8QxnGb5Zgrlxfum8d6FncTKH7ZyPetJmWq2rn2zYoKL8erBp2IGt6CZ
	WF6QsRCJn824BmrW7lXY3HYkvtFNndjPhynvjjXApAT7N0NbvXRiYqMiPUH8bPixjC+FogIZfDd
	zD870hjxJ4XvugYf40euXLt/t8Yn/L8x/fY86cC87z8Rqyn0c4arXsmpzeMFkgoK/Yn9QLLHwAn
	GlefUesk9rSY6Mp7J/ya5QE9F5GgAZsAMOuSwWFcNlL/vDv/yUK0i/tV3z/omZkYgJSdEW47HMN
	e4WCCG+kRI6uEC+GXR7Sq7f3CPQVp3GIhCOsgX8o733/w6t1Ng8K6EMn+enw==
X-Received: by 2002:a17:902:ccca:b0:2ae:44db:570c with SMTP id d9443c01a7336-2b26b2b089amr2189835ad.12.1775042615401;
        Wed, 01 Apr 2026 04:23:35 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe606dd2sm6533691a91.3.2026.04.01.04.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:23:34 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:23:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>, iommu@lists.linux.dev,
	Janne Grunau <j@jannau.net>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Neal Gompa <neal@gompa.dev>, Orson Zhai <orsonzhai@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel@sholland.org>, Sven Peter <sven@kernel.org>,
	virtualization@lists.linux.dev, Chen-Yu Tsai <wens@kernel.org>,
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Jon Hunter <jonathanh@nvidia.com>, patches@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH] iommu: Always fill in gather when unmapping
Message-ID: <ac0AKyvHMYHlqL5i@google.com>
References: <0-v1-664d3acaabb9+78b-iommu_gather_always_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-664d3acaabb9+78b-iommu_gather_always_jgg@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ghiti.fr,collabora.com,eecs.berkeley.edu,lists.linux.dev,linux.alibaba.com,jannau.net,gmail.com,8bytes.org,kernel.org,lists.infradead.org,gompa.dev,dabbelt.com,sholland.org,mediatek.com,linux.intel.com,amd.com,nvidia.com,arm.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232760-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 5469B3799A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:56:22PM -0300, Jason Gunthorpe wrote:
> The fixed commit assumed that the gather would always be populated if
> an iotlb_sync was required.
> 
> arm-smmu-v3, amd, VT-d, riscv, s390, mtk all use information from the
> gather during their iotlb_sync() and this approach works for them.
> 
> However, arm-smmu, qcom_iommu, ipmmu-vmsa, sun50i, sprd, virtio,
> apple-dart all ignore the gather during their iotlb_sync(). They
> mostly issue a full flush.
> 
> Unfortunately the latter set of drivers often don't bother to add
> anything to the gather since they don't intend on using it. Since the
> core code now blocks gathers that were never filled, this caused those
> drivers to stop getting their iotlb_sync() calls and breaks them.
> 
> Since it is impossible to tell the difference between gathers that are
> empty because there is nothing to do and gathers that are empty
> because they are not used, fill in the gathers for the missing cases.
> 

I believe the problem is a fundamental disagreement between the core
layer and these drivers. The core assumes an empty gather means there
is no work to do, while these drivers expect a sync regardless. With
this, it seems we're forcing the drivers to lie to the core by 
populating a gather they don't actually use just to trigger the sync.

I was wondering if, as a longer-term direction, having an explicit flag
for these drivers to indicate they always require a sync would be a
cleaner way to handle this than the trivial population?

Just a thought, not a hard disagreement with the current approach..

> io-pgtable might have intended to allow the driver to choose between
> gather or immediate flush because it passed gather to
> ops->tlb_add_page(), however no driver does anything with it.
> 
> mtk uses io-pgtable-arm-v7s but added the range to the gather in the
> unmap callback. Move this into the io-pgtable-arm unmap itself. That
> will fix all the armv7 using drivers (arm-smmu, qcom_iommu,
> ipmmu-vmsa).
> 
> arm-smmu uses both ARM_V7S and ARM LPAE formats. The LPAE formats
> already have the gather population because SMMUv3 requires it, so it
> becomes consistent.
> 
> Add a trivial gather population to io-pgtable-dart.
> 
> Add trivial populations to sprd, sun50i and virtio-iommu in their
> unmap functions.
> 
> Fixes: 90c5def10bea ("iommu: Do not call drivers for empty gathers")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/r/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/io-pgtable-arm.c  | 4 +++-
>  drivers/iommu/io-pgtable-dart.c | 3 +++
>  drivers/iommu/mtk_iommu.c       | 1 -
>  drivers/iommu/sprd-iommu.c      | 1 +
>  drivers/iommu/sun50i-iommu.c    | 1 +
>  drivers/iommu/virtio-iommu.c    | 2 ++
>  6 files changed, 10 insertions(+), 2 deletions(-)
>

Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

