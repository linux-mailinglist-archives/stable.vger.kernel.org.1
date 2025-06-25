Return-Path: <stable+bounces-158558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA95AE84B6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9194E1888D73
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D62620FC;
	Wed, 25 Jun 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILgF6ZWn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9B3FD4;
	Wed, 25 Jun 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858035; cv=none; b=HjnwTvrRZKERhxq0NNuBW+G59aVmtDjKVPjAFEKxio5XB2c9QK0HuW+1X1wDPPsMw3FQ69XXK4wrYxuwellzNZhn1rmUcLAr5TGhxYoE4livFsEB9TJPOWyaQWnT6dOSAeFgb8PAWBtAMen4xdy7ssCHJxKS5Hl9wJJRlRqjOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858035; c=relaxed/simple;
	bh=7ZxBAiyfUmMtN7AjxxGSzEQM7fP1mVANe3bslfVATjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9sPy6SuWwtCE9KQspMPq4kMGLOg9B9CFJ2rKrtHKNHL3tbqSF3/0kdj0xi+CjIhQDJLvzNS2TzDX8N22VCATpCWrm578/kdibuSIFeI63pTXvVcISJAuT8NNDm0rG+DhcEM0tt6ASQSRjWyr8SwfFa1crmf06eDkLFKF23Pibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILgF6ZWn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b910593edso13817571fa.1;
        Wed, 25 Jun 2025 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750858031; x=1751462831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eWmQcceDnjey6WVhwoCM3alttfmTOHZzpPMwjO1DTw=;
        b=ILgF6ZWnEv0jM1prhwrOzV6Bqp2AdXgx25huXTmTCIWcKUy9rf6HJrv10VDvqrw9jX
         BkYSvszjJl60uR0IP1UBpcmbQ1pnaG0FEp3dCw/xv/WiAu0omzit5XswaGTKEuOeOzHv
         2fCo5bMeCQzsmtr7fwfBqax2/bth0G59J9St3ZVD9PACz9kHutVXXPRKNa0X8HsSaLc9
         MYGB/xViXqG2KpO75r4XTypRMusnAt0tCcjQwXVYxh5yYUQi9z3ZLyR36aIpIgvMeCQI
         UEyD89at3dhAmWWxlAd6j5L9M1eCQ/6igi+41BhScXFITCUiGkRKDPuR4PvmzOweMOUQ
         TMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858031; x=1751462831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eWmQcceDnjey6WVhwoCM3alttfmTOHZzpPMwjO1DTw=;
        b=QNfkxEB49Sr7jJPo//kxyLc2L+N2ANxikymFqUOsZjzCpq0mWn84ExQy/2boqJQEfV
         iHT9LG9qGozaLbr8ot1vYsyaVpQWlcmuQP3KZf3SQRm+Q8Vx1G5Tcd7ddCPtrgGCDD+a
         PnAN8R+ldmMlu55qJPvggD8bTu4uaQ/0S5Jv5sulyycQtoFNekkZ3fkFHDqSVzBqqrbU
         zHWmOyljMQVZK/KAGYpVfffFaNYcfAJO8Zqk/AJsyGZe4nteVGQDu2BZkRs6GOwNjZni
         5gaaWaLJdpVfWdl+dSdaCftrJUjh5rYMt4wvi+2dfsxhrBMH1RSTiBNTJQGOz5E9A4NQ
         OOew==
X-Forwarded-Encrypted: i=1; AJvYcCWcXTt8nH0983inY2l8uUYzRAU4BbuR3x4TQWRuqUVGveU3U/GV5xAUlT7eo3qJzkosn7hc/kgz@vger.kernel.org, AJvYcCWkkX9xGUyuuFKv+zTmFytjA/pTyPA0T4JRzBngPtpB6wVTS0jZWbzMlY2yOikryZm84PBIN6QM1qZYK0b4+PA=@vger.kernel.org, AJvYcCXbA7ax3fApSHbgIrhPsCCk9zG6UNSErs0BW6qPYOBxySzq3/QXu7AABQXzHuQFCJZMlWLFbmb0@vger.kernel.org, AJvYcCXjH49X1X85P/NiF3rpDkGpAtCpyUrlf7T0pFLPZEP2s4JV/ERtFPFDgrbg30AMPpnER1/nyinyXYSQZN/j@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfr8hkM4Fn0vAYuZ13uq6YeJXVoTKeunG46ZOylPuSA42tln9x
	TBaQDuEJaOrhwEH225t9gUMnP1PePlftpavjy1ZDSPAIk7Ocb6TdoX2zxhHaMUb2Bq+DRQiJZlr
	UI+soR5iLJN9e+sZEcf5QxMhLzDl697I=
X-Gm-Gg: ASbGnct7bfCfinCKdUjc53o69LPDh461OJUJGTD34+L6rWsH6xqzsypQnE0djhLyDdL
	K07SyY5eyHXf6pxo77zcC6I5/s02UImLd2VY0j1XmIwtyclP0P3k0+cmVJRdP9NN+dZC1p8i6xw
	5M/fg6bl180RJ0vm02Mj1mGOZiNgab2o1lWWcZdkHaDA==
X-Google-Smtp-Source: AGHT+IG2ftQGOZB8IDsuFAGSJ7WRgj2/KluM8fac5/UJbucBJJKKOqnTxouoVa1M2ZVSrEhuRs/0LY5oo8U9dBqktqk=
X-Received: by 2002:a2e:a5c2:0:b0:32a:8297:54c9 with SMTP id
 38308e7fff4ca-32cc6434852mr10560721fa.8.1750858030473; Wed, 25 Jun 2025
 06:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625130510.18382-1-ceggers@arri.de>
In-Reply-To: <20250625130510.18382-1-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Jun 2025 09:26:58 -0400
X-Gm-Features: Ac12FXxoRatCETVtaTcE8jTrNySsVyuFBKwzRXMZzaO5K4vFYbneLMjuaNcOZUE
Message-ID: <CABBYNZ+cfFCzBMNBv6imodUG1twK5=MSwoVCnR8St_w9-HiU_w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Fix HCI command order for extended advertising
To: Christian Eggers <ceggers@arri.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Jun 25, 2025 at 9:05=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> For extended advertising capable controllers, hci_start_ext_adv_sync()
> at the moment synchronously calls SET_EXT_ADV_PARAMS [1],
> SET_ADV_SET_RAND_ADDR [2], SET_EXT_SCAN_RSP_DATA [3](optional) and
> SET_EXT_ADV_ENABLE [4].  After all synchronous commands are finished,
> SET_EXT_ADV_DATA is called from the async response handler of
> SET_EXT_ADV_PARAMS [5] (via hci_update_adv_data).
>
> So the current implementation sets the advertising data AFTER enabling
> the advertising instance.  The BT Core specification explicitly allows
> for this [6]:
>
> > If advertising is currently enabled for the specified advertising set,
> > the Controller shall use the new data in subsequent extended
> > advertising events for this advertising set. If an extended
> > advertising event is in progress when this command is issued, the
> > Controller may use the old or new data for that event.

Ok, lets stop right here, if the controller deviates from the spec it
needs a quirk and not make the whole stack work around a bug in the
firmware.

> In case of the Realtek RTL8761BU chip (almost all contemporary BT USB
> dongles are built on it), updating the advertising data after enabling
> the instance produces (at least one) corrupted advertising message.
> Under normal conditions, a single corrupted advertising message would
> probably not attract much attention, but during MESH provisioning (via
> MGMT I/O / mesh_send(_sync)), up to 3 different messages (BEACON, ACK,
> CAPS) are sent within a loop which causes corruption of ALL provisioning
> messages.
>
> I have no idea whether this could be fixed in the firmware of the USB
> dongles (I didn't even find the chip on the Realtek homepage), but
> generally I would suggest changing the order of the HCI commands as this
> matches the command order for "non-extended adv capable" controllers and
> simply is more natural.
>
> This patch only considers advertising instances with handle > 0, I don't
> know whether this should be extended to further cases.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/bluetooth/hci_sync.c#n1319
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/bluetooth/hci_sync.c#n1204
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/bluetooth/hci_sync.c#n1471
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/bluetooth/hci_sync.c#n1469
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/bluetooth/hci_event.c#n2180
> [6] https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML=
/Core-60/out/en/host-controller-interface/host-controller-interface-functio=
nal-specification.html#UUID-d4f36cb5-f26c-d053-1034-e7a547ed6a13
>
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if control=
ler supports")
> Cc: stable@vger.kernel.org
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  include/net/bluetooth/hci_sync.h |  1 +
>  net/bluetooth/hci_event.c        | 33 +++++++++++++++++++++++++++++
>  net/bluetooth/hci_sync.c         | 36 ++++++++++++++++++++++++++------
>  4 files changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 9fc8f544e20e..8d37f127ddba 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -237,6 +237,7 @@ struct oob_data {
>
>  struct adv_info {
>         struct list_head list;
> +       bool    enable_after_set_ext_data;
>         bool    enabled;
>         bool    pending;
>         bool    periodic;
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index 5224f57f6af2..00eceffeec87 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -112,6 +112,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hd=
ev, u8 instance,
>  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
>  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance);
>  int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance);
> +int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance);
>  int hci_enable_advertising_sync(struct hci_dev *hdev);
>  int hci_enable_advertising(struct hci_dev *hdev);
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..eb018d8a3c4b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2184,6 +2184,37 @@ static u8 hci_cc_set_ext_adv_param(struct hci_dev =
*hdev, void *data,
>         return rp->status;
>  }
>
> +static u8 hci_cc_le_set_ext_adv_data(struct hci_dev *hdev, void *data,
> +                                    struct sk_buff *skb)
> +{
> +       struct hci_cp_le_set_ext_adv_data *cp;
> +       struct hci_ev_status *rp =3D data;
> +       struct adv_info *adv_instance;
> +
> +       bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> +
> +       if (rp->status)
> +               return rp->status;
> +
> +       cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_DATA);
> +       if (!cp)
> +               return rp->status;
> +
> +       hci_dev_lock(hdev);
> +
> +       if (cp->handle) {
> +               adv_instance =3D hci_find_adv_instance(hdev, cp->handle);
> +               if (adv_instance) {
> +                       if (adv_instance->enable_after_set_ext_data)
> +                               hci_enable_ext_advertising(hdev, cp->hand=
le);
> +               }
> +       }
> +
> +       hci_dev_unlock(hdev);
> +
> +       return rp->status;
> +}
> +
>  static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
>                            struct sk_buff *skb)
>  {
> @@ -4166,6 +4197,8 @@ static const struct hci_cc {
>                sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
>         HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
>                sizeof(struct hci_rp_le_set_ext_adv_params)),
> +       HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_DATA,
> +                     hci_cc_le_set_ext_adv_data),
>         HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
>                       hci_cc_le_set_ext_adv_enable),
>         HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 1f8806dfa556..da0e39cce721 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1262,6 +1262,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev =
*hdev, u8 instance)
>                 hci_cpu_to_le24(adv->max_interval, cp.max_interval);
>                 cp.tx_power =3D adv->tx_power;
>                 cp.sid =3D adv->sid;
> +               adv->enable_after_set_ext_data =3D true;
>         } else {
>                 hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interva=
l);
>                 hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interva=
l);
> @@ -1456,6 +1457,23 @@ int hci_enable_ext_advertising_sync(struct hci_dev=
 *hdev, u8 instance)
>                                      data, HCI_CMD_TIMEOUT);
>  }
>
> +static int enable_ext_advertising_sync(struct hci_dev *hdev, void *data)
> +{
> +       u8 instance =3D PTR_UINT(data);
> +
> +       return hci_enable_ext_advertising_sync(hdev, instance);
> +}
> +
> +int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance)
> +{
> +       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
> +           list_empty(&hdev->adv_instances))
> +               return 0;
> +
> +       return hci_cmd_sync_queue(hdev, enable_ext_advertising_sync,
> +                                 UINT_PTR(instance), NULL);
> +}
> +
>  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
>  {
>         int err;
> @@ -1464,11 +1482,11 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, =
u8 instance)
>         if (err)
>                 return err;
>
> -       err =3D hci_set_ext_scan_rsp_data_sync(hdev, instance);
> -       if (err)
> -               return err;
> -
> -       return hci_enable_ext_advertising_sync(hdev, instance);
> +       /* SET_EXT_ADV_DATA and SET_EXT_ADV_ENABLE are called in the
> +        * asynchronous response chain of set_ext_adv_params in order to
> +        * set the advertising data first prior enabling it.
> +        */

Doing things asynchronously is known to create problems, which is why
we introduced the cmd_sync infra to handle a chain of commands like
this, so Id suggest sticking to the synchronous way, if the order
needs to be changed then use a quirk to detect it and then make sure
the instance is disabled on hci_set_ext_adv_data_sync and then
re-enable after updating it.

> +       return hci_set_ext_scan_rsp_data_sync(hdev, instance);
>  }
>
>  int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
> @@ -1832,8 +1850,14 @@ static int hci_set_ext_adv_data_sync(struct hci_de=
v *hdev, u8 instance)
>
>         if (instance) {
>                 adv =3D hci_find_adv_instance(hdev, instance);
> -               if (!adv || !adv->adv_data_changed)
> +               if (!adv)
>                         return 0;
> +               if (!adv->adv_data_changed) {
> +                       if (adv->enable_after_set_ext_data)
> +                               hci_enable_ext_advertising_sync(hdev,
> +                                                               adv->hand=
le);
> +                       return 0;
> +               }
>         }
>
>         len =3D eir_create_adv_data(hdev, instance, pdu->data,
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz

