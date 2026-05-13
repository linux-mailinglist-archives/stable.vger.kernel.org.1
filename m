Return-Path: <stable+bounces-246825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B/SK35lBGq6HgIAu9opvQ
	(envelope-from <stable+bounces-246825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:50:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B0532888
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 123D13040B4E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BD3FE651;
	Wed, 13 May 2026 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAcC9CKe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB63A63FE;
	Wed, 13 May 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673017; cv=none; b=nBjshM+aqmi5rvDFgPb9E7NGxyawXg3vPa8llvBawX+fXeLAV/UiMcb0X65v6gJ7K7gLwwAEpjjfe8hECcQqL1S+n4QuQIUpA/CUZ6b29xAl2vsYaFXpCioHrPqNaDt8GgNXWziTkA88Qlr94xeqMxeEkNSLBGUTDWg8Cbhyf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673017; c=relaxed/simple;
	bh=Nd501hgChR/UL/dVI5/rbdNXtUQk8uLIpkOH1WQ6lZk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NJ8W0cvZfvPTyEDDc80HvYtyV5o0RgxyajePEF/rkFwqfF8EQCmbGefzgGjDwlMGfCa6+NMcHBcMfxuFk413VVDOzK6RCgn4ZEFwwywNZBKvNVgGREY6GS1RPDaJ6hhc40wY4xe9BUCGMT0Kd4Kq0shTFJvnnW5CFUjMPgwrN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAcC9CKe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778673016; x=1810209016;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nd501hgChR/UL/dVI5/rbdNXtUQk8uLIpkOH1WQ6lZk=;
  b=jAcC9CKeFu+JXWqu1pPwn8YhJcU89pjCDH4wFyZekS2FmQTGcMuVN3k/
   150rpeJRWhP2OkficfpCrVzAVWg7Z4LoYkqWbgpzSahlISfQw1AFXCBAj
   0tAtfgMfN4zaAOczLX/jkPkjBa55ug8xK7dBN5YLfBUnT6Hz/eEa0SsGH
   z4T+IZ3+z80Eu5tzoGhDARjn93nWYXa9VPX8IQnJPjwmlYiC4W0R4IE5/
   6CO6eMoVqeHYGI93pZfg0zKWCsowUC6Ul18cCIMcQgXIAGUurbOOQ7dR6
   I/WKzb0SVAx1gic2iJxa4S7AmE7ClQZQIh4dlCXAY6qA4pEF+aViTLo/f
   g==;
X-CSE-ConnectionGUID: I9Mn4HPySK2HUwQ2chBoiA==
X-CSE-MsgGUID: 2YR3+KgjSjCrOuO1wQ7HXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79455098"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79455098"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:50:15 -0700
X-CSE-ConnectionGUID: cMQg6anwRT6AKE4cDK3h2g==
X-CSE-MsgGUID: kgrbea+hSo2Nzp4TUIDClA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="242078997"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:50:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 May 2026 14:50:10 +0300 (EEST)
To: Jacques Nilo <jnilo@free.fr>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 3/3] serial: 8250_dw: dispatch SysRq character in
 dw8250_handle_irq()
In-Reply-To: <340a4a76e5dbeb2e49ad4b8d41b9631e09e94bec.1778592805.git.jnilo@free.fr>
Message-ID: <fa464674-82cd-35e7-9317-92475694e291@linux.intel.com>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr> <cover.1778592805.git.jnilo@free.fr> <340a4a76e5dbeb2e49ad4b8d41b9631e09e94bec.1778592805.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1139180977-1778673010=:12534"
X-Rspamd-Queue-Id: D22B0532888
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[free.fr];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246825-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1139180977-1778673010=:12534
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 May 2026, Jacques Nilo wrote:

> dw8250_handle_irq() calls serial8250_handle_irq_locked() with the port
> lock held via guard(uart_port_lock_irqsave). The guard destructor is
> plain uart_port_unlock_irqrestore(), so a SysRq character captured into
> port->sysrq_ch by uart_prepare_sysrq_char() is dropped without ever
> being dispatched to handle_sysrq().
>=20
> This is the same regression pattern as in serial8250_handle_irq(),
> introduced when 883c5a2bc934 ("serial: 8250_dw: Rework
> dw8250_handle_irq() locking and IIR handling") moved the function to
> the guard()-based locking scheme without using the sysrq-aware unlock
> helper.
>=20
> Switch to guard(uart_port_lock_sysrq_irqsave) so that captured
> sysrq_ch is dispatched on scope exit, matching the fix in
> serial8250_handle_irq().
>=20
> Fixes: 883c5a2bc934 ("serial: 8250_dw: Rework dw8250_handle_irq() locking=
 and IIR handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jacques Nilo <jnilo@free.fr>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 55e40c10f..237543fa7 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -416,7 +416,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>  =09unsigned int quirks =3D d->pdata->quirks;
>  =09unsigned int status;
> =20
> -=09guard(uart_port_lock_irqsave)(p);
> +=09guard(uart_port_lock_sysrq_irqsave)(p);
> =20
>  =09switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
>  =09case UART_IIR_NO_INT:
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1139180977-1778673010=:12534--

