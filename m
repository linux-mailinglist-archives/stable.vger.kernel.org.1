Return-Path: <stable+bounces-246975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA0bODW6BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:51:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19166538565
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21707300D575
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E434DC528;
	Wed, 13 May 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fStpyn4i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5274DBD6B
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694252; cv=none; b=mnsOlXu0VZ6SncozFnN5xS/A2hqEckUpZkQj60VnS4lkNVcEkzKkJtCDNTEjQmpASbUAH/3hZeY8nVRwO5OyJ0Lpa8i/5s0NkFvuUulvrueCOtN7zU9yWEfBMSxC1t5yBCrb08RKOFSV3LTTxV2ZARv1mTxIwsMLzNsPttoTUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694252; c=relaxed/simple;
	bh=X+MbUVbMjLu+rlmKpQgI/8QF3Ke6PKRPBaagAPDg3qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=absO3xivwL5DwTVyh3gRpUE+Bygo+TMoepDdoYPXX+4ymGcaTEPs6lkjEBhFlZJFNR1m6x7HtevjacsbOSGow83Zrf6pxsiGR5DxNfOsdqXm/U+BdUzR5uVWBBmSYg3432yz1LHd3ZxZWGbH71MpcQ192g2Tj/5oq5KQhW1vfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fStpyn4i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1285ad.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694251; x=1779299051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4BJ4po9Dvpfk6XI5pkU3ene6W0TLSq/94NAtPnHwHxU=;
        b=fStpyn4iEWLgvJeX9N8kEOFf8w2VKDUjKsK9yJvgQI6y2s9IM9Uxtl4AG5DE27PDyj
         Va/YYVvmqkFnr/xljK7ZAOShrK2195spSmrVS/nMvmD6vXVd7u0d9SmB+iMJGOVe8eT4
         TRqZ6E28wr1lEHNKJIZxhBtcsfQwBxihff6Xc90X6KcdnH/gQl7xb0MKAMo83MMHMM+e
         5Wykdta2HJI+H6K9DyhzyQ+QWR/7rsbkA3yFgimZWPvE9saBrA96jlPaI8pEMWVhtsGD
         8NW+X3rLVaWxE/ADWmUYaRKRlxDb3lL2PSXUdvZtQWKu0bK9uPwUG1bHJ4LLUj0e3cGL
         4rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694251; x=1779299051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BJ4po9Dvpfk6XI5pkU3ene6W0TLSq/94NAtPnHwHxU=;
        b=OnHWUyfY3wcOOAKYFvZI45S1Oj3GknpvYAy6IktgESwJTlMcEjDVrb1bFZHZNa4Ho9
         n0Rw0MdAYtnL+i64jcVdxv+bFiMUp3jutnPEmVz06sF5YuKGiDdZqWxsL0LkJfWD8aHz
         UxHiM2SCGxbSIF4FQ2vYJOE62ITrWqxmTgknhL1ktJ/XcYUeTnGCpgve8ZpmvlIML503
         DsF6g7VZmcRbJBplDjfVlSQoBMhWGPpucPKyWE2A5dN4AsI7hx9IUi/YdQAuB7CWl+ZG
         OtP35Szq55Xtfrq/VX5Ugit/TbjN2uCs7jR3QKNLyNedpSDi0o/y+j5PK8Sx701tyqCI
         HKLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xPpcCmVULBdVw6a2ED1DiQV89rcMkYUEjcEyPzkvXo9ivLFaCqqpI40+dgv/QB4H783nIeCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTY0UiC0pvcupjpKtSCA29iuh+zfwKyx7m7aViVQt2j+gZ8pH
	fDRxS4uNatx/oBzoB0RZk2N2Ia/S0A7R3ULnsE6OFfG3trNU6bbHcF9bYtLXc6yd0g==
X-Gm-Gg: Acq92OF8DNxkHyhwAqO77gQmATpD3VDUgh7VrIZBVingdehnCA4tDt4hLoKjRUS98Gd
	Blg9pl7REbS0Tbc0EWxRmf+wBN7oI7s5JY802MnU/R6t0QmhszWIN6u/C7kBrE4Ddjj7SI70pGv
	G/5lK3H2cxLbASlZu2HzafayVqTsSXkPvnCRsf0ZyobnlyrUf6YNCZIdypzdH6l+qnE3krQ9esy
	NFmEo8VZiJSJAliLij3ck6CXM2WRYHnPBsL6EpZL4H49Bfg1Pt4QTKYHBYHA77qnkr36QP7Ojan
	3NHV3x4vgd7uu2L04ZU7RICI272cCa861rPADSosVU5vw8DK8Qak9C48rQ0u02YRm3C7Xc99TGV
	kE6qOLMh2JnE4ezMUKNnxz8VJD4ictotHiEXWLmJSgL+bh+iknsGlrAz3tBoh+6H72mggwLQLnd
	vyqZpHMPqDTkrMFkvhYX+Zs0xia1bt5gKHyLZOvE2B6kTlnPh8FuRC3rWEKLYCxzeCeRzT
X-Received: by 2002:a17:902:d483:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2bd579828c1mr113055ad.17.1778694250324;
        Wed, 13 May 2026 10:44:10 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267688e2esm15538264a12.8.2026.05.13.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:44:09 -0700 (PDT)
Date: Wed, 13 May 2026 17:44:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 2/5] iommu: Fix up map/unmap debugging for iommupt
 domains
Message-ID: <agS4Y7KDBlU3nR_u@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 19166538565
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
	TAGGED_FROM(0.00)[bounces-246975-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:14PM -0300, Jason Gunthorpe wrote:
> Sashiko noticed a few issues in this path, and a few more were
> found on review. Tidy them up further. These are intertwined
> because the debug code depends on some of the WARN_ONs to function
> right:
> 
> Lift into iommu_map_nosync():
> - The might_sleep_if()
> - 0 pgsize_bitmap WARN_ON
> - Promote the illegal domain->type to a WARN_ON
> - WARN_ON for illegal gfp flags
> 
> Then remove the return 0 since it is now safe to call
> iommu_debug_map().
> 
> Lift into __iommu_unmap():
> - 0 pgsize_bitmap WARN_ON
> - Promote the illegal domain->type to a WARN_ON
> - iommu_debug_unmap_begin()
> 
> This now pairs with the unconditional iommu_debug_map() on the
> mapping side. Thus iommu debugging now works for iommupt along
> with some of the other debugging features.
> 
> Fixes: 99fb8afa16ad ("iommupt: Directly call iommupt's unmap_range()")
> Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks

