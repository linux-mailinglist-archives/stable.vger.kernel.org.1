Return-Path: <stable+bounces-152574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC82AD797C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 19:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4163B1F12
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB352BE7DB;
	Thu, 12 Jun 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h2k6C843"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2A2BE7AB
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751185; cv=none; b=aVaBCUQuzjuGIU0c0uXO/3P8AXrLDHX5F+jE+Th7AXiFTKT16kHajuu7EQkAnvIVtxMn/FF6uJoZvhHANHfIsZkzIAROE8GYiSxOju9dbd8rDXzlS5Vpb0tdGk8VCHJRWs8l+SqN79dfoOqgQK7j7RIn9SgqRZaa4Qqal6vMOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751185; c=relaxed/simple;
	bh=/KcpP3sd6NE+ea6NDiYmJmS5AFVotPbnqQ+fVjozi/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8/OLORwVrYcFgS/dvWigpX4bzvEK2Wn+6x8rKPUj4NMjpmm9RgXDCony45z9b2H1Cu/ZSqWX8YBq+7hlBobVHget5oCCvsjZXCH+3K7VhNDIvYZQaH2sedGkIlGHb9a7FgyMPKrdPtodKxtL8r+mJoGj142hhvae9xb1BncGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h2k6C843; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso13620126d6.2
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749751182; x=1750355982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXTM+CkzUjCCaEkCj05xO9AKr6j3JG1MebSjEIdnf+8=;
        b=h2k6C843agjUUgv1Q/R2zJPTAsW6UcO/gZjV90884j3oQ2uUnDBCygC+t+9BqY9VU1
         x5Bd1PFBMpjKL9/zoLqAElwmSqRcRSCTpq8wiYicbqYaKd3UAI/zI23PKtcUEzjAH3g/
         4Tebv6cx07Up2YbEm6A97MEQvuvn7GLnLttOm8HTjVSXVh06VsimxJYSGlzgH3kTHvTO
         mzGgkbGPjUcbDZddOYdjy0KUUENqZaPg+FiJ+ija6NJ9MMejzRIDO5f+Eq0K3rF6+/7g
         xLvF6iZWkuWax2TYklmVU49HMSVzcqzIr3c48DbZGEM//zYxk6n0C/UDASe2mP55yWhE
         BRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749751182; x=1750355982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXTM+CkzUjCCaEkCj05xO9AKr6j3JG1MebSjEIdnf+8=;
        b=s92ceaXFeu0k5cJQNenPZCf5Zfk5J+T/Vv3KxusQ1acR4VEOBzL8vQK17eOSIdVf8D
         +zvA5dcItytfyIfJ25TOaIiX1vGzmVW11c+qSkPe1WJl115taya2ENu5wjCwqjc5sEKs
         c/si6DPHpoKXPRiYSRoF17hCF0cci69disPM0IX5yEcOkoZ+Jkhk8M+6ghi4gkrGIm2e
         wBaKSv2kdpjeMS84uBhMzIKQjeMohrdRbCZsnn8Sn9Bp5DcN2bOo1a1dG/K+7n4C3AWD
         Rllzw8HGiT6j/pWo/xDnl6wQ2rp08q1hD4wF4GTYcJi7INb4hUza9TqfiajArRZw84bq
         3bjw==
X-Forwarded-Encrypted: i=1; AJvYcCWB3UIBsxIGlpprk0YpV9T/taLJHv7F4KTAjVYELiusjw+T791V9uFoQ3CMuBmP9L9e257OdQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqojgof9LwqWa+4oZr1L4p6d73iAI1ye/sy4div7CvID2MGKsF
	p23h6int95LaFWQv7qwIwLKtkPTseQ1FAA5hCY2yrTKj8W0apzzdpC2caqoypc8CGEo=
X-Gm-Gg: ASbGncthukBGwbttmgdVGuhUI2Z4k2oGaPIsNQWJ5L3W6FNZjw824Gz1tu9sef2d7PX
	OkbQCXaXMcrToHQWciuUymbGcmDbgKOuOU+8X0vJnx51De0pgaox9IrTeBrIrtozvdp7zW1jEt5
	4Ag+EyqibcfNPJJAEM0V2RBkeWTICY0BYQwqi91RKW+Z66PUYqVBcGwyLUzyKvgvDjObTdwxC18
	Oj6DqM1ATiU9LMRDyIlByFE7Leb8IpLyRf7fj1c71GCLtcSIEWefBzExt3UCBeaw0GU5Hds9I8u
	vp+W1cA77foi9ccz0z3cfjQl/1mrAF1onh1qrw6oKZipwTR7i0RvCjvUs8FGoknhiuDocQaidVA
	6dDfNSg0V7o8w295pCd0nskW60zr1ugsDh/k1YA==
X-Google-Smtp-Source: AGHT+IEsvSci92g9GrvFGh5NfCjtusJYIMdN3N/cEr2P+xXcnfBxDJAll2rQe2ppsiqe5qWlDpXtYA==
X-Received: by 2002:a05:6214:224e:b0:6f8:a978:d46 with SMTP id 6a1803df08f44-6fb2c334737mr142643026d6.19.1749751181973;
        Thu, 12 Jun 2025 10:59:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b2f9c4sm12808026d6.26.2025.06.12.10.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:59:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uPmDE-00000004kef-3k63;
	Thu, 12 Jun 2025 14:59:40 -0300
Date: Thu, 12 Jun 2025 14:59:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/huge_memory: don't ignore queried cachemode in
 vmf_insert_pfn_pud()
Message-ID: <20250612175940.GA1130869@ziepe.ca>
References: <20250611120654.545963-1-david@redhat.com>
 <20250611120654.545963-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611120654.545963-2-david@redhat.com>

On Wed, Jun 11, 2025 at 02:06:52PM +0200, David Hildenbrand wrote:
> We setup the cache mode but ... don't forward the updated pgprot to
> insert_pfn_pud().
> 
> Only a problem on x86-64 PAT when mapping PFNs using PUDs that
> require a special cachemode.
> 
> Fix it by using the proper pgprot where the cachemode was setup.
> 
> Identified by code inspection.
> 
> Fixes: 7b806d229ef1 ("mm: remove vmf_insert_pfn_xxx_prot() for huge page-table entries")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

