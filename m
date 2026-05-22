Return-Path: <stable+bounces-253843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GeoCy+0EGrRcgYAu9opvQ
	(envelope-from <stable+bounces-253843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:53:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A945B9B07
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71C5B301CFFE
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C537DAA9;
	Fri, 22 May 2026 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHvu9Wlf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788036A02E
	for <stable@vger.kernel.org>; Fri, 22 May 2026 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479460; cv=pass; b=miNx0AhRuVCK1DBBO8xgcBd3ox0UIYiMae3gyOzLnrBVuDusJR+2pX59EQM1bIr50/NS4jdm2cjwrOMn8gx3IZVR1IGKNGVgDVDY31WyRhirtI3qTE6qRk9D3farffU4SqXDrZ72TTRo9SF7gPLm/MrUY2bCQW0pLL/HCytj10s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479460; c=relaxed/simple;
	bh=w13QDMKdFXVU9rMclB6pzScQGNlOb3CT8W9ZyRiGiCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtG4G9oOOrFt3KfWMHDiJ5c8wlW7MshvIblgiMz4BS//BSzYYDuNzd9mj6RDD+WDyrDPLgqFXvrJeDznTeUhlli3rnW4OhhnZkJ3qxz6IC723s9vQNHnNJaQrwHfP1dE28SeSd+G/+oMNxJ1Hrkq7yzryxQBZ4KWiF7GAMyOEEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHvu9Wlf; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so7859674e87.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 12:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779479457; cv=none;
        d=google.com; s=arc-20240605;
        b=Eu1wIugjldpaqg0v3cyLHJEzq8YO9hL9uuG66ccUuOQlnPs5ZG0ypxS+BpQOMBVUGY
         e73KdS5Ak5S/7Cpi3lKC1xAKEUUwW+GZ+aEQmQ1ilSkzhhGOn3QQOmr6iQltFLM0wzMB
         Rf1S59mTZMVwPA9BrgaSw1419DldywdrzIqfMKWDmILA67zJlVBjQVT+rysc83Kp430A
         f7aRywU8MmnWo2MywTo6G4B1y0ypTj6hhnoRTLL4EvTBK/IIs7KFyNFDylOOEryUIJ2j
         6U3XWaN4YVHPAKesTezJzkLZrYX47SxO+RnAX3wXEQcRLy5wp2y6suhzXdxKpId9UwMK
         OafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pq6Snvx3M6Cvj+MHUaAmKvnQl7LjByn3Z0Yyem+lcHg=;
        fh=xziNaP9ROp3V334O0zjVlnUApVqD/npD98+XaFFoqy8=;
        b=Mir2y4MjmyyxolDbsLU+O0yxI9sfwSg5iEpvU7sssagy5p9AyygSOVIdUuJyfUm2nM
         DSv5R1JBWr5fLYoNm2BvRww0+hsXCDSL9o/o7zOnBCp0FdLglgRTwh5lfbP5Ty2erHtR
         +JOXqXJ7S9Lsmnpca9FS5EA4KLaSHNo60rfnYLvLZfSLHfCa6zGcWcB/0m2yx3qWE4G8
         2Wo8qcQ0qbojhirQ/q1FYMC1X360BF1vzzSGV2K85sKqS2qac6KDRSwjHpORUC1WIJcl
         b40ewPRlMLpWiOTmM8Prhr3bvM+J6a1hykSQga29CFtLTjOprlw7M8VBHCK2wsC/eWOu
         G5/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779479457; x=1780084257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq6Snvx3M6Cvj+MHUaAmKvnQl7LjByn3Z0Yyem+lcHg=;
        b=HHvu9Wlf+YF5LwtnSucPT/wbNfIMf22wXPEblZSK47jf8LxEaG+G+xr8TEowWF3QbR
         u0IOS3lHBb8UE3zQVCZQD71CmtfMwFDk7XGrCX1ByGHTRZ+HQ1D+02a1c1xBdr17zYBT
         ELPVwcF5CvW/1oggef/TuOU+R33jo6MvHBSUpMDbq3kPe7q2eafjC+WINDhZeFsqVBEe
         kH3K1Tc3UgyHHd2KGKbdxMxojSaqZhvVi1pPzfGhFG1v1sLwJRShCAzlwxthnvRqhVbC
         MgHHL2pNlVd4+U4D3ku5VSgSISmeD/5x3xyAzEarO4WFdRqALuudk67/rpFXSY0rs2tZ
         59Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779479457; x=1780084257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pq6Snvx3M6Cvj+MHUaAmKvnQl7LjByn3Z0Yyem+lcHg=;
        b=OP5IucfSxmRMN4hkiuw8FysOxgD65ivV1xzin+bPgVSG3592pDXZZguvdg7W5BQDMy
         kqGPejHDLI9JC57wnzmiVxhvbxwlddTuSSkmWGCiB/C+W2hXxqL/r7qUYag5uutoAZCk
         45SqbVd/lSTqfVGBvIxRvpZrRFgJ6tsDJAVyje+UXl+26SQ5yq0tk5X04/R3PkloELXo
         nhYaNF96sNf8ARLd+owa/WHdSPb1WV1E3v9LzodB/zlPit4YjwrEKZpNRF93yyvQEOae
         IjvL2op2X4f/Ow/08rg2owMqe+cN6sYVytM+I+SH+/y4/liXgUzNpW0frRFz8VD84B1V
         EoZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LJPVtCRbTB+w4wh1xWlZ9wXpu2eLY6U2ubCKQJIaZLVHW9ND+VI7cojKQ+jIyxoYjeXkRlng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1jbAWjqexhdpiCrqV/g32hbv7wIzra9IyDQXBWkvFX7Gieev
	VneTnZRVKIAIJ9Y7fZmkwiCLkleSrDYjgtzj2gCKUXIwW4U+OxOcVGP2g6PWyT91TC/xa3Ke0mA
	YSxfT5Ct4j+VKf1IB/G8cPrNP8RPXHQQ=
X-Gm-Gg: Acq92OF1TzzNCpth/aF9gwU1QxUCGuKC9oI+gHMDIqrcIgAiWJ54/kC1f4N3wP1CzZj
	z+XS7PlTqoegpBp4LnMOC0OVc6jvGTTw52moBJn8xXzahjtGQauki6XxRqFbsK9WVXQ2+1UUhsv
	XKZZA4nPf2dHB/UFZFdG4KN2zbEjO5TM22C8zNTav5Wsm0UGoPAx0DRcnm0cwa4KlQ2IuzHLjre
	ASKCCDG3LwWlxi1OuvK99uuPPfJItwmDrD3Babf9rfr6cQFhdzQqDhDt1OW4KWscUDCf5Bo0rVk
	9YzD9XMBubViHriknvdMi9NePzLJgOXX8EighiM=
X-Received: by 2002:a05:6512:1243:b0:5aa:116c:4127 with SMTP id
 2adb3069b0e04-5aa323a9065mr1749567e87.41.1779479456947; Fri, 22 May 2026
 12:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522175658.41667-1-meatuni001@gmail.com>
In-Reply-To: <20260522175658.41667-1-meatuni001@gmail.com>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sat, 23 May 2026 04:50:44 +0900
X-Gm-Features: AVHnY4LSOxoBwV8oIV0SXoHrFePQWlSvLBHUXQVkre292EgLiHWaufbhRjsmr64
Message-ID: <CAGwK=3o0ufRr-611yN5Vx4dKaQ9=9BVrv8t3Emxh4_sQtAaXrA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: add length check in rfcomm_recv_mcc
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kees Cook <kees@kernel.org>, 
	stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253843-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org,molgen.mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suunj1331@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 99A945B9B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Muhammad,

Thanks for catching this. You're right =E2=80=94 my v2 added the length
check but accidentally dropped the skb_pull(skb, 2), which leaves
skb->data pointing at the MCC header when the sub-handlers run.

Since my v2 isn't merged yet, I'll fold your fix into a v3 of my
original series so everything stays in one patch. I'll add a
Suggested-by tag to credit you.

Thanks again for the review.

Regards,
SeungJu


On Sat, May 23, 2026 at 2:57=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> rfcomm_recv_mcc() casts skb->data to struct rfcomm_mcc * and
> reads mcc->type and mcc->len without first checking that skb->len
> is at least sizeof(*mcc) (2 bytes). A remote device can send a
> crafted UIH frame with a one-byte or zero-byte MCC payload to
> trigger an out-of-bounds read of the second byte.
>
> The unconditional skb_pull(skb, 2) that follows compounds the
> problem: if skb->len is less than 2, skb->data and skb->len are
> corrupted for all downstream MCC sub-handlers.
>
> Replace the open-coded cast and skb_pull() with skb_pull_data(),
> which atomically validates skb->len against sizeof(*mcc) and
> advances skb->data. Return -EILSEQ on failure.
>
> SeungJu Cheon's v2 patch added a manual skb->len size check in
> rfcomm_recv_mcc() before an open-coded cast, but removed the
> subsequent skb_pull(skb, 2) without replacing it. This leaves
> skb->data pointing at the MCC header when the sub-handlers are
> called, causing them to parse from the wrong offset. Using
> skb_pull_data() here avoids this problem: it validates, casts,
> and advances skb->data atomically, and is consistent with how
> the sub-handlers themselves were fixed in Cheon's patch.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-bluetooth/20260414010741.233892-1-suu=
nj1331@gmail.com/
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/rfcomm/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337..4e8047012 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1644,17 +1644,20 @@ static int rfcomm_recv_msc(struct rfcomm_session =
*s, int cr, struct sk_buff *skb
>
>  static int rfcomm_recv_mcc(struct rfcomm_session *s, struct sk_buff *skb=
)
>  {
> -       struct rfcomm_mcc *mcc =3D (void *) skb->data;
> +       struct rfcomm_mcc *mcc;
>         u8 type, cr, len;
>
> +       /* Minimum MCC frame: type(1) + len(1) */
> +       mcc =3D skb_pull_data(skb, sizeof(*mcc));
> +       if (!mcc)
> +               return -EILSEQ;
> +
>         cr   =3D __test_cr(mcc->type);
>         type =3D __get_mcc_type(mcc->type);
>         len  =3D __get_mcc_len(mcc->len);
>
>         BT_DBG("%p type 0x%x cr %d", s, type, cr);
>
> -       skb_pull(skb, 2);
> -
>         switch (type) {
>         case RFCOMM_PN:
>                 rfcomm_recv_pn(s, cr, skb);
> --
> 2.54.0
>

