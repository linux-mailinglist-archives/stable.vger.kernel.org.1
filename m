Return-Path: <stable+bounces-56011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941E91B2A1
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F81F22345
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639D41A2FA1;
	Thu, 27 Jun 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Das3UBC5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327871A2C34
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530389; cv=none; b=E1H6PCOexLSyDMsPgOMBK3duT8wl+ODDAfcrsGSaCgwxrmuM87gTfIAwFSwjE9HpClcQxBw6OxtbmClqNRYcprrdahHHgBU/+5rtc0ZrFZKsZMjxupnxYztXsu3ATOm/fn3jFpM6rI+3NV0mwXKo90FRM9CZN0XSzZubY83ja80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530389; c=relaxed/simple;
	bh=PPRwhvydXhxUZQexsx5RnnndFRg7TQ1NyXIyNCDp3+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+cy651+JHmnnjabZOl/SebHYjrIFsfXDLuV7zF8OCTodv2EaDHIHFH9EeKHlJsRZhzjLiZPioqFpXm+hmtrkBF6R2dfvW1YxE/bQHz8X61yxffOe22DjTcCf9v2tKDhJje4/eOUX+ZMyj/UeifOc3YRIu+lFwandLa+bhvPWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Das3UBC5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719530386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1YXe5ol6L04xULXPymw3GJypJtsSF73vsgstdp57Og=;
	b=Das3UBC5uwu53d6KuHIcWLPJgB8U6piOfukeBVvZIGn499FXb6wfPjmQkt5kht5hSzRZxw
	KNCcIVt12QcwWiFGeN1eQKqeo9o2VXaOmQ5XgJh72gsNjDat4HbRuh3J+VooksslmfotaU
	+awfgmbyPUw9LMV00aKphjy6y0k9vCI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438--x0VhxYIO0SIM9TcZ8N2Hw-1; Thu, 27 Jun 2024 19:19:44 -0400
X-MC-Unique: -x0VhxYIO0SIM9TcZ8N2Hw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ad803bc570so88606d6.1
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 16:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719530383; x=1720135183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1YXe5ol6L04xULXPymw3GJypJtsSF73vsgstdp57Og=;
        b=oCK7oGu+4xlI0WSvEYGnqpn3okdBsBZ+fvF4ryjqqDwNKQz1FieQSVrLs1mv218yow
         hYdw0WTarchkErtJJzO5kmv5zHpERWPH1TaXe9wOHSWHvozxpmFGh6b1DqWm9eWM6HyO
         xbmfYpf59g/cn+SDLNJmVpC7gRZMX5aEBHP14spuZSrKzAOh3agNMpgx2J8mb6rQJyPh
         LcBT1XIyaFmioDcyJ6xnDIwLnlUM69ZlRcNAHOx8l1WhyW9WcmnSZWxzqiHewKvYt2hl
         AsdvR8tCk/dTwB5+MY3LslBSw21l3b865NJLG8jpt9KCHy0xqINYArkladhwjxBJssel
         rIog==
X-Forwarded-Encrypted: i=1; AJvYcCVxxzNGx268uohRDyy903CbhbvtV6yivaaqhPqQ2jRKJtEiCdZ8gKKqyz4Fz/H39OIfPFgR2IrfTGQgdPP+M6TAJt91BCw3
X-Gm-Message-State: AOJu0Yx1qPI5xA2hxyaVQrGL+dzKIg4Bh1TmFaxeS7mKRPwtF2/yieGL
	XjT+mcZkANjCj7D+Jcp5RIeidQ8DzcG2tW5TytJKKRKq89Znr5sFMnZ7hXdJ7eVOz2S50vbX8Iq
	UQ0u+r7IX3bNT8gRjrfK4tgXeqq+MVcyCwchKSPv7rBMcXi7GGEH4Rg==
X-Received: by 2002:a05:620a:2905:b0:79c:12a4:538b with SMTP id af79cd13be357-79c12a458a7mr732289085a.2.1719530383187;
        Thu, 27 Jun 2024 16:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFINKkJ5VHiTiiGezMh5c/t5IqK3PUIBzUnqYyYCVAOhNr45JVSecJ4xWQgBsizyziOSOPc1w==
X-Received: by 2002:a05:620a:2905:b0:79c:12a4:538b with SMTP id af79cd13be357-79c12a458a7mr732286585a.2.1719530382525;
        Thu, 27 Jun 2024 16:19:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692ea2ccsm22783185a.88.2024.06.27.16.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:19:42 -0700 (PDT)
Date: Thu, 27 Jun 2024 19:19:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: yangge1116@126.com, david@redhat.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
Message-ID: <Zn3zjKnKIZjCXGrU@x1n>
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627221413.671680-1-yang@os.amperecomputing.com>

Yang,

On Thu, Jun 27, 2024 at 03:14:13PM -0700, Yang Shi wrote:
> The try_grab_folio() is supposed to be used in fast path and it elevates
> folio refcount by using add ref unless zero.  We are guaranteed to have
> at least one stable reference in slow path, so the simple atomic add
> could be used.  The performance difference should be trivial, but the
> misuse may be confusing and misleading.

This first paragraph is IMHO misleading itself..

I think we should mention upfront the important bit, on the user impact.

Here IMO the user impact should be: Linux may fail longterm pin in some
releavnt paths when applied over CMA reserved blocks.  And if to extend a
bit, that include not only slow-gup but also the new memfd pinning, because
both of them used try_grab_folio() which used to be only for fast-gup.

It's great this patch renamed try_grab_folio() to try_grab_folio_fast(), I
think that definitely helps on reducing the abuse in the future.  However
then with that the subject becomes misleading, because it says "do not call
try_grab_folio()" however after this patch we keep using it.

Maybe rename the subject to "mm: Fix longterm pin on slow gup and memfd pin
regress"?

> 
> In another thread [1] a kernel warning was reported when pinning folio
> in CMA memory when launching SEV virtual machine.  The splat looks like:
> 
> [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
> [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
> [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> [  464.325515] Call Trace:
> [  464.325520]  <TASK>
> [  464.325523]  ? __get_user_pages+0x423/0x520
> [  464.325528]  ? __warn+0x81/0x130
> [  464.325536]  ? __get_user_pages+0x423/0x520
> [  464.325541]  ? report_bug+0x171/0x1a0
> [  464.325549]  ? handle_bug+0x3c/0x70
> [  464.325554]  ? exc_invalid_op+0x17/0x70
> [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> [  464.325567]  ? __get_user_pages+0x423/0x520
> [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> [  464.325590]  pin_user_pages_fast+0x47/0x60
> [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> 
> Per the analysis done by yangge, when starting the SEV virtual machine,
> it will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the
> memory.  But the page is in CMA area, so fast GUP will fail then
> fallback to the slow path due to the longterm pinnalbe check in
> try_grab_folio().
> The slow path will try to pin the pages then migrate them out of CMA
> area.  But the slow path also uses try_grab_folio() to pin the page,
> it will also fail due to the same check then the above warning
> is triggered.
> 
> [1] https://lore.kernel.org/linux-mm/1719478388-31917-1-git-send-email-yangge1116@126.com/
> 
> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
> Cc: <stable@vger.kernel.org> [6.6+]
> Reported-by: yangge <yangge1116@126.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

The patch itself looks mostly ok to me.

There's still some "cleanup" part mangled together, e.g., the real meat
should be avoiding the folio_is_longterm_pinnable() check in relevant
paths.  The rest (e.g. switch slow-gup / memfd pin to use folio_ref_add()
not try_get_folio(), and renames) could be good cleanups.

So a smaller fix might be doable, but again I don't have a strong opinion
here.

Thanks,

-- 
Peter Xu


