Return-Path: <stable+bounces-159307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A2AF7493
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4843BFE50
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D82609D4;
	Thu,  3 Jul 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlxP7FOM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB2F29;
	Thu,  3 Jul 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546968; cv=none; b=uNBZadFixui2qSlyjxzorKwxeq2do/mHJMfxKZhwvV7s2uqHupQJSii4BM2VKhCOYIaA0nEcDR8Lw9pQC1ScM7lpaeXOPs9FEhqNT7yKlvOkbiskESpzmozlm0QFHJ4xxSuMsDTpOGGaS9xpp5bRDlwLIcNnMnLBEqvGOfCPIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546968; c=relaxed/simple;
	bh=1h5td7mHaRLVwU1IITV6OOtvq2fJvXJzQHsZ+1xTOZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEwpQL+70uileltkjufcva5r/p49ctUw0Ckebf3WigeQa4ccdkgimyfejNGBwQrjMx8RnGuzSXX6gHzYApsxM20eZVH681loPCfJIB5AuhVbvq1px8yZDeGAXyuqQygR8EVZknckmGltF4elfdoNZVqihXOvW0NhapaY0Zv9L/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlxP7FOM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313a001d781so4180818a91.3;
        Thu, 03 Jul 2025 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751546966; x=1752151766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6LiFOh64v/siwXdil08hktvYo8/cVuoCtLxNd2EEmBc=;
        b=KlxP7FOMzLfWr/q3PRJgXZ9NO7dgHRBK8Iu1qxCCyRqFhOfDdy2EsgyY87bJOkhuwV
         IGga29OAdWWQlklw1M/BAozeERZM5/ZRTGlDCwe3kzB6WgIW02uoWF9YdCZDdA47KH1H
         7Qyp41y19O/ZhWQ9skncNMpo1oCzoQO6iv15pEeRCj+w08EBN0jt1AjD8oYT8Ab0lCph
         wxhdcskP/slH2XnzEjhVMfAkyWJnA0r18wM1htiVruMUYsSibNWpRCxiWSRKDMCFMdXV
         mQ8ML0AW2fEBxT9XmFu8JxdeZRqw8W0oeroZRANshZ94/SwvKhLD4LJKSNdhDg37Um18
         A/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751546966; x=1752151766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LiFOh64v/siwXdil08hktvYo8/cVuoCtLxNd2EEmBc=;
        b=qYrmiVBZwWfqfWpzjon3PjV0+D9foCeaQLSad5lWwTnxLqokq7HjjsFAoK52QdCDmZ
         5Do6K12lBOXueqbJZZCajwwEERo2PXBUlJq3h5KWM5URMHa0qcQJHyMQ7ENxd6c8t9rq
         a8XA7MBS7fmcMzVfVI9qN2o6EvRIAZvKYGDT01f89HFDQRoAy31iI3/7FPIvfb5oA2le
         CPV0Eb97q8eGWrKEmfUgatCeYfxhWlWqAYRVdsTYFuuPo1LAU3LxFo0iHtzVIiVLgcSQ
         04f1U/x0PO0U+NpztpD95+mmgaoMoy2T3nLziATA5qPmiEuUY7yym/X/R01eHW0TVXE9
         23aw==
X-Forwarded-Encrypted: i=1; AJvYcCUtsmxhJmgn+KWg59h5ed4QHDwGkuZ6GKHLvkMz2sabDbdRa26YOo14E4iR/LYPGnwie7jF3at5JevszxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93fT08ERV5cqCGreSY+bKAB1ij+XigMPMWPSzfya9VYYWPjH6
	4w8oYwWe5HmSMOycfUqu+cPif0/XuLQwI+c1bTvC0Yt08tB7zq0AmUb3lugC7dGVCS5r9ejtcMV
	mRQ6xE/l44QKyAkmbLAd82pyHSUolW/s=
X-Gm-Gg: ASbGncv+tEB8x8vJ2aFm+nmSrmUqM2b9fS32WGQH0bl3OdXDuaBKfS85rhGnh96tCx6
	X9clvXRvw2WANhcUz7avx+8m925IJ3VIB6nMYp+QyZGtoBBPpTFuvNnVu25rS8drEU/DYfKuVMp
	6r11qwnl5bqC7Hkqqy4Zwg9PRc26SlFeG9XwvspGiVNXcj0B8vkAeEyd82
X-Google-Smtp-Source: AGHT+IH48/BERJnuPtZYQjLpcSnA8IMxSKCWbJND9Uz0Hh0HUl6pAtP7F+1crfYQJpC40rwlfFoBgshJvPClIiy9Goo=
X-Received: by 2002:a17:90b:3cc5:b0:311:c939:c851 with SMTP id
 98e67ed59e1d1-31a9d52bcbcmr4116449a91.4.1751546965945; Thu, 03 Jul 2025
 05:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702153312.351080-1-aha310510@gmail.com> <2025070322-front-purchase-b66f@gregkh>
In-Reply-To: <2025070322-front-purchase-b66f@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 3 Jul 2025 21:49:19 +0900
X-Gm-Features: Ac12FXycYs6l1_4Q6i9Y6NhpTZ-YgwI7DO1P07o9n57x9nl5UTWxk6QJqmx-x3Q
Message-ID: <CAO9qdTE0SGJTgzTRnOU=tn+uR3kH_zsuuMWEz=0h1k1ottzPWA@mail.gmail.com>
Subject: Re: [PATCH 6.15.y] mm/vmalloc: fix data race in show_numa_info()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, urezki@gmail.com, akpm@linux-foundation.org, 
	edumazet@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 03, 2025 at 12:33:12AM +0900, Jeongjun Park wrote:
> > commit 5c5f0468d172ddec2e333d738d2a1f85402cf0bc upstream.
> >
> > The following data-race was found in show_numa_info():
> >
> > ==================================================================
> > BUG: KCSAN: data-race in vmalloc_info_show / vmalloc_info_show
> >
> > read to 0xffff88800971fe30 of 4 bytes by task 8289 on cpu 0:
> >  show_numa_info mm/vmalloc.c:4936 [inline]
> >  vmalloc_info_show+0x5a8/0x7e0 mm/vmalloc.c:5016
> >  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
> >  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> > ....
> >
> > write to 0xffff88800971fe30 of 4 bytes by task 8287 on cpu 1:
> >  show_numa_info mm/vmalloc.c:4934 [inline]
> >  vmalloc_info_show+0x38f/0x7e0 mm/vmalloc.c:5016
> >  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
> >  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> > ....
> >
> > value changed: 0x0000008f -> 0x00000000
> > ==================================================================
> >
> > According to this report,there is a read/write data-race because
> > m->private is accessible to multiple CPUs.  To fix this, instead of
> > allocating the heap in proc_vmalloc_init() and passing the heap address to
> > m->private, vmalloc_info_show() should allocate the heap.
> >
> > Link: https://lkml.kernel.org/r/20250508165620.15321-1-aha310510@gmail.com
> > Fixes: 8e1d743 ("mm: vmalloc: support multiple nodes in vmallocinfo")
>
> Why did you change this line?

Oops, I accidentally imported the commit message from GitHub, so this
commit hash was shortened to 7 digits. I'll fix it right away and send
v2 patch.

>
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/vmalloc.c | 63 +++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 35 insertions(+), 28 deletions(-)
>
> Please document what you changed from the original version, as this does
> not match what is in Linus's tree.
>
> thanks,
>
> greg k-h

Regards,

Jeongjun Park

