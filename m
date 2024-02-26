Return-Path: <stable+bounces-23669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3B867313
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE995B23574
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799361F619;
	Mon, 26 Feb 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBl+rhKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD01F606
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945291; cv=none; b=GazqFUVljLZu2DDJsfOnFs/9SNN5015I52Sa08cXN30U6NKrJGbusund65wdiAvepvZcWDjfVi3qPDSJkFLPQpAp4YsBcpR4hr0YDtWxyLTAlOxEMj1uJHTmY4gU6HoKxOrUVpnkgMPLyVpTZYl+X/XqZ9LV+GFhG7yD2p83urk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945291; c=relaxed/simple;
	bh=2W7nqze4rfbsAhYpOX7xXRIshq8YxH4CarHFMpSi5lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdQkmUK9pQMRhOXmM+LC5ngt/jfEMkRtTyuAXdV8R9/4SLX2XjxINVtQJZSzNS8Vtjiue7f3qe6QAmwGoHqDfmyV+3PthMXD3btyUeTWrqNiear18K2wmUO8YhMDdyEMTn4pbffSrm5YHcOdf6qPoASFs3P37cICBNvPIVz4u68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBl+rhKt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512ed314881so2645608e87.2
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 03:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708945288; x=1709550088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foivR3XXAX+qVJySQb+oa4MFfW/tnV+glYPQlPN2YIU=;
        b=RBl+rhKtr11RQZqN5FzPm82aSli3WFmT+Lase1CvP8OM0kfzEaDeS7o4N19XhLbYWx
         Q1nvQZ/nsCeN+4R9mjKnqN4WGp7//2sG+UCHnZaZQKxVtebFIzHnvAppRwrWBNidgIbZ
         WlybBxfvrW2O2RAtInlojFixvuyRd4N4W/F/QDJRv913tDcJ8vYG/PQu1bzmEk6269Ga
         kibAJl9lIufqXjUGDfpo0H31qZrWMH0EOEIgOenU8NfgAG9GFLhQ1pU7uCoJTibuk7+x
         kj1hpoiZ0/cKtYZQPVycviJSaFtChnfov+zpnPXlb3GvM/+7SMzeH+90SiNnKJ2zTuvz
         KQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945288; x=1709550088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foivR3XXAX+qVJySQb+oa4MFfW/tnV+glYPQlPN2YIU=;
        b=VODJMqicwhY/+WgKRKZJiSytcBzMk5Sxk0IugqHLqQqHUIEWCqDztmjpm+MMJw9tSN
         xjI8xJXMs/b/pSX5qkXEI2hrWNQYdbcxVQY2UriIYJMMjC6j8tyTGepvlKLTCGIXKmJ7
         ujqnsTAFD08/RiIcZBH9+zuQKFofGw5wa1qD7+ZCQS28DH7GMRs28RdrE0b6oWV1NNnF
         rcExESXse5qy5hAgyiup15KEuS5hwYGDpUUDEAj+7y8LGWpjBV++T0Nxrq3S52ffoB0J
         IickFWQ6kvy0hrej4L5hzkn1JS8/v+oguaC1rvURUr9zVSSMEOrQD7yin7jFGHVsLd5b
         WIHg==
X-Forwarded-Encrypted: i=1; AJvYcCVh1IUaioH+DBQq4kLdCHAfUGwdGQlvhsWL1jG5/jyEPwAGk5lxe5jbkaoh2nMzo/FRdu2oItZLEXnUMnrt+HxtkbsRo7Z/
X-Gm-Message-State: AOJu0Yw6RNWt1hORfQL6H74l+PGkqSFNVe2zyMZpazFw9JQ32g48iUyP
	Kn5bM4hoYaYyQLsi0Y/1UuV6DF3eO0z7k59zwqclwFfOXyehW//o0m7aep7TboDtb+Qpzlp9vwd
	iufnhGLCIH/nVGBFtgaXYdkKg3eOZrUaKyms=
X-Google-Smtp-Source: AGHT+IEnp8hw3NCW/ZwuIs5tYNmiDyKzNIkcoWwLOaSNKRCMHKEYOETi3ktqPqqjg8UdyxvajoVtR36nLACgDM25h0k=
X-Received: by 2002:a19:9103:0:b0:512:caa2:18db with SMTP id
 t3-20020a199103000000b00512caa218dbmr3817932lfd.35.1708945287402; Mon, 26 Feb
 2024 03:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226103025.736067-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240226103025.736067-1-harshit.m.mogalapalli@oracle.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Mon, 26 Feb 2024 16:31:16 +0530
Message-ID: <CANT5p=qNgSXsBg8Str6Er3noBdMwsB2gH5EMB+NbX59O=r_nNg@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] cifs: fix mid leak during reconnection after
 timeout threshold
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: smfrench@gmail.com, stable@vger.kernel.org, sprasad@microsoft.com, 
	stfrench@microsoft.com, darren.kenny@oracle.com, dai.ngo@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:00=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> From: Shyam Prasad N <nspmangalore@gmail.com>
>
> commit 69cba9d3c1284e0838ae408830a02c4a063104bc upstream.
>
> When the number of responses with status of STATUS_IO_TIMEOUT
> exceeds a specified threshold (NUM_STATUS_IO_TIMEOUT), we reconnect
> the connection. But we do not return the mid, or the credits
> returned for the mid, or reduce the number of in-flight requests.
>
> This bug could result in the server->in_flight count to go bad,
> and also cause a leak in the mids.
>
> This change moves the check to a few lines below where the
> response is decrypted, even of the response is read from the
> transform header. This way, the code for returning the mids
> can be reused.
>
> Also, the cifs_reconnect was reconnecting just the transport
> connection before. In case of multi-channel, this may not be
> what we want to do after several timeouts. Changed that to
> reconnect the session and the tree too.
>
> Also renamed NUM_STATUS_IO_TIMEOUT to a more appropriate name
> MAX_STATUS_IO_TIMEOUT.
>
> Fixes: 8e670f77c4a5 ("Handle STATUS_IO_TIMEOUT gracefully")
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> [Harshit: Backport to 5.15.y]
>  Conflicts:
>         fs/cifs/connect.c -- 5.15.y doesn't have commit 183eea2ee5ba
>         ("cifs: reconnect only the connection and not smb session where
>  possible") -- User cifs_reconnect(server) instead of
> cifs_reconnect(server, true)
>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Would be nice to get a review from author/maintainer of the upstream patc=
h.
>
> A backport request was made previously but the patch didnot apply
> cleanly then:
> https://lore.kernel.org/all/CANT5p=3DoPGnCd4H5ppMbAiHsAKMor3LT_aQRqU7tKu=
=3Dq6q1BGQg@mail.gmail.com/
>
> xfstests with cifs done: before and after patching with this patch on 5.1=
5.149.
> There is no change in test results before and after the patch.
>
> Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> generic/393 generic/394
> Not run: generic/010 generic/286 generic/315
> Failures: generic/075 generic/112 generic/127 generic/285
> Failed 4 of 68 tests
>
> SECTION       -- smb3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> generic/393 generic/394
> Not run: generic/010 generic/014 generic/129 generic/130 generic/239
> Failures: generic/075 generic/091 generic/112 generic/127 generic/263 gen=
eric/285 generic/286
> Failed 7 of 68 tests
>
> SECTION       -- smb21
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> generic/393 generic/394
> Not run: generic/010 generic/014 generic/129 generic/130 generic/239 gene=
ric/286 generic/315
> Failures: generic/075 generic/112 generic/127 generic/285
> Failed 4 of 68 tests
>
> SECTION       -- smb2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Ran: cifs/001 generic/001 generic/002 generic/005 generic/006 generic/007
> generic/010 generic/011 generic/013 generic/014 generic/023 generic/024
> generic/028 generic/029 generic/030 generic/036 generic/069 generic/074
> generic/075 generic/084 generic/091 generic/095 generic/098 generic/100
> generic/109 generic/112 generic/113 generic/124 generic/127 generic/129
> generic/130 generic/132 generic/133 generic/135 generic/141 generic/169
> generic/198 generic/207 generic/208 generic/210 generic/211 generic/212
> generic/221 generic/239 generic/241 generic/245 generic/246 generic/247
> generic/248 generic/249 generic/257 generic/263 generic/285 generic/286
> generic/308 generic/309 generic/310 generic/315 generic/323 generic/339
> generic/340 generic/344 generic/345 generic/346 generic/354 generic/360
> generic/393 generic/394
> Not run: generic/010 generic/286 generic/315
> Failures: generic/075 generic/112 generic/127 generic/285
> Failed 4 of 68 tests
> ---
>  fs/cifs/connect.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index a521c705b0d7..a3e4811b7871 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -59,7 +59,7 @@ extern bool disable_legacy_dialects;
>  #define TLINK_IDLE_EXPIRE      (600 * HZ)
>
>  /* Drop the connection to not overload the server */
> -#define NUM_STATUS_IO_TIMEOUT   5
> +#define MAX_STATUS_IO_TIMEOUT   5
>
>  struct mount_ctx {
>         struct cifs_sb_info *cifs_sb;
> @@ -965,6 +965,7 @@ cifs_demultiplex_thread(void *p)
>         struct mid_q_entry *mids[MAX_COMPOUND];
>         char *bufs[MAX_COMPOUND];
>         unsigned int noreclaim_flag, num_io_timeout =3D 0;
> +       bool pending_reconnect =3D false;
>
>         noreclaim_flag =3D memalloc_noreclaim_save();
>         cifs_dbg(FYI, "Demultiplex PID: %d\n", task_pid_nr(current));
> @@ -1004,6 +1005,8 @@ cifs_demultiplex_thread(void *p)
>                 cifs_dbg(FYI, "RFC1002 header 0x%x\n", pdu_length);
>                 if (!is_smb_response(server, buf[0]))
>                         continue;
> +
> +               pending_reconnect =3D false;
>  next_pdu:
>                 server->pdu_size =3D pdu_length;
>
> @@ -1063,10 +1066,13 @@ cifs_demultiplex_thread(void *p)
>                 if (server->ops->is_status_io_timeout &&
>                     server->ops->is_status_io_timeout(buf)) {
>                         num_io_timeout++;
> -                       if (num_io_timeout > NUM_STATUS_IO_TIMEOUT) {
> -                               cifs_reconnect(server);
> +                       if (num_io_timeout > MAX_STATUS_IO_TIMEOUT) {
> +                               cifs_server_dbg(VFS,
> +                                               "Number of request timeou=
ts exceeded %d. Reconnecting",
> +                                               MAX_STATUS_IO_TIMEOUT);
> +
> +                               pending_reconnect =3D true;
>                                 num_io_timeout =3D 0;
> -                               continue;
>                         }
>                 }
>
> @@ -1113,6 +1119,11 @@ cifs_demultiplex_thread(void *p)
>                         buf =3D server->smallbuf;
>                         goto next_pdu;
>                 }
> +
> +               /* do this reconnect at the very end after processing all=
 MIDs */
> +               if (pending_reconnect)
> +                       cifs_reconnect(server);
> +
>         } /* end while !EXITING */
>
>         /* buffer usually freed in free_mid - need to free it here on exi=
t */
> --
> 2.43.0
>

These changes look good to me.
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>

--=20
Regards,
Shyam

