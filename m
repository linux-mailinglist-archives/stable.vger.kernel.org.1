Return-Path: <stable+bounces-98852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2C9E5B76
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 17:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE26E283AF9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034821D5B8;
	Thu,  5 Dec 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMxGkMgE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5B21CA09
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416262; cv=none; b=BkzDvEWwaj7zbLFaxHncRVWjf5SwyuvU++gmjxJQgJEHBxYagxIRF7E6uH/QjU7Z/y7pgibyc6EvMHLv48GMMtuKrExKsjR6vdMUQk/1ceL7kzEqF6i2/1HoMgS7399aiuYoVjDz0V0w9+cJZr8U05PSou1FhIMJvTEH99eTmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416262; c=relaxed/simple;
	bh=hG4asEEnz87Q9QSfkohZl5iGcIqBAo677zQLpe5jZdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCdhQ++CVzSudvSakCFJy0org+9bIdFYOTyaoOjXkgdc1egIkHMOen+6C81ka1iAgbIW3aVUmfv+zyKGbxgAitUhp99YoLTl8TIKXN+Fdm+vhgvN9AMi24n9hTfQetKeLsjFWw+qHVmcw6dlhjF1hNZzfO9f2sGntUI2cu05+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMxGkMgE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733416259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZDDsZtHXJGYVGhruhoC9cWjiVOcL7T2FVpAbVAAILg=;
	b=NMxGkMgESl5cBNGX0eBscFv0xhD518RmgIrQkXZ0oAepKNUG03/wI0s57ZccqKbPsKnslQ
	QMx0Xave1rfigmh6Rdby+lkCG9FK6ugKNQuRxPWHkH+9C9bYsLfyC3CHRWmmdJYE9R1onM
	UrtFT89i0l+W/TjRYEk5UG+Wmtywcc4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-kZGRxYFsNziVbL_tDRYQmQ-1; Thu, 05 Dec 2024 11:30:58 -0500
X-MC-Unique: kZGRxYFsNziVbL_tDRYQmQ-1
X-Mimecast-MFC-AGG-ID: kZGRxYFsNziVbL_tDRYQmQ
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53de3a4752eso900115e87.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 08:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416256; x=1734021056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZDDsZtHXJGYVGhruhoC9cWjiVOcL7T2FVpAbVAAILg=;
        b=cryiZRZKS9psszMYt1NBqlWAdbWtqA/WybYgp6R4t9DRQGmhmywoXh6UaiLKhj04GI
         vBWo+XG8D5FT4AOklQX6q95ByvAx0F5Hst0xWpm+HMzi2dck84QQcn0JeMRHEkeQAoyZ
         vohAGbSyZaEIHTwkMV+ekg74u15z9mg1nvvh+5Zz1QCwjzfAKyVnDNNF99Jui3DSqj6x
         KUhXINT5SaOqv2FdPoC3vWW/4tOHFKFnJbfvtqkFih+mnsZA870lHB06cpcJnmWoav/M
         xd0kv5truE42nz6erKRLzt3TNYAkZNBCqZF6i0+oxMfCzbvelTScgFXi4fz9a64uAVh4
         x1+A==
X-Forwarded-Encrypted: i=1; AJvYcCWbtjgOBHIV4YMvWA8A5ONP/OB7KjMTheAYNGVSKLvg8urFjCmB1D76CSemxz7K2PzZhKU3SdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt3DK5tJjeskHfyLPjbPgn3Ut/EnzQJmjHndfJ+I3QOPSkDGSz
	Ju0Jmwf5mr7r8mdkxym4kG+ISCSfOxWY3P18LiKNpU6jwHvIfbQCXmKh03LLQ4/ZAhN6XM3VJrb
	7Mixmoyxe2QErbhguo+YUW7yzv9ZNI0RvbLPwrJE7LwKV4V660QU2NAcowKx69wLYJxpLPuZ307
	LO1jiaN/AOgOI80/hMa2+MZ4Lrr8Us
X-Gm-Gg: ASbGncuwpPEQ2oXVXNkVzIZCEtrDKEVk7m31sl16a6aCSJBhfbAqP/Mbya8VW1YiOGo
	19hTuxoDiSHCwJ2hI1zf/or784XMVgXTE4lfF7nXZAkj2XkCP
X-Received: by 2002:a05:6512:3e1f:b0:53d:ed77:37c1 with SMTP id 2adb3069b0e04-53e12a20717mr6729842e87.43.1733416256517;
        Thu, 05 Dec 2024 08:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgMd6PL+rgVfvFv9AGhR5OqbNp6njB71ewbVTz9WRoSrISoqHQip6WAnnlTdT75/bdbul6qE9mnUw2af/7coo=
X-Received: by 2002:a05:6512:3e1f:b0:53d:ed77:37c1 with SMTP id
 2adb3069b0e04-53e12a20717mr6729822e87.43.1733416256140; Thu, 05 Dec 2024
 08:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOi1vP8PRbO3853M-MgMZfPOR+9TS1CrW5AGVP0s06u_=Xq3bg@mail.gmail.com>
 <20241205154951.4163232-1-max.kellermann@ionos.com>
In-Reply-To: <20241205154951.4163232-1-max.kellermann@ionos.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 5 Dec 2024 18:30:44 +0200
Message-ID: <CAO8a2Si+7uFkOCf4JxCSkLtJR=_nQOYPAZ_WkWES97ifhyHvBQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good.
This sequence has not been tested independently, but it should be fine.

On Thu, Dec 5, 2024 at 5:49=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> In two `break` statements, the call to ceph_release_page_vector() was
> missing, leaking the allocation from ceph_alloc_page_vector().
>
> Instead of adding the missing ceph_release_page_vector() calls, the
> Ceph maintainers preferred to transfer page ownership to the
> `ceph_osd_request` by passing `own_pages=3Dtrue` to
> osd_req_op_extent_osd_data_pages().  This requires postponing the
> ceph_osdc_put_request() call until after the block that accesses the
> `pages`.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 4b8d59ebda00..ce342a5d4b8b 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1127,7 +1127,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>
>                 osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
>                                                  offset_in_page(read_off)=
,
> -                                                false, false);
> +                                                false, true);
>
>                 op =3D &req->r_ops[0];
>                 if (sparse) {
> @@ -1186,8 +1186,6 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>                         ret =3D min_t(ssize_t, fret, len);
>                 }
>
> -               ceph_osdc_put_request(req);
> -
>                 /* Short read but not EOF? Zero out the remainder. */
>                 if (ret >=3D 0 && ret < len && (off + ret < i_size)) {
>                         int zlen =3D min(len - ret, i_size - off - ret);
> @@ -1221,7 +1219,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_=
t *ki_pos,
>                                 break;
>                         }
>                 }
> -               ceph_release_page_vector(pages, num_pages);
> +
> +               ceph_osdc_put_request(req);
>
>                 if (ret < 0) {
>                         if (ret =3D=3D -EBLOCKLISTED)
> --
> 2.45.2
>


