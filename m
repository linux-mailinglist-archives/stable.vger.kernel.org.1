Return-Path: <stable+bounces-163134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C3B0752D
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C125836C5
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776B2F4302;
	Wed, 16 Jul 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6+rBBYu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB42F0043;
	Wed, 16 Jul 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667050; cv=none; b=RU05maHn3AH4zH1oyPONOC03NmOZl917Umss/5TzJYOKQ+hw6A3Lxyg4vIOqSeA7/urLrqlw+hXjJRnl0izG/WgfOE6fXAETR55zRUuaDlp5G5slm3grCDX0RD0awVwA0ziQuyqGG4sQ8a9ATd8E3v3JII9YkQ5k6oRZbFzyCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667050; c=relaxed/simple;
	bh=ahNvfh6VoJDlKv5Gqc6oO3rXFasM7n3WmOyQr7d6Gm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rb8IKEdJqPwCX8kc++YcwLyv82iadk1zU1mNkrmfKOtGMGkqVOIbXCOMS47Nun2dKhG/pHC5pzo7e4TA+MENlP0Zee135zYsQWdIJWtiBS7VR/MLrh1esUgRDQM6fIv3WVDGJVKMmc1ERFyrl86b+Sm9FioLVLWILrS2B3yf/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6+rBBYu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d7b50815so42549565e9.2;
        Wed, 16 Jul 2025 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752667047; x=1753271847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sus59UsnbuGi6q2O4dZ/OSI0C7+7vrhcajwM1ATb9Ko=;
        b=d6+rBBYufl4mTyf1pcQhLTxUw1UtvpaA5DAwPxY6MHMvzRIMV201FNEDTW7faJfbVF
         p2rf27ibpBOJgctMcpm2tO/zFNaqjkEeE8+PwKiIlb1byF8B8kJIqmU6+YP9zFUQXf4S
         2/ELbvBK77Jd9NRBGTGVliB1jXzMGGVC/5cIk31C7J9DtW96ZsfAAwfXjwqaf6reJbau
         6DbFkd/AKzo4UyyKDFen1SvflsElMEU6OTHJdjzuNuxl1d8v2Ch/1JIM6THjZn/QjTKY
         0DX6+21uOVGRUrkC4uFKwVQwMUm+G43gP3XtPyEAdyWyi8qEGuD7uDwOQDjPVqdYemsr
         zy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667047; x=1753271847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sus59UsnbuGi6q2O4dZ/OSI0C7+7vrhcajwM1ATb9Ko=;
        b=Pk3xLn/lx92b8o0rdJKocVjsWHbNzOWJa+BbweX7l5bGiEoPWaYnELQ3TM788hF/qE
         f9Y6mN+rvp3Rx7HLrLMEGhJ8Mb2jaIMzZ14k1BAUmsJHTw9yezZgoy+a+gWnQC1tFXRM
         Ejw4ggdBXn4vPQvwNdzd8xq5NApLRPhBy2/FeEwkQ4waS1z8VobW4f5nKN7OCxe5mT7l
         OoDbEoz+RHfVUU3YHpus0ZmX/l5aMILFS8ltwRaWBCsT0xWvVRY2UNMzqgqgSXWO5S43
         meX8awTiZxjm7tlQ7RAqKVLUmDtQcDjDyQjUD3+NsseWVGWkY7n5XwO58aJgaa0SwoLI
         OWFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0uda491jc1vjeBf17v1WmElYn5Br69RHPXZHDSvxyiEWAgpM1BiRGHpJXlFH7ZjYDT1gWrYTdV1SEcCw=@vger.kernel.org, AJvYcCXHcM4HwJ94F+8JXQZ3Fugl5elexwX+CMoOCOldKTNcLlCfZzF1qRu+htyRiecvsdX22NMii3lS@vger.kernel.org
X-Gm-Message-State: AOJu0YwueQJjbUmEAzC6zJWM+fmszNN8Tv5ZeWvkzpbSKpwu4y8SkEGJ
	br/vGgJc8BXPjdvTmRUqvswB5ojYTBxO600S362xw8XJSmnpFxtL3r5N
X-Gm-Gg: ASbGnctLlTuaMzgXoMTCXDW6CXpyWkCNE+tD7yMIk/XgKfieS09mL6Zg2PWOkklJxcn
	WjECR/H4SdgXnhi7PrnDT5ly7RDzEbFVSEvWn91EScHfdXtglEHd7+4IQuG0scgNe35PyY0DCaQ
	mPwUGpWuOLn8wCpJ6gHwB2tcaSSF2WsLBvuOULtuMi0pn56GxCy+6sGjbzgmEqOv6mVhoe5FQFw
	iCFLrkw4PnhzSABLedKkvq9XvkVIZFzkF2RFuGaggmdC9i1xl3vHA5mVAMg9e4yHil8hc9JmIVE
	bCyxZohTH9eABGVarF8s8wQxzlkPLrn2kFwKWT6/ZRIWTjbqUq4vLoXRTl7PPr/zKcX8gH9Xrvz
	VwuGS9jVtCOxtx78boiiU/e1cALVvPr4x15xUqDIMCkd5I8/MYWSnZ78opIuu
X-Google-Smtp-Source: AGHT+IEO9Zt2BvzXTefjIV22N0YGVdjcWPFlq7BQGPADENKmKRWYWRGtIPb+nG6tBkrVVWdxVbs8sw==
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr22640315e9.4.1752667046936;
        Wed, 16 Jul 2025 04:57:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm17916359f8f.14.2025.07.16.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:57:26 -0700 (PDT)
Date: Wed, 16 Jul 2025 12:57:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin
 Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Jann Horn
 <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen
 <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>, Uladzislau
 Rezki <urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai"
 <yi1.lai@intel.com>, iommu@lists.linux.dev, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250716125725.37aa3f38@pumpkin>
In-Reply-To: <20250710155319.GK1613633@noisy.programming.kicks-ass.net>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
	<20250710135432.GO1613376@noisy.programming.kicks-ass.net>
	<20250710155319.GK1613633@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 17:53:19 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 10, 2025 at 03:54:32PM +0200, Peter Zijlstra wrote:
> 
> > > @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> > >  	if (ret)
> > >  		goto out_free_domain;
> > >  	domain->users = 1;
> > > -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> > >  
> > > +	if (list_empty(&iommu_mm->sva_domains)) {
> > > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > > +			if (list_empty(&iommu_sva_mms))
> > > +				static_branch_enable(&iommu_sva_present);
> > > +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> > > +		}
> > > +	}
> > > +	list_add(&domain->next, &iommu_mm->sva_domains);
> > >  out:
> > >  	refcount_set(&handle->users, 1);
> > >  	mutex_unlock(&iommu_sva_lock);
> > > @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> > >  		list_del(&domain->next);
> > >  		iommu_domain_free(domain);
> > >  	}
> > > +
> > > +	if (list_empty(&iommu_mm->sva_domains)) {
> > > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > > +			list_del(&iommu_mm->mm_list_elm);
> > > +			if (list_empty(&iommu_sva_mms))
> > > +				static_branch_disable(&iommu_sva_present);
> > > +		}
> > > +	}
> > > +
> > >  	mutex_unlock(&iommu_sva_lock);
> > >  	kfree(handle);
> > >  }  
> > 
> > This seems an odd coding style choice; why the extra unneeded
> > indentation? That is, what's wrong with:
> > 
> > 	if (list_empty()) {
> > 		guard(spinlock_irqsave)(&iommu_mms_lock);
> > 		list_del();
> > 		if (list_empty()
> > 			static_branch_disable();
> > 	}  
> 
> Well, for one, you can't do static_branch_{en,dis}able() from atomic
> context...

Aren't they also somewhat expensive - so you really want to use them
for configuration options which pretty much don't change.

	David

> 
> Was this ever tested?
> 


