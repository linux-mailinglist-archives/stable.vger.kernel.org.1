Return-Path: <stable+bounces-242644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4a/aHova9mnpZAIAu9opvQ
	(envelope-from <stable+bounces-242644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 07:18:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E25C24B47C2
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 07:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B58E3008295
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 05:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34BD2EB860;
	Sun,  3 May 2026 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtPuaKEw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59D283CAF
	for <stable@vger.kernel.org>; Sun,  3 May 2026 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777785477; cv=none; b=BK8u3ZSANNbbgyKYXrAFqNn5C+B4NtPUTzZnMBqpf3p58HjFJZQ9/c87zIXnXlZPUVYjO49P2V7ea9XJXJOXcB6u/O/Y9uZEfuMKHlAPXkfcwX7K8sNl9hjJMFPLn8TfSPx88RLfV+S2E7nE2m4sn1BVO3RoaDh1apv5RYekYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777785477; c=relaxed/simple;
	bh=37N6JFrKPnWTrSTAuqfErMeIjQF+zUvmHD5jsw5HCTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aorpYf/Hd4UcNebChDEWEauB2Fu0Gnv1FbvDQYu/W12qd/pqlVLbbPLuW971XmlxOyL6N4yw9ORUuAAcMU8rWyEP2oayFucg3AQVlY8M3w+XA1sC7tiMRy0co5HLHOQsrPSb3MqPwHHLiefnGAHihY3bUyH4LZfQjH9U+lGbrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtPuaKEw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so40066925e9.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 22:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777785475; x=1778390275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37N6JFrKPnWTrSTAuqfErMeIjQF+zUvmHD5jsw5HCTY=;
        b=mtPuaKEwPq87DnW3m/+DtX6ACEgT/XYdMXFVXxVSVojJp28tu17ObTbap893JhBIKK
         uj6cYdx2q7Oy+A+Z9nEDTYul2bik2Q9fTqwDWumt4wjoYt7LZZP12ZrJZra0YgtpMPn7
         bn59LA19gw0+8Ay4IAhI6aoaqomRBTz3Lrc2EoFUG+q2P2E7kWX4LDMdEMr414LARgGI
         CwVPxFwLK/BJlyUh/D01U4W4nouyphkpte7DU/qRRla0Inn9TXNvoXsmCVTKcRVSWwEt
         O7CjYfz7vha2y8dqwG90i/mUv7VIvQjhH6Tp3+12+0/VGdJq+DosPRHePBODIdODOd8C
         0Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777785475; x=1778390275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37N6JFrKPnWTrSTAuqfErMeIjQF+zUvmHD5jsw5HCTY=;
        b=PMaIN1xlXGpQ8ohgv4lywgzGHJHutceluwKe2ZrrU+AC57MraXb886Dah2Rk/NT7q0
         im1MLMOe55WFzt/XKsbxJnC+ccODk5Gu+4E7wvlfCN8oyXUYDKZHJiK6jjtT0fCiAz5e
         EEx6QnukqIuKzkiWJ7rl57POY15OZc1q21E6pmS4oHgg6UbDmI8E7ryE03V/e2V/2knS
         Dzkw9zo9Wgzav6tVwPXPnhdBCgjLrN/OwuNWUsMcyVy70jM4Xe53KV781RXm8wquDsG2
         IqgW3B0qQ0qChg92IyV4rc05rweJ6b7WHqwaBQOOhSjWkhX1gzCgFuAEfg3UFVtwhF7q
         r0DQ==
X-Forwarded-Encrypted: i=1; AFNElJ+j1EmZ8dCqnTFR1WlrSmxpxhDVC2rTQMdsONkDKchbQtROw0gHiQypyXevMJT8ZAt6UEqZ/hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXGcgWSXsmPlAe2Ak4akmj4VW2myFBSIxn5liRfHQLPku8xMc
	LjREcZGiBr9oFnnHsZE4C7jFI+WfVrrTEAZq31XoQXhtF+RE2Wr8x1SP
X-Gm-Gg: AeBDietCoR1foR2Hr4Uuwt4U/gyJKMIxCaJCqUl4jpudPeAPsmfqYsfAAWC8v5iCskV
	2q+Em+cpVUTxBQnKTxnEJIScuJ7YI5mjWLy+SHVJzDokju/7w8AcJI9Wg6miqCun6NA4cVwdwzm
	x7bzRY+FtVuxvsqyi75qKhLq87Pl+1mS1SkM74ce+FD/aVvk9lrdKoUcE3IQ4xUz6+GS+sia38L
	xnTHoVkcXpRBsukir4nsMgCFXsCAkw2kMe+ZU9LKZZxvkGqJQqCsFxof1wAPjhY+uyh9mIHlUWD
	DAZAoALmQ23cL9T+eIc1VEE0m5ZFcQyYigFqFoH5n8LOOLgXmp30OoeIvOU/nbEfJ6IlAvnbPNX
	ivi8+10SbBFyZfjVlioDh/eOxHH7A60/31Ru93l4yJRv2KfuSya8Q1hkBDS3IVBwidrQ2/4f4a2
	6ZroPF1639jOmIrBmdqHEHuub4hABBoQLqOTOeqtJmPUf/4JwIsNjsg5Wv
X-Received: by 2002:a05:6000:61e:b0:43d:4df5:3de with SMTP id ffacd0b85a97d-44bb65df980mr8599442f8f.31.1777785474469;
        Sat, 02 May 2026 22:17:54 -0700 (PDT)
Received: from foxbook (bgt227.neoplus.adsl.tpnet.pl. [83.28.83.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b768fdsm15579737f8f.33.2026.05.02.22.17.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 May 2026 22:17:54 -0700 (PDT)
Date: Sun, 3 May 2026 07:17:49 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260503071749.6abda137.michal.pecio@gmail.com>
In-Reply-To: <CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260430104850.352bd946.michal.pecio@gmail.com>
	<CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
	<20260430235453.2288c973.michal.pecio@gmail.com>
	<CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
	<20260502114644.76e6b5a3.michal.pecio@gmail.com>
	<CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
	<20260502235517.089ba5bf.michal.pecio@gmail.com>
	<CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E25C24B47C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242644-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, 3 May 2026 00:36:27 -0300, Desnes Nunes wrote:
> On Sat, May 2, 2026 at 6:55=E2=80=AFPM Michal Pecio <michal.pecio@gmail.c=
om> wrote:
> > On Sat, 2 May 2026 08:38:34 -0300, Desnes Nunes wrote: =20
> > > Kdump doesn't run and no vmcore is produced: =20
> > Is the kdump kernel not launched, or does it crash during boot?
> > The latter would make sense if there is some problem with the code. =20
>=20
> Kdump kernel didn't launch at all, thus no vmcore was produced.

Well, that's weird. But it seems you have serial console enabled so
I guess you should know whether it fails to start or crashes.

> > But I don't understand how patching xhci-hcd could possibly have
> > any effect on the former. Does this new code execute at all? Does
> > "kill the damn thing" ever appear in dmesg? =20
>=20
> Both kernels booted normally: the first one checking HSE after USBSTS
> was logged on xhci_handle_command_timeout(), as well as this new code
> checking for ring state or the HSE and HCE bits.
> Since kdump didn't start, the message "kill the damn thing" never got
> a chance to appear on crashkernel's dmesg.

It could show on the main kernel before the panic is triggered, if the
main kernel was patched too. Maybe they are the same kernel binary?

I'm trying to come up with any conceivable theory how patching xhci-hcd
could prevent the kdump kernel from loading. Still no idea...

Regards,
Michal

