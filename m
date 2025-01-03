Return-Path: <stable+bounces-106672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6514A0028B
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 02:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484F3162E6A
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E714901B;
	Fri,  3 Jan 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b6USI4n8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444FA93D
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869189; cv=none; b=GIBShByOUxBDgY6/AwNnqJLzAXI2eyjnzyf3UR4XlWxgOsvSraU67jE0Ftg9ohAjIAZvRE9P4wOX2TKBBmMWTFEvV86sW3fq/Wvg70ZskrBRlFaI6FxChzIj7IJHuZjmRjya2iInPNatFhDYTL4uVWIxxI4lqvk8PIcZuTlYhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869189; c=relaxed/simple;
	bh=OFNvUjI3EtOYEnDMllvwVmm5oJwGKc+la90CkN22/8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKmSZJQUgMNJPV2nr72vOcrRqzOgNNzPv9LQQr++dsr5AneX9mpeyt0zTGpZcPWyiHQkB8vy/gItIc3SvHu9JsvycIhEuHiHlmulwOkydydwAKlVVb5MZ1+qE3T6Ge+qT2yiJuviHdtXQRYtPE2ppS4/8FBJtetSIKYURoRBWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b6USI4n8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e399e904940so13580794276.2
        for <stable@vger.kernel.org>; Thu, 02 Jan 2025 17:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1735869185; x=1736473985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKP73UFQch/IkR4S5eIFu+FFl9BnuZCrjgs+nueA+FM=;
        b=b6USI4n8Q4uZ6Ox+7yZT4hRexhwFuoIXCjhm+5Re3sMCqezSty9sRDZzPEkhDBVlLa
         78XXVpqt+6DiQ+TE7miYJFbqlII3cb3JZijqPcugQH3eT6bIScsXTqAGBS2g9+LD8WIz
         npSJmlVtP61tgzntloL7F40k/zqDhBAlRs4Feyr/2YayMROyeFlna49BD/6nk/i6J+oj
         HZwsjOE+UiYrwF/qcqGg4+U5ZhkgAE526nGLoz4zKh29Ytl95u9u7v19J9V1XjBU+3SD
         i/yPdtpTBhZWGfYOoQJGJT46Mbz/dox9Nrh73SrVhVrVxEGYs4+AAtYCXgdvJO6op9MS
         0fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869185; x=1736473985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKP73UFQch/IkR4S5eIFu+FFl9BnuZCrjgs+nueA+FM=;
        b=bh7/hoysCDEaTrD/mgU//ElYsMMJVaQ3EZ9fbLMbHAsNGqDYM6rjVtryuucO0rcgZA
         3X5L9AsboQhDIL4lLZtfKhQlmKqzvPBSOqKgh+Kfz0HxDSbs0IqpMftJ+KjkTONlKS/G
         ZjiRZ/9VImmicoeQzCujx5M4pSmSa4HMHHAXfhpzPr4jvogv6qIdWrvUlM7WROC7EDsA
         GbwFnNbzstHzbAkuGvy8fjKW2IVnOOcB4wAg+NnGhdZokoS5CIApkds9Za2hpiCg9NBS
         URTPSav2+YMkXxTgwzrCDyRNyrP3qaE1VInIPrZLzvG1RXXvpCntCJkYWHr+aJH/MkMK
         oqDQ==
X-Gm-Message-State: AOJu0YzKqmtFC48Lc6LjNWOvLy+PQcmeDGNGgkHiem+UZ5tCmZIV2Sgq
	w5PQXcszcp7huvHicJufg6gGuTwKWmlH95r7Emoch7uCJX4emJ7Ew7a8H7OrSzPgV9YVQbLs2jX
	koDYreJRuQWo5jW81hPkn0Rve/6C0LomFMLT4oUMbrL+yDxU=
X-Gm-Gg: ASbGncvlYQS1C2n/wqn7HgNaO/OjABKsrMCbRRO0e26ojbe0nD8g1pXJ2I9hmdyfK3v
	NEvrY4ZomckkI1GN0GLX5/79CaY/3CmwQkFjE
X-Google-Smtp-Source: AGHT+IFW0ReMuhu6VEYI5B6z4gkZEhxfZ98cnnR3ONrtMrjCPnkjn/ebYcqaJdNsu4CnozNOSnaR58BNPU6SXQ1n0pU=
X-Received: by 2002:a05:690c:6f92:b0:6db:c847:c8c5 with SMTP id
 00721157ae682-6f3f812540bmr363890747b3.16.1735869185249; Thu, 02 Jan 2025
 17:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024122319-risk-starlit-ce4a@gregkh> <20250101234903.1565129-1-tweek@google.com>
In-Reply-To: <20250101234903.1565129-1-tweek@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jan 2025 20:52:54 -0500
Message-ID: <CAHC9VhTnrgnFKF8=mMFuEd2tR=V-bMhMNEc5CakktnGRnKkGMg@mail.gmail.com>
Subject: Re: [PATCH stable 5.4 -> 6.12] selinux: ignore unknown extended permissions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 6:49=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> commit 900f83cf376bdaf798b6f5dcb2eae0c822e908b6 upstream.
>
> When evaluating extended permissions, ignore unknown permissions instead
> of calling BUG(). This commit ensures that future permissions can be
> added without interfering with older kernels.
>
> Cc: stable@vger.kernel.org
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> (cherry picked from commit 900f83cf376bdaf798b6f5dcb2eae0c822e908b6)
> ---
>  security/selinux/ss/services.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

The backport looks good to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index a9830fbfc5c6..88850405ded9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -955,7 +955,10 @@ void services_compute_xperms_decision(struct extende=
d_perms_decision *xpermd,
>                                         xpermd->driver))
>                         return;
>         } else {
> -               BUG();
> +               pr_warn_once(
> +                       "SELinux: unknown extended permission (%u) will b=
e ignored\n",
> +                       node->datum.u.xperms->specified);
> +               return;
>         }
>
>         if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
> @@ -992,7 +995,8 @@ void services_compute_xperms_decision(struct extended=
_perms_decision *xpermd,
>                                         node->datum.u.xperms->perms.p[i];
>                 }
>         } else {
> -               BUG();
> +               pr_warn_once("SELinux: unknown specified key (%u)\n",
> +                            node->key.specified);
>         }
>  }
>
> --
> 2.47.1.613.gc27f4b7a9f-goog

--=20
paul-moore.com

