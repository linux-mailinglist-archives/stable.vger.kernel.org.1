Return-Path: <stable+bounces-183457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFEFBBEDF9
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 20:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 931FD4F06ED
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41EB23816A;
	Mon,  6 Oct 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGopF/qP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D931922F6
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773641; cv=none; b=V/RENgmkWmqKNBMZHPxzhDFnmZRSI0U/yGAqRQZhtSmOHGgY+O3JG/C6tODdP6xM70yCTA7no7HUzwrDef801HODoLEqKZODa2hVnHzx/jRWp4Q/CB3LpwC1h0LYWksmHwCHSWIAZm9TMBFETXrMSR3PJE+53cHvXbBkztXcEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773641; c=relaxed/simple;
	bh=0GEMNRcZziGzb3s681pgK1hZuY+IKAUR9TQA+X75qiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7yzB8I0BUrA6ia4EdPIRj9r3jIn/rkQK8yGTIUBZ/Y35JoQOK82quIcWGwaQeH+J1JFxbseNVO7ycVbFI4pv7+djyHw+nrLxRPpMbDKmfEBWcIn0Fvi5bQQ/EIIneddREm5PXWzukGmO0FSkhWvic4WLnIfG659fgtgxU6OwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGopF/qP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso9455862a12.1
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759773638; x=1760378438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inbCGeX0MlCaOTe4pzWEAkquVwCrsIcfcgv0X9AXOR8=;
        b=XGopF/qPtyupbN0LE08URXj6BA3OCXBI4X3IA99iabFOuSjMJHI/cnVZyuud7W7juJ
         2IVLb3DxuhxwCLM76sHpS8JGl2AgjRh8jhhSJaVyE3OChfepX5Ye/z1eljXWGlsREGYD
         rBdGcsoIEZ15Odw4mwYlo6pmtItN9ZaSfeMJWBwI3qw0cLyCD8lkSPfwZszZx7Tu7/T9
         IYRTsEJFZ2nltYgmyjO7z/5sOYYvuPv3ke+37ylNK/UaNbywR0O2uZy29vaFLSW4Trzx
         uKamB45KFXxym6plXieuIeFNRSHiIATxLWfvQcNcLKGGwbTvSl3bV+sA/J1U0B5IJSBf
         ntfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773638; x=1760378438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inbCGeX0MlCaOTe4pzWEAkquVwCrsIcfcgv0X9AXOR8=;
        b=eOkKzPhhzFLtQmSHFJxu1QRdDBQlvpuhUVlUkjoAH0uzlaFiKVFURms22fs7GgaNQH
         23DBwEdRzf18HloRN1MXv96Bc5z61L6qY0R9QEaO9lbV7ZRAUuWCyBgvDaLjcoZcpB+M
         lveoTOUASgaH9swB+hJpQXEV1gtsURB9o4h4ymgVCo3SK+ueFlJl7uc1Rv1vppICI2xH
         nyVzRhPapbn/F1mhXtsr90pOTBE5nP1RuhszSpRLgDCjCbsOD7Glfe1a2pdY/QyXw6GU
         L2qxcOGFgyqcmpTycFrk8gccQ/lZL//0Gg/hHdoyPJUJXVnDkK+rzPWOkXNO75TtO7p9
         3kkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXgmR1lYHrrOUm+UohnKAj6bqgBy4FInrkD/Xgfxb92aDXsD1Cvy7XASM3j9f1mWqN6GloOag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSKx96liHPjnsQ5uDyDlMmH3AIBOl6Unx5/WnCQ+oeqQDHUSH
	jkE/WB1jHCHY7JdL4IM1XRhY/5B7RJlYOeZfQAepiS1C29i2U118/eCeZs+f99rvDo3w+nN5v/B
	Y/l2fGheqD375bldOKlvawPvEQHms7sQ=
X-Gm-Gg: ASbGncs1Y8VqydrUYf6SuTtkyiKWplUpSnZKPKYzsInb6Tx10zH5UpYBKfhz0EWH8QK
	AEFG3arXCbgcxG+Oi/zmW1RvYqDjOmXeCFXpxYPxxGvpOxvWjbDu6CReaW3nESpDvuYXjtQvZ9o
	NP8el4FZc2VaquQqvJMBDo2wf5erzPsaMvGnsVX2W40YOitgmLFoiPP62qOW4A44JJgELE7gE0n
	zTYp7I4x9JfOjxxYChSR7rRHILLK8svXoB4NL3X9go9bQlxVZ4wJOItYiJwh41Z5To7aN4oXQI=
X-Google-Smtp-Source: AGHT+IHc/KM682jYWj3WvcK4lSK7EMboJJkdUb1lxllQSBBYt5rLkWpEgXxcvdPFJR/OuHQrWNQ0UC2LN9vnzduKPDI=
X-Received: by 2002:a05:6402:354c:b0:633:d0b7:d6c3 with SMTP id
 4fb4d7f45d1cf-639348e53b3mr15040695a12.5.1759773637242; Mon, 06 Oct 2025
 11:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
In-Reply-To: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Mon, 6 Oct 2025 23:30:25 +0530
X-Gm-Features: AS18NWBipFXoldgwotbv0EXeAnZgq5bGgzj04ZlSOSM0MjF-bQqudelsREmIC6Q
Message-ID: <CABPSWR6B0M=nos=wBpjidXMPVYVDKYi0i+-ufuR460_m48vjVw@mail.gmail.com>
Subject: Re: [PATCH] scsi: fix shift out-of-bounds in sg_build_indirect The
 num variable is set to 0. The variable num gets its value from
 scatter_elem_sz. However the minimum value of scatter_elem_sz is PAGE_SHIFT.
 So setting num to PAGE_SIZE when num < PAGE_SIZE.
To: Kshitij Paranjape <kshitijvparanjape@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org, syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kshitij,

Subject line of your patch should not exceed more than 80 characters
[recommended]
Please check your patch format.

~~vivek

On Mon, Oct 6, 2025 at 11:17=E2=80=AFPM Kshitij Paranjape
<kshitijvparanjape@gmail.com> wrote:
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D270f1c719ee7baab9941
> Signed-off-by: Kshitij Paranjape <kshitijvparanjape@gmail.com>
> ---
>  drivers/scsi/sg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index effb7e768165..9ae41bb256d7 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1888,6 +1888,7 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * s=
fp, int buff_size)
>                 if (num < PAGE_SIZE) {
>                         scatter_elem_sz =3D PAGE_SIZE;
>                         scatter_elem_sz_prev =3D PAGE_SIZE;
> +                       num =3D scatter_elem_sz;
>                 } else
>                         scatter_elem_sz_prev =3D num;
>         }
> --
> 2.43.0
>
>

