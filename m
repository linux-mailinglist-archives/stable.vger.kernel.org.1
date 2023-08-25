Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6C788243
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjHYIiX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbjHYIiT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 04:38:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BD6213B
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 01:38:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcc331f942so8851371fa.0
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692952684; x=1693557484;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QT5lB6ELtp2Kj+OItj8lkNw3marf28CcZNitD0oxae4=;
        b=fHBPaZspft3eDNR1krp/yU67SM/sMHlaoFAQ8K+sV3YhB930ZvHHtjyM4/Xm7cDeHD
         cFf/Y1qlG6/9qyhsS9fvNcP7uj+gnQBidZRpwGJXqyRIhxAZD2vERtCVlmS7eR7RLUgV
         NAvuj2MukmD0YWeP/1EAtb8qm/5kxKQWfdeYXf2Fa7NsLQjzsQnHoCEY5dp05IRcVfKJ
         wL48tPb3fOP6w0hL8OBtwKSeKloWZLW/yasJUaMwepT1Kro0MaM3KYZ0kmnJZVZ0pp1K
         6gY8rPD3p8kNBcxRtYAnySPI263hmGRTNp450NGWcbcOHUBkK9D5omX4W07QBvItD8Tx
         tINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692952684; x=1693557484;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT5lB6ELtp2Kj+OItj8lkNw3marf28CcZNitD0oxae4=;
        b=lNTwpqqFlTkJDDCtH8gPfaplXcpi1S48gWj/n06J6RRbQHc2Gi6Rt/GnHkzJ3u5p7D
         9LFHfCNTTywuMu/t9CYQbqUX/sz0dVjdtaSIeq8s4c5Z5RuhWUXNtP4SeIEJ6IpRLoeb
         IHnF5Zbmc4zmqeXl/d0bipxVHakZvM0jO1mYfkzUZCFyDAm09urB81zZaRmhhnzN3Wn8
         a64RBE4DHFdfpKWL2vGvf9ZrxCVQfG2T0z69KHICWwVu4obZ56o5Cryc2HVrfFWJza0y
         MHO3zytrq8SLCZKkVZwqUEmnr95/7DWws33pH+byiBPQJA8X/bco/kDEyn3R72DKPRSl
         1QRA==
X-Gm-Message-State: AOJu0YzbGOt30ibjdIxIOPUgi6Wo+kIJxXnbQcQ0unhLDWgjsO77p0gi
        wPu7hrBRm0D6zJNKSD+0lcM=
X-Google-Smtp-Source: AGHT+IGOmN4g5i3o5oae/akXL0yQoPaUAUaWkgxO5MgazCDUPqE0YTdLnCr2Ujramb5WkqW0V1T2kA==
X-Received: by 2002:a2e:a4b2:0:b0:2b6:b30f:5bf with SMTP id g18-20020a2ea4b2000000b002b6b30f05bfmr7106277ljm.13.1692952683415;
        Fri, 25 Aug 2023 01:38:03 -0700 (PDT)
Received: from [100.119.51.22] (95-24-151-207.broadband.corbina.ru. [95.24.151.207])
        by smtp.gmail.com with ESMTPSA id j16-20020a2e6e10000000b002b9ef00b10csm240000ljc.2.2023.08.25.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:38:03 -0700 (PDT)
Message-ID: <e81e0014604bc8cf6f387c67875e43dc9a339815.camel@gmail.com>
Subject: Re: [PATCH 5.10 066/135] net/ncsi: change from ndo_set_mac_address
 to dev_set_mac_address
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Paul Fertser <fercerpav@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 25 Aug 2023 11:38:02 +0300
In-Reply-To: <2023082507-breezy-eastward-da6d@gregkh>
References: <20230824170617.074557800@linuxfoundation.org>
         <20230824170620.057993946@linuxfoundation.org>
         <739b18f9dc2ae6cde7b1060ee8071d7687b5d4e3.camel@gmail.com>
         <2023082507-breezy-eastward-da6d@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 2023-08-25 at 09:16 +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 25, 2023 at 09:24:46AM +0300, Ivan Mikhaylov wrote:
> > On Thu, 2023-08-24 at 19:08 +0200, Greg Kroah-Hartman wrote:
> > > 5.10-stable review patch.=C2=A0 If anyone has any objections, please
> > > let
> > > me know.
> > >=20
> > > ------------------
> > >=20
> > > From: Ivan Mikhaylov <fr0st61te@gmail.com>
> > >=20
> > > [ Upstream commit 790071347a0a1a89e618eedcd51c687ea783aeb3 ]
> > >=20
> > > Change ndo_set_mac_address to dev_set_mac_address because
> > > dev_set_mac_address provides a way to notify network layer about
> > > MAC
> > > change. In other case, services may not aware about MAC change
> > > and
> > > keep
> > > using old one which set from network adapter driver.
> > >=20
> > > As example, DHCP client from systemd do not update MAC address
> > > without
> > > notification from net subsystem which leads to the problem with
> > > acquiring
> > > the right address from DHCP server.
> > >=20
> > > Fixes: cb10c7c0dfd9e ("net/ncsi: Add NCSI Broadcom OEM command")
> > > Cc: stable@vger.kernel.org=C2=A0# v6.0+ 2f38e84 net/ncsi: make one
> > > oem_gma
> > > function for all mfr id
> > > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> > > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > > =C2=A0net/ncsi/ncsi-rsp.c | 5 +++--
> > > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> > > index 888ccc2d4e34b..47ffb790ff99f 100644
> > > --- a/net/ncsi/ncsi-rsp.c
> > > +++ b/net/ncsi/ncsi-rsp.c
> > > @@ -616,7 +616,6 @@ static int
> > > ncsi_rsp_handler_oem_mlx_gma(struct
> > > ncsi_request *nr)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ncsi_dev_priv =
*ndp =3D nr->ndp;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net_device *nd=
ev =3D ndp->ndev.dev;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct net_device_op=
s *ops =3D ndev->netdev_ops;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ncsi_rsp_oem_p=
kt *rsp;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sockaddr saddr=
;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
> > > @@ -630,7 +629,9 @@ static int
> > > ncsi_rsp_handler_oem_mlx_gma(struct
> > > ncsi_request *nr)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Set the flag for G=
MA command which should only be
> > > called
> > > once */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndp->gma_flag =3D 1;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ops->ndo_set_mac_a=
ddress(ndev, &saddr);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rtnl_lock();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D dev_set_mac_addres=
s(ndev, &saddr, NULL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rtnl_unlock();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0netdev_warn(ndev, "NCSI: 'Writing mac address to
> > > device failed\n");
> > > =C2=A0
> >=20
> > Greg, we had conversation in the past about this particular
> > patchset
> > series:
> > https://www.spinics.net/lists/stable-commits/msg308587.html
> >=20
> > Just one patch is not enough, I didn't test it either on linux
> > kernel
> > version < 6.0 , also I saw the Sasha's commits about the same for
> > 5.4,
> > 5.10, 5.15 and answered to him about necessity of two patchsets
> > instead
> > of one on 19 aug.
>=20
> Ah, so I should also include commit 74b449b98dcc ("net/ncsi: make one
> oem_gma function for all mfr id"), right?
>=20
> thanks,
>=20
> greg k-h

Greg, yes, that's right and I'm not sure if these two patches applies
well for 5.x stable releases.

Thanks.
