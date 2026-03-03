Return-Path: <stable+bounces-222923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A5vH/Yop2nSfAAAu9opvQ
	(envelope-from <stable+bounces-222923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:31:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1D1F5550
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB3D3036744
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD32427AC54;
	Tue,  3 Mar 2026 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLbZ2MuZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94537308F3B
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562632; cv=none; b=pBXhw/ErWGO0C0CNgTT2P77o0siObljtYdGJjJht0zIhk6zqYoUeCh9BygTj/YmSzcjzNtJVjssYinyBzlCLFqCWVHCzJ3WpfvMIqhibrKN7aTsr5OHcNaaxXusrN1BBHVkrDB811K3wsshY57bqcwsovFaAj+0jcaMMlLSoP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562632; c=relaxed/simple;
	bh=XW0MM9Qb0l7ek0D6rjJBMdfOtLG2Js4WUdcnE1GL9zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxu6IabfmFJ60NOonFqDZE7r13Bp8h/n+xAoDL2h3o0r295QfkvRbY9W0n6/VE1CNpLSVorBhqSC5xg6UevvENB/igH5r/oU+mp8fFEzRuFcUWDeh+0YQDdvnfqTT3BP50ccmSpsJ+DaKkFqNMpq9MBBFCag10YNbqiGmSvZKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLbZ2MuZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae523d54d2so99245ad.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 10:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772562631; x=1773167431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZwVdnEFy1OqWo7KkJ5/mQriJgyzWARTRDxGrzurnM4=;
        b=DLbZ2MuZQnF+WMMs+kPTXqZbv2rjcWjjvGquhM8jmLL72U3oHuqkx9S75aojwhxL2N
         cZ+6jFeW26gbDcB5KHU94R/ZFv1dsFTKZ0v6vWCPrNalgeUp35hxwMb1bHI/9F4mGrqT
         Gntbp7xu9bJK+JqFp3ozX3VxkkMhRLe8l3XiUriLeYoZdOXo1y3QDOPCXRKf3Ic9Qd5U
         hZSlv5Tc3OK/YnXlY0++ihdit3n0U30G7FQv944Sr3mqVoe0gwofrXYeUJgWcx4hKfd3
         Ab12FVrh5wF3stfzmB6AHoZdIR9jPKzXM5HYpk92TLOWQbvOAGnWWPqAanq4MKoAjKlZ
         oF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562631; x=1773167431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZwVdnEFy1OqWo7KkJ5/mQriJgyzWARTRDxGrzurnM4=;
        b=fVnHPwcaKHMlhnLpYZ8VwzL4QbTaeGIa19omR356JR3jKylTX1d457N5ETUBss0Fil
         +ZNLFl2qti8AbKx/Hkmfyo5pU042IcpAE9L6qzoy6K+2QRx21Ae8Ov8WY2/v7Bpf+GCX
         fwqughy/Y/RbWxkpsLIDvj7guXyuRAe+BCXpYI7RFQdEnKtVwQhGSyZYg5AeyhFBnt6o
         NJWHwsyfIni7ah/PiM/iIs2QV1a8+nbH4JjNEbgc2BUFFHZqDSBd8HGBjp5VVtpj1Bqp
         NFiLCZzbXPK/U9jLXzyn3D3CgA19XtkIew2vlZx2UIA7BZ++D30CmflpcblKtC+dhC7o
         kxwg==
X-Forwarded-Encrypted: i=1; AJvYcCUxWbkVENBr8UIaKzbMynsZJmQdPD5rMp0EPW6IYvb/QNmVMok/sbxaimyfqleNxyMiNxY0KVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywniq8/AOmK3PgiXle/9UkVimYaimeouztVinBTl5RIBlMwfNNv
	ln6NHy/0Ps6bjjowuVuomh2pDqlSv/RuGWY2ygT3UzkNbAa+5p6JOJIY4duj05L7mQ==
X-Gm-Gg: ATEYQzy5NeJKWkDq6KPzg8vPS8LFvCEAAriK/0FbUMZ8gIWVzpfv4rbGRJkxK3YGH3h
	YjV8XlQO/zlhDfKs/2MTEwLv2afsGFeQkvs7khH+Zhbk8i6znPNxXu8x16M7qtoS7bm6Cu4LvK9
	5mYoEGW9Sk+lLpRyLzH1tc8BGQCMHUIo2mWQmIZhsE+38qYmE6APLk8V0qH33dy4eZnPb80Ner/
	sF8hpTL9pqjPX4UnHk0a8GmCKrDmxkhpdBOHztuK6Fz/XJYbJlD2Q8Kx7cW5s7dG5HnMCuMxmXu
	bz2WBYbFryPSkEd5hGKJ5DZl5MpKPF9USUDM64AduI1+Y1PLti0hlx0uhg7Bx7h1M/4t82RS6SG
	tnTGnbMfOslDyJFInvQbuIWcwgi088Faj3qo/EiJkODRvmNVjMYkkJkkcZ1WiWVSYUtio66pwGG
	7K/ezg2h02kBoYU1TSIHixcywHsv/b1Ycz04W/MA+n9yR5Q/1MnxRPF1SdXO1b7A==
X-Received: by 2002:a17:903:3c23:b0:2a8:fe50:2933 with SMTP id d9443c01a7336-2ae3949de2dmr1433415ad.0.1772562630134;
        Tue, 03 Mar 2026 10:30:30 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599bb43e28sm1884837a91.1.2026.03.03.10.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:30:29 -0800 (PST)
Date: Tue, 3 Mar 2026 18:30:24 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH rc 1/2] iommu: Do not call drivers for empty gathers
Message-ID: <pvnu5d23x6bk5cs6wbf2nf7v4m3ietrgumeq7rn43twsadns5l@pa4jvd62bmgq>
References: <0-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
 <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
X-Rspamd-Queue-Id: EFB1D1F5550
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222923-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:22:52PM -0400, Jason Gunthorpe wrote:
>An empty gather is coded with start=U64_MAX, end=0 and several drivers go
>on to convert that to a size with:
>
> end - start + 1
>
>Which gives 2 for an empty gather. This then causes Weird Stuff to
>happen (for example an UBSAN splat in VT-d) that is hopefully harmless,
>but maybe not.
>
>Prevent drivers from being called right in iommu_iotlb_sync().
>
>Auditing shows that AMD, Intel, Mediatek and RSIC-V drivers all do things
>on these empty gathers.
>
>Further, there are several callers that can trigger empty gathers,
>especially in unusual conditions. For example iommu_map_nosync() will call
>a 0 size unmap on some error paths. Also in VFIO, iommupt and other
>places.
>
>Cc: stable@vger.kernel.org
>Reported-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>Closes: https://lore.kernel.org/r/11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> include/linux/iommu.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>index 54b8b48c762e88..555597b54083cd 100644
>--- a/include/linux/iommu.h
>+++ b/include/linux/iommu.h
>@@ -980,7 +980,8 @@ static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
> static inline void iommu_iotlb_sync(struct iommu_domain *domain,
> 				  struct iommu_iotlb_gather *iotlb_gather)
> {
>-	if (domain->ops->iotlb_sync)
>+	if (domain->ops->iotlb_sync &&
>+	    likely(iotlb_gather->start < iotlb_gather->end))
> 		domain->ops->iotlb_sync(domain, iotlb_gather);
>
> 	iommu_iotlb_gather_init(iotlb_gather);
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

