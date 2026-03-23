Return-Path: <stable+bounces-227960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLH/Kd0lwWmbRAQAu9opvQ
	(envelope-from <stable+bounces-227960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:37:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542642F14E8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93118300F138
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE25396582;
	Mon, 23 Mar 2026 11:36:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B832AADC
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265808; cv=none; b=tfNboKLSNE1hr+uYzwc8ElXTU60o0ca9fsQvDvCbOX4MJsHw3Eu+oPKJ4Gvo6GffANOWm8NPRvLE5+bR4XaxIZXxc2t474q/bvONub3ZMDyMpMa9hLZST3Pq2cy7RCNGg11jh10kZEdoBKQ0QiB7/iVMTGCdsJWe08TUzM/vsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265808; c=relaxed/simple;
	bh=iBuTuvBEePsdIy0MEqv2qHOkYw5LBEupxgNu66uAAQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwpC7goB5ZSfhXLJ092yGn+7r/69X4ZOK/bECOerPkKqFvbzx0S2S0abrYEgu05SKv1wn+kMiPZcvkgj1e+f5/E7BEda2xK3cdjoZhVTCxmieELZqtiS9fsHeH4oPx34s87xgaYSq/ID/A88dfZl7q9nq7JPmZJB9Xk8D1NX37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w4daJ-0000KT-7B; Mon, 23 Mar 2026 12:36:39 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w4daI-001idw-2x;
	Mon, 23 Mar 2026 12:36:38 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w4daI-000000007d1-3WZP;
	Mon, 23 Mar 2026 12:36:38 +0100
Message-ID: <19172f0cf9cd0f2767fd63c24d3b53c5e7eee379.camel@pengutronix.de>
Subject: Re: [PATCH] reset: gpio: fix double free in
 reset_add_gpio_aux_device() error path
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@kernel.org>, Guangshuo Li
	 <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org, Linus Walleij <linusw@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Date: Mon, 23 Mar 2026 12:36:38 +0100
In-Reply-To: <CAMRc=MfLQFbFhJ+sKQSf52xSRLMSoS9q+utDk=AjMT_XJJ7Z1w@mail.gmail.com>
References: <20260321074240.796922-1-lgs201920130244@gmail.com>
	 <CAMRc=MfLQFbFhJ+sKQSf52xSRLMSoS9q+utDk=AjMT_XJJ7Z1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227960-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c09:e001:a7::12fc:5321:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a0a:edc0:0:c01:1d::a2:received,100.90.174.1:received,2a0a:edc0:0:900:1d::4e:received,185.203.201.7:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 542642F14E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mo, 2026-03-23 at 03:05 -0700, Bartosz Golaszewski wrote:
> On Sat, 21 Mar 2026 08:42:40 +0100, Guangshuo Li
> <lgs201920130244@gmail.com> said:
> > When __auxiliary_device_add() fails, reset_add_gpio_aux_device()
> > calls auxiliary_device_uninit(adev).
> >=20
> > The device release callback reset_gpio_aux_device_release() frees
> > adev, but the current error path then calls kfree(adev) again,
> > causing a double free.
> >=20
> > Keep kfree(adev) for the auxiliary_device_init() failure path, but
> > avoid freeing adev after auxiliary_device_uninit().
> >=20
> > Fixes: 5fc4e4cf7a22 ("reset: gpio: use software nodes to setup the GPIO=
 lookup")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/reset/core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 0135dd0ae204..58ecde760b6e 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -856,7 +856,6 @@ static int reset_add_gpio_aux_device(struct device =
*parent,
> >  	ret =3D __auxiliary_device_add(adev, "reset");
> >  	if (ret) {
> >  		auxiliary_device_uninit(adev);
> > -		kfree(adev);
> >  		return ret;
> >  	}
> >=20
> > --
> > 2.43.0
> >=20
> >=20
>=20
> With recent changes in reset core this all went away but yeah, looks righ=
t
> and should be backported.
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied to reset/fixes, thanks!

[1/1] reset: gpio: fix double free in reset_add_gpio_aux_device() error pat=
h
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dfbffb8c7c7bb

regards
Philipp

