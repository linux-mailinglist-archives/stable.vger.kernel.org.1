Return-Path: <stable+bounces-158790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF914AEBBA3
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 17:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72C53AB02B
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123432E9745;
	Fri, 27 Jun 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHr93/B8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154D2E8DF1;
	Fri, 27 Jun 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037968; cv=none; b=RWsFEVxji34tZf3ZuUZfW94bQ+CKHQgxeC3x0Byud6SDCCR8hds9Dj02NyVmFiBE+B0tdJs9RUXe/eYrvRK8kM9m1GNreAV+OTMyQcLiPVe5Ye/fTuPHlyo+7k2ctuaNAD9Y4EQKb3cOayfpim54DVawXgtqH/S5bTTIw0Cn39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037968; c=relaxed/simple;
	bh=UW3Mrl01DO2jk/u65DmRXhVobAL5B70HH7dcQLiOq9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5wTmJ673bA6/Kzx/6mayMKp1W5oWtde8FbNLSkFWl3PmigMBnD7Y2w1ZZXZBx5KxkPwrizi3WybYMG734OIRScjHZJco5EQ/XkPBNi8Cp9zHQO+0VmcvR6WbtZ6iUQMyewBUC6ezlj0ZkbEk49or+3UqpeNQ8oEvNfAn2TEM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHr93/B8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so2623279a12.0;
        Fri, 27 Jun 2025 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751037966; x=1751642766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIWl+ebVZzHv6ydpcN8PbsabRPmxd3PaFqm6sShSn2s=;
        b=NHr93/B8K51Ab8B9ZsMOOMEccFfiQ5CaePB8IA5GZFUhIJTsYhdyZP52Iz0FTBHWKb
         b/tpqzaeqZCatGtV7WeAR8SSloUbWrOJcKdTmEjsObNCqOscabaAXDSdKaB0kd6CZZHo
         SUCjtFqVG9tykDRTZ1cO+dl9QpWKGwnoWilJg/zJaqfwoN/wkLsAfZN6dvOV4UBigbfN
         TpRR+5YCadDb/u4DXzoCRMRNNl3mA1vmpVoOStFckZQwH0ZzFgJs6NyWQj6fIpj8tEBc
         mtC/vKnuocUp+PHsPzidILHk7TJ7Yl9rdWAUBx861VfmEVc2kObKUnJzyuKeNxz7gcRT
         lZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037966; x=1751642766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIWl+ebVZzHv6ydpcN8PbsabRPmxd3PaFqm6sShSn2s=;
        b=mrBFfpL7tXXjOy238/G38CRcBmbFlnHHgGdwbsrxidA7qsd3gqxlQS5+VaylNVwu3t
         TFq7HTccP7wEOH3s0nTorgSi3KDTV4LuePkxy1anpzFBRFIi7VxSioJumRJ+UiI4nhYu
         MvZf6zmzV85B6/2ySZ3XIRw7Pjn6pzV/8Kb0kdEY2F5qryc5qHThfOao53nfUbFTVFUJ
         fMt0kw0MLFQKy2sdWe0gHhaNGXBm33Z25W2SD6pwu+daMh9tGQC6qWBFWhSNp/NaK5mY
         5JkipYGxn/UsQNcXG3CbFhbKrQm0G2W9zx1lDTMg3BS68TLF/BNwDocMieAZ4TTAlGGC
         ZKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUSqPVLNVq8UpMydaSMmqN5nZ6Sh1E6ZsrjV6cZDZyv8s8QdGO3/ojw03RhZefh5VctWZMsSUgYpvDccDJ1@vger.kernel.org, AJvYcCVxSuCke6ka5SJhoNrCoAmT86Aq1kVpbvjsdHVrlEJV5YEP90Kl+IdbeXRxQEIwiiG1LA9OKMlZ@vger.kernel.org, AJvYcCWuH46bchslHjBf+5Whf0HCJCHNV1MSCY9evajfQ5d2rs5O9UR+Z+jnjOP9RSRlvu8L7nO7lbiNL/yW0VSxGeg=@vger.kernel.org, AJvYcCXkFf/ccBNBOOK+pKB8mLVrcokQzGFULJHcYrb9eyNShu7aQIgjVT/edjJy9CQtH2izDACmeFPu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1j+ob6h/tUFTvPp/QoJe4zgT5Mv2V6hnGZ+KVnvhyrlkyaxK2
	9FQh6BeeHyfFGA5F63ugYDqMBEzUWrDlBxj6onoUhfDGA/b1YpTRsi1wDTEPogq3sJYxiDwspNv
	CnEb3KNwr9TdWvUEDVtVFpHKM7cxWxu0=
X-Gm-Gg: ASbGncux33fO2QNZrFlxqqWuasFuAiiQAOAjerO7QSBHcXY2kQeKWr2bJgWnkgQX5cG
	LeYp8litrhrzzBLILJQam/FfaOVja2YtZz+JI97ZK5o/3yCo7ck+fT3yymDqUK1cVwnJlULTFyd
	MX5PR/JfIcrR0k4PTBxi+q76/71X/Sh9LQ08ZreTp2yQ==
X-Google-Smtp-Source: AGHT+IG6omwbl4T8oCQvgn4QJ8FuRj2BklbKXGSk9uDsEXP89WXwjIyjmq2jFUVAp4eRwR7X+Q76KtkJLX80iEOL830=
X-Received: by 2002:a17:90b:28d0:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-318c9243c54mr5145588a91.20.1751037965952; Fri, 27 Jun 2025
 08:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627070508.13780-1-ceggers@arri.de> <4990184.OV4Wx5bFTl@n9w6sw14>
In-Reply-To: <4990184.OV4Wx5bFTl@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Jun 2025 11:25:50 -0400
X-Gm-Features: Ac12FXzHuXwtL1_aEL74mlbzVEZh2IEum4oWjA7pcCG_XVA--VJngY-13seWEzw
Message-ID: <CABBYNZL11npqO27DPjGz52X9zVD-5pqVwHEEVHY_aw1NH8GxjQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: HCI: Set extended advertising data synchronously
To: Christian Eggers <ceggers@arri.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Jun 27, 2025 at 6:09=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi Luiz,
>
> after changing my test setup (I now only use Mesh, no "normal" advertisin=
g
> anymore), I get many of these errors:
>
> bluetooth-meshd[276]: @ MGMT Command: Mesh Send (0x0059) plen 40         =
                                                          {0x0001} [hci0] 4=
3.846388
>         Address: 00:00:00:00:00:00 (OUI 00-00-00)
>         Addr Type: 2
>         Instant: 0x0000000000000000
>         Delay: 0
>         Count: 1
>         Data Length: 21
>         Data[21]: 142b003a8b6fe779bd4385a94fed0a9cf611880000
> < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen =
25                                                            #479 [hci0] 4=
3.846505
>         Handle: 0x05
>         Properties: 0x0010
>           Use legacy advertising PDUs: ADV_NONCONN_IND
>         Min advertising interval: 1280.000 msec (0x0800)
>         Max advertising interval: 1280.000 msec (0x0800)
>         Channel map: 37, 38, 39 (0x07)
>         Own address type: Random (0x01)
>         Peer address type: Public (0x00)
>         Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
>         Filter policy: Allow Scan Request from Any, Allow Connect Request=
 from Any (0x00)
>         TX power: Host has no preference (0x7f)
>         Primary PHY: LE 1M (0x01)
>         Secondary max skip: 0x00
>         Secondary PHY: LE 1M (0x01)
>         SID: 0x00
>         Scan request notifications: Disabled (0x00)
> > HCI Event: Command Complete (0x0e) plen 5                              =
                                                              #480 [hci0] 4=
3.847480
>       LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 2
> --->    Status: Command Disallowed (0x0c)
>         TX power (selected): 0 dbm (0x00)
>
>
> From the btmon output it is obvious that advertising is not disabled befo=
re updating the parameters.
>
> I added the following debug line in hci_setup_ext_adv_instance_sync():
>
>         printk(KERN_ERR "instance =3D %u, adv =3D %p, adv->pending =3D %d=
, adv->enabled =3D %d\n",
>                instance, adv, adv ? adv->pending : -1, adv ? adv->enabled=
 : -1);
>
> From the debug output I see that adv->pending is still true (so advertisi=
ng is not disabled
> before setting the advertising params). After changing the check from
>
>         if (adv && !adv->pending) {
>
> to
>
>         if (adv && adv->enabled) {
>
> it seems to do the job correctly. What do you think?

Yeah, that is indeed a bug, in fact we can just leave for
hci_disable_ext_adv_instance_sync to detect if the instance is
enabled:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2e0e532384c3..13ebd1a380fd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1228,7 +1228,7 @@ int hci_setup_ext_adv_instance_sync(struct
hci_dev *hdev, u8 instance)
         * Command Disallowed error, so we must first disable the
         * instance if it is active.
         */
-       if (adv && !adv->pending) {
+       if (adv) {
                err =3D hci_disable_ext_adv_instance_sync(hdev, instance);
                if (err)
                        return err;


>
> regards,
> Christian
>
>
> On Friday, 27 June 2025, 09:05:08 CEST, Christian Eggers wrote:
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
> > ---
> > v3: refactor: store adv_addr_type/tx_power within hci_set_ext_adv_param=
s_sync()
> >
> > v2: convert setting of adv data into synchronous context (rather than m=
oving
> > more methods into asynchronous response handlers).
> > - hci_set_ext_adv_params_sync: new method
> > - hci_set_ext_adv_data_sync: move within source file (no changes)
> > - hci_set_adv_data_sync: dito
> > - hci_update_adv_data_sync: dito
> > - hci_cc_set_ext_adv_param: remove (performed synchronously now)
> >
> >  net/bluetooth/hci_event.c |  36 -------
> >  net/bluetooth/hci_sync.c  | 207 ++++++++++++++++++++++++--------------
> >  2 files changed, 130 insertions(+), 113 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 66052d6aaa1d..4d5ace9d245d 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2150,40 +2150,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *h=
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
> > @@ -4164,8 +4130,6 @@ static const struct hci_cc {
> >       HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
> >              hci_cc_le_read_num_adv_sets,
> >              sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> > -     HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
> > -            sizeof(struct hci_rp_le_set_ext_adv_params)),
> >       HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
> >                     hci_cc_le_set_ext_adv_enable),
> >       HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 1f8806dfa556..563614b53485 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -1205,9 +1205,126 @@ static int hci_set_adv_set_random_addr_sync(str=
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
> > +             bt_dev_err(hdev, "Invalid response length for "
> > +                        "HCI_OP_LE_SET_EXT_ADV_PARAMS: %u", skb->len);
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
> > +     DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> > +                 HCI_MAX_EXT_AD_LENGTH);
> > +     u8 len;
> > +     struct adv_info *adv =3D NULL;
> > +     int err;
> > +
> > +     if (instance) {
> > +             adv =3D hci_find_adv_instance(hdev, instance);
> > +             if (!adv || !adv->adv_data_changed)
> > +                     return 0;
> > +     }
> > +
> > +     len =3D eir_create_adv_data(hdev, instance, pdu->data,
> > +                               HCI_MAX_EXT_AD_LENGTH);
> > +
> > +     pdu->length =3D len;
> > +     pdu->handle =3D adv ? adv->handle : instance;
> > +     pdu->operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> > +     pdu->frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> > +
> > +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> > +                                 struct_size(pdu, data, len), pdu,
> > +                                 HCI_CMD_TIMEOUT);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Update data if the command succeed */
> > +     if (adv) {
> > +             adv->adv_data_changed =3D false;
> > +     } else {
> > +             memcpy(hdev->adv_data, pdu->data, len);
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
> > +     len =3D eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.da=
ta));
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
> > @@ -1316,8 +1433,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_d=
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
> > @@ -1822,79 +1943,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hd=
ev, u8 handle, u8 reason)
> >                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >  }
> >
> > -static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance=
)
> > -{
> > -     DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> > -                 HCI_MAX_EXT_AD_LENGTH);
> > -     u8 len;
> > -     struct adv_info *adv =3D NULL;
> > -     int err;
> > -
> > -     if (instance) {
> > -             adv =3D hci_find_adv_instance(hdev, instance);
> > -             if (!adv || !adv->adv_data_changed)
> > -                     return 0;
> > -     }
> > -
> > -     len =3D eir_create_adv_data(hdev, instance, pdu->data,
> > -                               HCI_MAX_EXT_AD_LENGTH);
> > -
> > -     pdu->length =3D len;
> > -     pdu->handle =3D adv ? adv->handle : instance;
> > -     pdu->operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> > -     pdu->frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> > -
> > -     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> > -                                 struct_size(pdu, data, len), pdu,
> > -                                 HCI_CMD_TIMEOUT);
> > -     if (err)
> > -             return err;
> > -
> > -     /* Update data if the command succeed */
> > -     if (adv) {
> > -             adv->adv_data_changed =3D false;
> > -     } else {
> > -             memcpy(hdev->adv_data, pdu->data, len);
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
> > -     len =3D eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.da=
ta));
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
> > @@ -6269,6 +6317,7 @@ static int hci_le_ext_directed_advertising_sync(s=
truct hci_dev *hdev,
> >                                               struct hci_conn *conn)
> >  {
> >       struct hci_cp_le_set_ext_adv_params cp;
> > +     struct hci_rp_le_set_ext_adv_params rp;
> >       int err;
> >       bdaddr_t random_addr;
> >       u8 own_addr_type;
> > @@ -6310,8 +6359,12 @@ static int hci_le_ext_directed_advertising_sync(=
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
> >
>
>
>
>


--=20
Luiz Augusto von Dentz

