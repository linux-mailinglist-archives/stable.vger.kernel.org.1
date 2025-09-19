Return-Path: <stable+bounces-180673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2BB8A8C3
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51747B06C8
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29932126D;
	Fri, 19 Sep 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgioItWR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC6131E884
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298948; cv=none; b=ci1hO9kyVttamWzfA/jOSyTmYYWKVtFCcyLRmcd7bb5m15f5Y3QJkIb5w2dvt5OHLDerhbu1JhEjvzaeBgLeKLGyP6rlC42E7r7vDUtIhaX2nWKgaPAm1nwn2gGOKkYNVbQ1cu7J/OpHEPNuI/xtz34Ld9/yZhhctHnWULbawtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298948; c=relaxed/simple;
	bh=BS4KtDrq6Dx+RDukiMH+9r5Pse7avn4XgUu/V7iPc0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb7sdlDLsB6e+5ZOHwPKIu85X967dJ7DrLS1ISgu8Q+qd0ZBtOdA36GulVw87ERyvhHwDwNCIu4iVZPo0a50AGmvwbp4P8I5G+ON96ilg9wquMYUSOdjBLktcLLrJMeFoHAGz+8am3c9MEDHkqJSmrhmNtcn0tUMrBJkrhNEz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgioItWR; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-31d6e39817fso4064529fac.3
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758298946; x=1758903746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNf4FavrobHnYfMkgvSm3G7G16uS+CH76oyvfIGfz8U=;
        b=hgioItWREHywNAa1DWJSu204ZNPo9/FuPwnOrsiqsWTkzE04/q4kDnHBKU+dDk+vwc
         0p2518CQOjMS6I4mJP00tq5WXkHsp04kTLwUWXyoVmq11iou+V8NNaPceOufRJlVzGIR
         UO8ueoODfVN3CBd88ZwLr+6gMsYqbgetwmOolroLtzXQBh1DTTruqAetkoAr5autyqRk
         j3tZq551pivFMAdvdP4IanwEdONkoUPFPgu+2aJI0LBtD9yBRdrrSzKOtInbElXr/Voy
         aVv2jzemCIaZcyYNM8fhMbTuCjxSPCsDps+LAiZ3diDALkcUV2yb67VwVwinwoGfo9p1
         iPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758298946; x=1758903746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNf4FavrobHnYfMkgvSm3G7G16uS+CH76oyvfIGfz8U=;
        b=R07ubCCeEaB4VgABDIBr29eWfXB36t/FtcIowlPbzmcJlqaibkG2Oqyj7f/JqOcWUQ
         jSlW1fdU+Kjjt7n28i4teBbtInQoxPvhg5czdDPh+JiZRMupdrZ4OpJpE0cdY6wZEjC0
         RqSJQnVgOZ43+iaqkGGSKRBfRcba4bR8VujgfMA6ECVNglWPwoXVetFSPG6ksSbsfLPD
         e2NA3l4ZJIQ/xib0XopQrKiuTlWiRmYK6uN6OzD7gGoDCOU19X7WaS22CKYyM3aKQsav
         HCYPv8q5oKRxq//WLVl1JYTpg2sQgVaL/25S5/FHh3Wo93a7UivpWfFeABnFF0JsVafp
         P8jA==
X-Forwarded-Encrypted: i=1; AJvYcCXHbgDqZrTK87gEmmtDNo9PaiGizgxEsG1GBzlsA8tc6nSZF6fWRg45GXtkfc+WaSXoNCcE1qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMkBU+6Z9hXLDVXaQcvvNB5KRbhVXVXRMRQTbWwK2Vo/sLf4S
	L7M8/IPOdSueAEIWz17P7aRw6wD8xYgFgcRIxsv9HKaSNbOHTk52RxZUh6IX08YBYqHDB6wjKc3
	Szp0pX8sIzXKclE8ysUshoFfewDIwsNs=
X-Gm-Gg: ASbGnct2YyjXXA2xGrMYtrG9twVQxkwrGDe25Vxx4Jnnk5276zsoPJ6IDDItVZ/oPy9
	OElXOIhQnzpjR8npKrc+8CDks6I2PFjaHWyJkT6hcYcHMTv2WFtCGLmJdVl5PcGq9RwWdG0rLlT
	b4AJ23jvEEyApIYFdkq4XZVuFXuGopTbNxPuZA5TcTB2ZwiyIKk4UaHFKdcwQbw61YZ7cJfrv0a
	wur8V/o
X-Google-Smtp-Source: AGHT+IExwi0L9CbXm3iuTEJUU3ZKD9YcdGSXZz5X3ytfvK54XI/i0JSaCP4BDsRoldnppbYnA5wX7dQUAuNpJBB2KAs=
X-Received: by 2002:a05:6871:521f:b0:31a:a3f2:f561 with SMTP id
 586e51a60fabf-33bb3ee7b22mr2004233fac.31.1758298945941; Fri, 19 Sep 2025
 09:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919142106.43527-1-acsjakub@amazon.de>
In-Reply-To: <20250919142106.43527-1-acsjakub@amazon.de>
From: Andrei Vagin <avagin@gmail.com>
Date: Fri, 19 Sep 2025 09:22:14 -0700
X-Gm-Features: AS18NWCw6i9bPS8OTVJYSNm_-cHQyTaqUgLBxnacQlZHln_Y9tAkHn8i9O5pwkU
Message-ID: <CANaxB-yAOhES6j6VJMDybAJJy8JEXM+ZB+ey4-=QVyLBeTYfrw@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/task_mmu: check cur_buf for NULL
To: Jakub Acs <acsjakub@amazon.de>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jinjiang Tu <tujinjiang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Muhammad Usama Anjum <usama.anjum@collabora.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 7:21=E2=80=AFAM Jakub Acs <acsjakub@amazon.de> wrot=
e:
>
> When PAGEMAP_SCAN ioctl invoked with vec_len =3D 0 reaches
> pagemap_scan_backout_range(), kernel panics with null-ptr-deref:
>
> [   44.936808] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc0000000000: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.937797] KASAN: null-ptr-deref in range [0x0000000000000000-0x00000=
00000000007]
> [   44.938391] CPU: 1 UID: 0 PID: 2480 Comm: reproducer Not tainted 6.17.=
0-rc6 #22 PREEMPT(none)
> [   44.939062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.939935] RIP: 0010:pagemap_scan_thp_entry.isra.0+0x741/0xa80
>
> <snip registers, unreliable trace>
>
> [   44.946828] Call Trace:
> [   44.947030]  <TASK>
> [   44.949219]  pagemap_scan_pmd_entry+0xec/0xfa0
> [   44.952593]  walk_pmd_range.isra.0+0x302/0x910
> [   44.954069]  walk_pud_range.isra.0+0x419/0x790
> [   44.954427]  walk_p4d_range+0x41e/0x620
> [   44.954743]  walk_pgd_range+0x31e/0x630
> [   44.955057]  __walk_page_range+0x160/0x670
> [   44.956883]  walk_page_range_mm+0x408/0x980
> [   44.958677]  walk_page_range+0x66/0x90
> [   44.958984]  do_pagemap_scan+0x28d/0x9c0
> [   44.961833]  do_pagemap_cmd+0x59/0x80
> [   44.962484]  __x64_sys_ioctl+0x18d/0x210
> [   44.962804]  do_syscall_64+0x5b/0x290
> [   44.963111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> vec_len =3D 0 in pagemap_scan_init_bounce_buffer() means no buffers are
> allocated and p->vec_buf remains set to NULL.
>
> This breaks an assumption made later in pagemap_scan_backout_range(),
> that page_region is always allocated for p->vec_buf_index.
>
> Fix it by explicitly checking cur_buf for NULL before dereferencing.
>
> Other sites that might run into same deref-issue are already (directly
> or transitively) protected by checking p->vec_buf.
>
> Note:
> From PAGEMAP_SCAN man page, it seems vec_len =3D 0 is valid when no outpu=
t
> is requested and it's only the side effects caller is interested in,
> hence it passes check in pagemap_scan_get_args().
>
> This issue was found by syzkaller.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and option=
ally clear info about PTEs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jinjiang Tu <tujinjiang@huawei.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Penglei Jiang <superman.xpt@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> linux-kernel@vger.kernel.org
> linux-fsdevel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
>
> ---
>  fs/proc/task_mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 29cca0e6d0ff..8c10a8135e74 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2417,6 +2417,9 @@ static void pagemap_scan_backout_range(struct pagem=
ap_scan_private *p,
>  {
>         struct page_region *cur_buf =3D &p->vec_buf[p->vec_buf_index];
>
> +       if (!cur_buf)

I think it is better to check !p->vec_buf. I know that vec_buf_index is
always 0 in this case, so there is no functional difference, but the
!p->vec_buf is more readable/obvious.

Thanks,
Andrei

