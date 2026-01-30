Return-Path: <stable+bounces-212853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMP3Oi9yfGmAMwIAu9opvQ
	(envelope-from <stable+bounces-212853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:56:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE03B8A95
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EC73013D52
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50EF2DE71D;
	Fri, 30 Jan 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6k09UEn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsHAy3BU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845A301704
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763360; cv=pass; b=ZzTHIfrW7Z4cWCXMyKvJoOek//IWfuU0ID9llAQRodGjCfcRF38VdKUvgL1Zjh07+IAR2/w3LBqJdulPHFS24YZQ4Tyan6Ug0/duOqRlQjEIN5ynH7Zb5ytgjqB83hGK38UxOTCaYp9/FULrO9i8bMYKFBocIZIJvIlkWoD5pbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763360; c=relaxed/simple;
	bh=tDUV2M7sFM1EXX304FGpuqw+CFIvJOM0R/NfHzgnVWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxMdh9a7Veu6kU7M7S4dz+p/zV6pWsXGW7BRWjHYamxyCNvUNWKGX74oVNDOZH73/d+Xlq0PX0SVBGqvBN5GIClpIGXVuUiNlxDyDUmto1dd78Ww5By6Hy8mHcOpvIaEaPgEfgy/jsBDVXuNIFC53mbHHC/CVfAzlOws+havB9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6k09UEn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsHAy3BU; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769763358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy7Lg/JNukiw01dctwhw0lTv8BVxCRgkGATAIRLOljo=;
	b=Y6k09UEnbYqjuUJoP3Q2j3fjIRQ3nJFR1bR4mM4NaRVMrSSXWbXqO+167/yDy93TyAOhNf
	uAIgbU2Rwj09bUsSEy1O9WNThxtzgYhSbBPhh3/owzyeyFNPNnshLujzpft4X1Rsgoi0Ew
	u7ZO7n13eonGHAKCFggJMXxgmkejc2w=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-uOJUGdZ-OQOLgNL9uPagsA-1; Fri, 30 Jan 2026 03:55:55 -0500
X-MC-Unique: uOJUGdZ-OQOLgNL9uPagsA-1
X-Mimecast-MFC-AGG-ID: uOJUGdZ-OQOLgNL9uPagsA_1769763355
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7900ab6755fso25252297b3.0
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 00:55:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769763355; cv=none;
        d=google.com; s=arc-20240605;
        b=EkBycPCRymjLDN/ADC8sCt7vc7j+1wSV5LeyJD6tiRsZ82RLarhZ1GLubaCxlId4Ro
         ygMwvZVkhZ8QkRTlKI5nDn7XMz08v2CT/33wzC2N4JTcCqAZFEelWbt55Ejvm+nJgOwm
         f1gV9hHUlWElxmQecQ2ikBLG6WO8pSUMZgDpeoHQ/+Z/qxLcuVlZ3HDrXsB150r8hr/Y
         f1zvNCmIhau6yvyTeKVFm9yhC4h6Hj4oGlFo5cJtEPwoFWqOlsHd+JxnLsAmWkmsKJre
         q/R3Ia8zVPeSQHt9ZxsA8ofp3L3oggly+iOPTNM0H7DEfJ08Ju0A3aVBRknyX/Ua3CqA
         1S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hy7Lg/JNukiw01dctwhw0lTv8BVxCRgkGATAIRLOljo=;
        fh=UQClBgLtNlalcsrZ/yQ6nUa+vF+5F6YozZhtaZ6i6vk=;
        b=ls8sJjtDUHynqgZQGUZNVsJdJn8EJhV8nB1rrD2GiBc6svdU3FjL3IOnA4qizexrw0
         GriSID0f8E5bnOZrbWvFZwe1SMLIgY1vVRTn5TM+TmWk3FCe1omh4wWLPgNFucS3mBKJ
         dJNEcweJZ4WZ644U0DtAbhc45N+F+Dbrhjfx3NjG4+XcfosmZV4feMyhNmoD1kWdLAy9
         PJEwBqkJLEzxf3DEhofwHFog3ssoBf6KtjJtMowFR4z2OGXlWu+2+u3AaCYBs/aeDWFH
         W3+Yu+0GpM/EoAzm1gByoODXLpxUdXN4s3PtX9l5owqN+fqzlZO2hkrNBbSjB0NEf+TA
         4fWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769763355; x=1770368155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy7Lg/JNukiw01dctwhw0lTv8BVxCRgkGATAIRLOljo=;
        b=DsHAy3BUcJocEF72F7MAehvgk8vBdRJgqz0vFfsYtvCSG2Q/zfacYJXfW/qM1PhnQh
         LY9eYaRLrgLAqXOeTKgOTEhanr6hVs0HDV7b4YGorHulbdPv55uY68oeDwUsJMv23Avx
         mmqrxeUi7HpsAM3QJE7jgG6tqnlJ/b/1+0fxdeY3KUm5dJwyGwwt+luudQxXBlaNxx/1
         4QFm2hfwmRDMaAbMq2C9R0lEiDpeUSLJKTyBkUwNZ2mKmkbp4DPbAsxhU92lrUQgyIaM
         Qoq6orQ9xito5+lN5Z+UecOS2ZaVJZNAvj9JR7Xya90GlfuNYUwmvXJJ5Sl3ZPS6C9Zz
         u5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769763355; x=1770368155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hy7Lg/JNukiw01dctwhw0lTv8BVxCRgkGATAIRLOljo=;
        b=agfwQuv5I1ou2b4ZLZNhZsMaMreF6DuJ+zaALc8exhapZQwwomorizMYa8vc19FTYm
         yrYVpbITVf5G2pH4dQElrvolBEYu4wb2IY7uDy30sl40ALwQMCqELuPbXdKEQP0Sf7RU
         qGD0UlBCB2EtUbR5DfCAZTFKzvQqXr13kSqx5+MWfDRN4bTRl8atOaevpJHSZSmm7n2C
         pVSlEoFyfNFxQKrUG0EKt+VxT7qJqZDv6/t7wJR787O62b7BzBmWsHs2OD61KV0FbNUc
         xs66g552W62aeggjkF4yBmcMtK6CPoi9GNZsH665h/SjPv5L6RTCv3SfUuvL1y5OFgJY
         x5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWz0ZNR05OYkUGwRly4HyUeFm+VU9URiQYXkDwqaCMhtV4M39vy/4D9TBRivMkvYwvD8MEljrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztsHOh9srpephJ2k+FnWblaBajTwOlydxYt3ukr2v/A7WtxHy0
	d0Bw2DO+KA5FaZER1Pw8UqjNTUXej40ZP9qIuTDI7jIymF9HNcsHgPUGof31G0tJtxIoWrr0Ajd
	9H76S7iDYvB33mBAnkxV/bHMAQQ44bmLC5CQs2P9if6RxhW1PC3SySooBuHsFe71fFF5tcoT93r
	e8VwS7kLT+Frg6WF3cV2NhUho5sNwJQ+rD
X-Gm-Gg: AZuq6aKglEl3SGxwGF3dRcQX6j92DbGY0msYHyrscEw7MHkn8Mz+D1e8ZZOoacJYafJ
	EGi5z+c88MTLebmF/CmH23F+w3wLt/VShSjugEsqrCKGY8Yi8porYs0kn73CPXDMfK/IKWaTON3
	NY0fLd7uz7Tx9gmLSCTGXjkoizfTynJjolH8Q748Z2r6AT+XwAxjW5cHfe0Y/8A4RULw==
X-Received: by 2002:a05:690c:45c5:b0:794:8f0f:e8c5 with SMTP id 00721157ae682-7949e01d485mr20228997b3.58.1769763355266;
        Fri, 30 Jan 2026 00:55:55 -0800 (PST)
X-Received: by 2002:a05:690c:45c5:b0:794:8f0f:e8c5 with SMTP id
 00721157ae682-7949e01d485mr20228917b3.58.1769763354885; Fri, 30 Jan 2026
 00:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130050750.4050-1-jasowang@redhat.com>
In-Reply-To: <20260130050750.4050-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Jan 2026 09:55:18 +0100
X-Gm-Features: AZwV_Qj4av1QMp6k4LYgz2oCC7PDlNamd-x8snWeLLa05FtKcVnQe5UNZ4leKag
Message-ID: <CAJaqyWdciiqB7uvUs0_13zYY9bO_h0KSxGqESDUN0ZRGfuWODg@mail.gmail.com>
Subject: Re: [PATCH] VDUSE: avoid leaking information to userspace
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212853-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eperezma@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4EE03B8A95
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 6:08=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> The bounceing is not necessarily page aligned, so current VDUSE can
> leak kernel information through mapping bounce pages to
> userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
> information to userspace.
>
> Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
> Cc: stable@vger.kernel.org

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 0a9f668467a8..ec743bed361c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -124,7 +124,7 @@ static int vduse_domain_map_bounce_page(struct vduse_=
iova_domain *domain,
>                 if (!map->bounce_page) {
>                         head_map =3D &domain->bounce_maps[(iova & PAGE_MA=
SK) >> BOUNCE_MAP_SHIFT];
>                         if (!head_map->bounce_page) {
> -                               tmp_page =3D alloc_page(GFP_ATOMIC);
> +                               tmp_page =3D alloc_page(GFP_ATOMIC | __GF=
P_ZERO);
>                                 if (!tmp_page)
>                                         return -ENOMEM;
>                                 if (cmpxchg(&head_map->bounce_page, NULL,=
 tmp_page))
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 73d1d517dc6c..57a40a821c65 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -976,7 +976,7 @@ static void *vduse_dev_alloc_coherent(union virtio_ma=
p token, size_t size,
>         if (!token.group)
>                 return NULL;
>
> -       addr =3D alloc_pages_exact(size, flag);
> +       addr =3D alloc_pages_exact(size, flag | __GFP_ZERO);
>         if (!addr)
>                 return NULL;
>
> --
> 2.34.1
>


