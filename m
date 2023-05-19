Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD1708ED6
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 06:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjESEaZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 00:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESEaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 00:30:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1F10D0
        for <stable@vger.kernel.org>; Thu, 18 May 2023 21:30:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2536b4b3398so1059720a91.3
        for <stable@vger.kernel.org>; Thu, 18 May 2023 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684470622; x=1687062622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7rhwTrEAMX08YzP/4DHviFyIbM+YD+5MP+UjCfh5d8=;
        b=TNIczUF2G+oWvPr2w7jkkUbLgyuwkCadYukw22DE7XazUFdaLL16TY9GAmVMNt0396
         KLOwihwV1a2RnUQ0PdCUCPerIB/9wLu1SR8Rukq7Dycij9HPFFmmKbhcLukreqiwASl5
         TA1VWipq3P7NqmwL+V8ZgLhnLwZYLUdkp1OhwevxtYCo6hVe5LX0mFBnpbtYjzXbvXTy
         Cc7jHBHnyGTDA480xgyWOxpa3Wx4u5MN2UiZBPSjeJzm0qjkapM6Beii5kRnavWdc1Lh
         YRHM6AOePJ/otLwqVkUWeNUbcAgdmJsRiUmI3lCqGJhMtyEQLOVU8Lf6dvjvnEwWm77x
         cSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684470622; x=1687062622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7rhwTrEAMX08YzP/4DHviFyIbM+YD+5MP+UjCfh5d8=;
        b=OeBRc1RgY3i3GzxI7mUEFn25YuiF9biUS7fp9roSBKKep9FVAW/fvfrOOQatbdzUie
         H1y1Suwss8q+IFG+7Lt/sN8kCeeeSahlK6b2AKC91tJtAaNveVAauWHJH7wxf6EfaKLZ
         mlrzzBJybDXGx6+pIpi8rDCrdepUxv5IzQXYgwJsPAaL6nPKW++XENxr+XQaP8Hi4gsi
         0Lhe0U8t+HOupDpOGgaKv5hwgQ9mIeJEMJGahfkANE3oD0Hvfb3NC7XyhyIwiTUu149v
         qv83MkPZ9epaVhu10mea4FZMiT5IN3Ves59h/sIGLS0UfeUQ6pxVvMi/5XsMh/n4Ud4H
         siKw==
X-Gm-Message-State: AC+VfDxFCX88s60+3p+w6OSeypQisHcM8tDihMIG3KHYd0A/PwRCpmRq
        QEeiXwGWaEn8x9NvQg++j0Fja9uGPuhERTwH+GsYCw==
X-Google-Smtp-Source: ACHHUZ6VjrLP43KWoztAM4tD22Kf73o24OLyIQjLaqps5vcL8vuqqDuLgZEL+qpzNX+LhVQ4cd7hc0MOG8M5Du6sc6Y=
X-Received: by 2002:a17:90a:2b4f:b0:247:6ead:d0ed with SMTP id
 y15-20020a17090a2b4f00b002476eadd0edmr986340pjc.28.1684470622331; Thu, 18 May
 2023 21:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230517115955.1078339-1-badhri@google.com> <c7f19b4e-469c-4e40-bd2e-e864ca5f7872@rowland.harvard.edu>
 <CAPTae5JB2LLEF7ZNaJxMnF==8WCWoEYvmF_FK3F=BDq0Hko0xQ@mail.gmail.com> <c7cb96ea-628d-4591-908c-d6ea572ef5a0@rowland.harvard.edu>
In-Reply-To: <c7cb96ea-628d-4591-908c-d6ea572ef5a0@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 18 May 2023 21:29:45 -0700
Message-ID: <CAPTae5KGN_KTFO+hj68heTMqJ0tfyBfjQnwLUGyMM40Uq+w_Eg@mail.gmail.com>
Subject: Re: [PATCH v1] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 17, 2023 at 1:01=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, May 17, 2023 at 10:19:25AM -0700, Badhri Jagan Sridharan wrote:
> > On Wed, May 17, 2023 at 7:44=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Wed, May 17, 2023 at 11:59:55AM +0000, Badhri Jagan Sridharan wrot=
e:
> > > > chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> > > > ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handl=
er
> > > > processing.
> > >
> > > Surely that is the wrong approach.
> > >
> > > The real problem here is that usb_udc_vbus_handler() gets called from
> > > within a udc_start routine.  But this is totally unnecessary, because
> > > the UDC core will call usb_udc_connect_control_locked() itself, later=
 on
> > > during gadget_bind_driver().
> >
> > Hi Alan,
> >
> > usb_udc_vbus_handler sets the udc->vbus flag as well apart from
> > calling usb_udc_connect_control_locked().  So, removing usb_udc_vbus_ha=
ndler
> > from chip specific start callback might prevent the controller from
> > starting.
> >
> > void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
> > {
> > struct usb_udc *udc =3D gadget->udc;
> >
> > mutex_lock(&udc->connect_lock);
> > if (udc) {
> > udc->vbus =3D status;
> > usb_udc_connect_control_locked(udc);
>
> Then add "udc->vbus =3D true;" at the appropriate spot in
> gadget_bind_driver().


Not sure if I am misunderstanding something.
"udc->vbus =3D true" is set by usb_udc_vbus_handler based on invocation
from the chip level gadget driver and gadget_bind_driver() does not
seem to have the context for udc->vbus.
Do you still think it makes sense to add  "udc->vbus =3D true;" to
gadget_bind_driver() ?

>
>
> Alan Stern
>
> PS: I just noticed that in max3420_udc.c, the max_3420_vbus_handler()
> function calls usb_udc_vbus_handler() from within an interrupt handler.
> This won't work, since interrupt handlers aren't allowed to sleep and
> therefore can't lock mutexes.


Good point ! I didn't notice  that usb_udc_vbus_handler()  is invoked
from interrupt context as well.
I was looking at turning connect_lock into a spin lock. But looks like
udc_lock which is acquired
in usb_gadget_disconnect_locked is a mutex, So keeping connect_lock as
mutex and changing
vbus_events_lock into spin_lock is what that seems to be possible.
Sending out V2 of this patch
with these changes so that it's easier to see what I am referring to.
Eager to know your thoughts !

Thanks,
Badhri
