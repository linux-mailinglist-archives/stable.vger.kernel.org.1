Return-Path: <stable+bounces-160491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9561AAFCCF1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611311883179
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79532DECC4;
	Tue,  8 Jul 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ob5JnNmL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E82BE7B1
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983593; cv=none; b=hAXWod7aEjod+0U3rKPN38RwwK2tGHJXtL5XizUm+3BnrARU6LCKhwuDKHvYPNXXVNZT/8YaFELs+vMxw6IzkslYAjhDmNubshvFAAJHdNetQawdL05JZ3ICeqX8pHB9dWY7FOZbDAO8SM5TdKCOkq/iOL/D91VQLpc0gjy/xYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983593; c=relaxed/simple;
	bh=BINVLnRgyb20mtAp5cKy1Cm5MJUnIiU9I4ytjoEXwOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPgTg5bi6kIWB7deZBSN3/VZAoVbbZYkb2fXwJ/OETRzN4xmricToIyLsSA6hWguKHnOIuPiu0uf5SX2nBMRIkpShm4xafSVtya6rJX33qhgLy3diGL5lTvmxhgR3bGIF8l0PuGNvxZAJJRPfZwwdTP3FRg6ahLVkkkAE/QySk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ob5JnNmL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d45f5fde50so404809285a.2
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751983591; x=1752588391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi7H4e9g21Nfu25Zqs4l/n2K5Xp4dE24U9jx1txkOqM=;
        b=ob5JnNmL1bALluVuIazMQe61MO0lKCK0TSrKq/hifvHdCUnk0bBVkAsSlcFA8h7Vss
         8cp5RK1FKBxIDpvbxIBcsdeq5c3lXWCcvmzcY0imUtSWWSu+WGCeDD8YfKIT5+K8l2uX
         DXi5s3mCkbUzZa4kcT5sZjIR0tPKloF9KMe7VaDk7dP2fZlqhAeytpF87RN6P+N52Uj5
         OgEXcm7pecPzj3OqXHRgRpGmPWfrTVL5OblT7ngJBNNvx07zRnZ80LP5Nm5mxVZlKFeU
         Bn7EkX7MM8Ui3aNE/qJUNknNNXoWW3py+217mtH/2tdEk4JY+ORuc5VHpiN2jalPexmO
         +MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983591; x=1752588391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi7H4e9g21Nfu25Zqs4l/n2K5Xp4dE24U9jx1txkOqM=;
        b=O3oDz7lFODzmc1QtTF77+jEkAcXSxq4NJ4KyRLAyv3LatHo9y2D42wT4mS9p7Y8+iV
         /+g7sHi/Q2XLDpM7V1NOJzk8mvjaQVDoI9tByZxF0N2xrzqVCS73AGByaWTcdPhrnDtW
         Qvk9RXoPyL8XkzX5A6xmEGhCgFJUeiCq1DIzOY4RiL5e7ecH7dhx1dZzYqXyCEDkAWtV
         Dhm7LSK2NzbiTov5dzzK7KVXt0GkoLvrzmYwwIxUozUL418Ax6edt8ERYgcVWZh22b9t
         9Jg7qV/zDYjiVGp7xYhoTxUMkoI5sGc7CjVerrEdR+kkzVBKMT3aSr6os/f1/Wg25G7N
         yKrA==
X-Forwarded-Encrypted: i=1; AJvYcCUGnntmkFQPShOpKU99AZcaCN8JS2v2xnqNit4XJRf/sOUurSe4LHfcqkgpnVKzeV8dQzhmoqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zoZHzuQUpDOPl4zYpPNy1F8lttFS71k3X9fWVN8D1bQ2BvMw
	hHon/UGQh+2QpLMN5u7atICZTML4cCSJRtJJBTE7QOVcWIjwNhTUJAg9YYEGJ/j1d6o=
X-Gm-Gg: ASbGncuxsuiy6807zQJZxcXW3fh6p+HfN48vfaZoVhuzHo2E5UKgyoDVAtMBXwMruhb
	abass/R6u428Z7tzecA+1xPAAct4l5BqoggGHactyjwr49oFLspHoyYmjxoJgICe28PySfE5xrD
	965QBtBH75aiF+n/D7PWnu4Zk8PQ+hM0nakP/oIsdsYWFZAUv4Hqw6OjiHHrMBKGN+Eit/RdnPU
	XCwfTAGLwkkFZo56hhQfeEYwLXM7f27/sVZhpv/h39gxHopNMCVXl9pucmVf+QBskQpG86s6g0e
	2ShkB7rSL01DtKk9xNpk6JYk+4eOVVAJUWica6lBgdZkJXub42n7QLcdq1DKxl2kr0nVqvagWEd
	4ewI6+yN7u9UTmYg89eCVozGHoaiqvw0X/DOxHA==
X-Google-Smtp-Source: AGHT+IE/cztazeqpYwjRDoFWW5gJZRO8uoDuF7N/tMta0ZaCg/Nk+lDvQEF/OVmMyutYglTV2SlC/w==
X-Received: by 2002:a05:620a:8009:b0:7d0:97b1:bfa with SMTP id af79cd13be357-7da01a8a1e3mr539517585a.8.1751983590756;
        Tue, 08 Jul 2025 07:06:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb67f2sm781455285a.111.2025.07.08.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:06:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uZ8xp-00000006iCd-3LhG;
	Tue, 08 Jul 2025 11:06:29 -0300
Date: Tue, 8 Jul 2025 11:06:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250708140629.GQ904431@ziepe.ca>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <0c6f6b3e-d68d-4deb-963e-6074944afff7@linux.intel.com>
 <20250708122755.GV1410929@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708122755.GV1410929@nvidia.com>

On Tue, Jul 08, 2025 at 09:27:55AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 08, 2025 at 01:42:53PM +0800, Baolu Lu wrote:
> > > +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> > > +{
> > > +	struct iommu_mm_data *iommu_mm;
> > > +
> > > +	might_sleep();
> > 
> > Yi Lai <yi1.lai@intel.com> reported an issue here. This interface could
> > potentially be called in a non-sleepable context.
> 
> Oh thats really bad, the notifiers inside the iommu driver are not
> required to be called in a sleepable context either and I don't really
> want to change that requirement.

Actually, I have got confused here with the hmm use of notifiers.

The iommu drivers use arch_invalidate_secondary_tlbs so they are
already in atomic contexts.

So your idea to use a spinlock seems correct.

Jason

