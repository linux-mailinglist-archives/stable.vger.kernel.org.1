Return-Path: <stable+bounces-92132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778C9C3FB9
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593B91C21843
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911919E7E2;
	Mon, 11 Nov 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riSR2RXx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926714D70E
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332581; cv=none; b=iX9tZ0wFcXicOCthNdLx8Ek6gEeIafUavNrZqQUe8AIju9UILwluk5/Y+iLa8mdxkiHHE/+9yFkFx6yxWo8G6ovaTbHOoRNi9KkULgExJWK2YYlj2+5ErBuVMxxDHAaEwB++CWp9xcyT84k1NaGj11CiluwfEbP0DFr6QnmtN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332581; c=relaxed/simple;
	bh=gF6/BtnCKdtkeAzG+8E09gcLV3K8e5RynRf2hWztlPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/9MPsmrq+iwoOwT9dk0cWrp9ItmPtdKjLoEuzNmL/OPRyX3lQoNliFcUy3gcf4oD1RpYyWqD3a0no62rpvyvlCSwNMVMZ8pWbDQIGY/pS1ED3eMVBNIcCv461FRTcH8FZjVFAFURFK5G7yKaw4J+xQq4DaQuNiSe/Q44BTBscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riSR2RXx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c8ac50b79so256605ad.0
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731332580; x=1731937380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72liP3ILJcYy/3S9j69iqKfolSFq3Nj0JuCOpKZPINY=;
        b=riSR2RXxH/1eCEFDvtgh4ZoAxP5ov89ZSmsTm0hytuPv7rGK6gGST61dEpiN61Mxw3
         vAn4qWM3bhWk3D75e3IVEXZbDYWbTEzNuaxukEkTuwROVX34YUiYeyZNuzj6TRtuRXPE
         CBSfbdOpyTKNX+0oqfMmAEIudhAMEgGoIFGBV8U7l8Ub+zDh8G5fLSquPlKkT3nHyJRs
         RQ4XJ4fVidmdS8FSzEkLT35qQaVMnI9jTEgnoqBjZVIXqUbQgZh9MBdkFsmn0sIeIiS6
         8sPFNgxPCw0rxa7X4uSeeU0QiCw5e5wroZjZ6j/qGYScHI6W4h0SO6E2gBWvYe9TDbhW
         Pe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731332580; x=1731937380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72liP3ILJcYy/3S9j69iqKfolSFq3Nj0JuCOpKZPINY=;
        b=wvRKVLSD3XijTQkRloCHAc4hkPkvy7tZeSuBSlkqUPF8M3Kt+eck2RxcKUfvcEB4aK
         gLXz1kqGa2e9eVXEGWQ7venHyBtRsGi1jwS9I1q3ZQabH0SdRcD3N0t+804MRigDNnQe
         t2gWeb/Hm728qxi/YXIkFml0wfFkd93KgSmOFEspMLNNJcY8JxqfZFekR8CJEB+OQYHt
         PAWIKn+h6tTd1BUvCD8LSxxEfnGGeic6Xoybu0JJeOka7BTrtKbNq8SDyv3icYkX0IDm
         /cwGqKzM4G51KH9V+xsidaMy0kT1kIPYDG4L1lgmfNLWSI/vigt/6UehYl4ds92clep0
         Bh2g==
X-Forwarded-Encrypted: i=1; AJvYcCW9mXbgKaXc16uuuyDkZjUpNNosvsmzBkdKr9Bg8kEIGSutwG9dh0CcqVIZAAuzvg//sQJzxxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnjF8E9YSzrhg5zr24HZS0xRftRG+rYQ39hOAz53mnLlGPbxa
	tPWSFUE7YbDe/U1hpXIvLXOencyYmjbO+wQENn48dDT6jJTmzPYGMhoC3Bvc0wmYNfwDZfwaeTW
	aTQr4CMzuPyjhgri+HhgkSaTkz9M1CvzlhSDy
X-Gm-Gg: ASbGnct8BMO5++/aTRP6N8/xlz2TV5B0SvE4mBiyyAaTddGZ/qZ9rvaSvtboMpa7aRK
	4yIY90ujo/HoAJn+SoxKC7Q2ecFQ4cw==
X-Google-Smtp-Source: AGHT+IEJ+gVjHu6IDY7Kal6ws0MNoRNSbw1jsXvGRBX21ZRJfNzenUgKv9qTzqFUAN5RlMjCZlLITYHan3TVQo57grE=
X-Received: by 2002:a17:902:dac9:b0:20c:f3cf:50e9 with SMTP id
 d9443c01a7336-2118dea0987mr3600665ad.4.1731332579476; Mon, 11 Nov 2024
 05:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111082834.22492C4CED0@smtp.kernel.org>
In-Reply-To: <20241111082834.22492C4CED0@smtp.kernel.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 11 Nov 2024 08:42:23 -0500
Message-ID: <CADyq12z8Yqm1C8d1OMMz8N2H1LQ6Wj3L+pnMzCqmdbt-40AG_Q@mail.gmail.com>
Subject: Re: [merged mm-stable] zram-clear-idle-flag-in-mark_idle.patch
 removed from -mm tree
To: Andrew Morton <akpm@linux-foundation.org>, "# v4 . 10+" <stable@vger.kernel.org>
Cc: mm-commits@vger.kernel.org, minchan@kernel.org, kawasin@google.com, 
	senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:28=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>
> The quilt patch titled
>      Subject: zram: clear IDLE flag in mark_idle()
> has been removed from the -mm tree.  Its filename was
>      zram-clear-idle-flag-in-mark_idle.patch
>
> This patch was dropped because it was merged into the mm-stable branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

I think this also needs to be Cc'd to stable.

>
> ------------------------------------------------------
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> Subject: zram: clear IDLE flag in mark_idle()
> Date: Tue, 29 Oct 2024 00:36:15 +0900
>
> If entry does not fulfill current mark_idle() parameters, e.g.  cutoff
> time, then we should clear its ZRAM_IDLE from previous mark_idle()
> invocations.
>
> Consider the following case:
> - mark_idle() cutoff time 8h
> - mark_idle() cutoff time 4h
> - writeback() idle - will writeback entries with cutoff time 8h,
>   while it should only pick entries with cutoff time 4h
>
> The bug was reported by Shin Kawamura.
>
> Link: https://lkml.kernel.org/r/20241028153629.1479791-3-senozhatsky@chro=
mium.org
> Fixes: 755804d16965 ("zram: introduce an aged idle interface")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reported-by: Shin Kawamura <kawasin@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
Cc: stable@vger.kernel.org

> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  drivers/block/zram/zram_drv.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- a/drivers/block/zram/zram_drv.c~zram-clear-idle-flag-in-mark_idle
> +++ a/drivers/block/zram/zram_drv.c
> @@ -410,6 +410,8 @@ static void mark_idle(struct zram *zram,
>  #endif
>                 if (is_idle)
>                         zram_set_flag(zram, index, ZRAM_IDLE);
> +               else
> +                       zram_clear_flag(zram, index, ZRAM_IDLE);
>                 zram_slot_unlock(zram, index);
>         }
>  }
> _
>
> Patches currently in -mm which might be from senozhatsky@chromium.org are
>
>

