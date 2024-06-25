Return-Path: <stable+bounces-55773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13D916A84
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A528D1C20E95
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E62E403;
	Tue, 25 Jun 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u7Fr9UsU"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF81758C;
	Tue, 25 Jun 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326081; cv=none; b=H9uEObDl2kPP0LBOWrtuEkIsjkeUoyWkiBAt42HEvQwr6reIV+vcCMxYUG752tlRb9cX1cgVOxAs0q08CQOWNyaYWDLUPRkmJG7UKINUBs8z1V3PNgsEuNuJYMCoNR46XQN733GUVgEtK/yBlnp1kXpUYO4kyM94eWJnxUqII0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326081; c=relaxed/simple;
	bh=Kujgj0anIo/IcUOKduxF8pOvJsiKk1vmUd/L0ICVeTE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ttw91w0QWT5HlxmS7QPR0Jy0cofK1aVDzBCXUA5Gf9/Vodhsmg3rZ9akZzX8WoNgps2jBR6s6bJ/3lTeNMHdDbG1Ec/Cw74YUWRlqagwpX+YY/NkKABzLgKcoLVeA1CU97fxFpZaeWc8XDumAgLiauRbLFJe/G1Zs1leORwFIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u7Fr9UsU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719326060; x=1719930860; i=markus.elfring@web.de;
	bh=4hqmfo5ctGH968xUb+z+rr8LiHMCJOdB3zcu6j3LRIo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u7Fr9UsU3M+6VBd5zDYTpRGJhqFvgvzY4YrzX23C5I6Lgp0KbH8vx9cc2MKyZNCp
	 dkzT37MWVnNmUEpcdL076Ok7w7LDZVochztC4Ty3iBgmpD70AP8+ZXC9RpH6uPqu+
	 D+6Yk7PbqPZQPeUtuCCRyq7FJDub299czeluVijqPMelRaeXRE+zYx0obeXQiPA9B
	 G6Pz5Xb1GnoHDYG71clPNaeyEb/HfpC8u8yaGsv20FSeyqlEVKg+E49m7YzwEuSBJ
	 N3N4vo+0W6jFwDHR07KswcvJrxnwHdRHEkOiRn2s8TWg6NC3gw8SYEIjmcviicgh1
	 1JHYofBhbeDOo8I7bQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmzl-1sl2f63wn1-00fa6K; Tue, 25
 Jun 2024 16:34:20 +0200
Message-ID: <c7969a4e-61aa-479f-89c8-0373e84c43be@web.de>
Date: Tue, 25 Jun 2024 16:34:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240625081029.2619437-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/nouveau/dispnv04: fix null pointer dereference in
 nv17_tv_get_hd_modes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240625081029.2619437-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w+lKWxONvobVkG1JBjQ5wfxpvmogK7zfC3one7JxNJttL0yxtRT
 2X3FNzQnbkxaLdb0QHQefzMbPsBUfPIZBpc17M3CtJkoxYSpCVRop7sRcgsds0cCrzG16JL
 45sBtaD4ZQLCbci57s7tU6j4/EnczQZ9ldF89yqCNo7uLR/WEgR67k03y/u/VqbI+aIUgaR
 XzVzJnh9Z66x/b49M7tAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:trJvbE4vUhE=;eCQIKaNK/fS/KPnXOL1hOZwQ4wD
 515WonsX5Vk7h9q7pmgwOtGWyFaCet7T6v+AZVm5PSUfqS7y6d3fAHfcUS7T4r0spc4lKcpPk
 wP2fRFk2qJIOfx3XYpHaUj1Un55DWZNBHbFcly+meblXwapr4wX2U2JdVDWOmlLIXIg7Wuwcu
 OWcjYmRKmZMrwUadiNtgncjLPE7cGJxQYexPcACsLCFeHoOnwcji81IVi6rKJ5DrMXlWMrKJU
 /tby3YQp5CgALY1vqtPIALu/vMtiLKVLsAJAVFHTpvBby15EaKO8hMCjtrMdnu9v8dBVIIizZ
 iVLSmdGiqTL6p36JQCxIw8O837C5lxTeIBeE09mAt/dZEuQvBC67JVyvS4z2IBozGt4Az9wIT
 96RnxFazx5gaUlwa18DAS5UzJHqyrJxO7b867L3j5ysvCwFR9e10MIZemuHeYXwqUKoEj4K/f
 qP2DZhspPlq+Fs2CM+SG18tOdJdJ2vFnbXgDKguPRZUfVCT0C1wHmQi+iBO6k0uEUWOuPo7/v
 OLezWGdUCdUoebLnlGPp3DIORuJvVtYwnDzZe/lQGxOepiZvVSwTRsf2DC7Cm0QtlMcp7l+4X
 8ofuF+uAqVlGK6h+HP3vXCxbBk1QB6lPnnRNeJbxSRXvQUCvfv3BJLmLzvHkVIiqZEowcJL29
 b8ER3rE931Lxr9INbkCj/QBJnDKCzqjiNS283Sq3pQRYCkTY1kWUbNYH1EDY4gGOGK7d6mmd5
 eSJ5B++ussY1vK6rfYjT4/El97/sTzSyq0aoJozgYil1SzQyTSgSj77jBEaWoRrHf9pl+nNuO
 CiRyhbn/PlOyELAV9EH2hhAa999Bw4yCLh6PEAK5a/8no=

> In nv17_tv_get_hd_modes(), the return value of drm_mode_duplicate() is
> assigned to mode, which will lead to a possible NULL pointer dereference
> on failure of drm_mode_duplicate(). The same applies to drm_cvt_mode().
> Add a check to avoid null pointer dereference.

Can a wording approach (like the following) be a better change description=
?

  A null pointer is stored in the local variable =E2=80=9Cmode=E2=80=9D af=
ter a call
  of the function =E2=80=9Cdrm_cvt_mode=E2=80=9D or =E2=80=9Cdrm_mode_dupl=
icate=E2=80=9D failed.
  This pointer was used in subsequent statements where an undesirable
  dereference will be performed then.
  Thus add corresponding return value checks.


> Cc: stable@vger.kernel.org

Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


How do you think about to use a summary phrase like
=E2=80=9CPrevent null pointer dereferences in nv17_tv_get_hd_modes()=E2=80=
=9D?

Regards,
Markus

