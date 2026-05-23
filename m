Return-Path: <stable+bounces-253980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fEUiBTAmEmorvwYAu9opvQ
	(envelope-from <stable+bounces-253980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 00:12:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31B5C0D98
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 00:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D0730131C3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B9325704;
	Sat, 23 May 2026 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JffdEPAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D7222580
	for <stable@vger.kernel.org>; Sat, 23 May 2026 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779574312; cv=none; b=eBwnAxejfbrLpgqukvMGyfzGiEuxlS4NJX4+UryxIlZU8jPxLjLLUByRQRyEpdY1wV+91ZHtv9NQ9UWqdHgmGJlDuS+l/9dyok3D1wDa8/eVQXVxd2bgA7EDzZegGj/d5Hx8eDeVbIsYbkZUPaX+PyNE2tqKJV7cb+7fTpRsFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779574312; c=relaxed/simple;
	bh=FglZgCFQ4warPzK5hdfB5/dY/hEy9mNhU2guCIrYsIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+YhqTC8DIz4i2J9NTImXso5YVe0TwfZThBb36ccPhQiHqkNlUSCPhh0u8j6CvEwbLFIKJkBAm/Zt086tY9sqBPkIGwJlk2ohllQ7szb9a8F+oj4WpzzxGgENL8/s2wRoMmKbHVEkXko8hOomPBSmZJZm0SnDfhwHfOWf8SZSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JffdEPAQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EBE1F00A3A
	for <stable@vger.kernel.org>; Sat, 23 May 2026 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779574310;
	bh=xUiBWlmWfokug/bhDYwI7emM+WOQXoX2pKibgpGhk7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JffdEPAQK13z1iDLJO+r5ZCjqF2k0SXjmv02OPCDVkdJ8HxPkx3RUkZmYYb/sTjmF
	 xz/UurGTR+Pc+fq2h/JyB68uJ97T1Nsmyg9wUBNV1gVplxKtgpRnsa5Yz1Bwn29rej
	 wT4zbxlLAWbNRhrbFhjovJdzP64lNUoXeBMa5Iuiu2a6ojbLBEDbGBKyVa6FIK5A3H
	 2nMIQIhFrqsdJnTwHArUD5I2uOe1eLDrsSg+CnAI7myGadAHndvK47lknZ/SBQaUgs
	 PcQoQd3R6gz0S2wSriLJCHdNa84anxgt53Lm6xXFawB8K++6r91bFfcvuc4HkztcVy
	 GiZYp43l+MteA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so13792485e87.3
        for <stable@vger.kernel.org>; Sat, 23 May 2026 15:11:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zjQA4TmQYAv861S5cKgs3kJvrlzupaeOT+YN70h/nkm0CJsZ4wLCs7BczjrjHEzX6U5zz0Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFiKPvpmE3nj3JtSjfVFj+d1V9cDBao5IDNAtl4ryoAywuiHt
	/pIZ4cRXiP0X3gseBIU437/wtHiiFtXppNN//98xn6ZDezVXRP/kMR/Fi41r6VRcQix1M0FlYEp
	bIOg+hFIvLDSm+y5E4SzVGl1EAFt3u0E=
X-Received: by 2002:a05:6512:3ca7:b0:5a8:8825:15fc with SMTP id
 2adb3069b0e04-5aa3238ba06mr2955522e87.3.1779574309233; Sat, 23 May 2026
 15:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522212018.25295-1-kmehltretter@gmail.com>
In-Reply-To: <20260522212018.25295-1-kmehltretter@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 24 May 2026 00:11:36 +0200
X-Gmail-Original-Message-ID: <CAD++jL=jrk4EYo+5mhp1cpy2cfsA966MVmbohWhcZdx_SObD_w@mail.gmail.com>
X-Gm-Features: AVHnY4JVd9LDhBpQKgiZIDi0f5dy-gmldueQmj7HE80mVvbvmmb_60Pm-Q0ZSqk
Message-ID: <CAD++jL=jrk4EYo+5mhp1cpy2cfsA966MVmbohWhcZdx_SObD_w@mail.gmail.com>
Subject: Re: [PATCH] ARM: io: avoid KASAN instrumentation of raw halfword I/O
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Abbott Liu <liuwenliang@huawei.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,huawei.com,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253980-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5D31B5C0D98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:20=E2=80=AFPM Karl Mehltretter
<kmehltretter@gmail.com> wrote:

> Commit 421015713b30 ("ARM: 9017/2: Enable KASan for ARM") made KASAN
> instrument ARM C memory accesses. For CPUs before ARMv6, __raw_readw()
> and __raw_writew() are C volatile halfword accesses, so KASAN instruments
> them as normal memory accesses.
>
> That is not valid for MMIO. On the QEMU versatilepb machine with an
> ARM926EJ-S CPU and CONFIG_KASAN=3Dy, PL011 probing traps while registerin=
g
> the UART:
>
>   Unable to handle kernel paging request at virtual address bd23e207
>   PC is at __asan_store2+0x2c/0x9c
>   LR is at pl011_register_port+0x4c/0x19c
>
> Keep the existing volatile halfword access, but move the pre-ARMv6
> definitions into __no_kasan_or_inline functions so raw MMIO halfword
> accesses are not instrumented by KASAN. The ARMv6-and-newer inline
> assembly path is unchanged.
>
> Fixes: 421015713b30 ("ARM: 9017/2: Enable KASan for ARM")
> Cc: stable@vger.kernel.org # v5.11+
> Assisted-by: Codex:gpt-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

That makes sense.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Please put this patch into Russell's patch tracker.

Yours,
Linus Walleij

