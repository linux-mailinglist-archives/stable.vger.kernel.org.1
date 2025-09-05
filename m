Return-Path: <stable+bounces-177824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB3B45AAC
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09EAA7A21C2
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE753705B2;
	Fri,  5 Sep 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj9h4lTw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD903705B5
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082932; cv=none; b=nGmzzkwRcR7in5eKerT1II+iFRTCJB2Ayg7dXmvmzsC+fFBP3j3Qj/4h0m2D7qwcSpqVmFdL85C43n8KXwYh4ForfbQPeL5Yp4wWAXAO2+X+wk6xj6vAA4TQEhTCxKwvJkjNnA1ABN08kwMJ3HInqP9ZpJ/7YPp7WpifNGfCkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082932; c=relaxed/simple;
	bh=nBqVJvIHpZ/hhIkh512pJcRlR7IMGeiScyT8OJkadCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiRvxvIApMTzijBFKpaUrPCJDyPAU0mDFNLWW59n91rnZigj+NO74bCRoI8NYj+ZZf+H00D4A4aZT4xibFrQfyD5Nf/RM0dscLwIkX9ljFkI14HSzNi4WSazruA0YkRupPK6zJgfstUB6/Pi9LDhbzHXVoUAvH3T8Ub51Q8hkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj9h4lTw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f7c8b38a0so285593e87.2
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757082928; x=1757687728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBMMkeCxHosHV7c8FxU0uPkYWEXN7KfNUsOKbUcY+ww=;
        b=Hj9h4lTwniaEeGeFQdFctyeqaC/S8l9svytLS/XYKNcMU2ajeYZYKSdJFvZu0X8Zxw
         1n9QxxYkXSXmjjbPagNc3erjXiV7oP0aD9BkbO/62vNqrkiz39TQLJ8kxYvj+nIcyqEW
         KOGTbvhgAC0U1Pb0mMxL8TKgG12fdMwi8XnjjLhqhoriWiWXQDMg27uy4Tz1rHvELxnX
         S5vNvVKxq+nqJwd8Bm0s9Sg6oQgNZnDz1HLT3ZegU41R/P60ZMKPshXFLVN7anDwo3Dm
         OwUtjFM1cYRRYdKXVE/s1Dt8Ua8077tZe+UZudUZFZiyenzqjKDplKkZGNYceJgBaRZt
         BA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082928; x=1757687728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBMMkeCxHosHV7c8FxU0uPkYWEXN7KfNUsOKbUcY+ww=;
        b=lT1F1ULz0ZG+hhLsM3YpT/kahglfTSIfPgZKg8IuWMR2oGuyb3MeZDclS8eEyiM2IT
         0+A/A0bsFvqWIOUJ9uVZWzDTxaKIWHuB/G+Nd0xSYIpT7krzTQEqKrifkHmDeYa43DyA
         t6wzijjrKq84blYpAot3Zi4Q69sq1KEu61EDhPfQ4qfF5yTrXEx+enVRGiARtdhzadpV
         qcIlK9jdggxRwEvAP0OraOr1Tdeq+tmpVFujw6ZYWgaBRRt+0bnMovhFabiKyTxHRedO
         sKKvSp8IvQTYY45bOweZ8jzx7ikSnDCaZsl8WXJ7b5MWZTHnuWaPdWNJYKmAFmPaDtMg
         VXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Gw6e7QMATH9Gwf6yqQckO/JTfq+dBkNpo6pXTrqUzw3W5IY61+3Knybx4FaxhXxsexJjOe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpbnXFRmT4fQeoP+K1AdySJqMwVCerjNMHSlsr1TSoiokFWo/
	q3hlep281oqU64KZhFf7CKiKorNJhY+gaWh7W/+dmqb7HtGwbChkQwwb
X-Gm-Gg: ASbGncusXgS3qGI8VN9Y2SjKQTHB+2x9GnGRXYXhjMRpWHvIFIvzeWCZDs8PcDRomhV
	3/T3z8x945z7TB/T2m+pzB91P5BPFMPnygUCTy6vNG3OTrCRy9f+lcb3Ob8ZObWnQLa8GJcG2Bg
	cb3PwLyAFlKy+lAJk0hCmkLpyJ+93RSJOVae5bHRAUC7IHKk7nYqDh1PeWbqqJAVgi7jdNZcLv8
	wrvcXrJiJCjA53ydNV40zgj+1W2ix7kTDIw57RlayKoISzNqHQ7kqBKaUmJrsMU1LpPOcXkqZ2g
	wZoAPnaNK2KlYcVIqA5e59GPbdZFWhsjqZbxRxRfDnIiETe2JfJS8JtHCgHOWHdOoJr2en/o78+
	APv6FgmxttpQTxBQudO4qJwSRmgCSxNh3pQAVI6o=
X-Google-Smtp-Source: AGHT+IG4masltMaevxRMKJ471lFxHbeaLe9lEpEOz6RdTaqnQgxzkAWchzUMWXSGkj3L9K+f4Q+ZOA==
X-Received: by 2002:a05:6512:31c7:b0:55f:67de:343e with SMTP id 2adb3069b0e04-55f68b7d516mr4140045e87.1.1757082928376;
        Fri, 05 Sep 2025 07:35:28 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc25bsm1820494e87.98.2025.09.05.07.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:35:27 -0700 (PDT)
Message-ID: <7563a670-0118-4110-8ad6-7771f22bd046@gmail.com>
Date: Fri, 5 Sep 2025 16:35:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20250831121058.92971-1-urezki@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250831121058.92971-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/25 2:10 PM, Uladzislau Rezki (Sony) wrote:
> kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> and always allocate memory using the hardcoded GFP_KERNEL flag. This
> makes them inconsistent with vmalloc(), which was recently extended to
> support GFP_NOFS and GFP_NOIO allocations.
> 
> Page table allocations performed during shadow population also ignore
> the external gfp_mask. To preserve the intended semantics of GFP_NOFS
> and GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
> memalloc scope.
> 
> This patch:
>  - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
>  - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
>  - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
>    around apply_to_page_range();
>  - Updates vmalloc.c and percpu allocator call sites accordingly.
> 
> To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---

Reported-by: syzbot+3470c9ffee63e4abafeb@syzkaller.appspotmail.com
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>



