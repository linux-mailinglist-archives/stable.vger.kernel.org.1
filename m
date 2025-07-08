Return-Path: <stable+bounces-160523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674AAAFCFD2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4B16A8F9
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99D2E264F;
	Tue,  8 Jul 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da03IRrU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0591A288;
	Tue,  8 Jul 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990185; cv=none; b=upLvH2Va0qCdtGjbdOxlByQ2ZO+Poxbo+MXEBMfF1arIDfJkIOB5EvtxH1Hzk3YM8Y4G4WUMBQ7KqhQYpQEjSIi6WQ907PpOy7ypST7zAuUGDbNnh43uQNpb2q6swFV7TzwOPFbr4d+dIGaXh+4KVBsFxWXtTI1ShgeBmWguc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990185; c=relaxed/simple;
	bh=V7T1glrCop5gC48ERB4gfbupb1+pJNqx0UusVo8v0jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlCPe+vY3Dw5OMlJP9l/nJ0kLwIj5++7UJhUP76fjVo9a95S4G8qkBryuqkPFrfliDW5JO+LpWEFx1/kuQRPnIVY88Q/4A1vGvFmKc3veMlic0wrLZrxXHvN4jzgjs4Q/EIjted0U+9Bq9l2UJHKaFsfHY3BJG0uXQgsYknjbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da03IRrU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so37009451fa.0;
        Tue, 08 Jul 2025 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751990181; x=1752594981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxVeflfzBX9rJCROGCxMNNBHf1lqkI/X1ZIeU6W3cOU=;
        b=Da03IRrURIDMWfTwOUfiF8scn8sqkAipyBxevshgGf4JRfL8jfF3x4NDoqizEoYdaZ
         LUYbTfVXF5tdUDjHy7eBRnT8go47knev84uXrFlmGRIUwOdcW1ElQ6vDXNOE6PNK7szy
         Q0/NXrKoFz4GQ2sg5ZA9+A/i6GezY3MbslPCiwI0qvqVD5ePw6IrWV9j18aR5AT+K6Vt
         3lLuU+hWUSAVCZu/2MykxO5mw2gpOjT14wlpyJ99ZkqwBe4x9On2OUTawNtAYKLsnMQC
         7n0p/W7j7cgk4ACT7vahsY8mwwPvc8t/Mm9zlL2BcrTmpZ7YGKRNiyWLNkHFeVm6yXeW
         t9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990181; x=1752594981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxVeflfzBX9rJCROGCxMNNBHf1lqkI/X1ZIeU6W3cOU=;
        b=APTOm/fiGBKHqRjzMINu/DX5YbrNcu2mWX1+wRCbNzvLqle023Xcf8bf7cBgG5saGt
         Oqc0PGI+i0yxYgUvGDqRBluEFU+I6Z5rOVcB0s5CueIuU3Mhezwy5dg6O/32/ePGVowI
         xSBn+KeamiO6GuMqya5HgBEvUOA9cgyN0OqwiO9iPyWoF3b0bSZ+g6aSLZtpyyzVZbRo
         uzgV1+xmADaw1uznqaweu2oofrcdf8/q5SoUty9VcnEfRVzeGq9tPT0PObVhC+c5tiLR
         3JNt4GQZ2tW6FwWpnKqhYQV2V06QirOhAMXOilQcYXAAqp0oK9J1uERysDmfP8Y9palQ
         M+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpFZT4cQH+bRsZSFwkWlS069IkG0IP5NCQRKFPt7PgjbojJD3imVUIDtrdwwOudqyjIcUyT5Ld@vger.kernel.org, AJvYcCX7b5o5C2ycIqVdTSvap4g8+1YIVF3NR5JfJJu8okAdIXmcCYtbW0vW6XhpPQ2kc5XfCfQhPYJWe7x9ma/hncs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBeQRYpSfx3OBWfpnkbOSJQTfZryJjXNs5reWzGs6dDOLvoQzK
	KVWn9ewAriWSMiq0P9uiQyEeKMTpReUKK/JnTqRtx4EJMsuDGSGSf8+bpOsMn1W2iNIRsy/mv2M
	Ocl3ehnJ1rnN0nde5IS5YCp1p1oCwNlw=
X-Gm-Gg: ASbGncttRGtv05WgVSS7urab00OzI2z3kzbzdTw1O14NPwKKTlbauq5fb9u7NnE83hU
	WbX50sfp5ss6kNydvu/KnuYhJVebQ7YbWOUAmRim5JmcfG5m90TfXqhbXWXozGWXMvrd7q4+wKZ
	oWFwDL+RO8ewbxZuEW37dZ7VoP/cHsLO1lzl6oJOksuQ==
X-Google-Smtp-Source: AGHT+IFIsb7jA9cwNja44+IqMZNzZlGZmmaOAVfwvGx/KNv0bNPt/LJzG+6zy8KbUen+Iwr6o3pneIGxi/gQWOnMAZM=
X-Received: by 2002:a05:651c:2149:b0:32a:87ba:42b5 with SMTP id
 38308e7fff4ca-32e5f59b7f3mr30886861fa.17.1751990180946; Tue, 08 Jul 2025
 08:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025070625-wafer-speed-20c1@gregkh> <20250707081306.22624-2-ceggers@arri.de>
 <2025070807-dimple-radish-723b@gregkh>
In-Reply-To: <2025070807-dimple-radish-723b@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 11:56:07 -0400
X-Gm-Features: Ac12FXx2CAxiI8xtD64RYrTC2dxxHZzN9HNkMIqTU4177RecJ3ZOP6vm-2b8iXA
Message-ID: <CABBYNZJKGkqU0=Wt9mWurhw9zL=np-NPhpCDFh_aN2Y-i0ZkRw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: HCI: Set extended advertising data synchronously
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Eggers <ceggers@arri.de>, stable@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Jul 8, 2025 at 11:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jul 07, 2025 at 10:13:07AM +0200, Christian Eggers wrote:
> > Upstream commit 89fb8acc38852116d38d721ad394aad7f2871670
> >
> > Currently, for controllers with extended advertising, the advertising
> > data is set in the asynchronous response handler for extended
> > adverstising params. As most advertising settings are performed in a
> > synchronous context, the (asynchronous) setting of the advertising data
> > is done too late (after enabling the advertising).
> >
> > Move setting of adverstising data from asynchronous response handler
> > into synchronous context to fix ordering of HCI commands.
> >
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if contr=
oller supports")
> > Cc: stable@vger.kernel.org
> > v2: https://lore.kernel.org/linux-bluetooth/20250626115209.17839-1-cegg=
ers@arri.de/
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_event.c |  36 -------
> >  net/bluetooth/hci_sync.c  | 213 ++++++++++++++++++++++++--------------
> >  2 files changed, 133 insertions(+), 116 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 008d14b3d8b8..147766458a6c 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2139,40 +2139,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *h=
dev, void *data,
> >       return rp->status;
> >  }
> >
> > -static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
> > -                                struct sk_buff *skb)
> > -{
> > -     struct hci_rp_le_set_ext_adv_params *rp =3D data;
> > -     struct hci_cp_le_set_ext_adv_params *cp;
> > -     struct adv_info *adv_instance;
> > -
> > -     bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> > -
> > -     if (rp->status)
> > -             return rp->status;
> > -
> > -     cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
> > -     if (!cp)
> > -             return rp->status;
> > -
> > -     hci_dev_lock(hdev);
> > -     hdev->adv_addr_type =3D cp->own_addr_type;
> > -     if (!cp->handle) {
> > -             /* Store in hdev for instance 0 */
> > -             hdev->adv_tx_power =3D rp->tx_power;
> > -     } else {
> > -             adv_instance =3D hci_find_adv_instance(hdev, cp->handle);
> > -             if (adv_instance)
> > -                     adv_instance->tx_power =3D rp->tx_power;
> > -     }
> > -     /* Update adv data as tx power is known now */
> > -     hci_update_adv_data(hdev, cp->handle);
> > -
> > -     hci_dev_unlock(hdev);
> > -
> > -     return rp->status;
> > -}
> > -
> >  static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
> >                          struct sk_buff *skb)
> >  {
> > @@ -4153,8 +4119,6 @@ static const struct hci_cc {
> >       HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
> >              hci_cc_le_read_num_adv_sets,
> >              sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> > -     HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
> > -            sizeof(struct hci_rp_le_set_ext_adv_params)),
> >       HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
> >                     hci_cc_le_set_ext_adv_enable),
> >       HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index e92bc4ceb5ad..7b6c8f53e334 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -1224,9 +1224,129 @@ static int hci_set_adv_set_random_addr_sync(str=
uct hci_dev *hdev, u8 instance,
> >                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >  }
> >
> > +static int
> > +hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv=
,
> > +                         const struct hci_cp_le_set_ext_adv_params *cp=
,
> > +                         struct hci_rp_le_set_ext_adv_params *rp)
> > +{
> > +     struct sk_buff *skb;
> > +
> > +     skb =3D __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof=
(*cp),
> > +                          cp, HCI_CMD_TIMEOUT);
> > +
> > +     /* If command return a status event, skb will be set to -ENODATA =
*/
> > +     if (skb =3D=3D ERR_PTR(-ENODATA))
> > +             return 0;
> > +
> > +     if (IS_ERR(skb)) {
> > +             bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld",
> > +                        HCI_OP_LE_SET_EXT_ADV_PARAMS, PTR_ERR(skb));
> > +             return PTR_ERR(skb);
> > +     }
> > +
> > +     if (skb->len !=3D sizeof(*rp)) {
> > +             bt_dev_err(hdev, "Invalid response length for 0x%4.4x: %u=
",
> > +                        HCI_OP_LE_SET_EXT_ADV_PARAMS, skb->len);
> > +             kfree_skb(skb);
> > +             return -EIO;
> > +     }
> > +
> > +     memcpy(rp, skb->data, sizeof(*rp));
> > +     kfree_skb(skb);
> > +
> > +     if (!rp->status) {
> > +             hdev->adv_addr_type =3D cp->own_addr_type;
> > +             if (!cp->handle) {
> > +                     /* Store in hdev for instance 0 */
> > +                     hdev->adv_tx_power =3D rp->tx_power;
> > +             } else if (adv) {
> > +                     adv->tx_power =3D rp->tx_power;
> > +             }
> > +     }
> > +
> > +     return rp->status;
> > +}
> > +
> > +static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance=
)
> > +{
> > +     struct {
> > +             struct hci_cp_le_set_ext_adv_data cp;
> > +             u8 data[HCI_MAX_EXT_AD_LENGTH];
> > +     } pdu;
> > +     u8 len;
> > +     struct adv_info *adv =3D NULL;
> > +     int err;
> > +
> > +     memset(&pdu, 0, sizeof(pdu));
> > +
> > +     if (instance) {
> > +             adv =3D hci_find_adv_instance(hdev, instance);
> > +             if (!adv || !adv->adv_data_changed)
> > +                     return 0;
> > +     }
> > +
> > +     len =3D eir_create_adv_data(hdev, instance, pdu.data);
> > +
> > +     pdu.cp.length =3D len;
> > +     pdu.cp.handle =3D instance;
> > +     pdu.cp.operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> > +     pdu.cp.frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> > +
> > +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> > +                                 sizeof(pdu.cp) + len, &pdu.cp,
> > +                                 HCI_CMD_TIMEOUT);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Update data if the command succeed */
> > +     if (adv) {
> > +             adv->adv_data_changed =3D false;
> > +     } else {
> > +             memcpy(hdev->adv_data, pdu.data, len);
> > +             hdev->adv_data_len =3D len;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > +{
> > +     struct hci_cp_le_set_adv_data cp;
> > +     u8 len;
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +
> > +     len =3D eir_create_adv_data(hdev, instance, cp.data);
> > +
> > +     /* There's nothing to do if the data hasn't changed */
> > +     if (hdev->adv_data_len =3D=3D len &&
> > +         memcmp(cp.data, hdev->adv_data, len) =3D=3D 0)
> > +             return 0;
> > +
> > +     memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> > +     hdev->adv_data_len =3D len;
> > +
> > +     cp.length =3D len;
> > +
> > +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> > +                                  sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +}
> > +
> > +int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > +{
> > +     if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> > +             return 0;
> > +
> > +     if (ext_adv_capable(hdev))
> > +             return hci_set_ext_adv_data_sync(hdev, instance);
> > +
> > +     return hci_set_adv_data_sync(hdev, instance);
> > +}
> > +
> >  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
> >  {
> >       struct hci_cp_le_set_ext_adv_params cp;
> > +     struct hci_rp_le_set_ext_adv_params rp;
> >       bool connectable;
> >       u32 flags;
> >       bdaddr_t random_addr;
> > @@ -1333,8 +1453,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_d=
ev *hdev, u8 instance)
> >               cp.secondary_phy =3D HCI_ADV_PHY_1M;
> >       }
> >
> > -     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
> > -                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +     err =3D hci_set_ext_adv_params_sync(hdev, adv, &cp, &rp);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Update adv data as tx power is known now */
> > +     err =3D hci_set_ext_adv_data_sync(hdev, cp.handle);
> >       if (err)
> >               return err;
> >
> > @@ -1859,82 +1983,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hd=
ev, u8 handle, u8 reason)
> >                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >  }
> >
> > -static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance=
)
> > -{
> > -     struct {
> > -             struct hci_cp_le_set_ext_adv_data cp;
> > -             u8 data[HCI_MAX_EXT_AD_LENGTH];
> > -     } pdu;
> > -     u8 len;
> > -     struct adv_info *adv =3D NULL;
> > -     int err;
> > -
> > -     memset(&pdu, 0, sizeof(pdu));
> > -
> > -     if (instance) {
> > -             adv =3D hci_find_adv_instance(hdev, instance);
> > -             if (!adv || !adv->adv_data_changed)
> > -                     return 0;
> > -     }
> > -
> > -     len =3D eir_create_adv_data(hdev, instance, pdu.data);
> > -
> > -     pdu.cp.length =3D len;
> > -     pdu.cp.handle =3D instance;
> > -     pdu.cp.operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> > -     pdu.cp.frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> > -
> > -     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> > -                                 sizeof(pdu.cp) + len, &pdu.cp,
> > -                                 HCI_CMD_TIMEOUT);
> > -     if (err)
> > -             return err;
> > -
> > -     /* Update data if the command succeed */
> > -     if (adv) {
> > -             adv->adv_data_changed =3D false;
> > -     } else {
> > -             memcpy(hdev->adv_data, pdu.data, len);
> > -             hdev->adv_data_len =3D len;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > -{
> > -     struct hci_cp_le_set_adv_data cp;
> > -     u8 len;
> > -
> > -     memset(&cp, 0, sizeof(cp));
> > -
> > -     len =3D eir_create_adv_data(hdev, instance, cp.data);
> > -
> > -     /* There's nothing to do if the data hasn't changed */
> > -     if (hdev->adv_data_len =3D=3D len &&
> > -         memcmp(cp.data, hdev->adv_data, len) =3D=3D 0)
> > -             return 0;
> > -
> > -     memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> > -     hdev->adv_data_len =3D len;
> > -
> > -     cp.length =3D len;
> > -
> > -     return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> > -                                  sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > -}
> > -
> > -int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > -{
> > -     if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> > -             return 0;
> > -
> > -     if (ext_adv_capable(hdev))
> > -             return hci_set_ext_adv_data_sync(hdev, instance);
> > -
> > -     return hci_set_adv_data_sync(hdev, instance);
> > -}
> > -
> >  int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
> >                                  bool force)
> >  {
> > @@ -6257,6 +6305,7 @@ static int hci_le_ext_directed_advertising_sync(s=
truct hci_dev *hdev,
> >                                               struct hci_conn *conn)
> >  {
> >       struct hci_cp_le_set_ext_adv_params cp;
> > +     struct hci_rp_le_set_ext_adv_params rp;
> >       int err;
> >       bdaddr_t random_addr;
> >       u8 own_addr_type;
> > @@ -6298,8 +6347,12 @@ static int hci_le_ext_directed_advertising_sync(=
struct hci_dev *hdev,
> >       if (err)
> >               return err;
> >
> > -     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
> > -                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +     err =3D hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Update adv data as tx power is known now */
> > +     err =3D hci_set_ext_adv_data_sync(hdev, cp.handle);
> >       if (err)
> >               return err;
> >
> > --
> > [Resend, upstream commit id was missing]
> >
> > Hi Greg,
> >
> > I've backported this patch for 6.6. There were some trivial merge
> > conflicts due to moved coded sections.
> >
> > Please try it also for older trees. If I get any FAILED notices,
> > I'll try to prepare patches for specific trees.
>
> You made major changes here from the upstream version, PLEASE document
> them properly in the changelog.  Also, can you test it to verify that it
> works and doesn't blow up the stack like I'm guessing it might?

@Christian Eggers try running resulting image with mgmt-tester and the
following tests:

Add Ext Advertising - Invalid Params 1 (Multiple Phys)
Add Ext Advertising - Invalid Params 2 (Multiple PHYs)
Add Ext Advertising - Invalid Params 3 (Multiple PHYs)
Add Ext Advertising - Invalid Params 4 (Multiple PHYs)
Add Ext Advertising - Success 1 (Powered, Add Adv Inst)
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst)
Add Ext Advertising - Success 3 (!Powered, Adv Enable)
Add Ext Advertising - Success 4 (Set Adv on override)
Add Ext Advertising - Success 5 (Set Adv off override)
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok)
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)
Add Ext Advertising - Success 8 (Connectable Flag)
Add Ext Advertising - Success 9 (General Discov Flag)
Add Ext Advertising - Success 10 (Limited Discov Flag)
Add Ext Advertising - Success 11 (Managed Flags)
Add Ext Advertising - Success 12 (TX Power Flag)
Add Ext Advertising - Success 13 (ADV_SCAN_IND)
Add Ext Advertising - Success 14 (ADV_NONCONN_IND)
Add Ext Advertising - Success 15 (ADV_IND)
Add Ext Advertising - Success 16 (Connectable -> on)
Add Ext Advertising - Success 17 (Connectable -> off)
Add Ext Advertising - Success 20 (Add Adv override)
Add Ext Advertising - Success 21 (Timeout expires)
Add Ext Advertising - Success 22 (LE -> off, Remove)
Add Ext Advertising - Success (Empty ScRsp)
Add Ext Advertising - Success (ScRsp only)
Add Ext Advertising - Invalid Params (ScRsp too long)
Add Ext Advertising - Success (ScRsp appear)
Add Ext Advertising - Invalid Params (ScRsp appear long)
Add Ext Advertising - Success (Appear is null)
Add Ext Advertising - Success (Name is null)
Add Ext Advertising - Success (Complete name)
Add Ext Advertising - Success (Shortened name)
Add Ext Advertising - Success (Short name)
Add Ext Advertising - Success (Name + data)
Add Ext Advertising - Invalid Params (Name + data)
Add Ext Advertising - Success (Name+data+appear)
Add Ext Advertising - Success (PHY -> 1M)
Add Ext Advertising - Success (PHY -> 2M)
Add Ext Advertising - Success (PHY -> Coded)
Add Ext Advertising - Success (Ext Pdu Scannable)
Add Ext Advertising - Success (Ext Pdu Connectable)
Add Ext Advertising - Success (Ext Pdu Conn Scan)
Add Ext Advertising - Success (1m Connectable -> on)
Add Ext Advertising - Success (1m Connectable -> off)

This should exercise the code you are changing, I assume they should
all pass with 6.6.y but perhaps you can discard if there were
something not passing since it can be the result of mgmt-tester
changes that are not backward compatible.

> thanks,
>
> greg k-h
>


--=20
Luiz Augusto von Dentz

