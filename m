Return-Path: <stable+bounces-253366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEykOnUIDmrY5gUAu9opvQ
	(envelope-from <stable+bounces-253366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:16:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ED55980A8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BA1630EA4A4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A440586A;
	Wed, 20 May 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsQBHPx+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021883FF8A0
	for <stable@vger.kernel.org>; Wed, 20 May 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303357; cv=pass; b=Ufmvdm6ZsP0yZFJvCUmQW/taNjCF7vfqj1iwLij3E+qLEAW3e9xzu12Pec3Pr+o+eATnNCiUQuUjqZfoPuMlxG4Onh5dxJpkFSKjehjtaJn2ORLvK7RBEj+Ae9nn6TwrEEpG5MKcpce8uehgw+SRGPmtYr8XMu6XZDgXQCnbgiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303357; c=relaxed/simple;
	bh=2u490WDo595MMxpuiyMNdGJ0Bm1Dajiv8tCE+WbJBN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShFMWQ1vPEMz0/cOXxc2c+6cXiJHwNGMQnfIbEoyYszwbgU9mvxRMXPfo5VjxQRiAlgy7DJm3Lyu1K6qyu6izYqqKgNvRVjztAlr2S0n4BfT3BPDiZebIAplgtGqPv+z8Waj+dP4hATcgFe1UCjMUQA465aYZE8gFRGygQ3Am8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsQBHPx+; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d1c670255so3595e9.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779303353; cv=none;
        d=google.com; s=arc-20240605;
        b=VipptVguUx1hReTBUZs1AlNST1uyZUK7VhI+qzT6Qxm7Hcgj3+/IhjqTHync4khivG
         jqC7KjZqovrlfnSSw/Shy3gsD2TzYbIbUaVtpAIbl+oaKxbePpZxSOsQs+CbEO2647Gd
         u1XiIhGrxQdFPOrOXuH+1Ptx8jDHf8PxDK76AlXLcs26muiBk6zpOkPe+jKvD9ilvZm+
         YPnMHJATsWd99BFdoUki0DsluqW8/UITIQGqNGiUgRW4/3DoPim8UPaXqH4fYIV3puj1
         JP8DlnF9kAdi1nQC9E3rrSznofTE159dtTx39wkR698B1dUL4qkqXBvt5wQVfYMUQWxb
         7eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E1+n5AcFKPfiWIk+cScd/VlPyCmYE0i+xazRrH2IaoI=;
        fh=F8pt44QfuTb0l4Rz2iH98EU6TcTGllyop6YMj+22qNA=;
        b=QaGh705NFBEJUwQRDHRl/eQeEC08Nuwol0c2xQEhFOT91WKI+S3abyyiujwE93PjTo
         pLTGU8QAFO8ySplQg9G3CqhcznjvUL9ve5FIYkd0jcOlTpYawFyTJ4VlL4rUrPIHz/UR
         AFkzLpygRTzaiY5Ilos60TCX7BKjYWtG6i+CRMeB2UnsHSdK5RgIyCjaNyVfVvJOIyeN
         wUyffAcfdRMhf7+aonvCLBxlntah1Ov8xJrtaIkBFmE0xFB2uo0vWJkR5Fz48Wto9qRe
         ee5cU0vGX9FLQpBeoasxfntOR+vGBXt12TFW9AJex7CST4Sx0gATLHHxbLThKb4MVX89
         uZWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303353; x=1779908153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1+n5AcFKPfiWIk+cScd/VlPyCmYE0i+xazRrH2IaoI=;
        b=WsQBHPx+1BdW+nbVnlTQBbGq63Wb1VaMHOB+/CgrJ85TIVE1XUrDcLI2HwYcGtbWIR
         N6+/EMzKPMWnIBJHfT39Ivm1F9ahWDYBFx0TVfLJz61eYOeCIewlw0OYpikMBLNnFxJr
         HO8KQx5ItyRAHj3UZUZU6+Fo7vj57dkt/v6lPHo6wYAJzbBP1JSJNY9xf7veS7zC2up1
         tEFmr3WozL8BN4j/iOBo0gqg64kTsqgh830MTm59+UKFHKL7dCAoSNjP8UIauEfM9oC1
         TSauVAuFuwi/R+61DGCvuy4qNbfp84N8YsRXtQO3nrEeC5Sj9l8Qxup2IXo5KE6p0g4e
         nyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303353; x=1779908153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1+n5AcFKPfiWIk+cScd/VlPyCmYE0i+xazRrH2IaoI=;
        b=fvulzjAlgyKODQv8vCdcofiErRv75hF02SGcif8oJGs2TPE+JVcXm1Kvxi5h0JXQBN
         21txii+ESkG+u9q6kromkUpT7ZHTjy/9Vn0MU2QJ+BoCgu7lWnThYL888jSenGF270Gb
         yM4YBlTCxB7thXAUa0HpNAzNJtoHInzL/dEcBC34NBvhIHDmslwvMX4/CCHHjx8+F0qE
         4t//V8d3FmfVdF8BE+ctCsB5pDHBPjpk8iRZ4w//9fHH2noZlVjGXDsYDwZe4GhWqnc8
         PpqlSlONXht3rFg3tus23Wb0Ud2ITrsQ5vx2oykJNzB4P5s8x4wqEdSo/lm5xKn79L5S
         DXMg==
X-Forwarded-Encrypted: i=1; AFNElJ9xTIPB7HvXYbYZiobX/8CKOuTlGMg/izH/fdlBGprJlWJI7Pg4CjtzzMNrO0bKuHhkTsm2Nrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9jiLrr1r/SbJSEWPOnFN8B0PT2u+7436WiByxTvW2qXpSlv5
	rpIcqA/+avhENmxLSQeHgdiPsFXXOx9g88hDxsGyph/eRjOd8NXa/NBDhQgqlqRYA8Y52Yl3Kfg
	G3DyLiSM5Fk8g2rMsoq2CIpVUb/KvmFCZMq1t+Kri
X-Gm-Gg: Acq92OHgtK9836oa44ZB1OuJwgSRZbBbvf9UsVOEQ+2xnHtRG4h20i4DkSUSuq1VCGM
	h9qy2x6MXWEkVExBikb4pZWBjDp+uJMLEVLKaBC2Mcr9gD9Xfk3WN2fngncX3qdUFbTlKGtOr/h
	jmwwMBGyYbqzYRzUgwjv7Fg7FYxZqDFsnULSGA8wjm441iTi2inaJXxWOMWcK/goQ/C1N+vYGGy
	TS15wlPsvfxi1Fe4qe6cRhVmA5YSPv/03dl6AqMwS1RXyxW7yg0hGdL06aMUTiMBqMn1vxgdbyD
	+csZMmfZwj4BZpomSb4nqWkz2mcJoe7VghSqJeDqw0MAU+IgkpjQ
X-Received: by 2002:a05:600c:609b:b0:488:7ed5:38ef with SMTP id
 5b1f17b1804b1-4903415dcf6mr120965e9.9.1779303352876; Wed, 20 May 2026
 11:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203530.66310-1-devnexen@gmail.com>
In-Reply-To: <20260519203530.66310-1-devnexen@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 May 2026 11:55:19 -0700
X-Gm-Features: AVHnY4KsF6gLgHIJlsnHvTuhZIZ-lL6YqMhepw9Q71OPa8u5kx3HMdWQKIsVi1M
Message-ID: <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: reject dma-buf bind with
 non-page-aligned size or SG length
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, sdf.kernel@gmail.com, kaiyuanz@google.com, 
	bobbyeshleman@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-253366-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 72ED55980A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 1:35=E2=80=AFPM David Carlier <devnexen@gmail.com> =
wrote:
>
> net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> PAGE_SIZE multiples without checking:
>
>   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
>     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->size
>     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =3D
>     N*PAGE_SIZE + r (1 <=3D r < PAGE_SIZE), sendmsg() at iov_base =3D
>     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.
>
>   - owner->area.num_niovs =3D len / PAGE_SIZE while gen_pool_add_owner()
>     covers the full byte len, so a non-page-multiple non-final sg
>     desyncs num_niovs from the gen_pool region for every later sg, on
>     both RX and TX.
>
> dma-buf does not require page-aligned sizes, so the bind path has to
> enforce what its own indexing assumes. Reject both with -EINVAL.
>
> The size check is TX-only (only tx_vec is sized off dmabuf->size); the
> SG-length check covers both directions.
>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> Changes in v2:
>   - Reframe commit message around the kernel-side OOB instead of
>     "real exporters already page-align", which read as the OOB being
>     unreachable and undercut Cc: stable (Stanislav Fomichev).
>   - Hoist the SG-length check out of the if (TX) branch so it covers
>     RX too; RX has the same num_niovs / gen_pool desync on a
>     contract-violating exporter, just without an OOB. Keep the
>     size-multiple check TX-only (Stanislav Fomichev).
>   - Drop bool todevice; compare direction =3D=3D DMA_TO_DEVICE inline to
>     match the existing call site at the tx_vec[] assignment
>     (Bobby Eshleman).
>
>  net/core/devmem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 468344739db2..4f71de44c0fb 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>         }
>
>         if (direction =3D=3D DMA_TO_DEVICE) {
> +               if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> +                       err =3D -EINVAL;
> +                       NL_SET_ERR_MSG(extack, "TX dma-buf size must be a=
 multiple of PAGE_SIZE");
> +                       goto err_unmap;
> +               }
>                 binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
>                                                 dmabuf->size / PAGE_SIZE)=
;
>                 if (!binding->tx_vec) {
> @@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                 size_t len =3D sg_dma_len(sg);
>                 struct net_iov *niov;
>
> +               if (!IS_ALIGNED(len, PAGE_SIZE)) {
> +                       err =3D -EINVAL;
> +                       NL_SET_ERR_MSG(extack, "dma-buf SG length must be=
 PAGE_SIZE aligned");
> +                       goto err_free_chunks;
> +               }
> +
>                 owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
>                                      dev_to_node(&dev->dev));
>                 if (!owner) {
> --
> 2.53.0
>

No hold on, I don't think we actually have a bug here. AFAIR all
you're describing is intionional . Yes the TX vectors and their niov
arrays do implicitly 'pad' the dmabuf size to PAGE_SIZE.

But net_devmem_get_niov_at has this check that prevents us from trying
to send past the dma-buf size, even if it's not page_aligned:

```
if (virt_addr >=3D binding->dmabuf->size)
return NULL;
```

IIRC the NULL should be bubbled up to the user as some error.

Please double check that we actually have a bug here. If not, please
don't merge this. This change could break existing users using devmem
TX correctly with non-PAGE_SIZE aligned dmabufs, which is a valid use
case.

And if we have a bug, lets fix it in some way that doesn't deprecate
support for non page-aligned TX dmabufs. You may be breaking users
here.

--=20
Thanks,
Mina

