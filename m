Return-Path: <stable+bounces-246989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEJVJ2K8BGriNQIAu9opvQ
	(envelope-from <stable+bounces-246989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:01:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF95387FE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F25630237DE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115A41C310;
	Wed, 13 May 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aizmh+6j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C133321B1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695042; cv=none; b=NXBab2nZtXG0+tqvNKmBScruH4hrPQrllaYsG3JPBAVAQOjUjvwY/iiX4iQNPKgen2mi0e0uf1cL9aepKPNJPtvC977TXFnH5wDFBqmx36XAQETyhXllE3klC1MtcsNrEs8i1zF1BDeteGjIs6VadSbpC3uWpcDKRhF9kxStggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695042; c=relaxed/simple;
	bh=QKN3YqFmH0/TeY985PphVsKphrajBj6NCp6nMBNJqi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmSwJsh794PWfeqYEwvUCmC9yRFwNLttdd0iMx3FiYTf9QOOmU4RyGmhxSEu+Lha/d84nMqm/cdgbZusRE+ewijHJvsioXRqJ/sa85qLgJxT8+CTrrC5UIUvRazdukwAp6kRSbrz3OjywzExWQynC/zr/TMCvcNDCYlZlT5hwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aizmh+6j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so285ad.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778695037; x=1779299837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rumaNYmYuf6e0hytuftPfqmK7NdxUKC1PH7+SuVwJzI=;
        b=Aizmh+6jxVDU/j0LkndlpWCUS8MbrUWZocFrPYayFzTN2pJ2cqsH5d72lhX3BTkQGu
         iePoJx66KvbF/mdCn0m11sMn2CHvSvmdZRQ0+aEdCJeF1/iJnWp3kyHO+zlhvVoOeEmo
         mR/xrV9mb/AH8pJiwvtfcFzG4moZ9+hYbL+p8/4j53w5iWQomRpKV12lIj4ZXhSZUdZG
         yV9gLbO5CRYc1EXiSLeMvXew07NBGsd6relyleVKcOObRa8nN5TeGVISzyWDBPx1YiB+
         3Q9IBKvpZMX5ppdJ4K9o/uHTXyV4IvqqCfk0Ok6MvENZkFm/HZIkV/D3EIdKB/kv50oa
         i35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695037; x=1779299837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rumaNYmYuf6e0hytuftPfqmK7NdxUKC1PH7+SuVwJzI=;
        b=bK8sR1+eEaIkBMttsCgWSuL/iGwY4m10mB9SBgEUOwLk9XksZvsbZggCnwaaTDhOHg
         5S7JJLsPQD2EDZwTse7rvI0gij6jKm0sPHYtU0Te87bn9Pf1j+CGqle/6jL8mIcTrHER
         5W/sGaAVV05A+DbvUhkB3ZLVtPH9gsruCBbRVgj3tjfk2X47g+5fw1zAMOj8fUBQn/7U
         9lCbcDLCpx4l5tZLnFM7q+hxuhN3NTsTnO8q/sMii8uo1FFgGVo8vHCZMj8m74Uvj4n5
         BqbNalQ6RjKxg7bJl2x7LzauQyIVLvfIKIqWUDepZ3UfQnnIsCkV07pAAuxlrW0eziRC
         8jag==
X-Forwarded-Encrypted: i=1; AFNElJ8T9xFRlBpkJ+Y0BigeVVNOVneUuWbKKhT/s6m/XTj2Uu8iwTm8LsmQvTrAgWnx2gpKaR16a0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVzXegyNpK1aD9r13MucobJVZKEQj5e+F2wJTw39HOouRzMyZ
	Fkvx46Z/clDTifwFfEIfiQMrPBZoDCVd+bE25aqCvdpUEW1jf19Laof61UADNPtEbw==
X-Gm-Gg: Acq92OELXSXknYc64Up3EWj8Ae5AO0W8YwA3NodGgaNiEjRGxzJ17GUamMUQRkLX1in
	Uj6JJU/RBR5DnqGzICKxcMdzR+oew3zq1F1WYcn3AfxkalVuCyoslTb0J4Y/LP/zxV+/6F4eACu
	RwDixWa6/c3oIwBznJ9MrbdxM2PcF/SHLmYbTj89W6ZnBUgD6P7pYJIEOBw0rgfwOcf74JrQNru
	JNj+hk+uCUhXHMMw5nyBSRFtx5y+7ZBfxf8kjjbIJT/nymJKgd4ZbOiVOnTP2PzCoH8NFf5trtO
	vz3DIhrCbGcl1nocdYax9O7Wv0YzRq+mIR5b3SrIqBYWB1KvoSsMfG4m227qxk4F/9ST6Z6StwL
	1X4HwG6GOdPKt5iUbfL42NTUn28aQp7dYVAvMd7Jpz6tDOhNziUROPfFy/EJhr9zahs9yVEpiUC
	8f0+fkVefCk5+OBIzZPuCZ5XG/M/Zl2VtkhTfImbIvAC+BHdCgBRlwdIHGNeFGEv8qZjAZog==
X-Received: by 2002:a17:902:ef0b:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2bd55ecaa5fmr219545ad.1.1778695036910;
        Wed, 13 May 2026 10:57:16 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e9fd64sm158045275ad.69.2026.05.13.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:57:16 -0700 (PDT)
Date: Wed, 13 May 2026 17:57:13 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <agS6jQII_2PsAuZh@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <agS04F8UmZwWZNao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agS04F8UmZwWZNao@google.com>
X-Rspamd-Queue-Id: 86EF95387FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246989-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 05:46:22PM +0000, Samiullah Khawaja wrote:
>On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
>>Sashiko pointed out that the driver could drop PAGE_SIZE from the
>>pgsize_bitmap. That is technically allowed but nothing does it, and
>>such an iommu_domain would not be used with the DMA API today.
>>
>>Still, it is against the design and it is trivial to fix up. Lift
>>the PT_WARN_ON to the if branch and just skip the fast path.
>>
>>Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
>>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>---
>>drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
>>1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>>index 19b6daf88f2ab1..4877b05291c9d4 100644
>>--- a/drivers/iommu/generic_pt/iommu_pt.h
>>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>>@@ -920,8 +920,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
>>		return ret;
>>
>>	/* Calculate target page size and level for the leaves */
>>-	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
>>-		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
>>+	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
>>+		likely(pgsize_bitmap & PAGE_SIZE)) {
>>		if (log2_mod(iova | paddr, PAGE_SHIFT))
>>			return -ENXIO;

After thought nit:

I wonder if the error handling of iova and paddr alignment should also
be deferred to non-fast path? Basically lift the iova and paddr check
in the parent if?
>>		map.leaf_pgsize_lg2 = PAGE_SHIFT;
>>-- 
>>2.43.0
>>
>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

