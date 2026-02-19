Return-Path: <stable+bounces-217402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOkuA6DQlmkZoQIAu9opvQ
	(envelope-from <stable+bounces-217402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 09:58:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565915D27A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 09:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ECEB301B171
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5483382E2;
	Thu, 19 Feb 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI9sL68S"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FF3382D6
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491482; cv=none; b=lorcvECIia2LG557B5CfptWWmrzLvwVDcYC0IT60UjWbf9xtDBkBzAsQLKxHLJgaOP/K6MHemhI2QvVqA8TY3HHPcSff3DMdDeI5gX4IKgnB1Ii50gz1RRZk52DxUyL43vPhdWwkoPvSxg8yMGlcyuxWJ32S/Rcxb5m+dyEv3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491482; c=relaxed/simple;
	bh=RaU7x6gSN3yYDniJgRhFDMbiZ8LZTpqr9r4GDly3Xhk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hlNDG3iEzQV/rfV43hDfoBvWsS8r3+G6wnzDmUcJzfmjuoknOaRZie1ehOp2Su5i4OrzdNjEQefZurN3+ZWOigNbcDi3VgLsN2Ez643dNCsNpVRQvC+vggCp73XkoeZhj70ZTDUrWv+kbdKnW5K7LMWqvOKyLHF+Y4IESAiZFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI9sL68S; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-127423bea4bso1566864c88.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771491480; x=1772096280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w9QckPjYVpC7XREf2SsBK4wtYoxkxE+nJ3fOgUmSovk=;
        b=nI9sL68Su4BXNPdhkPvW+mUNhSF1mcbv/sx4CSzy7QsV57YxPoLosvbVAhEFgVWpRS
         zX5OTSfyE2TkStm4EaLaFs1vmC+2UMUdd8jHCQmDv2ovwOuKjVzZr8VlbOBy3Lf8Rc14
         Q17NqjH/1SW42GxFLcQNq5zGC0NGYbUaWV5otEv2YUmT71EhlRnv7QiY3Vn00MD0rCgQ
         kgjkkxaRkflvsDAKnpmvu7ef1ATQFeASjbzeGwi1ex5e8Mq/AgGBTkNrGLwF3jwIimq7
         ka4l2/xEgvCgreGIEi8fP5p6V3oTHCZvmVEqqdZkEpBG9CKmiQNWqkQRP2/3jFAkwxDo
         7OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771491480; x=1772096280;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9QckPjYVpC7XREf2SsBK4wtYoxkxE+nJ3fOgUmSovk=;
        b=wZmd3V/BC6VjCpVPjkywflCgeVffRfdp2n4F0VwvG2SzYhiCgGy+InLh46SHVjm0UL
         6WFmO9aU209I4No4mvAmIqoZBd0U/qHMp+w/zdCQR8hW2Baj/qrEUhC1TmeC6YaBG3w6
         h6oJyprQaJZSA/MckA4PEw+AH4aoyxDDMKLbtS+vDP6P5AQ4KEEUnrm0whvukCjQ+9An
         2dlSaZScG64hQsWNuVYCSQP/W7v3MSYPExe3EV8uNip+Hlo1G19ghuYLiwHZy9eQWFrI
         BWUdd3Pd0sRiiu3b+a/mfzpi0tryJ3sXT6k4Mg0LnRIifZDMBGxF1Vp4QcAvFBQ7usA7
         RImw==
X-Forwarded-Encrypted: i=1; AJvYcCWIkKMZEf4u90142lEYCNcG5lbiY2+5gDUXjGey40p8dNQMGwQIpXfuAv3F0RXtqUYAcyDjy2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2l1v6SF5l8gRmmnrpCDVWF/VW2ytWS5dJQc2N+WGgo8rRsWeE
	ljCuZuosHtWsiZxvmx6fKdLAjkglCrHupVbGY+hvJQ9+NEFt2y+NanVK
X-Gm-Gg: AZuq6aJ7AmNWLHXEGu2hBX6f6BBF5jkMP+p+3iyS/yeLKQqxj+OMhiQuZFVylDndoR/
	YCaBOFhXfjRM0K6K0q02h7C5R9alCFa8dHShl4HHjbaE3IGVDq3Wfh/T6XIvPLzq5Iqf5XOlBlz
	MYtBYhDpaFr+cBgqMBJqr0MQ4nBUWvZSyQORzZObU2r5Pmz0CJE4Vnho8Rh7qi4CJMboo2Aiq2N
	uN4N7ZdA37qTqEsQUOF63id3dfR0CzJrsSPBq5EX9gdqA3Q/48J8IjNjHGqA4oyYfE2SZDqB2eY
	qeFtiWQ7/GDosJFDNd/V1gENSS9ePSdZU7PT6LYtONGsWqkpaxEPDXLtkKhyA3COZ637vc1dG87
	rRFw/BZnRmXgYuXQUgIeVgFf5cQu8P08SvqFp9JGxDihlZda3WJjwS1c05HRAJqFlGeOGab1lXt
	08l1VnLvVUsrRH3jATVI7aIgk0/Z8pZ3nx9nNRfosr4Zo=
X-Received: by 2002:a05:7022:f9d:b0:121:a01a:8e2f with SMTP id a92af1059eb24-1273ae688f2mr9613531c88.42.1771491479596;
        Thu, 19 Feb 2026 00:57:59 -0800 (PST)
Received: from ehlo.thunderbird.net ([2601:647:5e00:4acd:97bd:bbcc:96e6:7f02])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b62455sm25648107c88.1.2026.02.19.00.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 00:57:58 -0800 (PST)
Date: Thu, 19 Feb 2026 00:57:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
CC: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_gpiolib=3A_normalize_the_return_v?=
 =?US-ASCII?Q?alue_of_gc-=3Eset=28=29_on_behalf_of_buggy_drivers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260219-gpiolib-set-normalize-v1-1-f0d53a009db4@oss.qualcomm.com>
References: <20260219-gpiolib-set-normalize-v1-1-f0d53a009db4@oss.qualcomm.com>
Message-ID: <48629460-701F-438F-8E1A-6F428C49FF6E@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217402-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4565915D27A
X-Rspamd-Action: no action

On February 19, 2026 12:52:37 AM PST, Bartosz Golaszewski <bartosz=2Egolasz=
ewski@oss=2Equalcomm=2Ecom> wrote:
>Commit 86ef402d805d ("gpiolib: sanitize the return value of
>gpio_chip::get()") started checking the return value of the =2Eset()
>callback in struct gpio_chip=2E Now - almost a year later - it turns out
>that there are quite a few drivers in tree that can break with this
>change=2E Partially revert it: normalize the return value in GPIO core bu=
t
>also emit a warning=2E
>
>Cc: stable@vger=2Ekernel=2Eorg
>Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::ge=
t()")
>Reported-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>Closes: https://lore=2Ekernel=2Eorg/all/aZSkqGTqMp_57qC7@google=2Ecom/
>Signed-off-by: Bartosz Golaszewski <bartosz=2Egolaszewski@oss=2Equalcomm=
=2Ecom>
>---
> drivers/gpio/gpiolib=2Ec | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpio/gpiolib=2Ec b/drivers/gpio/gpiolib=2Ec
>index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81=2E=2E9f7a1a1ebd8365fe933c9=
89caf9e8c544fd9ba0f 100644
>--- a/drivers/gpio/gpiolib=2Ec
>+++ b/drivers/gpio/gpiolib=2Ec
>@@ -2914,8 +2914,12 @@ static int gpiochip_set(struct gpio_chip *gc, unsi=
gned int offset, int value)
> 		return -EOPNOTSUPP;
>=20
> 	ret =3D gc->set(gc, offset, value);
>-	if (ret > 0)
>-		ret =3D -EBADE;
>+	if (ret > 0) {
>+		gpiochip_warn(gc,
>+			"invalid return value from gc->set(): %d, consider fixing the driver\=
n",
>+			ret);
>+		ret =3D !!ret;
>+	}
>=20
> 	return ret;
> }

You want to patch gpiochip_get()=2E It could be that set() is similarly tr=
oublesome, but the report is about get() not working=2E

Thanks=2E=20
Hi Bartosz,=20
--=20
Dmitry

