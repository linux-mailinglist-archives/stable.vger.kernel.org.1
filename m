Return-Path: <stable+bounces-118370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74FA3CF48
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 03:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E12C16A83F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17735942;
	Thu, 20 Feb 2025 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eVWQ4fJr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCEF11CBA
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017809; cv=none; b=hiCEyQ6b+aEYsobH2IVYtD5mmciLlvlwyub9BrsiG7njhLEcbqUWbBmlt4Yk7qpORtbLIUAKbrK5VGa1fp/imiVJa24sHqO8a5C5qj3b62PWl0MTXm7nMXNqsKuwRMmADF/M8M+SBq/vraD6d4sF0+Va6Rn3bYaR3m0acQmTjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017809; c=relaxed/simple;
	bh=JpgwqCB8zCvfhKFjCKWpOWkLduzHfEVVSLa2+KR6ff8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUMXodMCFGmXmUEspLLWWrsniRpoeXOk+1r0o4MvPcgBnc4RIVyk6xq9o8q9q9l6UExHZpFuxSR3bRbU1sbNyGdEPuK8t/ZDfyQi2TD4g+T7eSNkxm+AVsYL7c6vk9IbYjrNibaKsq9zdL0IyXWMRoyJLmcS432sy52ZDQPLM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eVWQ4fJr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2211acda7f6so7370115ad.3
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740017806; x=1740622606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPJrUAVVU255VluMM4NRpdJMTLeQod8b802zAHP71IM=;
        b=eVWQ4fJrbDm/hRIj4z77Ol2JY6hp64u3tw0UImktGDE9KkDu3CrsXVeLUQwqiBI/Y0
         YAt8e40n9HUcZOwrm1PSt0teiEKyHUJz7805TI97mmaYPP9ghQHkgFarOf+PPMA8J3zJ
         0rrMtcoHW3OTUn++ZKqbzyrSUxsDI2SETcJ1zi6kRDc2kl0mBuwtTrFQR2AcIE7Ag1zZ
         MgANAFSe63RM4OIzuJsCqYN6IWlTTkCel1LkYXPx7qaEC7yx15TZI/bnU7QyIqBMp2Xu
         JazMyuXelIBeMg5O4YVq4TrPCbMQSLsqJIgNmI2EhqBNq1KBqmYRQKxQGVDFC+F5q1uw
         11Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017806; x=1740622606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPJrUAVVU255VluMM4NRpdJMTLeQod8b802zAHP71IM=;
        b=D4Ye3cIT+hLm7fJRrbMIsk57J9Ujode2MNa4mjYJZ5H2/FUWuu2JE9GU4NMOrr7mbA
         5+ak5bZStx4+P3+GadIv5u1crxa/CNQ/zo9c8KZKxiAJg9kFnFUhYYcF19gNcOyhMhvH
         I/xp9WV+28TwKHh9LUlCk3okkNopW307tmPyQDsx4RcAuPpvjP6GQGIIeYkt+n/XomL3
         jTfaKPzIEPqdbE7plp+Y4iRtQS4ZbCXwALpYAM9Tus7TnZXOIWjWd1btqWE9CHdc8y1M
         zZvdF0i51EnS9A17eFA7d4Zj9mRlSzTZdcW5WbK/rGLE87gH6/4C/GxZ51OR6yF5mlkb
         bpSg==
X-Forwarded-Encrypted: i=1; AJvYcCUN8xHK8rjCxp7LtUYRx/hK7kiC2x1d4hhNLsW21y7rkX+8uY8f/NSC36NEP2fxdQHbGBxadm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8Lz9r6NV/L4l+mGwQtLw7I/w8g1mR2YPLofGf68z9rs/Py/A
	aYwzUey+S6kYzJSRCuwmylviWp1/shnRbWFpCLaP9b92x1ZkV/6EaShm9kbCCDw=
X-Gm-Gg: ASbGnctTsJlWng39olyVqxpu6foUqsMsP07FYbV3FiFkvUmTlIu2ROmx0fhDy9NtTZA
	QgoimndqKEnoxvnBW5vnbBgv3vmAkFCuvX5D6mUA5ax4r3riiMCJeW9KNRDxTj1WUq/hwVAxmoR
	SMW+392yiqurkTqXe4NFf9aGaQRh42o/a135uTezYfgZfjpfmyXE558Iw4S8xi/coeynna4cPdS
	l2QhXw91cJvFXp4ROw/9EydP5BAHSEBFusqZvqu812QKiqSgdGo+7Grf6E05Wuze9w6U8moFeaM
	ML7pIa3oM+RCYmECBUKHMfWLtSttTDxIWCpH/YHn
X-Google-Smtp-Source: AGHT+IHsrTf+2IUgEuka8Rdp79QumYTvBN07QjGvbatNc0HfOYKuhS5UhceZtzQLSBZ2eikrfT+dcg==
X-Received: by 2002:a17:902:f609:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2217119ecc7mr89900345ad.42.1740017806519;
        Wed, 19 Feb 2025 18:16:46 -0800 (PST)
Received: from [10.84.150.121] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22116f0c907sm69252675ad.222.2025.02.19.18.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 18:16:45 -0800 (PST)
Message-ID: <5c5232ee-4b4d-42a1-9be9-3489f93f7590@bytedance.com>
Date: Thu, 20 Feb 2025 10:16:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: pgtable: fix NULL pointer dereference issue
Content-Language: en-US
To: Ezra Buehler <ezra@easyb.ch>
Cc: linux@armlinux.org.uk, david@redhat.com, hughd@google.com,
 ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ezra Buehler
 <ezra.buehler@husqvarnagroup.com>, stable@vger.kernel.org
References: <20250217024924.57996-1-zhengqi.arch@bytedance.com>
 <CAM1KZSnM-imYwM5Gf4gw8yXr1+6PXyLvbpKbBu_KJmPR0WS7cA@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAM1KZSnM-imYwM5Gf4gw8yXr1+6PXyLvbpKbBu_KJmPR0WS7cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/19 18:58, Ezra Buehler wrote:
> On Mon, Feb 17, 2025 at 3:49 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
>> parameter is NULL, which will cause a NULL pointer dereference issue in
>> adjust_pte():
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 00000030 when read
>> Hardware name: Atmel AT91SAM9
>> PC is at update_mmu_cache_range+0x1e0/0x278
>> LR is at pte_offset_map_rw_nolock+0x18/0x2c
>> Call trace:
>>   update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>>   remove_migration_pte from rmap_walk_file+0xcc/0x130
>>   rmap_walk_file from remove_migration_ptes+0x90/0xa4
>>   remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>>   migrate_pages_batch from migrate_pages+0x188/0x488
>>   migrate_pages from compact_zone+0x56c/0x954
>>   compact_zone from compact_node+0x90/0xf0
>>   compact_node from kcompactd+0x1d4/0x204
>>   kcompactd from kthread+0x120/0x12c
>>   kthread from ret_from_fork+0x14/0x38
>> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>>
>> To fix it, do not rely on whether 'ptl' is equal to decide whether to hold
>> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
>> enabled. In addition, if two vmas map to the same PTE page, there is no
>> need to hold the pte lock again, otherwise a deadlock will occur. Just add
>> the need_lock parameter to let adjust_pte() know this information.
>>
>> Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>> Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
>> Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Tested-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> I confirm that this fixes our issue on the AT91SAM9G25-based GARDENA
> smart Gateway.
> 
> However, unfortunately, I do not have a 4-core ARMv5 board at hand to
> test the CONFIG_SPLIT_PTE_PTLOCKS case.

Got it. And thank you very much for your testing!

> 
> Cheers,
> Ezra.

