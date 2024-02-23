Return-Path: <stable+bounces-23536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB4861E83
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F078B22C5B
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 21:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D87148312;
	Fri, 23 Feb 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CpbZ+1ON"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC51448F3
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722451; cv=none; b=XE+03VvwY/0RdcdAbYdJXX54QbG5OKgPZsKKL7g0aWmlgrKZkr2gsk4OVIzHiSIb869VjIGajbePmIA+baErbA0F3xBQlmC2DLqqtXprf+mZJ1B1nMdQbt62XIOt+Zx5xHLLIkgcXfGJGO65ub4qC2yy0biAzdfW15zGVQSVJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722451; c=relaxed/simple;
	bh=6VgQr8fJjg6fEs6AHFjmsFnIQHc5a5uEmdWg5mQPymA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUeXshgEz2gH/Y+hYwK961dCFLE8rnSlGre8QG9kFEz/dyq9paM1onvXf+mDQ+ehHxgn05HLwt2MwM5PnKJ8Xt86mi7WltmCWesOZvN0yuH8N5qcAS0zSMh043MzjPekOATz7IydI17s4fcygn/4EhDalsm7uN2vlSMcKo7ifdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CpbZ+1ON; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6087396e405so6931767b3.0
        for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708722449; x=1709327249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTVIr1+DQqd7VndTuddH8HDUIEhAoCQ0AKItibRMycI=;
        b=CpbZ+1ONoL4hAF2MgBVMj9+mDIUgqyyn2Rm0f6MXSEW7qL6SCnfVpPtW/MwXPpa3NG
         kZWWX7CumzKC5qLo4sP3uyGIa7FtcWmhi7C0HxIaKTCwUAM5DeFmd5hgrOWCefMeeCHU
         gC60pChbSpNcR42yqtujInW2HBd8I2l9aTLH5jDZxYaU9hIpZhsb1se8Du8BoKhZfeuN
         djJuvHVC7vEc7XuVFqFbUKmMPtEWcoGWkkNg519RijfyNs8orSCX8XnAoaRBCBNHHzDq
         bfvuirSyKlz3isF1tLaVmflxPZa4PfKELAvanWuHsnD3HJoIRe4GKWCJ3tWFCjARswO8
         Tfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722449; x=1709327249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTVIr1+DQqd7VndTuddH8HDUIEhAoCQ0AKItibRMycI=;
        b=Hm7yrmyXBAKFUZmQYFjhVTnE9LrQtieVXIlMHFEL1U1s3lmGnSqK9EfY7InQpXTIF8
         Sl2H+QaoU1dJGt++25O2rlk3XH76TE2+j0KSW1uIcNJK6JdzsJ28375AtF/6YPXXoULN
         wISp65u7voWTxJDdQxPLnqkKa+PGS6JEyPGn33IHHrJD7rLErKspJK243Hiw40m53JJf
         q3ho4DNb6ePikM6cD+GUU+wJ9ZFLcRoHiDuHGshxpwbVB5wYFHI1pKJ5BRqi+s4eSh3S
         hM8b1Hq/azy+cerTdXUK1EziYWt7DE66z8w3ziI/dMEkcW3CeWcdSyyGlMJZtQqe4ZDu
         pbNA==
X-Forwarded-Encrypted: i=1; AJvYcCWeZw2r/h/vNSxAiNSpzPc5xNvvMhIm5KZKq3GVYUfSKqcRrLFUTZr7c9rEOSbBJSfVBvIQoUV/TCYSz3YK9ytFjF+2lW5U
X-Gm-Message-State: AOJu0YwOaLO2U9mW5HES0Tcgwpo3Xf0C92yIgqhKHcZOekcv3WclyRLO
	E8/wyRuMe5vVsbfvdlSys3klNsUVinSMZYWJv7HNLK2b5vQc+RLyyx+XwNVviqfQDvWc/VXVkFn
	fxCYxGyAFeUk97CKpnLaEnf9DpJZDgbV6HwCe
X-Google-Smtp-Source: AGHT+IFzOTG2gqhjwIuQqFrSF9kYO7XKdQQqylj7QZT68fEwlWe6kyHm8630oV+XgrXsN2qoMyNAn4/rC/VdW5ppCKY=
X-Received: by 2002:a25:b215:0:b0:dcc:97c:5754 with SMTP id
 i21-20020a25b215000000b00dcc097c5754mr892475ybj.5.1708722449224; Fri, 23 Feb
 2024 13:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
In-Reply-To: <20240223190546.3329966-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 16:07:18 -0500
Message-ID: <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> aa_getprocattr() may not initialize the value's pointer in some case.
> As for proc_pid_attr_read(), initialize this pointer to NULL in
> apparmor_getselfattr() to avoid an UAF in the kfree() call.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/apparmor/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If you like John, I can send this up to Linus with the related SELinux
fix, I would just need an ACK from you.

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 98e1150bee9d..9a3dcaafb5b1 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -784,7 +784,7 @@ static int apparmor_getselfattr(unsigned int attr, st=
ruct lsm_ctx __user *lx,
>         int error =3D -ENOENT;
>         struct aa_task_ctx *ctx =3D task_ctx(current);
>         struct aa_label *label =3D NULL;
> -       char *value;
> +       char *value =3D NULL;
>
>         switch (attr) {
>         case LSM_ATTR_CURRENT:
> --
> 2.43.0

--=20
paul-moore.com

