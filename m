Return-Path: <stable+bounces-77847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA7F987C30
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 02:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91728B24B9F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 00:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F34409;
	Fri, 27 Sep 2024 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDnps57K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CBEEA6
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727397540; cv=none; b=deAe/+mtk6YjmiM8Wkv5sSIayYM5lj7CH1Vpv+5M7mEe5lqQYFrIutoRqlqMAmj+lfik1XWJYKt2YYokE3hy5fmzaGYoPuKvvD0A770qosRp6FwPxD2pn3AEPXMjw5SLu94l8fqs0yfpB4H+O6ZZ3FEyr6Frv6OCSmGiM1xSsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727397540; c=relaxed/simple;
	bh=RoQcuYtXgZSaSu4pk3CoF38cPyy/Cae7qDA6oDadUA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFwGX+eqM6rn5ryWUR+8UfHj7eEWA9k0YOEGh6VuGRGx9Tb9IJDu1AW6rr/nIVFv6QDZ/Ysm6hpyyDcO4cykX+caP/NdvfG8ACvg9F+Svg3BxikMFAQmAyVPSpKuqbKVmVKjk3C68zMFNFqJGMzTnYBQiF+Ve1OCuHmFTWUX4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDnps57K; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2db85775c43so1201634a91.0
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727397538; x=1728002338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQD/ixtKcZmhVxo1tdXaoFoncY1lIGZ/DuAUv+05Pu8=;
        b=tDnps57KGMjXuwhVcAAyo/y1e1cFaDdyq9P8rk0uVEqXb9w1ehVCG2qCg11EpydC0M
         1P105M8sTuhOuqIw4szwZmWXTZgF73qCwtuRZvtQ0Vcbr51g4FhAIcciuE4rKTpi3lDb
         N7CPfzObYf6TLV2o7iQmsdFdbNU25g/yeC2mPDlEPTX48RlLDwMShAAcmbt9cQ4/vSyM
         SqgNWdxtYcHa3KgaBLf8lnDduhoY3cNbRMx6wt2eYDEOM7avBiA96r+a0zlVFWnNhaIC
         DBT8lXH4imGEGduF4BDio+SXQFEGr7zruLJSW4cqwFSQ82mNh3jPu7/JZ9BtKbiiNHqM
         2uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727397538; x=1728002338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQD/ixtKcZmhVxo1tdXaoFoncY1lIGZ/DuAUv+05Pu8=;
        b=KyoAPLsvc4i64rkb2jVtoa8nYG6ZlCFx7tvgDlMSlU1akKpHBGRvEMe6DyYqpkLOO6
         lU41MyIn4UFBnYKnzbLLgRAJ7X8Ms8A59MA5U87PyeKNQgGcFcdvp/T9XqtMFy+Iw9k8
         xqldD+nT45VIYx3PnSoCKBk39GzBYIENUXqWpy+AlPM6L0krlLy2BLcrsKmW+9urE/56
         sPkSwkERZlxF6+Fs6R2qix6cb+DjzmGAHOx2fUmcXc8UF8bEGetfWjHr/i12aG/TgaH2
         7awDk/0EUuZJL4ue9kX7dfWPddrWuiWTTKPMpDYs4Wd7mhv6+rfJuwl8Yg/vGCSW/9ZC
         YcCw==
X-Forwarded-Encrypted: i=1; AJvYcCU2rN9/JcQ/DxuiWogkGeezCGlwAtcjoc//DvxrdiHslsoL59QseI45E1bcbdaJen89FwdJPCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPz6+ObpPc256OmDqV2NWAJoZ2+t6+bbLyPUJ9nzNyGD8T64tY
	qSnccBZJiSgP1dZIgpNCXaYsB/+Y1olBsC+aP1p1r+0XoRZJx/lz9TdD+kQUbejOCYZtOP9/Stj
	hx0HSXfOCzxleHKyNzp4vKwJhY1EFYaTfZJCs
X-Google-Smtp-Source: AGHT+IEzTNU0Yymy2dLcPK+S3NriYVN2F62r19fvGHBhhlAeaWBTbu3O/z0UDnkADJbO3/1mJp8EEDOmLk6ifoiSNjk=
X-Received: by 2002:a17:90b:120e:b0:2d8:89ff:db1a with SMTP id
 98e67ed59e1d1-2e0b716e425mr2596094a91.8.1727397537433; Thu, 26 Sep 2024
 17:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-9-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-9-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 26 Sep 2024 17:38:42 -0700
Message-ID: <CAHRSSEzGyqPkxdaJfXOyvE_L6j98=7CEyU2FhJ8+OXwSosXXew@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] binder: add delivered_freeze to debugfs output
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:37=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Add the pending proc->delivered_freeze work to the debugfs output. This
> information was omitted in the original implementation of the freeze
> notification and can be valuable for debugging issues.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 7c09b5e38e32..ef353ca13c35 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6569,6 +6569,10 @@ static void print_binder_proc(struct seq_file *m,
>                 seq_puts(m, "  has delivered dead binder\n");
>                 break;
>         }
> +       list_for_each_entry(w, &proc->delivered_freeze, entry) {
> +               seq_puts(m, "  has delivered freeze binder\n");
> +               break;
> +       }
>         binder_inner_proc_unlock(proc);
>         if (!print_all && m->count =3D=3D header_pos)
>                 m->count =3D start_pos;
> --
> 2.46.1.824.gd892dcdcdd-goog
>

