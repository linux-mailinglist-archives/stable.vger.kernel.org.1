Return-Path: <stable+bounces-180541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DDEB853AB
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BB15608AF
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E930EF80;
	Thu, 18 Sep 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ak/ryp8V"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAC19F121
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205061; cv=none; b=KH4tT9wRgxx57X+D1Idgz0NnP1jI2SV+0nYH6/nSLu+BgaA1iaoLGYuis+hOldLWwSWgx/Y15OGsP1IqWpFUW6IXZCN9r9Q7HhjwAIKIhPJPZm6WVO31pa0XTEd986FGHEN37vJYSyhREeshfzS8ABXGPJkIh67y/8FUiT8E8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205061; c=relaxed/simple;
	bh=oBrHOy3u1qRTaEr6O66akdLOdzotS9PWV5TdeiiBhnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5RETVZWuxvocW0zOeKlvHh47uf35LYkYoFCngiMTmEJB9hIXxxueN8jEWxm6Q3DhjgRyyZcrr6fM7gLYXYL7Hpo3lvkCo47+FOoAg2Fs/Q7lCqxXqUD5Pst053U9DjSk0NQG5jp+ksYtBnrDop4aK70wc3d6XVKDTTcdBl2Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ak/ryp8V; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so4796216d6.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758205058; x=1758809858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PlWQvS2VeWY2sKUieX87g6u6W0qtTQRJN790c3dQ9A=;
        b=Ak/ryp8VStXeFSBJzUhGgBLtLIqlkFRGu6+Vf1rezOiw2VjVa+CFpMBHrelb3kHiUl
         F0QhB9oeDA0ZAphKMET0Zz/vY3CYMecGMGzhVADO7mBfzO/qKbNfpcLk0Lg8OXs4PAVM
         rzJkAwg/YsxdJbuxkbDgtxUj0Fs7C6UdBbMYgCVQgK5gHJ/SVUkKdq7aJN67yLzwGUqa
         pNiFWblEN/UhnlfZPM3bbT0srmmhKXq6EqgfkGYcVJaOWz8wTGILvWSZYMwN4zennHsS
         lrx9njiEdAYnA0/lviBmsL5bdwVoQ1nfp6+09Zmn4WZI71lCHSZ1nphlQnd/Q+qprBLb
         sS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205058; x=1758809858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PlWQvS2VeWY2sKUieX87g6u6W0qtTQRJN790c3dQ9A=;
        b=Vp79iv95zJtUjd3qMfpg6KT6ZsodDOUQ26uN6BWUNKADeHAi9wEchHEAUNZFQWr8bv
         fUcG1FlLTPxNNgEWAWr5K7NwJKXZrENVdGAoIKdbe6pPB5R3YhzYdlg3upGyjYr8qIVY
         YYzBoCQegf28S8ldXX7OCpxCyAXzZvZApem5zYUpvF01LbaMn+yXzgejxgSjSG9AJ+am
         QcMYx6fZlNQOAfN7//X8jU93TWEKFFPsHoTO/bblDjjTioEPZ9Cex+MilELbLij4o27l
         zDr2ohDd4g0fx3we0MtHYeyqSXXctbmv20Ae2zcAr9nkL6ERKFYwEuj7l+FnxtE1knEC
         2SHw==
X-Forwarded-Encrypted: i=1; AJvYcCXPqJeMuvgl83Ss8yVIuIWEEFdDiKxdPEjayq3N1g4Ts5iJjWTQEMiNLBndwCgfNm2BRQV30g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVDvxIx4WX8j2ugzdZ75dMueJHB/iYLWV80E20V+EENUMZvbB
	G4/11A/eUFjRXWLAZsH1A4TdyOVsA1cgi9q9jZxXhclRcsAnP9pdxhXx7UyJmvwymB4=
X-Gm-Gg: ASbGncsYFEZo4IoQOoHB2CYTx5JpgAw6Ftgkou/OZd3YR3XpqalEkz2SckUK8jOpYlK
	IfSoTmeATo1x5MOGp+LDD34fiatrfdaoZDHNmCFqp60UvYPhOtiLcbdvXK8iPGYfgZSa38divDS
	r0LimhdsDtoygwOtUsgMJSYp+uIyDv+bINElqMXbQm9rxzXoR8Ua8qUOSNVzCCxKbe7tE2LAztf
	l3Vho9bxY7R3O1cORCAxieKY00+u2QNmyKjrUEUxdd6u6W0qDV8WeKS+auDNo3+LMteEW5Dkzct
	YhC5FKfWLQcpCGPBOoeQEx7hMyTeauKQIxYuhHbQPVYtrphgZgwqdbHAzsPTQidM5eEFAYdPggG
	3YujFuvxBGHSYuOPizzciPIV80F4zuQte54MqYIDwz5ZkPcq4+Nd0TJiG/wMhJclhAucMNAzpj+
	FhjrgHJKD3qfu0eReUzK0D4g==
X-Google-Smtp-Source: AGHT+IGdtgO3co+AzjVg14mLustilnQBnl2mxoBu2Ha/Mk2Otj53RF7QzncRloXmzkssBqEVBSBo2A==
X-Received: by 2002:ad4:5de4:0:b0:733:74d3:5fda with SMTP id 6a1803df08f44-78eccef286dmr69174246d6.28.1758205058082;
        Thu, 18 Sep 2025 07:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793443cfee2sm13588626d6.13.2025.09.18.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:17:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzFS5-00000008w2b-0Rq1;
	Thu, 18 Sep 2025 11:17:37 -0300
Date: Thu, 18 Sep 2025 11:17:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
Message-ID: <20250918141737.GP1326709@ziepe.ca>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911121416.633216-1-vasant.hegde@amd.com>

On Thu, Sep 11, 2025 at 12:14:15PM +0000, Vasant Hegde wrote:

> The IOMMU IOVA allocator initially starts with 32-bit address and onces its
> exhuasted it switches to 64-bit address (max address is determined based
> on IOMMU and device DMA capability). To support larger IOVA, AMD IOMMU
> driver increases page table level.

Is this the case? I thought I saw something that the allocator is
starting from high addresses?
 
> But in unmap path (iommu_v1_unmap_pages()), fetch_pte() reads
> pgtable->[root/mode] without lock. So its possible that in exteme corner case,
> when increase_address_space() is updating pgtable->[root/mode], fetch_pte()
> reads wrong page table level (pgtable->mode). It does compare the value with
> level encoded in page table and returns NULL. This will result is
> iommu_unmap ops to fail and upper layer may retry/log WARN_ON.

Yep, definately a bug, I spotted it already and fixed it in iommupt,
you can read about it here:

https://lore.kernel.org/linux-iommu/13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com/

> CPU 0                                         CPU 1
> ------                                       ------
> map pages                                    unmap pages
> alloc_pte() -> increase_address_space()      iommu_v1_unmap_pages() -> fetch_pte()
>   pgtable->root = pte (new root value)
>                                              READ pgtable->[mode/root]
> 					       Reads new root, old mode
>   Updates mode (pgtable->mode += 1)

This doesn't solve the whole problem, yes reading the two values
coherently is important but we must also serialize parallel map such
that map only returns if the IOMMU is actually programmed with the new
roots.

I don't see that in this fix.

IMHO unless someone is actually hitting this I'd leave it and focus on
merging iomupt which fully fixes this without adding any locks to the
fast path.

Jason

