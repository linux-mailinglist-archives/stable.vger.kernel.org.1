Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8E709B83
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjESPph (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjESPpg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 11:45:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E61B3
        for <stable@vger.kernel.org>; Fri, 19 May 2023 08:45:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso1129485b3a.0
        for <stable@vger.kernel.org>; Fri, 19 May 2023 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684511134; x=1687103134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2a0D7KFX+ar40EIbBe/MkP/xIi7gWSnepHbZAaa39s=;
        b=z+DaZqUGK2GmR/Q17ULz20uJOBy6Lmw+vzrQNMl3iZNg/9wAn7b4seGkZHo0xnS9xx
         Gcu4eEqcqiQKH2xDd28qO6NSvWCfp3vOBeaITHOKMO7hdcx0iHKzxBIDAYuwduI6SOBk
         FzqqtQ7cx1c2o4nzjOVPr1ng5padPy/Tf88RDxc6UU/fxX3AjpIFg6sz6bste5Tkkz5v
         d6cGHEdCYZ5dHY7urcxMNL05cxAPRF60k62douajvXwYZd2E2HE14lm+837sklFqQaBs
         vItR2qw3pLSeo2Lpp8iQpl3GMsfOhrESPGjWs03fy4VpPUckiBdjGzqY3xGJ031CmFRZ
         crHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684511134; x=1687103134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2a0D7KFX+ar40EIbBe/MkP/xIi7gWSnepHbZAaa39s=;
        b=cgGkxtLOFw2dnl7C8EPNG09lAgb1iZAAhbqVI/O5jEhY8+G0C/+WidfA2YwarygqN3
         mXjQGSPhCy2Iuiu0oz5LWF4eG/FT79FfNRPNN2rC84UBgUnzdp4j/I/PmhTI4Uyd0WYp
         Z0JXxQlIuskNOYucFgWUZuFXvm9diMJErRz3TVhgccWgqUyM8abh95AWrrh90ZSWNP3e
         iWAGPVL3uY4dUge9sanSZ/qatiwi7I4mxpCqDmMOipX828t390ALR75r5eylZS7cqP5H
         5sOzcJrq8/IuU+Ck0ko40SeA8zQ3nxs4L3ES2FKrPtBagUiG1bcj5NiofqdZ/fry3+vU
         JKvQ==
X-Gm-Message-State: AC+VfDz2nq/Nc7AWKRkh9MUbZSsgtikBZxwCuF+QL7wUfzdBaY6VPdRn
        0lgiv492ooitYgsgkmKBuCRyiFxbCxPwWx70WdFw3A==
X-Google-Smtp-Source: ACHHUZ6zD7XL7L3zGIBrXWRqHA0dw1kaq1aUdYJyMWJaUhDF95bGm/7VnfBvKezUi10cZoSykitcggxtmKh0shz7Rbs=
X-Received: by 2002:a17:902:eb46:b0:1ac:9cad:1845 with SMTP id
 i6-20020a170902eb4600b001ac9cad1845mr3189607pli.18.1684511134420; Fri, 19 May
 2023 08:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230519043041.1593578-1-badhri@google.com> <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
In-Reply-To: <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 19 May 2023 08:44:57 -0700
Message-ID: <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler processing
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

On Fri, May 19, 2023 at 8:07=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, May 19, 2023 at 10:49:49AM -0400, Alan Stern wrote:
> > On Fri, May 19, 2023 at 04:30:41AM +0000, Badhri Jagan Sridharan wrote:
> > > chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> > > ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
> > > processing.
> >
> > Look, this is way overkill.
> >
> > usb_udc_vbus_handler() has only two jobs to do: set udc->vbus and call
> > usb_udc_connect_control().  Furthermore, it gets called from only two
> > drivers: chipidea and max3420.
> >
> > Why not have the callers set udc->vbus themselves and then call
> > usb_gadget_{dis}connect() directly?  Then we could eliminate
> > usb_udc_vbus_handler() entirely.  And the unnecessary calls -- the ones
> > causing deadlocks -- from within udc_start() and udc_stop() handlers ca=
n
> > be removed with no further consequence.
> >
> > This approach simplifies and removes code.  Whereas your approach
> > complicates and adds code for no good reason.
>
> I changed my mind.
>
> After looking more closely, I found the comment in gadget.h about
> ->disconnect() callbacks happening in interrupt context.  This means we
> cannot use a mutex to protect the associated state, and therefore the
> connect_lock _must_ be a spinlock, not a mutex.

Quick observation so that I don't misunderstand.
I already see gadget->udc->driver->disconnect(gadget) being called with
udc_lock being held.

               mutex_lock(&udc_lock);
               if (gadget->udc->driver)
                       gadget->udc->driver->disconnect(gadget);
               mutex_unlock(&udc_lock);

The below patch seems to have introduced it:
1016fc0c096c USB: gadget: Fix obscure lockdep violation for udc_mutex

Are you referring to some other ->disconnect() callback ? If so, can you po=
int
me to which one ?

>
> This also probably means that udc_start and udc_stop callbacks should
> not be invoked with the lock held.  In fact, you might want to avoid
> using the lock at all with gadget_bind_driver() and
> gadget_unbind_driver() -- use it only in the functions that these
> routines call.
>
> So it appears the whole connect_lock thing needs to be redesigned with
> these ideas in mind.  However, it's still true that the UDC drivers
> shouldn't try to set the connection state from within their udc_start
> and udc_stop callbacks, because the core takes care of this
> automatically.
>
> Alan Stern

Thanks for your inputs !
Badhri
