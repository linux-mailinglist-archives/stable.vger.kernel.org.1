Return-Path: <stable+bounces-232682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHS0LeWVzGkSUQYAu9opvQ
	(envelope-from <stable+bounces-232682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:49:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788E374860
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EECE3021EAE
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7037F8A6;
	Wed,  1 Apr 2026 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4iyB75C"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0C2C21E6
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775015350; cv=pass; b=L6eo8K/AaY4HyIkDbfLCTomTdWlq9JcS4D29FAqlG106goIcgvBswZWZEus5Ik0u3nAxoFbU3k65ACxxE0zkQI/NzUAMFv8XvZ8k4OD7wEoPFXY8xhXZookqBILBNlvU76z0reVMeXreD9L9pow68FXIllEXoHSvG2hcXs0Y8Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775015350; c=relaxed/simple;
	bh=Uq0rAon/XHdmSSBnTga+GiKV88qppyF1UmfrhXcY238=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/jbRis+InODDZbrvWnjit1GYIejvDDXBWSTFxhaOGXbA7vNHgVALfqhGBlBYXCj29Eq4Ka/5W4s6JJM7KdNCLjLX1BtuTlu6Bqk6UAlqaXFQnUuyGCLvd/KqMbOhn1a5de9bewMA6/mR4vg9XTPOxsa2vc7xxTlt+PraVEFvyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4iyB75C; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-467161c4a1cso2148403b6e.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775015347; cv=none;
        d=google.com; s=arc-20240605;
        b=fBh0/04E+dbqUenkagtRqB2GDoSDqGfB6BYZ4EQG5kGTY7D6cRcO8SwGVLFN+B1XO2
         Ne9Z16xTFGaLY28jr7pVjbhEPbFN9g15vuE1dD4mwxV+zsNf/LP50jAwiGvysyTkn/N8
         ObGtS+M7VDY5jxl3CqpQJzLRnSRAQvFl84SAN1PlK7qQYL8+IfHYra1bF+A5nBy1ZXb0
         hcpueJI1++aY5HE8AybaaLvgXnVOam8MrYZGF9NmfyG1gawm155UGJW0+MPoanEd7+xy
         eKQNtoyzkHmW3X55Nx7tvHEY4vMiEd4s+lipc79ORieJ+C6d3otC+7y9dMfMD9AS6y7l
         fOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+OMXuhs/r/8PL00D986h01bobDw8jDu72xUXKqnjVQ=;
        fh=MQVhair4QodRJt2fqLMu9gf5CJ6O8/auEKF9rwaWAa4=;
        b=fhL0jeyikHbAhkPPDA/JkBtknWdaSRouaJkQNjzrKal7SMJkgn8rpRIu0gsu0Wmzy5
         1FDdoGubOsY21MrQPT+NYC+y0OPELRvB9lN3SIzYppro0RsyAK7bJcCgMQUe1LLDvGO+
         u05yyTJZUqJNlaPuDYn0vM7JGY6uZ6mHIO0D3TFpTmpplAKXACr/2YLhageVOHmrSvn/
         p+aaE+fWTF3Qls/K6GjnfZo9BLCP4sJCpS17ydlvLou2mgse7hMe4FjCRDuAt1Nv2JUr
         +NrM6+ekXfeQQ8mZTGdOCWHSC9pqRLICCOsTakrTWLw5mfLIF0Rc8NLIHA5CLf/uTwpI
         420Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775015347; x=1775620147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+OMXuhs/r/8PL00D986h01bobDw8jDu72xUXKqnjVQ=;
        b=d4iyB75CzkvvBsICj2nOKenaGWHUbaFzrQYt8Y0OGdP+cTP/LrOLMv8/kUBfv02Bcz
         ftqEjLekOaNyHglyy1U0f9ffEj70WsqsU170kRbmFAr7WK+KqV4LzBMJJQjfUTXURsng
         OX2ag3D25elhiL1KwnamSpd2uc8vpMbPnL2CxhFuLMxGTQNStkutY5GpLbDUGD8xC5Xk
         1KWdCv9FdNUoTJUQCuBIefqh2MEnxox3L8zaWJ7KztfzZL4IsnV7snuHrBzev6H2gt6p
         qUZAJbYm/g570EHTONnFp0WkosjIgVjNwfSL3ERSJbG9X1cBaWR9kASQXnosHPnym5JM
         MqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775015347; x=1775620147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+OMXuhs/r/8PL00D986h01bobDw8jDu72xUXKqnjVQ=;
        b=StTZArdw1RgVBebgUF767i8+pKGrdxQ18wsMIjmmfKBhocywTI7UtblEp0rjD2Cu9Y
         tzTNxVc8SWLV2lsea3we27pQdVKYvIDs53KsI93btBzDJz1iY1Y/lBK1EcESXgP6HeQa
         UGirXrB8mAoyXsVixNmO+OBU1CDi63GB0Ca+tprtDv3oFDCw6SGRK9KojpoGLUBfI7C2
         ao1+meMvYOTQSDcXOUoP6FnGmsjdlRd5jfrFpWIfCAekN6tTAvcG2wFC/ncBRlPh170u
         8hCj3JosK3R15YITq+B7PuhaK55e7xTMzG45QcQMkTEKbz6XGDjP1FD+IfMNmW1NgR3+
         Gvfg==
X-Forwarded-Encrypted: i=1; AJvYcCXYi4MS2D3OeIgAjZ9Q194sLpjIjuJs7LmIyHQvmqsXyXQuT81NuWTHus2LJDqvNOqg7f/vdN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xoUmkmM7fIuyBG111aYAj5yqNTmWBKbCkwawBPZxscT7XOLf
	KgEqvnGiF6LyUDYdzWlPoTgZAfUtKOqgUgiLXTJFHg7Ylw6VE/5yGSefvpR21UQrXyVysTcG4bb
	HBJNJhqDT5epjStKlObAY5Fkje6Eo2Ofpzb52ZGw=
X-Gm-Gg: ATEYQzz2nAnby23ShJpRVFYfcb3PYaLEdDrt6gKL3ZgCtmxgHYscCRySOvot/Va8tBd
	eMihjOxtM/s4x+SGfQ7RXBVBV5W8Y9IF3WbnrkOqZmbTJjNeIOJXQWm1eKxbKUHa2uRfP1VQguj
	1XnYEN1p2A50cFisT4+QyeVnUS/ojuO6gZNH8pw56frImJ0kYuOzUACIdrGUHEgjYFbszzSfTqn
	w29jkGba/OqtHr83nR4+0kBmGPse95SJIJhuzp4HHbemsZdhH4c4fuTvTU5IRUjkdOiFz3VvjQZ
	1iRa1u+h2+2Swj0vuMQJTn5U0KQ1fZfXMJU9
X-Received: by 2002:a05:6808:670a:b0:468:12a9:d54e with SMTP id
 5614622812f47-46ae01a4d6bmr959369b6e.44.1775015346973; Tue, 31 Mar 2026
 20:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com> <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
In-Reply-To: <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Tue, 31 Mar 2026 20:48:55 -0700
X-Gm-Features: AQROBzAgTA2ff2-kt_ct7XRR7Gwg-3n1Kuixh5FxrNWnH7tIskkJ04PtuD8AQf0
Message-ID: <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-232682-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:url,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2788E374860
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 7:08=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
> > From: Kyle Farnung <kfarnung@gmail.com>
> >
> > Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> > reliability issues similar to those reported in [1]. These platforms
>
> how similar it is? can you describe the issue in details?

The issue is that intermittently after suspend my WiFi adapter connects
successfully for a few minutes and then drops. It will then keep trying to
reconnect in a loop but never succeed. A reboot will fix it, but eventually
I found that reloading the module also resolves the issue
(modprobe -r ath11k_pci && modprobe ath11k_pci). Based on some searching, I
did try adding "ath11k_pci.disable_idle_ps=3D1" to my kernel arguments. At
first it looked like maybe it worked, but then I hit the same problem
again. At that point I decided to try building a custom module with the
ATH11K_PM_WOW override and so far I'm two days and 10 suspends in without
issue.

Looking through kernel logs, the issue appears to have started with kernel
version 6.17.4. It looks like my Fedora install jumped from 6.16.10 to
6.17.4 on October 22, 2025 and I started seeing the issue two days later.

Here are the logs from the most recent occurrence (filtered for brevity):

Mar 29 15:26:24 kjfp14sg5 kernel: PM: suspend exit
Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: chip_id
0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: fw_version
0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
Mar 29 15:26:35 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-CONNECTED - Connection to 68:d7:9a:2a:94:f8 completed [id=3D0
id_str=3D]
Mar 29 15:26:49 kjfp14sg5 wpa_supplicant[2373]: wlp2s0: CTRL-EVENT-BEACON-L=
OSS
Mar 29 15:26:55 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: failed to
flush transmit queue, data pkts pending 9
Mar 29 15:26:55 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D4
locally_generated=3D1
Mar 29 15:27:00 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D80:2a:a8:98:26:3e reason=3D6
Mar 29 15:27:05 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D74:ac:b9:df:54:36 reason=3D6
Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D2
Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"Batman" auth_failures=3D1
duration=3D10 reason=3DCONN_FAILED

>
> > were not previously included in the ath11k PM quirk table.
> >
> > Add DMI matches for product IDs 21ME and 21MF to apply the existing
> > ATH11K_PM_WOW override, improving suspend/resume behavior on these
> > systems.
> >
> > Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> > [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/th=
inkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
> >
> > Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machin=
e model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> > ---
> > Changes in v2:
> > - Fix missing mailing list recipients (linux-wireless, ath11k, linux-ke=
rnel)
> > - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-cf2=
fa39cc2d5@gmail.com
> > ---
> >  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wirel=
ess/ath/ath11k/core.c
> > index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb=
9c93d9ef692d127fe 100644
> > --- a/drivers/net/wireless/ath/ath11k/core.c
> > +++ b/drivers/net/wireless/ath/ath11k/core.c
> > @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quir=
k_table[] =3D {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
> >               },
> >       },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G5 AMD #1 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> > +             },
> > +     },
> > +     {
> > +             .driver_data =3D (void *)ATH11K_PM_WOW,
> > +             .matches =3D { /* P14s G5 AMD #2 */
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> > +             },
> > +     },
> >       {}
> >  };
> >
> >
> > ---
> > base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> > change-id: 20260330-p14s-pm-quirk-0a51ba19235f
> >
> > Best regards,
>

