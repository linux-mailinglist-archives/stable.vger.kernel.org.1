Return-Path: <stable+bounces-262532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n0cYJdSNKWqAZQMAu9opvQ
	(envelope-from <stable+bounces-262532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:16:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3C66B491
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:16:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OCHesFF8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262532-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262532-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5278536BA64E
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09AE4219FF;
	Wed, 10 Jun 2026 16:00:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EF1429827;
	Wed, 10 Jun 2026 16:00:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107257; cv=none; b=sbMaE+wd3WogRUj9U8azmQHUZPuhG5dMGombqUMkzaTZRmIAoLGV3IhbonYrBNsO9Et+Ujk0gUztxMVIPTSznblw9VK0/u16/m1fTmscpQwJ4PUzLN8B+IMDPQs12KOHFzJhjIH5jx3kqhC6Sl/JNAfEAZog++H1vaLMofNG8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107257; c=relaxed/simple;
	bh=yygwYe7ShSyUHaZhEeUMjmed3v11V4TuHwXMVMS5XAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cq86y6QpHk0LcWbLcmUtZGIyIkodjIQfUNorTKT6IZVIU+1qAmnkhwjyu3rKzNxlcsjauBvkKM2sbbvxA0v1FTbkjJoO+sgyFujjoEi0odtstfdmYZJdm8gfs75b/oxDmUKZxU8iALub6FgOllgnJWBH3RaqIyx9TeWC6StW6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCHesFF8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC231F00893;
	Wed, 10 Jun 2026 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781107256;
	bh=yygwYe7ShSyUHaZhEeUMjmed3v11V4TuHwXMVMS5XAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OCHesFF8//A0zaC61op3thmafZuokfM0wtk/nGR7unwxA6rAoQyBfDdNAja9hHcQm
	 63kdmOZXk9Xh7vQBQCm6+8Y6Gtt01PVDdrkYEYbDSgKpGrsIItxyQMzDHCKFaP6965
	 ZbKaf/LU4f59jQDD0vErq6gZzwGVlmNWtpMYBwx93bFUnWBvHWwlhfRY/p4QX8oApc
	 nFAecEk/dDfyLFdmUHUwo1PYgx2WjkL/r3jTwNpprMMCg+hs313gh/Mmz7EaYLzvCT
	 aih3q50WkLu+GzTRY1VgHueBVKeLTzf2UkmjfdamM1T0vHg8G6E/5X06pm/EgXSum2
	 yV02N2ttD+XPg==
Date: Wed, 10 Jun 2026 18:00:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Oleg Makarenko <oleg@makarenk.ooo>
cc: bentiss@kernel.org, stable@vger.kernel.org, 
    Oliver Roundtree <oroundtree1@gmail.com>, 
    =?ISO-8859-15?Q?Ryno_Kotz=E9?= <lemon.xah@gmail.com>, 
    =?ISO-8859-2?Q?Tomasz_Paku=B3a?= <tomasz.pakula.oficjalny@gmail.com>, 
    Anssi Hannula <anssi.hannula@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, 
    linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: pidff: Use correct effect type in effect update
In-Reply-To: <20260609160031.493353-1-oleg@makarenk.ooo>
Message-ID: <r9903509-5s4n-o1qs-7798-sn361qqp0282@xreary.bet>
References: <20260609160031.493353-1-oleg@makarenk.ooo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262532-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,mail.ru];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:oleg@makarenk.ooo,m:bentiss@kernel.org,m:stable@vger.kernel.org,m:oroundtree1@gmail.com,m:lemon.xah@gmail.com,m:tomasz.pakula.oficjalny@gmail.com,m:anssi.hannula@gmail.com,m:dtor@mail.ru,m:linux-input@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lemonxah@gmail.com,m:tomaszpakulaoficjalny@gmail.com,m:anssihannula@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,xreary.bet:mid,makarenk.ooo:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4E3C66B491

On Tue, 9 Jun 2026, Oleg Makarenko wrote:

> When updating an existing effect, the effect type from the last created
> effect was sent to the device instead of the updated one.
> This caused incorrect reports when a game creates multiple different
> effects and updates only one that is not the last created.
>=20
> Fixes FFB in multiple games that create multiple simultaneous effects
> (Forza Horizon 5/6).
>=20
> Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
> Cc: <stable@vger.kernel.org>
> Tested-by: Oliver Roundtree <oroundtree1@gmail.com>
> Co-developed-by: Ryno Kotz=E9 <lemon.xah@gmail.com>
> Signed-off-by: Ryno Kotz=E9 <lemon.xah@gmail.com>
> Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs


