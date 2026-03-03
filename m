Return-Path: <stable+bounces-222924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMKVAu8op2nSfAAAu9opvQ
	(envelope-from <stable+bounces-222924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:31:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076BE1F5548
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19AC5300531B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164E351C0C;
	Tue,  3 Mar 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViFXaBa2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377D426EA0
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562664; cv=none; b=Uqxfmic5Nq6zBPajTDHgMDFJUo0VmNm6LrnI2gkhBJlYvpgTwGeXI4pKDkPhieVB/mKXA+2tAqs6usSevnKC4C9rlkAMvLRtieBphShXgrO+cJazMP9TfS7ib0AOSRF+lU9OMtsLLZJhdDjjoQJB9GBl8jt5mNFDVkFoFToAH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562664; c=relaxed/simple;
	bh=sCiUg2lh7iLRhnHcu27aCI5XiBzYr6Wi4NzkifYMdd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+/Ld50HPANZa7TP5Xf1foYGyvTve+/hWNp2fJArPIyDKQZWZZV6IOuhj5jA3pCU3JOh9HvSpL4P479/iSTBSuZP8dPfxpc4uxyWCmej/RExsRIJCb4YfEjzWbUXIJSbQlnuh7GfW8PWJqG4ISrMqRikFg5j3MaTmCF8RB39G6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViFXaBa2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae523d54d2so99345ad.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 10:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772562661; x=1773167461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQzKFsyRhRIrog3eTrUkCLTxvtc/Z0j3oDo/kaQyuvI=;
        b=ViFXaBa20lDVg9WHbLh3H9GO4pApttlTkJ3xuXn/cbs0xj4MNbYN9MtICWqRG5n5IT
         MOZ+Vx8a9oJdB+NFQAeTaLZKy3tZHKI+CeZv0Dgq9qWTTtdTOxR3pF1L2/EdorvWh/oF
         Dk7T6CEXDOD6FG/GkhUYfUH0oF93czrnDjQjjQNy0VbFt8r9oJqX9XOayz4rlOgubzzq
         Qa9gkBeRKpbi+gKXHl59Q8I0l2+6tetpj4dSFZrmMP4xqRQ2YQ/RSJNmJbu8YF53LwEB
         0mIAmzzJgCbUcnB5G5eDv4m2WjY/N29zFLclzX4tUY/7+BlIWouFyedR+8wSa3Z/oCtH
         01dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562661; x=1773167461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQzKFsyRhRIrog3eTrUkCLTxvtc/Z0j3oDo/kaQyuvI=;
        b=oLbS3XB+xxUbSR4P6MXPHWkDA2lIxH9mxJWEe2F9psT1CRYvmNOxzrWgkPirfRy3wi
         oKDWsJgFZcthd4tDT4UM8wocogNKv0Bmkj441NFE7uNDlNpzjWADR3cCCz59ZP0z8a6a
         U8DCZqaNavGAgloPRkPCt/M7nSZg7OaYP6lraY9HID2wS7TndfPobTDoqXmQJbZ6G1nE
         DHiCxKs3gjHjWbbFJlOsOVcnkfRLlR4eggPHx6bHylZ5D97ev4BF+f+0bImGJWUatsn/
         oQ4LfpJ68RVJlkzLeIdZzJm7bFbnz40LgEIKiVeGpQqWxzed/7MlRybikoGnswWRvY9k
         EXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9F+8JE2zw/mCrJJ2LJPZJL1YLBuqFNTXO6kX3J/WwnUHhMOTjzmU87c6JAuvRHoNI3Fehdvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBp62OcVkaZ2pqnKdLOtqgScSbRxTUpgX3hYbKs7Zz3MsUr9EX
	e1fpAYZ5WwtTURhs2t5XV4FErtXoWTYnsu7YJf8Lg92CdDXocHzX8Z6SprSQiEHOBQ==
X-Gm-Gg: ATEYQzynIeFf/qekV6th9LJE0XE0akRcKVloO6DCeapJ2p/Lsa1A3czbIWPB6V9uoIj
	pWytAXaHrsntpOjgirjOn2iemGAw6AXo5vapDfh/oQRq395FiTzKNqeBN2FOwhvT/mQEjerudhe
	WZ4IEmcyhtGAWgfIjnXDkEffsuDMtjJiZNTLhGa9jbJ2ta2NdkaiqjPk7T4+FB62dJWdbGjYcQ1
	NP1m65jdVLElGQ54asGK2nHRsY5Qgb0Fmw6QGy/zCeyw9tPl7th+S3QjjlNTBUSVtFaHzbb8sN9
	RjaEMmlvAJkg+z2BlnSIi0zoYwldG2xZz9vLxkXbf8u9iRjGMeFf+aHkO+WNbRJqqamvsQi7Hsa
	IJUBjhfsLIoEoyoa5/tv+A0/FzI74pXG4UifjxkQXe13qT/6NNsLSiqCnEkq7jf6MmKYjNox/Ze
	EVxvh1rHv087SDG3rNb/7RQx9luBwQkkKoYlSAaPWxmeoNv1CpyF+1X0mC0JI4pw==
X-Received: by 2002:a17:902:d4cd:b0:2ae:4e8e:954e with SMTP id d9443c01a7336-2ae4e8e973dmr4955415ad.5.1772562660023;
        Tue, 03 Mar 2026 10:31:00 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739dabd43sm19660065b3a.25.2026.03.03.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:30:59 -0800 (PST)
Date: Tue, 3 Mar 2026 18:30:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH rc 2/2] iommupt: Fix short gather if the unmap goes into
 a large mapping
Message-ID: <oo4dc27qzpomectrhjyeg3vlshiktejtzppz4vn53q4ufzs2w2@wdl46dnfacv7>
References: <0-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
 <2-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
X-Rspamd-Queue-Id: 076BE1F5548
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222924-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:22:53PM -0400, Jason Gunthorpe wrote:
>unmap has the odd behavior that it can unmap more than requested if the
>ending point lands within the middle of a large or contiguous IOPTE.
>
>In this case the gather should flush everything unmapped which can be
>larger than what was requested to be unmapped. The gather was only
>flushing the range requested to be unmapped, not extending to the extra
>range, resulting in a short invalidation if the caller hits this special
>condition.
>
>This was found by the new invalidation/gather test I am adding in
>preparation for ARMv8. Claude deduced the root cause.
>
>As far as I remember nothing relies on unmapping a large entry, so this is
>likely not a triggerable bug.
>
>Cc: stable@vger.kernel.org
>Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/generic_pt/iommu_pt.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>index 3e33fe64feab22..7e7a6e7abdeed1 100644
>--- a/drivers/iommu/generic_pt/iommu_pt.h
>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>@@ -1057,7 +1057,7 @@ size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long iova,
>
> 	pt_walk_range(&range, __unmap_range, &unmap);
>
>-	gather_range_pages(iotlb_gather, iommu_table, iova, len,
>+	gather_range_pages(iotlb_gather, iommu_table, iova, unmap.unmapped,
> 			   &unmap.free_list);
>
> 	return unmap.unmapped;
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

