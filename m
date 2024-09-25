Return-Path: <stable+bounces-77092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753E9854FF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 10:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F150283EAE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF60157487;
	Wed, 25 Sep 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO5xypmb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038414D2BB
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251452; cv=none; b=iZnknbL2vL3e8bswvgDW0EheqG644Sv2c7ZASOHQdgWJG4Rtm0Pkm0Nu4MkqUQ+jg5v6JekhkJIT0bLSNRwpzVESQYVtxUgFcHw9Be11OYPZAsImj9ab/6to1htjtKLtFocCdn+83A1uUhZ26ZXx40x1w95q2mVMkZVuGqz+ykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251452; c=relaxed/simple;
	bh=VB9g9c1zujyx7vmfcbvXFPnE0OOYMVj4A7JsIXSIbf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbMAciwsRI5L+dnNDoIpASx1AIPI5xe1rH7V9k72bx1uZA3GVzNmRsn91A2ZI40SdAKx4A5sZ9FnbpbieL1oLs+EGsLhQRvyHxZbH9yKGjUFyInoudSEOjfy8ixkRxSpva2CEHQkfwPrNxeCryPJ4Tq86ESAtuq5ZxU20a01eFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FO5xypmb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso231003f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727251448; x=1727856248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj+TfSlawgCc9Osig+lijT0zyXuRBIYW5Lo6S1CxHh0=;
        b=FO5xypmbWGQEGJPXkw+4XZs3V12jfyAEqqyiowyux+nAXvtBBYISbRzP0CDMAcE0gI
         H9Q7CGEVi78biivy7z0JByotLaky0QNzSARglaDeSA/EF3zgCh0hiJAK+ae3Rw1rRtY7
         rQ/Opb7oO0xNTrru2/i2xLRk8eTwsWnR+kvhjFA1eKmBanJmLGdOnmL2B95Q0OhkCwik
         MGUWreHQKmxtMoHNmXIXHjwMrS0PV2agYDN5G8U1NUEswdCcWNc44+CqsqHCNUhCcNQn
         Yo/Ancr6Hg70JaGMctyMQPOPFe2G3RzUPUlEjCNivmPfmUeVqnrxYLXdfyP5swPtxPT0
         RFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251448; x=1727856248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj+TfSlawgCc9Osig+lijT0zyXuRBIYW5Lo6S1CxHh0=;
        b=bnczX4d0wc2ZTh8sUFsucLNb5nf5BXd2BIWr9zTs0wuBOr21hNcuaJPtTcw5qWcwUr
         jKASHHwNRWmegtDQgWJlPV+XlXRFuQfk4m3YraGZAqdpzfG9SpgjKGUY60X5rHlLDQMJ
         cKgkhX+3z0l2IoUP+qpPah8nuN/UWTK4+xy8PSKJgTJnZYa3IhnwgozK01eAdOrg1tj3
         oT5SyRm7Q2WLIFomfPcH9M0inJgh42g7/pNGc6WqlgIWQNgsMLu3mL65n3zReZxex8g6
         le7Uim4xqiCVld0bHdtjzrKrk4sBwDTLutljZawHb+DulnPo9ygj8tyKH8IB5eItSBek
         djVA==
X-Forwarded-Encrypted: i=1; AJvYcCWHCA2rI31+4t1RpD0jCTroGQXl+l1kQcycJuBFCJIfjkLogruxx7BoOGsvuE+ub/6HchU8Mhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwamuuqJKj06p77pz+po2TAs5/0GjNX4frOxZQH1Sq9GgKfRTmZ
	8oXS7L3yWvPzWAEqG6nslS/JP7bb+i6goPbE2ckLrU2YvzeLUnnpA/AuGW0u0kYUpiRlEwtn3mW
	lmZJ9t8xkz/FCePpL1W9eoxFf8f4RiRCUSgS0qtQNHERx1muX1Q==
X-Google-Smtp-Source: AGHT+IGJUjYAV1NoP++0nFD187USsTcKM2oiOqdnaOcuM9TQvV7djhXHNMm870RitHPs8SUVyWCqox8ufG/44K/XXmo=
X-Received: by 2002:adf:fc08:0:b0:374:c847:86d with SMTP id
 ffacd0b85a97d-37cc2467801mr1164893f8f.16.1727251448214; Wed, 25 Sep 2024
 01:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-4-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-4-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 10:03:55 +0200
Message-ID: <CAH5fLggAoKssv+nmg54ibsdTtPF_kxU=WGHK6zQDRxaSd8dpdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] binder: fix freeze UAF in binder_release_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> When a binder reference is cleaned up, any freeze work queued in the
> associated process should also be removed. Otherwise, the reference is
> freed while its ref->freeze.work is still queued in proc->work leading
> to a use-after-free issue as shown by the following KASAN report:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in binder_release_work+0x398/0x3d0
>   Read of size 8 at addr ffff31600ee91488 by task kworker/5:1/211
>
>   CPU: 5 UID: 0 PID: 211 Comm: kworker/5:1 Not tainted 6.11.0-rc7-00382-g=
fc6c92196396 #22
>   Hardware name: linux,dummy-virt (DT)
>   Workqueue: events binder_deferred_func
>   Call trace:
>    binder_release_work+0x398/0x3d0
>    binder_deferred_func+0xb60/0x109c
>    process_one_work+0x51c/0xbd4
>    worker_thread+0x608/0xee8
>
>   Allocated by task 703:
>    __kmalloc_cache_noprof+0x130/0x280
>    binder_thread_write+0xdb4/0x42a0
>    binder_ioctl+0x18f0/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>    invoke_syscall+0x6c/0x254
>
>   Freed by task 211:
>    kfree+0xc4/0x230
>    binder_deferred_func+0xae8/0x109c
>    process_one_work+0x51c/0xbd4
>    worker_thread+0x608/0xee8
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This commit fixes the issue by ensuring any queued freeze work is removed
> when cleaning up a binder reference.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

