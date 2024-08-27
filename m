Return-Path: <stable+bounces-70290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD7295FF60
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 04:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08727283106
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3852F22;
	Tue, 27 Aug 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKsCMSgS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C055168BE
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727309; cv=none; b=mpC2WLTrkZCOKuwtAqU0+XS4SHW3KGZvRAVsyW1UHLPQN9vfdxRGmI36eFhRNzgr5RATcEF6R74EdikFMhE+ffaExptHzMPJx7iu2XCI5ELfPoJOv+nioSNkBvoI7GmgEATRnCLI246DBlxERvbfHF9YpBNEIf0SgkVGFLRhE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727309; c=relaxed/simple;
	bh=vUgfHd1dvds89VfN1GxF+1kRQuhkZ1vIrsgOkHWW2xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajIyLVVHLF2S3kNRrUWAz7nLDDKrltKXMSgBX+ZDqmhAlyL5Gw0MgAw3nudNvvkFvB3Yfp5ERmmVBdEXDHnReEzR0qfH4Xx9yd2iErZNYBazpHNr7EzF4Be4/idhxLjYs56KzT48BxeXwNfVGihM6bx5vzgUV2U6Mfh5LEpSiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKsCMSgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8455EC4DE0D
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727308;
	bh=vUgfHd1dvds89VfN1GxF+1kRQuhkZ1vIrsgOkHWW2xE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MKsCMSgSNa2bEo7izNXB2AJ3RPMYITjjNLPIZRU0sPZKMR4SW0u+v1vAmERLh8Nrx
	 /8u8YUtXXDaggvB70vs+xCD8116GmMa7woIQEq7L8phn2++6vVJxTrNbzWKK1xPptf
	 bGL4s/Je6TqBGgNeeQ2cCTriHOAPVKA9vddBMjSsaUFaRlSqeC3tuKLSdQBvbde8SZ
	 Z836PYYtmEWJ8/h0BTCouk6gV3fah8/0VqphqtWkhIA58f7gNiPkJQQIDKkZEpDH2s
	 Mb0yySXrRxJYGHK8eCA2vnf+IX8d7PqMWFp+EjiP2xW4O4ElnkQyheLyZ4KmNrAQHQ
	 JXgfLm89v+AqQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27018df4ff3so3924524fac.1
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 19:55:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQ3kb0anmIkq5+k5iKK1x9MgNlINFSFcymvXYQNRztxf8x8yUnayNpUNkdAnGfpSmbC2axWDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJRufgV/7s8uxCzEUJHsJY/y6/XlQmwgz6DBj7s6+mLkWyPl0
	i+5+JTJzmMcr50liZVpNGb3CV4Mu3xiRedqenWLUmC6RZ3KiX0/4M59RU3pZpT1J9pLJyQNSZ4e
	KS0ervNIJyLaHJVh7ITnTLvqpMzI=
X-Google-Smtp-Source: AGHT+IEQwacPoXZtK048iEKXUWwDTg5DtAJscsxXUQ/jtBwMhdcul5YPvLj/saPNIUKlS+/knUD0DUrFx74oCC117j0=
X-Received: by 2002:a05:6870:b50f:b0:254:affe:5a05 with SMTP id
 586e51a60fabf-273e64d961fmr13819396fac.21.1724727307838; Mon, 26 Aug 2024
 19:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024082604-depose-iphone-7d55@gregkh>
In-Reply-To: <2024082604-depose-iphone-7d55@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 27 Aug 2024 11:54:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_KPR0FAsx+6DrEfU3J-ahnMtfA64gqyxHCOMHS3ZZejA@mail.gmail.com>
Message-ID: <CAKYAXd_KPR0FAsx+6DrEfU3J-ahnMtfA64gqyxHCOMHS3ZZejA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ksmbd: the buffer of smb2 query dir
 response has at least 1" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:38=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
As follows, I have marked stable tag(v6.1+) in patch to apply to 6.1
kernel versions or later.

 Cc: stable@vger.kernel.org # v6.1+

This patch does not need to be applied to 5.15 or 5.10.

Thanks!
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x ce61b605a00502c59311d0a4b1f58d62b48272d0
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082604-=
depose-iphone-7d55@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>
> Possible dependencies:
>
> ce61b605a005 ("ksmbd: the buffer of smb2 query dir response has at least =
1 byte")
> e2b76ab8b5c9 ("ksmbd: add support for read compound")
> e202a1e8634b ("ksmbd: no response from compound read")
> 7b7d709ef7cf ("ksmbd: add missing compound request handing in some comman=
ds")
> 81a94b27847f ("ksmbd: use kvzalloc instead of kvmalloc")
> 38c8a9a52082 ("smb: move client and server files to common directory fs/s=
mb")
> 30210947a343 ("ksmbd: fix racy issue under cocurrent smb2 tree disconnect=
")
> abcc506a9a71 ("ksmbd: fix racy issue from smb2 close and logoff with mult=
ichannel")
> ea174a918939 ("ksmbd: destroy expired sessions")
> f5c779b7ddbd ("ksmbd: fix racy issue from session setup and logoff")
> 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
> 34e8ccf9ce24 ("ksmbd: set NegotiateContextCount once instead of every inc=
")
> 42bc6793e452 ("Merge tag 'pull-lock_rename_child' of git://git.kernel.org=
/pub/scm/linux/kernel/git/viro/vfs into ksmbd-for-next")
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From ce61b605a00502c59311d0a4b1f58d62b48272d0 Mon Sep 17 00:00:00 2001
> From: Namjae Jeon <linkinjeon@kernel.org>
> Date: Tue, 20 Aug 2024 22:07:38 +0900
> Subject: [PATCH] ksmbd: the buffer of smb2 query dir response has at leas=
t 1
>  byte
>
> When STATUS_NO_MORE_FILES status is set to smb2 query dir response,
> ->StructureSize is set to 9, which mean buffer has 1 byte.
> This issue occurs because ->Buffer[1] in smb2_query_directory_rsp to
> flex-array.
>
> Fixes: eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with flex-ar=
rays")
> Cc: stable@vger.kernel.org # v6.1+
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
>
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index 0bc9edf22ba4..e9204180919e 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -4409,7 +4409,8 @@ int smb2_query_dir(struct ksmbd_work *work)
>                 rsp->OutputBufferLength =3D cpu_to_le32(0);
>                 rsp->Buffer[0] =3D 0;
>                 rc =3D ksmbd_iov_pin_rsp(work, (void *)rsp,
> -                                      sizeof(struct smb2_query_directory=
_rsp));
> +                                      offsetof(struct smb2_query_directo=
ry_rsp, Buffer)
> +                                      + 1);
>                 if (rc)
>                         goto err_out;
>         } else {
>

