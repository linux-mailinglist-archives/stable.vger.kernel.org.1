Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98179787FC8
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjHYGZM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHYGYv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 02:24:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534161BF0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 23:24:49 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so7912571fa.3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692944687; x=1693549487;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEHc+Bn9fVExj/Xm1/appuP/CTV5FQDNf/fQ5GlDY9k=;
        b=Qmg0yw1ib8mMBEqotOKleA6FwURO9sng03yw+9MYlavL0ZlVsDEq7uH1kDO0WfP8+Z
         m7qrQRZz6OWWTxb9FOJW7QBf3ezDj+0k0A1zB4YitThip3meDT6Xv0bifjNwsSPqjCTh
         36tFUDlYw+FHdO/z2XftXmRxZMENCJpOADF18f1+teqz+fI6107UD/PrSXBpX5ahf1m9
         e2cJz4VjQsR1U4zRn+Z+/zVNBSB2oUXQ0rRCCatYrQCX/Bb/UOlH205vr5drI7SvwKZQ
         rXXRkux7sSidO7fDBj167/Ka0lW/sEeL9VBF+YV9KyyQ7ON8jEzP+gI2k0HL9dL3zqkc
         19UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692944687; x=1693549487;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEHc+Bn9fVExj/Xm1/appuP/CTV5FQDNf/fQ5GlDY9k=;
        b=b5KI+aIyuFXhl4WrOkGplZtXLKWJpeC+BhCz2zAHZLw9KGTZBDjQJfhQor1Kn9EVP+
         q1fC7NH3hGoFthMNeYEOCR99tOCSpiWwMH5DBDqq2dbeJV6lzBxfyVTQGhTzyuUN2nVK
         Pvd5FMbNO1KCRFASUxLU9I5ox45zi1sz+jgh/2Y7/vIHC0Cc4syKWUNhigSu0kRgJEFT
         5vsIy56qygNVQtDAou8Y7iqg04MofMpGPS+RBVT27iN95Q/AeJx2GmVgcGXoNwPRpCNL
         2b4ZPNNrszXsznsZnYKfF1cj6QBQ9XewUMM6rDABjeNM7R+28S17arzwg6vNAIeCzb8l
         rkhg==
X-Gm-Message-State: AOJu0YxqQQpdshALzfLQ63WPx8j3a4EAzBzRtzDYb4BCM6zRewzF3SNm
        RGW4SAGIcM2+u9xlYybKwjo=
X-Google-Smtp-Source: AGHT+IEeEg+wOHWE9+2JE6SBQOCKkhi7+hlHb7+7beGRLxugsfX/OUlKdP7BCUV3f2noAr4xPP7nWw==
X-Received: by 2002:a2e:9594:0:b0:2b6:d137:b61c with SMTP id w20-20020a2e9594000000b002b6d137b61cmr14112049ljh.39.1692944687281;
        Thu, 24 Aug 2023 23:24:47 -0700 (PDT)
Received: from [100.119.51.22] (95-24-151-207.broadband.corbina.ru. [95.24.151.207])
        by smtp.gmail.com with ESMTPSA id 8-20020a05651c00c800b002b9e501a6acsm196422ljr.3.2023.08.24.23.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 23:24:46 -0700 (PDT)
Message-ID: <739b18f9dc2ae6cde7b1060ee8071d7687b5d4e3.camel@gmail.com>
Subject: Re: [PATCH 5.10 066/135] net/ncsi: change from ndo_set_mac_address
 to dev_set_mac_address
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, Paul Fertser <fercerpav@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 25 Aug 2023 09:24:46 +0300
In-Reply-To: <20230824170620.057993946@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
         <20230824170620.057993946@linuxfoundation.org>
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

On Thu, 2023-08-24 at 19:08 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.=C2=A0 If anyone has any objections, please let
> me know.
>=20
> ------------------
>=20
> From: Ivan Mikhaylov <fr0st61te@gmail.com>
>=20
> [ Upstream commit 790071347a0a1a89e618eedcd51c687ea783aeb3 ]
>=20
> Change ndo_set_mac_address to dev_set_mac_address because
> dev_set_mac_address provides a way to notify network layer about MAC
> change. In other case, services may not aware about MAC change and
> keep
> using old one which set from network adapter driver.
>=20
> As example, DHCP client from systemd do not update MAC address
> without
> notification from net subsystem which leads to the problem with
> acquiring
> the right address from DHCP server.
>=20
> Fixes: cb10c7c0dfd9e ("net/ncsi: Add NCSI Broadcom OEM command")
> Cc: stable@vger.kernel.org=C2=A0# v6.0+ 2f38e84 net/ncsi: make one oem_gm=
a
> function for all mfr id
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> =C2=A0net/ncsi/ncsi-rsp.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 888ccc2d4e34b..47ffb790ff99f 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -616,7 +616,6 @@ static int ncsi_rsp_handler_oem_mlx_gma(struct
> ncsi_request *nr)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ncsi_dev_priv *ndp=
 =3D nr->ndp;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net_device *ndev =
=3D ndp->ndev.dev;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct net_device_ops *o=
ps =3D ndev->netdev_ops;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ncsi_rsp_oem_pkt *=
rsp;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sockaddr saddr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
> @@ -630,7 +629,9 @@ static int ncsi_rsp_handler_oem_mlx_gma(struct
> ncsi_request *nr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Set the flag for GMA c=
ommand which should only be called
> once */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ndp->gma_flag =3D 1;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ops->ndo_set_mac_addre=
ss(ndev, &saddr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rtnl_lock();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D dev_set_mac_address(nd=
ev, &saddr, NULL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rtnl_unlock();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0netdev_warn(ndev, "NCSI: 'Writing mac address to
> device failed\n");
> =C2=A0

Greg, we had conversation in the past about this particular patchset
series:
https://www.spinics.net/lists/stable-commits/msg308587.html

Just one patch is not enough, I didn't test it either on linux kernel
version < 6.0 , also I saw the Sasha's commits about the same for 5.4,
5.10, 5.15 and answered to him about necessity of two patchsets instead
of one on 19 aug.

Thanks.
