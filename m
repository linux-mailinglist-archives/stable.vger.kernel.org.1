Return-Path: <stable+bounces-230981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Gho8FPafyWmN0AUAu9opvQ
	(envelope-from <stable+bounces-230981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 23:56:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4471F354394
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 23:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59202300291D
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424C830171C;
	Sun, 29 Mar 2026 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdvgA2Bk"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DFA2EA16A
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774821358; cv=pass; b=ZYWUvpoXTaegqm9iU/tY6FJeafZB7WKBHYQKuCuzmI8yj1zYYGezGt6AS8iHVav40LyvqGiposBMarmzNRBOnTRdpE5mi5zzL5zyLlShp0ulvdp+jPnOfjF1wrDS/MrCOsWUjg8Ee+LrfOrqAb919/H1pHnvA2Ebyk3cl3UZyx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774821358; c=relaxed/simple;
	bh=Fejz6rJ4GEPFTaw06ZTFFlWOB51sqXYDKUai/Vk/JIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQqMnwmLl5H7HL+wnKrHBLBWp7oq8Bo0UG4AImLwQtiZuPlZ0qSgze+eGUKijjaBOPW+d+JyIscrnLCSS2rEiCWC4/5t0XM5trbtGv9QaqXoaXv2ffEJfhxfwTfpASUpQF1yF5m5q4RB//KalT2me8B5v6ZdWcfR1nP2wbcBWts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdvgA2Bk; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45f053b7b90so2110619b6e.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 14:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774821356; cv=none;
        d=google.com; s=arc-20240605;
        b=EeT6a+ebADYUFK0eQxMgP2zZ5mRcoGiA/exuD7pPvH2qzRnuRgKFEANU2GV/e1TCz5
         mUEgCsb+j2dyR2Qu+jn5DbJLA7V/FlYTHuJbLs9P4rcxMwjWQPU3fuMoBSH7cDJg0J9P
         i9FLZHmOi/J/J92b+FiiIEdapalpB4vmb5Ka1efyF5/4RNskJ0/rch2JomgbsPW0HdnZ
         0ocYC2c2hX2uRp6t37GDP7t9VH+7lVvHUxv0P5QtzxcEMt6iWVKAnkTGlcK2RjdVkTu+
         J5ETdaZ+xFQwBm6nHhB4rMp5nCRN8vShstPpzgfN+sBdCUCTJwqunjiYxxqC0DWh2Ss0
         R2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P8t7yw82NC0kKIhmlhLsUaimYifnA6UnB6dfoQqt+Eg=;
        fh=ePON2cJ7pSEHyfWpJegMp9WWysIuhHYqSxskkseelsU=;
        b=JHA8bCEYdVvHXC2oJDNDwNJdWRhataeFRA1Lnzld6bCrKWupMZxmEVFNuRL54L6v7w
         170HVrGVmfjhfH57aifaT8aTG/ZlHsP6MD58Q4LFy0URtDpUhEJLNWT6D83rVMA/o4yF
         hvCW6X4xcN4VHkEVe4EuLlSWXPz4zISccP8vSgN67Fl780jfU/Entf56NqytvXsHvheI
         FplbqVM+2gK6IgU4b9pvnjqtlscT6hRu6zkvQaVkcXfqabShzoN84lOKdixZLedZaY5m
         tC7GL6EXledDv1UAzpsYfk9AgJYaYojGUqm1x6KiedhMuyfodvjeP0ahBk5TzK2gsJiQ
         nyHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774821356; x=1775426156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8t7yw82NC0kKIhmlhLsUaimYifnA6UnB6dfoQqt+Eg=;
        b=RdvgA2Bk8mp92XT9DE2NOjhvi0VMu/S2oRX2fX5Qjxdp+h9KD4KfOCIqvHjqVCk2rd
         4uo5wQBz49u7WN4QY+8dLkjzIujOh676LEBsDhq/M4CbNDfofi7U2XxPtaNxZD0EVIpD
         ZSZvWi6ZZPDjyEi1hdw9+Z+yLKKDLdO1YiPwd4m10PkfYiJtloSZRN4GOO/79uKBsTyo
         xQJmA8CNkVDt3vO5ePV0KdHzYtcXTRCejV0sfxnBRuxpp+U+1+ERXv2+57roX4I6Jeag
         YaT/LpoPlcn5g19CDmLye0wb4MZLzwMupkwAz+mDvcLh958ybyhgRojV2li+JsrQjUDA
         /NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774821356; x=1775426156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P8t7yw82NC0kKIhmlhLsUaimYifnA6UnB6dfoQqt+Eg=;
        b=YznYpnBjy3b0lujdDqNGBw8s17MiZlvcPoyl38s2ULwItzzR5Cw157OWvkLJ9LEwda
         pojgyt+0mPmy2ngbH7EXZzZKcAoCyUXrfsbaUNWNKV5Lo3KbUu5vSUWfJKqA37Npd3Gm
         lbGCkqADqu0/6fhiq03DxYBPXcXHqLH7Zx6u5pLi1Qtjw4dOYrH0wzRsTUfVUXFMN/Yu
         ze+fgJao1TfEcFtIpaBansknvLWYiJR30rinBUby3raQwGnI7BD3pcAgzP+hjxZoxsm+
         iReFhyTm0WEMxnaai7C/7yh9ekVipduMr00t7GoobcZ8E7lHOhbZC9rn8EwMXP3PVwPW
         yFFw==
X-Forwarded-Encrypted: i=1; AJvYcCXt5faukKKZN/EoCUTCFgODbIIdoNX+ncwKqH+AzmpTmNZO0bYIqlBJ3VA8bMXSZ+kCDtMsBYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtP34+I9uHLvfxL8GLzYZb13xPU656zuvR4q2OoZPvH2SUiU8H
	EEPTvnuiKj6DTPVWod7GEkETMPd+skk7Ugpcm+wxdwAxmJ5ZN15w/9qSxSg8USs8yWmp5ebx5kl
	sRg9EBWVMEsMMLlMGeB2nUROXE7Rchqs=
X-Gm-Gg: ATEYQzyIH1l5Xm94jQ6lrJnSfTn/LVVGOZ5CxKOYyNAWKOiXx2UltV0fV5V0C2+Zv5o
	lJJ5APgvbWYIqx51sg9RMKzSNgjSctaeLzPrWqfdixoo5AS8ZvQtOMZoIW44OTXNbbmP2p3XUXF
	96EnYYi2WhXDbuTtvzZiLe1n77y9c9jYTO488AdHgeDZ7TFiUx50z3PdPmOhPiNF8D82jiAYyu+
	saff2V+cS5swhfE7MUbIqrRRe8gXRb7r7yfzRTBovy3wfTnPnTmpi7MNUvvG1uKQW41NBU6pmDd
	1UIMFA==
X-Received: by 2002:a05:6808:2388:b0:450:aba0:f006 with SMTP id
 5614622812f47-46a8a451ed2mr5156572b6e.17.1774821355682; Sun, 29 Mar 2026
 14:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
 <20260326013719.1662-1-fjhhz1997@gmail.com> <CA+bbHrX3CdXqW6b0GbY_C7rmte3_9Q=89TJN=A2EBCQM1xSzag@mail.gmail.com>
In-Reply-To: <CA+bbHrX3CdXqW6b0GbY_C7rmte3_9Q=89TJN=A2EBCQM1xSzag@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Sun, 29 Mar 2026 23:55:45 +0200
X-Gm-Features: AQROBzBV4fYKXfmb82jpqaVIi77LDxx4s5eA8opKgtbx7U89qdegdHIbNTJnggI
Message-ID: <CA+bbHrUkGP5bX6SFVXLS-bTyHWUiRyHaSojvMW6RGPz+T55yHg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: fix the issue of NULL pointer access
 when deleting the virtual interface
To: =?UTF-8?B?5YKF57un5pmX?= <fjhhz1997@gmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230981-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dropbox.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4471F354394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please review my latest messages in the GitHub thread.
https://github.com/morrownr/USB-WiFi/issues/682

There you=E2=80=99ll even find a link to a video I recorded so you can see
that even on bare metal with Kali Linux installed natively, it still
doesn=E2=80=99t work. It behaves exactly the same as it does in the VM.

Here is the link
https://www.dropbox.com/scl/fi/i6h8xbls5xkvae0pitrbg/video_2026-03-29_23-44=
-36.mp4?rlkey=3Djm48ly9tjwbhsi4aauml2auh9&dl=3D1

Regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El jue, 26 mar 2026 a las 13:16, =C3=93scar Alfonso D=C3=ADaz
(<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
>
> Hi, in response to the three points:
>
> 1. VMware
>
> 2. This is the output of the lsusb command: "Bus 004 Device 002: ID
> 0e8d:7961 MediaTek Inc. Wireless_Device". The adapter is very cheap,
> it=E2=80=99s a Fenvi AX1800 (MT7921U), this one:
> https://s.click.aliexpress.com/e/_okxhxNl . But as I said, the bug
> also happens when using the Alfa AWUS036AXML (MT7921AUN).
>
> 3. I=E2=80=99m not sure about this right now. I=E2=80=99d say everything =
dies. I=E2=80=99ll
> test that to see if SSH is still available (I don=E2=80=99t think so, but=
 I=E2=80=99m
> not 100% sure at the moment).
>
> Give me a few days. I=E2=80=99ll test this again over the weekend. I=E2=
=80=99ll also
> run a test on bare metal (not in a VM). That said, like me, many
> people use VMs for pentesting. So even if it works on bare metal,
> which I=E2=80=99ll test this weekend, I think it would still be worth
> investigating whether it can be fixed for VMs, since many people,
> myself included, use them for work. If it works with other WiFi
> adapters, it would be a big drawback if it didn=E2=80=99t work with Media=
Tek
> adapters.
>
> I=E2=80=99ll also reply with a similar message in the thread.
>
> Thanks and regards.
> --
> Oscar
>
> OpenPGP Key: DA9C60E9 ||
> https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> --
>
> El jue, 26 mar 2026 a las 2:37, =E5=82=85=E7=BB=A7=E6=99=97 (<fjhhz1997@g=
mail.com>) escribi=C3=B3:
> >
> > Hi =C3=93scar,
> >
> > Lucid-Duck spent some time trying to reproduce your crash and wasn't ab=
le
> > to trigger it. Here's a summary of what was tested:
> >
> > - Kali 2025.4 (kernel 6.18.12+kali-amd64) VM on QEMU/KVM, with my v2
> >   patch applied
> > - MT7921AU USB adapter, passthrough to VM
> > - Full airgeddon evil twin flow: monitor VIF + hostapd AP + continuous
> >   deauth via aireplay-ng
> > - Also tested on bare metal Fedora 6.19.8 with the same adapter
> >
> > All tests were stable -- no crash, no dmesg errors, load stayed low. Th=
e
> > deauth frames were confirmed sending for 30+ seconds under the v2 patch
> > without issues.
> >
> > The one variable that couldn't be matched was the VM hypervisor.
> > Lucid-Duck used QEMU/KVM, which handles USB passthrough at the kernel
> > level (xHCI). If you're using VirtualBox or VMware, the USB passthrough
> > path is quite different (userspace proxy), and that could potentially
> > explain a total VM freeze that isn't a kernel panic.
> >
> > Could you please reply to Lucid-Duck directly on GitHub with the
> > following information? Here's the link:
> > https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4129198757
> >
> > 1. Which hypervisor are you using? (VirtualBox, VMware, QEMU/KVM, etc.)
> > 2. Your exact USB adapter model and ID? (0e8d:7961 covers several
> >    MT7921 variants)
> > 3. If possible, try SSHing into the VM from the host while the display
> >    is frozen -- if SSH still works, the issue is at the hypervisor/disp=
lay
> >    level, not the kernel.
> >
> > Thanks,
> > =E5=82=85=E7=BB=A7=E6=99=97

