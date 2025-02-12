Return-Path: <stable+bounces-115011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6451A32006
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702FD1618EA
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9DD2046A2;
	Wed, 12 Feb 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NUMBZw9v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9720468F
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345607; cv=none; b=W0MbV7t41kf/bRt2hshBi9XswXRbxjQLwLysdTLsUQce5K+pVBCfLMQIf35mxddsFjGc3Z3WvHcStdjLnA51THXrmFxsGtWNFmYpH2KtQbiryWot+1JXZ+ZlTGNjMxSgq9obgwo0/dS9eKPC//OgyDUssUIVs467C2o1Il6Omf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345607; c=relaxed/simple;
	bh=bIFAFWBKWpZ07y7ctOBZ70nTlK0JeLPnASpipllNb7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZwOhL7ZM6lkrTwRmKNL+S5JmTbx8yehD2FZHyHEXzXPzuMY/6M38DjF0uYHuRfKD78ffS3ouVESLV5nKEy/rrTcAlTbFMNqxH9Q/TugdVMkENDwX9DReskR034J3myE5z9OT1AJjGzhQTA5TTxVi50j8KnmxFPx8fra2mdNcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NUMBZw9v; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f6d264221so49427895ad.1
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739345605; x=1739950405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkwC4yo/St1MU9GrbOiGWT5f1H9mKSQMNgvX57ikxsY=;
        b=NUMBZw9vPlXuscejlvYcNB0QaLN/b5qskT0WdWzTG5nm7a9DkMYmYX46tFTHRn3KRF
         mojBEaXe0ZgJdS5qHjlRPD6xSB1VWef1o7+MIIwwaiplQUyOSvR5DMqxAtrlWxLubQ6Z
         dk91FQToMAeSOOLhC69avYWbQ/hVOYk/7bMdKKItrMX8rf1E4ZReor2B3iPNDnjOdtD4
         Gla5JHdCywkWkdx1ll5twsM+h9Q3XaipD7qnK0cuAwqL9lJwydG5dVr7hFg4Ag5m9Y7w
         8j6QuuJrDsOJwHozgdVcPvEzLw2qlcCfvn5ywL+dXldeMzAFmeJf2v8vyyJlKVjvS+yG
         VXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345605; x=1739950405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkwC4yo/St1MU9GrbOiGWT5f1H9mKSQMNgvX57ikxsY=;
        b=F8oTsLSiFp55ji876CQf59facyU1nVd4fVx+jZ55yW8jb6Cs/Va8ymn3TBFGgQDJ1x
         N3FmcGz3bgUnMUcyX1NBtSkoFanhkn7GmshCUw0Fq+9quD7sOS8kesWUufKD6EFqRgES
         WwhZ/Ps1Zct/8b5ggVYv7Aunx6jKp1cyBRQkatZ8WVPOB03QXdDRGfN+SThXkwchovOk
         ASB1R6EwuoGj9jFJotQ96IOSiUaqk5eXC+pXlr81iSUkyTJRBs35/rwakDJYoUw6wMbB
         hhPe617JtQG90HOJf1oXkX+Bx26y3facSTcpH7ja9oyGS85LGVRKvsYJTW4Jz04Y0lhh
         9kew==
X-Forwarded-Encrypted: i=1; AJvYcCXXAjRWT/W+WTWq3YrsrETh1sXMbuB2I/whfBPKeR4B4ZHSlp0J79QIPpxha2UrxETWDQBxUdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPbuGy27VN1Z0ffMt9Yd6lKfWJnwQk3IH0KlSqGGXHbS1Ppn1
	wHJ+aXkAYsWQ2PKRdCZo/ufaWUhc+p0f7jHcHqrzVPazrLK6cmumifuGeeYvjTM=
X-Gm-Gg: ASbGncuP+CjGKzzXZZKqBpJ1zXg3ubhop5j25u34CsmX6THHF5zevOw9MGh+1kuhAAh
	VImxdd2X21eJR+uBbSOAM4hwqXuN2TQq2F5y2dzeOKVfLEg+64Y+u0Ft4FV2qOJMOLEGNQWecrf
	x6A3ISrbQRqzKE+hXgPk6AlXU3iWRO9KHD/y7bUWy2r9V6+Sahg/L/d/y1cejInvibMeJC4gWnJ
	IOp3kuzumlJWp05SpVlflaU0sNaaulNX2EW+LqpGT70FAHIgj8Lpohek0XC6bTA7zjdBe6unyuk
	cT2jvLya29SUpPKmLwC2Yoa9K6Vj9eAX5FyMW5MGjg==
X-Google-Smtp-Source: AGHT+IGiuGc7iBWpCw3G4pXH50ZiqqPYc7UNNfOGWQ0h2PpQXVIqAav7BnmCxlwuHgBLLmHBduzIkw==
X-Received: by 2002:a17:902:fc4f:b0:21f:7821:55b6 with SMTP id d9443c01a7336-220bbae2543mr35144095ad.13.1739345605349;
        Tue, 11 Feb 2025 23:33:25 -0800 (PST)
Received: from [10.84.150.121] ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce0bsm106755595ad.21.2025.02.11.23.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 23:33:24 -0800 (PST)
Message-ID: <2e194c31-c177-496b-8e53-a20625e20a2b@bytedance.com>
Date: Wed, 12 Feb 2025 15:32:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: pgtable: fix NULL pointer dereference issue
Content-Language: en-US
To: Ezra Buehler <ezra@easyb.ch>
Cc: linux@armlinux.org.uk, david@redhat.com, hughd@google.com,
 ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <be323425-2465-423a-a6f4-affbaa1efe09@bytedance.com>
 <20250212064002.55598-1-zhengqi.arch@bytedance.com>
 <CAM1KZSnWFivV-7nc55MBAEtdP1LXfW4eLKa-94HPZaTP0AOPrg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAM1KZSnWFivV-7nc55MBAEtdP1LXfW4eLKa-94HPZaTP0AOPrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ezra,

On 2025/2/12 15:27, Ezra Buehler wrote:
> Hi Qi,
> 
> Thanks for the fix. I will test it as well as I can.

Thanks!

> 
> On Wed, Feb 12, 2025 at 7:41 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
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
>> Reported-by: Ezra Buehler <ezra@easyb.ch>
> 
> Perhaps a detail but, maybe better use "Ezra Buehler
> <ezra.buehler@husqvarnagroup.com>" here.

Got it. Will wait for your test results first.

Thanks,
Qi

> 
> Cheers,
> Ezra.

