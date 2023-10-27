Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5A7D8F43
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjJ0HJy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJ0HJx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 03:09:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED900186
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 00:09:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32ddfb38c02so1198174f8f.3
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698390589; x=1698995389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZPoKy/32kD9TK86P4LFHbN697d0ba1K8lTZLC735wI=;
        b=FKsM7vvHih+HpIVY9L6h99N9nVnduwbLepwFvIp4IkVqNR5nqLWroP85ObLCfhS8Yi
         UU9aF+JxAOtkfrSQUOYa97Fht6lP8c2t+qClPXkV6w71oz+Gni7QHGggjpNJzDBdVkRa
         BvoJeXAVfME3OkC6D0hWV6/EFIWKaYGd7fU2dkyewG+OTDDvHU1G+B97BQNL+npTUb1S
         Za5TQUvYBoG5a6Sq5TfIRqSnC562sdrpcgpNudPeIZiuE2TBzqRQC5CCb+dLVR2x/tTb
         0+Zv2yXgkK5gHiSsMN6Cc4D9MhWQ0OwXeSQZYLHlvZIcC+b2aj6i0Po2LdELll5seVIu
         eTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698390589; x=1698995389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZPoKy/32kD9TK86P4LFHbN697d0ba1K8lTZLC735wI=;
        b=YdNtbL3ZSDpD+OtsOOkZEeOutkP2FxbO62mEhVTYCKmd6IHtAcvXPbKnenx+Z0sZMq
         0F/sQxb+i0R8kBomaLhk+JSUDHToktqGXGk8/c4AQXkpgeHdtFXSEWRi78pB1LFDEgTP
         Yu4OKztqbHBobyIFtoSTgFMxQO/BP0QTrvJyWBybmZK34VHMgy3AG4xPaiAQ/XV0sWC2
         klAbxNXbei04wj9Hpug9CslcX9K9WYay4jZ0gnCCAC4J2kKECr/I0DH3on9S3OYOs6+k
         AMrIOENmaWy9wHWg+xrLX9hf8SLZ8Aet7f7D6Fpy7/HpPCb9rwwr8XfZAL0gERoNTo/f
         fx2g==
X-Gm-Message-State: AOJu0Yw/jkn2HEIP9/6hDCdeQoaT+B9mdExL7l6T9MJxzYbhnsy9ZN1m
        XdeZxX9ovkRNoMcSw1D/NKkR5mY/4VifGlq5niE=
X-Google-Smtp-Source: AGHT+IF01OB0Jby2mK/tN88u5K9Rlr0RZoeviolDpclBjhYuB5Lnu0XGEJoSIP1m0B5VdJ4ky9LA7tjpeDc3tnbjI20=
X-Received: by 2002:adf:e4c4:0:b0:32d:804c:15d1 with SMTP id
 v4-20020adfe4c4000000b0032d804c15d1mr1515310wrm.47.1698390589010; Fri, 27 Oct
 2023 00:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
 <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
 <20231016054647.GA26170@lst.de> <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
 <ZTqA--6dDYJ76Gyk@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZTqA--6dDYJ76Gyk@kbusch-mbp.dhcp.thefacebook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Fri, 27 Oct 2023 12:39:22 +0530
Message-ID: <CA+1E3rJsb-8M_fE-PGrvAkzwHN6PLZPSYXJpZhRtn6hOipK8cA@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 26, 2023 at 8:38=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Oct 26, 2023 at 08:03:30PM +0530, Kanchan Joshi wrote:
> > On Mon, Oct 16, 2023 at 11:16=E2=80=AFAM Christoph Hellwig <hch@lst.de>=
 wrote:
> > >
> > > On Mon, Oct 16, 2023 at 12:49:45AM +0530, Kanchan Joshi wrote:
> > > > OTOH, this patch implemented a software-only way out. There are som=
e
> > > > checks, but someone (either SW or HW) has to do those to keep thing=
s
> > > > right.
> > >
> > > It only verifies it to the read/write family of commands by
> > > interpreting these commands.  It still leaves a wide hole for any
> > > other command.
> >
> > Can you please explain for what command do you see the hole? I am
> > trying to see if it is really impossible to fix this hole for good.
> >
> > We only need to check for specific io commands of the NVM/ZNS command
> > set that can do extra DMA.
>
> The spec defines a few commands that may use MPTR, but most of the
> possible opcodes that could use it are not defined in spec. You'd have
> to break forward compatibility through this interface for non-root users
> by limiting its use to only the known opcodes and reject everything
> else.

I see. Future commands. Looks like every solution involves non-root
users to face some form of inconvenience.
