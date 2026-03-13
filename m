Return-Path: <stable+bounces-225291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO5eNg7zs2nYdgAAu9opvQ
	(envelope-from <stable+bounces-225291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:20:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB2282238
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4C0C3092470
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED06A3890E7;
	Fri, 13 Mar 2026 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="TRWq8/7a"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957203859E1;
	Fri, 13 Mar 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400637; cv=none; b=DhwNsSgHzGaOq+n2f7wCkJ/AOht+5M6jyjRW744mhneIqCHVJe3Kw8sDcvDkarcCKwsx0rQew1j80t4ouTpHol3pUDo3VCLPJ5+t1kGhIA74Bp9719971GlIjCuIqkH7b0xnSg3R5Pm0MRmKcx4fE79Kve9pDBt8tmYr4uTAI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400637; c=relaxed/simple;
	bh=YdSRc6yZDArzXE18aTywSwAcu/U+YIzDF7q03Jyff2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrEYCyPft2tJise17RK2Tto50n9AwcSSXGS7NnC9kjYFgaIrLXt3IeNvQCB8v4h+gBx8SXcIlZwU7tktEdfATLEcu/vtn9iwvDYraTq1B+O6ZdngJcHvDIA/mz0AkWWkZJ8luh42b5uOlVmoaXFoep+xJTM2ksUNKdit+Gpd+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=TRWq8/7a; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773400629; x=1774005429; i=ps.report@gmx.net;
	bh=ypV3vYw83EYJ0vt2X0bGq6QL8N0WSnHy74z4DwwmweM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TRWq8/7a9Y+sn6VMldsYL5kdGTBtr/+dGNOiNLDRtcf+3ZyxdeUEFfCfcMNaq/rC
	 HTYr1jXT6ThGq98UGBSD9Tk0uWT1eF7UGhie/psxpKbHSSspCysDmMlBBpd6kFeeG
	 CJ+eOeKr0hOo3RX6fr7I7XKjx1hvUoX+mrVBX5iENw/1xmoe5D4KHls7XfZIPF9mJ
	 t2PgstXESJeCQTmG76n5OeY/HlIqQWDKq3ABYT39dq6WAzbviyHp2XsZLXtaUt1xG
	 6tz9LxT7FMHfaI3rtUOhjTmpzJzFaKcF1k7e4RJJrNbZwH42HtrD7fjcUTB1ZBHDm
	 6ckNhVFHX/71HU9xdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1vsj2Y3k2A-00ACVj; Fri, 13
 Mar 2026 12:17:08 +0100
Date: Fri, 13 Mar 2026 12:17:08 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Marc Buerg <buermarc@googlemail.com>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org, Elias Oezcan <elias.rw2@gmail.com>
Subject: Re: [PATCH] sysctl: fix uninitialized variable in
 proc_do_large_bitmap
Message-ID: <20260313121708.137dae22@pc-1>
In-Reply-To: <20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com>
References: <20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1txXnPKaIsmimdGxNhIbTHleLzY3rP1lt65i4KdVr5oPUsQ97S0
 IPhnvHsvjE6klItIRtdteSK+WIYUc3ggcHL66RSkg6ve6Y58hrZfkOurynJhAX+lx2p39Dr
 Bp1TBn5Kxqob0eif6B8jZ8kfNxDd/YchskNCMuFNNWExRaMEfPO9mLnlGApxva9G0lI7Exc
 Q4L9R/4Gk9KYec62c52Xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ytOGWQYTBVQ=;BoLVGF8mUE6Rx4Drf/3WX4JXTiC
 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
 +CJnMYvHPLbKTNETT15y66U09fCBHNLkw==
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225291-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ps.report@gmx.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SURBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:query timed out]
X-Rspamd-Queue-Id: 7DCB2282238
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Marc,

On Thu, 12 Mar 2026 16:42:19 +0100, Marc Buerg <buermarc@googlemail.com> w=
rote:

> proc_do_large_bitmap() does not initialize variable c, which is expected
> to be set to a trailing character by proc_get_long().
>=20
> However, proc_get_long() only sets c when the input buffer contains a
> trailing character after the parsed value.
>=20
> If c is not initialized it may happen to contain a '-'. If this is the
> case proc_do_large_bitmap() expects to be able to parse a second part of
> the input buffer. If there is no second part an unjustified -EINVAL will
> be returned.
>=20
> Initialize c to 0 to prevent returning -EINVAL on valid input.
>=20
> ---
> When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
> possible to receive an -EINVAL for a valid value.
>=20
> This happens due to an uninitialized variable in the
> proc_do_large_bitmap() function, namely char c. To trigger this behavior
> the variable has to contain the later explicitly checked '-' char by
> chance.
>=20
> In proc_do_large_bitmap() it is expected that the variable might be
> filled by the proc_get_long() function with the trailing character of
> the given input. But only if a trailing character exists within the
> passed size of the buffer.
>=20
> The proc_get_long() function can set c if the length of the parsed long
> is smaller than the given size of the buffer containing the user input.
> This is not the case if the buffer only contains the port value (e.g.
> "123") and sets the size exactly to that (3). Meaning if there is no
> trailing character, c will not be set.
>=20
> If no trailing character is present we still do a c =3D=3D '-' check. If=
 the
> uninitialized variable contains this char the function continues
> parsing. It will now set err to -EINVAL in the next proc_get_long()
> call, as there is nothing more to parse.
>=20
> Initializing c to 0 will solve the problem.
>=20
> The problem will only arise sporadically, as the variable must contain
> '-' by chance. On the affected system CONFIG_INIT_STACK_NONE=3Dy was
> enabled. Further, when enabling eBPF tracing to dump contents of the
> stack the issue disappears, which would fit the current explanation as a
> root cause for the observed behavior.
>=20
> Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
> Signed-off-by: Marc Buerg <buermarc@googlemail.com>
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 9d3a666ffde1..c9efb17cc255 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1118,7 +1118,7 @@ int proc_do_large_bitmap(const struct ctl_table *t=
able, int dir,
>  	unsigned long bitmap_len =3D table->maxlen;
>  	unsigned long *bitmap =3D *(unsigned long **) table->data;
>  	unsigned long *tmp_bitmap =3D NULL;
> -	char tr_a[] =3D { '-', ',', '\n' }, tr_b[] =3D { ',', '\n', 0 }, c;
> +	char tr_a[] =3D { '-', ',', '\n' }, tr_b[] =3D { ',', '\n', 0 }, c =3D=
 0;
> =20
>  	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(d=
ir))) {
>  		*lenp =3D 0;
>=20

Given the description of proc_get_long() regarding @tr:

   * @tr: pointer to store the trailer character
   *
   * In case of success %0 is returned and @buf and @size are updated with
   * the amount of bytes read. If @tr is non-NULL and a trailing
   * character exists (size is non-zero after returning from this
   * function), @tr is updated with the trailing character.

Would the better fix be:

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 354a2d294f52..89db88552987 100644
=2D-- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1427,7 +1427,7 @@ int proc_do_large_bitmap(struct ctl_table *table, in=
t write,
 				left--;
 			}
=20
-			if (c =3D=3D '-') {
+			if (left && c =3D=3D '-') {
 				err =3D proc_get_long(&p, &left, &val_b,
 						     &neg, tr_b, sizeof(tr_b),
 						     &c);

Regards,
Peter

> ---
> base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
> change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-3=
0c6ef4ac1c5
>=20
> Best regards,


