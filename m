Return-Path: <stable+bounces-112267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC6A281D9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 03:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 532557A163A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 02:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685E20C03F;
	Wed,  5 Feb 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvWnWZXx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1942077;
	Wed,  5 Feb 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722935; cv=none; b=E+85sjIXdi4++hENap1hRdex0H2VNyc9ndTfWa/grPIuyWlxkj1/et74fd6W2FykU960AfwmAPu5XVDFsC5w3AQB/IZ/hbQOnChUq9SqQoLXSjvNbWPOLAFi09OUjpeRofeiC5xo2hfeAzyvtPvTme005TP9IIONV22Az9bRs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722935; c=relaxed/simple;
	bh=WOtdLbsfrE+PGA+dCq1gfe3hKpLA4ftoZsKiTg1xh78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN24jua2JY7SvMOYGRpOBJNHcO7dEqaoq+KQBWHHcZANI3hNwkctC8X7P82+U5ZvQF/nMcqmFTwI/IxiekTSKb6J4iV2q/ddWs3QKLgGRVR1onJsThWgo0bHNU0peknXTTyT5afRenYN52XKP1qHeQNLfXOnwTMLF7y+teYyywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvWnWZXx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4678cd314b6so58874251cf.3;
        Tue, 04 Feb 2025 18:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738722932; x=1739327732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N+4rW3SsekYEUc8nzCVlrVQkaioSvtxJiN6kI5HrK0=;
        b=kvWnWZXxccvz4GpTZGhv7UJhwtuapBrHQXnHdOnKiaP9+BEGGSZdXtXDE15yecWKM4
         3yh9LtwYoLs8tuhbkHmyWfvUbLqMjECGLaidFQXynZBoxpWuOdiPhcfWdVYk/Jhfp1dp
         2XyOIQbFSjiRZDBlHOjOZEvNRXcZFMT30z1rxTWiNwNeGeBIak2rMj+raOPOxPsjtH8s
         VgVTj8waI8SCa/FyhH0/UWlPIEtXqbIm/UTbYFko8vEgrVX/nyKV97jx6z6liPvNMQOe
         jk/x1KjnER2GP1CcAuZCWtg1e5qHZf9J2IR+gBzC75MnS8PAu/ZvWKPPrcOSk8Y4NagH
         ixKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738722932; x=1739327732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N+4rW3SsekYEUc8nzCVlrVQkaioSvtxJiN6kI5HrK0=;
        b=JUzBSsB8Xnk5QAMsr2vhBTkxJ6Oxvj56Sf2LFzmzzuU0HXTHu14fIy28fqlWPsqS0t
         8WMVVCEWyzUExc1P4sJxWCIp6CzCDJkc8Tnb43bUBiC3dOfs2aGfCaZKFIOV9nieISoq
         0t89P9C9udbf5iZT5gKHlt/iYodzFqQIZmLOeiJgbK6DxNx/AvqKZiW64agxBea6o/3W
         8kcnOdXooIDWWtL8/JOMTwnToxGPlObQeJuBqv1fMaMJHSzJigMcbrP/U8x2UXtNs77X
         n+a04kPcalxYvPjzZRDLsu1vhualh+8/XnV9gk/65atBluAvrPQf8cy3SC40lwJ6G3Ov
         KmRw==
X-Forwarded-Encrypted: i=1; AJvYcCV5fq9uZxLcoNxu4TD/O0uSbeT1Kkp/YjLemDMQp0Go7eYK1TRTZuokRXQSKvlnqKFN/SkPll1cosACzBY=@vger.kernel.org, AJvYcCXhaRwoA7CrZrG63FzQe3OwksJgeybdpjh+RkcBWfo009cuI0hr6ZnxwuWbk//B4HU+F8daBKEm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7w4z/A6q/fPZ2k4Y07Be7YZhcXqFwgyGGApx4d7WIjmhuIlz
	S3IIes8SCWV4xRr8J/sOqWMUDOn2T4r9S8ZxMfgcuHJgysmfnu5CEJYNMYGwp5WwMKtt6uyVCHR
	LPLE6gdX8lCzJ0cX/0DVN1I8nWZx1omAC
X-Gm-Gg: ASbGncsZC36WO0lZgJcOPb7Jp51fcFOAs9wUgH1655IJmyOvOqAHZXf9qjLlztqyO5a
	kH8lv9CGp3iVas7eSCmEAMTnUl/BuT267lNDU+0Q+u1Eid+wN2FofZKdfQ1LEY9/AOqQ+MMgr
X-Google-Smtp-Source: AGHT+IE063EYM4tWEE7WYPrDhbceSvU1oIFvALHqQjqTvkhDse0m/DanubcApO0WLJidamuFwaSloVjnb4AUFeQhGIE=
X-Received: by 2002:a05:622a:1a9a:b0:462:e827:c11a with SMTP id
 d75a77b69052e-470281ba564mr19695661cf.19.1738722932180; Tue, 04 Feb 2025
 18:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
 <20250204023323.14213-1-jiashengjiangcool@gmail.com> <e41d9378-e5e5-478d-bead-aa50a9f79d4d@wanadoo.fr>
 <48ad8f05-a90b-499d-9e73-8e5ff032824a@kernel.org> <f9a35a4f-b774-4480-910a-cdcf926df41b@wanadoo.fr>
In-Reply-To: <f9a35a4f-b774-4480-910a-cdcf926df41b@wanadoo.fr>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Tue, 4 Feb 2025 21:35:21 -0500
X-Gm-Features: AWEUYZkirK4j39ugQSeyxuqN18Ew0eSAiZ7kK5iwAMUijihh2awqnAb3jDJsyJM
Message-ID: <CANeGvZUzHVnQdwTkam4HE9EVfEf8xY4L7Y20vj5v_N-vbD9kzQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: Add check and kfree() for kcalloc()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jiri Slaby <jirislaby@kernel.org>, gmpy.liaowx@gmail.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Tue, Feb 4, 2025 at 3:50=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 04/02/2025 =C3=A0 07:36, Jiri Slaby a =C3=A9crit :
> > On 04. 02. 25, 7:17, Christophe JAILLET wrote:
> >> Le 04/02/2025 =C3=A0 03:33, Jiasheng Jiang a =C3=A9crit :
> >>> Add a check for kcalloc() to ensure successful allocation.
> >>> Moreover, add kfree() in the error-handling path to prevent memory
> >>> leaks.
> >>>
> >>> Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
> >>> Cc: <stable@vger.kernel.org> # v5.10+
> >>> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> >>> ---
> >>> Changelog:
> >>>
> >>> v1 -> v2:
> >>>
> >>> 1. Remove redundant logging.
> >>> 2. Add kfree() in the error-handling path.
> >>> ---
> >>>   drivers/mtd/mtdpstore.c | 19 ++++++++++++++++++-
> >>>   1 file changed, 18 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
> >>> index 7ac8ac901306..2d8e330dd215 100644
> >>> --- a/drivers/mtd/mtdpstore.c
> >>> +++ b/drivers/mtd/mtdpstore.c
> >>> @@ -418,10 +418,17 @@ static void mtdpstore_notify_add(struct
> >>> mtd_info *mtd)
> >>>       longcnt =3D BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
> >>>       cxt->rmmap =3D kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> >>> +    if (!cxt->rmmap)
> >>> +        goto end;
> >>
> >> Nitpick: Could be a direct return.
> >>
> >>> +
> >>>       cxt->usedmap =3D kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> >>> +    if (!cxt->usedmap)
> >>> +        goto free_rmmap;
> >>>       longcnt =3D BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
> >>>       cxt->badmap =3D kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> >>> +    if (!cxt->badmap)
> >>> +        goto free_usedmap;
> >>>       /* just support dmesg right now */
> >>>       cxt->dev.flags =3D PSTORE_FLAGS_DMESG;
> >>> @@ -435,10 +442,20 @@ static void mtdpstore_notify_add(struct
> >>> mtd_info *mtd)
> >>>       if (ret) {
> >>>           dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
> >>>                   mtd->index);
> >>> -        return;
> >>> +        goto free_badmap;
> >>>       }
> >>>       cxt->mtd =3D mtd;
> >>>       dev_info(&mtd->dev, "Attached to MTD device %d\n", mtd->index);
> >>> +    goto end;
> >>
> >> Mater of taste, but I think that having an explicit return here would
> >> be clearer that a goto end;
> >
> > Yes, drop the whole end.
> >
> >>> +free_badmap:
> >>> +    kfree(cxt->badmap);
> >>> +free_usedmap:
> >>> +    kfree(cxt->usedmap);
> >>> +free_rmmap:
> >>> +    kfree(cxt->rmmap);
> >>
> >> I think that in all these paths, you should also have
> >>      cxt->XXXmap =3D NULL;
> >> after the kfree().
> >>
> >> otherwise when mtdpstore_notify_remove() is called, you could have a
> >> double free.
> >
> > Right, and this is already a problem for failing
> > register_pstore_device() in _add() -- there is unconditional
> > unregister_pstore_device() in _remove(). Should _remove() check cxt->mt=
d
> > first?
>
> Not sure it is needed.
> IIUC, [1] would not match in this case, because [2] would not have been
> executed. Agreed?

Thanks for your advice.
I have submitted a v3 to replace kcalloc() with devm_kcalloc() to
prevent memory leaks.
Moreover, I moved the return value check to another patch, so that
each patch does only one thing.

-Jiasheng

>
> CJ
>
>
> [1]: https://elixir.bootlin.com/linux/v6.13/source/fs/pstore/blk.c#L169
> [2]: https://elixir.bootlin.com/linux/v6.13/source/fs/pstore/blk.c#L141
>
> >
> > thanks,
>

