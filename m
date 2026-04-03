Return-Path: <stable+bounces-233170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGgaJ/6Wz2nmxQYAu9opvQ
	(envelope-from <stable+bounces-233170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:31:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C43934E6
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFD5D303B5C1
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BD3AB29E;
	Fri,  3 Apr 2026 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="hGMLgp8B"
X-Original-To: stable@vger.kernel.org
Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEF30EF89;
	Fri,  3 Apr 2026 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212278; cv=none; b=da2upFglmMN/4t1N09E/DHwHog2GbjkW1vPqvNpJzjkddtOhsp+UvZ1SYngrCNUIXJWUJPevx+RiI01pzDnh6P3AbhrXs6aj1NDhubUKM1lJgWmF95Q32qCPatEnGqdyxY8dhxlZpFhJap/7mAWN5R1oAztaCieYkPsGJpHdr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212278; c=relaxed/simple;
	bh=T9DtQyBdudPL8w5KatbzuIV0wdsUMDdApNtbaTIiwpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uz2nRJt9npkDE0zecWIQZrOaha4NuBJWxj7VvavvYk06HLj6P/cObbUCkr7MCZQYe7/Ues+DllPrk/MkpMjWPwWpQZUP5eKEHm/R8n+ArJ/Hz/HJC4KB/RQFZYiRDVXOcpb2nZNtVVV8q+ZNcoBj4Ej7QeHRU3XfwCNykmPdazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=hGMLgp8B; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1775211896; bh=T9DtQyBdudPL8w5KatbzuIV0wdsUMDdApNtbaTIiwpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hGMLgp8BlAIAGv44N3LzBgwdD8t6UZlqQZRdXYLwbDO0rt1XebCFTOvN2OFkeofJG
	 nR3AALOPYXmXb05DWLoQpzMZxOgO+f2FBeNPwbP65vDYxqzgeMbl5uySY3sLyxrbRK
	 JwtopdMwdbcOhqY/B1qIGV57QY9cX3zEftxUE+aJS+gLrLhVdzXGBHnzanAbBJjFdS
	 iskxlMkIyHhvHYn4cBZ/QeSVKOjkZcZU23qNnmwbW+MMkSZhaPGnL4/QDXbO7QXG5M
	 fFv/JGTOOOpFoxo1TyE8xLBK7RoBdvs0SiJBQY0EfnwaAJQDmR94cdrZNyyZmgYWC4
	 Rg/oxJVx5UHIQ==
Received: from pliszka.localnet (79.184.49.207.ipv4.supernova.orange.pl [79.184.49.207])
	by ms.puri.sm (Postfix) with ESMTPSA id 10FCC1F6CB;
	Fri, 03 Apr 2026 03:24:56 -0700 (PDT)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sven@kernel.org,
 Vincent Cloutier <vincent@cloutier.co>, stable@vger.kernel.org
Subject:
 Re: [PATCH v1 1/1] usb: typec: tipd: Restore generic TPS6598x contract
 interrupts
Date: Fri, 03 Apr 2026 12:24:54 +0200
Message-ID: <2374707.tdWV9SEqCh@pliszka>
In-Reply-To: <20260402000950.715470-1-vincent.cloutier@icloud.com>
References: <20260402000950.715470-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[puri.sm,reject];
	R_DKIM_ALLOW(-0.20)[puri.sm:s=smtp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233170-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[puri.sm:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.krzyszkowiak@puri.sm,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,puri.sm:dkim]
X-Rspamd-Queue-Id: BA4C43934E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On czwartek, 2 kwietnia 2026 02:09:50 czas =C5=9Brodkowoeuropejski letni Vi=
ncent=20
Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
>=20
> The generic TPS6598x interrupt handler still relies on
> PP_SWITCH_CHANGED, NEW_CONTRACT_AS_CONSUMER, HARD_RESET, and
> STATUS_UPDATE, but the irq_mask1 refactor only kept
> POWER_STATUS_UPDATE, DATA_STATUS_UPDATE, and PLUG_EVENT in
> tps6598x_data.
>=20
> On the librem5 that leaves PD partners stuck at the 500 mA fallback
> because the active contract is never refreshed after attach.
>=20
> Restore the missing interrupt bits so the existing handler paths are
> reachable again. This fixes USB-C charging negotiation on the librem5:
> after a replug the TPS6598x source power supply reports 3 A instead of
> 500 mA and the BQ25890 input limit follows suit.
>=20
> Fixes: b3dddff502c5 ("usb: typec: tipd: Move initial irq mask to tipd_dat=
a")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
> ---
>  drivers/usb/typec/tipd/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 84ee5687bb27..83f2fec6e34e 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -2395,7 +2395,11 @@ static const struct tipd_data tps6598x_data =3D {
>  	.irq_handler =3D tps6598x_interrupt,
>  	.irq_mask1 =3D TPS_REG_INT_POWER_STATUS_UPDATE |
>  		     TPS_REG_INT_DATA_STATUS_UPDATE |
> -		     TPS_REG_INT_PLUG_EVENT,
> +		     TPS_REG_INT_PLUG_EVENT |
> +		     TPS_REG_INT_PP_SWITCH_CHANGED |
> +		     TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER |
> +		     TPS_REG_INT_HARD_RESET |
> +		     TPS_REG_INT_STATUS_UPDATE,
>  	.tps_struct_size =3D sizeof(struct tps6598x),
>  	.register_port =3D tps6598x_register_port,
>  	.unregister_port =3D tps6598x_unregister_port,

This driver has never handled these interrupts (as seen in the commit you=20
referenced), so these should be added in patches that make it handle them.

You likely got confused by the patches that still stay in the downstream=20
Librem 5 tree. We should get them cleaned up and mainlined, but until that=
=20
happens this patch doesn't make much sense here I'm afraid.

S.



