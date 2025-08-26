Return-Path: <stable+bounces-176444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CDB3757E
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 01:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E8D7A14A4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61492D641A;
	Tue, 26 Aug 2025 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYkNLHdW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CB1547D2
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250607; cv=none; b=ibWF4SOncoC+RIOZ20jHI34Dc5h9ik85Uh7CQj//O5BVJuswA4lDOjjNOOzqS/feriEgEdBIRzxeCeL2cwmor76aQvYYG1pD1YsMOlLD50TRQGUhB+juQcsFz+toYYRlDatLDhnTRfDUXctTWI2g63ubzmKhEw+2ANpFzTUSRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250607; c=relaxed/simple;
	bh=PPIcFUpnwryEy7agkWVlVXKQSAD2kox2H6uN8IYHWAI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=orpbOml0LMut5FW11bJU7WXTZLYGtMIEugl8jWolYAThFYKOE2ip+7VWezCk8Fy5RXrAwEZJzKceeVrlb3E8cZ/vWF8P56HUHQ72d6N2gEe/gos29H5mKmh2CzV65As8XvH4DUv28kmUGtdE7DWnBZXe6zGGfzbx9PXrZpE13fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYkNLHdW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756250604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfV453EylzFjDMotqL0A6T4TqEkZwnGf9pcGEH+odnM=;
	b=XYkNLHdWI+0FxmBQbTFRT+3ltN7g6Fae9LBIdXm+HQjB/yK8Ia3uXaxBKDMeGjwi88aIqC
	xDaVjPabHmp5yxa7xZ88Xri8ObEDVfp5A3Oe/jZ8Qmpj8fmL1SlabmwXcO+U4NQAcfnjg+
	7gmJnrWa70K54m4Xp2go7tMcXt8aCa4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-RuGxl7chM6qW-Nx1FrKLsg-1; Tue, 26 Aug 2025 19:23:23 -0400
X-MC-Unique: RuGxl7chM6qW-Nx1FrKLsg-1
X-Mimecast-MFC-AGG-ID: RuGxl7chM6qW-Nx1FrKLsg_1756250603
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f55eb56so120776116d6.2
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 16:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756250602; x=1756855402;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfV453EylzFjDMotqL0A6T4TqEkZwnGf9pcGEH+odnM=;
        b=EstxKmL/voz3n4DPR/g5I+QfF0QiGZvl1RlhzRlGi4senVGuY1o5J92u32appzK5Aq
         ONKeqPxaG8dcC7bfQcrwyUCM+8hYq5UZspbwPzdGrSYXu8uPChyBaPHLC9hDTUKfcAs7
         HGDz8T+fHp1zxMQ8PWwSjYlxa760/0Atq/XbFDVgOSsSdId5TDHMSpAbv0L7vLKxQEmo
         FEE5xnMvikUhtE5YwjkAVoRYb4pAuhtdmx8JUw2GdtNGvd9dCGtXoobN0KXSsRboah0d
         0eKx0v0aoArJakrCinU9L4rR6vBfhKHUScO1vyZoGSD1MhLlmb7aSPhsszH8wMhxriZ+
         QDeA==
X-Gm-Message-State: AOJu0YzRd5BvrKvs7IBdp3wc1t3+zspNcYfzUNRUZkgUXsX4lCwSVLjJ
	RnBjcxChjLhCS/ucQCgzYacWFzdv4bDV5m0nlH4xEc5e8MfFAHDmr10Fn64HYld1CyK9HmVXnCL
	hM6/BLNklBPjXScw2ifKaSd/yTP2PHoG25l/9KMBSODfIUVWO/jm3kNR59Q==
X-Gm-Gg: ASbGncvJZ3TUd566ymbRh4ITqCqCUSquhgHFucbvoItzHZJVmRjwQ3ZXvoKmhTOxN7w
	dL4HCU2aoelpZUqIARqyWAy6xH6mqDH96vevMLnu8elzm8AJWtujmOVSQjV4njWhetu5vGFdwTw
	0gkegAKCWumerXauXGO/mCgOr6HI/7El8LNjm+gLs3BQBzjhswlwalk2KL3xXap348NqBOjDchf
	/obALi8CFMuOWpSG0s9nJdQHs8W1/fe/fHrPOhPz/oxEP98GPkNlCx4809BhClMHX2hstJrCVtd
	q5I4runRfDvHxKERUiJ+zyfoxsivLjdk/FewfOW0Lxau2RgLQhDNEG/bnJ0zYSKOa/AnLZnOIyD
	g/xsn5oV58A==
X-Received: by 2002:a05:6214:262c:b0:707:6665:eb67 with SMTP id 6a1803df08f44-70d970d80acmr196728726d6.27.1756250602637;
        Tue, 26 Aug 2025 16:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEagzZGepQvPjAZ7woLBtEEbKkKtRRVScJpVsy+SdVoofoUKsJC2jnzOZHnQCCSJR5pLARGzw==
X-Received: by 2002:a05:6214:262c:b0:707:6665:eb67 with SMTP id 6a1803df08f44-70d970d80acmr196728556d6.27.1756250602132;
        Tue, 26 Aug 2025 16:23:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72aff6esm72585926d6.53.2025.08.26.16.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 16:23:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ccb63d79-8c7f-4d0f-b92c-3ecb94471cd7@redhat.com>
Date: Tue, 26 Aug 2025 19:23:20 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
To: Gu Bowen <gubowen5@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Waiman Long <llong@redhat.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org,
 Breno Leitao <leitao@debian.org>, John Ogness <john.ogness@linutronix.de>,
 Lu Jialin <lujialin4@huawei.com>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
Content-Language: en-US
In-Reply-To: <20250822073541.1886469-1-gubowen5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 3:35 AM, Gu Bowen wrote:
> There are some AA deadlock issues in kmemleak, similar to the situation
> reported by Breno [1]. The deadlock path is as follows:
>
> mem_pool_alloc()
>    -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
>        -> pr_warn()
>            -> netconsole subsystem
> 	     -> netpoll
> 	         -> __alloc_skb
> 		   -> __create_object
> 		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
>
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided. The proper API to use should be
> printk_deferred_enter()/printk_deferred_exit() [2]. Another way is to
> place the warn print after kmemleak is released.
>
> [1]
> https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
> [2]
> https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
> ====================
>
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>
> ---
>   mm/kmemleak.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 84265983f239..1ac56ceb29b6 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -437,9 +437,15 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
>   		else if (untagged_objp == untagged_ptr || alias)
>   			return object;
>   		else {
> +			/*
> +			 * Printk deferring due to the kmemleak_lock held.
> +			 * This is done to avoid deadlock.
> +			 */
> +			printk_deferred_enter();
>   			kmemleak_warn("Found object by alias at 0x%08lx\n",
>   				      ptr);
>   			dump_object_info(object);
> +			printk_deferred_exit();
>   			break;
>   		}
>   	}
> @@ -736,6 +742,11 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
>   		else if (untagged_objp + parent->size <= untagged_ptr)
>   			link = &parent->rb_node.rb_right;
>   		else {
> +			/*
> +			 * Printk deferring due to the kmemleak_lock held.
> +			 * This is done to avoid deadlock.
> +			 */
> +			printk_deferred_enter();
>   			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
>   				      ptr);
>   			/*
> @@ -743,6 +754,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
>   			 * be freed while the kmemleak_lock is held.
>   			 */
>   			dump_object_info(parent);
> +			printk_deferred_exit();
>   			return -EEXIST;
>   		}
>   	}
> @@ -856,13 +868,8 @@ static void delete_object_part(unsigned long ptr, size_t size,
>   
>   	raw_spin_lock_irqsave(&kmemleak_lock, flags);
>   	object = __find_and_remove_object(ptr, 1, objflags);
> -	if (!object) {
> -#ifdef DEBUG
> -		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
> -			      ptr, size);
> -#endif
> +	if (!object)
>   		goto unlock;
> -	}
>   
>   	/*
>   	 * Create one or two objects that may result from the memory block
> @@ -882,8 +889,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
>   
>   unlock:
>   	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> -	if (object)
> +	if (object) {
>   		__delete_object(object);
> +	} else {
> +#ifdef DEBUG
> +		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
> +			      ptr, size);
> +#endif
> +	}
>   
>   out:
>   	if (object_l)
Reviewed-by: Waiman Long <longman@redhat.com>


