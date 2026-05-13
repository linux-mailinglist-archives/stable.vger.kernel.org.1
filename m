Return-Path: <stable+bounces-246823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPPrH7JlBGpVIAIAu9opvQ
	(envelope-from <stable+bounces-246823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:51:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9185328BF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81A78300D92D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B339AD32;
	Wed, 13 May 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSICViyB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7137F72F;
	Wed, 13 May 2026 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673001; cv=none; b=K5C3zZuIKrVCXUlLglm4xjeV8/nLkvZcC43de7BBa2o6q6nUgx2KBNEkidSJx8LfZUknKhCZ3jFgsz6IWV8eNuwJFELAgdA+MnwZMj1aS0brJydAAc7cxcosqoyBZrzTldzTiiZKQ+0y3IZDjlzj00XHjCfV1tIt1R11186CMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673001; c=relaxed/simple;
	bh=y7YTdDNOgPWmZ8e7kGA0uKrl3g7cfC6t3Ce8lQyE80k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OXDXxp/xf8xNsW0S7Vf5/yiPaEytyHNOA0iS6Kh8bmENLogXaRVU/lPtn2/Pooi6zdLlY2ObuHdoTd+H+AUw/YMQOmMBLWXSt1vlu3tY11nkXQD86wVo460/34ZWKPyEcm3Gdlk4oJ5wmvT9dxLP4RFZbuRR+3b0zd6/424zV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSICViyB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778672999; x=1810208999;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y7YTdDNOgPWmZ8e7kGA0uKrl3g7cfC6t3Ce8lQyE80k=;
  b=MSICViyBLc8eAcgyttKS3k2sKhd1kVrkCj87ULHH/SHAo6Cc7kZOicmY
   ttQpa9f9UV/m+bRGxJ5aFmM6ZVNmjjFiNWDaqrndWiifJR/sE0VGo213X
   +9ViPtpP9hug5jym7PngLIbTt1yfJO2a8dhjywK2nBNig5Hf+3auoL9pZ
   hMBPxtzauuSOw/y60VvJbn9sC4MDFxEhFdKr2EdsLyQrLmfeDiqlYcWKr
   rblwwVu+oRCQwbU7PjWrultjR7X4NpA49WsabLUALX+q3jQMeHlNcZBtr
   VldeJw1m5/7ZPQ/MX2kcJm8X9mKUYCIPuSj6mYE4hbiZJRGluSX0+hNYp
   Q==;
X-CSE-ConnectionGUID: JAPATyl/Tj+JmtTKOQCC7Q==
X-CSE-MsgGUID: acMWjL0NQwaJZwXz/NHVbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79455059"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79455059"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:49:58 -0700
X-CSE-ConnectionGUID: EipZDLHcQM2FXOkV95eq+g==
X-CSE-MsgGUID: GVCCyDd1Sze8aaDyfYZH+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="242078877"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:49:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 May 2026 14:49:53 +0300 (EEST)
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: 8250: dispatch SysRq character in
 serial8250_handle_irq()
In-Reply-To: <5d6d693aa9e92f05412d0f9395872d41e1b8e444.1778592805.git.jnilo@free.fr>
Message-ID: <8e222497-313e-6322-609b-547a3c87c165@linux.intel.com>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr> <cover.1778592805.git.jnilo@free.fr> <5d6d693aa9e92f05412d0f9395872d41e1b8e444.1778592805.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1798024874-1778672993=:12534"
X-Rspamd-Queue-Id: EA9185328BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[free.fr];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246823-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1798024874-1778672993=:12534
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 May 2026, Jacques Nilo wrote:

> serial8250_handle_irq() captures a SysRq character into port->sysrq_ch
> inside serial8250_handle_irq_locked() via uart_prepare_sysrq_char()
> (reached from serial8250_read_char()). Dispatch of that captured
> character to handle_sysrq() is expected to happen at port-unlock time,
> through uart_unlock_and_check_sysrq[_irqrestore]().
>=20
> After commit 8324a54f604d ("serial: 8250: Add
> serial8250_handle_irq_locked()") the function was reduced to a wrapper
> that takes the port lock via guard(uart_port_lock_irqsave) whose
> destructor is plain uart_port_unlock_irqrestore(). The sysrq-aware
> unlock helper is no longer called, so port->sysrq_ch is captured but
> never dispatched: BREAK + SysRq key is consumed silently.
>=20
> This was the very condition Johan Hovold's 853a9ae29e978 ("serial:
> 8250: fix handle_irq locking", 2021) introduced
> uart_unlock_and_check_sysrq_irqrestore() to address.
>=20
> Switch to the new guard(uart_port_lock_sysrq_irqsave), whose destructor
> is the sysrq-aware unlock helper, restoring the pre-split behaviour.
> Update the Context: comment on serial8250_handle_irq_locked() so future
> HW-specific 8250 wrappers know to use the same guard or the explicit
> sysrq-aware unlock.
>=20
> Verified on RTL8196E with CONFIG_MAGIC_SYSRQ_SERIAL=3Dy: BREAK + 'h' on
> the console UART produces the SysRq help dump in dmesg and the brk
> counter in /proc/tty/driver/serial increments correctly.
>=20
> Fixes: 8324a54f604d ("serial: 8250: Add serial8250_handle_irq_locked()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jacques Nilo <jnilo@free.fr>
> ---
>  drivers/tty/serial/8250/8250_port.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index e4e6a53eb..64f3487e8 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1786,7 +1786,10 @@ static bool handle_rx_dma(struct uart_8250_port *u=
p, unsigned int iir)
>  }
> =20
>  /*
> - * Context: port's lock must be held by the caller.
> + * Context: port's lock must be held by the caller. The caller must
> + * release it via guard(uart_port_lock_sysrq_irqsave) or
> + * uart_unlock_and_check_sysrq_irqrestore(), which captures SysRq
> + * character on unlock.
>   */
>  void serial8250_handle_irq_locked(struct uart_port *port, unsigned int i=
ir)
>  {
> @@ -1839,7 +1842,7 @@ int serial8250_handle_irq(struct uart_port *port, u=
nsigned int iir)
>  =09if (iir & UART_IIR_NO_INT)
>  =09=09return 0;
> =20
> -=09guard(uart_port_lock_irqsave)(port);
> +=09guard(uart_port_lock_sysrq_irqsave)(port);
>  =09serial8250_handle_irq_locked(port, iir);
> =20
>  =09return 1;
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1798024874-1778672993=:12534--

