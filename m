Return-Path: <stable+bounces-10015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02C826F55
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915B71F2305B
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AA41229;
	Mon,  8 Jan 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfycwFOd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096B44C80
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557a615108eso6955a12.0
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704719468; x=1705324268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIf+Cv6l2YWxO4JRvhmFzcGOzPeJE4jlEsDS/yu4VlA=;
        b=xfycwFOdnwYILrHD1dDeS3m6Brnm8DG08dqHFwF/YBjjGMUCM31t0mgx5dHSrj61zE
         kMBtkIDskyK9M6vB/Hd75YitEzWALJCKzq7jn+AlpQPioiwYjngGjyk0bVSjg5N+a3hS
         fyN734Cy9NyWP9PSo67fj05vUf1tuvdFQDReefx3ISXUHCaAU7drE68WoD0C9DpJydXr
         LKyri6GfqNcFkpPKxN5j0PudnOxY1xUM0s8zLI4dbl8AGyFHFkEJcORDjIVExGrdayl6
         LlCTDZl+jlj10H/S5yczBYPStM64BM+ZRC23w31dVmz4rMw2Pq5iqZ33MVLzfpqESnww
         IDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704719468; x=1705324268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIf+Cv6l2YWxO4JRvhmFzcGOzPeJE4jlEsDS/yu4VlA=;
        b=IJH/xoe6uzehpGnUEEckzVpdS8Y4ZhzE+ZF867VH/MnRC7NVcs5gmvL6vJzgIUGCsM
         lyBF/FT+yP/1R42M/hJEPr+o8BkG9fB215Zxzoo3fEq0j0aGHdla4hbiwSF7pk0jcsG4
         eclrT0sjO9GoaKZfXgfSjZoxdhDFXhGCDLZssOgCfUr83+/L0ujzsV5H/AkiPz+ZrUpl
         twn+sHDEX1ZVXMg9faNuBOX3upTiYJSRe/vli0mPNVOHyD0Qn6Kxex8N8pYZuAtHGrkk
         CmtyV9S3d+hsUz5Fo1dAdveq1drIwIt8yY3Kte5ezLSmLoP6Q9EXjIME5gb3YQ+1jegk
         g9lQ==
X-Gm-Message-State: AOJu0YyrhUObubjHRh1nKOlb61N9ilCxfXAAgvk/NMEugolA2q8hy95y
	a1GON5atVtQkEaaP/1Ir3PZAxSCcF9Ev4jW9qeyxYu8rlgEXN1wR6m2dQm4fdA==
X-Google-Smtp-Source: AGHT+IHHhuENJkMB9VlNvntX4OWvxSCz6/tAl3VaO8nrQRADD6Rm5a1gf02yHWMGqhPrYj6+FQXSaxELs6ubgUpgN1Y=
X-Received: by 2002:a50:a690:0:b0:555:6529:3bfe with SMTP id
 e16-20020a50a690000000b0055565293bfemr265829edc.1.1704719467813; Mon, 08 Jan
 2024 05:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214194518.337211-1-john.fastabend@gmail.com>
In-Reply-To: <20231214194518.337211-1-john.fastabend@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 8 Jan 2024 14:10:31 +0100
Message-ID: <CAG48ez36YXSjKWMfpLFUj9RCRg13WzQG3dHC-cyUtyJLmZQ-Aw@mail.gmail.com>
Subject: [missing stable fix on 5.x] [PATCH] net: tls, update curr on splice
 as well
To: John Fastabend <john.fastabend@gmail.com>, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Boris Pismenny <borisp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:45=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
> commit c5a595000e2677e865a39f249c056bc05d6e55fd upstream.
>
> Backport of upstream fix for tls on 6.1 and lower kernels.
> The curr pointer must also be updated on the splice similar to how
> we do this for other copy types.
>
> Cc: stable@vger.kernel.org # 6.1.x-

I think this Cc marker was wrong - the commit message says "on 6.1 and
lower kernels", but this marker seems to say "6.1 and *newer*
kernels". The current status is that this issue is fixed on 6.6.7 and
6.1.69, but not on the 5.x stable kernels.

> Reported-by: Jann Horn <jannh@google.com>
> Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/tls/tls_sw.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 2e60bf06adff..0323040d34bc 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1225,6 +1225,8 @@ static int tls_sw_do_sendpage(struct sock *sk, stru=
ct page *page,
>                 }
>
>                 sk_msg_page_add(msg_pl, page, copy, offset);
> +               msg_pl->sg.copybreak =3D 0;
> +               msg_pl->sg.curr =3D msg_pl->sg.end;
>                 sk_mem_charge(sk, copy);
>
>                 offset +=3D copy;
> --
> 2.33.0
>

