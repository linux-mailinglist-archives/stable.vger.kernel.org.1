Return-Path: <stable+bounces-260627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ewnHBQ5aImpjVQEAu9opvQ
	(envelope-from <stable+bounces-260627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 07:09:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF776451C5
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 07:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=uAEdUkc6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260627-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260627-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C152F302335A
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2730595B;
	Fri,  5 Jun 2026 05:05:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C0168BD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 05:05:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635913; cv=none; b=EF24xK+0mxjL3JeNeZ89a+fc1wWwde6/BhR/HAiwiQ1F8RP3wF2YZ7ekhGq7g26eL5LdNRI5hL9fWpCJm4uTby8xGqgtA14DuePYPr7brELyeQ+P97WRG2koyoPCoSt+XZP2pSTESOlHYwQVuILqqckUl9CKAANHpGEjm50W/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635913; c=relaxed/simple;
	bh=0cAx5OVVaxm1B19LB6mVCJYySN/Wqh42M5HoVh9JnH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gv+8BTOcTuqJ/+lHoTE7H7na0ciMLg9tXVuzyRpGWIoeOoVQRaCluwt7d4eHEcygKGLQBie7qJg0OO9wBnSEDfrWM7KxUWpaN2vioPkqDBQGbQzcOHDyudr+QJ7MA1+gQSGFnnZt7mraAsQxQorTlZJp9bFgYkZZDKX+ZMPrRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uAEdUkc6; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 02C5A4E40760;
	Fri,  5 Jun 2026 05:05:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEBFB5FED1;
	Fri,  5 Jun 2026 05:05:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E780C106A1EA5;
	Fri,  5 Jun 2026 07:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780635908; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0cAx5OVVaxm1B19LB6mVCJYySN/Wqh42M5HoVh9JnH0=;
	b=uAEdUkc6KzLPxYbcAKBkInHdL3ovpa9JXFbH+bFZ0m9t9/ZNyytqF6LJku/QRMI9CwyBpa
	RHQKLHWKVVIdaNok9fvRwX2SnxgnCtPN8jkTrduOPsRxv5TUX+slN6eh+Yv2jwp1MUts+L
	ocjKqNdc/w9La4731yIn1YdVfT0Qw65y4UmQrgMuBniIgo6DL2XB2OQCVsPUfafPnVwJi8
	ZZfnCqG4wSV8OUeyLGDJTZc0PNOHZjff7KZr+3ZEHKA68nlDVtE/0/mhz8YKEiqKvII2+5
	ouNmjTMMNVStINsts8VrVjI6xv3TxV5GG8rJnnKEmJopNvoa3Mz6HBwBYH/liQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  alvinzhou@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: Restore fallback
 parameters for MX25L12805D
In-Reply-To: <20260605005720.1857413-3-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Fri, 5 Jun 2026 08:57:20 +0800")
References: <20260605005720.1857413-1-linchengming884@gmail.com>
	<20260605005720.1857413-3-linchengming884@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 05 Jun 2026 07:05:04 +0200
Message-ID: <87pl25wpa7.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260627-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linchengming884@gmail.com,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:alvinzhou@mxic.com.tw,m:chengminglin@mxic.com.tw,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FF776451C5

Hello,

> In a previous effort to drop flash_info fields and rely on SFDP, the
> static size and no_sfdp_flags were removed from the MX25L12805D entry
> (JEDEC ID 0xc22018).
>
> At that time, the legacy MX25L12805D was already EOL and unavailable
> for physical testing. Verification was inadvertently performed using
> the newer MX25L12833F, which shares the same JEDEC ID but supports
> SFDP. As a result, the probe succeeded during testing, leading to
> the mistaken removal of the fallback parameters.
>
> Since the actual MX25L12805D lacks SFDP support entirely, it strictly
> requires these static parameters.
>
> Restore .size =3D SZ_16M and .no_sfdp_flags =3D SECT_4K to this entry
> to fix the probe failure for the legacy part.
>
> Fixes: 947c86e481a0 ("mtd: spi-nor: macronix: Drop the redundant flash in=
fo fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

