Return-Path: <stable+bounces-3700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87489801B60
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 09:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DB3B20E6A
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8CAC2E3;
	Sat,  2 Dec 2023 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATS7Ny6Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3714194
	for <stable@vger.kernel.org>; Sat,  2 Dec 2023 00:05:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3333131e08dso1174508f8f.2
        for <stable@vger.kernel.org>; Sat, 02 Dec 2023 00:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701504347; x=1702109147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HowLc+47UdqlWMWSoXJ6gBUgIqLLfc3nLVORZni1zlo=;
        b=ATS7Ny6YdH/0m7a0dAauq5v04T40sjsEQyHH3qzjSU1Whe6wvxc/QNuNrdo9g6P+Z2
         AsgAJdK0EijYSWfDez57XkSL+AvAT8Q45lxPcPa5HdYrePoXLALsPoxe3Lv9KcbXloqF
         t3//VFQC+vePcebP1DvJEx4ymgnXFYO+yEm7MgHtLiRAo7q9BLzOeWtgwom07DgvWtG5
         FnEPDrhRQOsroAXDaWfohgf2b9+B+FuqFRNOI9Sg03tPybXAKF5be/nhgQypkeokMm1m
         2WRG6WUT7wXmjqdGq8AkxjoZzmo31FxjtCYHiTcMxqcaXL6nHsNawnrMp9mG5uvXdsiJ
         5tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701504347; x=1702109147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HowLc+47UdqlWMWSoXJ6gBUgIqLLfc3nLVORZni1zlo=;
        b=PPjrArZSSR4wdZDFTsASH53wclYydj+MMMuVqn1Q1WOst9V350ispu0xh+2bwlNwAT
         ArqIklo4gAhV7n4dOKaec2vVIq3rCS7b381+wm5Rmwfm/HgWd6RUAwupAcT8IiflMmPF
         dRnu4AT8i8nQQ0aIgNT/58an8NaXSp7qlhvcc4mOMMFEGBgmLwA9wfI4kZoIu0aqBjok
         ySOoV2hcxw9Gex2jyXJMgBhAaX32ep3dpSPRY7H4o8UEAUdMT2eWcZPRaDD1vA+DDzUe
         UrSpV5s8lSI1SbN0XA/ZzV1qvyYmU/z//+N48cwImVRZkWSFoUf29BR3oBRYOCVRpNK2
         ciyQ==
X-Gm-Message-State: AOJu0YytpqgBARjC9HIY/Vy7l4atksc595s5DyL6QJL4SgbYY3FJjV2R
	vy4wTxFkMB/1WOO43j/IP0h8tEYGsdfHFASqwSgbSwz/
X-Google-Smtp-Source: AGHT+IG891iuue6NLYV8f/dmJsGOwxE/bIlKL6vFrhALYMRgd1E+XxGLpvQRHTSBR1YPpervEAF4Kzdky8slB3dCD8c=
X-Received: by 2002:adf:e5d1:0:b0:333:2fd2:2ecf with SMTP id
 a17-20020adfe5d1000000b003332fd22ecfmr1452452wrn.72.1701504346986; Sat, 02
 Dec 2023 00:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023112431-matching-imperfect-1b76@gregkh> <20231202065616.710903-1-debug.penguin32@gmail.com>
 <2023120231-poker-napped-be47@gregkh>
In-Reply-To: <2023120231-poker-napped-be47@gregkh>
From: Ronald Monthero <debug.penguin32@gmail.com>
Date: Sat, 2 Dec 2023 18:05:35 +1000
Message-ID: <CALk6Uxp5K=XWAEyfBg3Cu=60Me9KOJSn4hFgbAkRiTXVkNE-oA@mail.gmail.com>
Subject: Re: [PATCH] rcu: Avoid tracing a few functions executed in stop machine
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg ack sorry missed that block, will update and send it now. thanks
BR,
ronald

On Sat, Dec 2, 2023 at 5:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Sat, Dec 02, 2023 at 04:56:16PM +1000, Ronald Monthero wrote:
> >
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
>
> You lost the signed-off-by and didn't cc: everyone on the original
> commit, how come?
>
> thanks,
>
> greg k-h

