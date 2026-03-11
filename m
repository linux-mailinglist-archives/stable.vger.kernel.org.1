Return-Path: <stable+bounces-224741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHSmFFmxsWmXEgAAu9opvQ
	(envelope-from <stable+bounces-224741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:15:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C8268789
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 047753032D34
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571F3E866E;
	Wed, 11 Mar 2026 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/SwQrum"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CA3E866D
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252943; cv=pass; b=fXya2lqSzmh5nxweVSC07Wsi2qmj1xGe3A/V8MtRlnWjgG46Kf423M59hduGCi71MS/rQIcqozt12TKPvVVG4AH0PgSp6y+PttZmAbd+6UIOt74ZfYIKCtgK4iJPkDn6/smW/g9bZu5gAFS3iHQM0fuzbf8V9KjeyuoAK1s915M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252943; c=relaxed/simple;
	bh=OVfOqi9kmHjE2GGS+gx2YQEZfTRNSPhoTo4MN0cMJUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxI4/N+Bm/LD1pz91gCe1qHOV051tGHFQkieCPWQBH0SCdz5rXln7NZDmwZNMswhkWCe3cMyS7TiOIrROiy6Pvniq8PTAeovAAT6hhOS1Z57nhfC2VOTS+ab9qlTISR/8NB5tZF7q2j/KRjBW7nhr0bSD8UGGATNJVqz/SS5vnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/SwQrum; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64937edbc9eso200848d50.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 11:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773252941; cv=none;
        d=google.com; s=arc-20240605;
        b=SnrYiPesD4WCLLmnIoImk+Rt52naN7zpAzbKJcOW4Vu6J7/x2TictPrSGDQY7jXtqr
         gNyYlplMKVJZ4YUUGzwn+qikaPetdyFzEDPrNanVgLW6XG1ZkInl4rKAIDlZeyjxdJmJ
         smX9HBKnEVeZ5vWdcO3Y9h3Cllbr1yNXzthArMTlbhy4xyVdj6v/R1lVzcNq6nKx1Nz0
         3WuRJZeQ51pSRQ8HjzzrM/cE7GkgWdmaVJxilTbydwAO/+yM1O9dZCyx99vzOZ6lAtTg
         4O/VSVnowtMU21CSd1yr6m1DTMBJlPuOEOmX3tNP4+qNKYgM3lD220PqwpevjiNnCY05
         4+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cNiHFT+wY3afaQYyIxR6Q/+q0rxmvPgYN7lz3CIl1c=;
        fh=IOp7F517Xv8lJ+jfZ4obFSJTUhoHa8mE1AwfMP8NNQQ=;
        b=P35m1wd0fqJLde74/McXck7Ov8jjyt9LqSRF0LIlDEZLjLzQButL0TQdOwxXOWjL7P
         X5YC29xruXTXKRPs1KC4eS0WOgHfpVG1EgJamZRldzQ2wl5/sI5zwGFDV8nUCd4CM6I6
         jc5maEBvBMOSZfaYTTzl6ZgL5O3kcSDUCpED5fY9Ny7Rv04o4/WPUxNVovB8yVP9cXTR
         SMG/LwIkOPlU5NcFBU74Iehc8qeVc3xgHgT7wk4xR3owD6v5cYRz01HYiPUi5KXdescI
         mIsiU2AkYFZIF0f6eayUgxL2iv5KOb2FYBm+rloyEmnG8HuWd4hTQu3sbieX7nQK76d3
         mYaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773252941; x=1773857741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cNiHFT+wY3afaQYyIxR6Q/+q0rxmvPgYN7lz3CIl1c=;
        b=T/SwQrummYHFMUy1M13JiU3aO0R5+hIAqNeesCmge8ibgqLvJDzlHv4AVwITg3AEuh
         5kRvva3QzgX7w69FyDH4SrwXGBq1ABmpDuAa/m1yL1QzrXaqtWq+/2u26AFK9xPIYugz
         MnLK4qADtbz+SUEAI6ijE49bzf5gq/WR/FqPtHldenyM30WinpDS9loRWN1PnKvgvdKI
         Qhh+wm18Zmub97KOBb9MX0iMHFa5VgdKdVREzWxgAP/LOkS48lgMpYaScLGeR4FDb4rg
         LYVzx/8F5kDmdeYxVPACCe5Ijr/oRBBYj5wAPWe4qEabJpcu4XJylMyCAu+WdMPPPUv7
         43YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252941; x=1773857741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cNiHFT+wY3afaQYyIxR6Q/+q0rxmvPgYN7lz3CIl1c=;
        b=rhISWusYndUHtEi09yZ1N7ihIoX639Z2Ofo2mN75rMiO4zdSszy1LdmNBlTsWbJjm8
         cTbY8LnRF8mNH58pq6eHb1GqVsAhBs56KhXC51L1SPKhE4kJQz8Yl6s+yGGa4mRT4EoR
         Y0oHhiaODDAJYO/HOeUP0klldTQU21l0FQcu9yxSrgUCYhEOIlSHr62olFa3S++j6Gg6
         zWl4vchMsonmtQOeyWY5rLiyClIG38iAqU2L1GRwIEtJneYlYrYjUXNYzDry421Q0X2u
         QxWlQWPeY82mpLjW4tTHGo2vyAFYXG8paXbqr0NqnSNFYPK6JYWA+bK7EvAq8xYKKYPe
         HwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQkzVZEQEm3cX0McWg/IwQ5qoKs4lrNtEEncxilIHyKZxJTiEY09cv3T3qu9wsnua/QAX0kwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0BwArMaLKxhjSycFNmiDrtbcDzMx0jF9rS+JJQKkqT6BTvur
	BRwlXJp629CR9X53mwSVVY5mTrdzw8YjUkNhQ4UjWAb+UXP3CLljGOOm0u9H2UqaZL+jqh8x+4/
	OkCC8B4QcB3o+RuwT/zmk46Pn4b5GRss=
X-Gm-Gg: ATEYQzwHQQHzntDSYga9zydrdC9eXZNY+sJBcqgbEK+hBjmohy30ycUe75vWwykCAHT
	WylogvqcIiTI+ScjbLQf/9TcWI+iq3SQMotIDE6QtgnAjjhlctZmpKDRD2UK2zpRyZqFgIdMT3v
	T6Dtchzn6A6Y6wPNk+5t2Ed+vp6XaJWGWXvU1C2qZt+v55uKnn5x0urcobUHja6zbxUxJgYdqHi
	Bl6ZRJd1E8uogkA7UQmNaifx1tAmA70E3/l544PWzOp955ceXTNni1lGYkHPsGsADICtE1jQwTN
	keLUeKXWsCcJlI0lKcnUzFIhzDqwCsF/eYdQdwa1cjVhp9OsAlapZTjXLmdSOqjrk4eeZTsxW75
	XPIp57Qzyjy8a5GXN6j+zus6ZsU1R8Np+2NUaFxRD74Atg/0c2DQVwY0cdiDOxeiq3vbC5yA+Ku
	jLk5jtgLIF8uHC4QnxIjgG+wGY7AgQHwscPQ==
X-Received: by 2002:a05:690c:6d83:b0:799:1f23:6e46 with SMTP id
 00721157ae682-7991f23716bmr18872717b3.33.1773252940653; Wed, 11 Mar 2026
 11:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311002825.15502-1-sean.wang@kernel.org> <20260311002825.15502-2-sean.wang@kernel.org>
 <CAFktD2cbFJrLS4ggc+yf582BYmw=jJsntfbDR65ssMpVGM2BKA@mail.gmail.com> <CAFrh3J-PsVQ1u_hGFxTVKK0uOs6KxT=euK+jbGvWCueqvynAgw@mail.gmail.com>
In-Reply-To: <CAFrh3J-PsVQ1u_hGFxTVKK0uOs6KxT=euK+jbGvWCueqvynAgw@mail.gmail.com>
From: Satadru Pramanik <satadru@gmail.com>
Date: Wed, 11 Mar 2026 14:15:29 -0400
X-Gm-Features: AaiRm53p8hfe8wBrpyGcXoM78Zv_gF9F9NSxVY9UXwSZNnh9JUTRTDRcyeNi0YQ
Message-ID: <CAFrh3J_4N5j9eZAgbP0gzj5gTGVABat9-4xWZBicKMfgL85LRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
To: Nick <morrownr@gmail.com>
Cc: Sean Wang <sean.wang@kernel.org>, nbd@nbd.name, lorenzo.bianconi@redhat.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Sean Wang <sean.wang@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224741-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satadru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: D07C8268789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After rebuilding the kernel with 7.0-rc3 and the two patches at
https://patchwork.kernel.org/project/linux-wireless/list/?series=3D1064695,
I can confirm that after a warm reboot booted from that kernel, the
mt7925u-based adapter is once again visible.

Thanks!

Regards,

Satadru Pramanik



On Wed, Mar 11, 2026 at 12:42=E2=80=AFPM Satadru Pramanik <satadru@gmail.co=
m> wrote:
>
> Hello all, I'm rebuilding this kernel one more time in case I mispatched,=
 and will let you know shortly if a new kernel build works.
>
> Regards,
>
> Satadru
>
> On Wed, Mar 11, 2026 at 12:15=E2=80=AFPM Nick <morrownr@gmail.com> wrote:
>>
>> > From: Sean Wang <sean.wang@mediatek.com>
>> >
>> > mt7925u uses different reset/status registers from mt7921u. Reusing th=
e
>> > mt7921u register set causes the WFSYS reset to fail.
>> >
>> > Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
>> > correct registers and fix mt7925u failing to initialize after a warm
>> > reboot.
>> >
>> > Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module"=
)
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> > ---
>> >  drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
>> >  drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
>> >  2 files changed, 16 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/driver=
s/net/wireless/mediatek/mt76/mt792x_regs.h
>> > index 7ddde9286861..d2a8b2b0df32 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
>> > @@ -392,6 +392,10 @@
>> >  #define MT_CBTOP_RGU_WF_SUBSYS_RST     MT_CBTOP_RGU(0x600)
>> >  #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
>> >
>> > +#define MT7925_CBTOP_RGU_WF_SUBSYS_RST 0x70028600
>> > +#define MT7925_WFSYS_INIT_DONE_ADDR    0x184c1604
>> > +#define MT7925_WFSYS_INIT_DONE         0x00001d1e
>> > +
>> >  #define MT_HW_BOUND                    0x70010020
>> >  #define MT_HW_CHIPID                   0x70010200
>> >  #define MT_HW_REV                      0x70010204
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers=
/net/wireless/mediatek/mt76/mt792x_usb.c
>> > index a92e872226cf..47827d1c5ccb 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
>> > @@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfs=
ys_desc =3D {
>> >         .need_status_sel =3D true,
>> >  };
>> >
>> > +static const struct mt792xu_wfsys_desc mt7925_wfsys_desc =3D {
>> > +       .rst_reg =3D MT7925_CBTOP_RGU_WF_SUBSYS_RST,
>> > +       .done_reg =3D MT7925_WFSYS_INIT_DONE_ADDR,
>> > +       .done_mask =3D U32_MAX,
>> > +       .done_val =3D MT7925_WFSYS_INIT_DONE,
>> > +       .delay_ms =3D 20,
>> > +       .need_status_sel =3D false,
>> > +};
>> > +
>> >  int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
>> >  {
>> >         int err;
>> > @@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
>> >
>> >  int mt792xu_wfsys_reset(struct mt792x_dev *dev)
>> >  {
>> > -       const struct mt792xu_wfsys_desc *desc =3D &mt7921_wfsys_desc;
>> > +       const struct mt792xu_wfsys_desc *desc =3D is_mt7925(&dev->mt76=
) ?
>> > +                                               &mt7925_wfsys_desc :
>> > +                                               &mt7921_wfsys_desc;
>> >         u32 val;
>> >         int i;
>> >
>> > --
>> > 2.43.0
>> >
>>
>> Sean, testing results from: Satadru Pramanik <satadru@gmail.com>
>>
>> "The updated patches from
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D10646=
95
>> do NOT work. I get the -110 error with them on a warm reboot.
>> Reverting to the kernel with the older patch restores my adapter
>> connection on a warm reboot."
>>
>> You are welcome to stop by the Github issue where this issue is being di=
scussed:
>>
>> https://github.com/morrownr/USB-WiFi/issues/688#
>>
>> Nick

