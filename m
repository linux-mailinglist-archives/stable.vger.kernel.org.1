Return-Path: <stable+bounces-246866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM8vH/6DBGpwLAIAu9opvQ
	(envelope-from <stable+bounces-246866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:00:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1770534905
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CD5731B3B82
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0585D304972;
	Wed, 13 May 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArKW+53H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883A3F4135;
	Wed, 13 May 2026 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679338; cv=none; b=biMGYaqkVUVA7VKAeigXCepjYof84Xjs7nuonMhIBFX4k6OAFZcAM4a3VOyzzbdmrYsE5N8eNHF6WvpNzj0k68aCxB3VsLW03Pb71p/o7r7sVqrAFugdrSxfhQcMSfiRqsKQZFAlQgZyt19KSAlpL/jXdkRHTBMSESVD97jes/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679338; c=relaxed/simple;
	bh=KjbblYiiEBif+Niwo4suUNP8LpP9G0670n6uJ0JMzlM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fg2GGtO9+a4f4fBT24jIMnP/awFUnBUlEse/K0j4SmTJHcuAKljyZ0o6Bkn3tH38qxjfzv4bXzTQd9uSfjeU0RiYIZsjW1enDsNPzaSrAW650aWBk4qfl8weOpygnn6uwlfq2sAwBASgCWQ+JUMJrBJzqjC5v753tQKsZeqOV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArKW+53H; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778679336; x=1810215336;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KjbblYiiEBif+Niwo4suUNP8LpP9G0670n6uJ0JMzlM=;
  b=ArKW+53H8D2Dwv9UhUPCH9BVO84kfgWPxCNFAvW9wHrKbvMx55Fmq0TB
   tq4oygNp0WIEMWItv9BTk0gCGVyqWoyVgBeK/PVuyebZwGmAALHZYxFDy
   bKXpZA1Imcg9zj/NBW/FufdUIeCGOHlQlilMFTH6fo0aDShm1oDvMlnnG
   x0PiyAOkYedqq8ez6jUaizjBFlUTiXsmYdkHzIBqnCln53p3FAanp6saf
   a2FDJfFoDrdJfXBOvftMC3CaZmAUdf0WI11VMiPmFWkASJ4RvKVAqzzQa
   YBF4VGIKejtMpJ+oZr04lp2nm8b3rIqWbbsQ5cc77csDgcUkBzIBbGFjY
   g==;
X-CSE-ConnectionGUID: oJZKGnCdQ+SUWDk7ZrIqbg==
X-CSE-MsgGUID: d3dvbuHzT0ynikND7tGCBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78633498"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="78633498"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 06:35:36 -0700
X-CSE-ConnectionGUID: d+83l/PiQWmwrmP25dMqBQ==
X-CSE-MsgGUID: ff2iNg6YQrC0b8/7a5zDPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233820935"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 06:35:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 May 2026 16:35:30 +0300 (EEST)
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: introduce
 guard(uart_port_lock_check_sysrq_irqsave)
In-Reply-To: <3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr>
Message-ID: <4c63e55e-6208-8955-c01a-8a1198a0f485@linux.intel.com>
References: <cover.1778592805.git.jnilo@free.fr> <cover.1778675349.git.jnilo@free.fr> <3849af4bc55d5d2a424fa850844e94d641b2f8a6.1778675349.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1209508298-1778679330=:12534"
X-Rspamd-Queue-Id: F1770534905
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[free.fr];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246866-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1209508298-1778679330=:12534
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 May 2026, Jacques Nilo wrote:

> uart_handle_break() and uart_prepare_sysrq_char() (in
> include/linux/serial_core.h) capture a SysRq character into
> port->sysrq_ch while the port lock is held and rely on the unlock
> helper -- uart_unlock_and_check_sysrq_irqrestore() -- to dispatch the
> captured character to handle_sysrq() on scope exit.
>=20
> The existing guard(uart_port_lock_irqsave) cannot be used by IRQ
> handlers that process RX, because its destructor calls plain
> uart_port_unlock_irqrestore() and silently drops port->sysrq_ch.
>=20
> Add a dedicated guard(uart_port_lock_check_sysrq_irqsave) variant
> whose destructor is the sysrq-aware unlock helper. The lock side is
> identical to uart_port_lock_irqsave -- only the unlock-time behaviour
> differs. Callers that may capture SysRq characters must use
> guard(uart_port_lock_check_sysrq_irqsave); the existing
> guard(uart_port_lock_irqsave) keeps its current plain-unlock semantics
> for the many callers that do not process RX.
>=20
> The new macro is placed after the CONFIG_MAGIC_SYSRQ_SERIAL block so
> both definitions of uart_unlock_and_check_sysrq_irqrestore() (sysrq
> enabled and disabled) are visible at expansion time. When
> CONFIG_MAGIC_SYSRQ_SERIAL=3Dn the destructor degenerates to plain
> uart_port_unlock_irqrestore(), so there is no overhead.
>=20
> No functional change on its own; users are converted in the following
> patches.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Jacques Nilo <jnilo@free.fr>
> ---
>  include/linux/serial_core.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 4f7bbdd90..d1404c97d 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -1286,6 +1286,18 @@ static inline void uart_unlock_and_check_sysrq_irq=
restore(struct uart_port *port
>  }
>  #endif=09/* CONFIG_MAGIC_SYSRQ_SERIAL */
> =20
> +/*
> + * Variant of guard(uart_port_lock_irqsave) for IRQ handlers that may ca=
pture
> + * a SysRq character via uart_prepare_sysrq_char(). The destructor uses =
the
> + * sysrq-aware unlock helper so that a captured port->sysrq_ch is dispat=
ched
> + * to handle_sysrq() on scope exit. The plain guard variant silently dro=
ps
> + * sysrq_ch and must not be used by callers that process RX.
> + */
> +DEFINE_LOCK_GUARD_1(uart_port_lock_check_sysrq_irqsave, struct uart_port=
,
> +                    uart_port_lock_irqsave(_T->lock, &_T->flags),
> +                    uart_unlock_and_check_sysrq_irqrestore(_T->lock, _T-=
>flags),
> +                    unsigned long flags);
> +
>  /*
>   * We do the SysRQ and SAK checking like this...
>   */
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1209508298-1778679330=:12534--

