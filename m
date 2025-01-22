Return-Path: <stable+bounces-110119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB9A18D55
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203C33A034B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1AF1C3BE5;
	Wed, 22 Jan 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZmtW4yr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41448F7D;
	Wed, 22 Jan 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737533175; cv=none; b=W5U6AlCJtJGRh4U10O3zwlZFsb0thcK7P8QgFRQt/I0sdco9vGiK2+0BhcMRzpldcqkMDMY3eeWNzCWVWUF5zrKTBq2ZDJIpLRMqTkiOssLlvtqLZi4eh5RyHSDivOBmrLVxqpBR5l8N3e6XDTffrFkFXZxPm4HLU38kpYq67kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737533175; c=relaxed/simple;
	bh=vTyHnhvRW9VyumFezYy1LbSefMo0zhGQhJdvbirTvus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NK8WGb1HUYMlJiCm5Cu3YRE/51IRO04DlenONVBc3bIOGdWcxdV7db9mDj7n0+sv4xrEs32pRHTPRl1gIVwnR58UUpe55gy5XMd14yY0obxdE8zOh7U1OpaCd7q7XRWEKVrA+oSgA9cEG/Sx/oARUe3wHY8ZClp1bPiEkUvHuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZmtW4yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D7AC4CEE2;
	Wed, 22 Jan 2025 08:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737533175;
	bh=vTyHnhvRW9VyumFezYy1LbSefMo0zhGQhJdvbirTvus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LZmtW4yrIT3grMzw6LaV1qdt/U5XNyeSaHtjWZpLp8//NfhI5XehbSE2AdPqDVBp9
	 SinxIMlvvsMTn8W0iJgMWPuSlSH5mEAh5RY90ztBt5m7lWJbwQGMptP3VGgpyNyoED
	 pbVsgwu7Zy6nBs6AMGv/1gzgxXoPI7wG+zbh2SWYi0oWrZmQ3N0Pmz4EKiRS6/A8or
	 kkNlgasiKNi5MnReSEWaRJ+FMjpCw4C/ZVS9Qprct5gNrTJNtqxEmgmNyXFdmjlKvr
	 8+/eYZZVMhHdnEGCQB+eSHEHbg4HLakTAN99xJRymlFhnwNAPq1JM7/uQwq5H5kGye
	 muKHfGfCsd2ZA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab651f1dd36so143467966b.0;
        Wed, 22 Jan 2025 00:06:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9hIApu0d0l7KXMy4U6VhUaraZGVzLtKK3NiTACW2N2R/o5AHfOmhPxDYP/KKIX4SWm5Ojo72t@vger.kernel.org, AJvYcCUnnJ8YornN/RQGclGSVuKQC0UsOb2QEGo1nChotZfrlAQMfoZVyNpX787Q7awN66nsqCDQKD7pFmoY7Co=@vger.kernel.org, AJvYcCWxutWvezFfl6xUm7/roL3RrylWlFMFUbtx5FtBHrr7ksau/g4dkGKXQvZ7V9lzgWt32sndiUO/5b7g@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyBc1WSXasc0HRyhoTUwWMczNV3wOhG69zUNR+mywYRV75XP6
	F44jQ3g4CJW4/VcQWUzFKk03vS5856ljgX/FqKYAmqGxCqe93auJivp1EZQHxlTW6hy/F/fiK4W
	sMXyXsWt+Zef7H6W8mCXgMvLmlC0=
X-Google-Smtp-Source: AGHT+IEqdNQPkcdgwV2S6Ycf6gfq3Wp1MlPTEdyAPi1hC9cu7CfF2C7JSmBCsk2tpf3GeVK2Bwf3y92MZ+sTdlpXnK0=
X-Received: by 2002:a17:907:746:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ab38b4aa1c6mr1954220166b.49.1737533174012; Wed, 22 Jan 2025
 00:06:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122025013.37155-1-guoren@kernel.org> <TYCPR01MB11040EA25C858F700C3AC9694D8E12@TYCPR01MB11040.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11040EA25C858F700C3AC9694D8E12@TYCPR01MB11040.jpnprd01.prod.outlook.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 22 Jan 2025 16:06:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQTLHjKa9SJLnh1fpQK-kVC1_pjFD3geiusa-QKzh4FQg@mail.gmail.com>
X-Gm-Features: AbW1kvZkqNU4VV84qLvqjbaXXVaIogoR-XnGOINsng-2aloA7Q-ncoSdLBv6QYk
Message-ID: <CAJF2gTQTLHjKa9SJLnh1fpQK-kVC1_pjFD3geiusa-QKzh4FQg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix compiler warning
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>, "conor@kernel.org" <conor@kernel.org>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Guo Ren <guoren@linux.alibaba.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:59=E2=80=AFPM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hello,
>
> Thank you for the patch!
>
> > From: guoren@kernel.org, Sent: Wednesday, January 22, 2025 11:50 AM
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > drivers/usb/gadget/udc/renesas_usb3.c: In function 'renesas_usb3_probe'=
:
> > drivers/usb/gadget/udc/renesas_usb3.c:2638:73: warning: '%d'
> > directive output may be truncated writing between 1 and 11 bytes into a
> > region of size 6 [-Wformat-truncation=3D]
> > 2638 |   snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i=
);
> >                                     ^~~~~~~~~~~~~~~~~~~~~~~~     ^~   ^
>
> Just a record. Since the maximum number of ep is up to 16, such an overfl=
ow
> will not occur actually. Anyway, fixing this compiler warning is good.
>
> > Fixes: 8292493c22c8 ("riscv: Kconfig.socs: Add ARCH_RENESAS kconfig opt=
ion")
>
> Please use the following Fixes tag:
>
> Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas =
USB3.0 peripheral controller")
Okay

>
> Best regards,
> Yoshihiro Shimoda
>
> > Cc: stable@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> <snip URL>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget=
/udc/renesas_usb3.c
> > index fce5c41d9f29..89b304cf6d03 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -310,7 +310,7 @@ struct renesas_usb3_request {
> >       struct list_head        queue;
> >  };
> >
> > -#define USB3_EP_NAME_SIZE    8
> > +#define USB3_EP_NAME_SIZE    16
> >  struct renesas_usb3_ep {
> >       struct usb_ep ep;
> >       struct renesas_usb3 *usb3;
> > --
> > 2.40.1
> >
>


--=20
Best Regards
 Guo Ren

