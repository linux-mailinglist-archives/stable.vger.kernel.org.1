Return-Path: <stable+bounces-192370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37276C30D36
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF0442728B
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636CF2EB87E;
	Tue,  4 Nov 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXxOlMUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F82E7F02
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257087; cv=none; b=EqfZXr48QgpD46TWd6SE+YvVarHI0MYik4F67LBZTVwOPOjKpatCrFjkOD7iXpaWREcxo94hPx+YlKugxkOZ5ya/I+WVoRMnBK6B1B4t2vq2Q+bHaF2RS3ul3R6AOBXzPLM29g+A9Ttzh0W7xNVZHLkjDnYwj8XfR+EO+2taxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257087; c=relaxed/simple;
	bh=4sxepXpgXyoI1KPueMhCUrJEif1TBujc2PXqQCP8udA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=subtW+3jJe3YVNM1EaHivyIOPPvfCc3xzxIjTsgUdTxHmReiEtJA992cbWDPWuHSxg4fRlfCCqAuyU8/zJsSsiUkLIvhLCIYa1ZQW4Bqfv1wcx+trP/beFco4IN+TXif90f4efeSSQK65bQH9VOj3Z7V23fvp1qsb8gt3ROA5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXxOlMUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89CFC19422
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762257086;
	bh=4sxepXpgXyoI1KPueMhCUrJEif1TBujc2PXqQCP8udA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hXxOlMUrR+aOK01iiyLx1NZQlQikZHJPsKwQh7vmPl4/eJv0e9fTbOBZqaV9vVvR+
	 tZYo2HsUOyStR1MTtDGHlENB1NoNjNYdIsX0b6vE+fRhblVSZ6z+Ims5iW5E9D5AoS
	 rpw1/nvpdqkf3nC5cDmLRTlCZU7gLDmYEdRKoGnDhuP51dT7eL9CgBay3muObANW+t
	 2Cq8e71QQks+RxVLFQCLxv1M0+5di7ZFp9e5iHqtP432Rv1jVJGMEBFK1uoWcPWOBU
	 bdcYKw5BRmE6Yp+l/Z3Y1y01OFDXsbVYpD5/h4gQ+XZ4oRFts0lbgScinbJ08NZFDk
	 T0SLwQij3kjDQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so7724073a12.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 03:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7suvkXHC6knYxVKbdXxvQ5RzJF2GgyIIRduw1eBiRlI6FwKM26S0+T7bBt7DmWsC6qOTpHiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmCI7Gcly/n8HuFDOauzfIZIDZZ/fY6Dq+4o2gFjreqDAZbx5
	4hFlfiKkgpdH+af/Zz+9zdSAStu7qjFCQRu3lV68VZWUT6+a1o1P5fNvfmPg1jVYbBYMgX+vSGH
	//rkg3rMI4GM8jkT2n8Qd4hDSRFUz2ow=
X-Google-Smtp-Source: AGHT+IH0IHP2Hd+YGTBC0Qhq/nb8jOkUl6kH3xIHQ6LHWCfBIRs++7edGlN5ue6wvlu/FikZ3jcA7epgb/rbOqFLt1g=
X-Received: by 2002:a05:6402:440d:b0:640:6512:b9f with SMTP id
 4fb4d7f45d1cf-640770209afmr15867978a12.28.1762257085356; Tue, 04 Nov 2025
 03:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110432-maimed-polio-c7b4@gregkh> <20251104100325.343863-1-pioooooooooip@gmail.com>
In-Reply-To: <20251104100325.343863-1-pioooooooooip@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 4 Nov 2025 20:51:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_9Vf+ZMhuf8ZWvsize3RJ0SvTWGuEsX11jA8r7tvmXmA@mail.gmail.com>
X-Gm-Features: AWmQ_bluLJT4i7opQd1DafXRLcECE3PVPLGdL0KCoJwD9OSNgVttDqFLUVcFVaM
Message-ID: <CAKYAXd_9Vf+ZMhuf8ZWvsize3RJ0SvTWGuEsX11jA8r7tvmXmA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
To: Qianchang Zhao <pioooooooooip@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, Zhitong Liu <liuzhitong1993@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:03=E2=80=AFPM Qianchang Zhao <pioooooooooip@gmail.=
com> wrote:
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
>  fs/smb/server/server.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
> index 7b01c7589..15dd13e76 100644
> --- a/fs/smb/server/server.c
> +++ b/fs/smb/server/server.c
> @@ -246,11 +246,11 @@ static void __handle_ksmbd_work(struct ksmbd_work *=
work,
>                 rc =3D conn->ops->encrypt_resp(work);
>                 if (rc < 0) {
>                         conn->ops->set_rsp_status(work, STATUS_DATA_ERROR=
);
> -                        work->encrypted =3D false;
> -                               if (work->tr_buf) {
> -                                       kvfree(work->tr_buf);
> -                                       work->tr_buf =3D NULL;
> -                                       }
> +                       work->encrypted =3D false;
> +                       if (work->tr_buf) {
> +                               kvfree(work->tr_buf);
> +                               work->tr_buf =3D NULL;
> +                       }
This patch seems to be broken or wrong. Please check the patch again.
Thanks!
>                 }
>         }
>         if (work->sess)
> --
> 2.34.1
>

