Return-Path: <stable+bounces-72753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7240969056
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 01:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15559B20ACA
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 23:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0798E1A4E71;
	Mon,  2 Sep 2024 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTW2Xlfm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58F4CE13
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318979; cv=none; b=rn/42Uw9/ldO5h0Uc4YuqxaPEvvWWPzXyKggJD0CVvB+Uxw2QPufXQvAPk9MiEhbdRc+RcDaJBJ48BZXxPmWFPaRJNMWM5VdwVy14Y3vp8DbVCsh6wvnGw4lFLAHP3R8d441ql8LAI+o4rs4EFYG30gBAYzRiInAg0MAmijCYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318979; c=relaxed/simple;
	bh=Ej0QxayqmDqh+wOpxhn6PZ7Ekd6SK7fVmjZK7b/LTh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiaGW8t9N8hMOT8OkugikP5FLt4x9KgiTYhpmSAl8SjLAULZO6bgSAcnGYH29XrdXdDhP21Z+oS6FdOTjzoZO/rTItsQt0Bit0kXP5+zmcg43i+uptB9BCRidsmcQwmolESnrqEJDpb2RSE7emPO1/taKzpUhOp0cqWNr9FaTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTW2Xlfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630A8C4CEC9
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 23:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725318979;
	bh=Ej0QxayqmDqh+wOpxhn6PZ7Ekd6SK7fVmjZK7b/LTh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LTW2XlfmLF1ioGde4BsCDN0IhOlKhZyC4ys/J/mC2HvjfI+D7/17gwGXcP8HaNdmz
	 TqwYM0DdYC8al+NCgJRUdgnEM3Of+HQyu3Ojg11X+3mXmWfBCMpqDQffQiHV7NWZ5n
	 LerQePfFo/SKWmyzAiqT/LoeVMvsYCdUb6RnoXsZLW9P7YSjmLCUzMEjpmgGCD5N2k
	 De0SRcFP+YuIxcNSu0lLH4sV7quVXkbIM+Z3y8REWXGkHYc7Mn6Y3sWRBiHDlGAjcI
	 vHIVSw+2g6m+PSfYbf/DZmVbdbUktpLW/iFiX9un3Tw61Q0LzfTDM3DUPEtJzb84Vx
	 sdjuyENRl0Wkg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5da686531d3so3162650eaf.3
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 16:16:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGE8vFOfNde/C5Pv2kqBa2zLsTpx28MR2IqtxIafKOAS0Pnrd8
	g3XpM+QIAG1yYCMMAY+rgNLpI+VtZ6EGm9lXs5yxvx/wh4hwK1esgkbGrwi/xL1+xh57sKrCXHI
	onPDp+7wcXAxbDxywijGeQtfHWxk=
X-Google-Smtp-Source: AGHT+IHZFLXQHfwF/+H01XPI7DZ1neDBClcyw6vG784FclEFN5UP5Vrolv7pexrAYKz2gd97A67gGOi+aBZMpKD7yDE=
X-Received: by 2002:a05:6871:4e48:b0:25e:368:b5a4 with SMTP id
 586e51a60fabf-277d03b127amr10124293fac.18.1725318978733; Mon, 02 Sep 2024
 16:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160823.230213148@linuxfoundation.org> <20240901160830.426516431@linuxfoundation.org>
In-Reply-To: <20240901160830.426516431@linuxfoundation.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Sep 2024 08:16:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_UvscfaXpnoJNv2GEeDU0sUfg3_=gG7VX7My60EzXgfA@mail.gmail.com>
Message-ID: <CAKYAXd_UvscfaXpnoJNv2GEeDU0sUfg3_=gG7VX7My60EzXgfA@mail.gmail.com>
Subject: Re: [PATCH 5.15 187/215] ksmbd: the buffer of smb2 query dir response
 has at least 1 byte
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Steve French <stfrench@microsoft.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 2:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
Hi Greg,
> 5.15-stable review patch.  If anyone has any objections, please let me kn=
ow.
Please drop this patch.
I told you this patch was required for 6.1 kernel versions or later in
previous mail.

Thanks!
>
> ------------------
>
> From: Namjae Jeon <linkinjeon@kernel.org>
>
> [ Upstream commit ce61b605a00502c59311d0a4b1f58d62b48272d0 ]
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
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ksmbd/smb2pdu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 57f59172d8212..3458f2ae5cee4 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -4160,7 +4160,8 @@ int smb2_query_dir(struct ksmbd_work *work)
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
> --
> 2.43.0
>
>
>

