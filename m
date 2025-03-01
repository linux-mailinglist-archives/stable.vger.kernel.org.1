Return-Path: <stable+bounces-120010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA61A4ACDE
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 17:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5804A18972FD
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E611E51F1;
	Sat,  1 Mar 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kggXazpR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A41487D1;
	Sat,  1 Mar 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846583; cv=none; b=p+7StccTfnN4pVvqoe226mBylmu5t6y8mSRdXC4toAqTxDvFgbIQ7aYMOFsZ+wTeQA8WDWwjjp4XZLMjntyrVgb/MdOf+rUSBwd4Mq32tacg8i7w0irCxRaTqNTRpbIkTSnoQi0gRXXUk2MlnHv29PlzPaytN6znKuTC/Nn4AIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846583; c=relaxed/simple;
	bh=HHShl6fmzO4CDNXm56EjpFDU0XBN5j6Jo9fKXnk6j54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z73Xc75kDcTqsu0otbWUxgxYdpLZ9rsHVxQDnPkhgoFtUgfaRbyZ0g9ksxmzgKAYY/BkgABMlN6Z0peSR9GJDGuDCFmdtIyGPiaBamP1tMKywREjOHibM6Xbm64aAoNXT8IKiKLwgG8DHmD5z7HNkkJvaiZLsBSGFvpdi4A+QxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kggXazpR; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2adc2b6837eso817234fac.1;
        Sat, 01 Mar 2025 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740846580; x=1741451380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZEUaQpxNWQ0VLyb0pFtWCnEhCo7qZid/hN1L1j+FZ4=;
        b=kggXazpRY55j5+/mlLOS0/ng99wfrPqrkUETshG9RT7kVru2Kk2KYyGLyCT7hNNmmU
         nSrj74++Kwfo8kxEo7NEKZRPO/HeVTWpYAtpOLE+NzHGK65reSNe1y+/+UGTjszx/+4+
         RKjHb8mwgBhvw7h5qaXoJIBcWPFRZyHnPwYjnjTAZncbTciQjIjEAbvingJzCRR9u2io
         2Ky7MxLM0DggVZHRtVRmY6RILQLqGNZco3L8wCmmhbdMrIuKVeERLXfTkstBWdv3j0JM
         a+5f7J2bJbnP1z3KXzDRMYyNmnNhKiG3b0udyePWmbcpLU2bMuU7bGfKpSvKW6LyEyUD
         RRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740846580; x=1741451380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZEUaQpxNWQ0VLyb0pFtWCnEhCo7qZid/hN1L1j+FZ4=;
        b=Bcuj1gDQhHRSQWHQztaAqJ+YLl2XU2WywuH0CULfqHktO/RdUwgpFUykCmvK0E4MIX
         AivpTmh+5IDLvuAVM4JO8GOV6GF7jMCLog6JN4gaBsJT1PdPOf0B4DoN9YlpXvs49QaH
         i/kOuOMu7uTPzZ1skRuqpwftXm+vb266oxL88tsWuPc+9b1vffK1DnBEaMemNSRBrb2W
         i8PPb6QoRRbkoe/+Qw8GMqJCUHJYSTAO5ai8lA5wS8Uf5GsdTVHKsoXLbx7UPp+aCo6S
         CvJEtopMASVdvDXWa0SdU3M+9b0rXSjLN8Yr9KZ47Zfo4GG9dJpuzLQsFB6QgRiJwe/c
         DySw==
X-Forwarded-Encrypted: i=1; AJvYcCUpK/RojR/vAES9ym5f+1cEWXwhQxcIX1iglSJZuNMu+a0d6pisw+NNMwzsvhZUgTXUWgi5BQz0M47iYD4=@vger.kernel.org, AJvYcCWLkamKU6bN9qDgnLIhV+WR2JXBYsIB9kq8eoY4Fz3P2Vh0wYpAuViO6MRto3u0DfxduOhF0A4r@vger.kernel.org, AJvYcCXjcf91jZc+/Q95tx/vmXwuo2sdeBWcGk4M7ZHHKda1mBCQsO5+kpHTyiC9/kJCVmLhcjGN1sRYD69rZJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVp6b6LjkRHTNYT3Y4cW7KrRmXr6MFpPH26Dsgxeqnk9njQ02S
	AN76yWMrxo19cUDnWSNHHz/2jUHHJzm9eTL84Hrw/YVGP+v1xhCl2tMuSUDYFQ3fiHGUI7lS8To
	WJWbftV8URdgqHg2wf+mUZA8oYFo=
X-Gm-Gg: ASbGnctjwGqzEErg3sFvB6M1kGPrNf7vffz9RVpeo5JSXkedI/KmXWTV2xlbkRXgrkP
	fATdFouMXnFyBi7QPTnbRYjWudIaaI9tyVSi7tOBfCn9d/2JeB8hV1UNVOvmEQWImYNnsS1Kave
	Cv5BYnJsL/jsiuNx6lCJ1JtnahK9k=
X-Google-Smtp-Source: AGHT+IFLHW43DGVnGXOFanwomRC74l4qNdWZrjLIPoHIxamo09AWIXLwMxZA6XLplMHBHwCIOVz4tMkmC7T/9yOmmsg=
X-Received: by 2002:a05:6870:82a6:b0:29d:c964:f035 with SMTP id
 586e51a60fabf-2c1787bbdb7mr4893395fac.35.1740846580586; Sat, 01 Mar 2025
 08:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219022753.2589753-1-haoxiang_li2024@163.com>
In-Reply-To: <20250219022753.2589753-1-haoxiang_li2024@163.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 1 Mar 2025 10:29:29 -0600
X-Gm-Features: AQ5f1JoEz6qNtlf8qYTx1DcstTc7Vho0S-m-HrMV1VKqR5yyS7jhPr7ifohbSwo
Message-ID: <CABb+yY3wC5Rp4DJFL=61uyYyGtJ-kPTWks8JMG7jQpp=V3P-Zg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: tegra-hsp: Add check for devm_kstrdup_const()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, brgl@bgdev.pl, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:28=E2=80=AFPM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> Add check for the return value of devm_kstrdup_const() in
> tegra_hsp_doorbell_create() to catch potential exception.
>
> Fixes: a54d03ed01b4 ("mailbox: tegra-hsp: use devm_kstrdup_const()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/mailbox/tegra-hsp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index c1981f091bd1..773a1cf6d93d 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -285,6 +285,8 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, cons=
t char *name,
>         db->channel.hsp =3D hsp;
>
>         db->name =3D devm_kstrdup_const(hsp->dev, name, GFP_KERNEL);
> +       if (!db->name)
> +               return ERR_PTR(-ENOMEM);

 tegra_hsp_doorbell.name seems unused, so maybe just get rid of it...  Thie=
rry ?

Thnx

