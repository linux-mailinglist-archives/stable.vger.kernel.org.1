Return-Path: <stable+bounces-255076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI0xNd6AGGpPkggAu9opvQ
	(envelope-from <stable+bounces-255076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:52:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6385F5EB8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6536C3016EF4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34563F9F52;
	Thu, 28 May 2026 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="B86+aeOV"
X-Original-To: stable@vger.kernel.org
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C43F0745;
	Thu, 28 May 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990638; cv=none; b=h3tCLykgzyW0k949iA13b4UTSzqoVuoynz46ryEhVPNjI8V/8Y8gwQyN2F/XUXTfjYU2J4JJz7xauTlDC4gIWlediHuqNSvCo32wUu7Iq2YJk9Ln2h4nJskMm9HDNcLDeN+4S4MbvulWiZwcAXVo3icNdk1XZONIByysIPWmjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990638; c=relaxed/simple;
	bh=b+bd4N7yVPm4/B36iT03Y7ghrup/4+PkJlwvarBCRGs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiCjKDPh9xODpMTHUb18K673uFaXOVUEE2ZG/6J6mfjG6RbSJ9loGgy724bIFpGcsg+jL3bnsQ6VR6QdoziFe4c+stG9Sbn47KkPgGyLzAo7ekUv9Rfxjd2k7ftSEQ+u7v2690feBI2JCP6bkqhTfG1HqqR8if3tgnIFevBR12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=B86+aeOV; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779990635; x=1780249835;
	bh=dLRA60UFJbuxNSp4QElVT59rSh9zsb/9Ln8whgJ1gEU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B86+aeOVaAyE0VTSAbXJQvua2eZJb0n2I15Bvw/7SbX037Sk3kLy9qGxc5vEdNLDD
	 ZrYRxL0U20wRW9aakXosD5JorBfehDNBN1pK/YbkGgi6XZKee4MGQ+I+i3Ly1726L7
	 ta8lijquxmqtY+7EPUvLGyePPl1FkHcG2QOuh1bd2OEVK1Qe1skSSU8/6koj64J3N2
	 W8fbRKHpIzzGEED5Woe6j0g+0oHoVZQ7UToxiIWtQh53K0mH0vgI5j4Zbyp0lhppIm
	 DlYe6Yy8wJFiF6WY5ATm3EgDFn16spSnbK8dsX+0GJyeE3UKB8Qoz5b5FE/ISbIqi2
	 fCX+elbd5RFdA==
Date: Thu, 28 May 2026 17:50:26 +0000
To: Hongling Zeng <zenghongling@kylinos.cn>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, adam.quandour@gmail.com, kees@kernel.org, linux-kernel@vger.kernel.org, zhongling0719@126.com, kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpib: cb7210: Fix region leak when request_irq fails
Message-ID: <NGjFgMaS4_1GFAjYxGd1DK-NXXgF5MZcVmrPqC8R-7515xBQ1B0ukPH3tJG0w-3MIsnhtqPZvt1re9ym8YpmR5pkUs2LzHrXIejmEm3bsLs=@protonmail.com>
In-Reply-To: <20260518022939.16881-1-zenghongling@kylinos.cn>
References: <20260518022939.16881-1-zenghongling@kylinos.cn>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: bb00bfc8e822191ba8c335a60a1cb5f9b8ad945c
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255076-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org,vger.kernel.org,126.com,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.karol.piatkowski@protonmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[protonmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,protonmail.com:mid,protonmail.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 3A6385F5EB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch is already in linux-next, but I see a problem similar to what I'=
ve
found here:

https://lore.kernel.org/all/LpJShJPaUZ8iZoWRA7Sy9TPz_7ZPHNvoU0lHOBrVEXvQGql=
z493ShbF6ZKQ2zcRqPHVuxOkjzR0KCdS6OngnflPYa0gsqaRTpRWFbxuqQ4A=3D@protonmail.=
com/

Additionally, we're releasing the region we never obtained.
I believe this patch should be reverted.

Thanks,
Dominik Karol

On Monday, May 18th, 2026 at 04:29, Hongling Zeng <zenghongling@kylinos.cn>=
 wrote:

> When request_irq() fails, the region allocated by request_region()
> is not released. Fix this by adding an error handling path with
> proper goto labels to release the region.
>=20
> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605160620.ReBOadPX-lkp@i=
ntel.com/
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Cc: stable@vger.kernel.org
>=20
> ---
>  Changes in v2:
>    - Fix variable name typo: use 'retval' instead of 'ret' (reported by t=
est robot)
> ---
>  drivers/gpib/cb7210/cb7210.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpib/cb7210/cb7210.c b/drivers/gpib/cb7210/cb7210.c
> index 6dd8637c5964..673b5bfe2e7d 100644
> --- a/drivers/gpib/cb7210/cb7210.c
> +++ b/drivers/gpib/cb7210/cb7210.c
> @@ -1049,7 +1049,8 @@ static int cb_isa_attach(struct gpib_board *board, =
const struct gpib_board_confi
>  =09if (!request_region(config->ibbase, cb7210_iosize, DRV_NAME)) {
>  =09=09dev_err(board->gpib_dev, "ioports starting at 0x%x are already in =
use\n",
>  =09=09=09config->ibbase);
> -=09=09return -EBUSY;
> +=09=09retval =3D -EBUSY;
> +=09=09goto err_release_region;
>  =09}
>  =09nec_priv->iobase =3D config->ibbase;
>  =09cb_priv->fifo_iobase =3D nec7210_iobase(cb_priv);
> @@ -1062,11 +1063,16 @@ static int cb_isa_attach(struct gpib_board *board=
, const struct gpib_board_confi
>  =09// install interrupt handler
>  =09if (request_irq(config->ibirq, cb7210_interrupt, isr_flags, DRV_NAME,=
 board)) {
>  =09=09dev_err(board->gpib_dev, "failed to obtain IRQ %d\n", config->ibir=
q);
> -=09=09return -EBUSY;
> +=09=09retval =3D -EBUSY;
> +=09=09goto err_release_region;
>  =09}
>  =09cb_priv->irq =3D config->ibirq;
>=20
>  =09return cb7210_init(cb_priv, board);
> +
> +err_release_region:
> +=09release_region(nec7210_iobase(cb_priv), cb7210_iosize);
> +=09return retval;
>  }
>=20
>  static void cb_isa_detach(struct gpib_board *board)
> --
> 2.25.1
>=20
> 

