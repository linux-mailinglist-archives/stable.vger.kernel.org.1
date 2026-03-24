Return-Path: <stable+bounces-230186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOJbBqKrwmkyggQAu9opvQ
	(envelope-from <stable+bounces-230186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:20:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB9317E6C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5DE31B8342
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699DB4070FC;
	Tue, 24 Mar 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9Ih6imk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE0405AB1
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364842; cv=pass; b=OqKRt6E79LmPdI/p7WZJKJ0jZtJ68d1Ael/kG7nHMIw2o/rpH9up7KpvfFRPZXoLP09/p51G5cj3jU5eqr2ABypTZqyVxFR7iCfaFjVxu33cA9GXTydhc73JojbZDbEcmWrojX12E5tJvK572I3R/TCGaCXcsO0Kzb0q90wubPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364842; c=relaxed/simple;
	bh=TpoGWw+v/2jxbHdvDGNJxdMEdB6f7zdrgJHKiONwIpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXs47MA9xgDrOI6YB3ydfuNIwzfnrL7jqwv5HefBaDz2uvc4jXc6xyxGw40VZOpN1Jn7ZjzpOxg9zHyZBce0a9XNsW8LTCNWC23glHgQQy9FzDfZn9CmEokGVdhl1K8Kxc6eadDIFLKH9IREEiLWoWQ5qXXbNQ5PqbO7uWFqH3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9Ih6imk; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9841aecf72so444685066b.2
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 08:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364839; cv=none;
        d=google.com; s=arc-20240605;
        b=IpRrIiORh+4rECnTRxwhSC/5jgqNiCH8ZAVCZnlExz3byZRFl+9lNKXJWX86jFlcBN
         Sry0yFUtJC+GVIPApbj/JS41r5Z3jzjy9XZo08L9AGir0OFJVsnGE0kJAzgPqvXrSXLe
         URPG5/Kmb5mTIlsoqMiH1x1M4QZxjsD5XdQsrVyYwWfq4P+qUUO91YLKxImFGRGILlHh
         9Mp+AUZHh96CUXuSDSCzzJaGqWiNUANzw6u7HSGsrv53BSAARUF5opBYBA3268r8aUeC
         LGQLbr2ShKpBOuH8mWGuqL7ybtnrewtQhSB1sWWe9hWbIC5LOboyNHKkjxNrVeueaRzK
         je/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fgORygUVD3DZVAnZlL9wOEuI4Pcd93v5L/PxzCz3DS4=;
        fh=bctkPqpk6hFOZaOgNgFqMAm/NUAbGIGX4YJgcWmu/HU=;
        b=M42TQjKM8zS33lC71yETBlUdc+/74JaGc8Sv3+dXe4rxDpO7KoE2csUkkntlRFifYX
         6XGncQE51mEhkI4dn9Nb239pVakM/+DJXdy2PBoZ9ydJgIjNDwxifz+PswjF22QQGpqg
         TgxkU/yFS+ltyRGoagBbQ2yXZHBx/DeCu5M7lchjM8ncGUWdpiscqSnQpVxQAeHB1Tur
         1ewPdXMwTYpsnazTeROcv+WYO4xTClwbBUmbGUICqwFBpUYpm8pgx6vUVbuUumdKr9xr
         1yaMPV2/FvgevMygLVBOcCD9gSMIO49C3yJOc0+p5tPsL7DGtMJqHH5q1laYGTt8wEly
         ybsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364839; x=1774969639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgORygUVD3DZVAnZlL9wOEuI4Pcd93v5L/PxzCz3DS4=;
        b=I9Ih6imkWgcOcQsRV1XQmXv5RCJP9UKPxpDgb/ajsHsUXBnH4sc9nl2I6ibqhO5KU0
         c3R26X7saSIsg5H1B7FbK7mp+oygTBLuYNPzblTvUhYeFDMOe5PVf+Ab8Wm7bMgZgMwj
         xQTxlY57Guw5RVYOtvZCCNq4FIFksP69R8WTleH6pJjoJ+iJx3xsGX1ROFOIjEmF+PxH
         4jdEJ6X2h5nXuhG3OtIRnrzfh4VEP/iBjZoszXRrzUB9N/QHPPDiumhpAE+yUFco9xyf
         vnQVj9oR4XWzxK3aYOTgiUjFcQWr+Kd3tDl4dbV33vtBh1M5FLdDIDZZEcTczTWVO9Sr
         bcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364839; x=1774969639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fgORygUVD3DZVAnZlL9wOEuI4Pcd93v5L/PxzCz3DS4=;
        b=bidiYxi0Nm/659WRgb7tSPlI2imwTWumM/RCIrjxZRzCUB+qZ5xn9vr6VCfgTzmMUM
         3WFGD8/UctzSlHuPk6vXCLj5hhhxX9+juP2Nq+ZRoM3OWB159cL+M6rJGn3ZBL9+8k5Q
         3U/+Jm+sjpytR7Dg9LL/77L9ceBsYQO46sBQ8CvnFA2MKL8FlZBofdc29MLWt0hI72pr
         Y6Y6PxaGuviB+gRx+QR37+eQZLF+nK0Vo9UnDSEU81AY54V2q9OsGWaII18iAs2utSNT
         xu+v8c9g5mkjvmwXtb0GnINattUrgnmhyAnQih1cTFu2eav+7OvkzavqoUuTcn015BVZ
         8vQw==
X-Forwarded-Encrypted: i=1; AJvYcCV++8PNlAfm/3rORB2STNoRl+VJh/sB0GX/R3uxxh4n3u/g+Xnc7prIymbSYnQqHbuAvEh/SUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9O/st7lJtY2SKuD5f7arbOTkrB3BlGNf6MGymTZNSxcZDbmS
	A2YkM6xlW5YSCSHhh7VcBH+StdjRJpT5/lB52oRhV0hxcS0QFYBNvKY9uScA2NOERmprx5maWCl
	D8Dk6c5B1L9JL8PG0iYa8ioVM1eGNuJI=
X-Gm-Gg: ATEYQzz7HN8tatRAt+2HiZlDkkwsBKbGTyzW+/BTdaKSLbBeAr6VXYEeQMI5uy1BoJv
	lYmDVSLREJcUqwNtPgfR+7iow6Ki3MGVTAUCl8/m6q4mUILC9L6hc4Kr/hi5RfcEaqSxY+k/2Ny
	54hLenE7bLVDBdcj7CePmSAXek9No82bvrvCwfTp0FoqVA2TP100ImXST4xY8xxrMxLCL5lva+D
	iU++4RMqrTZprVfZAf3hq+08SK+QEm7FNm4zj5Ftct0S7x7A2YGIpR9NNFcYJKWXmMJnmOjcbsP
	6cGfDx4LRpSS/TC1MOJJm/scdIoT19w+ebUoKIL78AA6rtTwnA==
X-Received: by 2002:a17:906:d293:b0:b97:2a5:8a4d with SMTP id
 a640c23a62f3a-b982f362d97mr846687766b.26.1774364838745; Tue, 24 Mar 2026
 08:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324100624.983458-1-yasuakitorimaru@gmail.com> <accee45c-7cae-48fc-b868-b7404b8c061c@oss.qualcomm.com>
In-Reply-To: <accee45c-7cae-48fc-b868-b7404b8c061c@oss.qualcomm.com>
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Date: Wed, 25 Mar 2026 00:07:07 +0900
X-Gm-Features: AaiRm53hpRCNywt2V51FnaLY0utiY_CyfA6i6OH09VtGrMwZyt9ab5Rg2t3NByA
Message-ID: <CAA2s7u7jpm2Q=18+pAxC2szqUjQ+3xSXokCT85YsAFKOLf4Zsw@mail.gmail.com>
Subject: Re: [PATCH] wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ajay.kathat@microchip.com, 
	claudiu.beznea@tuxon.dev, kees@kernel.org, linux-kernel@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-230186-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 71FB9317E6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 25 Mar 2026, Jeff Johnson wrote:
  > Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
  >
  > Another thing to note is it is very strange that the struct wid that de=
fines
  > the TLV format uses a signed type for both the TLV length and
payload pointer:
  >         s32 size;
  >         s8 *val;
  >
  > I don't think I've ever seen this in a TLV representation!

  Thank you for the review.

  Good point =E2=80=94 signed types for TLV length and payload are indeed u=
nusual
  and could mask subtle sign-extension bugs. I'll look into a follow-up
  cleanup patch for struct wid once this fix lands.

  Thanks,
  Yasuaki

2026=E5=B9=B43=E6=9C=8824=E6=97=A5(=E7=81=AB) 23:50 Jeff Johnson <jeff.john=
son@oss.qualcomm.com>:
>
> On 3/24/2026 3:06 AM, Yasuaki Torimaru wrote:
> > The variable valuesize is declared as u8 but accumulates the total
> > length of all SSIDs to scan. Each SSID contributes up to 33 bytes
> > (IEEE80211_MAX_SSID_LEN + 1), and with WILC_MAX_NUM_PROBED_SSID (10)
> > SSIDs the total can reach 330, which wraps around to 74 when stored
> > in a u8.
> >
> > This causes kmalloc to allocate only 75 bytes while the subsequent
> > memcpy writes up to 331 bytes into the buffer, resulting in a 256-byte
> > heap buffer overflow.
> >
> > Widen valuesize from u8 to u32 to accommodate the full range.
> >
> > Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
>
> Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>
> Another thing to note is it is very strange that the struct wid that defi=
nes
> the TLV format uses a signed type for both the TLV length and payload poi=
nter:
>         s32 size;
>         s8 *val;
>
> I don't think I've ever seen this in a TLV representation!
>
> > ---
> >  drivers/net/wireless/microchip/wilc1000/hif.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/ne=
t/wireless/microchip/wilc1000/hif.c
> > index f354b11cb919..944b2a812b63 100644
> > --- a/drivers/net/wireless/microchip/wilc1000/hif.c
> > +++ b/drivers/net/wireless/microchip/wilc1000/hif.c
> > @@ -163,7 +163,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source,
> >       u32 index =3D 0;
> >       u32 i, scan_timeout;
> >       u8 *buffer;
> > -     u8 valuesize =3D 0;
> > +     u32 valuesize =3D 0;
> >       u8 *search_ssid_vals =3D NULL;
> >       const u8 ch_list_len =3D request->n_channels;
> >       struct host_if_drv *hif_drv =3D vif->hif_drv;
>

