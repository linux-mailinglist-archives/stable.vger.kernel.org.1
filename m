Return-Path: <stable+bounces-233678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK2DMH0r1Wli1wcAu9opvQ
	(envelope-from <stable+bounces-233678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:06:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD423B17DD
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 815F63019921
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31523B27E7;
	Tue,  7 Apr 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah/BAsyD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D326CE2C
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577639; cv=pass; b=QMMs4Uhgmcdd1201Rf4w8xDu8Ls6rv/vmfAlEwf3WbEfxJ2i1ToSz+GeNZeu40Nm1rgQV0wTAIY9K7R6HstfstmGyntVSF20Ex3zbqShZJfgFF3K27UDcUAgyaHZJePT5YNf48/8m1u5G/xaIF5ykAMSXHlDd8jfDA1KEvEqM3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577639; c=relaxed/simple;
	bh=8RLob4QB28ImVoxRQZX+IBEgAl2HyO/hx5ZoQuzPjGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThmOmYY+zcsNjA/Id1xqhGmvjObinqMcdR/JEv0h3/NJTV6URaWj6UZdW4w51Mz+7j+ILehFiNr1gObZs6CYlRlCMrFYugKjCH+vqB86xxg8OByusdtjOoe0khUUbl9PJ8KKqIJ9V+EtGAFc2kNv1C9AJjZHg86rtiYMNRDlwRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah/BAsyD; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-953943f7a33so2250659241.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 09:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775577629; cv=none;
        d=google.com; s=arc-20240605;
        b=HN7P3rNSLf/HAz4PEUDRBUuwHQel2CQ0hX1YDA8QRUyVLJWKICX5uJawELm/J+xyLI
         1vqAl3bNQ8VdDVffxL9OD7uYK9gSBHiWLl4sF8CEm2h5nDKILgiFuenIlhKHSmFM8zqc
         IEcoHXhKaa6Lvd0UXtyBXfbeQ4lQeKUZw5kjc2RXu7EW7iLwASJNiyX2OAJxALaVJ28c
         5h06LvhiidIqCTmGQyaVEFQy9gNv6pFPnFExggx5MIB6wlHeiOrHrG6M2CHX+ru5NT0l
         URr5lr1XoICIa4P0NLSMslUqLZKJEoOW1KXxOoHZ7PA+b5rPKVSrQcdCCMW9QwvwSxjZ
         hLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7cOfNAa8j+2xclxv3TIo/Dyr9thVkxs9qM2FBEkKirg=;
        fh=GZuDVdLmhSXe+wBnbqZXaIFl8r47SoKqNXS8+grwyPs=;
        b=k4UTEV2PCxkxPcGOeVko/0zWCivhraRq1naNvyQjm7/I9WkSKtxJ8KdjKgQErswXNe
         EtA8cFKMgf46JFhsZ+O2ueAw/kCZ/DwG3sNtopWvUcaWrxx5O4cxK8GvGzcMkUJZLlqu
         6ezkMqenhcwfe+opSvZNCU3U5pXfh/l+kuQu0rnDCbex6jAO4ftdYSWx05PgmF5GAPs2
         YOE9j41BzFykQEWUkxg9DxRvvmGkDh3Mkc0057nxkFr5QwAHUtmtffMDsJPNxcsoSy10
         baoqzSQiMhV+Wi8N8+AWGYSgtfsF5fWzSyscgjETdTVyGaUzTHm3HSThOF4914drDQvC
         M3vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775577629; x=1776182429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cOfNAa8j+2xclxv3TIo/Dyr9thVkxs9qM2FBEkKirg=;
        b=Ah/BAsyDBEBwKo3TycGJk9eTlBqh/HcpGSGaZWkQ/pEuwchm9+QWleVPVEMNh4x8i7
         WhCm/9pCO4yFgZTyNNfYrVe8ja0O+3aAe/G+eEGSn1cbDB5ySPM/wh7TINx+fwNeOdGi
         oYVDQDRjGqWRWqROuivLSyEnta/Msc7nSUae6uzeu0bl8V5qowLZyFWLPJbCjF0DtLLb
         QQlAoy9DC+JwND2srujY3iSRgqF8chumIWcSsX2Y7BL7HUgve7mFP1ugG2peNhXcYKX1
         /36IgrXgmxUdyP1MUS0MDYEFg1CuOlJJlMq6vzgEoXTdEYVcK+6kTR7fVUXSJQdTAEfb
         Z4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775577629; x=1776182429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7cOfNAa8j+2xclxv3TIo/Dyr9thVkxs9qM2FBEkKirg=;
        b=D+SUc3AgFA+BM7uzkb4978zsGx0doZrcuHr+SvZjT96nrXlCvJRQnY5436fn72ov7e
         Kq3A9tbcJrDLny1SOPdUEe3brR55roqpES2H4RshM8CJRZqNgUjGKhzY4LQFQusTQdQ0
         pi5/D8jAgp7T7mw1ssJPOBQNpSFxbFIo7YgOl+qG64p4eOqpGdvqnHRECAo4k9oePrAu
         rvklzSy8HPflTDVBdKIXUuZbV0doLT1AZSXmu8SvbgaYSO+hwKk4sMFo2EzybEMU3FkD
         JVzgNG2KIvXMGXd6J7DEGSwwAAOic5LVQWG9mYok9Ug3CSqU8JDwoYPxvpfsCQVvCmKp
         9Xrg==
X-Forwarded-Encrypted: i=1; AJvYcCVjHXwI9Y8sgDGDQvkw1fLAlxerCc0Fgkkd72R8i/BnnOwlwtQRobmot7VhLP/6HyF+LraRU78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBQ4A8/R30OO6RD7k9zSg+U3Wngwl0m6VOsBfmmvQj4pOVtmm
	2PpC7rd5vnK0xlCFUP03FWKahTPMzt9Ua0QklmllskCg2GhENb1ce82zRHViqVWGUDUfkyf4R0k
	q37HuxnYrrMUNAoRedSyrlNOG1cJfAG8=
X-Gm-Gg: AeBDietWFK4GvUbHSeB1rrf6Oz8Onm1WS/MmStYVReN5Pzl5xE4znsktdrOHSDkYpeU
	wpr353PZdePZ/aZS5bH2XHKL2VlckbTxMyxzh/kFN60x0A6s0v7UIsjv3hhcrmLCA72ASbDSLJ/
	brf0P5aAbG9ju73wzC70qZE+3wwKSQ0GDIIaOYnekj0ZSadhz9YQyY0QWv3gqgMDVCWYopymnwc
	vGMvwVSiuCgFoZ3BZlctUczJa95J2xyxlVdVp0qdr+4/dHV46bfrJOJoRfEU7owrfpCxEhRKaop
	1CpOj/S7D5EmBd0tY/rQseqQBSp4qooQZV1uRR/u
X-Received: by 2002:a67:ef52:0:b0:607:4fe2:d3e1 with SMTP id
 ada2fe7eead31-6074fe32c26mr643493137.13.1775577628763; Tue, 07 Apr 2026
 09:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com> <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
In-Reply-To: <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
Date: Tue, 7 Apr 2026 12:00:16 -0400
X-Gm-Features: AQROBzB8oos5R4wfuV80BDxNB2sW-hRDYLx84rQYT0ZQnA6Gi09V7mSU-s_cnLA
Message-ID: <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com>
Subject: Re: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in
 sta_poll RSSI extraction
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233678-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:email,candelatech.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2DD423B17DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 11:25, Ben Greear wrote:
> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chipset
> at max.  So while the patch may be correct, it may also not matter in pra=
ctice
> and at least may not need to be backported into stable.

Hi Ben,

Please accept my apologies. You are correct that the mt7925 is a 2x2
chipset, so this does not have a practical impact and should not have
been tagged for stable. I did not read the documentation in its
entirety before submitting, and that is on me.

I will be much more careful and diligent with testing and review going forw=
ard.

Thanks for the feedback.

Joshua


On Tue, Apr 7, 2026 at 11:25=E2=80=AFAM Ben Greear <greearb@candelatech.com=
> wrote:
>
> On 4/6/26 16:47, Joshua Klinesmith wrote:
> > The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
> > spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
> > for the fourth byte, consistent with the other three chains and
> > with the RCPI3 definitions used elsewhere in the driver
> > (MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).
>
> Hello Joshua,
>
> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chipset
> at max.  So while the patch may be correct, it may also not matter in pra=
ctice
> and at least may not need to be backported into stable.  If it is a minor
> cleanup that doesn't actually matter, that should be described more clear=
ly
> in the commit message?
>
> Some of your patches are touching tricky parts of the code and making
> subtle comparisons against how the vendor's driver is written.  How well =
has
> this been tested and reviewed by a knowledgeable human in general?
>
> Thanks,
> Ben
>
> >
> > On devices with fewer than 4 antenna chains, the corrupted value
> > is masked out by antenna_mask in mt76_rx_signal(). On 4-chain
> > devices, this produces incorrect ACK signal strength readings.
> >
> > Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver fo=
r mt7925 chips")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/=
net/wireless/mediatek/mt76/mt7925/mac.c
> > index 6334019249..85e91ca84f 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> > @@ -144,7 +144,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *=
dev)
> >               rssi[0] =3D to_rssi(GENMASK(7, 0), val);
> >               rssi[1] =3D to_rssi(GENMASK(15, 8), val);
> >               rssi[2] =3D to_rssi(GENMASK(23, 16), val);
> > -             rssi[3] =3D to_rssi(GENMASK(31, 14), val);
> > +             rssi[3] =3D to_rssi(GENMASK(31, 24), val);
> >
> >               mlink->ack_signal =3D
> >                       mt76_rx_signal(msta->vif->phy->mt76->antenna_mask=
, rssi);
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>

