Return-Path: <stable+bounces-211362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L2dAdI8c2kztgAAu9opvQ
	(envelope-from <stable+bounces-211362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:18:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5287A731B0
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F01C3019451
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441C30BB80;
	Fri, 23 Jan 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBCmB3/P"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEE2F3C3F
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159886; cv=none; b=mZMGRgdUxRu8WQjise2GGRUmj2m3f/M9zhxoBB8fCWDnvj4FxFg+Y2HUZwfR1TYEpcbh50kE54xXl0HTD8Z6V0cMoHa9YzoKSFvHxc4+CN1xP59Mc2ctBqPAtChmjdUk5d/icfO4XQvtUDs9+zsU+I6Vuyj+7OR0+MeuuaeduDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159886; c=relaxed/simple;
	bh=XVH95s01MqloQH1J7IdnagDFHxf/iHAeNk0s14uQMvc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=As4/RA/CUbuK+kDngCPSLe9SVeHTEnRCA43W8KGtS5OkouFvCRb7FfyYkqPuVMhtJZWH4s2m23rVW90+7h3dy13GWP8Fr3X1RkfUz6UqiUNKxUEyE3i/Jt5OQg2+br8ChgZH+lnb5Uun7pf7t5yg/gJimXkcNfJCF/BE69hAp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBCmB3/P; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b844098869cso180689066b.2
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 01:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769159883; x=1769764683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ua9w7UEf7xgcdVIusVPQYkd37tPBqbwBjiHWdVEgXw=;
        b=bBCmB3/PRQlg21+v04SN+KgncglLaC+vjw0iW1XjTX2wiyYC7ZKtef++wsVS13Qm16
         pkQ3sOccOGri6uSrxZCwPv4ixBuCgJkneFQNcRYQ6R+sq9mSBfwvPFUoQPghCbeMniUd
         nRXjZfAaXyY5MFSbLWGH7zH+jNcMOXuWMtmsE64kQt959v68fpADqkX91TntrhziA8yO
         4h+TTIH2lUEkMzKPFeL0UKQLxXW8ooSoW634FqAEkNcKz72S1ZIZdJD5CydtYeQpDOSV
         Pk6mZ9CTmk+vYAmAzG0jlXmjGUykCdKVLpa6CRV3vEchTQeAC2tfFfwj2qKbZX8ZCrQc
         9MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769159883; x=1769764683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ua9w7UEf7xgcdVIusVPQYkd37tPBqbwBjiHWdVEgXw=;
        b=g1c6DlrmdPMgEtFtiwmgX3njVHceB5w2AGf7QTm9GsxwoD0lf2kIVe77QLHiGl4EA3
         9VJH/pFe9L94SkPzIKz6ySdgOjjSAAxOyoexS6D26p/hL+LEfOlm6zjm3gjJjS3lrvei
         nVwwHvnrdd6rL3XC7c7mA+mfx3Kv7WIr+1hHihtdHaQImOcNiH1Q/7EV9giamV9rFsCm
         Higioo1GLbiQXqFqG4EVLSlq91RjaeFhJOq2z/Xdcs9aIvg60kAwPgWnvtPLMM4pgT7M
         DyOwENC5ri9HFuJ4AUTsNsQws3A9z+9a7TkyecnFuNoEgW1xyUsIoakNg1aDeod2ypqv
         x5ww==
X-Forwarded-Encrypted: i=1; AJvYcCXhTT5TWTWoQ4SVhJFNw3q0c73DCUbFYj3nmJ03fXPYNY/RwghSQKpNAgQ9ta/rfP0sJE9Mzx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzycbW1tocaMPglWunTxoUqk5vyzrqMZau1CLxn+VhcG4BQ3lcK
	hWlRwzBfpfGyd9pHEammu3HR6dbRXIj61NDM3UcBgeRdkdzetHzrLbZlWaHqZ0Juv2Xn2yZKy+0
	Cm3cYw7HeK2hSQUhwuA==
X-Received: from ejqh18.prod.google.com ([2002:a17:906:5912:b0:b87:20a7:41e8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c94:b0:b86:e937:d097 with SMTP id a640c23a62f3a-b885ae0a088mr139955566b.38.1769159882639;
 Fri, 23 Jan 2026 01:18:02 -0800 (PST)
Date: Fri, 23 Jan 2026 09:18:01 +0000
In-Reply-To: <20260122180203.1502637-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aXHfYfNZ20-3J8qR@google.com> <20260122180203.1502637-1-cmllamas@google.com>
Message-ID: <aXM8ybQ60WW2Z1A4@google.com>
Subject: Re: [PATCH v2] binder: fix UAF in binder_netlink_report()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Li Li <dualli@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211362-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5287A731B0
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 06:02:02PM +0000, Carlos Llamas wrote:
> Oneway transactions sent to frozen targets via binder_proc_transaction()
> return a BR_TRANSACTION_PENDING_FROZEN error but they are still treated
> as successful since the target is expected to thaw at some point. It is
> then not safe to access 't' after BR_TRANSACTION_PENDING_FROZEN errors
> as the transaction could have been consumed by the now thawed target.
> 
> This is the case for binder_netlink_report() which derreferences 't'
> after a pending frozen error, as pointed out by the following KASAN
> report:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in binder_netlink_report.isra.0+0x694/0x6c8
>   Read of size 8 at addr ffff00000f98ba38 by task binder-util/522
> 
>   CPU: 4 UID: 0 PID: 522 Comm: binder-util Not tainted 6.19.0-rc6-00015-gc03e9c42ae8f #1 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    binder_netlink_report.isra.0+0x694/0x6c8
>    binder_transaction+0x66e4/0x79b8
>    binder_thread_write+0xab4/0x4440
>    binder_ioctl+0x1fd4/0x2940
>    [...]
> 
>   Allocated by task 522:
>    __kmalloc_cache_noprof+0x17c/0x50c
>    binder_transaction+0x584/0x79b8
>    binder_thread_write+0xab4/0x4440
>    binder_ioctl+0x1fd4/0x2940
>    [...]
> 
>   Freed by task 488:
>    kfree+0x1d0/0x420
>    binder_free_transaction+0x150/0x234
>    binder_thread_read+0x2d08/0x3ce4
>    binder_ioctl+0x488/0x2940
>    [...]
>   ==================================================================
> 
> Instead, make a transaction copy so the data can be safely accessed by
> binder_netlink_report() after a pending frozen error. While here, add a
> comment about not using t->buffer in binder_netlink_report().
> 
> Cc: stable@vger.kernel.org
> Fixes: 63740349eba7 ("binder: introduce transaction reports via netlink")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

