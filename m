Return-Path: <stable+bounces-69723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA723958925
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90230282C56
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B119005F;
	Tue, 20 Aug 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIo3oC1z"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7FA18FDA7
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163767; cv=none; b=n2FPUTG1KIYy3cRsWCF1oliLeHDGeRsQ5NF/xBo2KBDS2Qg8ZXbewARSUkaK7v8ckNCgzOBHOCOgMQ04GfMpH4v6/YPOyccegZSTJJNsto+QlSipXkjmvJvTw4vL8fImqxGiWuYg/qL/iJvQwN74FeJGFYEckvS+nvFuZYVglk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163767; c=relaxed/simple;
	bh=JEW4NWuGAZES/b91tJA7nvuGMZ5cDMcGOVSXH5zy+kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUyrkuk8NaksnybAf2ChFtdOz2lDOiaeixVG3LY7Wjx7AerbYIOwXmiIBY3vaGjQZrrdiLO4zkIS7k9zuE8cL7reeJL6W1VrgK+kEaTVMqxsNAJ6aZ5cCaSXMkmMevjjtD6uc8EWTIlmaSMU3vsdjFve/7GF8S4SCmXtJV+FwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIo3oC1z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724163765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6jI//rw3yShTXZczMS6gQeoAbE9NZq1Blrvaj1FYI0=;
	b=IIo3oC1z14p4CnkqnSDEXmqCkpmQzYIMTJr56LgnQgg0Z0k5DmVQoDyB18W5cSQtgswj3T
	tDLuQ9jUmWz7xSb+d6u2uIv9dlPtlrLMtuAAHbN3CpkWvFS4xl4vKTIMUDtk7dl89Z8V4c
	1U0Dc9VM9+XeZp9X4jurkXD1N4M+N8o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-1eJn0E4tO8akgpaYYnX1Lw-1; Tue, 20 Aug 2024 10:22:40 -0400
X-MC-Unique: 1eJn0E4tO8akgpaYYnX1Lw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-202049f7100so41707895ad.2
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 07:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163760; x=1724768560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6jI//rw3yShTXZczMS6gQeoAbE9NZq1Blrvaj1FYI0=;
        b=uxupbOPVMpBs4llR02LSO/rUwQrAaNFGM7XFNxTuNfZjPjjs9dSgtHumfUgbtNYv3G
         WBgtwmWxrbsa7gJQ7WJUpq5EA1f54fK8FXn3zaAeGWnZw51wXOOPsl01b5XHGRT/sa/q
         AsY/BCMd43BAvhdP/imH9NNjrrWrKJ4aYk/FBQiBh33WVk7nsyVtTaivmuDcVOk3Va/v
         Uox8nac4+1hwz6uNe0c84na8QOhhfeCHAnVpTFtl/DdDDM4tKUZO/bWviM7cSM3GO3E8
         LKJWVBF+jss1I3t1ccn2vkxGCMwf4kV1+05hRNVr4C8Q/pXM3anU93REx6bbAUR2J8NM
         BZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCX8UUqmMlXHrn+H5bj/6t9WMCCiylGPDKR+4rzzewzj9AuFBdcF8FoKVVJOsY2LZrsOnFhaGC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyayUSWjKJpG8DA70hiu9fkh0ZB1v6tw3hPN2tz23IdQ7Hdeflr
	uQD8KnClXo7aG9f3h4le6urDFqjqrtc/b93prT5nULMPT+SXolbHAbVvWrXRiJxX3qeqylyeVpl
	z2+tCO0kVUfhcJSuyg/jKuEIOQxNq7QTEL+sDuZzp2Grld3wJgf2hLcM+MbYahuFf5TekpfV3sV
	Pyvaoel6gRWAgnoPUvj7vk34NYCd6j
X-Received: by 2002:a17:903:8cc:b0:202:49e:6a35 with SMTP id d9443c01a7336-202049e8428mr129220615ad.19.1724163759905;
        Tue, 20 Aug 2024 07:22:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw4qLWYKGymRWTPsxtyvsNK4GvYqeKgRIw2A2QWzuIE7zdE3CAMJZZ9/DFiY3NBxHcBD7/3Ez0OLxjQlN5cYQ=
X-Received: by 2002:a17:903:8cc:b0:202:49e:6a35 with SMTP id
 d9443c01a7336-202049e8428mr129219965ad.19.1724163758924; Tue, 20 Aug 2024
 07:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820033148.29662-1-sunjunchao2870@gmail.com>
In-Reply-To: <20240820033148.29662-1-sunjunchao2870@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 20 Aug 2024 16:22:27 +0200
Message-ID: <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix double destroy_workqueue error
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 20, 2024 at 5:32=E2=80=AFAM Julian Sun <sunjunchao2870@gmail.co=
m> wrote:
> When gfs2_fill_super() fails, destroy_workqueue()
> is called within gfs2_gl_hash_clear(), and the
> subsequent code path calls destroy_workqueue()
> on the same work queue again.
>
> This issue can be fixed by setting the work
> queue pointer to NULL after the first
> destroy_workqueue() call and checking for
> a NULL pointer before attempting to destroy
> the work queue again.
>
> Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd34c2a269ed512c531b0
> Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/gfs2/glock.c      | 1 +
>  fs/gfs2/ops_fstype.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 12a769077ea0..4775c2cb8ae1 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -2249,6 +2249,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
>         gfs2_free_dead_glocks(sdp);
>         glock_hash_walk(dump_glock_func, sdp);
>         destroy_workqueue(sdp->sd_glock_wq);
> +       sdp->sd_glock_wq =3D NULL;

Here, sdp->sd_glock_wq is set to NULL,

>  }
>
>  static const char *state2str(unsigned state)
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index ff1f3e3dc65c..c1a7ff713c84 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1305,7 +1305,8 @@ static int gfs2_fill_super(struct super_block *sb, =
struct fs_context *fc)
>         gfs2_delete_debugfs_file(sdp);
>         gfs2_sys_fs_del(sdp);
>  fail_delete_wq:
> -       destroy_workqueue(sdp->sd_delete_wq);
> +       if (sdp->sd_delete_wq)
> +               destroy_workqueue(sdp->sd_delete_wq);

but here, we check if sdp->sd_delete_wq is NULL? That doesn't make sense.

>  fail_glock_wq:
>         destroy_workqueue(sdp->sd_glock_wq);
>  fail_free:
> --
> 2.39.2
>

Thanks,
Andreas


