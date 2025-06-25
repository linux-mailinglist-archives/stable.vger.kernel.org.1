Return-Path: <stable+bounces-158603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8AAE8755
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA90E1745F1
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87BF264A7F;
	Wed, 25 Jun 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfQFOCAC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AB19D07E;
	Wed, 25 Jun 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863728; cv=none; b=OchFCl+iNHldMxy6ayeUBKdJ2g/bEWxMjr4jVh9bk8I2JtQ3RFGOOt2wN1KWqPHUc3kGHhu6dolRPro3Rav+eWy87UeJYdD4W+nJSmhcyB+aSk6g66LnLtbSu0Yh/izc1yHkEjeUr1JWvMv8O3zEcBVAvkLRo1/NmMXEGhDy7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863728; c=relaxed/simple;
	bh=TATV1nzkeRk8wLxjTenYDmwjCGqiMGrrKLobPuxuLYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXyRn8K5Rq8wQ9A9QA2L1Td8AdbkWiwNDQZDD+XOfO+Baxnj4olyRQ1yu6/hYLNNfxvTHVYXFco03UHxYFZRhbcq+XTaORa8AW6kZBf628Znt6hWp8+etxF1R1r6mqrWPs8KsbMLR7EddiYJ85CbwAL62SQgsYOWp6adNLKFKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfQFOCAC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b7123edb9so64032671fa.2;
        Wed, 25 Jun 2025 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750863724; x=1751468524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=420YTqzU+XzX4ghS6mL6IyLrgPiw+g1A7gSb2koYSdM=;
        b=CfQFOCAChGgVjZCAczjVdDiku8wY7A2KMo3Iys03FEhpWoPNGvG/MNMegUGlvTP3c0
         b1QJ4xRS6MK75wWYW/0PBr5qlio1dZ/Qzn9QtW72Igv4bdhEW7MRAig8fxVTy4oyKSj/
         2WvsAme4ws68V56NCldHHuMspOCbjuIlcqLesLsnhYnD4dE8QQAQNFpdXwfyjyQTYPJC
         21BOGwVFu9hp4Nn0iO2hK1pIPeP3/ci1BKKFGYGrEjNCQl3mCiA7RGdgrsnXGdGqFCne
         CzCZUf1PMOuQDmbrRCfUcla4t3PYBkD7AdBz2a/+DecIzytRIYv1Li9rD8LGrGAczgQn
         wyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750863724; x=1751468524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=420YTqzU+XzX4ghS6mL6IyLrgPiw+g1A7gSb2koYSdM=;
        b=JM/hEAQAYmqiFqjYfBySb35OTslIwVjXDyFFUuCApP8bzJ09Jo5tw+8Rd2H/G+4Duj
         NkYF23XEbaFGxVlLmlymM/KHPpqyvZ8uU19Lj9eeFxt53Pc9VlbrlQZK40n8vKu7qjI7
         925AXHHbY5p6wd2jPKjMmN5rOUQ8rx26Zta/E5enSPv1RfLC92w3HNPfMTSlo9VA3Obd
         nzvPZLX/FSZs/YcIcJFCMAEAs8xKQj/3gTL3k+P1OpY0N/MqGJl/hAdS5AN9ezIIu95i
         UXaqlPghdvYI5fXOqVTcPUXhTmnhmE9WIA+EoZH+E3UcRqih0NFymMhDYm8XI2oKECwN
         8Duw==
X-Forwarded-Encrypted: i=1; AJvYcCUK5SimSXpuyypBvnidiiYr2WqYTQcxi7AEprKMY8ASQ1FK+xPDOI8X9e63zPJa9ohpSKyxHyRs@vger.kernel.org, AJvYcCWI9TJMdcR/dPInR8bvrfiQZ7drCQuzr2/knmUAQU97lw33HnE22XbOuzzdmCs/mHhG5ftQiKeE2LRsXRjY0Eg=@vger.kernel.org, AJvYcCWqilg/Qeb7LnVQKNS6e62PyGyeDnMrDfv4ybWdYNVvqG4JQpTZMZQrZ+v5vqWS7F4WB84raP2ISDcGQ8FU@vger.kernel.org, AJvYcCXiEDpLFbXNDs+wBHRbnflZU34gArXcQQEmvtOjYqsEJrfhcVncq4Re30tBKn5uFUXWj2g779eR@vger.kernel.org
X-Gm-Message-State: AOJu0YwevaF+Z413yBEF0ZfV5kbNpBeDeh9GfH+l8uJsZhejsl04Fawc
	sXhiiVES0uFJWNR9DS3DckstjISkdJ4WswPySNRDcGOmj6yZdWqb/Y2DUSSx0zWra0E2o9wHnsG
	d6bN8pLNQj3pvqoSZ+7xrlTIH0JOsb9E5FzBMNoo=
X-Gm-Gg: ASbGncuZv+Qwj6lVx+83PTE/vf3vdQQuCvzq/tp3P4iLTNUEbbbPa4HhOkaaZa1Z5cV
	sMkM0X9hQc1wKWLE40d8+2iG5rsox2p9meJ440eMwps2LCLdNvJM8jvwx+vR7n49jY9C77X2KGv
	go859cjYHQC6TGaFq9RD7FlFSYDynr42/ngZczQdIz3w==
X-Google-Smtp-Source: AGHT+IGZLopoSsVxJMPNHI8f4O4vnirW+A3XA91XHCC7GTrbkPjQybYOaMth/++hIm/2V9uLIMf1XtNymnBT09bu+kg=
X-Received: by 2002:a05:651c:3c5:b0:32b:1f48:20a2 with SMTP id
 38308e7fff4ca-32cc65b49e5mr8131261fa.34.1750863722738; Wed, 25 Jun 2025
 08:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625130510.18382-1-ceggers@arri.de> <CABBYNZ+cfFCzBMNBv6imodUG1twK5=MSwoVCnR8St_w9-HiU_w@mail.gmail.com>
 <9911499.eNJFYEL58v@n9w6sw14>
In-Reply-To: <9911499.eNJFYEL58v@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Jun 2025 11:01:50 -0400
X-Gm-Features: Ac12FXxyupH16CR3fSN3676HPX85fxgqYAJN5Af0-hSuqBgj1YvLgbLhhI6N2Ug
Message-ID: <CABBYNZLg9-FOszwNEnqUxdJ+CKSCTAMFVk_ihOW3bECXwajhpA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Fix HCI command order for extended advertising
To: Christian Eggers <ceggers@arri.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Jun 25, 2025 at 10:46=E2=80=AFAM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> Hi Luiz,
>
> On Wednesday, 25 June 2025, 15:26:58 CEST, Luiz Augusto von Dentz wrote:
> > Hi Christian,
> >
> > On Wed, Jun 25, 2025 at 9:05=E2=80=AFAM Christian Eggers <ceggers@arri.=
de> wrote:
> > >
> > > For extended advertising capable controllers, hci_start_ext_adv_sync(=
)
> > > at the moment synchronously calls SET_EXT_ADV_PARAMS [1],
> > > SET_ADV_SET_RAND_ADDR [2], SET_EXT_SCAN_RSP_DATA [3](optional) and
> > > SET_EXT_ADV_ENABLE [4].  After all synchronous commands are finished,
> > > SET_EXT_ADV_DATA is called from the async response handler of
> > > SET_EXT_ADV_PARAMS [5] (via hci_update_adv_data).
> > >
> > > So the current implementation sets the advertising data AFTER enablin=
g
> > > the advertising instance.  The BT Core specification explicitly allow=
s
> > > for this [6]:
> > >
> > > > If advertising is currently enabled for the specified advertising s=
et,
> > > > the Controller shall use the new data in subsequent extended
> > > > advertising events for this advertising set. If an extended
> > > > advertising event is in progress when this command is issued, the
> > > > Controller may use the old or new data for that event.
> >
> > Ok, lets stop right here, if the controller deviates from the spec it
> > needs a quirk and not make the whole stack work around a bug in the
> > firmware.
> I generally agree! In this particular case, I think that the current orde=
r of
> advertising commands may be the result of "random" and was probably not i=
ntended this
> way. While the command order of the "legacy" advertising commands looks p=
erfectly
> logical for me, the order of the "extended" commands seems to be broken b=
y setting
> the advertising data in the asynchronous response handler of set_ext_adv_=
params.

Yeah, the advertising data shall be set synchronously as well, if you
need anything from the command response there are variants that return
the response as skb so it can be processed.

> >
> > > In case of the Realtek RTL8761BU chip (almost all contemporary BT USB
> > > dongles are built on it), updating the advertising data after enablin=
g
> > > the instance produces (at least one) corrupted advertising message.
> > > Under normal conditions, a single corrupted advertising message would
> > > probably not attract much attention, but during MESH provisioning (vi=
a
> > > MGMT I/O / mesh_send(_sync)), up to 3 different messages (BEACON, ACK=
,
> > > CAPS) are sent within a loop which causes corruption of ALL provision=
ing
> > > messages.
> > >
> > > I have no idea whether this could be fixed in the firmware of the USB
> > > dongles (I didn't even find the chip on the Realtek homepage), but
> > > generally I would suggest changing the order of the HCI commands as t=
his
> > > matches the command order for "non-extended adv capable" controllers =
and
> > > simply is more natural.
> > >
> > > This patch only considers advertising instances with handle > 0, I do=
n't
> > > know whether this should be extended to further cases.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/net/bluetooth/hci_sync.c#n1319
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/net/bluetooth/hci_sync.c#n1204
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/net/bluetooth/hci_sync.c#n1471
> > > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/net/bluetooth/hci_sync.c#n1469
> > > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/net/bluetooth/hci_event.c#n2180
> > > [6] https://www.bluetooth.com/wp-content/uploads/Files/Specification/=
HTML/Core-60/out/en/host-controller-interface/host-controller-interface-fun=
ctional-specification.html#UUID-d4f36cb5-f26c-d053-1034-e7a547ed6a13
> > >
> > > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > > Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if con=
troller supports")
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  include/net/bluetooth/hci_core.h |  1 +
> > >  include/net/bluetooth/hci_sync.h |  1 +
> > >  net/bluetooth/hci_event.c        | 33 +++++++++++++++++++++++++++++
> > >  net/bluetooth/hci_sync.c         | 36 ++++++++++++++++++++++++++----=
--
> > >  4 files changed, 65 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index 9fc8f544e20e..8d37f127ddba 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -237,6 +237,7 @@ struct oob_data {
> > >
> > >  struct adv_info {
> > >         struct list_head list;
> > > +       bool    enable_after_set_ext_data;
> > >         bool    enabled;
> > >         bool    pending;
> > >         bool    periodic;
> > > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth=
/hci_sync.h
> > > index 5224f57f6af2..00eceffeec87 100644
> > > --- a/include/net/bluetooth/hci_sync.h
> > > +++ b/include/net/bluetooth/hci_sync.h
> > > @@ -112,6 +112,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev=
 *hdev, u8 instance,
> > >  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instanc=
e);
> > >  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance);
> > >  int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instanc=
e);
> > > +int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance);
> > >  int hci_enable_advertising_sync(struct hci_dev *hdev);
> > >  int hci_enable_advertising(struct hci_dev *hdev);
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 66052d6aaa1d..eb018d8a3c4b 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -2184,6 +2184,37 @@ static u8 hci_cc_set_ext_adv_param(struct hci_=
dev *hdev, void *data,
> > >         return rp->status;
> > >  }
> > >
> > > +static u8 hci_cc_le_set_ext_adv_data(struct hci_dev *hdev, void *dat=
a,
> > > +                                    struct sk_buff *skb)
> > > +{
> > > +       struct hci_cp_le_set_ext_adv_data *cp;
> > > +       struct hci_ev_status *rp =3D data;
> > > +       struct adv_info *adv_instance;
> > > +
> > > +       bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> > > +
> > > +       if (rp->status)
> > > +               return rp->status;
> > > +
> > > +       cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_DATA);
> > > +       if (!cp)
> > > +               return rp->status;
> > > +
> > > +       hci_dev_lock(hdev);
> > > +
> > > +       if (cp->handle) {
> > > +               adv_instance =3D hci_find_adv_instance(hdev, cp->hand=
le);
> > > +               if (adv_instance) {
> > > +                       if (adv_instance->enable_after_set_ext_data)
> > > +                               hci_enable_ext_advertising(hdev, cp->=
handle);
> > > +               }
> > > +       }
> > > +
> > > +       hci_dev_unlock(hdev);
> > > +
> > > +       return rp->status;
> > > +}
> > > +
> > >  static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
> > >                            struct sk_buff *skb)
> > >  {
> > > @@ -4166,6 +4197,8 @@ static const struct hci_cc {
> > >                sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> > >         HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param=
,
> > >                sizeof(struct hci_rp_le_set_ext_adv_params)),
> > > +       HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_DATA,
> > > +                     hci_cc_le_set_ext_adv_data),
> > >         HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
> > >                       hci_cc_le_set_ext_adv_enable),
> > >         HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 1f8806dfa556..da0e39cce721 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -1262,6 +1262,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_=
dev *hdev, u8 instance)
> > >                 hci_cpu_to_le24(adv->max_interval, cp.max_interval);
> > >                 cp.tx_power =3D adv->tx_power;
> > >                 cp.sid =3D adv->sid;
> > > +               adv->enable_after_set_ext_data =3D true;
> > >         } else {
> > >                 hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_int=
erval);
> > >                 hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_int=
erval);
> > > @@ -1456,6 +1457,23 @@ int hci_enable_ext_advertising_sync(struct hci=
_dev *hdev, u8 instance)
> > >                                      data, HCI_CMD_TIMEOUT);
> > >  }
> > >
> > > +static int enable_ext_advertising_sync(struct hci_dev *hdev, void *d=
ata)
> > > +{
> > > +       u8 instance =3D PTR_UINT(data);
> > > +
> > > +       return hci_enable_ext_advertising_sync(hdev, instance);
> > > +}
> > > +
> > > +int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance)
> > > +{
> > > +       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
> > > +           list_empty(&hdev->adv_instances))
> > > +               return 0;
> > > +
> > > +       return hci_cmd_sync_queue(hdev, enable_ext_advertising_sync,
> > > +                                 UINT_PTR(instance), NULL);
> > > +}
> > > +
> > >  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
> > >  {
> > >         int err;
> > > @@ -1464,11 +1482,11 @@ int hci_start_ext_adv_sync(struct hci_dev *hd=
ev, u8 instance)
> > >         if (err)
> > >                 return err;
> > >
> > > -       err =3D hci_set_ext_scan_rsp_data_sync(hdev, instance);
> > > -       if (err)
> > > -               return err;
> > > -
> > > -       return hci_enable_ext_advertising_sync(hdev, instance);
> > > +       /* SET_EXT_ADV_DATA and SET_EXT_ADV_ENABLE are called in the
> > > +        * asynchronous response chain of set_ext_adv_params in order=
 to
> > > +        * set the advertising data first prior enabling it.
> > > +        */
> >
> > Doing things asynchronously is known to create problems, which is why
> > we introduced the cmd_sync infra to handle a chain of commands like
> > this, so Id suggest sticking to the synchronous way, if the order
> > needs to be changed then use a quirk to detect it and then make sure
> > the instance is disabled on hci_set_ext_adv_data_sync and then
> > re-enable after updating it.
>
> Directly after creation, the instance is disabled (which is fine). In my
> opinion, the problem is then caused by enabling the instance _before_ set=
ting
> the advertisement data.
>
> If the synchronous API is preferred, setting the advertisement data shoul=
d
> probably also be done synchronously (e.g. by calling hci_set_ext_adv_data=
_sync()
> from hci_start_ext_adv_sync() rather than calling hci_update_adv_data() f=
rom
> hci_cc_set_ext_adv_param()). But I guess that the "tx power" value is onl=
y
> known after hci_cc_set_ext_adv_param() has been run (queued?) and this is=
 probably
> too late for the synchronous stuff called by hci_start_ext_adv_sync().

Not really, like I said there is the likes of __hci_cmd_sync if you
want to process the response directly, so the logic on
hci_cc_set_ext_adv_param is not really necessary if we do that, this
might explain why it may seems out of order since hci_update_adv_data
will queue the command to be run after the cmd_sync is done
programming the existing instance.

That said for the likes of MGMT_OP_ADD_EXT_ADV_DATA you will still
need to detect if the instance has already been enabled then do
disable/re-enable logic if the quirk is set.

> >
> > > +       return hci_set_ext_scan_rsp_data_sync(hdev, instance);
> > >  }
> > >
> > >  int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instan=
ce)
> > > @@ -1832,8 +1850,14 @@ static int hci_set_ext_adv_data_sync(struct hc=
i_dev *hdev, u8 instance)
> > >
> > >         if (instance) {
> > >                 adv =3D hci_find_adv_instance(hdev, instance);
> > > -               if (!adv || !adv->adv_data_changed)
> > > +               if (!adv)
> > >                         return 0;
> > > +               if (!adv->adv_data_changed) {
> > > +                       if (adv->enable_after_set_ext_data)
> > > +                               hci_enable_ext_advertising_sync(hdev,
> > > +                                                               adv->=
handle);
> > > +                       return 0;
> > > +               }
> > >         }
> > >
> > >         len =3D eir_create_adv_data(hdev, instance, pdu->data,
> > > --
> > > 2.43.0
> > >
> >
> >
> >
> regards,
> Christian
>
>
>
> regards,
> Christian
>
>
>


--=20
Luiz Augusto von Dentz

