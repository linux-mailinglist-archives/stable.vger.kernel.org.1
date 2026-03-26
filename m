Return-Path: <stable+bounces-230506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iED5M8JqxWl1+AQAu9opvQ
	(envelope-from <stable+bounces-230506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:20:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F0339115
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC8D3048EEE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BEE3446BC;
	Thu, 26 Mar 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JogsVsu7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9865344040
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545417; cv=pass; b=YTP1inv2J6GvWfh6lklAqCeb7VFejryd0nMBLKROanqusQPRgB4VMZpD2KKGjTYzqrOQq4oDsW3Eqqa9IzHeBgu1PYmimSIXgMc94KcCAesKpXewKLVJJkm0kdDvqqRPEdbZQWZMzEjgsk4AJR7b6T1OaBlGtRgd+Kynj37lvQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545417; c=relaxed/simple;
	bh=XpGGKH0+jHnbkTx4XXcFRGePkyMxcMWfvg1wX52P9i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlOlhX43h0NL3ubKhwD0/0C1DWMfLTQXDjbVR7v92GEHDZJZF8P+l1hU8ezYJY2iwYKPMNGsgYdqp1oHNJXzGr42DI8eAorm6BpDEFRogftEnst1d/Bt/GpX90Dvx0VMc/almHvWPb6DxR25Xii6ZkZTFEel53n8TQ9k6VgbkFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JogsVsu7; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64edf260b49so1576436d50.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 10:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774545415; cv=none;
        d=google.com; s=arc-20240605;
        b=d5WXTNkFnKWWFvsIITdOCEzKfG54tl90nSI+0BDUZkuMvDJ9o6XXtgoXTRNacPlMSM
         QOgTOu9pI9riu+wigBjc/NOXXBgvYCaBBNVG1p7vSDEto3ehjB4OuXFi7GDlGot0EKNI
         THh7EGcSkaXt7Q4gkKU5xszbKUWuuxQ4rUAcG+XI9xqqF19BiQpsh4LM2/Fd1E2OXnF7
         Ljk5ohTrdXSJqFbvvwrX3l3fKDHDCiEi/NcRJSDad7gfjnP+w8JM73snyUWNq71AJMmO
         lJfb8fOljQEFp4AJEHU8btNCWYsjIV+bWvozMixV1ny4qkZ8DY5huTW9/yz+8YKEWun7
         3QRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/out/Pg+eC1Z2v3A8N9eV3ek0NeKXkekWp4rHbti2gk=;
        fh=MniSUZatiEphoHv4JyO8fJPKguec+9A8OAlE/f8BMvM=;
        b=YB8ECysGbfyp/dozfG3ucxHunCAI1CbdrHMxYzoSubAptSQ4DU5Eo/1hbIRzQUPxBp
         DnlgsEFX1pcWbC+U1RcJNCTgjUSyCzMMZ+wfj321x0el8RRFRyxBy8IxgxmqX2O/huFA
         ccQxIC9q/rLT2/d2yfBX42+wATTtFHXOdnU8Xk94YSwRUxJYIzqwq/izgniAwTLjaMS6
         ODjddPSn0p3Y1e8rUOjlX/x2PuEEvEXvnLy6uny8HRMMms5AM/28QU/wxTn4zOv3O26q
         sWYgnqYE450NhAne+Mk4ojjdwQ37GdJU6WoNzYNJSTHJZYktRp17spfgEZ4tI2f3SL32
         hFjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774545415; x=1775150215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/out/Pg+eC1Z2v3A8N9eV3ek0NeKXkekWp4rHbti2gk=;
        b=JogsVsu7i8eoTAcPkMYZxq8iRuU9W5GExeU4BeqUdF3cFYYhnmmpLsZ8qjDk/oeQRy
         xQgdOWpWRTH8I1GtLqsFqlCU8IRbTi/PLYm1xli9c5RBWeOmkEUhwfCaF3ZlxRS74m8K
         S03o2p9J7HGzWmB2J+WNIcsPaip5Kmi+SkTfHrJkwrq2dlqKzKyGvsoqRsUdXMX3mJhr
         LIDA5hJy3hppoPFuN6HBKUGOPwvrbpPVAw4zMzAg6S3tY0NXk4+bjVrn1Bgyc2Ciwc/t
         4wyvkK7GMv8FA1xHlBhjKKuufSeW/HPtjU63qIjDOD3tcsT4UqtmqVsf2tPp8R9HaeRv
         uJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545415; x=1775150215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/out/Pg+eC1Z2v3A8N9eV3ek0NeKXkekWp4rHbti2gk=;
        b=hQpunBrIctuXoNF/VGEFCY1sYwuDaIalA2AwhI68Sb6LmjirKWd4zfd5Dby/omhKra
         +CbXOe1vOEULqCZGBEyY5zt5/joYia1Pr0P0OnmBPe39UiDuRLjOq4H/5Wdk32MfyI/x
         68xh/ovkE7gJH979476Cj0lm/cVDSexqUH9Q9vAUmgc9U8YO2Zgp9UWEI47YF2uGDv/z
         rSkKIPkoBD6NIO3PoxNhXtpodPMSxq5n29lRP7IcJMo3LMSKacCarRJ1tQTFoq9ko6LO
         20o9QDwqsDlwh9hFJHFIlLnTWStj2Nscq7QoVFR9i1xE7AmSSwzY6MiIbyyBm9+XuAcB
         rTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNT0hRyX2l08FV4bTweatDneffptNHPpRroMTHypo+Qr7LOKmVqxIEClMNJqZvj2enb1RhjYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF96RW/OO6o9EWT9LDPKsSx+dTlO6lgayyuQ0/sTSstpIlUlO5
	/NKYcQdF7RcNcbSC1jBbTbtW3LgVjh82OF1ZvGu856DF/ZSrT5Xa0QTwjR+oq0/O7BHLKQZjAz4
	7BUchTPq9uSGVQT0/Dn7hTU0mqnUfN2I=
X-Gm-Gg: ATEYQzz4o/gqczDZ3ivE5DDRekq/HamovlNJeP/mIpCUiung++phnETR5BTztZXjBy3
	jjuyhGAkAjFelY5/SqqvpzbemGG/h8tG454i9mcoPTQiqI4E2AOMSFyDxy5gt7UwbnSYM9BWOqP
	FGBjFc2DyEFiVkmZ59Ic4R4mH0vC9F2b3NnBUI0DkDLc/Zf9hp/kjwbknBuRzh1WGUfH4d+NmqB
	MBgCWBKHXCqkevNb2L0vljy9ZoJWN0ZdCBmo/6FOgIuHrUIqXrvfd1YrwsV1s/x2MZkFNI81END
	eXUGd4x+CQnDPsTMqm1x5UXVp6zmTk684A5rvfulOZkGSb2wVUFFOrYrwX0WP1m0t1g4pGRSNn1
	K+a9k
X-Received: by 2002:a05:690e:b8c:b0:64f:b8af:3595 with SMTP id
 956f58d0204a3-64fee1d9a44mr1868046d50.17.1774545414483; Thu, 26 Mar 2026
 10:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <798ca355ce0144488610929e6c13e383.security@1.0.0.127.in-addr.arpa>
In-Reply-To: <798ca355ce0144488610929e6c13e383.security@1.0.0.127.in-addr.arpa>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Mar 2026 13:16:43 -0400
X-Gm-Features: AQROBzDkB_gnah06z1tnOE9musoqsKMA1N7J6IXrdXzfGTUIESodA9_4JmsUdpI
Message-ID: <CABBYNZLzVwa=Jq2GFJ96G0JCFEQjyY6yAEfrHsuwBXGmfEiyaw@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
To: Oleh Konko <security@1seal.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230506-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1seal.org:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 180F0339115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Oleh,

On Thu, Mar 26, 2026 at 11:06=E2=80=AFAM Oleh Konko <security@1seal.org> wr=
ote:
>
> hci_store_wake_reason() is called from hci_event_packet() immediately
> after stripping the HCI event header but before hci_event_func()
> enforces the per-event minimum payload length from hci_ev_table.
> This means a short HCI event frame can reach bacpy() before any bounds
> check runs.
>
> Rather than duplicating skb parsing and per-event length checks inside
> hci_store_wake_reason(), move wake-address storage into the individual
> event handlers after their existing event-length validation has
> succeeded. Convert hci_store_wake_reason() into a small helper that only
> stores an already-validated bdaddr while the caller holds hci_dev_lock().
> Use the same helper after hci_event_func() with a NULL address to
> preserve the existing unexpected-wake fallback semantics when no
> validated event handler records a wake address.
>
> Annotate the helper with __must_hold(&hdev->lock) and add
> lockdep_assert_held(&hdev->lock) so future call paths keep the lock
> contract explicit.
>
> Call the helper from hci_conn_request_evt(), hci_conn_complete_evt(),
> hci_le_adv_report_evt(), hci_le_ext_adv_report_evt(), and
> hci_le_direct_adv_report_evt().
>
> Fixes: 2f20216c1d6f ("Bluetooth: Emit controller suspend and resume event=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleh Konko <security@1seal.org>
> ---
> v5:
> - add __must_hold(&hdev->lock) and lockdep_assert_held(&hdev->lock)
>
>  net/bluetooth/hci_event.c | 90 ++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 59 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 286529d2e554..cb27037eeef5 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -80,6 +80,10 @@ static void *hci_le_ev_skb_pull(struct hci_dev *hdev, =
struct sk_buff *skb,
>         return data;
>  }
>
> +static void hci_store_wake_reason(struct hci_dev *hdev,
> +                                 const bdaddr_t *bdaddr, u8 addr_type)
> +       __must_hold(&hdev->lock);
> +
>  static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
>                                 struct sk_buff *skb)
>  {
> @@ -3111,6 +3115,7 @@ static void hci_conn_complete_evt(struct hci_dev *h=
dev, void *data,
>         bt_dev_dbg(hdev, "status 0x%2.2x", status);
>
>         hci_dev_lock(hdev);
> +       hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
>
>         /* Check for existing connection:
>          *
> @@ -3274,6 +3279,10 @@ static void hci_conn_request_evt(struct hci_dev *h=
dev, void *data,
>
>         bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_t=
ype);
>
> +       hci_dev_lock(hdev);
> +       hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
> +       hci_dev_unlock(hdev);
> +
>         /* Reject incoming connection from device with same BD ADDR again=
st
>          * CVE-2020-26555
>          */
> @@ -6403,6 +6412,8 @@ static void hci_le_adv_report_evt(struct hci_dev *h=
dev, void *data,
>                                         info->length + 1))
>                         break;
>
> +               hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> +
>                 if (info->length <=3D max_adv_len(hdev)) {
>                         rssi =3D info->data[info->length];
>                         process_adv_report(hdev, info->type, &info->bdadd=
r,
> @@ -6491,6 +6502,8 @@ static void hci_le_ext_adv_report_evt(struct hci_de=
v *hdev, void *data,
>                                         info->length))
>                         break;
>
> +               hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> +
>                 evt_type =3D __le16_to_cpu(info->type) & LE_EXT_ADV_EVT_T=
YPE_MASK;
>                 legacy_evt_type =3D ext_evt_type_to_legacy(hdev, evt_type=
);
>
> @@ -6834,6 +6847,8 @@ static void hci_le_direct_adv_report_evt(struct hci=
_dev *hdev, void *data,
>         for (i =3D 0; i < ev->num; i++) {
>                 struct hci_ev_le_direct_adv_info *info =3D &ev->info[i];
>
> +               hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> +
>                 process_adv_report(hdev, info->type, &info->bdaddr,
>                                    info->bdaddr_type, &info->direct_addr,
>                                    info->direct_addr_type, HCI_ADV_PHY_1M=
, 0,
> @@ -7517,73 +7532,29 @@ static bool hci_get_cmd_complete(struct hci_dev *=
hdev, u16 opcode,
>         return true;
>  }
>
> -static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
> -                                 struct sk_buff *skb)
> +static void hci_store_wake_reason(struct hci_dev *hdev,
> +                                 const bdaddr_t *bdaddr, u8 addr_type)
> +       __must_hold(&hdev->lock)
>  {
> -       struct hci_ev_le_advertising_info *adv;
> -       struct hci_ev_le_direct_adv_info *direct_adv;
> -       struct hci_ev_le_ext_adv_info *ext_adv;
> -       const struct hci_ev_conn_complete *conn_complete =3D (void *)skb-=
>data;
> -       const struct hci_ev_conn_request *conn_request =3D (void *)skb->d=
ata;
> -
> -       hci_dev_lock(hdev);
> +       lockdep_assert_held(&hdev->lock);
>
>         /* If we are currently suspended and this is the first BT event s=
een,
>          * save the wake reason associated with the event.
>          */
>         if (!hdev->suspended || hdev->wake_reason)
> -               goto unlock;
> +               return;
> +
> +       if (!bdaddr) {
> +               hdev->wake_reason =3D MGMT_WAKE_REASON_UNEXPECTED;
> +               return;
> +       }
>
>         /* Default to remote wake. Values for wake_reason are documented =
in the
>          * Bluez mgmt api docs.
>          */
>         hdev->wake_reason =3D MGMT_WAKE_REASON_REMOTE_WAKE;
> -
> -       /* Once configured for remote wakeup, we should only wake up for
> -        * reconnections. It's useful to see which device is waking us up=
 so
> -        * keep track of the bdaddr of the connection event that woke us =
up.
> -        */
> -       if (event =3D=3D HCI_EV_CONN_REQUEST) {
> -               bacpy(&hdev->wake_addr, &conn_request->bdaddr);
> -               hdev->wake_addr_type =3D BDADDR_BREDR;
> -       } else if (event =3D=3D HCI_EV_CONN_COMPLETE) {
> -               bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
> -               hdev->wake_addr_type =3D BDADDR_BREDR;
> -       } else if (event =3D=3D HCI_EV_LE_META) {
> -               struct hci_ev_le_meta *le_ev =3D (void *)skb->data;
> -               u8 subevent =3D le_ev->subevent;
> -               u8 *ptr =3D &skb->data[sizeof(*le_ev)];
> -               u8 num_reports =3D *ptr;
> -
> -               if ((subevent =3D=3D HCI_EV_LE_ADVERTISING_REPORT ||
> -                    subevent =3D=3D HCI_EV_LE_DIRECT_ADV_REPORT ||
> -                    subevent =3D=3D HCI_EV_LE_EXT_ADV_REPORT) &&
> -                   num_reports) {
> -                       adv =3D (void *)(ptr + 1);
> -                       direct_adv =3D (void *)(ptr + 1);
> -                       ext_adv =3D (void *)(ptr + 1);
> -
> -                       switch (subevent) {
> -                       case HCI_EV_LE_ADVERTISING_REPORT:
> -                               bacpy(&hdev->wake_addr, &adv->bdaddr);
> -                               hdev->wake_addr_type =3D adv->bdaddr_type=
;
> -                               break;
> -                       case HCI_EV_LE_DIRECT_ADV_REPORT:
> -                               bacpy(&hdev->wake_addr, &direct_adv->bdad=
dr);
> -                               hdev->wake_addr_type =3D direct_adv->bdad=
dr_type;
> -                               break;
> -                       case HCI_EV_LE_EXT_ADV_REPORT:
> -                               bacpy(&hdev->wake_addr, &ext_adv->bdaddr)=
;
> -                               hdev->wake_addr_type =3D ext_adv->bdaddr_=
type;
> -                               break;
> -                       }
> -               }
> -       } else {
> -               hdev->wake_reason =3D MGMT_WAKE_REASON_UNEXPECTED;
> -       }
> -
> -unlock:
> -       hci_dev_unlock(hdev);
> +       bacpy(&hdev->wake_addr, bdaddr);
> +       hdev->wake_addr_type =3D addr_type;
>  }
>
>  #define HCI_EV_VL(_op, _func, _min_len, _max_len) \
> @@ -7830,14 +7801,15 @@ void hci_event_packet(struct hci_dev *hdev, struc=
t sk_buff *skb)
>
>         skb_pull(skb, HCI_EVENT_HDR_SIZE);
>
> -       /* Store wake reason if we're suspended */
> -       hci_store_wake_reason(hdev, event, skb);
> -
>         bt_dev_dbg(hdev, "event 0x%2.2x", event);
>
>         hci_event_func(hdev, event, skb, &opcode, &status, &req_complete,
>                        &req_complete_skb);
>
> +       hci_dev_lock(hdev);
> +       hci_store_wake_reason(hdev, NULL, 0);
> +       hci_dev_unlock(hdev);
> +
>         if (req_complete) {
>                 req_complete(hdev, status, opcode);
>         } else if (req_complete_skb) {
> --
> 2.50.0

https://sashiko.dev/#/patchset/f0d72bf42b33441991665b23e293c879.security%40=
1.0.0.127.in-addr.arpa

Seems valid to me, so we probably need to call hci_store_wake_reason
in more event handlers.

--=20
Luiz Augusto von Dentz

