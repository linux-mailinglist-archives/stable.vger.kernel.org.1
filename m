Return-Path: <stable+bounces-232966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J4aMCpBzmlQmQYAu9opvQ
	(envelope-from <stable+bounces-232966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:12:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3660638788A
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7CEE3018C03
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B638B14C;
	Thu,  2 Apr 2026 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkUjSIHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CE3D16FB
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124315; cv=pass; b=VEAGDAldZ0b8nMVmZGoam1CBdEdRuYNrp3KEqVzCbYd0TC/ydAwMqHQIhd0ZPm/AmZAJoO8+yIsfRnYNiQSVDep47I7E+jVkFD5pJnFBoZLJ+n7do4NXYFg2O5yS2ygy/SWfB+6nqN5y8ue0XpTA/qPb3w7A4KnJreDG+ipAZE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124315; c=relaxed/simple;
	bh=OsiL/1pwgaLk9UGEMEVqaS1tHbhO879gXMnD9GeFmM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOEk8NoR+tdlWqxeoEu5M4fGEEL/X4ILd72H0X8QXbC5brjuTmr1HU1M45gu2WWT2gO5M5a76XSZu8gK7TusD/CGlBfiZPE9VjS2KvyXsjRd+jXsaNx9JExt52qSkHlM/A9cypYrqMtB7zhvs4xyPj8enAEScdhgbQY/Tvryw3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkUjSIHI; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67e23011c93so248344eaf.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 03:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775124313; cv=none;
        d=google.com; s=arc-20240605;
        b=T380da9tQcrsD99VaMdv2oyWSMZltlgdnMPBe65oc2Mv2lPJGn0GpmDBebfJ8reqNC
         AUFXGZeB5pSZMGeaL2j2SmQyuIiRzfIGX8yAI5JgvzUosQ9abb/SGMvKhaKAPAiPpx5X
         LazrcVrl/AUwiHBXAe4H5Ww8ZRnPnJx7ci0g9TyjWF6GVNXehj65Ur3BJbBuvbKyx+DA
         izqANAk4tnh7l2DF4gPucYPkToS4dxM3+P/h6GW+086g9Y66HPONT7PLUjQe8jxL4Try
         CNWezs5GuCMFaCsCaADFOfa3wu5CBx42cCa880Q3I68/bFuRGYNOKdkDZX3wmh1PQIyp
         90lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Z0F0LSV4rb0+tEeskaVV3h52HTcTsqrrJt52KWcr8c=;
        fh=lDEEfhhSAMDKKJBvj5fxoM3omncMHluDkNRg7x0hOkg=;
        b=Muw+2oN7xt6cPMzN/mIqKr/2b/KwJi6k/RPuFjZvGaV53bTYtB84rfymjGJJaSdEmb
         0IuKGeRlpHI7flklQmq3jH6tSgKouNcwuhUlRG930CMO1lWDsIrHv1fCCLrU0b+B4c8t
         eWGi/rv54XtuJ3Q1+J8OjmlyzfW4wSLzkOevjoPGsmXv1UKydBWy3pIxDFRvMGu1dT2a
         igIeIXmhQh46PgxJYwJU4gPss/9T/HFHTItsOWiePQnmzd2FlfN4rPOxT394yN4wkzLc
         /qmU+pkEXxyufZouQl1f/NcmnHo9l4QWiXyeD5N7kC8VdNBSDvJHTQQVJSCA8N1MZntE
         919w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775124313; x=1775729113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z0F0LSV4rb0+tEeskaVV3h52HTcTsqrrJt52KWcr8c=;
        b=UkUjSIHI1U703viqbTydlU4JHi7AFAl51AUpCMx9b+wVryiST9od87YB4RwLXhKC7u
         l1jt1voRP5Mgg0J9rUDkORvIYjtHKc1q4cFgy9vQowZ1mSYQLEYH22A6IRr1yCaQ6t6H
         8hd0UZ5DO1+4d/OzgIsSmaLeoLGZj+cdrf7jySzpiknlouXB2ZZsjsycsIo3y8Ft5IGp
         evKaQJbKktL19N/SqAtcNIy3qOD7QOcIA7LKwPnBtPbNcEq7z6OzA3CGT+ZBJlW9r+Hg
         Ul0KYMmbBXL1u2qAVj6FsUqGa5Ir4a2xrVKODmmTypPrRYTgIc7iZLKRoS//MYNeC7JU
         pOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775124313; x=1775729113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Z0F0LSV4rb0+tEeskaVV3h52HTcTsqrrJt52KWcr8c=;
        b=QSreQDDBoYCsNpNPg8SB+ylJtjW0RF7EjFtKu0Fz0tp1me/vgDrvVptMwZ7fsLjvTq
         wfTB4vIYg+/Jub3wWqQIchhsf+r2p3hO04PmsNS0kGSdHcTwlHGaECAQUVLaY+g15stI
         BhSpBziOlXnxIJ/dbTpz6qDtX7YUOWyN/v6bUqTVpl8GxFIdu8XZLj2WzcU2bAFWUBjn
         cCofTVCSwBn1dADZxCdtdPAyoEa745ga3i9VGCxug8kJkV+qRPpHkRJFISN8W/qq9ucp
         MxqIzl7/zGlPu9zrN3D4sn35v1EN2c3UpTE9pTsBWssXuhvKeC8snUFOnCDb1yJxHtXg
         p+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXkbby8VHqX/rL2gSO3Vvemr979bkLtxMVKVEnTenXeA5Oj6eqhwk1hhEEP/EQOn76vzwAvBIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxll0FY3VpZHp1hHwyaH5Uaom7n3oWsTEAkgUMNopqnVjKhJlho
	n1Kim1Iy3t2VmTIv5/9YuUnrfn9rd/K64YiAZ/ha8fUpDtKoGnG2KWgLzn2hivK1WKcXUXgR31d
	eBewjOMus3Wh64pY2uKD2W7cjcJrDPC0=
X-Gm-Gg: ATEYQzyrqEs6qsjgiol+tOHRgVB6X4ktXJ6wDd6fhJPdIUR9KTVERWF1wNMQwGlmect
	LIlpahb2u8JMkVjF9CMxDI11CrJtTUxgRGrjBrYor7py0aLgBpnsLEky9oQ0PcXiGgDz72JDQzs
	DrM77vo6sJrqMFasMCLzjsAPCwNOsO7MnXiijE7I4UGF7WQZHs5gDyBy3tqW/WwTY6lbATjcMMl
	UDh8Wq21KxHyAf82pDOaZZc+rqNqfxj7s9kvtGaCmmNtujzZya1r+czVBI/OjYMbWBEc16yj/bl
	qlkq7UEHDjsRcwUFE5pgzg6Fb9FY9tx7ba85U8jIlcbHE3qFQjlKJOI98ey7w0K/ab+1uQ==
X-Received: by 2002:a05:6820:3087:b0:67e:3265:1659 with SMTP id
 006d021491bc7-67fabd0ee58mr3470951eaf.62.1775124313530; Thu, 02 Apr 2026
 03:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402083722.100973-1-fabio.porcedda@gmail.com> <ac46YeSJeYVvm0Hn@hovoldconsulting.com>
In-Reply-To: <ac46YeSJeYVvm0Hn@hovoldconsulting.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 2 Apr 2026 12:04:33 +0200
X-Gm-Features: AQROBzDG6MB7MLj_5-xfUluKajqLUUg8YfN3uzie3Tuh6LKnQWHoKmLCh6Jmgto
Message-ID: <CAHkwnC8avsKQFdbGZ=sTgjhWgoykjH+nLm=si8J5siwr=DkB7Q@mail.gmail.com>
Subject: Re: [PATCH v2] USB: serial: option: add Telit Cinterion FN990A MBIM composition
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Daniele Palmas <dnlplm@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabioporcedda@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3660638788A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 11:44=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Apr 02, 2026 at 10:37:22AM +0200, Fabio Porcedda wrote:
> > Add the following Telit Cinterion FN990A MBIM composition:
> >
> > 0x1074: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (diag) +
> >         DPL (Data Packet Logging) + adb
> >
> > T:  Bus=3D01 Lev=3D01 Prnt=3D04 Port=3D06 Cnt=3D01 Dev#=3D  3 Spd=3D480=
  MxCh=3D 0
> > D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D1bc7 ProdID=3D1074 Rev=3D05.04
> > S:  Manufacturer=3DTelit Wireless Solutions
> > S:  Product=3DFN990
> > S:  SerialNumber=3D70628d0c
> > C:  #Ifs=3D 7 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> > I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D02(commc) Sub=3D0e Prot=3D00 Driv=
er=3Dcdc_mbim
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D32ms
> > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3D0a(data ) Sub=3D00 Prot=3D02 Driv=
er=3Dcdc_mbim
> > E:  Ad=3D0f(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D8e(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D60 Driv=
er=3Doption
> > E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D85(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3D30 Driv=
er=3Doption
> > E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D88(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 6 Alt=3D 0 #EPs=3D 1 Cls=3Dff(vend.) Sub=3Dff Prot=3D80 Driv=
er=3D(none)
> > E:  Ad=3D8f(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>
> > @@ -1383,6 +1383,8 @@ static const struct usb_device_id option_ids[] =
=3D {
> >         .driver_info =3D NCTRL(2) | RSVD(3) },
> >       { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),    /=
* Telit FN990A (ECM) */
> >         .driver_info =3D NCTRL(0) | RSVD(1) },
> > +     { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1074, 0xff),    /=
* Telit FN990A (MBIM) */
> > +       .driver_info =3D NCTRL(5) | RSVD(6) | RSVD(7) },
>
> There is no adb interface in the usb-devices output in the commit
> message. Do you still need to reserve interface 7?

The output of usb-devices was not complete, I've sent a new version
with the full output:
https://lore.kernel.org/linux-usb/20260402095727.108281-1-fabio.porcedda@gm=
ail.com

> >       { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),    /=
* Telit FN990A (PCIe) */
> >         .driver_info =3D RSVD(0) },
> >       { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),    /=
* Telit FN990A (rmnet + audio) */
>
> Johan

Thanks
--=20
Fabio Porcedda

