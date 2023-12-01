Return-Path: <stable+bounces-3658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1F5800D8C
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC141C2102A
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53C3D975;
	Fri,  1 Dec 2023 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ix7sSaRT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA341700
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 06:43:07 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0BA3440331
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701441786;
	bh=MeHPQXItxGwzbv6QpJekpb1ikFSiPcGnYtdVUGLJIS4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ix7sSaRT9L+/y6c+yakgKlxv/4xUpYPjYzUPiTEc7kQAh3h7I6lsjfF2e9DpV4mT1
	 sYjXZ1i50R9rwvPvj9xaLTRl1p2XsiABNy4o1Gx0xA5doP4uhVjez3+Jp+h2D8EB2y
	 hJKrGs2NbECoJISynsqunJbScqz3RiWOmqTCXEaNXFSxufatYtUjAiV4RKSdA3fmZ2
	 1rqRd85SpYS6xp/dGjfVF+TR7Yz5CGzU8GfUss0HVwt6KLylUGwdkkWz+1HBZYfHWn
	 R1G4z/F1p4JlJ+mLWsaIvAaOR64TWjfMZLUGF6/95aSnK4M5IgG0/D1xNcQc1Nv+Vj
	 4oiDiqOzkdLfA==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42388d6a561so32023921cf.1
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 06:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441785; x=1702046585;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeHPQXItxGwzbv6QpJekpb1ikFSiPcGnYtdVUGLJIS4=;
        b=VKRvRPnjPGweAZthZByv/4AQmteQSgo122O0yxo0sLS9i4WfgsWoXdGgnPWWHdQb8G
         IUW0gR2GgOGIhsVKLhOuH7cUu7tmTYVyeAaiF4TdE+PgY8N5+vT3hix8wJOX30FwJSbu
         5ltuCTtLSZ99kZiI8UTQJ+KvGr5F0WWdTg4VaFN/TS+OkZI6Sn/K2o/PDrNHAowlPkWs
         SRosVvZLIEEhCV+dDlZwvZ1eFSOd/Ld293JORyxWu7qvsbl3g7XjbOdxgJ3OvHgrWmJe
         ZnO/sr4bSpqPxzZAvtf9qupU6WBnnUAN2wxjPXv1tRqldQTjnR8CIjxS8b21E2a0x6PD
         TFIw==
X-Gm-Message-State: AOJu0YyS7yXVoGJT9smhQgQ8Vm8PIc/Kj5LMESxPPz5z2w0iad7Ut3di
	KVMx7J2izCExV88WHvyBZoqnktSeOKbs4+a7142rVKuTga7I+42O1ZE2xjUdlO8TY/jHRruT0Co
	pJtGy8vKpqZWkeCW9WtaZyGLuQdjTDXugXAaxohxJwrWi00dfEw==
X-Received: by 2002:a05:622a:4a0d:b0:423:9642:7824 with SMTP id fv13-20020a05622a4a0d00b0042396427824mr31391118qtb.49.1701441785054;
        Fri, 01 Dec 2023 06:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFXRhPjw2kpYgo1hB5NXDs8hUhXGv76AJm+E/K/ggJTd9UIG1Ccz103gQcgr7OxXJxSY+Iolj7RoJIV/czA/w=
X-Received: by 2002:a05:622a:4a0d:b0:423:9642:7824 with SMTP id
 fv13-20020a05622a4a0d00b0042396427824mr31391103qtb.49.1701441784835; Fri, 01
 Dec 2023 06:43:04 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 15:43:04 +0100
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z9CooaYqeTuZK0FARKupf_StTSfWBo7ziv4KtGq6pEVaQ@mail.gmail.com>
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
 <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
 <CAJM55Z9CooaYqeTuZK0FARKupf_StTSfWBo7ziv4KtGq6pEVaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 1 Dec 2023 15:43:04 +0100
Message-ID: <CAJM55Z-yam5RnsztYFSKVGoshLFaUau=rOmArsDsZnLYm3jE+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7100: ignore disabled device
 tree nodes
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Nam Cao <namcao@linutronix.de>, 
	Emil Renner Berthing <kernel@esmil.dk>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Huan Feng <huan.feng@starfivetech.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Emil Renner Berthing wrote:
> Nam Cao wrote:
> > The driver always registers pin configurations in device tree. This can
> > cause some inconvenience to users, as pin configurations in the base
> > device tree cannot be disabled in the device tree overlay, even when the
> > relevant devices are not used.
> >
> > Ignore disabled pin configuration nodes in device tree.
> >
> > Fixes: ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive SoCs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> >  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> > index 530fe340a9a1..561fd0c6b9b0 100644
> > --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> > +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> > @@ -492,7 +492,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
> >
> >  	nmaps = 0;
> >  	ngroups = 0;
> > -	for_each_child_of_node(np, child) {
> > +	for_each_available_child_of_node(np, child) {
>
> Hi Nam,
>
> Is this safe to do? I mean will the children considered "available" not change
> as drivers are loaded during boot so this is racy?

I just noticed the Allwinner D1 device trees use /omit-if-no-ref/ in front of
the pin group nodes. I think all current pin group nodes (for the JH7100 at
least) are used by some peripheral, so if you're removing peripherals from the
device tree you should be removing the reference too and this scheme should
work for you.

/Emil

