Return-Path: <stable+bounces-192663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C92C3E11C
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 02:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E9518881D1
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 01:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAF2609D0;
	Fri,  7 Nov 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBHQHaUu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nE8SzKHQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C72DF6F7
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477267; cv=none; b=NC37GSwhBOSOn4bCJfVnBWO8Zxm2gFkTUyqiMX/0JHABRhLI5uHzlJWoe3ymuysWcu5m9mxehA974gAtNE7Z5l42N+yfvqt5vDkenZA3oLAEUBO2I5/Y/SgKMAHYx765cFJM1zPhTqgdKSnybrNBqXUdEBLHTgER+X9ImWAsuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477267; c=relaxed/simple;
	bh=6Vq6xnllNLKddg7S0xjjPzOVqzBWr3NnaXE5Cy1bsT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdBYFoaL/cC328ccYGQwlPCZyhutGIAKqZ6M0ImJtI6H+JOuoQdpYd6blo60A5ST4pe4Ncg4GX5sLFjutUo+niVe8RydXl58KbDSPnSbPrxPZ0o9IjLfdX3QWyVc3CoHYR5+v6k2jDCldJjXKeocXUbKCbrLNF6tDxe3ZVk55/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBHQHaUu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nE8SzKHQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762477263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oS0uMhMGdq49DhBi/gfTvr28qD45X58Y+Rz8QovrzNg=;
	b=HBHQHaUu3blTnI4kWkRTUhGBDgAL0bIXq4gZyNHhmUipZXHXFp6M9eABGwPo0EjU9dnyeO
	TPVnVgrJ1fwgkRlQ75IVMgyoWDe0i+Q272iIwUhaaPacdt8GnsE2WpQf3yezCzNXlg4lHw
	ZJWqhaOzThmcAuUKtdJ1DcGuH2cN+wk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-EYlYOgTUOeqp31xJvYpy5w-1; Thu, 06 Nov 2025 20:01:01 -0500
X-MC-Unique: EYlYOgTUOeqp31xJvYpy5w-1
X-Mimecast-MFC-AGG-ID: EYlYOgTUOeqp31xJvYpy5w_1762477260
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso649716a12.3
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 17:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762477260; x=1763082060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS0uMhMGdq49DhBi/gfTvr28qD45X58Y+Rz8QovrzNg=;
        b=nE8SzKHQzsB4iXiQhlfyOIf2C6EApvHhyKOS0ghyH6x//JS5uQSdyI6lNvznsde+DG
         4K4XnF9ZY5dLMmkuGey51M8bzB1ufOtAOVyK9BL5xmC4Q7ZCco2RSPqM/CsJM+4TtzPW
         PtklTJcmfGp+IfSh331l1DZ6p1Bykw9llhBoj/wAYmUoP+Jy2kHAVsbYDRW52wziiI/1
         CxtaiY3LKUA2X1sfimjcy3VYUV6wqtxXbgpIZ0HHGRIRCBh2wMYNF6J1ky8a+kSIHlyU
         k2ucaRw/l/4mO7mLrL54JSzsA3LfiQwoZkWke8YAKMixj84vDCnA5EvbLkfrtUa91KG0
         /fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477260; x=1763082060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS0uMhMGdq49DhBi/gfTvr28qD45X58Y+Rz8QovrzNg=;
        b=IjBUaHDmR4/qXp7K7wYI5xSiY7DEJTjl3WTxPEb4Ip4rq8FoqK/IjFKsU+bQANV3v7
         vWsH/4Y1nEhbqq84RYqbslPLdMQb9zaYTzxXosyElRqD3pr3/kvU4y0syEM0Q8jmc45o
         p/BJObVKeKHy6FUIh9f9BGiT9IBD6ifrwxq5F8IwCzrXGSPWCxkwnHfrAC8zqIhExrLi
         fOrEJ3jX0QzukU4Hz42DIa/bPsCsl2WrFFFdaGSl/HYiQ6gKcOcuydPXVppMuePJO+fZ
         E+Mzq0OGr3fLD2r3ek5zaifZli8FaXnixJ/u3UyJeRDe7gquXKLjWsYybwTJ4sk2Ll7d
         Vugw==
X-Forwarded-Encrypted: i=1; AJvYcCWHZzFrvk7iP3htJfFOTSttu5GPYj/VUPvc92nYh7YdXoOoZoDvp9+6noy38q96HJ8gMWARhVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LXN+Rc11fve2DanJgA8GG73iWlGcPdyF5XOlRcu4OKzoX0gM
	x/aKcg94UoAnqVDmlU6OXADrQW3Uf7wYWYjCsBlS2lVRf1DPmT5dRUFQkjYtObE/dgGXsW2o26Z
	GAQdVKsvgdW7A5bqxbE9+fUuuYbbWEZ3rpEKFUlsCRIioTmKnt6RhfD7rGkNwcrrntkb4A417to
	RbB9xQhMfQ01c2JFoDEpBrS4IayoaL0PlL
X-Gm-Gg: ASbGncvSJVzUDM263CWyv6wrIu5heKzrANZ9v4NE2O6Rr8JaLlDWZWTNYqjGtw0r/HF
	BzH0Fc5jL8NyHW5W8LrCVnJmunMMhlRP3o5YkAtWcFgQPrEd8pgl2TuhuLo+GRgGpzU2oSpjMF4
	ZxF1mJZScpd4bOtfrDyActiq0+N0rbdAuQKMu7TwVwAibz4YZJ/ZwmAcPx
X-Received: by 2002:a05:6a20:72a5:b0:343:af1:9a5a with SMTP id adf61e73a8af0-352291520b6mr2205562637.5.1762477260189;
        Thu, 06 Nov 2025 17:01:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGZjYhyU2I/iqThL1SwvIj+q56hy6nUrJ+za+wlQBhGl64lNQqk0EUbiOrhi2GgmjKaUpvt0VIaarghb0tmRU=
X-Received: by 2002:a05:6a20:72a5:b0:343:af1:9a5a with SMTP id
 adf61e73a8af0-352291520b6mr2205498637.5.1762477259683; Thu, 06 Nov 2025
 17:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107003005.107D6C4CEFB@smtp.kernel.org>
In-Reply-To: <20251107003005.107D6C4CEFB@smtp.kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 7 Nov 2025 09:00:48 +0800
X-Gm-Features: AWmQ_bkXy77GLlQuIcMFJZTYbmotYc5pKuX5_CTlFqpD6b4cIml4CakEu0fWk5w
Message-ID: <CAF+s44QyfTDsXDXaAYtN3Kcf2i8g9J7tQdBnwDc=PtnTV-sM0g@mail.gmail.com>
Subject: Re: [to-be-updated] kernel-kexec-fix-ima-when-allocation-happens-in-cma-area.patch
 removed from -mm tree
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, zohar@linux.ibm.com, stable@vger.kernel.org, 
	roberto.sassu@huawei.com, graf@amazon.com, chenste@linux.microsoft.com, 
	bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:30=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
>
> The quilt patch titled
>      Subject: kernel/kexec: fix IMA when allocation happens in CMA area
> has been removed from the -mm tree.  Its filename was
>      kernel-kexec-fix-ima-when-allocation-happens-in-cma-area.patch
>
> This patch was dropped because an updated version will be issued
>
> ------------------------------------------------------
> From: Pingfan Liu <piliu@redhat.com>
> Subject: kernel/kexec: fix IMA when allocation happens in CMA area
> Date: Wed, 5 Nov 2025 21:09:22 +0800
>
> When I tested kexec with the latest kernel, I ran into the following
> warning:
>
> [   40.712410] ------------[ cut here ]------------
> [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kima=
ge_map_segment+0x144/0x198
> [...]
> [   40.816047] Call trace:
> [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> [   40.823221]  ima_kexec_post_load+0x58/0xc0
> [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> [...]
> [   40.855423] ---[ end trace 0000000000000000 ]---
>
> This is caused by the fact that kexec allocates the destination directly
> in the CMA area.  In that case, the CMA kernel address should be exported
> directly to the IMA component, instead of using the vmalloc'd address.
>
> Link: https://lkml.kernel.org/r/20251105130922.13321-2-piliu@redhat.com
> Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  kernel/kexec_core.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> --- a/kernel/kexec_core.c~kernel-kexec-fix-ima-when-allocation-happens-in=
-cma-area
> +++ a/kernel/kexec_core.c
> @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *
>         kimage_entry_t *ptr, entry;
>         struct page **src_pages;
>         unsigned int npages;
> +       struct page *cma;
>         void *vaddr =3D NULL;
>         int i;
>
> @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *
>         size =3D image->segment[idx].memsz;
>         eaddr =3D addr + size;
>
> +       cma =3D image->segment_cma[idx];
> +       if (cma)
> +               return cma;

It should be " return page_address(cma);" as [PATCHv2 2/2]
kernel/kexec: Fix IMA when allocation happens in CMA area
(https://lore.kernel.org/all/20251106065904.10772-2-piliu@redhat.com/
)


Thanks,

Pingfan


