Return-Path: <stable+bounces-127318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35ABA7799B
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C1188EE22
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C11F9ED2;
	Tue,  1 Apr 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTn3EeX/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161F1F91CD
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507305; cv=none; b=GG4R2OCfJ4yUkqqXnSm7qZuweNkA3jziJaewiuldPkcZVr4JKy62P55CdB//6l4rj4Z0+TCvT9U5I4eaFi1+AunXB2Qy2ZuopUlp4WDp7mxPI/FvVpaTwL/kFpuiof0i6w0+zaKLWnhRGepd1Tta6CyJeByF4BZ58UHjKSPxkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507305; c=relaxed/simple;
	bh=lAEC+Pf5uytHLCbc/4PM5Z7g7tEIjr/2/EY3vxgSUVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrwXBA5h6T/WxWUU9tcKRqRwFb1dznyP7MFwC1OU7ofPaJ2Fa2pprGz0W4kI1obObgqlpYsbaCgDRKoVRGBxYOsgEXcMCVA6htFjrSrrUF9bkFLWsOf1EDaJBQx6GYgzY595s/GOE2r1UkgEFidUcFi8qS5m/mhuF8VAPJNfOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTn3EeX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743507302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF4YuDd97kbH9h4b0Huy41NC1nIWjQbGUIb1cXKzuDs=;
	b=YTn3EeX/GWjNmfvd0G65lj3cjm4D81oGDPLogLVUi3qZYSFJI3HEBMxXa/rlEIyyJdX8B+
	Uw8O64lc0MfT36c4bcd1UUItB8/KvVecfamFbd2NQ7KyzQUanIyKsD/gzyYc4d1U72QDu+
	b3yfYduIeQcBYIaYOXznGeLXe+nKWyI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475--G6_sfhBPSS1CjuPWOTbXw-1; Tue, 01 Apr 2025 07:35:01 -0400
X-MC-Unique: -G6_sfhBPSS1CjuPWOTbXw-1
X-Mimecast-MFC-AGG-ID: -G6_sfhBPSS1CjuPWOTbXw_1743507301
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-229170fbe74so81292255ad.2
        for <stable@vger.kernel.org>; Tue, 01 Apr 2025 04:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743507300; x=1744112100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF4YuDd97kbH9h4b0Huy41NC1nIWjQbGUIb1cXKzuDs=;
        b=UAM6Js7Yqdq3NblqMUcHQHTgHG4cJUPqQcVCOmT80VrHgGD5r30KqCwkpJmL0gHEXN
         nPy7BxKcfRbIypjKQWuBQqR2ckoHezs9JukrmknIHsoVT9C81IG6Z3CfkP1Uv9e6Wi8x
         25CPOQZ2Vj+M6WkmV2JP2chg8zeFqoQRVTsa9NnhDwiHT7V1x3dh2K9PAD4O9DquscE6
         HPO5XLfbnlUT8tVWz/XCKRcJDqXonvZ673wUJC1pnXDf8MTuZeKvx0DpoGL6ReSGFctN
         t/RFMWArtwICvCdQGyZrb0ZWyZpt35povAz7YAo/QUa/dm2FDVAZfAOhVHZxOKjnYAgA
         F7pw==
X-Gm-Message-State: AOJu0YwP7e0wJ3h28c3XhCKiH43GorbE3qbQZjFL5HfSGt7DYjDndPKe
	hTEDnxYHGtiGBfVcuikXklnDnzsHk/keRGxULIxX3HoqHNVrpn+Gz/M3qZ632gMpsdKNngBjhvL
	oxr+X0eDo5tTEesIOoy3mlj5S4lazUilovg7h0gqblwRDuipiPrmdrUKSf3GHvfVlv/meA9lx0I
	6NEmUlTLTKa3+TXl95w5r2ceL2CxI0HWdnXlV6
X-Gm-Gg: ASbGncuZSAVIKO5EtvHLgRGARr4gaDQAQvvq2HQT371aI4LakQLsKX0WMO8mycS6qS5
	1+OCwoqwew5X5uRoMQB4a8W7zFn7TapW7lWp5eCwPklxqiFMS7LwPhBfgIm4SXbDDLCnvUjo=
X-Received: by 2002:a17:903:2408:b0:21f:85af:4bbf with SMTP id d9443c01a7336-2292f95d1f0mr186006895ad.20.1743507299907;
        Tue, 01 Apr 2025 04:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSn5uOt98uhKZMMDLL1PKULGJN4KlvJ0HGSMvnm2Gb0y4uBbgD4AVkvun+hnHid4h00atdlaLqTwOr5wiMPx0=
X-Received: by 2002:a17:903:2408:b0:21f:85af:4bbf with SMTP id
 d9443c01a7336-2292f95d1f0mr186006645ad.20.1743507299575; Tue, 01 Apr 2025
 04:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331230324.1266587-1-aahringo@redhat.com>
In-Reply-To: <20250331230324.1266587-1-aahringo@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 1 Apr 2025 13:34:48 +0200
X-Gm-Features: AQ5f1JpDZFaI4ElGDN_h999frdCV6HsRsYbhA0HPvlCNr-3Y6fXIOT9mZSYMj88
Message-ID: <CAHc6FU7ny9PZeg6sipLc36VwiRChAbw=MtyCveGnX3pXLTfVKQ@mail.gmail.com>
Subject: Re: [PATCHv2 gfs2/for-next] gfs2: move msleep to sleepable context
To: Alexander Aring <aahringo@redhat.com>
Cc: stable@vger.kernel.org, gfs2@lists.linux.dev, david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 1:03=E2=80=AFAM Alexander Aring <aahringo@redhat.com=
> wrote:
> This patch moves the msleep_interruptible() out of the non-sleepable
> context by moving the ls->ls_recover_spin spinlock around so
> msleep_interruptible() will be called in a sleepable context.
>
> Cc: stable@vger.kernel.org
> Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> changes since v2:
>  - move the spinlock around to avoid schedule under spinlock
>
>  fs/gfs2/lock_dlm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index 58aeeae7ed8c..2c9172dd41e7 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -996,14 +996,15 @@ static int control_mount(struct gfs2_sbd *sdp)
>                 if (sdp->sd_args.ar_spectator) {
>                         fs_info(sdp, "Recovery is required. Waiting for a=
 "
>                                 "non-spectator to mount.\n");
> +                       spin_unlock(&ls->ls_recover_spin);
>                         msleep_interruptible(1000);
>                 } else {
>                         fs_info(sdp, "control_mount wait1 block %u start =
%u "
>                                 "mount %u lvb %u flags %lx\n", block_gen,
>                                 start_gen, mount_gen, lvb_gen,
>                                 ls->ls_recover_flags);
> +                       spin_unlock(&ls->ls_recover_spin);
>                 }
> -               spin_unlock(&ls->ls_recover_spin);
>                 goto restart;
>         }
>
> --
> 2.43.0

Pushed to for-next, thanks.

Andreas


