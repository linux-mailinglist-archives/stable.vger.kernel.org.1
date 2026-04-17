Return-Path: <stable+bounces-238485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIgzDSgu4ml22gAAu9opvQ
	(envelope-from <stable+bounces-238485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:57:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD541B633
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB146308CD87
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412E3A1D02;
	Fri, 17 Apr 2026 12:56:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12738A72D
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430594; cv=none; b=lZDS0o1HO0gQ2mDSpxa0OSFqvkCJom+prp+KGzUAaww/QUo3aEiNk0Cm6cfyRntSHdgSXJ4+a4kaHBVCP62+ptRY2vInrgfjJf8Nnit/wAbG0Xkn8G4ANvADf2fc8jAe6KekYoLsBsxa2RoKsQF23AitpABsA8xhlATTGnY+UTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430594; c=relaxed/simple;
	bh=Q8NsFEG9ZbxpVev0FTO8qLeWdg9a7p4e0wi67qPhdss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBvnoug54oylCwVpK2P6arwdeuhhTtR6g6YoOFIOqdKU8YjdBE2naOgEeU5qtdrM9MJ56DOdLC/SpFXltJ+bv4pQ+KuHCSMwOqdzS3sidCJByyXXo3f9qn4JovtQ5myF+KXERQM21QrLGV2SU5Dj1KX/8TM+YzPjK26iZStw/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-47018d341f8so406438b6e.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430592; x=1777035392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQ7E0BVCzrZ39XOhVCVYNxv43US7LndGBNHCx5jFIzc=;
        b=YY64ONizfk75//9U4xwSxhFebupv1J5ysFQz2DNkCUUOJt1RpU25F1p7xd/nyKRlyo
         pKTF6nbtuUUTlL6Cu76OPc5s2QWgCK2uz5/3nbuebGfixUkuGUlgv5ZdaRC3C8XZk7gu
         3lhc6+5N6lT0BsqJByJoF4X/QDFaxqvhLE+HKuEBphS/eEi2ks1KZX++xuKqdXU2pNPD
         HlnM2XrjOGmcq9coYlpP8io+vX1jipUnrLvTarYk5AWEVnijsgBe/cX0XvAlGjFqnfyA
         7iOSh+9b7rM9fFO2dhYXo2fkaDShBpjRpDFPqtGamCMQuRVhVa60nEdGuN9zbYH3XhF9
         Waqg==
X-Forwarded-Encrypted: i=1; AFNElJ8cGI22AZQ7j5QsqcA7/9kyuGfZtzGNZ3UMwSMAFzIsOVyfzkJPr6RFqfeUTMUeFZwUuA9RoOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hPtfGKdzQ0NGTdkDIzxdbyfY+ZGtXnK0wSQc+c6/iuoshthM
	kAH/xqjkD1eNhV8ZB5H58qYlk8eIxJpy1CDJykX/DygpfJnM6XI2cRN2C7pVig==
X-Gm-Gg: AeBDiesqTkWe4JjcgmxAm7Huh1UL+tuzwDViAzwyZ11C9idDDfUrqj2xz2/F6WodCyX
	qMpA0KrsDDxYLs4WRZYM+FPNIBqCIz8hN+S6pKCfgXR/1eRi8OTMU39bbJT2q7cCJzJK/gQEpjU
	Kn0BkQqVX6SWBpBM7/E0KjvUuOb4Xq1K9dKoKaA/Ca+TOkYBgP3lbU65V7WrFlHpEsOeNUpa7US
	2HjLQ178Tg92rqUcg8ZsooHczaTxOhbvQWorLBBH2hsWN0n3iiN0+LWsfhOcrTUMqmsTDWd59NF
	5KG27hfQzL4EYGBsBVvbeYJi7xR2XqAhg5nuBGihmPCpvPV6Vn+fFAfJfNGrIGb6U5E8CY9TPhF
	wwRIiRStAZJBsRpg+WJj4ixirq4HRwhBGUoiF3jVpHpxPjSo/co7NGoidX8jiUJK9fOLJehG2Kj
	S1KWXokrI+5FGZE3xDSp7zxE+IogrXqzXJL0ct7Lj6KixhqbfuAvV2Ni/f8YBI/LGvL7aJ/WSxs
	63Gt9VXt+18hNbYOJm6Dt+A9z9DMjX1bXBa/CM1Qwo/lRwdayK8KeLsfVB7pdF9dXi7AOsbepO0
	Pc+b7L1Ac9yFStAmIEk=
X-Received: by 2002:a05:6808:4f0c:b0:467:1f38:bc19 with SMTP id 5614622812f47-4799c7ef008mr1030503b6e.9.1776430591907;
        Fri, 17 Apr 2026 05:56:31 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff07f5dsm848499b6e.6.2026.04.17.05.56.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 05:56:31 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbce74e537so583940a34.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:56:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ82LE6xhD+cXDRja9WybN0ndBJrTQ3nOtKu2aztsJxk/NulO/Jy/6om5sU8DbgmHbkxzjmS0vs=@vger.kernel.org
X-Received: by 2002:a05:6830:368b:b0:7d7:d2e4:630a with SMTP id
 46e09a7af769-7dc951c7534mr1574853a34.14.1776430590793; Fri, 17 Apr 2026
 05:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417104639.2608008-1-tristmd@gmail.com>
In-Reply-To: <20260417104639.2608008-1-tristmd@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 17 Apr 2026 08:55:53 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_X1bfKwE44PJdgbHHZtHVy8bt1gotWsqkAWsS5s=_irQ@mail.gmail.com>
X-Gm-Features: AQROBzCi0gDy3D7m8PPBy3zcjwXiwPzD0sMHzUSSerDbzRMjjnlKfNBi1eGHZ2M
Message-ID: <CAEg-Je_X1bfKwE44PJdgbHHZtHVy8bt1gotWsqkAWsS5s=_irQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event length
 in completion ring
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	sven@svenpeter.dev, marcan@marcan.st, asahi@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,holtmann.org,svenpeter.dev,marcan.st,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-238485-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gompa.dev];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neal@gompa.dev,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3FD541B633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 6:49=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware-controlled entry->len is used as the memcpy size for inline
> payload data without bounds checking when the PAYLOAD_MAPPED flag is not
> set. This causes out-of-bounds reads from the completion ring DMA memory
> for the HCI_D2H and SCO_D2H transfer rings.
>
> Add a length validation against the completion ring payload_size.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 =
PCIe boards")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 925d0a635..5d2f594c2 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377=
_data *bcm4377,
>         msg_id =3D le16_to_cpu(entry->msg_id);
>         transfer_ring =3D le16_to_cpu(entry->ring_id);
>
> +       if (data_len > ring->payload_size) {
> +               dev_warn(&bcm4377->pdev->dev,
> +                        "event data len %zu exceeds payload size %zu for=
 ring %d\n",
> +                        data_len, ring->payload_size, ring->ring_id);
> +               return;
> +       }
> +
>         if ((ring->transfer_rings & BIT(transfer_ring)) =3D=3D 0) {
>                 dev_warn(
>                         &bcm4377->pdev->dev,
> --
> 2.47.3
>
>

Seems sensible enough.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

