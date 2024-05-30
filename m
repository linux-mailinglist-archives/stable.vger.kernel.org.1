Return-Path: <stable+bounces-47721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D78D4E79
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061DC1F22237
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9D145A01;
	Thu, 30 May 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIyMj6rC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310117D35E;
	Thu, 30 May 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081092; cv=none; b=PWqusfZp3xDY7VPHYQos+H3qsG4XF0MsGEz4SG6fPJj608sSKkK+mpdxFF5yWSNZYXH0l/kSZWdd9qxqWD00LMbTJ9TWyWPb2okIJ8xaiI6RRF08Z7V496Z3tZmMRd2NSAJEa4DpFpkM5Gxl/A0yxrrIGYlbVM6/fvKU+cCHr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081092; c=relaxed/simple;
	bh=vHl/hFne/dN3VS62u9WcIyO8pcYKfCjKEu2He7GV1JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpBZQ6cM1VOdRo5Zu8HRh++qDVyB8Y+MbzomcBoW4Vn0qm4BehFpXZO0vsPU+qSsX4Z+/z/9mY2/P/1nF+YwyBB7npoBEW6S9ZZo/a/hZdt+9oM2R/eDT3sXdoxHB0jDBuNh/KyBWUxku6MqkFVLVqzODef2rks9m1nF/jfacvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIyMj6rC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-702323ea6b2so659336b3a.3;
        Thu, 30 May 2024 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717081090; x=1717685890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pcneh6OdbXB2yw8eBub3uBTS5tn1ef9zWgBOmoSp/pE=;
        b=BIyMj6rCXKyErJ12caQIMKVLS1tC8uA4ibcuKhdpuaQIfQJ6KLsk5B05PL/rapeLuk
         qd41hkoqWOb9nZaE0LcZ6UR9S62F+qgKjTRPoWhmxdXrgaMIWTzFB0brs9TSJhWUzD4c
         R+DKGhNsklZ6ghU0eES3S7HL8bHqh/VoiIGDS0Q7dpY/C2v61ojMq2c566vHrvNYNY0y
         0A5PiUiQMkVmswdS6nlBVxb5hzJ1ilYBtQ1pGc1Q9jYeAhkBKRuswfi9GWZ5SLQK1jef
         DuxIcREvr+rYQj9bHD7PsKGZ5uxH4ZHoS2qGLzBy/0lliAcxbLb3Ty/GexcybH5IcoTo
         +WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081090; x=1717685890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pcneh6OdbXB2yw8eBub3uBTS5tn1ef9zWgBOmoSp/pE=;
        b=q2l1779Ir8dCHl0jjvjq7nUD81KIfkPT58PSG666YWN6GhqUsJSeIUZrvjzNUv1qS/
         2Au5lrffcKyzC7YqbpM2oCftfrVB1echzODvm7SzjKxN+nq3ozYfd/quWsMbP0tISHLk
         aqvLH0SrPTeKIivmZlW1c+LptG5hf74hTmIdMfmnAnxdRYItCKgBo8BtH/x9u5CJhWJX
         R3ts4YVLu1ZFEVggvWAIsvMPmDqrO43VtgcIMec2KtgpthnLg1IVIWUpIyxgPQdDUK6x
         Wg5EQoUdz9QoD0xjeybZqbljGyzBChavJuNW6KN3QCrh+DI++fwLYps8TYGx8naupYxi
         s6wg==
X-Forwarded-Encrypted: i=1; AJvYcCV3iX6CDh4tm2KNzQJzAmOp2IAi7bz/xIEFFMzykZH+89IxRBzdXTc0zbQhxo8I/DMGwwO+9DaqrG9wQXFv1txTV8AmaVAan4eCSDZR7up7o6Jmr0yBrK2Lmqs5J3kgmx4mxAmF4xYW
X-Gm-Message-State: AOJu0YzQE+AjktKgt7jjUd3TurYU6mDUL9d/YvTWs7cDXUQwgN9C+3ZI
	4zjnJ0diPJtvxWN7EgkY2wL2oQ4cENfVPIsdnIVK/RecJtUFwCZvqgwSB06Z+RTftrWYk1TDTFm
	lZ2v0YwRTvPL4POeqUBoVv2J+tDY=
X-Google-Smtp-Source: AGHT+IG/K9bjenhk0+Nldu2e8TDBOCESyblInvnkPhmih6+zxEhLkPmDFwz2LvGoFVaBBs/bIA3IpcKiiLGStFQRrDc=
X-Received: by 2002:a05:6a00:4214:b0:6ed:60a4:6d9c with SMTP id
 d2e1a72fcca58-702310e53cdmr2970675b3a.4.1717081090330; Thu, 30 May 2024
 07:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-drop-counted-by-radeon-states-state-array-v1-1-5cdc1fb29be7@kernel.org>
In-Reply-To: <20240529-drop-counted-by-radeon-states-state-array-v1-1-5cdc1fb29be7@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 May 2024 10:57:58 -0400
Message-ID: <CADnq5_P5Mz=Acm0HURUUHu03eBmemcu7jYe8nYJ5WtBjb93Qgg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Remove __counted_by from StateArray.states[]
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, May 29, 2024 at 5:54=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> From: Bill Wendling <morbo@google.com>
>
> Work for __counted_by on generic pointers in structures (not just
> flexible array members) has started landing in Clang 19 (current tip of
> tree). During the development of this feature, a restriction was added
> to __counted_by to prevent the flexible array member's element type from
> including a flexible array member itself such as:
>
>   struct foo {
>     int count;
>     char buf[];
>   };
>
>   struct bar {
>     int count;
>     struct foo data[] __counted_by(count);
>   };
>
> because the size of data cannot be calculated with the standard array
> size formula:
>
>   sizeof(struct foo) * count
>
> This restriction was downgraded to a warning but due to CONFIG_WERROR,
> it can still break the build. The application of __counted_by on the
> states member of 'struct _StateArray' triggers this restriction,
> resulting in:
>
>   drivers/gpu/drm/radeon/pptable.h:442:5: error: 'counted_by' should not =
be applied to an array with element of unknown size because 'ATOM_PPLIB_STA=
TE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible=
 array member. This will be an error in a future compiler version [-Werror,=
-Wbounds-safety-counted-by-elt-type-unknown-size]
>     442 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
>
> Remove this use of __counted_by to fix the warning/error. However,
> rather than remove it altogether, leave it commented, as it may be
> possible to support this in future compiler releases.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2028
> Fixes: efade6fe50e7 ("drm/radeon: silence UBSAN warning (v3)")
> Signed-off-by: Bill Wendling <morbo@google.com>
> Co-developed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/radeon/pptable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pp=
table.h
> index b7f22597ee95..969a8fb0ee9e 100644
> --- a/drivers/gpu/drm/radeon/pptable.h
> +++ b/drivers/gpu/drm/radeon/pptable.h
> @@ -439,7 +439,7 @@ typedef struct _StateArray{
>      //how many states we have
>      UCHAR ucNumEntries;
>
> -    ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
> +    ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
>  }StateArray;
>
>
>
> ---
> base-commit: e64e8f7c178e5228e0b2dbb504b9dc75953a319f
> change-id: 20240529-drop-counted-by-radeon-states-state-array-01936ded4c1=
8
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

