Return-Path: <stable+bounces-147879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F5AAC5A67
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 21:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EDC1BC2015
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613227E7EC;
	Tue, 27 May 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeZTdOJS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCE1F63C1
	for <stable@vger.kernel.org>; Tue, 27 May 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748372935; cv=none; b=IyAlhGvYniuOFb0clWsSzodpjj0MIQ6RCPrgZmCf7DR0pMKGPTQSRA6a4zPkVYkoepQB24qBsnMklpT8s1n+PI90m67Hnia92/EQXCPKl8qBJ3eff+FXUkHJxjx/5GcZWK7ruKnHkGFR9t7AZFAis7QHZKTkx3UTA8XJSTaGVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748372935; c=relaxed/simple;
	bh=WSs0JVHmPFw7Mk3JUgnSAfwyoqh/UW4/L1UBKPQ17NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mF//img/NnPxuBP7q0LWE958DC5Lx6B0Iy1IcrCOy0EfCbQzahTwQ/E4WjPU+c5BPPBpzt6H6eK1TJiX4PDjz/Hw4zAdWovj670TQeAOIncdKf+yyFl4cgNPd8tZ0azH32z/4ABAl5UkF+Q2yy4NhGMFVJ37cXbGJSOFbw0Vaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeZTdOJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748372932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUCjKL7EFoG7vbAgS7E8yLbDRLFelai5GeAFNQZUOU4=;
	b=QeZTdOJSRAsD1nRkYp325MMRxomnwFsLigSjuieDJZ2+UmeCwUMJpGn9N8xT7sH7/3tYtr
	Vwdoak+M8U41aWLQatm9H6Ff2XBRN2Hw2GIP2MHeAhQjA8oxp1GqE0wIM4ctsuRdZIpwZ6
	IP5KStlkXp8bbWYGH072L5tTd874FE4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-_-pIwqlJPIuSlGN3uyqUeA-1; Tue, 27 May 2025 15:08:48 -0400
X-MC-Unique: _-pIwqlJPIuSlGN3uyqUeA-1
X-Mimecast-MFC-AGG-ID: _-pIwqlJPIuSlGN3uyqUeA_1748372926
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c7c30d8986so1099942985a.2
        for <stable@vger.kernel.org>; Tue, 27 May 2025 12:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748372926; x=1748977726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUCjKL7EFoG7vbAgS7E8yLbDRLFelai5GeAFNQZUOU4=;
        b=pQd6d0BS7EarEtPxTbdPFbBBph8mMeaO9jUc78bVuy6763CF7wrXW93f+fl8ALuMCi
         ZyQyudwOxe1EKO0Kosgq1cV1F97Kv5vb+6c7WUJhkNA5JsGC/V2c+a8d5EQ/SKOIxfj4
         48p2xJY3ZFYDOzQZXDorQr2Y681Km//A/09IrmSyuxT3fuK2xfZkg8pfUYY3jFzHW/Fh
         RQdbnTeV2lS+MGmHcGyWxCLFO2qbmDAsDIyE5uLFOF6uzPLZy9YqXY8Ppm/VVcmphu+K
         zo9BREt0CbnhONPS9ACGNarhkR5Xvk28Zez7v1wVfg6D1QfQRTZk1KEY8oqluRuCldvP
         yLew==
X-Forwarded-Encrypted: i=1; AJvYcCV4x5bcjexcRxMLiUNdBdaRts16quikA4fpSHNAzOsU5KqSLxIsTU3JD6DY6gCFYr26Mt0bowg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUh1uRPbCoQM0NK5pJXzFEB7Zv69U3qm7qp3eM3EEu79J6au3/
	uFnOMXXvahpf3sKJLbmdMBwFeUweFJ6V7pUCw8d1HrAvR3gockq1puL2graOwVO0SeyGZ05MalJ
	mUaGKDYrq05Wsw+3A0HZgEOreMyjtB325ANZPbfUAphxVSaBts0t2w1bKoQ==
X-Gm-Gg: ASbGncu2uvoFmNMLkMgGFRjTRNVAvW2gZW3wnlBiiO2gDpiI9+7x42gVJT6OkuFTs4Y
	LK4RVzi0wJsEWqHv61DNY1wU8c6QR4otc1avNZpxtGV2GVee6GYASTDujwv+0ZLLQcTnAETiM+v
	c2e87ghar8NE6QijbouVUfhY+7aDwqcm5O9fx38IsWzXgsJukhETFYBhyOiyWngMlLecq1BtIjN
	l4uedIDLN+ufG+pz843y7O3VeyNZnehYnqIG2m0joEZBoYkc7WqXBaNPWc50jP9IPsOtvwDuVqX
	OLuiZs+xyVLHYVLDqLbSAtHG6L/yj53CYsu67HOksDPKbJQGtEGJjY5zImo=
X-Received: by 2002:a05:620a:1a85:b0:7c9:6d26:91b9 with SMTP id af79cd13be357-7ceecc166efmr2089130785a.36.1748372926462;
        Tue, 27 May 2025 12:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXM0Kj5rSW3ASAGlPZcrCrdIx2OXX33SlPnO7B2AXfCTRBt8r6lm0v/MkKCu8tk4Apbvlm/Q==
X-Received: by 2002:a05:620a:1a85:b0:7c9:6d26:91b9 with SMTP id af79cd13be357-7ceecc166efmr2089124985a.36.1748372925911;
        Tue, 27 May 2025 12:08:45 -0700 (PDT)
Received: from ?IPV6:2600:4040:5308:eb00:a77e:fec5:d269:f23e? ([2600:4040:5308:eb00:a77e:fec5:d269:f23e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467ecf98sm1763389085a.61.2025.05.27.12.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 12:08:45 -0700 (PDT)
Message-ID: <ddd366de-3dc5-40af-bec5-9edf0c0720f7@redhat.com>
Date: Tue, 27 May 2025 15:08:39 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 588/783] dm vdo vio-pool: allow variable-sized
 metadata vios
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Ken Raeburn <raeburn@redhat.com>,
 Mikulas Patocka <mpatocka@redhat.com>, Sasha Levin <sashal@kernel.org>
References: <20250527162513.035720581@linuxfoundation.org>
 <20250527162537.082726404@linuxfoundation.org>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20250527162537.082726404@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/27/25 12:26 PM, Greg Kroah-Hartman wrote:
> 6.14-stable review patch.  If anyone has any objections, please let me know.

There's no reason to take this patch for 6.14, it can just be dropped.

This patch adds a new interface, but the subsequent patches that use 
that interface are not being backported. So it won't hurt anything, but 
it's also useless in 6.14.

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


