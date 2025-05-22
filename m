Return-Path: <stable+bounces-146138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38FAC1705
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 00:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2831C038B0
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE829AB0D;
	Thu, 22 May 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irEWfg1L"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A529AAE5
	for <stable@vger.kernel.org>; Thu, 22 May 2025 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954394; cv=none; b=DRzrJNmk2lyrfHuz8t3dDG9cYYvsxJdMcFqHtx1UozHciiS0Jc2mXEc9vqry5/MJ7N6i+g/uGOu4dAPITSL+sRweichy8FT2aGJHf8AWiDBWB8b0vtnVO0PX/HwroyPEKqxf4abZT+t/myaW3olqmCkrpzu6hQ1MzGf+CDloUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954394; c=relaxed/simple;
	bh=g7IwXnfaU/Ic7Nqx7LJ2Z1PYEukicNg9RA4iD0PnHsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=F4qIn3eH4mPM2N98fDeykDai4IhOsOteoyvf1M2L1w5ezF6WbONDv5UO+bCBatQwkTWUI7BgwAAagiiZpWlYNw8JIEIhMkm39UpBvbZo/khmM9J3TgeiYQccUsXv9NV9EtD2J8EeHhEmUMb5vuCLlIhiNbVXZLijYarLWHVAJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irEWfg1L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747954390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlGqgjjL5VSHymlk09KO7DNpVCD1ZioU08bVsHZ8+cQ=;
	b=irEWfg1LCTuERWT59EpmKnmy2QkChO0ITCzUEXg2WcSDSQJDNV+ZBZB40J+nRDVregq8bR
	Hz2XdCScoa2Tjnb1VfLgH2iusBUY+OdwglGBd/U0dXOlmDiFGPtS+G3iM6EZRz3zSuhU1z
	dNhBuDTSsPsSrGqzOWOTZvz6oA9jDX4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-qCxyPHJiNyuLZOOqGKxaGQ-1; Thu, 22 May 2025 18:53:09 -0400
X-MC-Unique: qCxyPHJiNyuLZOOqGKxaGQ-1
X-Mimecast-MFC-AGG-ID: qCxyPHJiNyuLZOOqGKxaGQ_1747954389
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c760637fe5so1467434085a.0
        for <stable@vger.kernel.org>; Thu, 22 May 2025 15:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747954389; x=1748559189;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlGqgjjL5VSHymlk09KO7DNpVCD1ZioU08bVsHZ8+cQ=;
        b=qMrmd4emLcIoM9N5AQt1XDGL1HDW8SN10OyPD/rOXcH7andRTv8JiirOe/TG/67Igt
         bFcarJ9soKf9Hzg5soKWwK4pPgIAP40Wsa3AIqVKlUbxB1M4SStM85aAal/+6aXBIl1O
         YGEgMr5b/F+HSUq2OzotYQtzGU7fT2vhdoW59Ij+mOyGlgfKQSLYltdLVXzxzkiKKb/3
         wUyhH+lhYeOSYbq98hbL9ZdIDC6xd4nW9y0VEH9GviWuYTbJAN2rBtj/8Bn3XsG5MlbT
         Dco2g9s6YR+TJBDSERwWsaoGBxNV9I+/6Epult5AxIfx2F0oXzbdhRlCu9ULOSzDuckD
         LI7w==
X-Gm-Message-State: AOJu0YyZJaw1eYa1EXbC8rMJ/tvde+6tAy4UI50Hh3K2rcfBQ10wPRrv
	f5t6sr9affyn5yyjy/cZzritrzJ+N5rkF363a3wD5BGC/DX/DFCZfVSUGArA8DzbcXihSwQsUFO
	r3F3EZj4RVg6am64Z5CP7N9AO7punnQgkbR8Htp4tCwAHl+5yMznZqePzFV/RDYe46Pgs0g+Wlr
	iHBLeRA0dvJ/Q+S/qORTB/+fAzWu70SgOLveC7WU4GnA==
X-Gm-Gg: ASbGncvSWqOBuVF/7mUZBXyylR5X/2FrCvXaBf9cl5fTTpG+ZULnSs+M2Lu5AK/v4Zr
	9qgQnlQq9cf2Oiaxe/8mItVzNI7uRsmIxd+6u+ljIltzfVltizvlZvw0vInFtUZKEhXX9Ocj4HR
	gK1ybg+tHVPqLNorGDZQWdNT3rJX8Oozl2Gn88vStBq1ENsB0hoHlhJ+w3qtAteHbeUVUNZbiLA
	so6ICS0fPj/AoxhTDK7dmUvttD16XACIz9m69fQhCknY+19GJPb5ZvtGzS0FJt3BBxnNNWcpULA
	gQp89giTZJoj3Ofn/mKAzqa0pl/PjBZVceL7tytd4lB/qRfbiUFX3lBhh7k=
X-Received: by 2002:a05:620a:4093:b0:7cd:2857:331c with SMTP id af79cd13be357-7cd46779e79mr3449569485a.42.1747954388808;
        Thu, 22 May 2025 15:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETJANEkHojNEFdw87L5itL5RwtevOD+BC3tUhTJXU3StE4Lz9SJWNZVnXCqRDio6AvuSiKcw==
X-Received: by 2002:a05:620a:4093:b0:7cd:2857:331c with SMTP id af79cd13be357-7cd46779e79mr3449566785a.42.1747954388330;
        Thu, 22 May 2025 15:53:08 -0700 (PDT)
Received: from ?IPV6:2600:4040:5308:eb00:a77e:fec5:d269:f23e? ([2600:4040:5308:eb00:a77e:fec5:d269:f23e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467dab1asm1083199585a.44.2025.05.22.15.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:53:07 -0700 (PDT)
Message-ID: <e24d525c-80cd-4bc6-b1be-eb43cf16dd60@redhat.com>
Date: Thu, 22 May 2025 18:53:07 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "dm vdo vio-pool: allow variable-sized metadata vios" has
 been added to the 6.12-stable tree
Content-Language: en-US
To: stable@vger.kernel.org
References: <20250522223156.3205476-1-sashal@kernel.org>
Cc: Ken Raeburn <raeburn@redhat.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20250522223156.3205476-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/25 6:31 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      dm vdo vio-pool: allow variable-sized metadata vios
> 
> to the 6.12-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       dm-vdo-vio-pool-allow-variable-sized-metadata-vios.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

There is no reason to pull this patch into 6.12 since there are no 
features in 6.12 that would use it.

Matt

> 
> commit ac663217ac4eeab508db348a67511d45ccd9846f
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
> index ab62abe18827b..a664be89c15d7 100644
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
> index b291578f726f5..7c417c1af4516 100644
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
> @@ -204,22 +213,21 @@ int vio_reset_bio(struct vio *vio, char *data, bio_end_io_t callback,
>   
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
> @@ -231,7 +239,7 @@ int vio_reset_bio(struct vio *vio, char *data, bio_end_io_t callback,
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


