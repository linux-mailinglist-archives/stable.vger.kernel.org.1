Return-Path: <stable+bounces-246983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAlSLfi4BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:46:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACAC53843C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2B02300D351
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A604DC55B;
	Wed, 13 May 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COEkVT8q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E424DC553
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694389; cv=none; b=rp/EAlmW96/HnH0ixY20mwX6DPosQieSRjnuk+bw68CcSFUy/UaI/yGWYAsm1M10MNxYRqFA2u5/q8b5W8YpMfUjA4/Tq5rP1HHELGsq06CEYBVUMBAQ09Td1Qu/gAkGPWxwiJ9/gLxDQdndLFcpd+gghaGKOoUZ65VuULb99hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694389; c=relaxed/simple;
	bh=RJSvlSo8b3eU3kArKQ0tDZIFebTEAfI2/bt/cNgtTGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ8n8a6KmPUbsmNN5AH/lN+WEy/qYx0rpexSp73a2exDd9aPo3VgxvYm4tJbvZhefXq3/RPBmXSbwO0MJILVcfoY78IyWNYfV26GIrYtkD3rO1YflupxBAz+lZ+pTF89MDOKyRjSScyfhesF0PRe+9kJMGAECmM0XVceKGnoX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COEkVT8q; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-132cccd3d77so778c88.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694388; x=1779299188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeNgdwwD024w74BNPer9lil+jH8BVZwrPlFbFGxZTFc=;
        b=COEkVT8quN9YkxH2x2OxA2kFCkJxbVYDKRaEnaEw0yg6odEePzLO/fmbR23wz6c5LX
         GUErnZIKbOyO73cSgW7SeSNWk63vaj6guixVJw9bHVU7YzBcHBWQ1jbUuT/satrawfc3
         pCGJSdZ7VPOpq+/O3xIRUKJOWydaphlnWhj996xAm96k6KBHNs/kTGunZLgUR61LwVaS
         UC72h2gfoYNAkQMKSA7+ri/n6SF+y3+kh3oag837u7w/txcT1aTDG23X/70FXSbJGrIq
         K49jVqpxdAmrkJT0ykyyqsEmhMLEFgP9qQBfIL9Sa4GczUc6Mn955g1Q/o+8WKXM1i5S
         jyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694388; x=1779299188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeNgdwwD024w74BNPer9lil+jH8BVZwrPlFbFGxZTFc=;
        b=klo5quTM02vVfMfKQV7bO4E5TanqOPeoLe3fQowUeZ9oFAzsqcnqSDNk1/HWV5AK36
         XfRTsKEI+qfuYK0vuidPGEtoAq33gwqOlXz3gWbG/QBAI4OQG8MUj/Mj4N7S52UUe1lf
         WdDsVMaRgpkXIz6nmhWYvOVpjaTywQoLK/HgAo5ZjwoY7/OfqXmlrz/WTu5jRIkfZoFc
         tSnseurYNtoj5KIVYC/P3EGRTQl02+RYF7U8LT9YnPcemhTM5qmpP6rWCqzbTo1fpkyb
         I6ZTc8I0Qin3mpbIyLKg1tZSofqyHLi7cjrJwfxFsNbKtGyf+QyMxTb51cVE+LsrcHv0
         KBDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jgopmzH9U1sOF8ngn4SpBySxhSdvkBvxaU9wf5Fn2jxDJG92E3tpTbTCSsuVjHjANpKSKEXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd85bEST4vUkMODw6ufvh9oTXHJK8zmV2tVCV82Y6qqriAxAKS
	xDbNqqa38o0jEOECbbjeOjDpjqVyXg1RVGjmmNNMKYc0ZZ5Yvm1ue5CwLmL+z+FraA==
X-Gm-Gg: Acq92OHriIxngTVvPoICJdPd0Mpzs27DMLEk4+AbYc5vY4/ArefvXF3lX93ytXI9zIZ
	ONEXE6mQR3DtIfD2k27N4FqQ7W6pH2akNV57FL4jShl1r/N1hiL9c9ZTCq/jYGzmSClL2Y68qRm
	2On6Fb4RDWhL/gUF9iUjKXwB1cXW7WKe2KLm9gGGdJBojWo1X3XV5nVKblzncHls5y9hWlIywkE
	aMy8Y68/KKr6g8J1ZKsQIonz5bKh58ejiJhvKcqq+NN8cGVIOjawLaYXnwQZuyBxmxf5VyTeP29
	4nN5LjXRV/Dkb6JFfO2NKKvroWvnCPlP7uHhHo7j7m7UMtjhovtS/TsvxpFIZfYVK4+cuAv6O+v
	l9OrFBeKCHZVFnZ+EKikSj/QP8rzXHD8Ah4QHcxLad2xhb3NEyGqU4uY/rn2n2bCbANw6R6jBCy
	/H6F0EsDaC+U+ymHM48WqH1wRNCnTZvjzN/BFt50mhaU2m/U6Grq/U6UX6wEj8ZWw6MJh/yg==
X-Received: by 2002:a05:7022:69a5:b0:12c:8f55:cd0d with SMTP id a92af1059eb24-134cb46941fmr20666c88.8.1778694386986;
        Wed, 13 May 2026 10:46:26 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm29059095eec.4.2026.05.13.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:46:26 -0700 (PDT)
Date: Wed, 13 May 2026 17:46:22 +0000
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
Message-ID: <agS04F8UmZwWZNao@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 5ACAC53843C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246983-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
>Sashiko pointed out that the driver could drop PAGE_SIZE from the
>pgsize_bitmap. That is technically allowed but nothing does it, and
>such an iommu_domain would not be used with the DMA API today.
>
>Still, it is against the design and it is trivial to fix up. Lift
>the PT_WARN_ON to the if branch and just skip the fast path.
>
>Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>index 19b6daf88f2ab1..4877b05291c9d4 100644
>--- a/drivers/iommu/generic_pt/iommu_pt.h
>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>@@ -920,8 +920,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
> 		return ret;
>
> 	/* Calculate target page size and level for the leaves */
>-	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
>-		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
>+	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
>+		likely(pgsize_bitmap & PAGE_SIZE)) {
> 		if (log2_mod(iova | paddr, PAGE_SHIFT))
> 			return -ENXIO;
> 		map.leaf_pgsize_lg2 = PAGE_SHIFT;
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

