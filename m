Return-Path: <stable+bounces-7938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32025818F97
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 19:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566681C2516F
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1C43F8FA;
	Tue, 19 Dec 2023 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFR7JAjR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F340BEA;
	Tue, 19 Dec 2023 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d939e2f594so620877b3a.3;
        Tue, 19 Dec 2023 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703009667; x=1703614467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rM30I3C0/D1UB1IrxRysbf8DbDNzeT+kTnxO2PIKw6U=;
        b=YFR7JAjRwAM7PpuIoIoYm4J/iMop1eFSKJ5KPWOMy7Vh67zwnUZsxGunMJKD6pum4V
         2NbVxIjusLX2Oi6sUcgL/KC0gQwtJBXC1cSeUThJ3EIuBgHzZoO3jHH5idAvndEjqFbN
         zCwhMXwSsNUqNYYqCWymbuG6fQH0rkuVdFYL7pbYNsPd2SmF4kMDTNSwaXNF2Iz/Ypfx
         4yBMA6xzQvo64TOwmG65lSQgh6R7V6c3jC/Vo1yYmvAIYwWm7F/VxADzwuXMViUFjvwW
         4KAfSGOMdcV3fQZUNxWmVN4SAHmnz1435sjEGZdh35V5pva56kI05+DlO1INRSz/Pi4Q
         k5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009667; x=1703614467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM30I3C0/D1UB1IrxRysbf8DbDNzeT+kTnxO2PIKw6U=;
        b=hdWwnr127YG04Wf8QFexael34bM2ohGVjhAk1hMP6YcERoTA/mFGQRRcIwg1kBXBbJ
         ARNstir5dk2r4KgCXcM+QsDIdXsXlLAFu4bu8sWeZCZfswAKa+DUiTbNgMf4uOjDriL9
         lXNHBYi2+eEDw6k4qTFTVg8qaFbMr5zIh+/6hnDzVMsXtge4QB7Du4btSIU766NrcGqM
         Y225342785N6IZepqxLO6+bPtnYEV3bC+0bE/La39dRU4yQhFpje82SSK5xbvfWClLuM
         prbkw28ydVk/lqvPsNOe9YVXmvvT+auV0ipy52IG0Hm4gP4fGtPqZpU4506PhHJcy3w5
         4tDw==
X-Gm-Message-State: AOJu0YwmSoQtsKwj4k0QYa55Mar9zVfHBj762l2C+rLS+v4uzL4R6wFt
	oqU4/RKrqGJJCxqpthijIc8=
X-Google-Smtp-Source: AGHT+IFEcpiOmlfmjOLs//6wqp+AAviYjbV6n/032CKGqeHjP73CT/2/IcnVh4kzrACIucyK+gQyqg==
X-Received: by 2002:a05:6a00:b56:b0:6d7:d812:f417 with SMTP id p22-20020a056a000b5600b006d7d812f417mr4195384pfo.2.1703009666929;
        Tue, 19 Dec 2023 10:14:26 -0800 (PST)
Received: from debian ([177.240.14.150])
        by smtp.gmail.com with ESMTPSA id z6-20020aa78886000000b006cc02a6d18asm3966812pfe.61.2023.12.19.10.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:14:26 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 19 Dec 2023 10:14:19 -0800
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/hdm: Fix dpa translation locking
Message-ID: <ZYHde6aiBj5mmh7P@debian>
References: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>

On Wed, Dec 06, 2023 at 07:57:06PM -0800, Dan Williams wrote:
> The helper, cxl_dpa_resource_start(), snapshots the dpa-address of an
> endpoint-decoder after acquiring the cxl_dpa_rwsem. However, it is
> sufficient to assert that cxl_dpa_rwsem is held rather than acquire it
> in the helper. Otherwise, it triggers multiple lockdep reports:
> 
> 1/ Tracing callbacks are in an atomic context that can not acquire sleeping
> locks:
> 
>     BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1525
>     in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1288, name: bash
>     preempt_count: 2, expected: 0
>     RCU nest depth: 0, expected: 0
>     [..]
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x71/0x90
>      __might_resched+0x1b2/0x2c0
>      down_read+0x1a/0x190
>      cxl_dpa_resource_start+0x15/0x50 [cxl_core]
>      cxl_trace_hpa+0x122/0x300 [cxl_core]
>      trace_event_raw_event_cxl_poison+0x1c9/0x2d0 [cxl_core]
> 
> 2/ The rwsem is already held in the inject poison path:
> 
>     WARNING: possible recursive locking detected
>     6.7.0-rc2+ #12 Tainted: G        W  OE    N
>     --------------------------------------------
>     bash/1288 is trying to acquire lock:
>     ffffffffc05f73d0 (cxl_dpa_rwsem){++++}-{3:3}, at: cxl_dpa_resource_start+0x15/0x50 [cxl_core]
> 
>     but task is already holding lock:
>     ffffffffc05f73d0 (cxl_dpa_rwsem){++++}-{3:3}, at: cxl_inject_poison+0x7d/0x1e0 [cxl_core]
>     [..]
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x71/0x90
>      __might_resched+0x1b2/0x2c0
>      down_read+0x1a/0x190
>      cxl_dpa_resource_start+0x15/0x50 [cxl_core]
>      cxl_trace_hpa+0x122/0x300 [cxl_core]
>      trace_event_raw_event_cxl_poison+0x1c9/0x2d0 [cxl_core]
>      __traceiter_cxl_poison+0x5c/0x80 [cxl_core]
>      cxl_inject_poison+0x1bc/0x1e0 [cxl_core]
> 
> This appears to have been an issue since the initial implementation and
> uncovered by the new cxl-poison.sh test [1]. That test is now passing with
> these changes.
> 
> Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> Link: http://lore.kernel.org/r/e4f2716646918135ddbadf4146e92abb659de734.1700615159.git.alison.schofield@intel.com [1]
> Cc: <stable@vger.kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/hdm.c  |    3 +--
>  drivers/cxl/core/port.c |    4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 529baa8a1759..7d97790b893d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -363,10 +363,9 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  {
>  	resource_size_t base = -1;
>  
> -	down_read(&cxl_dpa_rwsem);
> +	lockdep_assert_held(&cxl_dpa_rwsem);
>  	if (cxled->dpa_res)
>  		base = cxled->dpa_res->start;
> -	up_read(&cxl_dpa_rwsem);
>  
>  	return base;
>  }
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 38441634e4c6..f6e9b2986a9a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -226,9 +226,9 @@ static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *at
>  			    char *buf)
>  {
>  	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> -	u64 base = cxl_dpa_resource_start(cxled);
>  
> -	return sysfs_emit(buf, "%#llx\n", base);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
> +	return sysfs_emit(buf, "%#llx\n", cxl_dpa_resource_start(cxled));
>  }
>  static DEVICE_ATTR_RO(dpa_resource);
>  
> 

