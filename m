Return-Path: <stable+bounces-147277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE022AC56F3
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B74A6073
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1814AD2B;
	Tue, 27 May 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7eYOgBd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355627FD49
	for <stable@vger.kernel.org>; Tue, 27 May 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366848; cv=none; b=KJC/tVko5bWwUPP9cgsTRKyiyly8NMCYfuZFYyZZC6z6TE44E0M4gDBBoOLNEewYFjCoz9oomvlj4WW2kAYjkp/2GMrJts7HPHk6YpYZzc2bwJdcoqrnSzDCwEbauFj3GciUdjw4rfJkpqoC5QULgMrHCqZ3QNZiRrl9+toORd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366848; c=relaxed/simple;
	bh=A3wIyJffHxPfmIV8B1isgc1zlN/9ZV21pjg8oWliHrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNTa3JQXHjAQB/JESpaClXlteJ4ABHPfgHEwg0Dk48lwkZHeiVMT8h/4eN2oXZ6DkR/cFQ7djqe6yyCAFi8NO51S5GtvDLsm2uLa3MSrC8iHrL1J2WTSNjWBjq6MIisnKLpLfy1pQvEpHwTftefFKqhWv9/xAJodWU9zVA5KKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7eYOgBd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748366845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQzpXQ7vkWBPskbjX+BkGNGUSRzfgukO2SXDGxgoMMs=;
	b=a7eYOgBdJPna/lB5ID6wllKSJ6+yPdJuTrupBbSuLHppzxxHfYWkAGIyqQzxkkvvDZQGub
	7fbJme8lOXJZYvazAlXzgzHIUyIYPAoxTOCqoKFE/0PBjASmogyj38ZZ/6Ucuz6op/t6QN
	sI570cafdjdhqWcUS/wvjXSapRNxlPs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-4kxQt5GJP7mz-DiVtzcNLA-1; Tue, 27 May 2025 13:27:23 -0400
X-MC-Unique: 4kxQt5GJP7mz-DiVtzcNLA-1
X-Mimecast-MFC-AGG-ID: 4kxQt5GJP7mz-DiVtzcNLA_1748366841
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c53e316734so546206885a.2
        for <stable@vger.kernel.org>; Tue, 27 May 2025 10:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748366841; x=1748971641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQzpXQ7vkWBPskbjX+BkGNGUSRzfgukO2SXDGxgoMMs=;
        b=Qwn4MHghzQr0CMgeKWCHJT3bvZVOMqeoU/r0lKzafCkmx8ezr7zdz5usI1wgv0E/HJ
         RZK3l/CEH8ViZoBY2e+ynHxS/j+qXQUhWQKYrNm2k+dr8VIEfqlyfUxp4rxNbdaSsxhm
         8BErN/b6L93UPqEFRPPGBriIOPXnsZ8jpZ55MZY4jQ4ffv9W2SFcVbYMJ/1ThlWCFqHd
         Cq37wY097LGIXWbIT4fqY7cZzPBGuOXWm3ZjH6YF3OIFjo+a8NE630n14ssOn9fWRrX7
         iiy/rCC2H1WdXhl1lsUxGXZ2MxDqw1IoGvnba+lH3X4C1w38jM/hhAGlDc/kdELRCzc0
         PnAg==
X-Forwarded-Encrypted: i=1; AJvYcCVcVZ2XCqNsZE6QtwmixFiaoMdW+mMnoMMXzNMbwgsqcqmpaHDFwZtitwAHZmWmhUrBG3Cs+Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfy8QzI86qxlZYGFCo2Yl7kyzxJrBuvrmMcU3MCjLCAQ6yGMpZ
	s5JdZsYiuuCOi6WPpQtLI/ldrsNsxApH8inGOM9ifaKHkzCtz7SadgYsaoc1cYLm6tzm7V36fd0
	Po4JDD7d76jDEuCig/0lA8i6LswL88Eb85cSwxMtB7mjLayUxdNIWkfP0PA==
X-Gm-Gg: ASbGncsCA4eQzZ4nRd8dwk4YWxCVx6aoCkGFn5fSVr1+tPXlXpq7vTzh4FTFwghEP3w
	jmnciHgQMWlX05fCC9+Lvdfx8cmEIAcqkT2vmbAjB4hh0JWNZ1xZioSCL9MANsr0lvy6YzxGmsn
	+3bCHgK5zmc8MvQQwaolNCuPFyMpXfKDbKryUcYTGQqDUo+KicTZ4ejKNqYEGA4kg+kJUR/mU2d
	q1ItfAmliUeov4TZydzoTQl/H1a7jApi+krG9Z91TF7JtB3oNoVPJBjZTaZWQ39VboI1fO8HNbT
	dW8tCydvJmM9I3MPfiIlEM8izUHbmx8DIUvHlngHLzOSQj/knYR8wLdiM3E=
X-Received: by 2002:a05:620a:f0d:b0:7cd:40:351 with SMTP id af79cd13be357-7ceecc33e6fmr1955055485a.58.1748366841217;
        Tue, 27 May 2025 10:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV8ht+49lI5qLVclM9XNHjng2TBDERfNRW0n/yJWFo6Oh60ZUmXJ0766q4+2Vo8i8akgpwrQ==
X-Received: by 2002:a05:620a:f0d:b0:7cd:40:351 with SMTP id af79cd13be357-7ceecc33e6fmr1955050985a.58.1748366840741;
        Tue, 27 May 2025 10:27:20 -0700 (PDT)
Received: from ?IPV6:2600:4040:5308:eb00:a77e:fec5:d269:f23e? ([2600:4040:5308:eb00:a77e:fec5:d269:f23e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cedf7930b5sm770956985a.89.2025.05.27.10.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 10:27:20 -0700 (PDT)
Message-ID: <ccdc7888-68a2-497a-bc28-f0c0297473b4@redhat.com>
Date: Tue, 27 May 2025 13:27:19 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 472/626] dm vdo vio-pool: allow variable-sized
 metadata vios
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Ken Raeburn <raeburn@redhat.com>,
 Mikulas Patocka <mpatocka@redhat.com>, Sasha Levin <sashal@kernel.org>
References: <20250527162445.028718347@linuxfoundation.org>
 <20250527162504.171843154@linuxfoundation.org>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20250527162504.171843154@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 12:26 PM, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.

There's no reason to take this patch for 6.12, it can just be dropped.

This patch adds a new interface, but the subsequent patches that use 
that interface are not being backported. So it won't hurt anything, but 
it's also useless in 6.12.

Matt

> ------------------
> 
> From: Ken Raeburn <raeburn@redhat.com>
> 
> [ Upstream commit f979da512553a41a657f2c1198277e84d66f8ce3 ]
> 
> With larger-sized metadata vio pools, vdo will sometimes need to
> issue I/O with a smaller size than the allocated size. Since
> vio_reset_bio is where the bvec array and I/O size are initialized,
> this reset interface must now specify what I/O size to use.
> 
> Signed-off-by: Ken Raeburn <raeburn@redhat.com>
> Signed-off-by: Matthew Sakai <msakai@redhat.com>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/md/dm-vdo/io-submitter.c |  6 ++++--
>   drivers/md/dm-vdo/io-submitter.h | 18 +++++++++++++---
>   drivers/md/dm-vdo/types.h        |  3 +++
>   drivers/md/dm-vdo/vio.c          | 36 +++++++++++++++++++-------------
>   drivers/md/dm-vdo/vio.h          |  2 ++
>   5 files changed, 46 insertions(+), 19 deletions(-)
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


