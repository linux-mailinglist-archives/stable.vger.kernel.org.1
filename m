Return-Path: <stable+bounces-270387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bTtUF5s1RmpFLwsAu9opvQ
	(envelope-from <stable+bounces-270387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 11:55:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83C6F58E9
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 11:55:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=k2JsrNzj;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=HGS1HUgc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270387-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270387-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DE0A30D2078
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828004A13A1;
	Thu,  2 Jul 2026 09:38:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979414A13BF;
	Thu,  2 Jul 2026 09:38:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985119; cv=none; b=UKt/CVjheogdHIBKw2nC1108rZTv0AE5/ZnI7yV3psLKFCU9FNhw22e9kuHK9UnJaJGxOhTCXUuI+mvJIGXxZPRrFEE4A9Lj/ci8As6B931gHN0MKbkhJ6jX4i2oaewnSIzdyLQjgcbUKuduzbjIUKL3qnnHy96y7eKEehwTsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985119; c=relaxed/simple;
	bh=le1pY0cZzch4KB3xevM5B8Vs1Omxe5BuEZ41Xr3LB1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fmorewg7QWZHy5Kq7CtnmLeOa5k5APMJEF1x48MFShOS79W9nCfMIy9sXtuPJ3WqpGVOA/b1QnDdQzJnfoazyZ9Fat284mXM5sF8nLB5rGTeuAgGyNBQHH7FrtAkuGp9AQkrDFiisC4xpJWMdHvcfIWKBrNErXTt5n7mdMSmq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k2JsrNzj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGS1HUgc; arc=none smtp.client-ip=193.142.43.55
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782985108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le1pY0cZzch4KB3xevM5B8Vs1Omxe5BuEZ41Xr3LB1w=;
	b=k2JsrNzjKN9sdTwU1KQIhBcQnL37+Bgh58nrQhF8Zs4QOklPCoMMWd5wUu9O70RzDYqB41
	SMX/N7HYsPQawlZKev4fiKNSwoxOPujo0EmrMcm3VJHoxxQMAu3m7+6GPJACNq7hZBeGqc
	lgV4dI3h3S5lhzLlUR6FNZ1WQooO80fdSj1P5d/kbEpdcSKAjG5tYlqDG9CxLkKT19oSiq
	1lkgyS4G+ly5PRw6vOIPLJqPZZRUVWJ8UOwiYAYZ3J09rh6NwePVQ1jSP43H8Ys6+eeMO+
	AE1x1/04fsPAE+cOhXkNktBJ+l2oMsRxNQAa3RPK8hyz6M4UXwz2UsOicVbS2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782985108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le1pY0cZzch4KB3xevM5B8Vs1Omxe5BuEZ41Xr3LB1w=;
	b=HGS1HUgcxEI0vVmM7UnXSpfhK8UD0pyk0iOseX5a5RKfDvA+OAq4MfG3jIBNb+zCS35nSg
	67Zx1WG+/SO5nyDg==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Nathan
 Chancellor <nathan@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Wende Tan <twd2.me@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, kernel test robot <lkp@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: vdso: Do not use LTO for the vDSO
In-Reply-To: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
Date: Thu, 02 Jul 2026 11:38:26 +0200
Message-ID: <87bjcpu3xp.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:nathan@kernel.org,m:conor.dooley@microchip.com,m:twd2.me@gmail.com,m:palmer@rivosinc.com,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lkp@intel.com,m:stable@vger.kernel.org,m:twd2me@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,microchip.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270387-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE83C6F58E9

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
> With LTO enabled the compiler assumes that the vDSO functions are not
> used and optimizes them away completely.
>
> Disable LTO for the vDSO, as these functions are hand-optimized anyways.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Nam Cao <namcao@linutronix.de>

