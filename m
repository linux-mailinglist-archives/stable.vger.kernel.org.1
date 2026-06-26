Return-Path: <stable+bounces-268912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uxlJOYV/PmogHAkAu9opvQ
	(envelope-from <stable+bounces-268912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:32:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07F6CD74A
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JjxSZ/kB";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268912-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268912-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4A0E300D339
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D203F54C4;
	Fri, 26 Jun 2026 13:32:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6C3ED5D4
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480767; cv=none; b=YOV+lGqozNRwOxToiSRKCgJ1WvVMuMrnhf1MM7KwzDUu15h05RMtD3TaxX4tILZIJgPoWscR0gdihH3j/rURRMWb40kPkkDuDP5Ag4VUvtqxtQnTOmXMKHOYs119p5JMNjh2GWg0Yz7ZXpsUquVv8PvZNb5SAznhPngWsTkNNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480767; c=relaxed/simple;
	bh=eYxbnzJlUlHT/UQT0GR28dDPGvcgtBeIxCBm3lsj8w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuT7CG0I0piSgaYhK41E1YICdrFDdL8KeKZ6hKdgl87/mTggaJ8JcqCcVUmuTwOPdA4FXgc9pcz/jUhtGKbUcqs7f7EfB/dNItZd+lhNHJ+IgOh/6wmx5yMVJcwCT8CrmNB64L9OcZglphquUsiKy1bjz+xQKzeYx2DwGmx7muk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjxSZ/kB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E4B1F00A3F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480765;
	bh=eYxbnzJlUlHT/UQT0GR28dDPGvcgtBeIxCBm3lsj8w4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JjxSZ/kBxcmtwAqzE/ltO1VCK1f8+F+qAH8t90OaOV/BL++OTTOOehxD3UuzrxTxB
	 XRKvG/uwAlbDebtZjh0h3TvxBKeGMjgX0cPYp4Ttb8LUjqkznybAVsEi7eBxPI6FPz
	 aLBUJ0CeEyw+dNCGllQDWUX1bmkfzDO6uh8EjTB0hvHsjB3i5AQgeXG83PxabZ87AL
	 lgzIA8Sd25T3WyeUiXeTDIE02PFUpTjNyHQT0uOJu7JRSKQoZj9U769K702zggTYJs
	 Wl5fBGG0ldqv5EyJYRLaz3xncka0Am6E6PBMYwSGZZhsVDSmocGmL54MudwuG9I1vR
	 yKNElLnsuwBew==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-396771119c4so8719981fa.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RolTcpaQ3IZ/U3CYuBfzy2oE0TbNDCd0AO26RvP0maEIAN/OjWown+sMRm9cClt0XljW3ORSVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbAPS0XPJKz2upHXgsmUyKd6hsNbsw7LGnCleuFrDGFJjaW/Z
	WETj3fVRb1RtzPpFc8dUE0z5nRvsfwxmQ9WomsM5zT3ZUYVugPW7XD5s/ds2gvSBoC+LRFmHp+G
	MLDQoXRrsbQp1YxGiugZylzxxp6QbBVg=
X-Received: by 2002:ac2:5dc6:0:b0:5ae:a9ed:249b with SMTP id
 2adb3069b0e04-5aea9ed24ffmr8111e87.60.1782480764654; Fri, 26 Jun 2026
 06:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
 <CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com> <aj55z9_pk7G7vOha@shell.armlinux.org.uk>
In-Reply-To: <aj55z9_pk7G7vOha@shell.armlinux.org.uk>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 26 Jun 2026 15:32:31 +0200
X-Gmail-Original-Message-ID: <CAD++jL=r5PKpKHK+OCWvDmzPJCAz-706x-8KheDj4+u+uJt_jA@mail.gmail.com>
X-Gm-Features: AVVi8CcrlZ5QTECLa-eRqzbPFMzfDHmxJ2msoXvrQi5mCDDz3n3yUknq4PEtLd0
Message-ID: <CAD++jL=r5PKpKHK+OCWvDmzPJCAz-706x-8KheDj4+u+uJt_jA@mail.gmail.com>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
To: Russell King <linux@armlinux.org.uk>
Cc: slipher <slipher@protonmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,google.com,vger.kernel.org,lists.linux.dev,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268912-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:slipher@protonmail.com,m:nathan@kernel.org,m:kees@kernel.org,m:samitolvanen@google.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,m:linus.walleij@linaro.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D07F6CD74A

On Fri, Jun 26, 2026 at 3:08=E2=80=AFPM Russell King <linux@armlinux.org.uk=
> wrote:

> Aren't regressions wonderful!

Makes me feel alive! ;)

> So I think safest is that everyone just moves away from BKPT.

I agree.

I'm waiting for the compiler guys to see if they have some good idea
on what to do istead.

Since it is a security feature, to me hanging in an eternal loop waiting
for watchdog reset or power off is better than issuing BKPT.
But that's pretty nasty.

Can the compiler simply use a read of the guard region at ffc00000
to raise a SIGBUS? (This is inherently a Linux-only solution but,
perhaps this can be parameterized?)

Yours,
Linus Walleij

