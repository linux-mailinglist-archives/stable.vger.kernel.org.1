Return-Path: <stable+bounces-183703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20297BC9694
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157F7189C73D
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220352EA154;
	Thu,  9 Oct 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx1cpHeP"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381132E9759
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018582; cv=none; b=oPybQ+IpcchJCIHXRS2/FwphhkDPxjqmHbUr6CIOapT87EwVWd6/wef0MS/tUHoeKxrnGnXBYvwKvKjZ0YL3LM/Go2huOEHdbpYDkfnXs5XE0i34c8TpJHe7x3WwHqEa2se7OEtsrpha4+q8zngVgn+EjwLCmN6FrguFqrYZkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018582; c=relaxed/simple;
	bh=sY/gtgf7NBozOjwc2EeRJ+KgsNPbK5kep4ypL81cuJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3KGY0DAwLeX/ArKmTubaKRKBuLSCUokkpeYrxn/fALKTgKCjHKKWQf4yZLJc5ijnvtdUyyy8H6fzFYINtqTtdSzFa4BusLjIUgTAh/jTf9tTyimipEKngKfzzkkZYmQinkCRIuL0clms2+asg2t2sN3yJxz80kYAgvPi865EoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx1cpHeP; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so92563539f.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018580; x=1760623380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfk2bfyqFX2yPC1pilpdm6kUPU4T4/Dvd4LObp2un+E=;
        b=hx1cpHeP97IWTfCT66W1ey8BmgdueE/D7jc6vp7ykfiYizvyc/GsfcLOSLM6TXLhgj
         iWW0DwTWqTMlJQbjl0jgrp7SDTEQGQDXDURN1N6/+i/cZ5sXdwvJJkXzGVXOcfaOI2D7
         36u8V4bRl1U6piKJ9JqjusCQcJlCOk32W3ITClBZCzYmr1q+2ZscngIlBzpnnLao2Qxr
         vPwpCbLtuvfHpmE4G8DJOCiWi0vsOCKe8awit8HDZj9PoQVtjeB4SGuW7WoVVN8nJpl8
         XRJQoC/m7LDM1puM9HBFRMuSMcRaRftNpF60Pmdoui9AVYvyztxWlOEBXpT6MTImiZmc
         y8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018580; x=1760623380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfk2bfyqFX2yPC1pilpdm6kUPU4T4/Dvd4LObp2un+E=;
        b=lqVTP0+3ddhohLIcsMNULrm4YwJR2nMa9BXHgG0ruU+afsSlsaziufcBHralJNaE9d
         gaW6QEJ8bwiJZL1sFN858dQvSx6fmTBwylTLYloq+XBq5I4lrP4hFp7zuyVUhtBfHGKM
         ru1RBBQP9v0Bp+Q+lCTkEN7FZpl/KfSu433s3ww/PkbO7lSWbW3OMb2nQbj3p/wv2JhV
         VxOIYqj/v4Y712pCBrLwmgxaTrTg9fVtmR4qkRBwMoAnBw6AQEa997rpqR6mvCjo2bGQ
         FTK+xZHRXKXjuvxd+ocib5oKObFDU1YVuqa2oKcTaLVQaj0CMtzFiSRR7IxktRTQw7wp
         GeBg==
X-Forwarded-Encrypted: i=1; AJvYcCUrX4JyBwZCQYHbljNZ0kHPwp/KMm7Fx3aVQQ6f097VYOTkbxSw/Cn8pAHZP36URsr7i57jc9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCDBxCy07lt51uMSkr21UGlI/4pxDMHo3Zc6Ou4XuGPyYwB9T
	NYXWJHGZ8nh8aHXEGkEvAkomLsW5juPCl7wgPC4TFOhYhqU1A6Fga9ssb8SlQa4xp27CMX28Efu
	7MpCQrRbEeTtbNCn2/f3y3laMFKpiPl8=
X-Gm-Gg: ASbGncthX09bOVi/0LPPUswrjCjBR8tvZzQfqs7tDZKiqmA6Nx0utlAvTQTuysRscZL
	+VWcFstXrqVdzWX2yekvmKHFhvEzWtVsr5ohI1Bu4gDdnSy9H+iSXR6X5VdnahPpuwKWJgsB5lh
	gjROZDcGpXTLjFNDDVEVmnOkzUHbk45/776BJfFB9VwhPMmsPpW1uWCn9xBQHdhoYtTrhp+DOH1
	FLLsS3a4KJaaWWENATDjXADDRDehhI=
X-Google-Smtp-Source: AGHT+IGFUh+yxdaAwOY01QTdDPRzmkqga8JwC7gVQ8hdE1VZLzwP/yHjfQX0w+P+lGz62g/ohriduN1YX1Cx7jhB7TA=
X-Received: by 2002:a05:6e02:4405:20b0:42f:9888:48f1 with SMTP id
 e9e14a558f8ab-42f98884980mr2655225ab.1.1760018579842; Thu, 09 Oct 2025
 07:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
In-Reply-To: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Oct 2025 22:02:23 +0800
X-Gm-Features: AS18NWAnZSobSr21rzMet2NXYBsUZ-tOijH1hdSEoiMgzrgWiOgQX5AxwPD-zdc
Message-ID: <CAL+tcoAWf4sNkQzCBTE8S7VgH12NPyqwiYDiig+jv0KGYAhFTA@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kees Cook <kees@kernel.org>, nxne.cnse.osdt.itp.upstreaming@intel.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:59=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Turned out certain clearly invalid values passed in &xdp_desc from
> userspace can pass xp_{,un}aligned_validate_desc() and then lead
> to UBs or just invalid frames to be queued for xmit.
>
> desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
> can cause positive integer overflow and wraparound, the same way low
> enough desc->addr with a non-zero pool->tx_metadata_len can cause
> negative integer overflow. Both scenarios can then pass the
> validation successfully.
> This doesn't happen with valid XSk applications, but can be used
> to perform attacks.
>
> Always promote desc->len to ``u64`` first to exclude positive
> overflows of it. Use explicit check_{add,sub}_overflow() when
> validating desc->addr (which is ``u64`` already).
>
> bloat-o-meter reports a little growth of the code size:
>
> add/remove: 0/0 grow/shrink: 2/1 up/down: 60/-16 (44)
> Function                                     old     new   delta
> xskq_cons_peek_desc                          299     330     +31
> xsk_tx_peek_release_desc_batch               973    1002     +29
> xsk_generic_xmit                            3148    3132     -16
>
> but hopefully this doesn't hurt the performance much.

I don't see an evident point that might affect the performance. Since
you said that, I tested by running './xdpsock -i eth1 -t -S -s 64' and
didn't spot any degradation.

>
> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks for the fix!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/xdp/xsk_queue.h | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index f16f390370dc..1eb8d9f8b104 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 option=
s)
>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>                                             struct xdp_desc *desc)
>  {
> -       u64 addr =3D desc->addr - pool->tx_metadata_len;
> -       u64 len =3D desc->len + pool->tx_metadata_len;
> -       u64 offset =3D addr & (pool->chunk_size - 1);
> +       u64 len =3D desc->len;
> +       u64 addr, offset;
>
> -       if (!desc->len)
> +       if (!len)
>                 return false;
>
> -       if (offset + len > pool->chunk_size)
> +       /* Can overflow if desc->addr < pool->tx_metadata_len */
> +       if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
> +               return false;
> +
> +       offset =3D addr & (pool->chunk_size - 1);
> +
> +       /*
> +        * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
> +        * (pool->chunk_size is ``u32``), @len is guaranteed
> +        * to be <=3D ``U32_MAX``.
> +        */
> +       if (offset + len + pool->tx_metadata_len > pool->chunk_size)
>                 return false;
>
>         if (addr >=3D pool->addrs_cnt)
> @@ -158,27 +168,42 @@ static inline bool xp_aligned_validate_desc(struct =
xsk_buff_pool *pool,
>
>         if (xp_unused_options_set(desc->options))
>                 return false;
> +

nit?

>         return true;
>  }
>
>  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool=
,
>                                               struct xdp_desc *desc)
>  {
> -       u64 addr =3D xp_unaligned_add_offset_to_addr(desc->addr) - pool->=
tx_metadata_len;
> -       u64 len =3D desc->len + pool->tx_metadata_len;
> +       u64 len =3D desc->len;
> +       u64 addr, end;
>
> -       if (!desc->len)
> +       if (!len)
>                 return false;
>
> +       /* Can't overflow: @len is guaranteed to be <=3D ``U32_MAX`` */
> +       len +=3D pool->tx_metadata_len;
>         if (len > pool->chunk_size)
>                 return false;
>
> -       if (addr >=3D pool->addrs_cnt || addr + len > pool->addrs_cnt ||
> -           xp_desc_crosses_non_contig_pg(pool, addr, len))
> +       /* Can overflow if desc->addr is close to 0 */
> +       if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr=
),
> +                              pool->tx_metadata_len, &addr))
> +               return false;
> +
> +       if (addr >=3D pool->addrs_cnt)
> +               return false;
> +
> +       /* Can overflow if pool->addrs_cnt is high enough */
> +       if (check_add_overflow(addr, len, &end) || end > pool->addrs_cnt)
> +               return false;
> +
> +       if (xp_desc_crosses_non_contig_pg(pool, addr, len))
>                 return false;
>
>         if (xp_unused_options_set(desc->options))
>                 return false;
> +
>         return true;
>  }
>
> --
> 2.51.0
>
>

