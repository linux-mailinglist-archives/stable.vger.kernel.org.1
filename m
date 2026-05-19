Return-Path: <stable+bounces-249589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD+hLBppDGo8hQUAu9opvQ
	(envelope-from <stable+bounces-249589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:43:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE357FE92
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF27330566C7
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E6370AEC;
	Tue, 19 May 2026 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBUMJ0D5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534F35202C
	for <stable@vger.kernel.org>; Tue, 19 May 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197867; cv=pass; b=eauf1lMNR1pB6NyYGBKTGdgnUYLcUEwK9LcMPEtKwvh4+Qh8w7KS12kd+k0QW53nLJLAOYqMqiJuqwHr+ksdhTx9/gF/I57GySynl3Bpuv+12PHxCSAhY9wi+7Y6AuB3ESk8ufCpCGtenptYyADFC2RmFGiS1F3+uUlUdDO/urQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197867; c=relaxed/simple;
	bh=a+6vVJmOZ3ZG/v6p+ChaawK/jURoxlUIsJFp9JcF6Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnqNzdc+RKjbPoqrUuWgFXKpbj7komN3PEVYwH/c8qaB6HLNtDXH/kYQ0HLLAJqKas32nE8CNeMUWiSughCuleJf3rA6W98GN1njxMiBy265tm5rzYXq0WCdkL0g9sstgyqS87tXvUENo5orLtF98NuHZ2V4EdAi/INAEbP9vbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBUMJ0D5; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so907279f8f.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 06:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197862; cv=none;
        d=google.com; s=arc-20240605;
        b=TUFJLYfmA9EIKXa961dj6Dl1paauVUCEtgDtu+tX0LXsUsBwgmi6D1nD01jJcD3tGL
         IwrVGGqDa2Tx7p7pX51Vjsg82jw89SJIRrER0A48ZaoO4pi34XykvNZdbvbC4wAMpVRV
         B4Ex05AS9SAqm830v2t+E6A1GlZMlztFkVzFd1Pm1EhvtBGH4X6d/XOMdJipX7Em1mgG
         IE9L5rpO4jv0BuS/Ym1nbD5HeznSN1ZubfzocD63ZeohyUKWh7v8UGrYJzqJq5EEBBxJ
         EkE21ZH/amgPoCfzdz4Mo0d+W2mlCRsYA2GguuiB2vDw3IxZrn2kmS0pDvbAzrMTdpm9
         kbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/ja8jc+FHQMYyLaMU5qKpBDmFJx8YQVV0WGsvU+fWE=;
        fh=tsPic/YrpGH1hUPH6cWtoBjB/fKXqxBx5eV8w7cJ4kQ=;
        b=lRBJTuQXaIHyhXH0jr5l7Rbv4Y2yxcI7c+ZpmSTlFBZyA2py+I3RBgSg2DxK6UrgG2
         v50+dn/mU6RL+wqMxMWxoc4zeFn2viE8lNfkIdwjJzfVidMI6+1CdHZHiOYDqplkx97R
         EygSnWuFvtrPRrzGO7+CiAD8OeUSDzUI+jFBUYeplyn/oMjIv3YaB/wrHI6dpBdpSUH4
         wXVNHwxs/FuF3pEaM60yLXnMPv09dbTlQpszqYNP2M5M89iBjFGvvK2tLPA0Uz+QjXat
         /dacbWmH/IU2n4350TDRjfUfTzSYYyR9HwlNl59mDH11dNIpNOip+zufF0vIL0024rYM
         dNnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197862; x=1779802662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/ja8jc+FHQMYyLaMU5qKpBDmFJx8YQVV0WGsvU+fWE=;
        b=eBUMJ0D5qz5yuUY2vA1ejwq6sp99nSXgj5qOPe57Pxoy/dgBM41o2zA3YFlbLk5lS0
         3KO0USOyZnalnhnkLaAJtpU6W0BAR3DF1vnl59RNsypd82qmIQ5VV/wPUKP8ZP/PF3Nk
         QTV7fbSicD61E+ehBaU5uoVgLLWYz10/NPkFtJ7KRIcymmZLGuf30WqmKR0nGf5Er3z6
         Px2QCL6bl+DfbsJQrUJ8vYj8vHt1t8lABrQyJ75Tl3h3I1I2g59IQN3JokcOsVSwpC/S
         Gi0hEV/UqtbVUr8IeB0kS4Q4YTr3LBU03fI/YbY8I6naR8OdX7jOvf4fZbppA+AYP2kQ
         /pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197862; x=1779802662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/ja8jc+FHQMYyLaMU5qKpBDmFJx8YQVV0WGsvU+fWE=;
        b=tU6F9/12uNQVCBBnEtRvJ0kGdZuyI26WP0v/wrRGOnBFmValAmZNKiRCeJ4+oOtcwM
         /dAiP8Ccha8sptufo1gwXYkRsaYyt34PS7OA7SZr3g/f0LPohubf0uvN8VwsFFwkxmS9
         Z4wL1y8ywTol/wkp0sB+/arpFvrHN8zFSu/fSJb8OrfEu3qRh8ClBLy9M1i/3WAgH8Bz
         zjmb3QkmUKVeYf/iYFlONNgd8bArWPnlQRAhCZboTaUQ+/g8zcQFrfMcotamVrKFBRXg
         2EnofeBqXDme0unhzEePIGhdTwsJaFv5WUxQ28HEpVhFhlPHAePZSlXYUllBl8PsBl2Y
         Dufg==
X-Forwarded-Encrypted: i=1; AFNElJ+NZ2oE/gDESOiyy0IGP6b0z0Q6GSH5iQT5MHUMcVG6VxJlm53EhCM6ul2iUh3YkMAefw3Xwqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKt1/gmKehQXTOReUTDFoeCKSgu74U1Tw4g8aMZ61HhJYOK33C
	AI0+rAIODtGkvmMGvEmUzhy/TB+NWSASuAy2Pk45jXt1Yw/5QlneIZWAyOZThzKsGYg3qbelizO
	Eab32gXApNzkvhZLux8IiO04aoLLw3UikNwH4mD0vpg==
X-Gm-Gg: Acq92OHqDhUfTH1FCyVaFtM2dBr5NttubmwCCUy2odmpKK3kd1SpHb4hqd4iPbXn3YG
	1YjDeO0WOk0pt2DIGZg4iXOTcFgYk2btTgZyq3mMvw08fhnoza+hpdKsed49/pM1kjBqhT8Jmqm
	6KiQpwLVBw9sJV2v8u5NAMGgym9s3fvDyZXg/NHigv4ESQTkl5xlEkqnSs6oKUzu5Ay74Wpw/5m
	LdqhUSqRXWlpltd+TBjbJakDfnQONr/EUJeKRWflmVK7UTgF+VgpyUmyosGPEnLIIqt/EbTZNTg
	NNlk0NrYEJmpvH/7hgmpSYvULaqgNCLNzyZvdWJnbUVeDUfVRxz8b7MpDZweiUKcq3qH
X-Received: by 2002:a05:6000:1ace:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-45e5c594c2cmr30428288f8f.30.1779197862459; Tue, 19 May 2026
 06:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260514212024.1624517-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
In-Reply-To: <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 14:37:16 +0100
X-Gm-Features: AVHnY4I3urEZt5J-xjsCBTxOrtCMrr3KZW2teP8VKCgNB9fs0VDzkYcmhM5yTss
Message-ID: <CA+V-a8uTXh2ieeBRCQC8Gzg_hCSFVFCOv0S_V+6MoGdX0F4VNA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: renesas_sdhi: Apply bad taps quirk to RZ/G2H
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249589-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,renesas];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,renesas.com:email,linux-m68k.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1CFE357FE92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Geert,

Thank you for the review.

On Mon, May 18, 2026 at 2:07=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, 14 May 2026 at 23:20, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Apply the sdhi_quirks_bad_taps2367 quirk to the RZ/G2H (R8A774E1)
> > SoC.
> >
> > RZ/G2H is identical to the R-Car H3-N (R8A77951), which already uses
> > this quirk to avoid unreliable tuning tap positions. Use the same
> > quirk entry for RZ/G2H to ensure consistent SDHI tuning behaviour.
> >
> > Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > @@ -224,6 +224,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks=
_rzg2l =3D {
> >   */
> >  static const struct soc_device_attribute sdhi_quirks_match[]  =3D {
>
> This array is meant for quirks, i.e. to address issues on specific
> SoC variants that cannot just be identified by the compatible value.
>
Ok, I will drop it from the quirks list.

> >         { .soc_id =3D "r8a774a1", .revision =3D "ES1.[012]", .data =3D =
&sdhi_quirks_4tap_nohs400 },
> > +       { .soc_id =3D "r8a774e1", .data =3D &sdhi_quirks_bad_taps2367 }=
,
>
> Hence I think this should be RZ/G2H should be added to
> renesas_sdhi_internal_dmac_of_match[] instead, referring to
> of_r8a7795_compatible.
>
Ok I will add an entry in  renesas_sdhi_internal_dmac_of_match[] (same
for patches 2 and 3).

Cheers,
Prabhakar

