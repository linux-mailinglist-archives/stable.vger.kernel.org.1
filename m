Return-Path: <stable+bounces-180981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA20B91FCE
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1404F428095
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400B2E7F30;
	Mon, 22 Sep 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bMTUk4el"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2012E7BA9;
	Mon, 22 Sep 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555351; cv=none; b=rq5RgzKzJKe2i29rsKhtYCRjdkKQrKFv4jJoVlNTUu4D54LqjcZQ2ekboSNCsh0/JcQ5V5wQge/6x7wH4aD0/ZzDJPwZFt4aYfrGC77ivW2IVXBN7zxPp5DroDyTc4hZQE0umVAy4wNHatwtvcSVOEuyFDU133Pbd4vQRwCprTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555351; c=relaxed/simple;
	bh=g2OcE0V4pQxO6raQVkHiSS49E3FmxbNOWCe42L7ZwPk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ipPAs5ekGjNe/ndLIlOPej4vGyFvtuVzFBFynMiu6rDIk2mKrJs2YxHai3ygcyiBwG6YTLj7wOwFcBS1hOcbNgDRHVE5MBA8Bul1nlYNy+MOeaa3A25wL82bhurrZTYjWK19DDMKABR9GqB18REf7sYEsT5uYyDCMIY8R963jtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bMTUk4el; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758555338; x=1759160138; i=markus.elfring@web.de;
	bh=AxO99iL8k+m22ZeFQs+CXmv6xUvbw5FdcwOtEbVg0Cs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bMTUk4elKoJai9d1Nv13mdDfw2ZhgbuD7+lfI8jh+yQJ3/lufn2CmOxdt2PcVM1S
	 yfXpvhR9R6yqrH7HWIgz2/Zc5l7iqjUSseEZX8M06P4H5dftU1eVpXlV5oXoNJOGd
	 WkY80NOv51IyFx/iywZsuINGxLA9BrD0xROUcBBF8+faRCVABb6rOBecsXxqF+s/O
	 hx0AJP2S2wEOnJ0h0emhYYKZ64zk/Pj2kR6Sk2qEYMb55tGipomMqv4S/otmGzZ5h
	 fBt1XUgo1f914N7XYsUaVH+C9Hhu57NsY0DR36BmiYfrjExRQVBGolpTnsHTMwZHi
	 Grx4+bEQD/tNmzuOEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.175]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJOq-1uCjU80cg6-016J5p; Mon, 22
 Sep 2025 17:35:38 +0200
Message-ID: <638119fb-4587-48a4-9534-2f19a194ca4e@web.de>
Date: Mon, 22 Sep 2025 17:35:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guangshuo Li <lgs201920130244@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-sound@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
References: <20250922140555.1776903-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v?] ASoC: mediatek: mt8365: Add check for devm_kcalloc()
 in mt8365_afe_suspend()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250922140555.1776903-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UCaoE7Bd1/Wu4jIqwUgFJVjE/0JX2zF1krC/MlCraYqD5cIQttJ
 I0nS4ggxnywXOIH6uEsZvhI62qAnVyGWfhpxtlKxAipw7e4TMYJfCSCxCM3YSBgPRt8pZGd
 q/cpDqGnR+FlV6PBI6EMmA3doxSev2FXAIu5fMb+BY1lmFB6jEk/ZqOrgfV4VjPL3FD1w/n
 e6jflQOkH/Jyj/4axs2XA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RVD1i6qt0Gs=;WdMZ3FymIWfme9heah3ClEwnOBm
 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

=E2=80=A6
> Add a NULL check and bail out with -ENOMEM, making sure to disable the
> main clock via the existing error path to keep clock state balanced.

How do you think about to increase the application of scope-based resource=
 management?


=E2=80=A6
> ---
>  sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 4 ++++
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc7#n310

See also:
https://lore.kernel.org/linux-sound/20250918140758.3583830-1-lgs2019201302=
44@gmail.com/

Regards,
Markus

