Return-Path: <stable+bounces-180810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3DCB8DCBA
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B82440B92
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57B2D6400;
	Sun, 21 Sep 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IDqqJ8bI"
X-Original-To: stable@vger.kernel.org
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E1258CF7
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758463070; cv=none; b=XoMZcUEV4FnX3t97NrlUK99gQuPN5VNVjB8C6G4G5zpgdxje43J+yRxcUvYQ1/O2RevEZEV1kVFDDde3T46G6toVCax/+pBxWwSu+zJ96vrA64+ZvcDrvV9aaz1xQsKhBf2kemEkFXqUQvnP4oj+cksd57pYWC618N5qgafoxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758463070; c=relaxed/simple;
	bh=naH1rkGMW+W6kfCuw5jUjYsu/5A0tChHt9oH4pRcXFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyjhczc+7vnCLAumoxm1UiucanACQsznwFV5xNNkVxPOrQZ3/w0u/7a61HiHfXqFA3hw5mjY2bP3DFJjrXGN/2oh3bn3MeICA6AQDkIBRstOODc5XQ3uDdjWGw2sYRUWms5HkLEhiuzEGwZU8zhVBj9E0C0vCere1QcIipqVwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IDqqJ8bI; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 3E621C4BBB
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 16:57:38 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 60F3DC4BB7
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 16:57:37 +0300 (EEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D73F61FDB7F
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 16:57:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1758463057;
	bh=NRueS7l51gPm7bl/J9N2xmCx0hmxJeNUHw9lcE4eLF0=;
	h=Received:From:Subject:To;
	b=IDqqJ8bINn5OVI1aWwZG4ebxP25b1rDwd3utUnyAmWtmxZaYOHUwQsb0n7T5u/GL5
	 UeuonmY7i5QfI1yNixLVQEQh/ZnyrC+5jfyi2uwt2fMOpouz9mYDPGrdBGyozyXEIR
	 +rirC7EXZIlqrNmcioO/Ab0Oop7DoSYUnIWzn+Ev/exxFFCQflsXvQFWaTAwb2dpaw
	 wByFpsOG3WO5ZLM0rk7qXjYN+tK8yNOE6JQ1m7FiSmBT40jqtdNvq7qsQJmfzLqtsT
	 t03B7j5HvDOoaZmx/Q3/SMK1V9Kqbyaauu6tOm2OSRKxwWMCzaF6Fm92s/vWv5Zxas
	 LapA43rOhx+Kg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-33730e1cda7so29535051fa.3
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 06:57:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxU4alTqo8KrW1V1454XlvDCutajMnfA684ouvMxkEvPbkhRfr2XW+5tZOn703VMh1kID4oqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2HYmveZj1FVfnFrWGGtbSTK7NeednNflsq5XVBWqdp/MzWrfv
	1oBVPHW2hhes0HW5hp9ReAv7fDcXZACPJwEyk4W8Ukwjhjs/tmfuwy399zIVrURiF4s+UUCfYbL
	CKueXEVloTPdLG91WZXG6HhW8lhFR5ak=
X-Google-Smtp-Source: 
 AGHT+IEtLfTNRJMBf0cf7crJcMaEe0iZ7q7IVqGzlNJNfwuadzkuebyuVQODahb9nw4OP9tp4w+T11ettudtJmkUTTE=
X-Received: by 2002:a05:651c:23d3:10b0:336:6c93:9726 with SMTP id
 38308e7fff4ca-364148b4276mr25788071fa.4.1758463056324; Sun, 21 Sep 2025
 06:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025092126-upstream-favorite-2f89@gregkh>
In-Reply-To: <2025092126-upstream-favorite-2f89@gregkh>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 21 Sep 2025 15:57:25 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwE-wBt2fiDyFPjX2tR9VySQJyXn1zLtEQFCRHnxNS=fWw@mail.gmail.com>
X-Gm-Features: AS18NWCzIXyxalh33FDNDHFr-CnpjOfIiIxrk3uzccKP8zNUf2cUTGZfwU02bxw
Message-ID: 
 <CAGwozwE-wBt2fiDyFPjX2tR9VySQJyXn1zLtEQFCRHnxNS=fWw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] platform/x86: asus-wmi: Re-add extra keys
 to ignore_key_wlan" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: ilpo.jarvinen@linux.intel.com, rahul@chandra.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <175846305707.3652301.10641007152223767351@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 21 Sept 2025 at 14:34, <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 225d1ee0f5ba3218d1814d36564fdb5f37b50474
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092126-=
upstream-favorite-2f89@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Possible dependencies:
>

Is commit 1c1d0401d1b8 ("platform/x86: asus-wmi: Fix ROG button
mapping, tablet mode on ASUS ROG Z13") eligible for backport to
stable? If yes it fixes the apply conflict. Z13 users would appreciate
in any case.

Antheas

>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 225d1ee0f5ba3218d1814d36564fdb5f37b50474 Mon Sep 17 00:00:00 2001
> From: Antheas Kapenekakis <lkml@antheas.dev>
> Date: Tue, 16 Sep 2025 09:28:18 +0200
> Subject: [PATCH] platform/x86: asus-wmi: Re-add extra keys to ignore_key_=
wlan
>  quirk
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> It turns out that the dual screen models use 0x5E for attaching and
> detaching the keyboard instead of 0x5F. So, re-add the codes by
> reverting commit cf3940ac737d ("platform/x86: asus-wmi: Remove extra
> keys from ignore_key_wlan quirk"). For our future reference, add a
> comment next to 0x5E indicating that it is used for that purpose.
>
> Fixes: cf3940ac737d ("platform/x86: asus-wmi: Remove extra keys from igno=
re_key_wlan quirk")
> Reported-by: Rahul Chandra <rahul@chandra.net>
> Closes: https://lore.kernel.org/all/10020-68c90c80-d-4ac6c580@106290038/
> Cc: stable@kernel.org
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> Link: https://patch.msgid.link/20250916072818.196462-1-lkml@antheas.dev
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/as=
us-nb-wmi.c
> index 3a488cf9ca06..6a62bc5b02fd 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -673,6 +673,8 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_dr=
iver *asus_wmi, int *code,
>                 if (atkbd_reports_vol_keys)
>                         *code =3D ASUS_WMI_KEY_IGNORE;
>                 break;
> +       case 0x5D: /* Wireless console Toggle */
> +       case 0x5E: /* Wireless console Enable / Keyboard Attach, Detach *=
/
>         case 0x5F: /* Wireless console Disable / Special Key */
>                 if (quirks->key_wlan_event)
>                         *code =3D quirks->key_wlan_event;
>
>


