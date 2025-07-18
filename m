Return-Path: <stable+bounces-163382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE02B0A7D6
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0BB188359D
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DC2E0409;
	Fri, 18 Jul 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia6fB74B"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED62DECC4;
	Fri, 18 Jul 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853440; cv=none; b=Jdz1Gc5GwLTJRWu1Xxu3KKJkuymU4JD0dOcQwfm3oLlzH7Tj8Q+Mwess19zUrxzB6yxozDIUq42pEKNzePIWe1Fd+qZtCyFDuHl+4uh4CQ14Uqr18ZUB/obB+cCAAz/yFEtCTEceKPTwHfnazj+UoA7HErVp5ME35+U5+3od600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853440; c=relaxed/simple;
	bh=mJCwGeAMlBeq7zLQGnl6f/i475VDz879qhHSIBsABO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q76usBNa3m93ycuAleBVcwHljKs7jU7g6dEMOx9zL3yFTulihJl7gqwUSNLlqoYQF9XHEXLEMsI9NtMP5N4ztWX1KLWSK6fJya+Nm8W2S6YqMrPWjWjT38BmuVYfTqyH+P9gRWa698P+L9sAvFIgh13aR5/9rnhBRlNeBhr9cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia6fB74B; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f18065b70so2333761fa.1;
        Fri, 18 Jul 2025 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752853437; x=1753458237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJ3ROjwqD3CLXG2IiheiI0iDXPqsbWX3BCQXRvH9p54=;
        b=Ia6fB74Bx/VPtiP+dIWPBfa7q2GLjEcU4nX8AtWjveovRIsv+Qe4UApA81kbNEWclJ
         2Kwj8rHvxrd2NXeZZIYc2r01at4DXZnOWXh5cyO+0pMJpOOI+CQ/yb8a+2l1uQlBtbVV
         6nFT4qAj8MmMmDbmFoXBHBXXlcWCj6MNFvhA6Qdc6o9gF+GfCO5R9SsiyaG0lIExk87U
         4y8I7u6yBtJL3KBmDc4Jb1rgFQK7ugaINhRwHELMaBDMWVXL50m2tdbp6WbaqUhhssmX
         og3pPDw9qTqP0jLZygZbGfaO5xO1ciJVmJLpScQVd+l3TYiQKCev9R7rqp5S1n3FDk3g
         uXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853437; x=1753458237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ3ROjwqD3CLXG2IiheiI0iDXPqsbWX3BCQXRvH9p54=;
        b=VhCRwNAfJcOJXSFbHschGEU8c+aYmezGdgj4GwM0NzgvqmrXueLrLwBeOLczVRu5KH
         wpTeaxfx96ycbMDg6HtvunGO5AEzGd0eSetlrbx1y+1E8oiMEPq6KZDQ1QJdRwNhoVYW
         oLz7rRDhghjILUMrl2tNeB1mV0Zcbg/LDyCc5hHJqESFpzwbpOfoaqSOTPK4ZuA5n8Kp
         UR7aO6KkWrAaCF4cM5rJRswTVi6ogiz+ucVeS/Us3Nv0P68u6BQ2oAbTJ90KM6ZVEZsf
         zq+ohbIgXJ9Ev8pheAxnwDDOT664/wFFuN7HcqlDKapT9VWlKhqJN5vuhpynvZW2Lg3u
         yq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUD5otqcl2595UESCpTtxU5w3CHS82YSk2ABDjVEnnoe7IluQvpKwCJedhYrbMN1eN3MfwwhoBrxheMW+0=@vger.kernel.org, AJvYcCW89V7QGFELbuAmzOhiG4qE72okLHMkYbidkkiTvWryAaZcegivIGGHKgSQVSmn0b9ZUk+2076U@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBydb4c15jgQbg5hEp8hiJU7tNdE+QQXB4h2kzlgp3WSy0Usk
	0Ng7mJ/hXWXdgLhOtPkTqBuyO2WLwo//cBE5j6QS5ZUoXjwWLY4kF5q8
X-Gm-Gg: ASbGncsnsv2icwSR0uQ8CVXHDH4qgTCDxSpLTi9HQQvue9cbxQVKu6HQ3Hy20AsRZbA
	LOtgwU3kMf9IFy1JsDgPSs5gbgUiDPTUmDD6+TpZf/K6jgbjvtoUr01GaJmLnPrjvojLmf1Egws
	ERwqZa0vYpE33wlUNtMYeqQbYMo8EJIbcayxunubOVbIitTRNdTCYg+eug7SA/OXhPFsEcs9n4S
	1yuC4qkE1ZiT9ftSmPXl81A0qdTB4HDd1/msABFoS9YpIDVMgZg1TsOpPJuHnx7XxdRglAk0NJX
	vwvZjewMh+a78qFfgPPeOmcE7RIvNcAkZf3J8TfKEXn9Lb7N7omRQoSGFggjXyOBB/3sQTVEBbV
	n0YS0vii05jCOtOqwwx/h+JRnU01F
X-Google-Smtp-Source: AGHT+IHuDciecE4/7Mw37ftoaXpLaruOdcnYTZ+5ZmmnuTgI8TgOpSp8IT4jSI8HtwvRnaLKI1Zjpg==
X-Received: by 2002:a05:6512:128a:b0:545:ece:82d5 with SMTP id 2adb3069b0e04-55a233a28b1mr1360799e87.13.1752853436956;
        Fri, 18 Jul 2025 08:43:56 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c777sm299394e87.116.2025.07.18.08.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 08:43:55 -0700 (PDT)
Message-ID: <0004f2ed-ac2b-4d93-8a4d-d01cbede94a2@gmail.com>
Date: Fri, 18 Jul 2025 17:43:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: use vmalloc_dump_obj() for vmalloc error reports
To: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Yunseong Kim <ysk@kzalloc.com>,
 stable@vger.kernel.org
References: <20250716152448.3877201-1-elver@google.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250716152448.3877201-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 5:23 PM, Marco Elver wrote:
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


Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

