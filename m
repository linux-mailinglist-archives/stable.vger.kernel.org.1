Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC07289A3
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFHUsf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 16:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFHUse (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 16:48:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0AB2D74
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 13:48:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso116316a91.0
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686257312; x=1688849312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/cWOdE9Cl4ghSCati9orroM7J3NkJ+yK6Fnm2pVwJU=;
        b=GiRa6WzkGzsFTmbxE578/6wmNaD4wDVcmaHNzIz8Yr+O8oFpKOBOCy0YSaJuhAqsEM
         L3ILbz7NT12kFAJ5BuEEJpKiGgw4VksSjdXJV40v3TxbwDPn3c4Vy8D2tgoO2lP7nna6
         hpiKCtyUVhA1DkYu5iVO9YETZ9uk913mB+gGTgVM9Pnjtu3UXjGmOfVe26u1AxIsc/mm
         +uYHy+v7Q6RaOcHR3F3xRY6lHfpUZLDbi83RwuBE8xeRJ+i/Dks/sZglO2ZjBHEGWhdH
         WRJ3fPFPaqZuqJLzf/LQP1sHFOzaqmE05lfuHwsepDjRt7rtCatUXfizQnU/+knR4uhK
         F6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686257312; x=1688849312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/cWOdE9Cl4ghSCati9orroM7J3NkJ+yK6Fnm2pVwJU=;
        b=JRFgMvCrpbh0wIvLBuAIWaQ8oZps32UsOo6RrQ71E9v73V/xiy2MIFDMDtGu5AqUkc
         oCKzM0K/iSJW5URc/77qqSoGHMwCEy2qLC4A9TtSafWGy7LwEN/KuCDGQ/W+xZbJAy35
         VOEX35DFSPyfAbt403sOCMGEzqFSehAVRHCmjESUIDRm5cyc4aG8ZaimQlQwNHLJ24nD
         H4sTmWQaNOmQaQpd1kEe7YOhR7DOeFls3GW9U6H4XYV3kPCMlubZN67kXxhDz6JWFvls
         rB0GSrlKozxrxT2I2zLTgftpznw6NFuKVi4fK/k6lAGJnlX0hQHNnA4mJ0N0CUSPBoQB
         C2VA==
X-Gm-Message-State: AC+VfDzgUKPfY6JRKhWIf4XYRmSjG0xoAetwDPsWjRpaH65jk5tJmaIE
        KbdCKnog7aNm5/GhR/u7lciOO2wl4dwAycxqkwq6zQ==
X-Google-Smtp-Source: ACHHUZ6JfEP+38rFRLnj+im5wyEAfcSq9Novt+P/3Vpr4qhLytsg61E9/YBQhclyxgM7gcqj17ylBBC0xkA+CkpFK70=
X-Received: by 2002:a17:90b:17d1:b0:253:25c3:7a95 with SMTP id
 me17-20020a17090b17d100b0025325c37a95mr3729209pjb.14.1686257311593; Thu, 08
 Jun 2023 13:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230601031028.544244-1-badhri@google.com> <20230601031028.544244-2-badhri@google.com>
 <0bea99f1-cf66-4e80-b89b-41007c2ccfee@rowland.harvard.edu>
 <CAPTae5+EG+neDj=z4vC-r88Ai9Ha9n6FGU3dJi34NY+bka0zvQ@mail.gmail.com> <66a886aa-4b3d-421d-a229-8bb400c6fc8b@rowland.harvard.edu>
In-Reply-To: <66a886aa-4b3d-421d-a229-8bb400c6fc8b@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 8 Jun 2023 13:47:54 -0700
Message-ID: <CAPTae5JQoGrCqDg=Os0pxZaGe4cAfVRXpTDm3V-tFn1C7BQWyw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] usb: gadget: udc: core: Prevent
 soft_connect_store() race
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Thanks Alan ! Just sent out the v7 of the series after fixing all
other comments.

Regards,
Badhri

On Thu, Jun 8, 2023 at 8:27=E2=80=AFAM Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>
> On Wed, Jun 07, 2023 at 10:17:04PM -0700, Badhri Jagan Sridharan wrote:
> > On Wed, Jun 7, 2023 at 11:26=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu>
> > wrote:
> > > > @@ -756,10 +772,12 @@ int usb_gadget_disconnect(struct usb_gadget
> > > *gadget)
> > > >       if (!gadget->connected)
> > > >               goto out;
> > > >
> > > > -     if (gadget->deactivated) {
> > > > +     if (gadget->deactivated || !gadget->udc->started) {
> > >
> > > Do you really need to add this extra test?  After all, if the gadget
> > > isn't started then how could the previous test of gadget->connected
> > > possibly succeed?
> > >
> > > In fact, I suspect this entire section of code was always useless, si=
nce
> > > the gadget couldn't be connected now if it was already deactivated.
> > >
> >
> > Thanks Alan ! Will fix all other comments in v7 but not sure about this=
 one.
> > Although the ->pullup() function will not be called,
> > -> connected flag could actually be set when the gadget is not started.
> >
> > - if (gadget->deactivated || !gadget->udc->allow_connect) {
> > + if (gadget->deactivated || !gadget->udc->allow_connect ||
> > !gadget->udc->started) {
> >   /*
> >   * If gadget is deactivated we only save new state.
> >   * Gadget will be connected automatically after activation.
> > + *
> > + * udc first needs to be started before gadget can be pulled up.
> >   */
> >   gadget->connected =3D true;
> >
> > This could happen, for instance, when  usb_udc_vbus_handler()  is invok=
ed
> > after soft_connect_store() disconnects the gadget.
> > Same applies to when usb_gadget_connect() is called after the gadget ha=
s
> > been deactivated through usb_gadget_deactivate().
> >
> > This implies that the checks should be there, right ?
>
> Yes, you're right; the checks do need to be there.  I had forgotten
> about these possible cases.  Ignore that comment.
>
> Alan Stern
