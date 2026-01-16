Return-Path: <stable+bounces-210052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDEFD31D1A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C760F301FF41
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC927586E;
	Fri, 16 Jan 2026 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFa9mYQk"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E08236435
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570018; cv=none; b=dY6Dfqm/z7IDRxdjtKs5vi0umEQQAfXqJECtknhkSWhA6nmNYOTFxOKxj3vFktsZmDESzEQe0yFRlQcx8D+RmxNMq/CbrBSFBAho0cURqaAmmATSi1wPo127YwP4b5vbUnAEYxYk02xhHnBkWYUeyzSjpke1DbTeL6lPhJdH09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570018; c=relaxed/simple;
	bh=OJOIrAKXmCyYwHMq+sthvkD+GOMMjdvOgzut3HECV54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBVCm7h0TMkMYa2IwIQ7Wm4AUtiaLtlweSP/EEh26s+3oXR2FmLyvHyvG3LJuucnfD32wu+qUh7LamwWyIJ3RcZlX829/FwdVTye/kGHPdOcak6qHidT7FTTB56ugEXA9JSIfFqDO8zz08JlltDdeR46zku+2YcDmE3lBPgZ8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFa9mYQk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b9fee27ccso254760e87.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768570013; x=1769174813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0eA49DHdlAf9Bft0pCk6JLi/3Gfwpf8alD37YhIJQ0=;
        b=fFa9mYQkfjtc/79UiBCcc636nlyI8Pk0gG7Hb1F/J0remmW+Tbfr6ssPDZPpEfP0tn
         dM01V/UaPoacdgrjAPQz/HXedbIpPDUTYmdKJwQ36Qyx+yLfVGG+DrdpeB1/W9B0D95t
         GqEr55gu3/cqc3nNub/uRF9/Y4HFpfmBVNJonMyBAXj4fcmFmIlSnyuyy+eKwDD+c9kK
         FNM3ELjxXs5YCsnEdsLkl/Hxe4PxnCbh3ZNl5EsWSyFJFRKy5e/gADosBe/VNo8r0LeE
         bIGUVpRIpD5pXfKSk2JmNOvBE6mrKk9hBFgZ8BBmbuhMBiilng6jURVOV3aRErpTXto0
         Sp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768570013; x=1769174813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0eA49DHdlAf9Bft0pCk6JLi/3Gfwpf8alD37YhIJQ0=;
        b=qoC7lz0lMBaSMYw5N6xe1UOkyrTmesWvwsSzTByOZb2cUbVpldKOQrt4UB3kRc8rb4
         cZPxh16+WVsdRQsBcfSSSxeJWv9/oHO1OFCf7q/bA1voDcbC8AA52DrRexxm+h70f4AC
         O4mgZSXKBWPk90yfcmBnl88cvcxgoBcCeBMCxzYIZonjuhIYTD+O0ol5ajq4gyxiZ8XM
         t+smSagwC1w4ZNesEEmJWYUQedTO3Ioz1PbtdAxuDG+D9CpL1cMnSZXeHPaE2lVOO27Z
         ZdApgcV1bwG3QYhw6UT4z9vYyhRMsmEJEGEeB4aPyHM0oBAlQuRAz67uxm5MOmzdrMd2
         sm+A==
X-Forwarded-Encrypted: i=1; AJvYcCXNO+K8D29twwG/PFFWz00vTHCH9LY5HXyLniwDYSLN1cgTzJsaIORe0/UknbEQNuxSf0PKIHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhNUae+SZ+YmzGaagWbmXESU6XWh/J5IEQf1Qyjmd45Iar5roE
	n0ng5sZbqx1XEYDYbQnxiZk8/C56OokxbYAlXk0ZokcoorEraBF2dB7p
X-Gm-Gg: AY/fxX4Dcq/j9wj7p3cEIwvsgM8uIwGlThc3tfxEkUPJI3j7TOXXoYWc8wqwWXC0NhN
	kOKmsxbmMLRizweS8FV5BIuTuncA5CbTurfUUtz0BxEn0SnUkdwuGaTQJoK/TT38H/w6Y5bPI2o
	HIYt4KxqXyd6nefROy3NcQROsRPRAQB3MImYOe6KOhSimUx2xzNoTJTjRSMNdX/60b9yTUgW/h1
	1r0P2fJY05Qo0IDerSj0WuvAJklHnXUoYKu0yTdt6sUyfPl2Vob1dkrjZBxmdgjZDgE/ayhcxDn
	zNKtlej5uDCX1uDjFXbUXRyuTKhHuSPXWOJG41gWTlJcuwMJleyVMg/pkYfZ18Nxnp1evV5ywFL
	/xHcDK6dlqCTCVNdG78hpAFvbEezDgTr5ShgkADvabq/YdnEt13DvXhrMm68kYq8G0Q3ZHqyfd3
	pnzVUHb5Y2cBc8T6MNuw==
X-Received: by 2002:a05:6512:63d1:20b0:59b:7be4:8c40 with SMTP id 2adb3069b0e04-59baef130e4mr407353e87.8.1768570012429;
        Fri, 16 Jan 2026 05:26:52 -0800 (PST)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf35273dsm782709e87.39.2026.01.16.05.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 05:26:51 -0800 (PST)
Message-ID: <10812bb1-58c3-45c9-bae4-428ce2d8effd@gmail.com>
Date: Fri, 16 Jan 2026 14:26:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/kasan: Fix KASAN poisoning in vrealloc()
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, joonki.min@samsung-slsi.corp-partner.google.com,
 stable@vger.kernel.org
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
 <20260113191516.31015-1-ryabinin.a.a@gmail.com>
 <CA+fCnZe0RQOv8gppvs7PoH2r4QazWs+PJTpw+S-Krj6cx22qbA@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CA+fCnZe0RQOv8gppvs7PoH2r4QazWs+PJTpw+S-Krj6cx22qbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/15/26 4:56 AM, Andrey Konovalov wrote:
> On Tue, Jan 13, 2026 at 8:16 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:

>> ---
>>  include/linux/kasan.h |  6 ++++++
>>  mm/kasan/shadow.c     | 24 ++++++++++++++++++++++++
>>  mm/vmalloc.c          |  7 ++-----
>>  3 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index 9c6ac4b62eb9..ff27712dd3c8 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -641,6 +641,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
>>                 __kasan_unpoison_vmap_areas(vms, nr_vms, flags);
>>  }
>>
>> +void kasan_vrealloc(const void *start, unsigned long old_size,
>> +               unsigned long new_size);
>> +
>>  #else /* CONFIG_KASAN_VMALLOC */
>>
>>  static inline void kasan_populate_early_vm_area_shadow(void *start,
>> @@ -670,6 +673,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
>>                           kasan_vmalloc_flags_t flags)
>>  { }
>>
>> +static inline void kasan_vrealloc(const void *start, unsigned long old_size,
>> +                               unsigned long new_size) { }
>> +
>>  #endif /* CONFIG_KASAN_VMALLOC */
>>
>>  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
>> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
>> index 32fbdf759ea2..e9b6b2d8e651 100644
>> --- a/mm/kasan/shadow.c
>> +++ b/mm/kasan/shadow.c
>> @@ -651,6 +651,30 @@ void __kasan_poison_vmalloc(const void *start, unsigned long size)
>>         kasan_poison(start, size, KASAN_VMALLOC_INVALID, false);
>>  }
>>
>> +void kasan_vrealloc(const void *addr, unsigned long old_size,
>> +               unsigned long new_size)
>> +{
>> +       if (!kasan_enabled())
>> +               return;
> 
> Please move this check to include/linux/kasan.h and add
> __kasan_vrealloc, similar to other hooks.
> 
> Otherwise, these kasan_enabled() checks eventually start creeping into
> lower-level KASAN functions, and this makes the logic hard to follow.
> We recently cleaned up most of these checks.
> 

So something like bellow I guess.
I think this would actually have the opposite effect and make the code harder to follow.
Introducing an extra wrapper adds another layer of indirection and more boilerplate, which
makes the control flow less obvious and the code harder to navigate and grep.

And what's the benefit here? I don't clearly see it.

---
 include/linux/kasan.h | 10 +++++++++-
 mm/kasan/shadow.c     |  5 +----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index ff27712dd3c8..338a1921a50a 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -641,9 +641,17 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
 		__kasan_unpoison_vmap_areas(vms, nr_vms, flags);
 }
 
-void kasan_vrealloc(const void *start, unsigned long old_size,
+void __kasan_vrealloc(const void *start, unsigned long old_size,
 		unsigned long new_size);
 
+static __always_inline void kasan_vrealloc(const void *start,
+					unsigned long old_size,
+					unsigned long new_size)
+{
+	if (kasan_enabled())
+		__kasan_vrealloc(start, old_size, new_size);
+}
+
 #else /* CONFIG_KASAN_VMALLOC */
 
 static inline void kasan_populate_early_vm_area_shadow(void *start,
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index e9b6b2d8e651..29b0d0d38b40 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -651,12 +651,9 @@ void __kasan_poison_vmalloc(const void *start, unsigned long size)
 	kasan_poison(start, size, KASAN_VMALLOC_INVALID, false);
 }
 
-void kasan_vrealloc(const void *addr, unsigned long old_size,
+void __kasan_vrealloc(const void *addr, unsigned long old_size,
 		unsigned long new_size)
 {
-	if (!kasan_enabled())
-		return;
-
 	if (new_size < old_size) {
 		kasan_poison_last_granule(addr, new_size);
 
-- 
2.52.0



