Return-Path: <stable+bounces-109470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26565A15F60
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 01:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB787A337B
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 00:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64BBA27;
	Sun, 19 Jan 2025 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Dj2IBDBj"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839825A636;
	Sun, 19 Jan 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737247031; cv=none; b=JsMZFf3kV9+0aQuS27tS9Zk+mdMpipr3aTeSSD9I01ag++oDaeXLBsKZRx9l2ezUbH/a+x8CGiqDD6XcbJj76HHzMDCnTR7S3XK3MXOFAtDWnAgH7yAu6kxM3b8W3oiO9roePh/xiroWDiALIYCL66ZxomwUa868anbv3Cfu6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737247031; c=relaxed/simple;
	bh=U8RjLxuQjzc0YdFVSoMX2SGusBZwgPBeV0c5AuJpV2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7fTfzPnuNclgJ4geNB4HiluriHHofED8wGWVRZdEDt6fiuQc5wwzh5N2qrh1+57Ge601nNp9cC7tM3z5uB/OpKR0VakNI0+SyBpmKWDXvGRGYDQ2vCtc8sW+sMjbkkatwxU0M7i4M6XmVlKa2HPevlOmsTjoRNQqwBoEaPT/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Dj2IBDBj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737247014; x=1737851814; i=wahrenst@gmx.net;
	bh=QQeOLmt0vKFgnNb5WK93uDhGtWcqwPO2Yivyo/lj/+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Dj2IBDBjpSHo/k6yfDsvYs/lSEz9bbng7of6IyE6bGn0hdEoSFcJpyWFf9+5PpMq
	 XpBknT5j0qj9KFtdUxLp43Gocig7GcZj12d05EPbuOIqqffrw6VoUehTyDaCbKV1R
	 Y2r0PRaoBtZuK3WN8+rw0rBWXHF1+KlT5wohEFVGM1VxeBefuEVMlRBe5R1ZGe8ae
	 +yO6ZZ9dgmtO0iFrKUKmukxA9twv2hdMKcgUPKdMHV8K5XOH/MJm9Udg67Gd3DeQf
	 CDBHI4u+RHjU6hUJs4MFgGV5ra0al6wchbDz0nK2i/tydaIgtsW7BfheIfqgbtHcV
	 NGYeoeUW3x5kK64xHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1tHVlx1QQR-015xDC; Sun, 19
 Jan 2025 01:36:54 +0100
Message-ID: <808a325f-81bc-4f5d-8c07-fa255ef2d25a@gmx.net>
Date: Sun, 19 Jan 2025 01:36:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert v6.2-rc1 and later "ARM: dts: bcm2835-rpi: Use
 firmware clocks for display"
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 stable@vger.kernel.org
References: <cb9e10dfb4f50207e33ddac16794ee6b806744da.1737217627.git.hns@goldelico.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <cb9e10dfb4f50207e33ddac16794ee6b806744da.1737217627.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yBn+2i4VZk7CtBetjY0K7FS0g1A6jQXZ+D1aePttNbM3MAP2Zuo
 xCB+bsKZI5fQyenRpy9moR3Wh8XIIIFBWW3ejXsHWzkHHyt8XDzCkg9Rxk+3T+0xpC0QuKH
 O0a5ahA0sHH0HQpa11WLLolGGHNiNJQwKyTYsCC7HDdOZsqdxpyWkNwmGP09VakGVAHsorp
 6+N5OzWL2qrfhI4TADBmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JFu1LOedMYY=;6O0P/bjrcaaOi7pZ1x6JZtHSnun
 kFVmt6fjK+ivRcfhPwlghpZ/A7O/8MjHKOyTwl7GAneGiTYPaQLoz2p9OKqMlt/4p3BU/5to3
 YPUOD06aJ4kmCKyYTOnZMqXbLfHfmLueyXc0VUYAVybp/pIbLIhLDTseaqJ5o9lnSIbg//D7A
 J+tmwMUBMyavVBtdZeT5dMbsEW0E27ejnttGdCQZc+JBHLrTw8lkuF5ILokqJRPs3VZmyTz1z
 4ZDfAUnG46mnnNG8AnI5atqQgueshehe8mtnacr/TCgJVQNahc5AiaN29B3F/X9O0ZWV+MZhE
 BC3+HCIOzoYSWMQ/BfxrwFrs6yEmZOH11kUekgvfd2QIkIT+vrwN6EpsLCDlpO8q2L1dKkQIz
 cIemr1pm6SLN/Ag9ueqtrdWakrg8SGoBjrFOpi73nbBldoGidmoqOt8CxFA8Asj72mWmdUQq+
 o3Pf4XSVQ4NGyn3MpF2G1gxuaCG/ZqzAJT/jBHfcz+fXmF2+6mR/twjgaSpZZ9l3EHcK04Hzu
 AbPjqyGVA7/ay+f78lBggPXt6Q97Wd1aVXnrdTO1XgdV5zysjMBseiNpxm76LsSKZBkvuA2gO
 Us9Sr8Gles/8SnsFkaX3hFI5TjXsDHJb9FwuywpWfDSR0OAMnGFkGRRbP7T0CsICN4wV7LHhg
 2fBFW1kd2wY/2cXC8a5L3JS845Rz7j8yWRvHQyYzJjCC7no/buFwDEpu34ByKcsJO+KrK71af
 wOZ5+/WyTaPKj4kCP9vXQObUoad2Tcp61agRvxBjiQNBYIIQAaNkwz6pl1reKQFco3fZjC6ud
 sEUL52zbw2YBhFL3M5TyElPn3P2m4pzX6L1xZKo3QMwVt/eDiwWBgQsyJjw2czcW/lEgXo2my
 NJZfqs0V6xfDhg1Xx12qzd73+fyz74jXOXc6VV/8Fcn1HxYLcFbm6xkoFPscwVS5tUC1r9dbc
 lUZML0pKF5dnDFSDSNKQIYQleTImxxiZ+oFcC8zW2o1NfoycZsQb0rEWnVuSBBjNqrUyeU1mr
 SfN9RGxMF6kaKwBdIMbwbuEj7vlDptkdUYgbHKKVNRobTq/yRnz5Zoi1nSDbgnKADxAlARUCE
 ggbXh+j39Z7IUfkcMWwXSMYxorV64dtmHqToTKV8Y4Ygh/+/JwE3LEtjtbNbpG368fMBW9Y+9
 z1yYHMS1JDu6i0oBVkEVCnzj4ztpyqaM+B7A4Cy8uyg==

Hi,

Am 18.01.25 um 17:27 schrieb H. Nikolaus Schaller:
> This reverts commit 27ab05e1b7e5c5ec9b4f658e1b2464c0908298a6.
>
> I tried to upgrade a RasPi 3B+ with Waveshare 7inch HDMI LCD
> from 6.1.y to 6.6.y but found that the display is broken with
> this log message:
>
> [   17.776315] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_drm_unregist=
er [vc4])
> [   17.784034] platform 3f806000.vec: deferred probe pending
>
> Some tests revealed that while 6.1.y works, 6.2-rc1 is already broken bu=
t all
> newer kernels as well. And a bisect did lead me to this patch.
I=C2=A0successfully tested every Kernel release until Linux 6.13-rc with t=
he
Raspberry Pi 3B+, so i prefer to step back and analyze this issue further.

What kernel config do you use ?
What is the value of CONFIG_CLK_RASPBERRYPI ?

Best regards

