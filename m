Return-Path: <stable+bounces-235434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDWwACXL12k/TAgAu9opvQ
	(envelope-from <stable+bounces-235434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:52:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AED3CD219
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED33309FEB5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F43E0C48;
	Thu,  9 Apr 2026 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piMk2zAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682E347BDC;
	Thu,  9 Apr 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749618; cv=none; b=H6ecu93s8ZSlFXkGcj/WpjWB7dQhEKsY/klFU97UsDsqjTsWn1fSxRoaWvT0aU7SgWdvHP675+K+LpAGqgqUj5/pGheRU4+zWsb/8gNx3dcT33wgCIPf4JtIJlNTl3+MPZlnHukms2VBNeQBAcb8Hu6VdZgW/Dsb2Q461Wbgvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749618; c=relaxed/simple;
	bh=OSccliokziw5UV6rkIs5aYcLuqOR8iiesk548tSKKeg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HcSC+nyyIHoTJu6VUaE2RPnpvCcnnwuX3QcNSYxf941DipBBlX8PiowQ7kPsAUKFuwxa1n9yDzi39WHcQ/FwWWpM9QzEqgMNpH6x6SIQgXRiBN7V3Eu0vc/DF9qUL0WIMcIfjvByu34X0e6CwG+vHjGYahBq0ICjbxajmBHJ57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piMk2zAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756B0C4CEF7;
	Thu,  9 Apr 2026 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749617;
	bh=OSccliokziw5UV6rkIs5aYcLuqOR8iiesk548tSKKeg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=piMk2zAF2OvdFuRIrYheqQbPcmcaKGOSclhZsdLV/qdV7nvGrRKk1nLfBUX5CwApK
	 MAAyc7pDzGQyRcBFimcTyMe/DoEOExBa01w0o/lRNbGiLrOl624a4od44322l+53ka
	 YacjwD4/+GT+IXQvFxYAE93nWW1xxrOn3kj9mrhtwNbyQ2TDYyP2lf9XXCcpAJKUih
	 HI3xjzQs0GDkp5UsqGGsq9KBKqDRgf4txMTNhbH6TZA9lil34+I68gbqp2i5zBhhFC
	 NfaPF+1QU/SbLZqniHl1tQ4T2085vWSfirvcCmY2x1sQhcGpGZfAyXgCM/vVY9LZ81
	 SkJgxilusC+lg==
Date: Thu, 9 Apr 2026 17:46:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    =?ISO-8859-15?Q?Andr=E9_Eikmeyer?= <andre.eikmeyer@gmail.com>
Subject: Re: [PATCH] HID: apple: ensure the keyboard backlight is off if
 suspending
In-Reply-To: <MAUPR01MB115467C51E492BD620ED390B6B85FA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <rp2oq787-0721-4005-9050-n437310rqo22@xreary.bet>
References: <MAUPR01MB115467C51E492BD620ED390B6B85FA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235434-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[live.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xreary.bet:mid,live.com:email]
X-Rspamd-Queue-Id: 53AED3CD219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 4 Apr 2026, Aditya Garg wrote:

> Some users reported that upon suspending their keyboard backlight
> remained on. Fix this by adding the missing LED_CORE_SUSPENDRESUME flag.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 394ba612f941 ("HID: apple: Add support for magic keyboard backligh=
t on T2 Macs")
> Fixes: 9018eacbe623 ("HID: apple: Add support for keyboard backlight on c=
ertain T2 Macs.")
> Reported-by: Andr=E9 Eikmeyer <andre.eikmeyer@gmail.com>
> Tested-by: Andr=E9 Eikmeyer <andre.eikmeyer@gmail.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs


