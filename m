Return-Path: <stable+bounces-233192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDjcNg7dz2mn1QYAu9opvQ
	(envelope-from <stable+bounces-233192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:30:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7E395C65
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E81DB3002D20
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38C3AF648;
	Fri,  3 Apr 2026 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPAz2bJY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0869313535
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229594; cv=none; b=PcpwZ8Lzc73alBtRge5GU65Bzmrbrlmk+u040Y8BvItemB34d5001b3hcmJdmGLPRgDhwwHmrsOZDI8HTlqEB+8I3e0uxUPt9LCztSlOLPBUYhYluxcoTFpJyUOGxB3NsEfUYohVb/U2xWsl8YM6bIxsUV8lTkZnKPndPBE0cbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229594; c=relaxed/simple;
	bh=uA+6V46rf6BOemDNgqn1Ld9hPYGCKqeJGfmxwLPppmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VoDn0ufwxxI4vHVdsA/9Of3P9hJKL9+o4HL3bAUszRipTc6Ol/QsnvVjeZWM+/PEfi9SlxanwFwe6Y9xiC2ZqEJGk+8uDgyzbDJ2j6sxyO+cV4TDdlRotWiUSQHF6vADiISHPalA4eqJ0eGj+BV7zjZF511UFetyuqc0/DasSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPAz2bJY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2454fc131so33708425ad.3
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229592; x=1775834392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTxlcaECIOSPGuWyVGV6jMrdulKgnVXDtGKmH5N3sQ8=;
        b=oPAz2bJYijjKA93RCct32bDF+otXfrANys3svf4OG1dqO42V50uTwy6xf9dEfa1J3Y
         fVSvqhbzZSFonm/VNLYGxAQJtQBokZeMTE2z5AMQY59eri42H/PT4tlSrVb/rGZObI+k
         qgtaS0ysi22NZBXb4MhpYR1vzwNTdXBuKUNZVXe8V6tKPAAfJsDs8v0rbtOitKlbuc3p
         jB9ofUfsA3RjW//eM6mg6hqljhU/CGLEFxc6xQnJufGQXkFqM4Qh4s95KohfP1pEOswW
         nhaVAZ+y2bAOm4fpbT4FtlTbm113PbVVXXBpT7m36boosh50+wE4K1QgBBf5Gz/H8shb
         brmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229592; x=1775834392;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uTxlcaECIOSPGuWyVGV6jMrdulKgnVXDtGKmH5N3sQ8=;
        b=EKI2mIUZq3T2bbX5itcbvYcTwGApQUDHB4wNciQSpUB+fMlJXBBFauIOVJ/GtfsdrM
         sFE+XH/UvZ/QP1k7VWM84mLA9LHrt7QXocA165IQOtfnzahuDYmisHV6fPQ094brtJ5j
         vvaFxkpehCfh+uJ9ZmMWI4Gb7DSlgReXjSzae2r9Ex8P8EMj+0VpjCeAXrLHs9+twPmQ
         iULzxLv2NgQOrU2HRG7etAY5iYVLl7afEzRy0wTr8smgXHe923rKAH/fjEIehvIcHj86
         YjmVXJWR6Ja2+BMXL2I9cHeo+rHZyOsdAzxe+kaJLCuO3BMyZWfTsSIffCU5HCJroNBQ
         BfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnFG0/e9X+WZh+FoVd+jlZbs5JburEzmO0ddNMSsbGLJTIK3gJzRr0/LjbisHpz5O3pI2EEzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyniYTjfZqy10kUyWZIcb9SdskYodZM/khRMgC8FQQXaen/fAAi
	VJgWRs0xB2vkYbvdTjxc5G2F1OF/suLMB/+pFmVnYZr7kllGf6etlEdCfkXYj/KYKRMZYjMmSav
	tEG1V7tFttkoDLplfxQrON55PuQ==
X-Received: from pgcn23.prod.google.com ([2002:a63:7217:0:b0:c73:bace:526e])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7354:b0:39b:e321:784f with SMTP id adf61e73a8af0-39f2f05041dmr3566398637.40.1775229591907;
 Fri, 03 Apr 2026 08:19:51 -0700 (PDT)
Date: Fri,  3 Apr 2026 15:19:47 +0000
In-Reply-To: <CABb+yY3hYcJ82QGor3w5KKHUGz9Pc1k64Jdf-94E4Yvv0DTeyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY3hYcJ82QGor3w5KKHUGz9Pc1k64Jdf-94E4Yvv0DTeyQ@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403151950.2592581-1-joonwonkang@google.com>
Subject: Re: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error
 code when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: angelogioacchino.delregno@collabora.com, jonathanh@nvidia.com, 
	joonwonkang@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-tegra@vger.kernel.org, matthias.bgg@gmail.com, stable@vger.kernel.org, 
	thierry.reding@gmail.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233192-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[collabora.com,nvidia.com,google.com,lists.infradead.org,vger.kernel.org,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9F7E395C65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@google.=
com> wrote:
> >
> > When the mailbox controller failed transmitting message, the error code
> > was only passed to the client's tx done handler and not to
> > mbox_send_message(). For this reason, the function could return a false
> > success. This commit resolves the issue by introducing the tx status an=
d
> > checking it before mbox_send_message() returns.
> >
> Can you please share the scenario when this becomes necessary? This
> can potentially change the ground underneath some clients, so we have
> to be sure this is really useful.

I would say the problem here is generic enough to apply to all the cases wh=
ere
the send result needs to be checked. Since the return value of the send API=
 is
not the real send result, any users who believe that this blocking send API
will return the real send result could fall for that. For example, users ma=
y
think the send was successful even though it was not actually. I believe it=
 is
uncommon that users have to register a callback solely to get the send resu=
lt
even though they are using the blocking send API already. Also, I guess the=
re
is no special reason why only the mailbox send API should work this way amo=
ng
other typical blocking send APIs. For these reasons, this patch makes the s=
end
API return the real send result. This way, users will not need to register =
the
redundant callback and I think the return value will align with their commo=
n
expectation.

Regarding the change in the ground for some clients, could you help to clar=
ify
a bit more on what change, you expect, would surprise the clients?

Thanks,
Joonwon Kang

>=20
> Thanks
> Jassi
>=20
>=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> > ---
> >  drivers/mailbox/mailbox.c          | 20 +++++++++++++++-----
> >  include/linux/mailbox_controller.h |  2 ++
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index d63386468982..ea9aec9dc947 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -21,7 +21,10 @@
> >  static LIST_HEAD(mbox_cons);
> >  static DEFINE_MUTEX(con_mutex);
> >
> > -static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct comp=
letion *tx_complete)
> > +static int add_to_rbuf(struct mbox_chan *chan,
> > +                      void *mssg,
> > +                      struct completion *tx_complete,
> > +                      int *tx_status)
> >  {
> >         int idx;
> >
> > @@ -34,6 +37,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *=
mssg, struct completion *tx
> >         idx =3D chan->msg_free;
> >         chan->msg_data[idx].data =3D mssg;
> >         chan->msg_data[idx].tx_complete =3D tx_complete;
> > +       chan->msg_data[idx].tx_status =3D tx_status;
> >         chan->msg_count++;
> >
> >         if (idx =3D=3D MBOX_TX_QUEUE_LEN - 1)
> > @@ -91,12 +95,13 @@ static void msg_submit(struct mbox_chan *chan)
> >
> >  static void tx_tick(struct mbox_chan *chan, int r, int idx)
> >  {
> > -       struct mbox_message mssg =3D {MBOX_NO_MSG, NULL};
> > +       struct mbox_message mssg =3D {MBOX_NO_MSG, NULL, NULL};
> >
> >         scoped_guard(spinlock_irqsave, &chan->lock) {
> >                 if (idx >=3D 0 && idx !=3D chan->active_req) {
> >                         chan->msg_data[idx].data =3D MBOX_NO_MSG;
> >                         chan->msg_data[idx].tx_complete =3D NULL;
> > +                       chan->msg_data[idx].tx_status =3D NULL;
> >                         return;
> >                 }
> >
> > @@ -116,8 +121,10 @@ static void tx_tick(struct mbox_chan *chan, int r,=
 int idx)
> >         if (chan->cl->tx_done)
> >                 chan->cl->tx_done(chan->cl, mssg.data, r);
> >
> > -       if (r !=3D -ETIME && chan->cl->tx_block)
> > +       if (r !=3D -ETIME && chan->cl->tx_block) {
> > +               *mssg.tx_status =3D r;
> >                 complete(mssg.tx_complete);
> > +       }
> >  }
> >
> >  static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
> > @@ -286,15 +293,16 @@ int mbox_send_message(struct mbox_chan *chan, voi=
d *mssg)
> >         int t;
> >         int idx;
> >         struct completion tx_complete;
> > +       int tx_status =3D 0;
> >
> >         if (!chan || !chan->cl || mssg =3D=3D MBOX_NO_MSG)
> >                 return -EINVAL;
> >
> >         if (chan->cl->tx_block) {
> >                 init_completion(&tx_complete);
> > -               t =3D add_to_rbuf(chan, mssg, &tx_complete);
> > +               t =3D add_to_rbuf(chan, mssg, &tx_complete, &tx_status)=
;
> >         } else {
> > -               t =3D add_to_rbuf(chan, mssg, NULL);
> > +               t =3D add_to_rbuf(chan, mssg, NULL, NULL);
> >         }
> >
> >         if (t < 0) {
> > @@ -318,6 +326,8 @@ int mbox_send_message(struct mbox_chan *chan, void =
*mssg)
> >                         idx =3D t;
> >                         t =3D -ETIME;
> >                         tx_tick(chan, t, idx);
> > +               } else if (tx_status < 0) {
> > +                       t =3D tx_status;
> >                 }
> >         }
> >
> > diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox=
_controller.h
> > index 912499ad08ed..890da97bcb50 100644
> > --- a/include/linux/mailbox_controller.h
> > +++ b/include/linux/mailbox_controller.h
> > @@ -117,10 +117,12 @@ struct mbox_controller {
> >   * struct mbox_message - Internal representation of a mailbox message
> >   * @data:              Data packet
> >   * @tx_complete:       Pointer to the transmission completion
> > + * @tx_status:         Pointer to the transmission status
> >   */
> >  struct mbox_message {
> >         void *data;
> >         struct completion *tx_complete;
> > +       int *tx_status;
> >  };
> >
> >  /**
> > --
> > 2.53.0.1185.g05d4b7b318-goog
> >

