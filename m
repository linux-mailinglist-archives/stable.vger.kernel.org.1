Return-Path: <stable+bounces-55983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B85491AF5F
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AB51F232D4
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0319AD81;
	Thu, 27 Jun 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtJm2b2d"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C722F1C
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514537; cv=none; b=pmhd7p/b+Q/lst1eXy1tdyQuBHEZtECMtRoTRV/uOYMZgSqGx2NHjYjc4OzmqsMCKSAswZUIaSz3Sbm/qZzKh9Qe7LyLcU6m0knbf3L1zYDBJNiOxRhTDkfkqCL3XOB7sarRiXYm8JEQX18SONVF44gMODTENiABaveHub4XRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514537; c=relaxed/simple;
	bh=29lOxz3XaEydxXz0C/cKCWYNDuPwhbuYGH1B8qzt/94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy/n041yhCKoUFauDtIGHz5xHoSfLAwdr1P04KctRL7R31IaTz6P7f1TtUvbGxziMqcPh0x57Wjff+dHkzWGmI6/vHFDje4oEqn1n3QBHzyRRGI8N+3i5WGry7ygt7tUoBRwfQUu5T01gxpZGqapFodu12JpWbxio1LZrFZtOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtJm2b2d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719514534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRo2z4A0curEj7fGmncj+Ilw/r1TDvkXres+ZonF1MQ=;
	b=AtJm2b2dkx8A0Ya8sBuwcBBrpdxDD9KJ4MHZNX6kxisV3U4hXGa6hxowl/9vQi7yypKNPb
	03KeBjp+Vh001P8RI8TV8ZXP+2QQHSAYqojiBnYhlvNcN1uqRWL09J39mfECrax6w23TjW
	/pPk6cm7/V9GZoRs3dfjocwmEoToUtA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Zi_v_QZSMp2nGgH82krC3Q-1; Thu, 27 Jun 2024 14:55:31 -0400
X-MC-Unique: Zi_v_QZSMp2nGgH82krC3Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b52c538d04so17078336d6.0
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 11:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719514531; x=1720119331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRo2z4A0curEj7fGmncj+Ilw/r1TDvkXres+ZonF1MQ=;
        b=OOhbGFvHlXKf95N3m3S40sUgXZ04N8zdAF1Vj6u3aKtDBU5HFTp+HuHmxSOoBCck7t
         5MuAzw7cmPlLOT8mNLqu1K3GSYwbWhStv50BsDs3X/CQqfTv79zPT3w9Se2gwfnHnBep
         wR8m2K8qDQirTFZrpvvLQ2FPvXEYV+IbwJCJXKe7zzbJ7OvysyPeZIXldwLhEn68i1JN
         pru237xvM4zHtYODMbpea3cMePvmV9qQiHIISkiuBLWwMS3Mj8V5rKoa7RJtmVnaZGJe
         0tIKcIc8hP29iQZYlerXxtdTMO1B82dnPyAymNsZzhGAEZprRysQxseVRA6y28+CcsKm
         9Kjw==
X-Forwarded-Encrypted: i=1; AJvYcCVlBoGFxmThe+pYp34jx9tM6NKZpMva9x/qb2C3UEJ/2rWQ4TFRkK1j1N4S0qaql4rSn5TAqdYviYqYM7XNChyzNSxs1OSk
X-Gm-Message-State: AOJu0YxHR+pSN4I6V3mFJFijN8TiMK437KWXUgX5/zMQggNpJJK+sUGQ
	FqBNZm0Fv5TlZUn3eU//YYpy8YzdSjugdN1C8RSR/eUoX/Jax5zeWOXGvksh5COZO2KRuzsKBmh
	XUx4/t5xqBZFpMaw6g0V+vvredDFk4nG3CiWq1p1sPJVKMgZv1GdFlQ==
X-Received: by 2002:a05:620a:171e:b0:798:d5b6:ccc4 with SMTP id af79cd13be357-79bdd895786mr1670637285a.6.1719514530925;
        Thu, 27 Jun 2024 11:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjq38zT/pvHIS6aZ5W1jf59a1bV8R30a02zd2hf1puy3/wwJsfC/keJrwwDT4rPC0cF1/wfw==
X-Received: by 2002:a05:620a:171e:b0:798:d5b6:ccc4 with SMTP id af79cd13be357-79bdd895786mr1670633985a.6.1719514530206;
        Thu, 27 Jun 2024 11:55:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692f0b82sm4706585a.74.2024.06.27.11.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:55:29 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:55:27 -0400
From: Peter Xu <peterx@redhat.com>
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn, David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm/gup: Use try_grab_page() instead of try_grab_folio()
 in gup slow path
Message-ID: <Zn21n5vg1Vz6whvs@x1n>
References: <1719478388-31917-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1719478388-31917-1-git-send-email-yangge1116@126.com>

On Thu, Jun 27, 2024 at 04:53:08PM +0800, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> If a large number of CMA memory are configured in system (for
> example, the CMA memory accounts for 50% of the system memory),
> starting a SEV virtual machine will fail. During starting the SEV
> virtual machine, it will call pin_user_pages_fast(..., FOLL_LONGTERM,
> ...) to pin memory. Normally if a page is present and in CMA area,
> pin_user_pages_fast() will first call __get_user_pages_locked() to
> pin the page in CMA area, and then call
> check_and_migrate_movable_pages() to migrate the page from CMA area
> to non-CMA area. But the current code calling __get_user_pages_locked()
> will fail, because it call try_grab_folio() to pin page in gup slow
> path.
> 
> The commit 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages
> != NULL"") uses try_grab_folio() in gup slow path, which seems to be
> problematic because try_grap_folio() will check if the page can be
> longterm pinned. This check may fail and cause __get_user_pages_lock()
> to fail. However, these checks are not required in gup slow path,
> seems we can use try_grab_page() instead of try_grab_folio(). In
> addition, in the current code, try_grab_page() can only add 1 to the
> page's refcount. We extend this function so that the page's refcount
> can be increased according to the parameters passed in.
> 
> The following log reveals it:
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
> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>

Thanks for the report and the fix proposed.  This is unfortunate..

It's just that I worry this may not be enough, as thp slow gup isn't the
only one using try_grab_folio().  There're also hugepd and memfd pinning
(which just got queued, again).

I suspect both of them can also hit a cma chunk here, and fail whenever
they shouldn't have.

The slight complexity resides in the hugepd path where it right now shares
with fast-gup.  So we may potentially need something similiar to what Yang
used to introduce in this patch:

https://lore.kernel.org/r/20240604234858.948986-2-yang@os.amperecomputing.com

So as to identify whether the hugepd gup is slow or fast, and we should
only let the fast gup fail on those.

Let me also loop them in on the other relevant discussion.

Thanks,

-- 
Peter Xu


