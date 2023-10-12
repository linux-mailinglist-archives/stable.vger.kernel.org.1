Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60F87C6810
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjJLIVK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjJLIVJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 04:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62F90
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697098820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUQGFZibjWLbHGD7MkFyWjWgEq0nesz4IaEchkjp01E=;
        b=fPzft8qldXMDEhFcIzBaQkTFTukfeKN9QAfPxzDIoxoEsbOU0zmSRZ/GpxsglhGeR9PZwR
        hKPXw/zR3DRQGiMuBbS8U71YZ7fx4ud0kX58wilVdc2Wer/5hwiUbqSJfMBajQiVTZGVrY
        Wqv5qg0RVE49g8HlOO1h4MG/coLJfbo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168--dswFqZqPeOSpbb_iLoJyA-1; Thu, 12 Oct 2023 04:20:15 -0400
X-MC-Unique: -dswFqZqPeOSpbb_iLoJyA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae56805c41so14910266b.0
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 01:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697098814; x=1697703614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUQGFZibjWLbHGD7MkFyWjWgEq0nesz4IaEchkjp01E=;
        b=UWyVL0kS+QVhEAJdZxlVc4XiUmYGiWGBXOHmjfnUHeEewVrYhIBkPVzQKfvYnWRkLE
         HN8vcLOPU+61M9LWs0OscnogFRPeF5sa8BmzTS1RKeGHR9pgRfyCwBa5fHYQIZLifsSP
         4Ki4WSXcDcFaJeT+jjtjdSEV3kWQwQTUoHlqBCEQXK/R3raieWy7gwoUPAGAzUxEYW36
         rL8kcwWR7ELwSj/axlh0LEIFIRqIeoDGp14oRCxslSI75v61kLPPHmHj3pEVP3bo+BcK
         An8Mek5gAMyuOrxTanZZknr04UK16/YfAxf26NSTM/PADAOlx5rfGjQzMbmoAREh55z2
         o21w==
X-Gm-Message-State: AOJu0YzMOZSWhIHWsWZP0Cez6BR68HnwJ0BEHxeQSKYdHb86kGK3S5PZ
        A7OqPwyG4SHMO0p3w9VQ29j3x9cJiTi7vsJoJ7hmLaCy+3QOXRr3/lSfCwQh6nMhGbWrIdWkRQk
        6i4LLcnbmVC4UESXU
X-Received: by 2002:a17:906:5308:b0:9b2:b532:d8d7 with SMTP id h8-20020a170906530800b009b2b532d8d7mr19609963ejo.5.1697098814251;
        Thu, 12 Oct 2023 01:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmtmCJxaUaeLtHi5RVZPHhGXh9jaLCD3x/MRiZ5QnXRXTXc+xC7HkDo64T2no3UQEvF/oS4A==
X-Received: by 2002:a17:906:5308:b0:9b2:b532:d8d7 with SMTP id h8-20020a170906530800b009b2b532d8d7mr19609936ejo.5.1697098813773;
        Thu, 12 Oct 2023 01:20:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-181.dyn.eolo.it. [146.241.228.181])
        by smtp.gmail.com with ESMTPSA id dx12-20020a170906a84c00b009b977bea1dcsm10765401ejb.23.2023.10.12.01.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:20:13 -0700 (PDT)
Message-ID: <438bdacdfe2b50534d30d5d51660c4a7c3ba4f66.camel@redhat.com>
Subject: Re: [PATCH net] net: davicom: dm9000: dm9000_phy_write(): fix
 deadlock during netdev watchdog handling
From:   Paolo Abeni <pabeni@redhat.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Francois Romieu <romieu@fr.zoreil.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>, Wei Fang <wei.fang@nxp.com>,
        kernel@pengutronix.de, stable@vger.kernel.org
Date:   Thu, 12 Oct 2023 10:20:11 +0200
In-Reply-To: <20231011-said-hemlock-834e5698a7a3-mkl@pengutronix.de>
References: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
         <20231010222131.GA3324403@electric-eye.fr.zoreil.com>
         <20231011-said-hemlock-834e5698a7a3-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-10-11 at 08:43 +0200, Marc Kleine-Budde wrote:
> On 11.10.2023 00:21:31, Francois Romieu wrote:
> > Marc Kleine-Budde <mkl@pengutronix.de> :
> > > The dm9000 takes the db->lock spin lock in dm9000_timeout() and calls
> > > into dm9000_init_dm9000(). For the DM9000B the PHY is reset with
> > > dm9000_phy_write(). That function again takes the db->lock spin lock,
> > > which results in a deadlock. For reference the backtrace:
> > [...]
> > > To workaround similar problem (take mutex inside spin lock ) , a
> > > "in_timeout" variable was added in 582379839bbd ("dm9000: avoid
> > > sleeping in dm9000_timeout callback"). Use this variable and not take
> > > the spin lock inside dm9000_phy_write() if in_timeout is true.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > > During the netdev watchdog handling the dm9000 driver takes the same
> > > spin lock twice. Avoid this by extending an existing workaround.
> > > ---
> >=20
> > I can review it but I can't really endorse it. :o)
> >=20
> > Extending ugly workaround in pre-2000 style device drivers...
> > I'd rather see the thing fixed if there is some real use for it.
>=20
> There definitely are still users of this drivers on modern kernels out
> there.
>=20
> I too don't like the feeling of wrapping more and more duct tape
> around existing drivers. How about moving the functionality to
> dm9000_phy_write_locked() and leave the locking in dm9000_phy_write().
> I will prepare a patch.

If you have the H/W handy to try some more invasive change, I'm
wondering if you could schedule a work from dm9000_timeout() and there
acquire all the needed locks.=20

Cheers,

Paolo

