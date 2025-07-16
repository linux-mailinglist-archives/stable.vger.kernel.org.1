Return-Path: <stable+bounces-163189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CADB07CB0
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CD116A660
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0A29A9C3;
	Wed, 16 Jul 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxgV31RK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575D28DEE0;
	Wed, 16 Jul 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690092; cv=none; b=B++epSzWGCwUMRSgz+5akP/VU/VrEuI1kiPdjFee9ORVd3ATsTglEKoSyiYjTuWFfWBbaVdnyjM+Ex1LzZzNJg4EdCmKKgKfK1u3fpiTkvuDyrTxfhda8pJNaIBvi61/gr7MMv9gkEBgaXPkVNrj8qmawpAeaWcRNPctQiYtdrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690092; c=relaxed/simple;
	bh=ok3c5KMhFBYZDlSSRZJA+MwBVa91RHrRE2gQ1sQeZ8M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ape4yyQZfKnRw3Cdw64YnQ0w11jKo7OrmuPJ6p4jwdySjRld5+adIdgQ5W/i1tG/PXzMWVA4zue1hqDGxORa83SaIrwPa0MN4Gyaf+W3ofnIM51c6yPjVPz/tovtemCFiGZajek8FZVaQkD6V92qBHgNoiAE15CDHGJhfrfnByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxgV31RK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55511c3e203so151950e87.3;
        Wed, 16 Jul 2025 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752690089; x=1753294889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnrCFtIVZL8hyVV2JzefY+gIDN+ezQ0AtgNK2sjo+OQ=;
        b=BxgV31RKnRlLl0MzYggKqfveEGT+J/GJZi3VIkasOMDp56O3flLZwK1ya919gBguLD
         bNE4geDbvVoVJG+eqe5fX5gcTQxqXnodoD7ycpf/38nmU5HCSazzHidukN0Tjd6PtUWC
         P0itsOon68haHvAb4c7NC4AtyJOr7AE2KZbe7y8Zqq1lZC/TBMRDeBZ3R3O0aFwDDYyo
         VlthEAbXGiiO+foLUjkpx7FyiZFVtQY9C+Oeew+zmeEhIW5jGSFr4XFtwpowGm/7lPaK
         aTxfEbQKBS7dVWOlNi8yUydbSbDJyHZAp6eTeI9m8gXrhdhBSGyuzDH6IPw0gcl0o9hW
         Vsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752690089; x=1753294889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnrCFtIVZL8hyVV2JzefY+gIDN+ezQ0AtgNK2sjo+OQ=;
        b=lVyqcu0iOEIomh9grMELQI3mV8zk47pzsvAiovlIMi0NgaAZuB9785fqzrba4+a1VI
         CCD/5vnwaYZDfRKN2HdHeCb+B7Hv+5zKD6UuN3Z5yEzWeJWnhgRHD0l3zeeSGTG7lUTQ
         2vj+E4LV3Eiaw3jwNyNl9t1P9j846vzpKMw8LCcoZiJpmzsxf4z/zHfVPm1CpUNc48p2
         Sa20ZD4sHzmQdZri7r8CU4c61i9Ujlw80Gqo5Zpw6o9hQQV0wJqoaPB1UwLoJFNZBMRj
         eNVzAf4WAhV16pLootH9hvKLxL59VpcRqryhVK3rEg6p67Y9D23nvZ0I1XZbUkB4h+mY
         G/UA==
X-Forwarded-Encrypted: i=1; AJvYcCVS92TIC8XGhg/L6zgenNPzilynitvZApVILrCEgH7TEjTvhCbs2NruRsT4G2Lk2uXFi99+Oy+RDbfgSAo=@vger.kernel.org, AJvYcCVk2XKyyhaj9Ilf6v/1yxT99pBwvBMvRV11FwW03ZbAGOEyOvjXeUjC8Jbt9BgcgKiCmotTXI9t@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6jqVU5Or+ZHmPQu6XSCcqJRWSlhTk48YU0P8GdlJE/zQlL7W
	n0+Q1bTajUKaFVBksH6K1MzO/bKwmvSWx7vI8HHri/88sKH3W1ZvJaDCYAD5q849
X-Gm-Gg: ASbGncs5QflQuQtCmfKBvZgq0bdRFntXVU/8bf1pTvKbuXdLqDyTAB26EJ22Rc1XSPX
	9WlnrKdjwuzVF9ARxJLccBYZ1N/NwNS2P3ewHRY4xW6gyH7ZOAvIcX60sZp2id1+jVp6IEmO0Rx
	31tCAHWthRkH0qSog4r4uNJ7ha1RrQzVirhTPp6VbQ2OW96pRq18zMCaPPNpodXVPnxlHWkZ3V0
	4IQvVYmjnmrDAvaPSIxGEcsenJvpXVoqs24q6XffdtM45vrWtEbrUO0Igu9GIuT8iBue7rVoz3K
	OUXHNaRGYQLCP5znSZwXV3Hm377p/ynA1Z1qqd5qm0GIeTf04o8tsPn61uKHMw/Er6GmjqJuB/t
	NgI6cVg9IGQHJAja/He0/mB3/LepCiVnl1TKH93la4q+i3JO2QaENqFW45Q==
X-Google-Smtp-Source: AGHT+IEQz/zAiPjsnW5zYim84jDmcgUqNS4qYdyO0Gc0hROsmXxeu2rgPFlRY76a52RFnXIwzEU0fQ==
X-Received: by 2002:a05:6512:61a1:b0:553:314e:81f7 with SMTP id 2adb3069b0e04-55a23ef4e8amr1113594e87.17.1752690088553;
        Wed, 16 Jul 2025 11:21:28 -0700 (PDT)
Received: from pc636 (host-95-203-27-91.mobileonline.telia.com. [95.203.27.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6bb54sm2743150e87.179.2025.07.16.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 11:21:27 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Jul 2025 20:21:25 +0200
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Yunseong Kim <ysk@kzalloc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] kasan: use vmalloc_dump_obj() for vmalloc error reports
Message-ID: <aHftpSnSit__laMx@pc636>
References: <20250716152448.3877201-1-elver@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152448.3877201-1-elver@google.com>

On Wed, Jul 16, 2025 at 05:23:28PM +0200, Marco Elver wrote:
> Since 6ee9b3d84775 ("kasan: remove kasan_find_vm_area() to prevent
> possible deadlock"), more detailed info about the vmalloc mapping and
> the origin was dropped due to potential deadlocks.
> 
> While fixing the deadlock is necessary, that patch was too quick in
> killing an otherwise useful feature, and did no due-diligence in
> understanding if an alternative option is available.
> 
> Restore printing more helpful vmalloc allocation info in KASAN reports
> with the help of vmalloc_dump_obj(). Example report:
> 
> | BUG: KASAN: vmalloc-out-of-bounds in vmalloc_oob+0x4c9/0x610
> | Read of size 1 at addr ffffc900002fd7f3 by task kunit_try_catch/493
> |
> | CPU: [...]
> | Call Trace:
> |  <TASK>
> |  dump_stack_lvl+0xa8/0xf0
> |  print_report+0x17e/0x810
> |  kasan_report+0x155/0x190
> |  vmalloc_oob+0x4c9/0x610
> |  [...]
> |
> | The buggy address belongs to a 1-page vmalloc region starting at 0xffffc900002fd000 allocated at vmalloc_oob+0x36/0x610
> | The buggy address belongs to the physical page:
> | page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x126364
> | flags: 0x200000000000000(node=0|zone=2)
> | raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
> | raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> | page dumped because: kasan: bad access detected
> |
> | [..]
> 
> Fixes: 6ee9b3d84775 ("kasan: remove kasan_find_vm_area() to prevent possible deadlock")
> Suggested-by: Uladzislau Rezki <urezki@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Yunseong Kim <ysk@kzalloc.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/kasan/report.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index b0877035491f..62c01b4527eb 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -399,7 +399,9 @@ static void print_address_description(void *addr, u8 tag,
>  	}
>  
>  	if (is_vmalloc_addr(addr)) {
> -		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
> +		pr_err("The buggy address belongs to a");
> +		if (!vmalloc_dump_obj(addr))
> +			pr_cont(" vmalloc virtual mapping\n");
>  		page = vmalloc_to_page(addr);
>  	}
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
Acked-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

