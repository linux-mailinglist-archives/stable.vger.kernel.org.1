Return-Path: <stable+bounces-171911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C7B2E0D1
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F64724EC3
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED4322525;
	Wed, 20 Aug 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFUsRoOa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43632C33D
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702082; cv=none; b=cmGNhbyWSD2UGf6lhxORp0a7JuEcWoPc2SAG0x/xKM0lObXkfGIvzyhw1x36dYrwl6YMDl75UL7FzfSSBp/X6ON6XdV1uC2uPGFDWPMFj8v6Hvl8p1p/Bk0PLzQgFCRoL7RasbpsGfTKb4YO8HOU+jPntF2Yyj2Q89xqd9FdUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702082; c=relaxed/simple;
	bh=6gEmHkM14QPzyBQEA5Bg2D6rO0vix/Ka6k76W9AzT0Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pvPG8sOkjqHTtHln0wx31Jf5yS4VLK3blWaBq4DG/i47LwJTnx7+9hwUS5t4ixnnrHCfr9WDOm/1593EhotfgvIxrLQyO+4KRrpSSL/eQa8i3tXRWXsj5sS8lIDx+X/4R2ZAykDGrMGDIfugDvCKkPH3YBwrqELwaRyAt69LTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFUsRoOa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755702078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwru5TX1hmNs5+ufZgj22qd45pHx0gD1JqlHAKNhi/Q=;
	b=HFUsRoOaV1x4ejg6fxo6Vy6o29i0iSgk60CkcXy5hHk7s2DPqVR2Zo61ijkhLnSVLYX4tG
	CHkxpHxiPxSjIV1aGyIieTLThtUzgp7XTcgeBIfAWttVn96XZreqMcypp1/nAniHRQ+Yol
	9X53G2fjSOIzkFXM32yZ+44XYNhJloc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-3qjAI0ZJOLSPeZOlv30r4w-1; Wed, 20 Aug 2025 11:01:15 -0400
X-MC-Unique: 3qjAI0ZJOLSPeZOlv30r4w-1
X-Mimecast-MFC-AGG-ID: 3qjAI0ZJOLSPeZOlv30r4w_1755702075
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870623cdaso1687576985a.2
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 08:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702075; x=1756306875;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uwru5TX1hmNs5+ufZgj22qd45pHx0gD1JqlHAKNhi/Q=;
        b=GvxgXONqgDp+9yCci8KNZTk+nu2/qCdUYTFxJW4wJ+0UnzTyTf/DMFku1EXCNbMKci
         MiJ4+Z2V6P4CeTpSfn3ariYRW9tv0hsskKLEt8a4Peps0VKwE1rl6YTV7tWPvmbrFEpv
         1mIwz1r/PNvMkBh3HanyAPfPrU0Vfw85q5GbVibM700ByK41lg5z0ccjMIydJqPnuSZd
         2iRwSv0/l8IZjc50kxr2BaAnNbBcS/pXEaMLv8XLGjQkrg8VY17lf5iRBGsLzE8ZlY14
         L646BDowKt02UpEEFeLH5UnQF1CSn6Co6e5g2zIu1KoyoHyPhZbC7VU5P0B/9/HuN/kH
         L6fg==
X-Forwarded-Encrypted: i=1; AJvYcCX8arXRyv3UCNyTLPe8jOZSQxq+JzV3i2oUmSDQLqu3FuCmdk2id3r9/wxQLL1ArNrcMlGKMFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgkZxMKb42FFnBFNID8S/eW3zW6kMo45vFguT32c4Zpoq+HG6
	o78fIkh0SIZZiJxcN02q7eaizpRukdBLBJuGpdHvHl+bq/CWqO+2O5i///JUjbQh/QTo/rdc8kk
	5/uh/INGXRCIXPeS/QQ9N0U2XTlswV5XZ2qRUhZFaJ2CAFEdXsRu1dZFB2A==
X-Gm-Gg: ASbGncv1JB5jr41TUTu0X7lDnSEFQsO1djh/rTJ1jCJ6uYCTDgE2VuQK/pVypXHVOe2
	/JVkUY2yhPO/zjeXVNhFQP9GpCcLyHsIaCsYbxj+ZJp7zoIHxraZAniPeZszyprRll6D4xZpWVY
	MLwcXGbHr8E7k613ZvHqrbGAq8h5VJ8UYMatsbuXe2DVgnzJVrFw5Ts4GUQUpABAWlOcZA1Swe+
	Z2C+53J3xPHWnhIwI/FspKZ0ewgnLPFQ+KO5HTiR91D+tnoa0H+GhSfHpHcv2uTyfDkE71jo/83
	X+bz5dOnWUFiDiqBKPM7VnQxRj1jHth6LbOyj0zBV8+urO2W1x51dYDKUKDTBWPvdPX9r5iOYPn
	ZXScV6c3dSA==
X-Received: by 2002:a05:620a:31a5:b0:7e9:f820:2b6d with SMTP id af79cd13be357-7e9fcbb49a1mr336170785a.67.1755702074371;
        Wed, 20 Aug 2025 08:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpAS/Pt2OG3esrr44EOu9shr1hzAACYm7jBC9DIaE1fQJhgngoOzDQG85RivoDlvbLssSO9A==
X-Received: by 2002:a05:620a:31a5:b0:7e9:f820:2b6d with SMTP id af79cd13be357-7e9fcbb49a1mr336045385a.67.1755702064230;
        Wed, 20 Aug 2025 08:01:04 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e027290sm969604785a.5.2025.08.20.08.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 08:01:03 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fed73718-8001-4db6-af36-86c60e85d224@redhat.com>
Date: Wed, 20 Aug 2025 11:01:00 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
To: Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <llong@redhat.com>
Cc: Gu Bowen <gubowen5@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-mm@kvack.org,
 Breno Leitao <leitao@debian.org>, John Ogness <john.ogness@linutronix.de>,
 Lu Jialin <lujialin4@huawei.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
 <113a8332-b35c-4d00-b8b1-21c07d133f1f@redhat.com> <aKWrSfLD5f1r5rg_@arm.com>
Content-Language: en-US
In-Reply-To: <aKWrSfLD5f1r5rg_@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/20/25 7:02 AM, Catalin Marinas wrote:
> On Tue, Aug 19, 2025 at 11:27:23PM -0400, Waiman Long wrote:
>> On 8/18/25 5:09 AM, Gu Bowen wrote:
>>> @@ -858,8 +870,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
>>>    	object = __find_and_remove_object(ptr, 1, objflags);
>>>    	if (!object) {
>>>    #ifdef DEBUG
>>> +		/*
>>> +		 * Printk deferring due to the kmemleak_lock held.
>>> +		 * This is done to avoid deadlock.
>>> +		 */
>>> +		printk_deferred_enter();
>>>    		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
>>>    			      ptr, size);
>>> +		printk_deferred_exit();
>>>    #endif
>> This particular warning message can be moved after unlock by adding a
>> warning flag. Locking is done outside of the other two helper functions
>> above, so it is easier to use printk_deferred_enter/exit() for those.
> I thought about this as well but the above is under an #ifdef DEBUG so
> we end up adding more lines on the unlock path (not sure which one looks
> better; I'd say the above, marginally).
>
> Another option would be to remove the #ifdef and try to identify the
> call sites that trigger the warning. Last time I checked (many years
> ago) they were fairly benign and decided to hide them before an #ifdef.

A bit more code change required the printing is moved.

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 84265983f239..eb4e0af5edba 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -856,13 +856,8 @@ static void delete_object_part(unsigned long ptr, 
size_t size,

         raw_spin_lock_irqsave(&kmemleak_lock, flags);
         object = __find_and_remove_object(ptr, 1, objflags);
-       if (!object) {
-#ifdef DEBUG
-               kmemleak_warn("Partially freeing unknown object at 
0x%08lx (size %zu)\n",
-                             ptr, size);
-#endif
+       if (!object)
                 goto unlock;
-       }

         /*
          * Create one or two objects that may result from the memory block
@@ -882,8 +877,14 @@ static void delete_object_part(unsigned long ptr, 
size_t size,

  unlock:
         raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
-       if (object)
+       if (object) {
                 __delete_object(object);
+       } else {
+#ifdef DEBUG
+               kmemleak_warn("Partially freeing unknown object at 
0x%08lx (size %zu)\n",
+                             ptr, size);
+#endif
+       }

Anyway, I am not against using printk_deferred_enter/exit here. It is 
just that they should be used as a last resort if there is no easy way 
to work around it.

Cheers,
Longman


