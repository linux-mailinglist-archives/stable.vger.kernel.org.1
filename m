Return-Path: <stable+bounces-7929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E311C818CE8
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A401C243D8
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E95D20B2F;
	Tue, 19 Dec 2023 16:50:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922234CEB;
	Tue, 19 Dec 2023 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvjL721hwz6K9Hf;
	Wed, 20 Dec 2023 00:47:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 185C4140F8A;
	Wed, 20 Dec 2023 00:49:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 16:49:30 +0000
Date: Tue, 19 Dec 2023 16:49:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/hdm: Fix dpa translation locking
Message-ID: <20231219164928.00000e6f@Huawei.com>
In-Reply-To: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>
References: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 06 Dec 2023 19:57:06 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

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
Seems good other than %#pa being more appropriate for the printk.
I'm guessing you already tidied that up though.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
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


