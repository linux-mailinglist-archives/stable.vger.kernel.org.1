Return-Path: <stable+bounces-146133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62129AC163D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B347B9520
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 21:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB625B1D4;
	Thu, 22 May 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrO/HnYc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169A25A2C1
	for <stable@vger.kernel.org>; Thu, 22 May 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950668; cv=none; b=GEBnAkuK2yZmVYsLwK+I5ylj9rBdqosmejS3QNbC1btqWI22gI9Ic89KP2LmQVbfSpc01hePGJEPCkb+WZ5nMaC02n21a07Rcv/rmhOEnq6zPRRTJPt0DfPXC1wQwCp2c+xR8XTTjwGlu784mTC99xsB2FPKnTI/3LPJtp+vIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950668; c=relaxed/simple;
	bh=GYgEK9Tn4FnYl4V4I/AE7GkGA9U2MjdEMYZDwRPyDrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=c6nf9SRGpw9mNHvZv1srDlF4cQ8jpZuiybGijHWH6DfvA9Qi/fvhVH22Zl1U06FWyYZxBxP59ccXg63TwmwJ5haTq8tfgKRm7/LK+sLriUUuIrSdjYGwsZXD+0zm35cX4EPG3hS88rWJtqnm8VJKujgPRODhmYRAwxgUg/G8AFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrO/HnYc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747950664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7I+TEBYuyLC6impD46/32ZXQsAQntEewyqgpIS0CF0=;
	b=XrO/HnYc49jTNnuzcIJdhJZqOl+YmSZrg87Oe7zRAJ/adYmK8O9O5GT7L0wyImn0dutJvZ
	OvmjIsHJTj5tvJ3pEwf6HiZr+U8OmOJa1Cbz4X9pP+rG+nIm+4wCpnM01zZXJi4j0sNgvO
	B+81WMiI6S+wIy94FbNeMC6LMyLdTBM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-gQ3JgeM8PmywGbeZn8QYJQ-1; Thu, 22 May 2025 17:51:02 -0400
X-MC-Unique: gQ3JgeM8PmywGbeZn8QYJQ-1
X-Mimecast-MFC-AGG-ID: gQ3JgeM8PmywGbeZn8QYJQ_1747950662
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f2b50a75d8so116533516d6.0
        for <stable@vger.kernel.org>; Thu, 22 May 2025 14:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747950662; x=1748555462;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7I+TEBYuyLC6impD46/32ZXQsAQntEewyqgpIS0CF0=;
        b=jXCo2rI7yY9Xa+uoP/p4S6faUhqAMqb1pIlFWH0GzHZvCSHOak5ILSVfozYaAPY0pw
         IAaAeeA94arL3ttIO5YdstPHX2stUy2Vdt4rqvJfzBc2yOfadyDXi1b7Gyps5gAownWa
         69OqYmAq9NP9SPUYtXcMzjMnb6PEriBy3Ell4RrZao8iKgegIncstJ9rdO/4hIFem4RE
         c3c1msfTaNJtjtzWtRgmv4+INyUBZaTcTlrGM7OBqvw/ikxpHymr7BfwbS6PgFu70Sfw
         riMU9uiOA+VqV6dS21RKAe693MlVMyUjst4aCb+QLK5hkiiE10p09Fxb4PtjJL03FRhy
         BDyQ==
X-Gm-Message-State: AOJu0YwZZB5p04RdEFgLv/4KlFUDkKkTdUSLgsqv4madS3EwcfAyqJ3B
	6H8/cQQUYiDdNdbSs0HXurg3z+qwIwftiaNouiPBO5LwPI3FsjnG127KWzRW9R4M8k3P3Oaparz
	0Hx2ZT9pEzmqet8wL3QsyqR1f6QionRBr2qpfWEXBPs6IoDuAKtAsljMxKyEg9/g3aztrDUDnNb
	CxwHrTBsQcJO3L0SX0Llq9jsljtOOx9g6OFDvTNn3mNQ==
X-Gm-Gg: ASbGncvzzNohbymIY8WgnQwUzC84zLh+xxtE0jru+CsWTBmVUxVojRM3cz2pM4G/NGr
	1JPQan2d2NzD4wrIiYmEB9WJlGmFArQZTmVoe5wm78iFzxUe07RyldEz6OntVCptxpn5Pjp1g+4
	ebu/uxrYG1NQj2cymvfL1tEmpLIA2G1PE4lB9EfUmRwjeqalZYrFC12vObNKH85srj5LBsT13fe
	gG7VOQohaHIa6MmpTfLO7KEkAvT7upU0ApOg6DcQSLY7VSsrxFyh0qz5raGWcJ6VdGFKWSvboZm
	uUVaofsMw7tGDY7+h654EmYmxN5dmpZTObnQIWN6AmKwasdFibdsI8WJ4Wg=
X-Received: by 2002:a05:620a:244d:b0:7c5:5e9f:eb30 with SMTP id af79cd13be357-7cd47f3d060mr4045871885a.15.1747950662140;
        Thu, 22 May 2025 14:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFly4Le84lxwG4TkUdwwGvWbC9ZwP/guj6ObhBAzSeOAkNKpc0Z0wUZHJvpT92Pfk/HONFk7w==
X-Received: by 2002:a05:620a:244d:b0:7c5:5e9f:eb30 with SMTP id af79cd13be357-7cd47f3d060mr4045868385a.15.1747950661581;
        Thu, 22 May 2025 14:51:01 -0700 (PDT)
Received: from ?IPV6:2600:4040:5308:eb00:a77e:fec5:d269:f23e? ([2600:4040:5308:eb00:a77e:fec5:d269:f23e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b62ecsm1075442685a.82.2025.05.22.14.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:51:01 -0700 (PDT)
Message-ID: <f0f0fb77-af1d-42f2-b8fe-a2edb1baf1f1@redhat.com>
Date: Thu, 22 May 2025 17:51:00 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "dm vdo vio-pool: allow variable-sized metadata vios" has
 been added to the 6.14-stable tree
Content-Language: en-US
To: stable@vger.kernel.org
References: <20250522214416.3152499-1-sashal@kernel.org>
Cc: Ken Raeburn <raeburn@redhat.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20250522214416.3152499-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/22/25 5:44 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      dm vdo vio-pool: allow variable-sized metadata vios
> 
> to the 6.14-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       dm-vdo-vio-pool-allow-variable-sized-metadata-vios.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

This patch should probably not get added to 6.14 or any earlier stable 
tree. It implements an interface for a new feature added in in 6.15, but 
without backporting that feature, nothing will use the new interface so 
this patch is unnecessary.

Thanks,
Matt

> 
> commit 921200c5e2f6a07ad93419d800d6a1a2fbf7abc7
> Author: Ken Raeburn <raeburn@redhat.com>
> Date:   Fri Jan 31 21:18:05 2025 -0500
> 
>      dm vdo vio-pool: allow variable-sized metadata vios
>      
>      [ Upstream commit f979da512553a41a657f2c1198277e84d66f8ce3 ]
>      
>      With larger-sized metadata vio pools, vdo will sometimes need to
>      issue I/O with a smaller size than the allocated size. Since
>      vio_reset_bio is where the bvec array and I/O size are initialized,
>      this reset interface must now specify what I/O size to use.
>      
>      Signed-off-by: Ken Raeburn <raeburn@redhat.com>
>      Signed-off-by: Matthew Sakai <msakai@redhat.com>
>      Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/md/dm-vdo/io-submitter.c b/drivers/md/dm-vdo/io-submitter.c
> index 421e5436c32c9..11d47770b54d2 100644
> --- a/drivers/md/dm-vdo/io-submitter.c
> +++ b/drivers/md/dm-vdo/io-submitter.c
> @@ -327,6 +327,7 @@ void vdo_submit_data_vio(struct data_vio *data_vio)
>    * @error_handler: the handler for submission or I/O errors (may be NULL)
>    * @operation: the type of I/O to perform
>    * @data: the buffer to read or write (may be NULL)
> + * @size: the I/O amount in bytes
>    *
>    * The vio is enqueued on a vdo bio queue so that bio submission (which may block) does not block
>    * other vdo threads.
> @@ -338,7 +339,7 @@ void vdo_submit_data_vio(struct data_vio *data_vio)
>    */
>   void __submit_metadata_vio(struct vio *vio, physical_block_number_t physical,
>   			   bio_end_io_t callback, vdo_action_fn error_handler,
> -			   blk_opf_t operation, char *data)
> +			   blk_opf_t operation, char *data, int size)
>   {
>   	int result;
>   	struct vdo_completion *completion = &vio->completion;
> @@ -349,7 +350,8 @@ void __submit_metadata_vio(struct vio *vio, physical_block_number_t physical,
>   
>   	vdo_reset_completion(completion);
>   	completion->error_handler = error_handler;
> -	result = vio_reset_bio(vio, data, callback, operation | REQ_META, physical);
> +	result = vio_reset_bio_with_size(vio, data, size, callback, operation | REQ_META,
> +					 physical);
>   	if (result != VDO_SUCCESS) {
>   		continue_vio(vio, result);
>   		return;
> diff --git a/drivers/md/dm-vdo/io-submitter.h b/drivers/md/dm-vdo/io-submitter.h
> index 80748699496f2..3088f11055fdd 100644
> --- a/drivers/md/dm-vdo/io-submitter.h
> +++ b/drivers/md/dm-vdo/io-submitter.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/bio.h>
>   
> +#include "constants.h"
>   #include "types.h"
>   
>   struct io_submitter;
> @@ -26,14 +27,25 @@ void vdo_submit_data_vio(struct data_vio *data_vio);
>   
>   void __submit_metadata_vio(struct vio *vio, physical_block_number_t physical,
>   			   bio_end_io_t callback, vdo_action_fn error_handler,
> -			   blk_opf_t operation, char *data);
> +			   blk_opf_t operation, char *data, int size);
>   
>   static inline void vdo_submit_metadata_vio(struct vio *vio, physical_block_number_t physical,
>   					   bio_end_io_t callback, vdo_action_fn error_handler,
>   					   blk_opf_t operation)
>   {
>   	__submit_metadata_vio(vio, physical, callback, error_handler,
> -			      operation, vio->data);
> +			      operation, vio->data, vio->block_count * VDO_BLOCK_SIZE);
> +}
> +
> +static inline void vdo_submit_metadata_vio_with_size(struct vio *vio,
> +						     physical_block_number_t physical,
> +						     bio_end_io_t callback,
> +						     vdo_action_fn error_handler,
> +						     blk_opf_t operation,
> +						     int size)
> +{
> +	__submit_metadata_vio(vio, physical, callback, error_handler,
> +			      operation, vio->data, size);
>   }
>   
>   static inline void vdo_submit_flush_vio(struct vio *vio, bio_end_io_t callback,
> @@ -41,7 +53,7 @@ static inline void vdo_submit_flush_vio(struct vio *vio, bio_end_io_t callback,
>   {
>   	/* FIXME: Can we just use REQ_OP_FLUSH? */
>   	__submit_metadata_vio(vio, 0, callback, error_handler,
> -			      REQ_OP_WRITE | REQ_PREFLUSH, NULL);
> +			      REQ_OP_WRITE | REQ_PREFLUSH, NULL, 0);
>   }
>   
>   #endif /* VDO_IO_SUBMITTER_H */
> diff --git a/drivers/md/dm-vdo/types.h b/drivers/md/dm-vdo/types.h
> index dbe892b10f265..cdf36e7d77021 100644
> --- a/drivers/md/dm-vdo/types.h
> +++ b/drivers/md/dm-vdo/types.h
> @@ -376,6 +376,9 @@ struct vio {
>   	/* The size of this vio in blocks */
>   	unsigned int block_count;
>   
> +	/* The amount of data to be read or written, in bytes */
> +	unsigned int io_size;
> +
>   	/* The data being read or written. */
>   	char *data;
>   
> diff --git a/drivers/md/dm-vdo/vio.c b/drivers/md/dm-vdo/vio.c
> index e710f3c5a972d..725d87ecf2150 100644
> --- a/drivers/md/dm-vdo/vio.c
> +++ b/drivers/md/dm-vdo/vio.c
> @@ -188,14 +188,23 @@ void vdo_set_bio_properties(struct bio *bio, struct vio *vio, bio_end_io_t callb
>   
>   /*
>    * Prepares the bio to perform IO with the specified buffer. May only be used on a VDO-allocated
> - * bio, as it assumes the bio wraps a 4k buffer that is 4k aligned, but there does not have to be a
> - * vio associated with the bio.
> + * bio, as it assumes the bio wraps a 4k-multiple buffer that is 4k aligned, but there does not
> + * have to be a vio associated with the bio.
>    */
>   int vio_reset_bio(struct vio *vio, char *data, bio_end_io_t callback,
>   		  blk_opf_t bi_opf, physical_block_number_t pbn)
>   {
> -	int bvec_count, offset, len, i;
> +	return vio_reset_bio_with_size(vio, data, vio->block_count * VDO_BLOCK_SIZE,
> +				       callback, bi_opf, pbn);
> +}
> +
> +int vio_reset_bio_with_size(struct vio *vio, char *data, int size, bio_end_io_t callback,
> +			    blk_opf_t bi_opf, physical_block_number_t pbn)
> +{
> +	int bvec_count, offset, i;
>   	struct bio *bio = vio->bio;
> +	int vio_size = vio->block_count * VDO_BLOCK_SIZE;
> +	int remaining;
>   
>   	bio_reset(bio, bio->bi_bdev, bi_opf);
>   	vdo_set_bio_properties(bio, vio, callback, bi_opf, pbn);
> @@ -205,22 +214,21 @@ int vio_reset_bio(struct vio *vio, char *data, bio_end_io_t callback,
>   	bio->bi_ioprio = 0;
>   	bio->bi_io_vec = bio->bi_inline_vecs;
>   	bio->bi_max_vecs = vio->block_count + 1;
> -	len = VDO_BLOCK_SIZE * vio->block_count;
> +	if (VDO_ASSERT(size <= vio_size, "specified size %d is not greater than allocated %d",
> +		       size, vio_size) != VDO_SUCCESS)
> +		size = vio_size;
> +	vio->io_size = size;
>   	offset = offset_in_page(data);
> -	bvec_count = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +	bvec_count = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> +	remaining = size;
>   
> -	/*
> -	 * If we knew that data was always on one page, or contiguous pages, we wouldn't need the
> -	 * loop. But if we're using vmalloc, it's not impossible that the data is in different
> -	 * pages that can't be merged in bio_add_page...
> -	 */
> -	for (i = 0; (i < bvec_count) && (len > 0); i++) {
> +	for (i = 0; (i < bvec_count) && (remaining > 0); i++) {
>   		struct page *page;
>   		int bytes_added;
>   		int bytes = PAGE_SIZE - offset;
>   
> -		if (bytes > len)
> -			bytes = len;
> +		if (bytes > remaining)
> +			bytes = remaining;
>   
>   		page = is_vmalloc_addr(data) ? vmalloc_to_page(data) : virt_to_page(data);
>   		bytes_added = bio_add_page(bio, page, bytes, offset);
> @@ -232,7 +240,7 @@ int vio_reset_bio(struct vio *vio, char *data, bio_end_io_t callback,
>   		}
>   
>   		data += bytes;
> -		len -= bytes;
> +		remaining -= bytes;
>   		offset = 0;
>   	}
>   
> diff --git a/drivers/md/dm-vdo/vio.h b/drivers/md/dm-vdo/vio.h
> index 3490e9f59b04a..74e8fd7c8c029 100644
> --- a/drivers/md/dm-vdo/vio.h
> +++ b/drivers/md/dm-vdo/vio.h
> @@ -123,6 +123,8 @@ void vdo_set_bio_properties(struct bio *bio, struct vio *vio, bio_end_io_t callb
>   
>   int vio_reset_bio(struct vio *vio, char *data, bio_end_io_t callback,
>   		  blk_opf_t bi_opf, physical_block_number_t pbn);
> +int vio_reset_bio_with_size(struct vio *vio, char *data, int size, bio_end_io_t callback,
> +			    blk_opf_t bi_opf, physical_block_number_t pbn);
>   
>   void update_vio_error_stats(struct vio *vio, const char *format, ...)
>   	__printf(2, 3);
> 


