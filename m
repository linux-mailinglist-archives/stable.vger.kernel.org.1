Return-Path: <stable+bounces-155338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8FAE3C1F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E62116A3BE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DA323ABAD;
	Mon, 23 Jun 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0MrDDOl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A863239E93
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674087; cv=none; b=VoXuUahGW2PZVnNOyshacSd0S6J09fmiecIuv33GhaLKimOfmuVdQnHsgCde1jJFicie7VtXvjG1Uxo8RHkPD+gWMrl3h96FMQXy7tR3+Gdo6Lu1EauuamqDvk7Pf+GfHYSTCCAhR+ZmV/t3tcR8eKuUTI5hp7HSAUtqu+vg6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674087; c=relaxed/simple;
	bh=CadnOnqUrP01j9sf1g6sUWHOFqKProxbSycYgQcVmxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMNLODUsyJYUGfDoQXV8A2L0C2AZgV7b1zl0XT3F4rfh2sPmr1vWFkpgfyjgzQM5Hs2SVKDKQ6OsaoBeo07oH1TTioVT1s1fSdAQjCqTQ9d6FKCRDs4lxikjYl8E2Z0VrGIOS+iRgap6iRFWCWvZpNVuEHGOIVHyCsOJQ6UZeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0MrDDOl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750674085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lgw/bD4SindaQDwTXpeWQKLQPGV/k/mx1XMIx/reNQ=;
	b=R0MrDDOlssSp//wjxy2Ur9/L7dVOhlPKqXTDrPsorsOgcB89m/HYMgi9qwqmNs9/Iz7E9P
	lCSwOO8fadMKn12fIU8DwyqJCdOVe/eWJzLFMwfFvr4AKXmQd4btT3komc31mlzIEgfsV1
	a2B6FMDCkEodv5dXk1x5fqpJJqqMOOc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-AnAUNzg0O8i5T5n7bkHswQ-1; Mon, 23 Jun 2025 06:21:21 -0400
X-MC-Unique: AnAUNzg0O8i5T5n7bkHswQ-1
X-Mimecast-MFC-AGG-ID: AnAUNzg0O8i5T5n7bkHswQ_1750674081
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7118199f959so60180247b3.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 03:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750674081; x=1751278881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lgw/bD4SindaQDwTXpeWQKLQPGV/k/mx1XMIx/reNQ=;
        b=TYB/9v0eb26zVAyvvzTsGDw3ZJv3CQIr+GTtkGZBumUjAV2yna+ZzY750z6JktU+QQ
         oGoh7Zus0dX4wAikkd3U+hOZhhe4dO9W8btXrMbzNF2OxCYB06w8AWuBJjc0VCLCFmNy
         0bQKvoLZbTMCP4iApBm8rgV9jRhaKnRLgW4MW4gY1gJxjzmW5TyggK/WIoIPH0ho0jXS
         eopownunCyJXPuUTnY6bZrmO0wnlZcMzV5+xTMJzWnvZJ5iRTHjyQFjI1ccDUhhi0Rzb
         e0P46w7WmKXI2zNkRR8a8X/C27q/14GtxlVPludb4kaqojlkipDUW/pIdPNLW8wEp4Kk
         u8lA==
X-Gm-Message-State: AOJu0Yx8nZE7GeeBZdxjgQp8Gjnyuj+LyT88c6KkuVXKn9jh5c21pvM/
	cbCzqoaiAvojfqE64hXltfy+vTQNAP/w0BEy/GLihOuIjXn/KjH22oNxcis54eQUaiOZMcLS7gU
	CQrOgNF9lHXhHnXYKKpsWXsBWzC9L6IPn1bvXdWvTw9EfL4r+8XijzfGZVxQoIn9zX0m+zRNynG
	R6DI6t4St7gF1I6Axzwg72Wkb37JQcpwVz
X-Gm-Gg: ASbGnctGMzml9v0vtyVVg7Ap4YcAdKNfyYoAbu2S/ZlPChS/kNUeFV4HfRyrFoRxzKK
	dgITSMBTVb90qhstAlQIKWyJwbnan4BFTT97mitNoX48zzJueJ54DbyC7hOv1yEgD2FaCg6QQdp
	lcu3c=
X-Received: by 2002:a05:690c:6f93:b0:711:7128:114f with SMTP id 00721157ae682-712c63c5613mr173777297b3.12.1750674081367;
        Mon, 23 Jun 2025 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFiDnn92RagGTfufzHsxHhTXMUufsWyR4eKoIQO45W2ta/mlkrX/GRWBBKswWX0hUbhvXY3gbxHPfx0i3Xsoc=
X-Received: by 2002:a05:690c:6f93:b0:711:7128:114f with SMTP id
 00721157ae682-712c63c5613mr173777017b3.12.1750674081105; Mon, 23 Jun 2025
 03:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618114409.179601-1-d.privalov@omp.ru>
In-Reply-To: <20250618114409.179601-1-d.privalov@omp.ru>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 23 Jun 2025 12:21:09 +0200
X-Gm-Features: AX0GCFvydjAk0H9SdIviYpopwIHMR0R5bzlGmZzRGrpaLGnO5vBQo-A0rDztVy8
Message-ID: <CAOssrKddunTkNzY1ydgg-rpi1aTuq-ghgJcVuQOXnK1GH5HCtg@mail.gmail.com>
Subject: Re: [PATCH 5.10/5.15 1/1] fuse: don't increment nlink in link()
To: "d.privalov" <d.privalov@omp.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 2:00=E2=80=AFPM d.privalov <d.privalov@omp.ru> wrot=
e:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> commit 97f044f690bac2b094bfb7fb2d177ef946c85880 upstream.
>
> The fuse_iget() call in create_new_entry() already updated the inode with
> all the new attributes and incremented the attribute version.
>
> Incrementing the nlink will result in the wrong count.  This wasn't notic=
ed
> because the attributes were invalidated right after this.
>
> Updating ctime is still needed for the writeback case when the ctime is n=
ot
> refreshed.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
> ---
>  fs/fuse/dir.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4488a53a192d..7055fdc1b8ce 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -807,7 +807,7 @@ void fuse_flush_time_update(struct inode *inode)
>         mapping_set_error(inode->i_mapping, err);
>  }
>
> -void fuse_update_ctime(struct inode *inode)
> +static void fuse_update_ctime_in_cache(struct inode *inode)
>  {

Backport is wrong.  In the original patch we have

-       fuse_invalidate_attr(inode);

And that line comes from 371e8fd02969 ("fuse: move
fuse_invalidate_attr() into fuse_update_ctime()") in v5.16.

The fix is to not introduce fuse_update_ctime_in_cache(), because
fuse_update_ctime() is already doing that.

Thanks,
Miklos


