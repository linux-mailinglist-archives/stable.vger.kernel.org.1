Return-Path: <stable+bounces-179741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB94B59BF9
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C6170363
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56A31B124;
	Tue, 16 Sep 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuYuso/H"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9030C624
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036188; cv=none; b=WG9CWb9hwygoewp6Dnfsfe1AG0q0bcbPz2neCvAeb2X4U1EAchDmderFkUePhXSRiFkDLYodoU9PDQ8mG7wzJptoE29VWmjuCUeUZKQ1arhzg3Y9ykWBiU1by5KW6CqiQLbe/gjD0eY0e8PiXVJMc9zzj6L33tZCh+6PJsgd0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036188; c=relaxed/simple;
	bh=Fa0Dr4dfGCPnuqxyzWaU5/riMvOQE/XL+WP+SmmUJ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/Eud7IZ9sQU5I7tZV+DA4vknyjnTEhO6JD3luRz4BgROuQnA6j2wVLn7vM5Jdzvq8Ws1V645WsJ009H0rxqDofZoNDRQZU9HT8o8lhmHVlvWEDXl/Taby6H0CwCBkx3XyHG9Ccr3OBNEhHBSdsBY1EVdokQoAmsGmpoYP4c6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuYuso/H; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so2772869f8f.2
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758036185; x=1758640985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=texts6YK6dHVfgZZeSBQl5brt53L42uPuX8uB3l26sA=;
        b=kuYuso/Hc7HXiwf0sWv54DUN46+b1/qPDv2uKpry4S8CwsD2dUCLnvQuCIT3es3a8n
         7/L/buyCO5ph0jTvPsthOqk83DVfHUMpvxc6LzNQPT4bwZtqSAZRUYf/sF1XlRsundft
         o6SiEOHA4WI4yCyjzHIZ9f+op+6HAx/rHKwv4tOqh+ArXDk4l+7VQ6IZ01rJJ/WFx1dl
         ry5+11ab6QRWeSZtYuVUtOOYCamY/pj78nN61bOGcDgj78arS/pCK9GwAjkqHtbnsrBm
         EgbwgmVfa6E/Oq9WGLns1cvDahmpsbrNl4VY9pcariYd2RD3BmhXuZXIt6OVwYzmjoM+
         NLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036185; x=1758640985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=texts6YK6dHVfgZZeSBQl5brt53L42uPuX8uB3l26sA=;
        b=NgYNzyHkP/r6MEIrRWpmJNDExnn6dpY8zXONMXd91aJqkVwyLnJ0C2XhyPJz1E5YXg
         9BCNAKuRMKO68BjQjuHRI+AKF8N1Kt+o8z0arqT/alcbckrVEwXayQMEOSWVtA05V5rn
         tlVkaTvSzsq2+vFw8eqPA6SfW2Kn6FFCBJeEC/ajzDuUifvEu7BVhiEmmjoi1J1JRCVr
         JOrKd36xiudIV6QT6Kc9cdUzrECbzU+aHVP4vHYdf0FROLrCbbCgeQjINw42AL150+d9
         IZrmMn9xdPBeBHfSvnjDQFzr01JdCYpdi9uIAjqhCmrde3CPrkY580Yf5+74o74S+hOX
         OWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq2QAF7IF9MUme6pkXlqr0o9FbqxWRNLWQNvbbHTD9DTUsNgcWvGAmHOC3wvuiCPpch7+W7IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+ZNGaxgaFv24SQ5AtCJnCatQ8kBiCA5hgtjZfPvEvwGIA/yi
	ATQ0GRXeybbVQbkanL5sxteOqjqq3wAviMCM1/8X2UnCfxXFydVLEf1ZegyZYKgwBHD0q51iwiA
	Ma01x+UxXGXH+Ls52xomTk5qV7Of7qMuKPg09aAKo
X-Gm-Gg: ASbGncuKr3n46CpNVHGO6/OeRbHX/bfdy1MJeMI3PyJoNlMuFCKDr0/O9GOdjNGOE2/
	kWZwMd+MMc+iIjQzLncdVLkDcegQwUvl2sIL3nB89BOiox/8t/sU/kUFv8FtPxWyTnBJGgfN5pT
	fou5fjDJFASoyFicIZoZOtidb5kj1xX9Nub8wOD5L6RhaETm7qCgueoKq+noLrpnSdAczxbeLL5
	1vmfQClVlcId/ta6rm7UzJ/x9sZupdyiBESHF5hjfzdcA==
X-Google-Smtp-Source: AGHT+IFy1RlL1SatJgBFIBvGoq3npIwG8d6Cn+4HJd5+MSUy27ddCNOgybatr+aQ4jtPxVHl995CYHsAfpJttecW+Y4=
X-Received: by 2002:a05:6000:1865:b0:3eb:9447:b97a with SMTP id
 ffacd0b85a97d-3eb9447bb52mr6106858f8f.54.1758036184384; Tue, 16 Sep 2025
 08:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915221248.3470154-1-cmllamas@google.com>
In-Reply-To: <20250915221248.3470154-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 16 Sep 2025 17:22:50 +0200
X-Gm-Features: AS18NWBLONbGoOBW37qrDmhLX61Yut1ndwXCKLgmrwXKz5E_ZpMaR_KAfK0teGc
Message-ID: <CAH5fLghdcCx_OrCY-xq2gxug4j4RTMnmZsoB-Y18tLRp=Z5R-g@mail.gmail.com>
Subject: Re: [PATCH] binder: fix double-free in dbitmap
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Tiffany Yang <ynaffit@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:12=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> A process might fail to allocate a new bitmap when trying to expand its
> proc->dmap. In that case, dbitmap_grow() fails and frees the old bitmap
> via dbitmap_free(). However, the driver calls dbitmap_free() again when
> the same process terminates, leading to a double-free error:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: double-free in binder_proc_dec_tmpref+0x2e0/0x55c
>   Free of addr ffff00000b7c1420 by task kworker/9:1/209
>
>   CPU: 9 UID: 0 PID: 209 Comm: kworker/9:1 Not tainted 6.17.0-rc6-dirty #=
5 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   Workqueue: events binder_deferred_func
>   Call trace:
>    kfree+0x164/0x31c
>    binder_proc_dec_tmpref+0x2e0/0x55c
>    binder_deferred_func+0xc24/0x1120
>    process_one_work+0x520/0xba4
>   [...]
>
>   Allocated by task 448:
>    __kmalloc_noprof+0x178/0x3c0
>    bitmap_zalloc+0x24/0x30
>    binder_open+0x14c/0xc10
>   [...]
>
>   Freed by task 449:
>    kfree+0x184/0x31c
>    binder_inc_ref_for_node+0xb44/0xe44
>    binder_transaction+0x29b4/0x7fbc
>    binder_thread_write+0x1708/0x442c
>    binder_ioctl+0x1b50/0x2900
>   [...]
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fix this issue by marking proc->map NULL in dbitmap_free().
>
> Cc: stable@vger.kernel.org
> Fixes: 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

