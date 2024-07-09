Return-Path: <stable+bounces-58740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC092B916
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0DA1F219B5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C201586D0;
	Tue,  9 Jul 2024 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PtUSgGH/"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39F1534FC;
	Tue,  9 Jul 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527085; cv=none; b=eoRwT8UIyk6M3Sf+4vXVLsHPzQpTWx2Pwft6uKK/zg53iFIjgXlBMun+8+s800BtI3gE/jxHcSjPvqaFf0tvWXVw73+2X0PRn09ULbekQ7h4Fdz5mFdan4w8+Lx7ktickhEy9cd/2PftRn9C3YGiCrJi60xn+ozYYO3vyGTms50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527085; c=relaxed/simple;
	bh=07u+d8/VVabnzNsgDPxn1WvWRdYn18Z+KZmEgI742IA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=T8l3DwpcJF37jy5qgG/qO7NppOIJNxVK1yT07blBQ/Wcs4cBwB1/Iq491MSc8jfFYJHxm8Ynj43VIEkBnPEv5YqfHjSbBk+QO8uBEVu6rptPaN0nGg9+p24nrRjQWH0v5jaka03/afUhaU3vceRgNsXsTNc1d5Umzz27i/aLiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PtUSgGH/; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720527033; x=1721131833; i=markus.elfring@web.de;
	bh=07u+d8/VVabnzNsgDPxn1WvWRdYn18Z+KZmEgI742IA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PtUSgGH/zk1ZLSvEsUj1h7TmqoGPsawvcXuKyULGBvdgP+WcdjoKlcKN82t61B0X
	 oDDIiirI53CUXCHi6uEPFMNSk42roQOATaaBMkgO55Vomvoh0QwzwDwOd9+jYjEyU
	 sEQOOw/uL4DtvetB7R1R94lpqDvzycQF7cZITY+VgZpOiLKaJU0KHKuumeYDdkIMw
	 1/Zgk0SqKwwRI7F/n7j+smTiLiFGwDFQra7cfde0Fz73vDvyMymrsfRYHqeBZ+iS4
	 WGaj/Rhc9O+QRvVC0/OgTF8Fe9YYtr+cNHkVvymRAlXSTZFZLFMigUsQSQJLrRagF
	 DQlpalzJzPOunqAsqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJNd-1sqlpe2EcB-00LfaQ; Tue, 09
 Jul 2024 14:10:33 +0200
Message-ID: <1fe42fac-b3b0-43fe-9270-79afed5fba6c@web.de>
Date: Tue, 9 Jul 2024 14:10:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Wei Liu <wei.liu@kernel.org>
References: <20240709113311.37168-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v4] drm/gma500: fix null pointer dereference in
 cdv_intel_lvds_get_modes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240709113311.37168-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d1pJZ68qXVLC5hDwh5dRD6Gu4W2nu8B0JaP0M5KPoZ4RDYSO2li
 54bTlvMJ+AgnnVabxrF789qHsFdBA8tafROZY+vtw2bjb4lDnngz8EweGuhNMimNbojDr91
 yY2StoZShqaVh+L+Pkju90eaafFKr1mdk/CX/fhqJE9q1m10cUIUIKLGuOhzEtJ1yMFYDqq
 AkbP11Bm8UZnaCwvJDMRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SB8L1Y85kb4=;IdtYRSGC0esrjCM//uktqOB6+Z7
 8jcwx3fpx3XaQNYh5US3nMVLJcmk2q+Ijg6X23q0bGq+hNmP3dvTKf6mAu5ObhZ81s5AJ9c6y
 dmhBGa93Nwec2NACODNAFrNomMkpemPjqziDZV3o80TDYl//Q4S7i6b11ElDt/OUYZGHlg4/X
 GGC1pyUJUWoCivIaI9PHxSlgFZ1aQnJwmRwPtRU8KwDjFU/Kz7uVnvGspAsEMpvF/xCw9guOU
 bzonFA4hCKKFbsA5qCRKbiZysTC3kWxO9rhN/wkkQxNEzL6XW5utLELYrKMlDKdGIPXB26+LM
 YwmmBdazbZbCyYZRXHTjaLjmt0SqNipBf+WGdXXp68I+zJjz5hG228RxWJjM9CwML8Dw7uJyY
 BI15TCjUJvbD86mjVjXxPM8UwPv6QRS77F5PHNGlb4hjasqoNNZMZVCM/HoPzRCVaYhG/pXIx
 VqbxFMGv7hVLjh4vBg93Y01+CzcVC6DP/CSZmb1ExsZTP+HpU9QqwT6/sTW3rfv5q3DULch1S
 1dgOgCBH9b0N6C7X3/9HW/Aw6quP1JBr2lwexuFAny3C3LuIS/CbAK2b/yr2E5cyJosTwoUIB
 Hn6neTn+1mfyHpp4L7BzoqfqYdbpsYNG2RDS+Z4fMcUk9x42XULh+NluKOmynfCnPAgn6iT3D
 AR5yNhlGPvbJBZ0B3ayDbEJPI9dWOd1dWSbuc/r0siTaxm0bRgNawhnlCa/vbkRyrhfKKsh3D
 jDh93qeAwIwM4DhryRAFT18CBg80askcrlNUwz8Z7RzUhvesZvH0KJCqz8X5pXjsKSOmxFn7J
 D5Acyn++A6C3j8ZMEccxNltpdYqVEGHJjUeoDnmnmRweU=

=E2=80=A6
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Are you going to adjust this information anyhow?


> ---
> Changes in v4:
> - revised the recipient email list, apologize for the inadvertent mistak=
e.
=E2=80=A6

The usage of mailing list addresses is probably undesirable for
the Developer's Certificate of Origin, isn't it?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc7#n398

Regards,
Markus

