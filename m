Return-Path: <stable+bounces-93515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57369CDD93
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFF7280C44
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3D1B4F1C;
	Fri, 15 Nov 2024 11:37:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74018622;
	Fri, 15 Nov 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670651; cv=none; b=N3uRhMlv0hzbzP/Z1g5hRAkEDF97Qkx7u8r8q9H4pT5dVeLawWKVyzw2L3V9rb0hUMoJSFZcC+mCLYy0aHh/G8g/H9rDTO03CYjJbKHytix9MhXFEh9Q7Px6YYv+fM/KL8nRfSFlRAnnrRdUqdzkMdGz0wsgPWY7RCaGQu2OwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670651; c=relaxed/simple;
	bh=dOalgTtg/bwqmLEZLE2g2dxJ45h6yNkggGcJMwBqGTI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHlfDYF/9q86abYjXxOkiWjxudG8ms6BCjxeEBBKoZJoTbkMt6m7IQLuu2iM6DaJE9v5iatlGSEHKnyt456vhPeKLu5l/twQImQsHcqbOWhMdgaCT7l7pZQ0mvUxmNXSf29cc4Yj0wA47dNMCDKk1gqtctroLuCjpUP5mGBs0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XqZk81n4tz6LCyH;
	Fri, 15 Nov 2024 19:37:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F11D1140A46;
	Fri, 15 Nov 2024 19:37:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Nov
 2024 12:37:19 +0100
Date: Fri, 15 Nov 2024 11:37:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Huafei <lihuafei1@huawei.com>
CC: <gregkh@linuxfoundation.org>, <tiantao6@hisilicon.com>,
	<rafael@kernel.org>, <baohua@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] topology: Keep the cpumask unchanged when printing
 cpumap
Message-ID: <20241115113718.00000c31@huawei.com>
In-Reply-To: <20241114110141.94725-1-lihuafei1@huawei.com>
References: <20241114110141.94725-1-lihuafei1@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Nov 2024 19:01:41 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> During fuzz testing, the following warning was discovered:
> 
>  different return values (15 and 11) from vsnprintf("%*pbl
>  ", ...)
> 
>  test:keyward is WARNING in kvasprintf
>  WARNING: CPU: 55 PID: 1168477 at lib/kasprintf.c:30 kvasprintf+0x121/0x130
>  Call Trace:
>   kvasprintf+0x121/0x130
>   kasprintf+0xa6/0xe0
>   bitmap_print_to_buf+0x89/0x100
>   core_siblings_list_read+0x7e/0xb0
>   kernfs_file_read_iter+0x15b/0x270
>   new_sync_read+0x153/0x260
>   vfs_read+0x215/0x290
>   ksys_read+0xb9/0x160
>   do_syscall_64+0x56/0x100
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> The call trace shows that kvasprintf() reported this warning during the
> printing of core_siblings_list. kvasprintf() has several steps:
> 
>  (1) First, calculate the length of the resulting formatted string.
> 
>  (2) Allocate a buffer based on the returned length.
> 
>  (3) Then, perform the actual string formatting.
> 
>  (4) Check whether the lengths of the formatted strings returned in
>      steps (1) and (2) are consistent.
> 
> If the core_cpumask is modified between steps (1) and (3), the lengths
> obtained in these two steps may not match. Indeed our test includes cpu
> hotplugging, which should modify core_cpumask while printing.
> 
> To fix this issue, cache the cpumask into a temporary variable before
> calling cpumap_print_{list, cpumask}_to_buf(), to keep it unchanged
> during the printing process.
> 
> Fixes: bb9ec13d156e ("topology: use bin_attribute to break the size limitation of cpumap ABI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Makes sense. Trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes in v2:
>  - Return an error when calling alloc_cpumask_var() fails instead of
>    returning a size of 0. 
>  - Add Cc (to stable) tag.
> ---
>  drivers/base/topology.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 89f98be5c5b9..d293cbd253e4 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -27,9 +27,17 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
>  			   loff_t off, size_t count)				\
>  {										\
>  	struct device *dev = kobj_to_dev(kobj);                                 \
> +	cpumask_var_t mask;							\
> +	ssize_t n;								\
>  										\
> -	return cpumap_print_bitmask_to_buf(buf, topology_##mask(dev->id),	\
> -					   off, count);                         \
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
> +		return -ENOMEM;							\
Good catch.
Could use __free(free_cpumask_var) but that is a bit messy given it's not a conventional
allocation that returns a pointer.  So probably not worth doing just to save a single
manual free call.


> +										\
> +	cpumask_copy(mask, topology_##mask(dev->id));				\
> +	n = cpumap_print_bitmask_to_buf(buf, mask, off, count);			\
> +	free_cpumask_var(mask);							\
> +										\
> +	return n;								\
>  }										\
>  										\
>  static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
> @@ -37,9 +45,17 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
>  				loff_t off, size_t count)			\
>  {										\
>  	struct device *dev = kobj_to_dev(kobj);					\
> +	cpumask_var_t mask;							\
> +	ssize_t n;								\
> +										\
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
> +		return -ENOMEM;							\
> +										\
> +	cpumask_copy(mask, topology_##mask(dev->id));				\
> +	n = cpumap_print_list_to_buf(buf, mask, off, count);			\
> +	free_cpumask_var(mask);							\
>  										\
> -	return cpumap_print_list_to_buf(buf, topology_##mask(dev->id),		\
> -					off, count);				\
> +	return n;								\
>  }
>  
>  define_id_show_func(physical_package_id, "%d");


