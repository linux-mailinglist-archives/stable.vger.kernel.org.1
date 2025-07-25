Return-Path: <stable+bounces-164744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143BBB1206F
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA203A7209
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785651E32B7;
	Fri, 25 Jul 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="kui8TE+5";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="W599hQ5U"
X-Original-To: stable@vger.kernel.org
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8D339A8
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455510; cv=none; b=jua4JT3cI5fWxHKeZsHcAymhnIpir9mvJ51B7+xOQL8uAfMnr4Uo1/Q21gtgNOAAN4uukMxsWN6F5o57Mk5g7SBmNSexW6WqxcurkosFu+d9eOMZRB3FCKzSQg9C/aLf6MuMrHfE0vkLpNGGzjCKEAM67MgtOYyCWt8aFRazNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455510; c=relaxed/simple;
	bh=bF8/csET5SNqtwj9JF9QFqV0DeWFFnRuoxPZBgbfsdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOkq/b+EI1G6pfT21gtMLmbVzLcv4wBRON4oozY2u+2bvLfXYtlNJ56AJ4oFUVzdpbddqqpOFxfoFD1BpwBZJTxikXzyirAsrpDQZFZnF8Z1aKyLm6pTKNoqzuEviivYzqj4TvDwjNWQrFI6Sq6yyp/ASvvNxET1G7mR2jh+MAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=kui8TE+5; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=W599hQ5U; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753455505; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=tl5AxARlMSzyRXW4Zbs7qJk+ktNSIeI/HtBHi+C3wDc=;
 b=kui8TE+5wQT1arPdE6wyVy1Cr7+1yZtBYSnmbDSS3WnLDPMtSpId3So0Tj75dU1GNrLDp
 fPVsC3EOEB/A8RlFIbQFvsket1oa48QVK75ChkHk5SxVtqFSOqqvDNi2w63A/fDzGj1MEli
 bCk8diXhwShyYBHHszziLLmSCplqWPVxa9chLwOllOOmmEGnzBPetxtC69FgGzhJbdePwYC
 6l+usA+6159QTxXmZQ0EGAdRoa6KW8iX+Z4A0Cn1X/feMKR/3c/Qp406lLzabc2cLo93FJ2
 dREB91WUr5cXAw4uO0b/M/Qb7t4P8k+OWwvknDiQ/4BLKtuWcEAEzjxIC6jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753455505; h=from : subject :
 to : message-id : date;
 bh=tl5AxARlMSzyRXW4Zbs7qJk+ktNSIeI/HtBHi+C3wDc=;
 b=W599hQ5Uxl6m8z09cwHg5jaS66mNwy4j+gr8uS8XhfoejxK0/hbXkfHZkCsk1h9kDvOA0
 gRisHgWidB7+fxwGeZSslAicCWfF/2DJlA9UaZKYzW/Qshmq2MR7LqFCXejLIRt4JLf9MvK
 A7tEjWCtCzua9nO15ZaLpUxL98es9TPwAM8jWCkgm2EExeMD4NCym9m0zG0yafFe/FBOYB2
 DP6ZcnbEhYY0fJ0ul4sVUUwrBIZIbjJypaZN2k0Pr6KH5JM6ZeBgjJB+aNFoArhXeBAlCNW
 zF3bl+8a0gAjKPe8zsnnJNNuDTP3FB4HO65bLnKlIDr/IbKFd0K3ohJzaYmA==
Received: from [10.152.250.198] (helo=vilez.localnet)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufJsI-FnQW0hPtRBK-dTGU;
	Fri, 25 Jul 2025 14:58:18 +0000
From: Edip Hazuri <edip@medip.dev>
To: perex@perex.cz, tiwai@suse.com, edip@medip.dev
Reply-To: 20250725144911.49708-2-edip@medip.dev
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Edip Hazuri <edip@medip.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 17:57:19 +0300
Message-ID: <2420183.ElGaqSPkdT@vilez>
In-Reply-To: <20250725144911.49708-2-edip@medip.dev>
References: <20250725144911.49708-2-edip@medip.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sR_qNS80Cz
X-smtpcorp-track: sl4mirsBEpvp.SNbnk3k7fzfJ.dkYGdQt140Z

On Friday, July 25, 2025 5:49:12=E2=80=AFPM GMT+03:00 edip@medip.dev wrote:
> From: Edip Hazuri <edip@medip.dev>
>=20
> The mute led on this laptop is using ALC245 but requires a quirk to work
> This patch enables the existing quirk for the device.
>=20
> Tested on Victus 16-r1xxx Laptop. The LED behaviour works
> as intended.
>=20
> v2:
> - adapt the HD-audio code changes and rebase on for-next branch of
> tiwai/sound.git - link to v1:
> https://lore.kernel.org/linux-sound/20250724210756.61453-2-edip@medip.dev/
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Edip Hazuri <edip@medip.dev>
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/hda/codecs/realtek/alc269.c
> b/sound/hda/codecs/realtek/alc269.c index 05019fa73..33ef08d25 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6580,6 +6580,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
>  	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660",
> ALC236_FIXUP_HP_GPIO_LED), SND_PCI_QUIRK(0x103c, 0x8c96, "HP",
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF), SND_PCI_QUIRK(0x103c, 0x8c97, "HP
> ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF), +	SND_PCI_QUIRK(0x103c,
> 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
> SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)",
> ALC245_FIXUP_HP_MUTE_LED_COEFBIT), SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook
> Power", ALC236_FIXUP_HP_GPIO_LED), SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook
> Power", ALC236_FIXUP_HP_GPIO_LED),

I'm so sorry, I forgot to fix the subject.
I'll fix it now




