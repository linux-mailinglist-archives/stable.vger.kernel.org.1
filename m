Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F27C5A32
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjJKR0i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJKR0h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 13:26:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5197FA4
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 10:26:35 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9a4c0d89f7so53167276.1
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697045194; x=1697649994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNew73H8cLV959XSqwiYY0ad0O2l97cOQFlYDKMA/zo=;
        b=ssa6ntaV03yK5gboE4vEFZQHVARfhDbrwTHgdzVbJ8o2Z/LDA1HdaFSHGqjGNqFcve
         vYzkbp5e0PigponDa4dKYClAe4YTosW7w0lrscXrShM5blfnvUC1LGETZ2HuzzyQe8FB
         P7ifEiJFuQeEVuavU1aojtXkqXWQVILFG3NXfq7duVcmpsABWmpo7h+k0/F5LNxw+bdx
         oQW5swGr5ci0u5pe6+A/Ld5MMSUwFXAzSkWHTYxkMo9awiJQr9oY8NfoesntYD9xd6a+
         Gz6H8VVcr73tZvNnlvtv1/1jiFvl0TMDxVytV837ztm3khyQ7wlSUT6KSStaxioH1R0+
         nYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045194; x=1697649994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNew73H8cLV959XSqwiYY0ad0O2l97cOQFlYDKMA/zo=;
        b=Nrnqjz998JINf5D7Q3Kg4QXTE4ZG1R/z04z/fPMz3wU5beBBVCwNl2yiXsO2Llt1+n
         6O9vJCB52Izi4mC7jAvXC7X288Rz3ZGNnnWdadcXhNUUeEf8PqscDesqOnHx4tQvSmyf
         LxnV5hLOK1RDl9hNT7CTubtksRf7cX4q9KVQ5ed61OfOOE87V9zJkJ5LpRNoxl2Ee1LI
         CAyYLEa+jNazak3rryoUzdddc6KhgN2tPV/mOwMIsLZBzMkOMt73HHmRBnEiavJRerd4
         DuDPQfFWa+IF7+NA7se5viY3ulVjDopTFY/9MvoQkOYEwYfbPByHUzGXsJaI3MJIfV/f
         YGdw==
X-Gm-Message-State: AOJu0YxksFZ/RapHTCYEu68/nOrzI9XkfdTrXSdpjVMyv1xluH3HqcMW
        aLYDZ890v58z1dXRC1pIICJicvklRVh9Wl9MQwLJ2Q==
X-Google-Smtp-Source: AGHT+IEp5ojjWgF2jbZMwhTPCU3vssABraPBQDjt2Us+Xxi5NO6ntvquWBFk9mwc8p87fRKuk04zCdroPyd0DKql4c0=
X-Received: by 2002:a25:9012:0:b0:d9a:5f25:d0df with SMTP id
 s18-20020a259012000000b00d9a5f25d0dfmr5073058ybl.57.1697045194529; Wed, 11
 Oct 2023 10:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com> <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org> <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
 <20231009172849.00f4a6c5@kernel.org> <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
 <7058E983-D543-4C5B-91ED-A8728775260A@flyingcircus.io>
In-Reply-To: <7058E983-D543-4C5B-91ED-A8728775260A@flyingcircus.io>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 11 Oct 2023 13:26:23 -0400
Message-ID: <CAM0EoM=jXYtbzo3W7eaVD5a=8DJde5Mu1wCQ7MvYigDT1k_Mkw@mail.gmail.com>
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC requirement
To:     Christian Theune <ct@flyingcircus.io>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Pedro Tammela <pctammela@mojatatu.com>,
        markovicbudimir@gmail.com, stable@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 1:32=E2=80=AFPM Christian Theune <ct@flyingcircus.i=
o> wrote:
>
> Hi,
>
> > On 10. Oct 2023, at 17:02, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > This is a tough one - as it stands right now we dont see a good way
> > out. It's either "exploitable by root / userns" or break uapi.
> > Christian - can you send your "working" scripts, simplified if
> > possible, and we'll take a look.
>
> Sure, what kind of simplification are we talking about? Something like th=
is?
>
> #### snip
> #!/bin/bash
> modprobe ifb
> modprobe act_mirred
>
> uplink=3Deth0
> uplink_ingress=3Difb0
>
> tc qdisc add dev $uplink handle ffff: ingress
> ifconfig $uplink up
>
> tc filter add dev $uplink parent ffff: protocol all u32 match u32 0 0 act=
ion mirred egress redirect dev $uplink_ingress
>
> tc qdisc add dev $uplink_ingress root handle 1: hfsc default 1
> tc class add dev $uplink_ingress parent 1: classid 1:999 hfsc rt m2 2.5gb=
it
> tc class add dev $uplink_ingress parent 1:999 classid 1:1 hfsc sc rate 50=
mbit
> #### snap
>
> This should provoke the error reliably. You might need to point it at wha=
tever network interface is available but need to be prepared to loose conne=
ctivity.
>

Ok - thanks, we'll look at this from the perspective of both ensuring
UAF is gone and making your config happy. TBH, in my view UAF comes
first but we can debate that later.

cheers,
jamal
> Christian
>
>
> Liebe Gr=C3=BC=C3=9Fe,
> Christian Theune
>
> --
> Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
> Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
> Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
> HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick
>
