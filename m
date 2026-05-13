Return-Path: <stable+bounces-246973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFVpKcG6BGrHNQIAu9opvQ
	(envelope-from <stable+bounces-246973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:54:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39B538662
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C5F3155FE3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5480F4DC536;
	Wed, 13 May 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLpdicMO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255744B696
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694153; cv=none; b=jNswCQlu4xXFETLd8Oy+CK9tooy+EBW+IwWIx2v6bjdo7rpoJLQEraG6nB/VqbB2M4/yb5wOWrNoytlUR9RJCVgokAsRB5ErL6NJ/Z9sC006fAwRhcjo/Ua/N74y+/M+u2qFGxdYm6xQmf044ykr83wq2BJFxWqxKqE1Za7du1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694153; c=relaxed/simple;
	bh=Z4DQx2lSeg373FycVPY8LgB/ufohedZhPA83y4EaBOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVSV3OdAE9XF2Bq/K+y2xSaO89KYkO/LEU6KJg7nNVA98SvkNLWAaBKmP7xys3OgRiwY7qoUidKXdIQFcME8WdD81UMjiDu24L2MRQ9yGijF6v1OuUA4SQNmMPXXRh4/ZWxYUyAiO8AneQ3ex6stBudxGpmuWNl3eiND+I0gwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLpdicMO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso2635ad.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694151; x=1779298951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcBA9DAGtJkPWnf5c2GL3hdpA6y9KY9keSOmEQ3FPfc=;
        b=mLpdicMOhlEXHzTsxbDP3HpS7DiNz4dg54JfWXCbp2Ye219WgmyqX0eHBu0eQPMEPa
         FcBy3dV0m0o8/eO3Wg12MCq+P4QbQ5M4kp8QYGQ4cachb2Ho1Iu02ZPUgwUuqw2Pb/LW
         fH4wC7TmcXMFiovT4s6RmfPLnNtzUwqEFC/+mI9gOTCovjiIB+bImfhlAP3N8jk2sBuJ
         7Ol0G0CYevv73TDhcRvupgx+thk3gkM/cF53sb8ERgQRhOAp3kxl18JULR17Wc6m8+Bh
         bolyjPht3en5QCxtOPmoEDsOuExf2C3vSxpSK4sHg3m9Ctod4XGJE4yfZ4tVgAzhOkfc
         niBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694151; x=1779298951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcBA9DAGtJkPWnf5c2GL3hdpA6y9KY9keSOmEQ3FPfc=;
        b=NnbAQRJRdVRUlgmSWH2OvL00JVzTRxP86zwkoddozlkj219yED6FlbCUO8UNPuT0Jq
         ceoIECd2+pg3GxCv//NxD1f1BuF4oFxZTnDkHFHYyfYIiPRZZzfZn3BwicPIArbv5LSw
         Xt6hAn2uV2oISZhfJFi89ykhbTN+lwHOFthkCV07OAsZ6fqYA2npVCQCjgSrOQG0Sh7U
         T2vSt8FArvR9+9EKgddgiLS+MqRDUJ06r+IuzA178Niqc2LAzyp1koKpRIabon8nfTVa
         M2OmN9JRb7ePf46VE9k26qLVc1KZ65bneY7u14Ay45GQhoOQ853mrBWcJhQv8wUMQGwq
         R3bw==
X-Forwarded-Encrypted: i=1; AFNElJ8+mdsUZ8r2gQ5OL9OyNSMa/5Xy2WGsuIQuYdHwPz8D3IL4MoAX08dPc3BZJ2MZIgBVWkd4NV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0loc/vBPGPNHoMBNr+93Hi2gGs57/C4ocPIpL41CutsfjyBp
	JO0gfFWKhs3eWEpZIDTIz0mYIzQU2L+ktnU9M5VU+LATmgRPZJ9THOMkVTruyNYXmw==
X-Gm-Gg: Acq92OEzwM4IwFx+Oqe0QnrvefedqWyiwOm3zdSCmfibPxG/i5v2Mweo0NELUv9GhF/
	YDL5jW8oNHd1h1OMtuF0HNfBoNkCX0AgKypNSRNhzVY22vJmrHUjWBKL6dKnf2Tu3h2D9+8x0nF
	RuLR0r5BdwRTZObSyMsI3471LCA2pUL9120RIMIhYhDpQAGSeUbfh43Jsri5naMSPC0ef6cz3MS
	xNRzm9qlOgIRuta9ZJUYLOodMKL8jBvh+1HpZy/gyGFDG/6ZpEUTYAgbJsmxg5G7yhGg4oZWK1o
	srZV0Ax2s7cNV6RM8WbLhxYQtYSFI8fj+8uiBNfQorEkNsjE4xWJ2okfckYqLmmv82tyBvKcR/6
	20g01mw+D2hJyPS6sSzB5x/lTgUKZfnPQWeTtlxIo8AZ9/6FDnZz53afjVcZZxO0b4551Mq8I/s
	ybMsqEt97Ddbe1ks7srF8eX+kdDi4tYxrPHm7F/c/rnHJ15Rmb+i/47W4wFVZUSov3MClZ
X-Received: by 2002:a17:903:3c2e:b0:2ba:3b89:c3a5 with SMTP id d9443c01a7336-2bd55e46765mr226415ad.12.1778694150405;
        Wed, 13 May 2026 10:42:30 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369224d2f4csm151787a91.0.2026.05.13.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:42:29 -0700 (PDT)
Date: Wed, 13 May 2026 17:42:22 +0000
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
Subject: Re: [PATCH rc 1/5] iommu: Fix loss of errno on map failure for
 classic ops
Message-ID: <agS3_gZOW3AjAAhL@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <1-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 0F39B538662
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246973-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,solid-run.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:13PM -0300, Jason Gunthorpe wrote:
> A typo, likely from a rebase, inverted the condition and caused
> errors to be lost. Fix it to be "if (ret)".
> 
> This was breaking iommu_create_device_direct_mappings() on drivers
> that don't use iommupt and don't fully set up their domain in
> alloc_pages() (i.e., SMMUv2). In this case the first call of
> iommu_create_device_direct_mappings() should fail due to the
> incompletely initialized domain. Since it wrongly returns success,
> the second call to iommu_create_device_direct_mappings() doesn't
> happen and IOMMU_RESV_DIRECT is never set up.
> 
> Cc: stable@vger.kernel.org
> Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
> Reported-by: Josua Mayer <josua@solid-run.com>
> Closes: https://lore.kernel.org/all/321c2e57-6a17-4aef-ba42-d2ebd577e472@solid-run.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

