Return-Path: <stable+bounces-318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C97F7937
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEFB2100E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B034196;
	Fri, 24 Nov 2023 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q9KBIJi6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2412700
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 08:35:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cf974e87d9so2685555ad.1
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 08:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700843747; x=1701448547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umaTYGfWT75d/2LbUos91FPz5jE7hHq6AI8iIDAt57w=;
        b=Q9KBIJi694g3xQzBKNao1xTBWatXLVqXhwrGT8/kjCFrt1jrXDhwnJlxU7HF5bfUhh
         dScokSCNTZuvlhdq0tSw++oTrLkpO7W3dJlAJgl8Ao0k9xiK0JWPJFahsnh8wryM9A97
         HDXuSjvIoZbRG5oSB6Kou4mb3VZuB2+I875LCJMzY6WuE3g/wHO6i3koWWpBmt1ZvcQ8
         9bWreW8jjlpDvBx35rTYnrx9ygjJPVnTycfCdlPoIIJX/bRRnd3Ym2QvAFOcFZ4v7iil
         AkMOID5eIYpHzY2uyL76z0INPurhSRloTvX/3EQV1WyulGCQTykmsbKS7wthlPB2jR1n
         Dwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843747; x=1701448547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umaTYGfWT75d/2LbUos91FPz5jE7hHq6AI8iIDAt57w=;
        b=UTke/sHB938wmzMilm3K5T1BtnLQCN1Fomxij+3zui4qyXQwx2ZC/I/pkG5PO/RNS7
         XMeKDFKofTkBiAS4143vif5snzGVwRAJD8xonjYxotxrbBq7FcbfFMaw6H/FXUv3R90a
         GtaZDbr7/MBQ4XNVqrpiDD9cQNfR+/pEt1sV8XaCDjIKNO+/ScOCu8Q/i+vz72S7MvAl
         d2EmRWCJUxg/OwjmsU7sSeYmuWS5CT4vUUHKiImiMja/86PgwH1VyQqoXddkqsA82Zvg
         vlHC1n0IkHpdDTL6rf015B9FMCXFHUVvm2A6iYE0CpfqfUAyxBhC+uRxe+gAxwwCaZBP
         koJw==
X-Gm-Message-State: AOJu0Yzjy00w5B7a13iGc8Y7jy2jRXRobOF/LvqCaWbuHnExkfwCHb8s
	RCxPum7TuEJTTp+XOzrzZxd32g==
X-Google-Smtp-Source: AGHT+IF4OxYiK6UIPy07lB8oGULkD1T35JFCzcc1vTX/Rscsd9lOnMQqTSfCRewL5umAqo+qCwX2nA==
X-Received: by 2002:a17:903:181:b0:1cf:5806:5634 with SMTP id z1-20020a170903018100b001cf58065634mr3688152plg.1.1700843738508;
        Fri, 24 Nov 2023 08:35:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001cf83962743sm1803081plq.250.2023.11.24.08.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 08:35:37 -0800 (PST)
Message-ID: <11a7d768-c6e7-4a6e-875d-87858bf023a5@kernel.dk>
Date: Fri, 24 Nov 2023 09:35:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR
Content-Language: en-US
To: Coly Li <colyli@suse.de>
Cc: Markus Weippert <markus@gekmihesg.de>,
 Bcache Linux <linux-bcache@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Zheng Wang
 <zyytlz.wz@163.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Stefan_F=C3=B6rster?= <cite@incertum.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZV9ZSyDLNDlzutgQ@pharmakeia.incertum.net>
 <be371028-efeb-44af-90ea-5c307f27d4c6@leemhuis.info>
 <71576a9ff7398bfa4b8c0a1a1a2523383b056168.camel@gekmihesg.de>
 <989C39B9-A05D-4E4F-A842-A4943A29FFD6@suse.de>
 <1c2a1f362d667d36d83a5ba43218bad199855b11.camel@gekmihesg.de>
 <3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de>
 <c47d3540ece151a2fb30e1c7b5881cb8922db915.camel@gekmihesg.de>
 <B68E455A-D6EB-4BB9-BD60-F2F8C3C8C21A@suse.de>
 <54706535-208b-43b5-814f-570ffa7b29bb@kernel.dk>
 <910112B4-168D-4ECC-B374-7E6668B778F9@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <910112B4-168D-4ECC-B374-7E6668B778F9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/23 9:34 AM, Coly Li wrote:
> 
> 
>> 2023?11?25? 00:31?Jens Axboe <axboe@kernel.dk> ???
>>
>> On 11/24/23 9:29 AM, Coly Li wrote:
>>>
>>>
>>>> 2023?11?24? 23:14?Markus Weippert <markus@gekmihesg.de> ???
>>>>
>>>> Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
>>>> node allocations") replaced IS_ERR_OR_NULL by IS_ERR. This leads to a
>>>> NULL pointer dereference.
>>>>
>>>> BUG: kernel NULL pointer dereference, address: 0000000000000080
>>>> Call Trace:
>>>> ? __die_body.cold+0x1a/0x1f
>>>> ? page_fault_oops+0xd2/0x2b0
>>>> ? exc_page_fault+0x70/0x170
>>>> ? asm_exc_page_fault+0x22/0x30
>>>> ? btree_node_free+0xf/0x160 [bcache]
>>>> ? up_write+0x32/0x60
>>>> btree_gc_coalesce+0x2aa/0x890 [bcache]
>>>> ? bch_extent_bad+0x70/0x170 [bcache]
>>>> btree_gc_recurse+0x130/0x390 [bcache]
>>>> ? btree_gc_mark_node+0x72/0x230 [bcache]
>>>> bch_btree_gc+0x5da/0x600 [bcache]
>>>> ? cpuusage_read+0x10/0x10
>>>> ? bch_btree_gc+0x600/0x600 [bcache]
>>>> bch_gc_thread+0x135/0x180 [bcache]
>>>>
>>>> The relevant code starts with:
>>>>
>>>>   new_nodes[0] = NULL;
>>>>
>>>>   for (i = 0; i < nodes; i++) {
>>>>       if (__bch_keylist_realloc(&keylist, bkey_u64s(&r[i].b->key)))
>>>>           goto out_nocoalesce;
>>>>   // ...
>>>> out_nocoalesce:
>>>>   // ...
>>>>   for (i = 0; i < nodes; i++)
>>>>       if (!IS_ERR(new_nodes[i])) {  // IS_ERR_OR_NULL before
>>>> 028ddcac477b
>>>>           btree_node_free(new_nodes[i]);  // new_nodes[0] is NULL
>>>>           rw_unlock(true, new_nodes[i]);
>>>>       }
>>>>
>>>> This patch replaces IS_ERR() by IS_ERR_OR_NULL() to fix this.
>>>>
>>>> Fixes: 028ddcac477b ("bcache: Remove unnecessary NULL point check in
>>>> node allocations")
>>>> Link:
>>>> https://lore.kernel.org/all/3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de/
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Zheng Wang <zyytlz.wz@163.com>
>>>> Cc: Coly Li <colyli@suse.de>
>>>> Signed-off-by: Markus Weippert <markus@gekmihesg.de>
>>>
>>> Added into my for-next.  Thanks for patching up.
>>
>> We should probably get this into the current release, rather than punt
>> it to 6.8.
> 
> Yes, copied. So far I don?t have other bcache patches for 6.7, I feel
> I might be redundant if I send you another for -rc4 series with this
> single patch.
> 
> Could you please directly take it into -rc4?

Sure, I'll just grab it as-is.

-- 
Jens Axboe


