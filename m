Return-Path: <stable+bounces-230499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMdlJFJhxWlM9wQAu9opvQ
	(envelope-from <stable+bounces-230499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:39:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF113388D0
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D563E30A0887
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF1F40B6CE;
	Thu, 26 Mar 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHRVaCij"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434253FF1
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542861; cv=pass; b=sme2YghgumJthR9z360u1lyZ4ZmP6o2OR9Bqo9SCOfqQ7Qfm4p8ZkMXtgC5ytfwhlXd5I4GolQP3w9LOg91cgHHjb1e4BSP+6dS5NAcFMv6rX102ri+4peF/IwfGMAr1ZSjNaV+1QmN1Kfj15gbUH+XCvNBYtdJins7S7yjRlPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542861; c=relaxed/simple;
	bh=eWK763odSd+RITsFu0TL+8Tv8kosnaCAYUAgpNhYL3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ql6nKV3+hYQjvvDI++0iX37rgmAYaEgoYKpOvHB3bt6DlIAfrG6iA8iYfZONfm7sXO1E4SQxTNYe90RgC2UawvZ9wPlG4cMU0dRQyOGCfrpq/DCuIgrptCDP+ybBuScOMpRQS5pWdsVPjs9VTOBhtLkr9X9NW6z9mJ/eVXOtiQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHRVaCij; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-649278a69c5so1147649d50.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 09:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542859; cv=none;
        d=google.com; s=arc-20240605;
        b=CZzyA/sFF2Fv7k1k9+8ZXzSAaXBn9ledmO4pEWiQMOS/86BRZF/oa5k1aUy9CYiVUj
         6wtVbigeo2GXTg4Vdg9ifnr10UhPxvctE4DEQMyloYSwYcMcZ3MXkcRDZ3NjPTR2PTJ4
         d+077kP8Y8igPbGOmWRmSVNBrDKiIHJTRZXCyHvXcWovSQg2sDa+RbNzAWX/8LwHMAs3
         zrvzDGbBmJ7ffzubnuAGPaCYPMh0nQ+P+eXD+/pcc4unbyGNKKacrD2cFS6ygDLIVYM3
         tnXbtaQ6zZPAr/kyv3YUJ/U/vURHoHfA+wSk0yOiS2xJ2Q+u1Fwwg9D2sTRlpG1i3ohE
         jSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=11ZA0CAg+pKLn2xyVYStQmO75u3YDSroNUhodO9+5yc=;
        fh=SpoS7PHEEJIGB5uGshWtq1fP3xGfwkS0/TMgaRbWhRM=;
        b=YhjVpbW3ursCJI+UpxRBm/RHJCPLNpLUsSwSOB9zYxniPhN68rExo2qvCI4m0u/u24
         fhTks0fOdfnE4csiNQmPhOsqsVJzkFiqMkra9bG6d+4bakslsFQK60BygvP1rVg8zeot
         Ri3Etgw5kVWCl9/cYSrh0AZgao2T30YwRdwee2zaf6b+RJm/9+iLtEpnJ2KRjzdW9iwq
         8RP0WI3bsqdY43gKJZ/9zei7MrTHwjd4LVHE22SIn/W0R//+ZbJMbgwhe/UKvrcDE2mW
         hJp6y735+jOm9UDZ35aw9bTf+u9NCEauCt1AjVgscYNz+p5PMau52tukzi58NIyw4MVy
         k4LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542859; x=1775147659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11ZA0CAg+pKLn2xyVYStQmO75u3YDSroNUhodO9+5yc=;
        b=EHRVaCijwAMeis70XSZaQoNml1yiQuphZy0aQHwz7UFpoGF/QBMFcAEIBuR6wJLQkn
         fkxwNFFxn9PWdJ68yia2/zN+hNntt+dOH30vt1Dh2yhYeY4QAfJ59sL9U4AfPSkoEx/X
         TObDgYrRTluQIlRsxXzprVGpyfemrWQA9cC7Pspf/oRsQ2RnEmpQfBN1K3RJUTASN67A
         +r1y1Vmygj3FoFen6no9KRbZ+00/yhNMvv9E1EsIz77fgrg0KdbxqMz0g2FWiU8DzLrJ
         XARLHEKcrcgiOyS1VilP1xXbRtcG53ZwuE7JSocau2JkKEDaKyFXi8f4fSyuLYX8Y2gf
         uHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542859; x=1775147659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11ZA0CAg+pKLn2xyVYStQmO75u3YDSroNUhodO9+5yc=;
        b=MRAki6Kq28tybXjB2oXi7M6oad7p8POp+/IBPSE7iy7v7NPwEVhNnrC9QYwVs51j8r
         YMufemgCsNoQNZ1aZ5rP2hlUzTLA9J9sEDVhpu4bYzSxvYF/ZNgRgKebtWeVseXB7Nlq
         jAeWP90m2/aHfdnEwfYbk15cKVvL6vOkhuvC25b6LpSAy2mi3cw8z1OFjEoG7RCozosJ
         9OUpu+je8y1zMtDTJc+vC2XZcgvGn6jjvfhsOHFF/qcA+6bKpLRmqT4q/WXcmhNls9JL
         oHzyVGu2uaGRC4SKoF/RFWSeqAoBVXyx+u7izFLjSNZtlGw8oM5tthvx/vb6l2YKOVYy
         1rPA==
X-Forwarded-Encrypted: i=1; AJvYcCWre+k4Od0NBPg7maTqaVZDKWmQHbXky+sa/SAI5Nv0oX7XdRGENi0xWHt4LsmG93U2AmPk9vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5fPEYnYH/8woLGeU+1mwb5azol0+ZlyLP8jZA+ksAXrsJeha
	i2SKEeyvU+9uXKEOgGvLf0lbY0Qion0L2U/tCZoZSDSRuGPPskMwXvlEyVVs+9vl1sn3BLlmVNK
	fYBaAxIqAnFAR++KNfeQ8wh9uzBmKOhmvIerT
X-Gm-Gg: ATEYQzxV/S3jBwMoT/cvwQDuVi+j1cnBNKyeq3A/qq34qVdbsiPff3WsVfxPGY08vdf
	6wT/AHvKwjvby/NxVNqVIPcNtosNYOIYkaVmGhRcOhcSDrs6mtJT/5WchEkwBPVJfA0V7fleZq8
	248i34G1HW1OggGjTq+DusEUpgPtOUyoeCC85LfgYOX+TjGMt9Ue2+Vo0hrwvKp4RUihcFNwvdn
	+mX2vQSxkQxvnGnmtmzEauGMvTt1l8IBjJQd5j6PQ8ku7CRLu1Uz66nTxzB6C1Bbloh0eRRsFgN
	cEdKE8sGmiYRCYCzJeqV68bY5aeeAtaOjPdtpJf4c8PdYxjZIOvQMlvu+buHayiVeeH+CQ2heAg
	gv9DY
X-Received: by 2002:a53:b708:0:b0:64c:b7c9:dffd with SMTP id
 956f58d0204a3-64ee613febdmr6574503d50.58.1774542858977; Thu, 26 Mar 2026
 09:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b8a0917d56b4a67ba541e8a5eb3abb8.security@1.0.0.127.in-addr.arpa>
 <2026032626-rinsing-component-ed00@gregkh> <PA4PR04MB767961D26B5B1D402A7328AF9256A@PA4PR04MB7679.eurprd04.prod.outlook.com>
 <PA4PR04MB76792C61C4A06C089ACC4A689256A@PA4PR04MB7679.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB76792C61C4A06C089ACC4A689256A@PA4PR04MB7679.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Mar 2026 12:34:07 -0400
X-Gm-Features: AQROBzAw1P5BKdk8Xzoyg39QliwJx-P5YS8DTaO9YFAX6tsdLyhxnvNbyt7JOPw
Message-ID: <CABBYNZKXqe2qDf-j8AxD1s0TD1x67EqynyZUUTSWDmrLDpEKtg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
To: Oleh Konko <security@1seal.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230499-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,holtmann.org:email,linuxfoundation.org:email,1seal.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CEF113388D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Oleh,

On Thu, Mar 26, 2026 at 12:22=E2=80=AFPM Oleh Konko <security@1seal.org> wr=
ote:
>
> v5 now applies cleanly and gets through build/sparse, but the
> current CI run still shows runtime regressions (mgmt/iso/sco/mesh).

Those are probably the already existing errors, so no need to spin a v6.

> looking at the delta, the most suspicious part is not the move of
> wake-address storage into validated handlers itself, but the new global
> fallback after hci_event_func(). that changes both timing and semantics:
> it adds a post-handler hci_dev_lock() path, and it also changes the old
> HCI_EV_LE_META fallback behavior into MGMT_WAKE_REASON_UNEXPECTED for
> cases that previously stayed on the remote-wake path.
>
> my plan for v6 is therefore to narrow the change:
> - keep wake address storage only in validated event handlers
> - drop the global post-handler fallback in hci_event_packet()
> - restore the non-address fallback paths without reintroducing the
>   pre-validation dereference
> - handle the LE meta fallback separately so its old semantics are
>   preserved without touching unvalidated payload
>
> unless you object, i'll respin in that direction rather than send
> another blind reroll.
>
> thanks,
> Oleh
> ________________________________
> =D0=9E=D1=82: Oleh Konko <security@1seal.org>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 26 =D0=BC=
=D0=B0=D1=80=D1=82=D0=B0 2026 =D0=B3. 16:06
> =D0=9A=D0=BE=D0=BC=D1=83: gregkh@linuxfoundation.org <gregkh@linuxfoundat=
ion.org>
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: linux-bluetooth@vger.kernel.org <linux-bl=
uetooth@vger.kernel.org>; marcel@holtmann.org <marcel@holtmann.org>; luiz.d=
entz@gmail.com <luiz.dentz@gmail.com>; linux-kernel@vger.kernel.org <linux-=
kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>
> =D0=A2=D0=B5=D0=BC=D0=B0: RE: [PATCH v3] Bluetooth: hci_event: move wake =
reason storage into validated event handlers
>
> hi Greg,
>
> thanks. the embedded headers were a formatting issue on my side.
>
> i have now resent the patch as v5 with proper inline formatting. this
> revision also adds the lock contract you asked for:
> __must_hold(&hdev->lock) on hci_store_wake_reason(), plus
> lockdep_assert_held(&hdev->lock) inside the helper.
>
> thanks,
> Oleh
> ________________________________
> =D0=9E=D1=82: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 26 =D0=BC=
=D0=B0=D1=80=D1=82=D0=B0 2026 =D0=B3. 15:57
> =D0=9A=D0=BE=D0=BC=D1=83: Oleh Konko <security@1seal.org>
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: linux-bluetooth@vger.kernel.org <linux-bl=
uetooth@vger.kernel.org>; marcel@holtmann.org <marcel@holtmann.org>; luiz.d=
entz@gmail.com <luiz.dentz@gmail.com>; linux-kernel@vger.kernel.org <linux-=
kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>
> =D0=A2=D0=B5=D0=BC=D0=B0: Re: [PATCH v3] Bluetooth: hci_event: move wake =
reason storage into validated event handlers
>
> On Thu, Mar 26, 2026 at 01:32:50PM +0000, Oleh Konko wrote:
> > From f0e8b2abaf4a895fad81756277014582c773808d Mon Sep 17 00:00:00 2001
> > From: Oleh Konko <security@1seal.org>
> > Date: Thu, 26 Mar 2026 14:29:58 +0100
> > Subject: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
> >  validated event handlers
>
> If you use git send-email, the header will not be in the body like this.
>
> > hci_store_wake_reason() is called from hci_event_packet() immediately
> > after stripping the HCI event header but before hci_event_func()
> > enforces the per-event minimum payload length from hci_ev_table.
> > This means a short HCI event frame can reach bacpy() before any bounds
> > check runs.
> >
> > Rather than duplicating skb parsing and per-event length checks inside
> > hci_store_wake_reason(), move wake-address storage into the individual
> > event handlers after their existing event-length validation has
> > succeeded. Convert hci_store_wake_reason() into a small helper that onl=
y
> > stores an already-validated bdaddr while the caller holds hci_dev_lock(=
).
> > Use the same helper after hci_event_func() with a NULL address to
> > preserve the existing unexpected-wake fallback semantics when no
> > validated event handler records a wake address.
> >
> > Call the helper from hci_conn_request_evt(), hci_conn_complete_evt(),
> > hci_le_adv_report_evt(), hci_le_ext_adv_report_evt(), and
> > hci_le_direct_adv_report_evt().
> >
> > Fixes: 2f20216c1d6f ("Bluetooth: Emit controller suspend and resume eve=
nts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Oleh Konko <security@1seal.org>
> > ---
> > v3:
> > - route the unexpected-wake fallback through hci_store_wake_reason(NULL=
, 0)
> >   after hci_event_func(), as suggested in review
> >
> >  net/bluetooth/hci_event.c | 89 +++++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 60 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 286529d2e..c0e0b4a1c 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -80,6 +80,9 @@ static void *hci_le_ev_skb_pull(struct hci_dev *hdev,=
 struct sk_buff *skb,
> >        return data;
> >  }
> >
> > +static void hci_store_wake_reason(struct hci_dev *hdev,
> > +                               const bdaddr_t *bdaddr, u8 addr_type);
> > +
> >  static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
> >                                struct sk_buff *skb)
> >  {
> > @@ -3111,6 +3114,7 @@ static void hci_conn_complete_evt(struct hci_dev =
*hdev, void *data,
> >        bt_dev_dbg(hdev, "status 0x%2.2x", status);
> >
> >        hci_dev_lock(hdev);
> > +     hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
> >
> >        /* Check for existing connection:
> >         *
> > @@ -3274,6 +3278,10 @@ static void hci_conn_request_evt(struct hci_dev =
*hdev, void *data,
> >
> >        bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_=
type);
> >
> > +     hci_dev_lock(hdev);
> > +     hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
> > +     hci_dev_unlock(hdev);
> > +
> >        /* Reject incoming connection from device with same BD ADDR agai=
nst
> >         * CVE-2020-26555
> >         */
> > @@ -6403,6 +6411,8 @@ static void hci_le_adv_report_evt(struct hci_dev =
*hdev, void *data,
> >                                        info->length + 1))
> >                        break;
> >
> > +             hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> > +
> >                if (info->length <=3D max_adv_len(hdev)) {
> >                        rssi =3D info->data[info->length];
> >                        process_adv_report(hdev, info->type, &info->bdad=
dr,
> > @@ -6491,6 +6501,8 @@ static void hci_le_ext_adv_report_evt(struct hci_=
dev *hdev, void *data,
> >                                        info->length))
> >                        break;
> >
> > +             hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> > +
> >                evt_type =3D __le16_to_cpu(info->type) & LE_EXT_ADV_EVT_=
TYPE_MASK;
> >                legacy_evt_type =3D ext_evt_type_to_legacy(hdev, evt_typ=
e);
> >
> > @@ -6834,6 +6846,8 @@ static void hci_le_direct_adv_report_evt(struct h=
ci_dev *hdev, void *data,
> >        for (i =3D 0; i < ev->num; i++) {
> >                struct hci_ev_le_direct_adv_info *info =3D &ev->info[i];
> >
> > +             hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> > +
> >                process_adv_report(hdev, info->type, &info->bdaddr,
> >                                   info->bdaddr_type, &info->direct_addr=
,
> >                                   info->direct_addr_type, HCI_ADV_PHY_1=
M, 0,
> > @@ -7517,73 +7531,27 @@ static bool hci_get_cmd_complete(struct hci_dev=
 *hdev, u16 opcode,
> >        return true;
> >  }
> >
> > -static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
> > -                               struct sk_buff *skb)
> > +/* hdev lock must be held. pass NULL bdaddr to record an unexpected wa=
ke. */
> > +static void hci_store_wake_reason(struct hci_dev *hdev,
> > +                               const bdaddr_t *bdaddr, u8 addr_type)
>
> If the lock must be held, why aren't you both adding the static test for
> this at build time __must_hold(), and the runtime lock test so that we
> know this lock is held?  That way any changes in any code paths in the
> future will properly trigger at build and runtime to know to be fixed
> up.
>
> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz

