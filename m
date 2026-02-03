Return-Path: <stable+bounces-213174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOoTKeiogWn0IQMAu9opvQ
	(envelope-from <stable+bounces-213174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 08:51:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F28D5D76
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 08:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E6163004682
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA5392C33;
	Tue,  3 Feb 2026 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxdbBWyk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AEB31D74C
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105060; cv=pass; b=qFkZGWIl/i0RsAmfiz2QtxnPehQpZrQrQQ79ywR3V1BZnOjbGUQ/OqGUvmPP8D2kiY87QqP5BTZ2LEhuGHq7yY+9RKMuwyBzEswJEaO7qY0dzCd1wovMKTXnJxmfs+JUDqAIwHwh5RJ0dUVL7E9o1yT/GifI7lm0/i91fejYLkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105060; c=relaxed/simple;
	bh=z3uO4wDS4x6z936FnI7cggR5KRAC0BgutNuhO1txo6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc0mN00Ab5psEPuthZSWyqbUQWCoz3loID6+YuVGlKL0mIa/v0YacPJ3TxzHFFJwLHW9eVJeY151anWNMQOSU+bYmcnDYiHVrziEhIHcZeYD0AUsLhXtqwZYIH13kU00+kbPa72Q4D9b8FwqQpLHN4n2lRzP2Q+Cf5oaSGPONvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxdbBWyk; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12460a7caa2so8078379c88.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 23:50:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770105056; cv=none;
        d=google.com; s=arc-20240605;
        b=DYaHwVvMukkEUvepTqEF3kP/6zRl3PP2XcuX+XArQRgpqmsdG6X1jB8s8xEDOAA7zy
         AdTk9KDhdWAfDklRiXEPQd1PyQt2jSkr5XwWzeJG50++Ow8bFj/Ecp0SIOaXc4BjDQN3
         Q0FQgGph6ncuG40Wld+A98WA8oyItAVuCJ6W03zKn4TTKAocgKaiW1zvvOCTUcnr+sni
         DoKJsY/eB0rEOu8jTYgTSddOz/rHuiGGj+L9QB1gBGxn0G7rU5hYNT6+bKbC/OMifMje
         n1YPByIJtk6xHtFKZ3dXe1phi9Po4JSaeH0j+scy79HxLigENLaQ/hkUwHyfUmq6B40r
         lUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dzMuEZYMn/hj9SYdAXLTnPBjRskZLNxUP6ZIZEqwunk=;
        fh=rYuiSWP8HxC8O3z/Ui5yvMMZoRK3o9Db+FuGQh6R5to=;
        b=U5kizhF0Sz5Ga+nAE3j20EQ6I9LAiF2BSxDAGWOJCUGvCRbiF831UZAnU81ofzea5a
         9rHpEDt/AFLnpempnskSlBu9AF6gP22irtLXua6n+n+JQwuY/Ts/dyiASKL/AW0eXxqe
         T++T3RNBW7ZjhYEnXUH+Vty4lAHh7LBg+6vl8YBFviVlAtAJuLSQsVBV2ROZ8/K6Lcry
         zq5RCMdbOZIXBMdB6eUWqkpf3W1LEcrf9upmwmwKQM7nANaM243KjcZo8N08gTw/XJin
         eUpgitoo6zyF6oZThErStV0L8gX4h1ynoy0Eq4zZam9kKkF0WwcpYiNGLEoVUpYoloQD
         qaMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770105056; x=1770709856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzMuEZYMn/hj9SYdAXLTnPBjRskZLNxUP6ZIZEqwunk=;
        b=IxdbBWykyN6SCKXUzV/u1uJzV5XIMNTY0ESeHRhKeO0HdvhevwhONg9J1h5Rfk4tpK
         eBpD8sYdeaasAQLZIJS7PDSjWD8bIiMDElOw0CYrLs6pBaWVG5auFRo0Bfpxywr7btas
         vid0zfnI40fizGts7Wc/KUg3Z6iq/rdt5uuWfAol+ZaOIfZSbwlkiLhFMIQFpF++XHSO
         wxgK2VuCSqeQdmWn34q95Po5SBsh3m9oICbashUv4U8eAdCO6Tjk3e7ZiRkjHbtC8wMK
         YbQ898CrnGZRF3K3YQXNtKi/2zHvci83WYHX/erAZCAZ4VRm5Pzy00wwZYgqI7pGc9nk
         KZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770105056; x=1770709856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzMuEZYMn/hj9SYdAXLTnPBjRskZLNxUP6ZIZEqwunk=;
        b=tbjtUFO2fPMc025V9YIt3gqTTRp4rucgE5KbcpBegAtd2oVrRrAiP4On1X1T3oohim
         XtBr4vqm8glegey3GwbBEiqymyIVdn61boPCeU9bC/02O1U6fUBqFrYW1Q7GAQSVfauh
         fHup0YWXhUJOeRfoQAhjYNcQxJqw0tT9gtbfb0HB3UAF7igUl1FyB8Xok1pKckEUqNbx
         vM33xjH8xwYgquFjhPPvbhDcffgz4h3ugkkRWoBAtT0UyMeIq+ESLa/vf0jVEs0Q05y2
         ip4yWvn2Bg3aQiP5ozxYkNu8pmMJpZPI8NX/+YnZwDQLuLOWTnI9+XO/D9wwnlc0+Fk4
         6dng==
X-Forwarded-Encrypted: i=1; AJvYcCWUzoH5f81GM7Gv0Xbsw+cKbnLPq7F389b4UoTrrdeIYLPQ7pi8Xez7tD7zHojkK1aMH2JYu2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQZRBzqrnIiSnL0hmhyUZWyTpFLDoQcyWyw5z4T89l9xN2kEm
	o6WEt9/D9I+eOH5wScXAykuhoGOdGFj5veyaifjj4XnlgGWK+h22d12RdI7v0l6h9bpxRjkmZPP
	zcE0m7tSM9Ah3v2YsEveeir+1QPGMC+k=
X-Gm-Gg: AZuq6aK+/FZ0feuPK+AoyLyhI+9yJ+dL0g8QA2pJDMkZyFnbRsJf4fj33Jv88lClzWF
	6Layh1CjYNjZD/Hvq6VOX7qefdxaW2u4ZU8zcOSsIovq9Xogufk4jlokphm6MwxY957/HEskv0S
	+zPaQvhJA3iIoKLLP3/gA7vpjozD1k3wf2wDJD7rNUrjsCBek2uiPO+sym5AIeYm7mOFf09B3Ko
	UZYSQi2oZtTJA2H8O0H9PVjtU/QV+ILlAUg1MviONd2a1Zbye2nIrSMESXsFuMw+CKr5Z9Y7gEa
	DsBN1RcGKmoURMt2urMQz7+5p6Fvc4k1lvNPJu8D7EYevth27pDTPMdANMOwAeCG/nyTfIUCnDQ
	OkPuLQIQXLw==
X-Received: by 2002:a05:7022:41e:b0:124:9e46:82fb with SMTP id
 a92af1059eb24-125c1010d65mr5955626c88.38.1770105056409; Mon, 02 Feb 2026
 23:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
 <CAEnQRZA-nMai9-CEdMqnr2drqBRXXPOKE3a+_3j4S_=x-bM0pQ@mail.gmail.com> <aYDN6X0WVT9nV8fg@p14s>
In-Reply-To: <aYDN6X0WVT9nV8fg@p14s>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 3 Feb 2026 09:53:38 +0200
X-Gm-Features: AZwV_Qi4gqYVwTTFEPdJsETuT6WyCitJtTK7rW3QVszmKRnozagvutFj3QflZ74
Message-ID: <CAEnQRZBVhijvq0VRTKXpW7va2Dxprzz-cnvvj=z90FPXRK+TSA@mail.gmail.com>
Subject: Re: [PATCH v3] remoteproc: imx: Fix invalid loaded resource table detection
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Bjorn Andersson <andersson@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Frank Li <frank.li@nxp.com>, linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213174-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.nxp.com,kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielbaluta@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1F28D5D76
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:16=E2=80=AFPM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Thu, Jan 29, 2026 at 06:02:21PM +0200, Daniel Baluta wrote:
> > On Thu, Jan 29, 2026 at 3:45=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nx=
p.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
> > > resource table even when the current firmware does not provide one.
> > >
> > > When the device tree contains a "rsc-table" entry, priv->rsc_table is
> > > non-NULL and denotes where a resource table would be located if one i=
s
> > > present in memory. However, when the current firmware has no resource
> > > table, rproc->table_ptr is NULL. The function still returns
> > > priv->rsc_table, and the remoteproc core interprets this as a valid l=
oaded
> > > resource table.
> > >
> > > Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table()=
 when
> > > there is no resource table for the current firmware (i.e. when
> > > rproc->table_ptr is NULL). This aligns the function's semantics with =
the
> > > remoteproc core: a loaded resource table is only reported when a vali=
d
> > > table_ptr exists.
> > >
> > > With this change, starting firmware without a resource table no longe=
r
> > > triggers a crash.
> > >
> > > Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook fo=
r find_loaded_rsc_table")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > Changes looks good to  me >
> >
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc=
 *rproc, const struct firmware *
> > >  {
> > >         struct imx_rproc *priv =3D rproc->priv;
> > >
> > > +       /* No resource table in the firmware */
> > > +       if (!rproc->table_ptr)
> > > +               return NULL;
> >
> > I wonder if we can make this change generic because it should happen
> > on other platforms also.
> >
> > Maybe something like this:
> >
> > remoteproc: core: Only copy loaded table when valid
> >
> > Copy resource table in memory only when:
> > * the current loaded firmware provides one
> > AND
> > * there is an explicit request to have the rsc table copied in memory
> > via rsc-table
> >
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1281,7 +1281,7 @@ static int rproc_start(struct rproc *rproc,
> > const struct firmware *fw)
> >          * that any subsequent changes will be applied to the loaded ve=
rsion.
> >          */
> >         loaded_table =3D rproc_find_loaded_rsc_table(rproc, fw);
> > -       if (loaded_table) {
> > +       if (rproc->cached_table && loaded_table) {
>
> But we would be doing the check for rproc->table_ptr twice (->table_ptr a=
nd
> ->cached_table should be the same).  The way it is currently writting for=
ces
> vendor specific implementation of rproc_elf_find_loaded_rsc_table() to do=
 the
> right thing.
>
> The merge window has been pushed by a week, giving me an opportunity to m=
erge
> this patch.  Should I do that or should we continue discussing the best
> approach?

Let's go with Peng's approach:

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

