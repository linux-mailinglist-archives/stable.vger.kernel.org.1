Return-Path: <stable+bounces-6606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7FA81151A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DE41C21180
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D24D2EAF2;
	Wed, 13 Dec 2023 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFUcndD6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19221BF9;
	Wed, 13 Dec 2023 06:44:10 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-dbcde128abeso44835276.0;
        Wed, 13 Dec 2023 06:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702478647; x=1703083447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA9AYgq+Q6lLyujeVI1ujBo0nRXSJrVBxDPsrp2S+R4=;
        b=XFUcndD633xVr3zIfrRp6M1noCcLqPTRQg4nHl1LjFrRj4TJy8wIyu3WEhCoBrCUw6
         1F6pcj+WwG4O6sfBb41ymn0U/5JMOAfUj/OSQIpgzxDpKSYJ9EzmTKsShEUYHTnak9Ee
         m9Ft173+8vPX3mLWJIV1PbKTillX7RiJLV1cxCU3xB3Vdw/XFSePzMNuMiHPlRdwHnCv
         3NOCxJHJpJQ1qR5lIOaqwN+MxZM83Qi0lIuPRgPsLrLgkhW+2VWfDBspq/uCA65jbGZx
         V3m64X/KCN+2l/3mHfcm1c2JLfKEavbORnBVXrPY+Li+XQSVw0rNxoLLiJia9XzelISJ
         0lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478647; x=1703083447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nA9AYgq+Q6lLyujeVI1ujBo0nRXSJrVBxDPsrp2S+R4=;
        b=perrq45UVy7PPKOBXnu7pwmV3NuB/H2Txo3bpps+SD6lXX6yjlfBLxrTfOV/4axXFg
         9Qbk4ORELSSp3jKM2oIoL0F5Q6aU9jUnIJ3/nS7yjM2NNWT3pp/yK+B4h9y0e0vZO18q
         Uu/4c2EVWOgkH/3doEbvWBdQ6KpgVaxmA+/p187EGvKLcWWW2nqDtNLDV8qaeVHqKqT0
         U1o+BJQx2TjsvaJf+tI+9yYcf8V96dRv+PJxznncnzRZKbJgfLwJ/eV06W4PXuONeunW
         knCUDZ1K3S4A1nzFwxLQzR5S8T5AYmh09mOLF/cgW9Ao6Ej5Ur75y+FKkzje5OVk8uQl
         maYw==
X-Gm-Message-State: AOJu0YyShoz20imV4DARy2zYkHAmGair/2kkxURCJy+1q304fbGYua/Z
	IG0DzJ5OFVlOVV7TnSwwpPBSXGmJr+DomXd+nfw=
X-Google-Smtp-Source: AGHT+IEuu9eTC37h0uGuH3d+sHC+1yl29aTiQxb2OyOfh7A8H4bhb370iJVrewUB70HeP25ONnpIil5Z4wLYPKFVIvA=
X-Received: by 2002:a25:f202:0:b0:dbc:cd3a:aded with SMTP id
 i2-20020a25f202000000b00dbccd3aadedmr777115ybe.11.1702478647466; Wed, 13 Dec
 2023 06:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130191050.3165862-2-hugo@hugovil.com> <202312061443.Cknef7Uq-lkp@intel.com>
 <20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com> <CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com>
 <20231212150302.a9ec5d085a4ba65e89ca41af@hugovil.com>
In-Reply-To: <20231212150302.a9ec5d085a4ba65e89ca41af@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Dec 2023 16:43:31 +0200
Message-ID: <CAHp75Vciqaphicuhs8HY3vmfLaLgHR55ebJbOXR3mw7X+HupSg@mail.gmail.com>
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in sc16is7xx_regmap_name()
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	hvilleneuve@dimonoff.com, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:03=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
> On Thu, 7 Dec 2023 20:24:45 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Dec 7, 2023 at 7:52=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.co=
m> wrote:

...

> > While at it, can you look at the following items to improve?
> > - sc16is7xx_alloc_line() can be updated to use IDA framework
> > - move return xxx; to the default cases in a few functions
> > - if (div > 0xffff) { --> if (div >=3D BIT(16)) { as it better shows wh=
y
> > the limit is that (we have only 16 bits for the divider)
> > - do {} while (0) in the sc16is7xx_port_irq, WTH?!
> > - while (1) { -- do { } while (keep_polling); in sc16is7xx_irq()
> > - use in_range() in sc16is7xx_setup_mctrl_ports() ? (maybe not, dunno)
> > - for (i--; i >=3D 0; i--) { --> while (i--) {
> > - use spi_get_device_match_data() and i2c_get_match_data()
> > - 15000000 --> 15 * HZ_PER_MHZ ?
> > - dropping MODULE_ALIAS (and fix the ID tables, _if_ needed)
> > - split the code to the core / main + SPI + I2C glue drivers
> >
> > * These just come on the first glance at the code, perhaps there is
> > more room to improve.
>
> Hi Andy,
> just to let you know that I have implemented almost all of the fixes /
> improvements. I will submit them once V2 of this current series
> lands in Greg's next tree.

Hooray!

> However, for sc16is7xx_alloc_line(), I looked at using the IDA framework
> but it doesn't seem possible because there is no IDA function
> to search if a bit is set, which is a needed functionality.

It can be done via trying to get it, but probably it's uglier than
current behaviour. Okay, let's leave it as is for now.

--=20
With Best Regards,
Andy Shevchenko

