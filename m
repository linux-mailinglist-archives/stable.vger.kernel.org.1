Return-Path: <stable+bounces-28162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3B87BEE6
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 15:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFDF1C21C81
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC35D464;
	Thu, 14 Mar 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBT/fG+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE71DFE4;
	Thu, 14 Mar 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426653; cv=none; b=tRKp/uY+NHZhCWBKNBUSy31fSUB7D78D5hZtH0+3MPPvIkryphxOe4UUfBfPsLCNlVdTPCakgtIGzQbH5EzWs3q+iWWtR1XR+/xc4eHhcZZARuDvcq5vCWKDhPYGKr7zbJ3H7BRWKd20oAfSZsEDOGX/YNx9CyCffbZi4fpPmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426653; c=relaxed/simple;
	bh=nOgzAl/kZbPiswgz+PAekV21T21wnBeyrjRSsKn26CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/+otjJiH/bme1P/LDQt/a41eRD+2ReXhMpFBB8TqugdewR+SqZOjl7Cf0iOZwmCJNc0G6wi09HxnXmbGeUfFqMcN5h+soX323CymojDn+DDey1+RUD8dtdntHeH7k3w+5fwQHkgK/2aksIgok2Zug7tzkbftaOw6nPtSemqcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBT/fG+U; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d228a132acso13445281fa.0;
        Thu, 14 Mar 2024 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710426649; x=1711031449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGuFdLL2A0SVLqEVBpXHYOjMN8ZFaFaJtzrBQiA78yk=;
        b=IBT/fG+UoTGoay0EmebQKsLd1xnBhTWvqPbC+Ld2KDKjmQWzSHFE3NXO7nRGD8Y+nu
         cvnTXg19e/a26VGLCOY/pw9UwxzYcNuUP00P2+nsrmx0PziyDX3gwuUhFUGKLm4jrQk7
         byGEyUl7aaCNuuDuno6L4bica3IfLiNSejkHOUwatxldkQVUKHRg9CsHHHaaOflWTkKH
         /VOhrlxh93eAkaqAhLJa3FJTxU/yN52ZMw2hi7t9yEREj89kEerdPjD1rVrVrWRNEhsm
         a9CAXK7K23PuLR7GgrQpAX4SkdijIFEugKUu0YEMqZWS/B7Gk+bTuiMx0Sd1iEYz5IC1
         PrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426649; x=1711031449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGuFdLL2A0SVLqEVBpXHYOjMN8ZFaFaJtzrBQiA78yk=;
        b=bnTVt2Hdx2LveYr1gSPXy2yef1WcsdiB8FSpxknbjMmXwh/N3J2yB8sF32VelyTjpi
         lWOv+MtCAYbNxgT4QBK6CZ0+V1Dyp+j2wWSUF4rAk5H7K5sBAevTVbmAekCpjnabiokz
         G1HfvU0Er1V7WSqfdP4EQgRHZTu2pK1c2D8CYOy1fKOsY7FRyipYFXRNaXH9Nf5KYT72
         FTsmoBWr1VKtQbybsu1iJmPO7gsB7mUqI6odOTw5XBJvI0fmECagMtNRBF8/nCTdM/jK
         XxsmCBdayXhVPu6dXRIQ6gc2FjX89YnScFdiKkV76I70+IbOZBTKfcFE7BW9gB2j1nNA
         fnFA==
X-Forwarded-Encrypted: i=1; AJvYcCWI8a+8f3UFeoYA8C5bpCDr/rqWQ0RaW6M6f+U4A/rm4q03X2KvlB2KyADx3LbkzGbOTJhkqJQVpeah2+nR23SLQEJsY3bMN3y4arXLjWyysmSrF6tyMtrqnReSKRQpr3n1kCPWrVwcF7/qW4zInizHnialfPewlG5H8eC6e84qBLEBt7a6
X-Gm-Message-State: AOJu0YyraJt+7zESLGLiIsD5a/mIyPXvUwVkP3X9bKjTR27d9+Wm//tV
	SSIy/jX33Y+Y5BKMUcVu2EkOef4Y1r/mCoR2LE/2KW6bjmr3d2sAeLHYfMQv1xvDY7ys9GLBq0b
	s+C6dlrFIuJ0e96TtxF0KtPdztgRCKQTj
X-Google-Smtp-Source: AGHT+IEuwoDwnTWhjt/JkLKa02QILhgzuO/FfliJLD2dXLjPQ9EXst9r8FPLjaypVgQWKhFpurrnVj3WvXCN81+5+3I=
X-Received: by 2002:a2e:a592:0:b0:2d4:6815:fc6f with SMTP id
 m18-20020a2ea592000000b002d46815fc6fmr1554846ljp.30.1710426649071; Thu, 14
 Mar 2024 07:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084412.1127-1-johan+linaro@kernel.org>
In-Reply-To: <20240314084412.1127-1-johan+linaro@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Mar 2024 10:30:36 -0400
Message-ID: <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Thu, Mar 14, 2024 at 4:44=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
>
> Qualcomm Bluetooth controllers like WCN6855 do not have persistent
> storage for the Bluetooth address and must therefore start as
> unconfigured to allow the user to set a valid address unless one has
> been provided by the boot firmware in the devicetree.
>
> A recent change snuck into v6.8-rc7 and incorrectly started marking the
> default (non-unique) address as valid. This specifically also breaks the
> Bluetooth setup for some user of the Lenovo ThinkPad X13s.
>
> Note that this is the second time Qualcomm breaks the driver this way
> and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
> fix use-bdaddr-property quirk"), which also has some further details.
>
> Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exi=
sts in DT")
> Cc: stable@vger.kernel.org      # 6.8
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Well I guess I will need to start asking for evidence that this works
on regular Linux distros then, because it looks like that is not the
environment Janaki and others Qualcomm folks are testing with.

What I probably would consider as evidence is bluetoothd logs showing
that the controller has been configured correctly or perhaps there is
a simpler way?

> ---
>  drivers/bluetooth/hci_qca.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index edd2a81b4d5e..f989c05f8177 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -7,7 +7,6 @@
>   *
>   *  Copyright (C) 2007 Texas Instruments, Inc.
>   *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights rese=
rved.
> - *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reser=
ved.
>   *
>   *  Acknowledgements:
>   *  This file is based on hci_ll.c, which was...
> @@ -1904,17 +1903,7 @@ static int qca_setup(struct hci_uart *hu)
>         case QCA_WCN6750:
>         case QCA_WCN6855:
>         case QCA_WCN7850:
> -
> -               /* Set BDA quirk bit for reading BDA value from fwnode pr=
operty
> -                * only if that property exist in DT.
> -                */
> -               if (fwnode_property_present(dev_fwnode(hdev->dev.parent),=
 "local-bd-address")) {
> -                       set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->qui=
rks);
> -                       bt_dev_info(hdev, "setting quirk bit to read BDA =
from fwnode later");
> -               } else {
> -                       bt_dev_dbg(hdev, "local-bd-address` is not presen=
t in the devicetree so not setting quirk bit for BDA");
> -               }
> -
> +               set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>                 hci_set_aosp_capable(hdev);
>
>                 ret =3D qca_read_soc_version(hdev, &ver, soc_type);
> --
> 2.43.2
>


--=20
Luiz Augusto von Dentz

