Return-Path: <stable+bounces-171870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7290B2D293
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 05:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D543B861A
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 03:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFD258ECA;
	Wed, 20 Aug 2025 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eymFlvdr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077751E9B08
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755660451; cv=none; b=V5zaiSAv1PDDEHaFIMK/TWSumvcqkBZKaxV3GaBLItxtAzHIiy/LlFyPv62dzfkNqPITgQvDcX7lWykj1RFKMew8fZGPg2qLUrc5MA+CrNqVQorWczgOMYm3hBP9JKi+IjPS+AUgDb94LAGfpArevnyR5fVmvJp3IDFc+YeIHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755660451; c=relaxed/simple;
	bh=CzE1mzfOEoyeiSDi/n0UtTiTSZvrNcqpd4IHhvvpEWA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WPJnPLVrFefNcOrQ6jq/oYaXWUA2G8bMp2JGsCe+bffI9dMtc6xAX0CqrB5Wwut0To5BHo1gYzPN4NuPQTXdc3A4rs0ulpRduSplx7q2FkqTp8sRwnvsiYvkWTMEY5J2ztqpPGh4WWTT7QuE6OpT9EfSAbSZkWstQAV/Lar+0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eymFlvdr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755660447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBtV/gVWBkyOUPr/F57qO1omGrrH3gCVGLkqTBMXbzg=;
	b=eymFlvdrMwsYYhWcPe+7RjbOkgFtYG6JPO8M5KjSClEVWWN9TUaHQZCFgmmnD/yG9yNqNJ
	aNVCUkW+IWqc+kGZCI3gDyir/kCbpmW+xRTs6FrIDaeOAJWk0PN7BH6emLB0s14M3idcRw
	0QmMjt7sATI1OhFANSkhyAhcGtIxQ/s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-LpOqHeKwOlaJyReUVbeOhQ-1; Tue, 19 Aug 2025 23:27:26 -0400
X-MC-Unique: LpOqHeKwOlaJyReUVbeOhQ-1
X-Mimecast-MFC-AGG-ID: LpOqHeKwOlaJyReUVbeOhQ_1755660446
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e870317642so1441152285a.0
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 20:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755660446; x=1756265246;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBtV/gVWBkyOUPr/F57qO1omGrrH3gCVGLkqTBMXbzg=;
        b=lTbmebsorAVIjoY+Tn0awXFgpMws4I0S0BlHup9Shhc6B06HyW1qEGEk2pfDSYyb46
         2mjXIA2nsFfkU9EeswzulLdQWsbcDXAnleIn1c+rr2XF8RkS+eGNVgcyPVx7+xAViHfq
         /Z6oxfmiLxiLFmkN4cwYdBJhZD7Uilo5ekmfRoaxmkW42owwKi2G8diLMPGlcDmtgA+X
         /X2HkD2yOOyYvauFKexZ3ThvZI+RHibUSvVxvkRYfPMSI5suXgrj8pQd5ujYjdl9V41x
         6qWUiWXhBi+hJ5fbxd6xFuVBw50jzJEOwrgGuSbWIT6OE/1yM1G2Xs9zVbYPSCxiqIuJ
         Wyxg==
X-Gm-Message-State: AOJu0YwRi1YqU0mJ0+S38wjtBgIZIbU9aeoqetCH9/1XqY4B8gzAvlOI
	S3gRxSMuySM6iltxXZCzVAPrm8e0SSL5Ft2U0DOVEjTD0VZgbsCozsxYhnVJF5S5Ua3jNDgXsEz
	t/Ax8VgTXHAElQDBnkT4qBapFji1c1h8PK7qi1LdTFDJ9R3AKVCUNQfjM8w==
X-Gm-Gg: ASbGncs/lQfaoFjcniMpmOgcV7yo1fftxVc1KyTjnAKs66RiwEbPNsDDtwmDU8Ptdil
	j2ORL33VUybXVfzUrvBPUg7N4pk1bN3e3MVARcEPQToBIjRzyrcq0DQjZgZoKm0s/aqp7pXhTdG
	2aOy7it+F6ayZSaog6Ka94jfZc5JqvcUpgqj+Y0i1R90jN5jgysDT/hyair37xEAFfha/V4ofeS
	WM5e/hqf4KBXUgUmd5O9EsDDtvxvuUTXmDFqXzQtSxQpPCExNlPCG+4tTN4gT9icuSxkCJ51S1S
	BkkCcuwyVmSxaRDNEvEhAZeisibXC1+kxkYXQBAoKn6LFooOpYzjt+zIJdrI3nopFVdz3nRSc9M
	QuFS7rNf3pg==
X-Received: by 2002:a05:620a:472b:b0:7e8:39da:9735 with SMTP id af79cd13be357-7e9fca75d1dmr182364185a.14.1755660445654;
        Tue, 19 Aug 2025 20:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9qFFsOUZW7BdZPaNwh9b+/hjR594POxsy5yqcNk8yrvy8IpcBso8ImATmHus1Hv5gu4ryFA==
X-Received: by 2002:a05:620a:472b:b0:7e8:39da:9735 with SMTP id af79cd13be357-7e9fca75d1dmr182362985a.14.1755660445227;
        Tue, 19 Aug 2025 20:27:25 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c14aesm860958585a.69.2025.08.19.20.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 20:27:24 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <113a8332-b35c-4d00-b8b1-21c07d133f1f@redhat.com>
Date: Tue, 19 Aug 2025 23:27:23 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
To: Gu Bowen <gubowen5@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, Waiman Long
 <llong@redhat.com>, Breno Leitao <leitao@debian.org>,
 John Ogness <john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
Content-Language: en-US
In-Reply-To: <20250818090945.1003644-1-gubowen5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 5:09 AM, Gu Bowen wrote:
> Our syztester report the lockdep WARNING [1], which was identified in
> stable kernel version 5.10. However, this deadlock path no longer exists
> due to the refactoring of console_lock in v6.2-rc1 [2]. Coincidentally,
> there are two types of deadlocks that we have found here. One is the ABBA
> deadlock, as mentioned above [1], and the other is the AA deadlock was
> reported by Breno [3]. The latter's deadlock issue persists.
>
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided. The proper API to use should be
> printk_deferred_enter()/printk_deferred_exit() [4].
>
> [1]
> https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/
> [2]
> https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/
> [3]
> https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
> [4]
> https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
> ====================
>
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>
> ---
>   mm/kmemleak.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 84265983f239..26113b89d09b 100644
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
> @@ -858,8 +870,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
>   	object = __find_and_remove_object(ptr, 1, objflags);
>   	if (!object) {
>   #ifdef DEBUG
> +		/*
> +		 * Printk deferring due to the kmemleak_lock held.
> +		 * This is done to avoid deadlock.
> +		 */
> +		printk_deferred_enter();
>   		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
>   			      ptr, size);
> +		printk_deferred_exit();
>   #endif

This particular warning message can be moved after unlock by adding a 
warning flag. Locking is done outside of the other two helper functions 
above, so it is easier to use printk_deferred_enter/exit() for those.

Anyway, it is just a nit.

Acked-by: Waiman Long <longman@redhat.com>


