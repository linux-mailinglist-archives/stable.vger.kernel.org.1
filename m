Return-Path: <stable+bounces-109405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8AA1559E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C17188AF98
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FDE1A23B8;
	Fri, 17 Jan 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q4YLbo4k"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664FA1A239F
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134529; cv=none; b=DSltyJFfXhptekoalgUZc/4gaWaoNgxSZR7t9W9XDl1BN7ThyBb/eqYXafR6pzjIZZFy7su5guVMZxHyIGvMSQOtYjrNhmjF5HLQRdSB6uOM6UbNxg1TZ8Q6KLXXzpqUwLKqVXtHD5OaB1S7wgGvLXpoOGyS3sAWjgJ9rb6hI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134529; c=relaxed/simple;
	bh=ch50kTqbrDd4nioi7l4WdUI2b/cPEQrG5hSaj1AwiKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8jXATKWb7f1rxEZTvQxZF59JNK67uwkLXMWuPBsjCVhzf/8lUO+i/HeURFJHBkRm6VaBTKHSnBSSxE23AG6xrSGqHjerzOOjtNZe2FdV3a1tGh1rSSeaicMbmIzqpg2c13VUT+FXQ0QzWg5O+uTYA9Ncx3BkVOuxM2rQ555++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q4YLbo4k; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4678664e22fso22177851cf.2
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737134525; x=1737739325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWqWCCvq4dit7q8wATuPZSt1vsy56MaPXRmal5Pwnng=;
        b=Q4YLbo4kZz1nLM/t//X9aLNIqvprwROt6pq5gIQr7IpUUi9LnfPyjf6k+3Xm/QLgiW
         Hstda+UveOiAEvLvfBfdvkAbEI995nIkuh61QaCuKRoQKcgqWduL7FN8gcERb19Tm77G
         1ZXnGekGVeN1on/c3Pc6CQnCT72o7Z8huTXrBVIqsflgIH8xv25HM52NQGE8EmPEsb5z
         BqIa9JOvIU1LgjvcccfziarlLXiqDy18lCcIuBaNzBHCxbPSGhC7DDXJLC9SnLzdloRH
         wzBtqpA0004hQg98pNWHcBSe2UA35i2NkJibwDs21kEjcIYpHEIoyTPq46eDnnCyqKCh
         MV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134525; x=1737739325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWqWCCvq4dit7q8wATuPZSt1vsy56MaPXRmal5Pwnng=;
        b=n1Vbxf9UUbJwkqbmWdQcdEDz8dfVM8BiPxFbdgkOqGw6V9KCqdsvnQpzBKnhM1wIW+
         Ync1V8SECbo4ATobqUT24WLdrVFYEN4IRiV8c9jHvpI388ZnqMjxAWg3F1c3hlld1bxV
         cphs53A2Q62Zyhqqsck/8zZPk5a7HSoo/xNJ/RsuXjUN5Q4PkV1+eMXuvebC+fvJaBYf
         QxKw+iyxfb5QJ7GnZDlqa9EQ5rPPa8EfJZQIYiFeFwMnLQEk4kxqxtWfzRb7Jl2N9InW
         R9U99Ymbh8R0Gqa96J1m3wNLduHyZ4sXCoKFG6TUtz15OCfFsm5AmHI9+TjcRtSCd17g
         2kAw==
X-Forwarded-Encrypted: i=1; AJvYcCXFA31uud8d+p0BDq56nZBqx4kYG+FpOjwl6/aqBbAvu7WCcaydh32/foZbBBjg18b3XO9/bKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFx01S7f9upEUw5eX9bvRcoxGAshlpWvJV2is9m6Zb0QEWRTqn
	Y0wWLQCz/B2uocYc/lDiM3Umio4hlJO8MMla7TfzN2n5KdTzRg143nDf8+xEmOg=
X-Gm-Gg: ASbGncsb7eSoxn5hV6EyMFR3J/xARqywwJM7M2I6vkq/KTiniB72woumNR0OlC+2CCR
	pIz8jLkJcWDVpsMxQENIOpfPNRyWoguJOQpZL067xwAstqHj2NdurBrV5C3FUMXhi9+nRNOXXxw
	AMFILYk1NItPyQwnPdE9eJPRCBDq3HrGP48JleSmXlwcZ43i/tJqNdPx9ny8k/7KV8Aj3p66GEi
	MrPaa02VUCtWYVS5+btcvwS89J0qJtJpJiL7k8YtXEHluYpZNnE0BLoJqwUXcG3qR9msQflwiJ4
	30bC9HdiuOnFmVURjaYcYnTmJ83RIg==
X-Google-Smtp-Source: AGHT+IEnvvopAuzyNCplmhKG8x3URwahSJDU3h5PkIakjZhO1icASJvI6Z9lh5kjv0X8/rjJ2Q/m1A==
X-Received: by 2002:ac8:7c47:0:b0:467:45b7:c495 with SMTP id d75a77b69052e-46e12a56246mr46152611cf.15.1737134525304;
        Fri, 17 Jan 2025 09:22:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10436f3asm13244941cf.80.2025.01.17.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:22:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tYq2m-000000036J2-15UA;
	Fri, 17 Jan 2025 13:22:04 -0400
Date: Fri, 17 Jan 2025 13:22:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Fix potential memory leak in
 iopf_queue_remove_device()
Message-ID: <20250117172204.GH674319@ziepe.ca>
References: <20250117055800.782462-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117055800.782462-1-baolu.lu@linux.intel.com>

On Fri, Jan 17, 2025 at 01:58:00PM +0800, Lu Baolu wrote:
> The iopf_queue_remove_device() helper removes a device from the per-iommu
> iopf queue when PRI is disabled on the device. It responds to all
> outstanding iopf's with an IOMMU_PAGE_RESP_INVALID code and detaches the
> device from the queue.
> 
> However, it fails to release the group structure that represents a group
> of iopf's awaiting for a response after responding to the hardware. This
> can cause a memory leak if iopf_queue_remove_device() is called with
> pending iopf's.
> 
> Fix it by calling iopf_free_group() after the iopf group is responded.
> 
> Fixes: 199112327135 ("iommu: Track iopf group instead of last fault")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/io-pgfault.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

