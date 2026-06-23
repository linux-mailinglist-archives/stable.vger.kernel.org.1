Return-Path: <stable+bounces-268023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LNunKDrpOmpnLAgAu9opvQ
	(envelope-from <stable+bounces-268023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:14:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6486B9E5B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:14:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ArvqaJoP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268023-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268023-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A908930A1523
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C10396D2C;
	Tue, 23 Jun 2026 20:14:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40854396D15;
	Tue, 23 Jun 2026 20:14:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245671; cv=none; b=JhXN+Tpha+N2eRbQuabAFGDd6e4ZwJfVeNB3wLCqrGKJkrwD4Gc4YuXLnvYZrv0axVPKN2oXXv+zyYdKuRyfKnulOL+EWSYw/s58oNPUuGPMVlNCivhXgjcvMAXhYkRgH9YMQUnTAYXYVhKOKhE7/hWQl/iYj8acc0+5eK6Tekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245671; c=relaxed/simple;
	bh=zYh8pvS9OVG5q1Ex3cNeJ8XRMlAk4G46E113ar53eyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxEcP8q6RuKluKl0Iv2CerhRIWpNCQpBJqhIHXIZ/HhE6ymfm4oIIEgksEHXTACgbn5ujhPIPF5RGoLrK4y/05yXQna7Ar/Kn2d+Iawr05ZmMtTKmws+tOH7/jWvDBFjdeIXSKShggENSnvOlMKAw14WtYPt6qpWgbtqAUR83SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArvqaJoP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825BA1F000E9;
	Tue, 23 Jun 2026 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245670;
	bh=3RhUwooFwRxx3GisCh/vJn3sB9qCf4G8uwEEmtd3BLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ArvqaJoPikGqUfb+98b682XDPHtnWUlkdu41diEaQOLkpo3Q91ZWiXEcvyqj/6YRm
	 ZfQLVpX/G7T6H6EgrNJf9G7whb69yhUL1/kW+ym57bVialzun4QcPZVO4CcpE02viw
	 dIw1dhKHHEdVMGAykZmoPPyQbYjTeIxH6IEByXumw8Hw1ozK024smQhxVuJELVQln1
	 ZVLJnzAzaz7gXI4ZP5EwrW+iJgyYj1mSt/iKdcllnOMt7KvFNGJ/QoER5BOXXqQC0i
	 L8CMqzeAw8/l8Fd6jBHctH2lNykqaWLYg2HDVH3XsrGQzHmCqmTTUd7br7bx2ybFNE
	 vjebByopwu08Q==
Date: Tue, 23 Jun 2026 22:14:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Wolfram Sang <wsa@kernel.org>, Kaushal Butala <kaushalkernelmailinglist@gmail.com>, 
	Shawn Guo <shawn.guo@freescale.com>, Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <ajro79ZTzd9h-nZn@zenone.zhora.eu>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vjardin@free.fr,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:wsa@kernel.org,m:kaushalkernelmailinglist@gmail.com,m:shawn.guo@freescale.com,m:stefan.eichenberger@toradex.com,m:linux-i2c@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[free.fr];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268023-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,nxp.com,gmail.com,kernel.org,freescale.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zenone.zhora.eu:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D6486B9E5B

Hi Oleksij, Stefan,

any chance you ca review this?

Vincent, please, next time don't send v2 as a reply to v1.

Thanks,
Andi

On Mon, May 25, 2026 at 06:43:14PM +0200, Vincent Jardin wrote:
> i2c-imx rejects a SMBus Block Read byte count of 0 (valid per SMBus 3.1
> 6.5.7) and it returns without a NACK+STOP, leaving the target
> holding SDA so the bus is stuck until a power cycle occur.
> 
> The same bug is occuring with two independently introduced spots, so the
> fix is two patches with their respective Fixes: tags and backport ranges:
> 
>   1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
>   2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
> Changes in v2:
> - Handle when count > I2C_SMBUS_BLOCK_MAX the same way as count == 0
>   Reported by the Sashiko AI review on v1.
> 
> ---
> Vincent Jardin (2):
>       i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
>       i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)
> 
>  drivers/i2c/busses/i2c-imx.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> ---
> base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
> change-id: 20260525-for-upstream-i2c-lx2160-fix-v1-0cba0a0093e5
> 
> Best regards,
> -- 
> Vincent Jardin <vjardin@free.fr>
> 

