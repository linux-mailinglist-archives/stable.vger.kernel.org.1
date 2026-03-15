Return-Path: <stable+bounces-225472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H7/G7LBtmkWHwEAu9opvQ
	(envelope-from <stable+bounces-225472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:26:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885C291050
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB6B301487E
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48381366545;
	Sun, 15 Mar 2026 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="czX7u1YK"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFA366050;
	Sun, 15 Mar 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584801; cv=none; b=XcuhAEKFxaMlbBsI+u4k4K90mXN+omWUQ72JIKAN0mSCWvSlInR0b4YyAEGyyfYcieCuuCRinjGN3XZ8ieqZtA+Y8QYLz08cVY6hYlpKixrjeMGwDfx7UduGRo/zVYyJxEosktSsj9Qa0aSvEtd/DSr6rF6ykTOWXULHdabAT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584801; c=relaxed/simple;
	bh=senDZHEmYebQCAnLtwzi1Q/bk5sXkiAKoJBR4qJTN4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saWPPRPIEscRZ3Y41f3KflDQqgZYy+H09XnFY8mUKI9GIUc/GvyTRJ55thujYmTgT7uhB6QjtdnWy5nwXpqSwFzDLXjjCuYXoGa9mrl6dQ5X8zCHdXCyxbM9OC1UaZlbrzH1+ik+yZgDlAYADC9FJJH3Xepnh2NjSbrjvkOAeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=czX7u1YK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773584796; x=1774189596; i=ps.report@gmx.net;
	bh=4phVwyEWx1J9XfZ+dWJJNPe7PNfSIlQ75z9+gBftQk8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=czX7u1YKU8YnUGQXn6jPhZqy/KosjAK+7EJUawJIxytHGm5vy4RPK6SkyUweGOf4
	 eEzThQIPJj+2wTJC5kNqjr6bZ0sesMW8gQfNGX23XOR6Z9MdNt66butW70G3lKiVW
	 5uhe1lqFaZbDZn/HXc3ABceJ54chWfB35n3cPGYgSRAtVPssCFC+GO8SGLAhmeuSp
	 iMWdVLq66tOMyZZZJUP0Cv4gPt9wRkr7tuZILUI6hpejURJkIJyuhdLiBqdTqXn3O
	 sdsnqmvi5ZW8qBSDeFyAYoIpC2GLCfrdf11U2dvub17Z3ZgGuSvJnBfYc5bwFE80c
	 FC2hUHmaFqh3qSxOtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1vzKdz018d-006hB3; Sun, 15
 Mar 2026 15:26:36 +0100
Date: Sun, 15 Mar 2026 15:26:35 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Marc Buerg <buermarc@googlemail.com>
Cc: elias.rw2@gmail.com, joel.granados@kernel.org, kees@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH ] sysctl: fix uninitialized variable in
 proc_do_large_bitmap
Message-ID: <20260315152635.4c20c6f0@pc-1>
In-Reply-To: <20260314093725.12429-1-buermarc@googlemail.com>
References: <20260313121708.137dae22@pc-1>
	<20260314093725.12429-1-buermarc@googlemail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ig1xaAQ0+949JxY3JMvRhraHgbltCILHchzewdZeiUJB+3E35lA
 R8llC13Dy93hScIZoCsK6IzqY0WGdR+Y5qeF2yjF7TyutfWVq/vy8MJ08z73jymo2y10CA0
 jAczLc4z2LhsN5gD6xbyvfZm50wxRdYC9diU3iQhCj1csOaY1CczayYu8UIkOzOsJUrYALC
 W0N2FEEIqLXp32ZV3kz0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tYu6fy0/5EM=;MWPce6m82ylYga0wuKq+ASsQ+3X
 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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225472-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ps.report@gmx.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1885C291050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Marc,

On Sat, 14 Mar 2026 10:37:25 +0100, Marc Buerg <buermarc@googlemail.com> w=
rote:

> Hello Peter,
>=20
> Thanks for your feedback and the idea. You are correct proc_get_long()
> does not set @tr if @size is zero, therefore, left in
> proc_do_large_bitmap() should be zero when we expect @tr to not be
> written to and c still being uninitialized.
>=20
> > Would the better fix be:
> >=20
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 354a2d294f52..89db88552987 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1427,7 +1427,7 @@ int proc_do_large_bitmap(struct ctl_table *table=
, in=3D
> > t write,
> >  				left--;
> >  			}
> > =20
> > -			if (c =3D=3D '-') {
> > +			if (left && c =3D=3D '-') {
> >  				err =3D proc_get_long(&p, &left, &val_b,
> >  						     &neg, tr_b, sizeof(tr_b),
> >  						     &c); =20
>=20
> This would explicitly fix the problem as it enforces that we only check
> if we know c contains what we want to check for. Fixing it like you
> proposed seems better to me.
>=20
> I am somewhat conflicted because leaving c uninitialized allows that a
> similar problematic access of c could be made in the future.
> Initializing c could prevent that. I also do not see an immediate
> downside, but that could just be my naivety. Further, that part would
> now behave similar to when we apply the default hardening configuration,
> if my understanding is correct.

Your 'initialize c' (outside of the while loop) approach will only fix the
problem at the first iteration of the loop, on further iterations c will b=
e
overwritten by the prior proc_get_long() calls..., for me the 'check c onl=
y
if valid' seems the better approach.... ;-)

Regards,
Peter

>=20
> On the other hand, we do not read c later on, and I do not see a reason
> why the function would change significantly. Still, it feels more
> defensive to me to also set c to 0.
>=20
> In the end, I am not so used to the kernel coding style. Is there
> anything that can be argued against providing both? If you think this is
> unnecessary I am happy to follow your reasoning and go with only the
> check for left being non-zero.
>=20
> Kind Regards,
> Marc


