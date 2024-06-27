Return-Path: <stable+bounces-56009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A791B271
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E971F249E4
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597119DF8C;
	Thu, 27 Jun 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfc6pPLR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BA13A3E8;
	Thu, 27 Jun 2024 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719529363; cv=none; b=hDjeLVmVpGfOagoarWnhdEtTS05BCrdAEti35HjjoJOOAor3uPxtVrCoX5KT8yqq6V39wIOczPmi3bwn9StYyTiYp3It/SwOCMfKdxSNcDU1Aer3JIwj4L0pfbgXjKnhITK3i0kkMMljiMvNCAoT6J79u57FT4uIhQNbKghcMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719529363; c=relaxed/simple;
	bh=aiolhD+dyxUTRN186M7q1SIwHWS8mV5MY9UdjimNGmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnW2+IJNodKkCAkxNqCQLwWa635dChNXLfn9mTYkHBYjNiLp/p46ebV4tcD16dH+pSXW0CrYBBUFPeKs+W/P1mYQYfFWJ8xo8wuvS2Mj3gSN4EADn3y5kenWHwlLqZr82EpYjr5N7WGH+gKWvTqlv7hVIMDY/TPfc5ivpqVrCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfc6pPLR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7252bfe773so1967266b.1;
        Thu, 27 Jun 2024 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719529360; x=1720134160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnOEwFCyggz503/ZybYbukRH2dYLHDiAN48qLQwUjyw=;
        b=hfc6pPLRV+AI+27KoJbby8JOqMxZQvu9rd1wgL5srYkJ+SShzurScsO9bu43dLBOoo
         fAYmZJAu3xN+cne9fSHmPqCRo1GXJfdUPSwAqua/J38jG4Rr9zTnLFm7XmECXPKzYCOd
         Ykiwpk0wklUItkVnvo8OETbFQH9Ipkiu3lmqJUAUKSSlp0aGYfsUicVUnrjfgEAdpqzr
         G7R0KSc9meHAxpQarhrVO2JnVLNOz3wTyCcrBADpP6HgxfZ7UYHpZDz7giaanQGZq0n1
         EddbunvIB5S+KcU78uQSQw47ohI0DLN8t2/KCBMnAidtdCCqkH4S3pyQubxSkfM6oBu2
         Oigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719529360; x=1720134160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnOEwFCyggz503/ZybYbukRH2dYLHDiAN48qLQwUjyw=;
        b=v8gWz9ZzMuBhM9w8itUFXA6YWbv9LZ1cULDBy+fgeVJNxoRiuBELlNlpa9Hu4HUBNu
         3PgmP9rtjQRjYy+T2jhn/McYbjTQEa5jBRXc7HdGLLFl1oBoWCoebo8GoDOGEsXUmjmE
         7Z6zutzjjBWD2HdCVCATlb9FNdsaPtfcZdvlwaowecoeTkTdrXM+x0ijzqKxOGPpSgf2
         sXYDikaHUT1tv55fCgU9anSRxdQ0+67A6CBRYXz8YtCLyDhVWOrXFIZeWfNps3YrfMG0
         p/o5QBLSf4t53R0xmKL+SoTb6uSPm32GQ+ZGPQxZh1v9g7Q6rnXCEcUox4YkyHn7UcJ0
         jRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWUQq4zOXinxckjkPvsL8tyMlKGv/0lMa8eYidYSq1pzp1JYtRZ46pcFogroSMpaR2wSD+OYQ0l/iPAtCFHNOAgOA+kGUbJAyvgbyVexy+V7ZCAChk6/22JEX/439/vEE/ITX0
X-Gm-Message-State: AOJu0YzrS2RXEY5tJj4BXhg3yCJtC7ZbdX0u+CJ3EuvW9/M9VqQ9qkv7
	i1LS06JrxE2e8wPfpJfSaQL8SWwKizvO/Zv6EX8fnga1wJPklNYaphPh4Eo3mKLvNIPDvx4FZke
	oN7lsBbhmuh5RJcivFada08aoEAM=
X-Google-Smtp-Source: AGHT+IHMeY5jM/wD/wv97U9VYE3QYen31/sqybOI0/uXha2NbNByjUWShGK4eJgrwM7PUPoyfc0VBUbdKDa6O/Bs/8I=
X-Received: by 2002:a17:907:8e93:b0:a6e:f62d:bd02 with SMTP id
 a640c23a62f3a-a7245c84f2emr1146127066b.7.1719529359712; Thu, 27 Jun 2024
 16:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627221413.671680-1-yang@os.amperecomputing.com> <20240627155425.a31792e7c4709facfcbd417c@linux-foundation.org>
In-Reply-To: <20240627155425.a31792e7c4709facfcbd417c@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 27 Jun 2024 16:02:27 -0700
Message-ID: <CAHbLzkp02odyQNogwSwzpBpUn+Yu4FEySHSn53GQy-i-iqEYuQ@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, peterx@redhat.com, yangge1116@126.com, 
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:54=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 27 Jun 2024 15:14:13 -0700 Yang Shi <yang@os.amperecomputing.com>=
 wrote:
>
> > The try_grab_folio() is supposed to be used in fast path and it elevate=
s
> > folio refcount by using add ref unless zero.  We are guaranteed to have
> > at least one stable reference in slow path, so the simple atomic add
> > could be used.  The performance difference should be trivial, but the
> > misuse may be confusing and misleading.
> >
> > In another thread [1] a kernel warning was reported when pinning folio
> > in CMA memory when launching SEV virtual machine.  The splat looks like=
:
> >
> > [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_p=
ages+0x423/0x520
> > [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not taint=
ed 6.6.33+ #6
> > [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> > [  464.325515] Call Trace:
> > [  464.325520]  <TASK>
> > [  464.325523]  ? __get_user_pages+0x423/0x520
> > [  464.325528]  ? __warn+0x81/0x130
> > [  464.325536]  ? __get_user_pages+0x423/0x520
> > [  464.325541]  ? report_bug+0x171/0x1a0
> > [  464.325549]  ? handle_bug+0x3c/0x70
> > [  464.325554]  ? exc_invalid_op+0x17/0x70
> > [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> > [  464.325567]  ? __get_user_pages+0x423/0x520
> > [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> > [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> > [  464.325590]  pin_user_pages_fast+0x47/0x60
> > [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> > [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> >
> > ...
> >
> > Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages !=3D N=
ULL"")
> > Cc: <stable@vger.kernel.org> [6.6+]
>
> So we want something against Linus mainline for backporting ease.
>
> >    3. Rebased onto the latest mm-unstable
>
> mm-unstable is quite different - memfd_pin_folios() doesn't exist in
> mainline!
>
> So can you please prepare the fix against current -linus?  I'll hang
> onto this patch to guide myself when I redo Vivek's "mm/gup: Introduce
> memfd_pin_folios() for pinning memfd folios" series on top.

Sure, I'm going to come up with another patch on top of Linus's tree.

>
>
>

