Return-Path: <stable+bounces-192478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F220C33F98
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 06:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1A1464659
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 05:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23E261B83;
	Wed,  5 Nov 2025 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkMFxPK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF825744D
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762319709; cv=none; b=DkYg4lam96h8jbL1U4IJVfRMpQPsm5wrgGDJIOi5pmf9SmyoGDJaAtZ0rQw92hTDufm82zdiQUxPmmA+fXm5feX4+OI1vWozdDo68JrhK9VWPAKIYr2jBt8WnKmMYr+/7WHg82baMHxsAH31HrKrUXj66MFV/pj2JXoZddRevO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762319709; c=relaxed/simple;
	bh=U1gcHYEs9i1aYxKKaiMBpSNsLLBtCBGwKROrVszwRYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9jjz0WZ0Pf3Ui+rLXhd5k//6NJunZoqtU1V42sM1oMVTOMqH0yjMqTa49SlBsTXrcYdP0kmj6l/rJHX4WsHCSwmyLYRz4acnWFufO2LOc1KRNwg+7Pnrh21Ck0C8exj3RrYcNiUCv3Yw6ieYZMeQHa7mZH547NCw69hr+dGbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkMFxPK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBDBC19421
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 05:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762319709;
	bh=U1gcHYEs9i1aYxKKaiMBpSNsLLBtCBGwKROrVszwRYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kkMFxPK62VIsB9OfmQqvzhME4k+ydiNyvaGbgBGvbqCoGu0UxzgSGliq8e+B7PMxs
	 D6DedIDFkHSgmDoguZdy8dIZ3OZ4C8eNA0shL5VLrRagW2zjDpr38TIkLrQH4yF26u
	 43eRILXak4Zwt+3uPbVx9RTaslXSum/fMtmrm+242VV3m56amavNR7NLdZ4HydpNtp
	 /bzgXTFfe1o9gaHgDy5vG8+wjm5HvINTOtTWQDO9n3jxZydxMX6fMYJud5FeMons7a
	 hPucUEYzTm83YrPIAyin3Y6Bx25ucjioIGlC7mObKmQTPja1HDcj3v5wWDuBtCG1QP
	 YgvVor0Fz4CSw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3424579a12.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 21:15:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0T2a9i+KaKJcGPYEDETHG42jlX6o5YsB+VVfiX5zQuqd1f0dL3NYkR35Nb/2GWCp6qecvYFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3x/3pBX4n/TZQidj9yxW4nbB53thQd/QOZgHHL5ly0YVXQgBs
	nldnKUkyeDOkPh9TjVrsXNgOtM0F7ldtlJ4+d5ksDnIrHwtaQF2E2wr1VyFbgCMQwkIbgXZb5Se
	A+DgWXu3XZ0or7rwoC4xYwm+WSeiCPe8=
X-Google-Smtp-Source: AGHT+IFC37S1oyDl/UFRyqOhTM6lpKE7vOb4Rois7WuNYgcmNYNdTXbXGcT2OjA1QYiPpBNetwu+J2hwSLldIctFzqo=
X-Received: by 2002:a05:6402:5193:b0:640:baed:f675 with SMTP id
 4fb4d7f45d1cf-64105b77b62mr1432647a12.33.1762319707657; Tue, 04 Nov 2025
 21:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110432-maimed-polio-c7b4@gregkh> <20251104141214.345175-1-pioooooooooip@gmail.com>
In-Reply-To: <20251104141214.345175-1-pioooooooooip@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 5 Nov 2025 14:14:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ORc86pHr66OVhCAXWbvPy7Y2DVAH_ubipOXufQGD4dQ@mail.gmail.com>
X-Gm-Features: AWmQ_bneHOhxu7T1nX-P1IRNUTalF5hYblatzPqzqhor9kRyW5EvYEalAbVSk9A
Message-ID: <CAKYAXd_ORc86pHr66OVhCAXWbvPy7Y2DVAH_ubipOXufQGD4dQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
To: Qianchang Zhao <pioooooooooip@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, Zhitong Liu <liuzhitong1993@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:12=E2=80=AFPM Qianchang Zhao <pioooooooooip@gmail=
.com> wrote:
>
> When encrypt_resp() fails at the send path, we only set
> STATUS_DATA_ERROR but leave the transform buffer allocated (work->tr_buf
> in this tree). Repeating this path leaks kernel memory and can lead to
> OOM (DoS) when encryption is required.
>
> Reproduced on: Linux v6.18-rc2 (self-built test kernel)
>
> Fix by freeing the transform buffer and forcing plaintext error reply.
>
> Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
> Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> ---
>  fs/smb/server/server.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
> index 40420544c..15dd13e76 100644
> --- a/fs/smb/server/server.c
> +++ b/fs/smb/server/server.c
> @@ -244,8 +244,14 @@ static void __handle_ksmbd_work(struct ksmbd_work *w=
ork,
>         if (work->sess && work->sess->enc && work->encrypted &&
>             conn->ops->encrypt_resp) {
>                 rc =3D conn->ops->encrypt_resp(work);
> -               if (rc < 0)
> +               if (rc < 0) {
>                         conn->ops->set_rsp_status(work, STATUS_DATA_ERROR=
);
> +                       work->encrypted =3D false;
> +                       if (work->tr_buf) {
> +                               kvfree(work->tr_buf);
->tr_buf is freed in ksmbd_free_work_struct(). How can tr_buf not be freed?
Thanks.
> +                               work->tr_buf =3D NULL;
> +                       }
> +               }
>         }
>         if (work->sess)
>                 ksmbd_user_session_put(work->sess);
> --
> 2.34.1
>

