Return-Path: <stable+bounces-60396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6087D9337B5
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 09:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912301C223A3
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC971BF37;
	Wed, 17 Jul 2024 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PxRs7jWb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667971CFA9
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200758; cv=none; b=QVrhkqvfvj4iX9ROQ98RQbMVpMAsGS19Lq+FoGJG5/v8tXMqGmVHvSEeH5eij64z381bEmVdovXLFM0Eh+bOmTh4w7mXNn2YdSIxusauXw4zsAmVUUywqKxVQejPoNEN9/z3HrUNzbSTkFwZfEEpHyoEAGTk+mKIXyI141InQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200758; c=relaxed/simple;
	bh=14a3EXAYx3n2AP13QV1T3S3XN5vJQPlb//kGSBxKTV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCoSCBjd7x04AKlG5kUKNTseOCP5oBY3JcBZaX1J0Ofde+6KF5QXfEM7KBhKzRF9em7Bu0z4D7ZNBzGW/3naS4Rnz2eVYtj3fnlFcM0qdZu7RcCDlpIVWAq+qnW0U7IkajhFOW3fOoV+wPR/JudQQqVWFtCUIoWtV1Iu8HT2QwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PxRs7jWb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77c1658c68so673551666b.0
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721200754; x=1721805554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArgSkToA2nsjWvuTjSuyJoQaI0tJr7zvtfDgU/aUVoY=;
        b=PxRs7jWbnOBywrRY+e752krtFT84TzIs8w/QBRfO6YgqtDgPU4b15aE2iiMWFvsiWr
         1gLk2Er1i8zHDPqbR1G/l+bkez7d4+VXFhX/EAU5zH2IozG8j7EguTun8KJkQP2j2cHh
         Qc4+Hdled9Oyv7V06h3nIdPC07suwas7zEybMupm27XlLUKJ4Z4DcGLCW07+JD2UdxUs
         p0zjN4JtqZFyiaW2yaLGOVfuR2KSTlozROS3T10VhYeC4vBNBr2583jowAOHbo+Ohesh
         DHNI4aUKfMPYy9mSU9FVMXvT6TUAPNL7L3yFL7p7Dsg0X/7AGMAofdGESZ9dxlDlXjrL
         UU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721200754; x=1721805554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArgSkToA2nsjWvuTjSuyJoQaI0tJr7zvtfDgU/aUVoY=;
        b=K6re1rluDkampYkRMN+MFc6a/vJjPT8eM26Qi6lcfllgWJqgpdY0Q1I2OTrhOm4HN8
         kHl4x4JHMfGX0bUzo6Eq7yQuL+IgA5gZ2yHy27xR7yAnkAZ8RfrhRHVNjADvdzJkDq/Q
         rqgiKlPCtS+a2Vw9GPpKtyks02O+YxfcNN1PfXQVL88zrs5b65BWdjK/XB5yh5iFiUJz
         /dg9/OjIPbwtWWux7Q5qC67T4sIzLCA0NBJb6i+ZY9XzDNHT+NEpumXXEhGqj6bCWf1I
         4iVjF0hO9iSEiLgKLXkDqsQLF4IZ4mXpd0upCL7u3txh0ZbByJN5/1IGhM1WtuCtLmYS
         wzSA==
X-Forwarded-Encrypted: i=1; AJvYcCUCzuYCeGFpGWocFPafVZ39VIGYOXa1zedZhGf1j9LXUsve0YhSblwX+F7dd6x489O6/GJf3HamhXhDEMJY6/mB4tJmW7om
X-Gm-Message-State: AOJu0YxGs2pG7mBTnMY3lsFOlW6G7pGNUCji876V4fCHBRHgxA4HjHvo
	gp0nzYCCCmtmLEPyRYc8hLoGs/BQv0ktDfgSObrFkXR9WrERnyhK4PkQ4gSaY5U=
X-Google-Smtp-Source: AGHT+IEFiz1UoJ1wRFUr8yrOzP0AGE8hgSRnejnhyVKNJBJmgOedBuq6BWNoanv2GWM0dmVqE7bphw==
X-Received: by 2002:a17:906:2b4b:b0:a77:cca9:b21c with SMTP id a640c23a62f3a-a7a011a1220mr45969466b.34.1721200753714;
        Wed, 17 Jul 2024 00:19:13 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1e04sm413330566b.127.2024.07.17.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:19:13 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:19:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jianxiong Gao <jxgao@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <ZpdwcOv9WiILZNvz@tiehlicka>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>

On Tue 16-07-24 16:00:13, Kirill A. Shutemov wrote:
> Unaccepted memory is considered unusable free memory, which is not
> counted as free on the zone watermark check. This causes
> get_page_from_freelist() to accept more memory to hit the high
> watermark, but it creates problems in the reclaim path.
> 
> The reclaim path encounters a failed zone watermark check and attempts
> to reclaim memory. This is usually successful, but if there is little or
> no reclaimable memory, it can result in endless reclaim with little to
> no progress. This can occur early in the boot process, just after start
> of the init process when the only reclaimable memory is the page cache
> of the init executable and its libraries.

How does this happen when try_to_accept_memory is the first thing to do
when wmark check fails in the allocation path?

Could you describe what was the initial configuration of the system? How
much of the unaccepted memory was there to trigger this?

> To address this issue, teach shrink_node() and shrink_zones() to accept
> memory before attempting to reclaim.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Jianxiong Gao <jxgao@google.com>
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Cc: stable@vger.kernel.org # v6.5+
[...]
>  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
>  	struct lruvec *target_lruvec;
>  	bool reclaimable = false;
>  
> +	/* Try to accept memory before going for reclaim */
> +	if (node_try_to_accept_memory(pgdat, sc)) {
> +		if (!should_continue_reclaim(pgdat, 0, sc))
> +			return;
> +	}
> +

This would need an exemption from the memcg reclaim.

>  	if (lru_gen_enabled() && root_reclaim(sc)) {
>  		lru_gen_shrink_node(pgdat, sc);
>  		return;

-- 
Michal Hocko
SUSE Labs

