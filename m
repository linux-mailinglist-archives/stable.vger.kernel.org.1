Return-Path: <stable+bounces-255068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFTNGg12GGo8kQgAu9opvQ
	(envelope-from <stable+bounces-255068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:06:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50165F564F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31AF3173926
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A73F7AAB;
	Thu, 28 May 2026 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NiWaeNeO"
X-Original-To: stable@vger.kernel.org
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87842F7F13;
	Thu, 28 May 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987495; cv=none; b=Ddj4sz5pG/pN+QfS88qDKQRiSN/oCbNBFVBwyNGeLQ46aP6fb8VTD7mOFskuQlnfVaPNoHkawKauG4LIRHQTgLfnuPR4GfpcgrfulAmy0niKSHunMHMsCoWukTXZy8SZgDx44JzlfQ19XLdVBya3Gky/oYkhvOhe6ui8SR556y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987495; c=relaxed/simple;
	bh=HGhF+kojMfE7g0gOFDwKnzGzMAWGvIe6br7HUf3MlrQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkfYqXqeeYDv9bQ47anvaafXfXCDpiLv5yJpCvdkJOYuQfYqwjS6L3nz7FVm6A4l0fl2BqykJUwdjil5sKxRWKDnq3WWAVdZnf9pIT17SbcBZ48jKSqLlvHs5N6iLwZg9YActx6m7a1m93TPQbsFS5Em0sSFLI0DccKBht2lYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=NiWaeNeO; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779987491; x=1780246691;
	bh=6OEi+FnIhWHynquoSLlvkA7OUnOMCNowrBZGFJrLo6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NiWaeNeO9bzO9a7p4W94jGA2yCVQbDG30Cfnn2c77i6+kQSnc4HTfkFcQVrkdEIWB
	 LRnEqFmDpTq05L7mnVm7Et8FaHrJyYLTGNsvtDqsHe5QqCwXF1zdE5knJl/W8bGftb
	 O/LDQDse0yDa2YKVBnSTQJJND4A4GX9iFnaUa/O80MprxtqswI4/dbCrnh3eG6/fYJ
	 tnAT9YKm7xtSsTps2XFThDA8Dkicqrx+9ZPNIPEaM4S5yJwgCFwK4mfhKhCtBZH/Bn
	 Ny5/RQE7miJoqJ1kAa3Zy4SsbQejYRWPTCQFGB0zJs4ZQHn0kX1XGyp+4cZf38iKVl
	 +nOyobSo4ejQA==
Date: Thu, 28 May 2026 16:58:07 +0000
To: Hongling Zeng <zenghongling@kylinos.cn>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, lukeyang.dev@gmail.com, kees@kernel.org, linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH] gpib: ines: Fix resource leak in ines_isa_attach()
Message-ID: <-cCT0w4G6b4RGudKB8hHZa9lrJgL55Hts_W3CgLYbGZyeJ9mqBkzf6v1xlm17FLQ-gOCqTrsj2wZraYOZHxwgImyX_PI0Cdu1t4D90sMW1Y=@protonmail.com>
In-Reply-To: <20260528020317.14836-1-zenghongling@kylinos.cn>
References: <20260528020317.14836-1-zenghongling@kylinos.cn>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 08352b5e473068be3c5d94f88e512fc755b901b1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org,vger.kernel.org,126.com];
	TAGGED_FROM(0.00)[bounces-255068-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.karol.piatkowski@protonmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[protonmail.com]
X-Rspamd-Queue-Id: C50165F564F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hongling Zeng,

On Thursday, May 28th, 2026 at 04:03, Hongling Zeng <zenghongling@kylinos.c=
n> wrote:

> When request_irq() fails in ines_isa_attach(), the function returns -1
> without releasing the I/O port region that was successfully acquired
> earlier by request_region(). This causes a resource leak.
>=20
> Fix this by adding a proper error path that releases the I/O port
> region before returning.
>=20
> Fixes: 0de51244e7b7e3 ("gpib: ines: use request_region for isa devices")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpib/ines/ines_gpib.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.=
c
> index c000f647fbb5..1e5112d05dfc 100644
> --- a/drivers/gpib/ines/ines_gpib.c
> +++ b/drivers/gpib/ines/ines_gpib.c
> @@ -911,11 +911,16 @@ static int ines_isa_attach(struct gpib_board *board=
, const struct gpib_board_con
>  =09nec7210_board_reset(nec_priv, board);
>  =09if (request_irq(config->ibirq, ines_pci_interrupt, isr_flags, DRV_NAM=
E, board)) {
>  =09=09dev_err(board->gpib_dev, "failed to allocate IRQ %d\n", config->ib=
irq);
> -=09=09return -1;
> +=09=09retval =3D -ENODEV;
> +=09=09goto err_release_region;
>  =09}
>  =09ines_priv->irq =3D config->ibirq;
>  =09ines_online(ines_priv, board, 1);
>  =09return 0;
> +
> +err_release_region:
> +=09release_region(config->ibbase, ines_isa_iosize);
> +=09return retval;

I see a similar problem to what I've found in fmh_gpib patch:
https://lore.kernel.org/all/LpJShJPaUZ8iZoWRA7Sy9TPz_7ZPHNvoU0lHOBrVEXvQGql=
z493ShbF6ZKQ2zcRqPHVuxOkjzR0KCdS6OngnflPYa0gsqaRTpRWFbxuqQ4A=3D@protonmail.=
com/

Thanks,
Dominik Karol

>  }
>=20
>  static void ines_pci_detach(struct gpib_board *board)
> --
> 2.25.1
>=20
> 

