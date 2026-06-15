Return-Path: <stable+bounces-263160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zollNzm+L2qKFgUAu9opvQ
	(envelope-from <stable+bounces-263160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 10:56:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E523684C60
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 10:56:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Wax036lk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263160-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263160-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E97F73006836
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80C39150B;
	Mon, 15 Jun 2026 08:56:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7A3A8FE1
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:56:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513781; cv=none; b=ligwgIkkxOqay0mGwPFD/wEVQSS6fWpEaSrtDLNEe0tmLWYoDEOeQmuMpKOHPkkkLxdm71YWwvxWl6MqH2Sds1DXDZRGCduZXVnH2cJpK5/aJimuEgUeZBPo4duqqQ4l4FkYt1jmokVSBuJma5Rx0FQUbS95mRXcua/kcRTBiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513781; c=relaxed/simple;
	bh=ZKfH21glWdbDRfqMbwsMq/OQ4udKVc6vViSAruOajjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAywK0RuUOkm79XZGfJ1iM+FbW71ANBK8vEdbUYVLLmBztS4/hQPXmHVicbkQhW0rIjZqSZoj1tevvl5izKz7n5YWAze9nWzPglk67fvgQ4CEGamkOXEA2RY2kOuxnHsUvSriMVbzSffynlHVUOYqNRwTITAl0Dbcpmru87EOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wax036lk; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b9318997so21768885e9.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781513778; x=1782118578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPi66HdqLZ5JIMHwZGt9OqfxPz6e5uIrhcdWeXWjXYI=;
        b=Wax036lkm56QJRh4EUjYn9bD8k3UqtZOC/zXFt+gfLYzbk24Ekct/azM1I0kVQNjum
         ca6kSbIOV0iGenwu5Y9HgMEjw1tU3yJwZ7hKDfvzLIO0LZJSa1qb6TMPcdQSbCKJP/Ab
         CtpDRS4z2lVmTFpa1rG5CMd61XpXMBSm7SFNeejg3s/yNaWyfvR7e4IzoPtDfJXWAhW7
         zcezEWXSNuCTsWkSlIPm77GSp2VlpnNVUPG9/MLki4UtaLaPA+r8DiDWUOr4RaQxvQwG
         wZ+XSQB736gY+yj3OqtnDO4c/MBO+9j/WHfD5veSIhGzMSeTDyDmdQQpb9FO2u7Aj5oI
         q13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513778; x=1782118578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPi66HdqLZ5JIMHwZGt9OqfxPz6e5uIrhcdWeXWjXYI=;
        b=tDZHWg9WQ7pfnbGDzqvLI+vOoEkrakhDpH9gYdnAf9SqEdx1jlZYnyetqZRWmlQazV
         abrKrRpNPLbuFF2vmOY0F51dlBF2QumGa6NWd7bewY54zSYTEygozlhbpQnPFiwJ9SA9
         d4BjGcX3JHqDmKpDdvQkKoWo8Ezm8ZcoW5nZDQeGDguKi5Xv4CtTNSO27P3+3eCw+8kX
         AHwvbUP/B3O2AG/Vz8knBJ8KEdjbJbJ32ukToY2BCEiPG1D+TNzRJ/FbtRhpYXxOgFhE
         fMgbzEg4bR3cGSobe23Z+tmrEEJlkyWVvfXc8Y7g2SV17BhJqvHZ0z5jHzOCdayp24IX
         AK/w==
X-Forwarded-Encrypted: i=1; AFNElJ/yOhLMbaE36MKFVUNEipUYM7eTnHXzo0Gbs/KjWimP/K7Y8oF2CI1U6sR2VBmVMYsqwsvGspQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOihkyFiqoCSW4OpmPVWURZWxBYq1X9vXIRsUFD36Mok9tlzxv
	oqKb87Pt38FqTYiFrTyxfYa16BY5XesGWW5+73uyFV0IxWVmbu27TfMh
X-Gm-Gg: Acq92OHvttSXGolqmoPiwtjnX+lGqimZTq5kqoxIoxgR2nNzvcnqbRDmBw8jRkTmQF8
	d1xWPEqmL+cqtLHsQ6NdoVauisd8r8LJryIzjh4inl2AEZDVu5a7lyArljocPpu6s+G5WDhHI5D
	pKBFMfRDcMyyNp5oBDEbxddiziZ4Oc9P/qQelUhhjDPbazzJjC3TMA7QH7wQ64n39vB7aVcR+Wo
	BthS2riMGWW8QWzSMOUGW4QF/0lYdBALlGDw4jQsdVvtZzDuOL9jbgIlEiljjWqQvZmJ9WPtN9E
	TdX3k8v1FF4f1HEXi5C+rOJH9LmCQZScJOvpDfpLuts4Oz4OvIbyyhwqWBMJcSB6WrksgtlbbNW
	6NNcKvN7ogInh+xtF8dPRYmO5xGpfLUiqk/3waMF5ArUYiTYUdAGv5dYaCDqSrZk3KogVqhf6l+
	RycreI2tX3x8ywR5rjAoOmjJzC8C2jK3KR1x2pX6nn7lfFgUgzSekMoF5FEzNX
X-Received: by 2002:a05:600c:3650:b0:490:d354:bd0a with SMTP id 5b1f17b1804b1-49220143bd1mr83939345e9.31.1781513777712;
        Mon, 15 Jun 2026 01:56:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492201fad25sm242143105e9.0.2026.06.15.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:56:17 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:56:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Shubham Bansal <illusionist.neo@gmail.com>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
Message-ID: <20260615095616.1c590e14@pumpkin>
In-Reply-To: <CADkSEUizT2dxUni185QDEkmVA+_r9bEQgbuEbZ8b-Sg3JZWrFA@mail.gmail.com>
References: <20260518014920.135011-1-enelsonmoore@gmail.com>
	<20260614125857.398a0e13@pumpkin>
	<CADkSEUizT2dxUni185QDEkmVA+_r9bEQgbuEbZ8b-Sg3JZWrFA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:linux@armlinux.org.uk,m:rmk+kernel@armlinux.org.uk,m:arnd@arndb.de,m:linusw@kernel.org,m:kees@kernel.org,m:nathan@kernel.org,m:thomas.weissschuh@linutronix.de,m:peterz@infradead.org,m:illusionist.neo@gmail.com,m:davem@davemloft.net,m:rmk@armlinux.org.uk,m:illusionistneo@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263160-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,armlinux.org.uk,arndb.de,kernel.org,linutronix.de,infradead.org,gmail.com,davemloft.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E523684C60

On Sun, 14 Jun 2026 14:44:38 -0700
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> Hi, David,
>=20
> On Sun, Jun 14, 2026 at 4:58=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> > Isn't it more the case that the ldrh/strh instructions were added for a=
rmv4.
> > Whether the bus supports 16bit accesses is entirely different. =20
>=20
> No, it is in fact the bus. While the Risc PC initially shipped with
> ARMv3 CPUs, which the kernel no longer supports, it was later upgraded
> to an ARMv4 StrongARM CPU. However, its bus was designed for ARMv3
> CPUs and has no way to represent a half-word access to memory. This
> means that ldrh/strh will execute (because the CPU supports them) but
> do not function as intended.

Ok, so they work fine for cached accesses.
The only issue will be with uncached ones?
(Or do I remember the strongarm having a write-through cache?)

It just seems odd because byte writes are usually handled with four
byte-enable lines; so the targets support all 16 combinations even
though a cpu will (normally) only be able to generate 8 of them.

	David

>=20
> Ethan


