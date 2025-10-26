Return-Path: <stable+bounces-189884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E5C0B101
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 20:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E6C934A1C5
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0122FE572;
	Sun, 26 Oct 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BuKlV2/v"
X-Original-To: stable@vger.kernel.org
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245582FE568
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506381; cv=none; b=Zcy8/CBsbjs7B1X35ttY9+cuLEdE9NjQiuRAxBRvSE5wgYNaNWopyhi7FV49BxepDa43JBLrgsC1nRmssChWlu6esjwFjXkgr5ybC1llECAZRie1WzroYd/MDyD9RePrxuHsQmxRKFdUA55r3CVZCAKN5FfstLYokXyrqafm3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506381; c=relaxed/simple;
	bh=xRG7RRaOd75W2AXX/3U7vBD9xweHddWhADNXxNQKzq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP2sWaupcq4niDCRZq2pUlArbvsOrFoz9W6cJuzZJyklYqPte2FCINeVX9T9tu3MLjpFuCBWq1yMFdoF94QitLoExt5Aocp90f9Evi93cW9GO9+20NlhCYoWE45k3AR99Csk0QH09L1J7s0QeaSb0DplQMe5LR6Pg5Vw4E2U6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BuKlV2/v; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 9DF395E4FC
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 21:19:32 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id F19325E07D
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 21:19:31 +0200 (EET)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id DEC4D201869
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 21:19:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761506371;
	bh=u+ORu+BOBg2onDpkWcuDWZ7x2Veds5ArtmoChBMc540=;
	h=Received:From:Subject:To;
	b=BuKlV2/vsL9uzXo0Vrb/NhDM+oavPdMzgTf01gRH5Rpgbczd28TuCtSKmkVztsMtU
	 7gVTS0h66pN/0LikU9eNqxMGFJX+McSYFdoJYPJ69Fu71QJYqRU+4PlTtTVQulXsOl
	 esMaDDMzBTXYuKSLRFFFlLPVeSJWzmkSueNfsVvKZLd6njr7lPTB+xdWAB1mXV70bK
	 UVgS4hUAgA1MuUto3ZAQ/SaMTSI+IkAjxAY45y+fh6C6x4lWpAC/jkzPnjV1vym6dW
	 vq9Vg6NfZwYwVNL0BUzoc1oeToi87aT/RgAliIPY1iL35QiiasJsWaRi0UWaWhfO20
	 MJvQbbC8i/Ayg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3696f1d5102so34586261fa.3
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 12:19:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUF7x+3ZQu0uZSolAcYLxtdyr56Gy8qKeLdwD0+lvrY7Iox+JpcpPyHBEvcH5Zzx2cVf94u3h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7brAjWrqn5cevVLTiI3/R3DQJ8StQe9f7uoMluxo3MHs5nmBo
	PB/PfXOAP0YcgolmjTtQMRb0PYMkpHlaEVuBcMhpVFt+AewAs/UhrQdkEcv6pcI0nDQCI5gUJ6C
	HE0STChYp527BoO9WMqVr97nyGByc9cY=
X-Google-Smtp-Source: 
 AGHT+IH1+LrV/HXJWrcLHsBoUCuoFjWejxe4QlRyJVq8b4diRfaog1nzI0eZGKw9EqPst1KY5trhwovqgZ+TN9X3TDo=
X-Received: by 2002:a05:651c:198c:b0:378:e79e:ce4c with SMTP id
 38308e7fff4ca-378e79ed460mr23672181fa.17.1761506370338; Sun, 26 Oct 2025
 12:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026191635.2447593-1-lkml@antheas.dev>
 <20251026191635.2447593-2-lkml@antheas.dev>
In-Reply-To: <20251026191635.2447593-2-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 26 Oct 2025 20:19:19 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
X-Gm-Features: AWmQ_bnSWEJ3v7n_AQchb1SyLrMbzY5rdWIx3bGjgVVdHSMZd6IqG2sxntWuSw8
Message-ID: 
 <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ALSA: hda/realtek: Add match for ASUS Xbox Ally
 projects
To: Shenghao Ding <shenghao-ding@ti.com>, Baojun Xu <baojun.xu@ti.com>
Cc: Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176150637118.1180642.1212259588552036789@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
> projects. While these projects work without a quirk, adding it increases
> the output volume significantly.

Also, if you can upstream the firmware files:
TAS2XXX13840.bin
TAS2XXX13841.bin
TAS2XXX13940.bin
TAS2XXX13941.bin

That would be great :)

Antheas

> Cc: stable@vger.kernel.org # 6.17
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  sound/hda/codecs/realtek/alc269.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 8ad5febd822a..d1ad84eee6d1 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>         SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASUS_GA605K_HEADSET_MIC),
> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TXNW2781_I2C),
> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TXNW2781_I2C),
>         SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
>         SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
> --
> 2.51.1
>
>


