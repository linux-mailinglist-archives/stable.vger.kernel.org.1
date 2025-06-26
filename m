Return-Path: <stable+bounces-158689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC6AAE9DF0
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 14:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BE01730E8
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9732E541F;
	Thu, 26 Jun 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT51aSI6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CD2E1729;
	Thu, 26 Jun 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942659; cv=none; b=HARNagRvJP2f1JAM745CkUCD3ZY5/9Uz3cHso8IqDOJu4HPnMobLLwpWw2JlV/VcyRCZ1mEnbWnCPmk1RJjRfJcrX6lNdahkno19SyZLBazW8BzY7HWCl2HoJ+b8UuqAhkFiHeI7JXZJoLs2/nbXgaz156Q9X+V3s0yy2eHdRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942659; c=relaxed/simple;
	bh=Z5XIQXQlazJbc/jPqjX37W6puWm6Ny0RQLBxIS6zP9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DInjxeROLlQTpr/FITcnrmWE/lT30JXi0Dn15RdA0go6ZwfId56ehf1yKSVXxPW3vt6Lo2oE/szZBSLT3JTWAtPhi54BH2vTklk8xeaVrMxFOlw0PBCTt3GINwqXIqL6qBZVHLMdtmFgHC0d31eUE6aUOJqsBMddvjojUvZoQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT51aSI6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32addf54a00so7793281fa.1;
        Thu, 26 Jun 2025 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750942655; x=1751547455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbDBF1m4ND8ODEViRH7eWaeCoVkwsjO8vjNuWncwojs=;
        b=nT51aSI6bIDaE6LQVthN9Uv6ONBsZlAsM193v/vA/ZpkDTZj70iD+rl3uD9W6/N+fG
         EAMS+UDfI25GZ0pRyK764WNgydAGGFyvW3pxLkyP59LuhX6upu3cIH5ENc2+rjlpDIY9
         u5O4HBIcqzJjSDxN5uM0IEFQlJwuL/TJ9wQ82UEwu08S2ocGMhuvhiSFSKmYbbidWj9F
         gv4E5/Jfn4MBj8GVe88GUVzjUklvPu1i9Ax+mko918PBSaXdCQXTS8u6KKcQsbg/9REU
         exciRbpOyC5nfIIu3zTVVorLygS3cUVMy/BxguLymRgxiCvYZrBkOlpdkOCQPorwM8PL
         R1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750942655; x=1751547455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbDBF1m4ND8ODEViRH7eWaeCoVkwsjO8vjNuWncwojs=;
        b=PzAXrubu1iw6tsx5kShaOltZLbWZaXP3zpMAoCHnKqirqiEUA6/wJ4hrvnoG9JIraH
         DNBtZgIWaFMtCKdoeFabhx/dy1d5OraPWCgRdmRPP3kecfR8wrVMXNvOJmCjluFpM/r1
         8Gxjh2bjVhCJ8rYbDgROtnSrUiM5zWAMvK5I+zGsogMF+GAd0FWsCZQuDDP/OvdOLu9I
         KhPjxscNo+3bDJW9xBENXRD0XYXtzt/RCz5UwWb301/UsOiQaD1Ods2rb2rgSYBuWKwQ
         LU2ftyDS4v80kt0yo5EloOBWYZelx7kNI+14Mp1oVaWewGCH5jK37IunEZ55HF+l1Gpm
         8XxA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Ft8RoAdArsTW9mypwj17w4SGwbRhTcSjlkhINuiOgsovJgvByooT0EHPVMc2z/aWjhKHfnwU@vger.kernel.org, AJvYcCVIqcTlwGvR0uak3sEB6VRmW61LPGuwOw7c4+9+c2p9Gm1Qfl6Kwlsu/J8nWHaA+5mU4HdZb581@vger.kernel.org, AJvYcCW/fVOTrWGp5c3ggKhDKSl7tq4vkCdRNG9mSD4h2EpxeQcchUHY89ze6XYxopT1Ddy3JW5al1fDVYZKJwT5t9Y=@vger.kernel.org, AJvYcCWIi2LxRg5rqmAZeH2gQA1d2UnoWKj7PpueEAAk1PwiaeBIDaye5AniGBe3YAQc1GXQ1lICHfxzkSW6RXdn@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcFDMXBx+XF2uz1ENevHdgwqfAUz8+E+ew1HG18LMUxfNnYPb
	to+6LtuiIifN7f7PtHUo3xxXDsZ7cN4fYBJojUPBgSFYOACa8q2zvhVQfnm9UV8qrU+w7DNByss
	o6WcNbBqqzuS/o4s3T9/3Eks0rQzt35g2KGMX8U0Jcw==
X-Gm-Gg: ASbGncu4W9LJ1Siy8xLcrOFLXNm1pFWDzr4DEgnLxI9EmT8HXzTaQyoJbuaYEO6zFGv
	BzAEl8kOj6DtnOESHI6VQ7SSGmi53GUN7kALLYILfmo8CsKCdpBSEo0toVgpSYcdpMP1aym9JrT
	J72fjVDtvFYZzBwirp7v0ujqBp5PWK83q1WAEMxSbslg==
X-Google-Smtp-Source: AGHT+IF2Wqjq+z5Kekhx8NTddyZTPh0HFQb8SRZurjGuP33M/t0OWBh1RC07DUJS9Qf8Npu4yJAd8K2ViTlWgwhM72s=
X-Received: by 2002:a05:651c:3045:b0:32b:7165:d0 with SMTP id
 38308e7fff4ca-32cc643d074mr16874431fa.10.1750942654696; Thu, 26 Jun 2025
 05:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626115209.17839-1-ceggers@arri.de>
In-Reply-To: <20250626115209.17839-1-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Jun 2025 08:57:22 -0400
X-Gm-Features: Ac12FXwbphIiiUdCuEqIOLqT54dhAb91jK5k-PvTjulolO7Gvgbeo-8mmls3-Gg
Message-ID: <CABBYNZLfDqh=49qtC2M6F+f+rmgZ-hQGnABseqWyk0H4QDGTqQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: HCI: Set extended advertising data synchronously
To: Christian Eggers <ceggers@arri.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, Jun 26, 2025 at 7:52=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Currently, for controllers with extended advertising, the advertising
> data is set in the asynchronous response handler for extended
> adverstising params. As most advertising settings are performed in a
> synchronous context, the (asynchronous) setting of the advertising data
> is done too late (after enabling the advertising).
>
> Move setting of adverstising data from asynchronous response handler
> into synchronous context to fix ordering of HCI commands.
>
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if control=
ler supports")
> Cc: stable@vger.kernel.org
> v1: https://lore.kernel.org/linux-bluetooth/20250625130510.18382-1-cegger=
s@arri.de/
> ---
> v2: convert setting of adv data into synchronous context (rather than mov=
ing
> more methods into asynchronous response handlers).
> - hci_set_ext_adv_params_sync: new method
> - hci_set_ext_adv_data_sync: move within source file (no changes)
> - hci_set_adv_data_sync: dito
> - hci_update_adv_data_sync: dito
> - hci_cc_set_ext_adv_param: remove (performed synchronously now)
>
> On Wednesday, 25 June 2025, 15:26:58 CEST, Luiz Augusto von Dentz wrote:
> > That said for the likes of MGMT_OP_ADD_EXT_ADV_DATA you will still
> > need to detect if the instance has already been enabled then do
> > disable/re-enable logic if the quirk is set.
>
> The critical opcode (HCI_OP_LE_SET_EXT_ADV_DATA) is only used in
> hci_set_ext_adv_data_sync(). Two of the callers already ensure that
> the advertising instance is disabled, so only hci_update_adv_data_sync()
> may need a quirk. I suggest doing this in a separate patch.
>
> regards,
> Christian
>
>  net/bluetooth/hci_event.c |  36 -------
>  net/bluetooth/hci_sync.c  | 209 ++++++++++++++++++++++++--------------
>  2 files changed, 132 insertions(+), 113 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..4d5ace9d245d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2150,40 +2150,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *hde=
v, void *data,
>         return rp->status;
>  }
>
> -static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
> -                                  struct sk_buff *skb)
> -{
> -       struct hci_rp_le_set_ext_adv_params *rp =3D data;
> -       struct hci_cp_le_set_ext_adv_params *cp;
> -       struct adv_info *adv_instance;
> -
> -       bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> -
> -       if (rp->status)
> -               return rp->status;
> -
> -       cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
> -       if (!cp)
> -               return rp->status;
> -
> -       hci_dev_lock(hdev);
> -       hdev->adv_addr_type =3D cp->own_addr_type;
> -       if (!cp->handle) {
> -               /* Store in hdev for instance 0 */
> -               hdev->adv_tx_power =3D rp->tx_power;
> -       } else {
> -               adv_instance =3D hci_find_adv_instance(hdev, cp->handle);
> -               if (adv_instance)
> -                       adv_instance->tx_power =3D rp->tx_power;
> -       }
> -       /* Update adv data as tx power is known now */
> -       hci_update_adv_data(hdev, cp->handle);
> -
> -       hci_dev_unlock(hdev);
> -
> -       return rp->status;
> -}
> -
>  static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
>                            struct sk_buff *skb)
>  {
> @@ -4164,8 +4130,6 @@ static const struct hci_cc {
>         HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
>                hci_cc_le_read_num_adv_sets,
>                sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> -       HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
> -              sizeof(struct hci_rp_le_set_ext_adv_params)),
>         HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
>                       hci_cc_le_set_ext_adv_enable),
>         HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 1f8806dfa556..2a09b2cb983e 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1205,9 +1205,116 @@ static int hci_set_adv_set_random_addr_sync(struc=
t hci_dev *hdev, u8 instance,
>                                      sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>  }
>
> +static int
> +hci_set_ext_adv_params_sync(struct hci_dev *hdev,
> +                           const struct hci_cp_le_set_ext_adv_params *cp=
,
> +                           struct hci_rp_le_set_ext_adv_params *rp)
> +{
> +       struct sk_buff *skb;
> +
> +       skb =3D __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof=
(*cp),
> +                            cp, HCI_CMD_TIMEOUT);
> +
> +       /* If command return a status event, skb will be set to -ENODATA =
*/
> +       if (skb =3D=3D ERR_PTR(-ENODATA))
> +               return 0;
> +
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld",
> +                          HCI_OP_LE_SET_EXT_ADV_PARAMS, PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +
> +       if (skb->len !=3D sizeof(*rp)) {
> +               bt_dev_err(hdev, "Invalid response length for "
> +                          "HCI_OP_LE_SET_EXT_ADV_PARAMS: %u", skb->len);
> +               kfree_skb(skb);
> +               return -EIO;
> +       }
> +
> +       memcpy(rp, skb->data, sizeof(*rp));
> +       kfree_skb(skb);
> +
> +       return rp->status;
> +}
> +
> +static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +{
> +       DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> +                   HCI_MAX_EXT_AD_LENGTH);
> +       u8 len;
> +       struct adv_info *adv =3D NULL;
> +       int err;
> +
> +       if (instance) {
> +               adv =3D hci_find_adv_instance(hdev, instance);
> +               if (!adv || !adv->adv_data_changed)
> +                       return 0;
> +       }
> +
> +       len =3D eir_create_adv_data(hdev, instance, pdu->data,
> +                                 HCI_MAX_EXT_AD_LENGTH);
> +
> +       pdu->length =3D len;
> +       pdu->handle =3D adv ? adv->handle : instance;
> +       pdu->operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> +       pdu->frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> +
> +       err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> +                                   struct_size(pdu, data, len), pdu,
> +                                   HCI_CMD_TIMEOUT);
> +       if (err)
> +               return err;
> +
> +       /* Update data if the command succeed */
> +       if (adv) {
> +               adv->adv_data_changed =3D false;
> +       } else {
> +               memcpy(hdev->adv_data, pdu->data, len);
> +               hdev->adv_data_len =3D len;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +{
> +       struct hci_cp_le_set_adv_data cp;
> +       u8 len;
> +
> +       memset(&cp, 0, sizeof(cp));
> +
> +       len =3D eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.da=
ta));
> +
> +       /* There's nothing to do if the data hasn't changed */
> +       if (hdev->adv_data_len =3D=3D len &&
> +           memcmp(cp.data, hdev->adv_data, len) =3D=3D 0)
> +               return 0;
> +
> +       memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> +       hdev->adv_data_len =3D len;
> +
> +       cp.length =3D len;
> +
> +       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +{
> +       if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> +               return 0;
> +
> +       if (ext_adv_capable(hdev))
> +               return hci_set_ext_adv_data_sync(hdev, instance);
> +
> +       return hci_set_adv_data_sync(hdev, instance);
> +}
> +
>  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
>  {
>         struct hci_cp_le_set_ext_adv_params cp;
> +       struct hci_rp_le_set_ext_adv_params rp;
>         bool connectable;
>         u32 flags;
>         bdaddr_t random_addr;
> @@ -1316,8 +1423,20 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev=
 *hdev, u8 instance)
>                 cp.secondary_phy =3D HCI_ADV_PHY_1M;
>         }
>
> -       err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
> -                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +       err =3D hci_set_ext_adv_params_sync(hdev, &cp, &rp);
> +       if (err)
> +               return err;
> +
> +       hdev->adv_addr_type =3D own_addr_type;
> +       if (!cp.handle) {
> +               /* Store in hdev for instance 0 */
> +               hdev->adv_tx_power =3D rp.tx_power;
> +       } else if (adv) {
> +               adv->tx_power =3D rp.tx_power;
> +       }

We can probably move the above code into hci_set_ext_adv_params_sync
so we guarantee the tx_power is updated whenever it is used, if there
are differences between the likes of directed advertisements, etc,
that can probably be handled internally as well, although I think it
doesn't seem to need a special handling since we restrict directected
advertisements to handle 0x00 only.

> +       /* Update adv data as tx power is known now */
> +       err =3D hci_set_ext_adv_data_sync(hdev, cp.handle);
>         if (err)
>                 return err;
>
> @@ -1822,79 +1941,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev=
, u8 handle, u8 reason)
>                                      sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>  }
>
> -static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
> -{
> -       DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> -                   HCI_MAX_EXT_AD_LENGTH);
> -       u8 len;
> -       struct adv_info *adv =3D NULL;
> -       int err;
> -
> -       if (instance) {
> -               adv =3D hci_find_adv_instance(hdev, instance);
> -               if (!adv || !adv->adv_data_changed)
> -                       return 0;
> -       }
> -
> -       len =3D eir_create_adv_data(hdev, instance, pdu->data,
> -                                 HCI_MAX_EXT_AD_LENGTH);
> -
> -       pdu->length =3D len;
> -       pdu->handle =3D adv ? adv->handle : instance;
> -       pdu->operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> -       pdu->frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> -
> -       err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> -                                   struct_size(pdu, data, len), pdu,
> -                                   HCI_CMD_TIMEOUT);
> -       if (err)
> -               return err;
> -
> -       /* Update data if the command succeed */
> -       if (adv) {
> -               adv->adv_data_changed =3D false;
> -       } else {
> -               memcpy(hdev->adv_data, pdu->data, len);
> -               hdev->adv_data_len =3D len;
> -       }
> -
> -       return 0;
> -}
> -
> -static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> -{
> -       struct hci_cp_le_set_adv_data cp;
> -       u8 len;
> -
> -       memset(&cp, 0, sizeof(cp));
> -
> -       len =3D eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.da=
ta));
> -
> -       /* There's nothing to do if the data hasn't changed */
> -       if (hdev->adv_data_len =3D=3D len &&
> -           memcmp(cp.data, hdev->adv_data, len) =3D=3D 0)
> -               return 0;
> -
> -       memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> -       hdev->adv_data_len =3D len;
> -
> -       cp.length =3D len;
> -
> -       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> -                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> -}
> -
> -int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> -{
> -       if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> -               return 0;
> -
> -       if (ext_adv_capable(hdev))
> -               return hci_set_ext_adv_data_sync(hdev, instance);
> -
> -       return hci_set_adv_data_sync(hdev, instance);
> -}
> -
>  int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
>                                    bool force)
>  {
> @@ -6269,6 +6315,7 @@ static int hci_le_ext_directed_advertising_sync(str=
uct hci_dev *hdev,
>                                                 struct hci_conn *conn)
>  {
>         struct hci_cp_le_set_ext_adv_params cp;
> +       struct hci_rp_le_set_ext_adv_params rp;
>         int err;
>         bdaddr_t random_addr;
>         u8 own_addr_type;
> @@ -6310,8 +6357,16 @@ static int hci_le_ext_directed_advertising_sync(st=
ruct hci_dev *hdev,
>         if (err)
>                 return err;
>
> -       err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
> -                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +       err =3D hci_set_ext_adv_params_sync(hdev, &cp, &rp);
> +       if (err)
> +               return err;
> +
> +       hdev->adv_addr_type =3D own_addr_type;
> +       /* Store in hdev for instance 0 */
> +       hdev->adv_tx_power =3D rp.tx_power;
> +
> +       /* Update adv data as tx power is known now */
> +       err =3D hci_set_ext_adv_data_sync(hdev, cp.handle);
>         if (err)
>                 return err;
>
> --
> 2.44.1
>


--=20
Luiz Augusto von Dentz

