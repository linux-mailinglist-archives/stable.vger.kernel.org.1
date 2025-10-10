Return-Path: <stable+bounces-183855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38022BCBD1B
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 08:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA019E4EB6
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A47271475;
	Fri, 10 Oct 2025 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgc0SajS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9314286
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079100; cv=none; b=YbXpKsRXg+PaUIE/T6kHmV4BUvD0WfnIFZ40YBAY/OZEfJv+lboQezje98rE/fkPMKFcoJ86L7YpKyBeMukHS2IM3/V4IoPWsuZ6mTlMbl/2yut11mp4yomGjL/Aa/Gom/u56TwROHSKtvZ7UQgcgT2avDde54jB/CngogcFUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079100; c=relaxed/simple;
	bh=JO89qedHC2MDzQioik5FsYyMVGDN4miABxDc+zrHX0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI6r9EnSlF7y7sB+XwtkTOwN/dSJNBKDpsgYQcgV2nhlv0nETrKGyvOrEyLBn/r996Jb0GMbDykpq3jYIjLd5Gm3ma4n8mq3qGjlaTUchSuB81CLUNuljWzI+oyoxwGRQEByABfCzC9FWlCXEq66WF6i6seeElNedbVmtRPDBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pgc0SajS; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9335a918867so166436839f.2
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 23:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760079097; x=1760683897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg0e0l77VG71toCseTjv4ZWJcNOrsHbf0eyR2Vr6uWs=;
        b=Pgc0SajS1Ybg2z6ik8kF0tAmXPhN1FnxZFTw5bc7cZ+nbSFWR8yturj4Weeo9aRqLY
         ihNdsPN+jdOzCD6QQKHC7tnvQXqPsjOEq4TGtB8zNZzuSlUtxO5cnqVfSTUJtL3v/zcD
         J+VaWO+tyKzMZdSMasxcgIUaYPIWa6vI8ZUNMa76ZE1EDoL5RVlfdPfnn3T17DWjXm3Z
         ks687f9vxNO0Td82+b+yOOGTGY50n1+9H/KQ8D6U75lRLN53DkCW2Cx3HMv3I+hbLu04
         AiGbG16s8QPa5iZZqFbFriwOs0Pd9uKuu5dZLFZ9Od4wq0cg120qDo/eCehHZ1j3niln
         4/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760079097; x=1760683897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg0e0l77VG71toCseTjv4ZWJcNOrsHbf0eyR2Vr6uWs=;
        b=KtB8v3aa2GN9ZMlUw33LRCkDaFngKwmy9VOBFL3zWBDWRz1hushaFA1aAhFbtNVX74
         I/WaIsmkcZBFNBXNnIecvZQXvHeGErbDPb45sso/IfGb6vDMeK+R0zQmONax0j/1O5lJ
         +Mgh1BqmkAtvcFx42ibN51n/NPrHhNMtTLQh1JRCepj6eWVxt/C+8IUl/syK+3wBCLR6
         eYJPAAGc9+eQolIROqjjD0eQZ8suu/fCHZlwcPzOX8WzxtCtnbohsjMnUrl8vJab2Euv
         CLKF6eOKp4vOd8oH1rmMC3D9m3zBmi1YmFUVnvMyrqC4IhjvX4IhmEs1E4vUjF9n5MOh
         Cptw==
X-Forwarded-Encrypted: i=1; AJvYcCVgvgWNfcRZ4feShuTy+5g2OAN751PmM/iRrFs7fyyfUqXngQc/A8CKc0dVmMjfyr5N9GiIUrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiYgFcanFIJZ7hlM4YL7Tqs7ritmtSLQVAy+Z6ZKYSURmAjJo
	14hV98YnllcBM8JTimeajIOMcjFwIJohWdAguwcNaBNb0I6zQ6NkHiGr6mt+spJXuLzS1cSDLPf
	GQ+tssX1da1vmQwdmtykPQNMOMobTdRk=
X-Gm-Gg: ASbGnctHVtpaRzK/KQt6iQ2ICcmHpNyN3E6acAwsjwuDc/QijPJk/qLfjKtIiCdVMFR
	7diZN5g+q0rrfm4Crpjl1xViysR92Sy+o0Y2mv1N56pfPgYMKVOo8EvdbG71Z7bshxiXbU194LU
	kJ75gj/HUiXzshGEjUhlMh81auwue4Kd20SbFP7RXXmxhQoQNRYvNGi88vXUaE/zneL5AriLzix
	gkjN+WftAMrukbW2K/ppBgrLw==
X-Google-Smtp-Source: AGHT+IEe8F2GZmi5p86X92Kgz6J3805Z1eNiHbQlhbqzs7s2OMXo54wa5LJlt3BYavvWRhltuJ3GA7pYmIhnRcbz9Fk=
X-Received: by 2002:a05:6e02:471c:b0:42f:91aa:50df with SMTP id
 e9e14a558f8ab-42f91aa5224mr58051315ab.30.1760079096925; Thu, 09 Oct 2025
 23:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008165659.4141318-1-aleksander.lobakin@intel.com> <aOfGZvSxC8X2h8Zb@boxer>
In-Reply-To: <aOfGZvSxC8X2h8Zb@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 10 Oct 2025 14:51:00 +0800
X-Gm-Features: AS18NWDlKhy58lp8knSTyrYulXCXM8f_V3QUHqfkuv613BZKEyP79qxM1IO6OTw
Message-ID: <CAL+tcoDJ3fCtgtrxwUnkgCPXkg9Zy6MKw-tNCuVEW2V1-yjvNw@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kees Cook <kees@kernel.org>, nxne.cnse.osdt.itp.upstreaming@intel.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 10:28=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Oct 08, 2025 at 06:56:59PM +0200, Alexander Lobakin wrote:
> > Turned out certain clearly invalid values passed in &xdp_desc from
> > userspace can pass xp_{,un}aligned_validate_desc() and then lead
> > to UBs or just invalid frames to be queued for xmit.
> >
> > desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
> > can cause positive integer overflow and wraparound, the same way low
> > enough desc->addr with a non-zero pool->tx_metadata_len can cause
> > negative integer overflow. Both scenarios can then pass the
> > validation successfully.
>
> Hmm, when underflow happens the addr would be enormous, passing
> existing validation would really be rare. However let us fix it while at
> it.
>
> > This doesn't happen with valid XSk applications, but can be used
> > to perform attacks.
> >
> > Always promote desc->len to ``u64`` first to exclude positive
> > overflows of it. Use explicit check_{add,sub}_overflow() when
> > validating desc->addr (which is ``u64`` already).
> >
> > bloat-o-meter reports a little growth of the code size:
> >
> > add/remove: 0/0 grow/shrink: 2/1 up/down: 60/-16 (44)
> > Function                                     old     new   delta
> > xskq_cons_peek_desc                          299     330     +31
> > xsk_tx_peek_release_desc_batch               973    1002     +29
> > xsk_generic_xmit                            3148    3132     -16
> >
> > but hopefully this doesn't hurt the performance much.
>
> Let us be fully transparent and link the previous discussion here?
>
> I was commenting that breaking up single statement to multiple branches
> might affect subtly performance as this code is executed per each
> descriptor. Jason tested copy+aligned mode, let us see if zc+unaligned
> mode is affected.
>
> <rant>
> I am also thinking about test side, but xsk tx metadata came with a
> separate test (xdp_hw_metadata), which was rather about testing positive
> cases. That is probably a separate discussion, but metadata negative
> tests should appear somewhere, I suppose xskxceiver would be a good fit,
> but then, should we merge the existing logic from xdp_hw_metadata?
> </rant>
>
> >
> > Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> > Cc: stable@vger.kernel.org # 6.8+
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > ---
> >  net/xdp/xsk_queue.h | 45 +++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 35 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index f16f390370dc..1eb8d9f8b104 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 opti=
ons)
> >  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool=
,
> >                                           struct xdp_desc *desc)
> >  {
> > -     u64 addr =3D desc->addr - pool->tx_metadata_len;
> > -     u64 len =3D desc->len + pool->tx_metadata_len;
> > -     u64 offset =3D addr & (pool->chunk_size - 1);
> > +     u64 len =3D desc->len;
> > +     u64 addr, offset;
> >
> > -     if (!desc->len)
> > +     if (!len)
>
> This is yet another thing being fixed here as for non-zero tx_metadata_le=
n
> we were allowing 0 length descriptors... :< overall feels like we relied
> too much on contract with userspace WRT descriptor layout.
>
> If zc perf is fine, then:

Testing on IXGBE that can reach 10Gb/sec line rate, I didn't see any
impact either. This time I used -u to cover the unaligned case.

What I did was just like below:
# sysctl -w vm.nr_hugepages=3D1024
# taskset -c 1 ./xdpsock -i eth1 -t -z -u -s 64

Thanks,
Jason

> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> >               return false;
> >
> > -     if (offset + len > pool->chunk_size)
> > +     /* Can overflow if desc->addr < pool->tx_metadata_len */
> > +     if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
> > +             return false;
> > +
> > +     offset =3D addr & (pool->chunk_size - 1);
> > +
> > +     /*
> > +      * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
> > +      * (pool->chunk_size is ``u32``), @len is guaranteed
> > +      * to be <=3D ``U32_MAX``.
> > +      */
> > +     if (offset + len + pool->tx_metadata_len > pool->chunk_size)
> >               return false;
> >
> >       if (addr >=3D pool->addrs_cnt)
> > @@ -158,27 +168,42 @@ static inline bool xp_aligned_validate_desc(struc=
t xsk_buff_pool *pool,
> >
> >       if (xp_unused_options_set(desc->options))
> >               return false;
> > +
> >       return true;
> >  }
> >
> >  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *po=
ol,
> >                                             struct xdp_desc *desc)
> >  {
> > -     u64 addr =3D xp_unaligned_add_offset_to_addr(desc->addr) - pool->=
tx_metadata_len;
> > -     u64 len =3D desc->len + pool->tx_metadata_len;
> > +     u64 len =3D desc->len;
> > +     u64 addr, end;
> >
> > -     if (!desc->len)
> > +     if (!len)
> >               return false;
> >
> > +     /* Can't overflow: @len is guaranteed to be <=3D ``U32_MAX`` */
> > +     len +=3D pool->tx_metadata_len;
> >       if (len > pool->chunk_size)
> >               return false;
> >
> > -     if (addr >=3D pool->addrs_cnt || addr + len > pool->addrs_cnt ||
> > -         xp_desc_crosses_non_contig_pg(pool, addr, len))
> > +     /* Can overflow if desc->addr is close to 0 */
> > +     if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr=
),
> > +                            pool->tx_metadata_len, &addr))
> > +             return false;
> > +
> > +     if (addr >=3D pool->addrs_cnt)
> > +             return false;
> > +
> > +     /* Can overflow if pool->addrs_cnt is high enough */
> > +     if (check_add_overflow(addr, len, &end) || end > pool->addrs_cnt)
> > +             return false;
> > +
> > +     if (xp_desc_crosses_non_contig_pg(pool, addr, len))
> >               return false;
> >
> >       if (xp_unused_options_set(desc->options))
> >               return false;
> > +
> >       return true;
> >  }
> >
> > --
> > 2.51.0
> >
>

