Return-Path: <stable+bounces-235682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SsfKKjbL2Wl2tAgAu9opvQ
	(envelope-from <stable+bounces-235682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 06:16:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F68A3DE504
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 06:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 376B8300DF54
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE132D8DDF;
	Sat, 11 Apr 2026 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJpqzEwi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A912853F3
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775881011; cv=pass; b=a2Ok9/7IYnyGVxz0uvmJUTqBqoeAlywtFzfUy7n46RU35fkV4s/9D5l5zu6v2aKe9f2pAw9CxiYOn3k6nQb+2x1U0utqwJBREhrdcY29iJ2tUoAsPmLIIoAWXQ3aQqz/owQEpsitVA8ZO6H7aouD3sGYQ8mGg+h9h3oWc7wpAMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775881011; c=relaxed/simple;
	bh=ZMAoOt1wkcOGigQ5e6NiEBofNEla2Sg1fNPkp6tYBhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaUwNHT+PS0n8FjN+wUBe5WguyCrbjAf6IX55bkjXBbx2vP37d7s30rsD7+Mv2qgkdjY3X/A9UI2kgum26jt5Iip0hkFCq2397ms/vcW2BvgRNgShniLZH/zfKi77J6VvO0Vj55TVFaYKe5WYQgZ9ete/SvzLE16vAe1g/ZGKnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJpqzEwi; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-470145d7e6cso1728844b6e.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 21:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775881009; cv=none;
        d=google.com; s=arc-20240605;
        b=SMRBOBcLRd7QUIhkPCN/3OUQ9Uu7EC4RlNyuHltS/Jbhr3WUxOxxM9ABYdYbmdyIGE
         w0HB7OM75W9WRgeEVHGbCcYERJVo9zWVMxUsPuChYy33wIgWhexAHcMQ6I1DdjSpSmg9
         oWuz2ZgQbH9v1KqmXIaxph6YDhCuGjMBlKFY0Zv1Tn5Z8RW7mJhM2SRMhdxx2tRA7X9P
         30Dft7soUFo071d+9Jdl4ESyUHccESCcNYwBbn9D4nJHQLRJ/sYQzaKMTGu8jIMginD/
         ReVfakKpbxxiZPlqJWHvD664m+5cko9lo+3jORuoSa/OuuBvua+sTRkZCnqMB86aULvN
         zQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twjEd1gufnLRO0nKS7zAkNbwWPdfTOTUCeT//oVlRls=;
        fh=6TmWuPCkAYwoFELWSJ2AIzdXzO63HAwm2YiF9A2thPM=;
        b=dNXXAQ2AS/vv4x7PBxbd+CmJV8djMSU/ut+jgoV2Ix7v1VoptApQv3LTtxS5sBrlz4
         Ae14kGCNG2gEldF5vEkPP+YbXeo0R/B5mauZUCGGGkYhorPBO6R7bem/gKK4MSJaq0we
         jHyMxPaVEKbbxPC0QRMrgxbV4FtsqeV6U+/jeCI0HrpARKDZD/1iujgnOsX1ViiIk+aY
         AsYfae/we5fdCYMJC+9R5LmZmxPDMjtxdwtZftDhU7VDYzdCL8iD4Wauq4QhRt8q0oi0
         /CxBvDVX7XL+7BsKWkINWGUgPb9nU8j0qgf2xg150btsgC+rP5dqtZAuh5pluNPtFu1T
         c98g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775881009; x=1776485809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twjEd1gufnLRO0nKS7zAkNbwWPdfTOTUCeT//oVlRls=;
        b=WJpqzEwinr9lE6CEoNj29POPjf2x/6cZ1CS6A6zRRposSzvUtFdko1wVJxg88XcxUZ
         tqvaxqW31KcDfwV3fydAKmhIN9aHKFcAUnhbvbTRzJa+m0LUsbtdtY1ZA1ZRetFCNvRh
         wVGvhtdi78prPCdmRZLk4VsT0Nf0+24N2yEvX6nbLn5v/ASbSKEdT8HZngzpy4DnlnGM
         40y63zPrVGCR23zZDQNXpKJiW9l0GDLePaZ8cfaBPtaho9yBJvU2mIBowheIYraKY3dJ
         7gQsdTxzIdKzmGyHW0mJUS2FjRIf0Ob1d9z8yRnAQWXbAm8P4uZvu/SgnjGVdRfvZw3w
         jtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775881009; x=1776485809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twjEd1gufnLRO0nKS7zAkNbwWPdfTOTUCeT//oVlRls=;
        b=KSQUbKGR9B+BmD0Z1aBwvpRxTBLZAijw/w1lCsznk/82Cod0XmgeXbElNA//fi6yMb
         0JA2qU3W4E80BIxp54KLPOePyLvne1WAaFW8kKyOchlnMofARdUcMg3HtEruy81tD8yD
         fBVwMe8PT9yauUe57898zmroJjN8wggUq/PN22Gu2bVTwMs/0E0LSsVdlnaXJSETdtwE
         6ffbVVjZ9kvVyG9cdxMj/P6GFQQyaGMt3BrlrqdoajpddRju4ChM1PZnZNMYLOlmosqO
         JRIZvftptMlR+LfbSr+JnkrCXPBYHhuw8KrnjYPDAmSHcTQTo8nvTvyUKUjKaLiAyJaW
         RelA==
X-Forwarded-Encrypted: i=1; AJvYcCWTR7IzINWxyQtWugbIe3Vup6gjeVGsTt0eldNktSPNOqKFQdlWowiAJD68hKZJDtw7X0Lhjd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrpF3+tb89vssXssCQCIVMZr9vI031oTZYJxvuE+J2+Kr6PhG
	Icac6vC0G2yqZUEWwEZGmdLqjsrip+CxxJY+nSL/zbjuHcOI9pa2WF2UMhWHm7eMcVeiZp85XOL
	l9FCTpZt3hfzJt6RQntVUsOtRGO+GLGA=
X-Gm-Gg: AeBDiet3V/wN9kp1MUPiPq+XsibBliLiYjxFTKWGEydLcLJ4wkpiuauRbAVSQ9+Qm94
	eJT0a6iU9blXJogQdt1WA0BhKCkMpcLpqgkaYByntPBvNZLZ+rFgeiUcTfKgM03S/B5EvCwqrxg
	JIj9tIz2T7f628SWXVW/RuYji/9OQHc8s22VFyBFq+5pE3+UYPCj4k0HuZ6zU2d5qDmtLcUh4PF
	H4YKAFPoSJoZ/oc+uwe1jfNU6HoHBpO2yWxozilsRho7OG/azG893UKgaAyXB+YiJP1wlvsGJ3F
	VJZrUPNwrL+JnHFkAc0HftYlFrni3KWzOaYZww==
X-Received: by 2002:a05:6808:c2b4:b0:45c:881c:e0c0 with SMTP id
 5614622812f47-4789f905c23mr3400091b6e.47.1775881008948; Fri, 10 Apr 2026
 21:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410173451.4797-1-devnexen@gmail.com> <eb7a2494-eadb-4801-a12e-68f537bfc94d@molgen.mpg.de>
In-Reply-To: <eb7a2494-eadb-4801-a12e-68f537bfc94d@molgen.mpg.de>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 11 Apr 2026 05:16:37 +0100
X-Gm-Features: AQROBzB5wNWqO-H31WnQxEe0oVHgscgvRrm-wDp9TRnfVf0eiHEvvwosysq5Ytg
Message-ID: <CA+XhMqx+anKJvtGM4NrYTEVAWgY1K_FNnic+GgBNj3dtpaKB5Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] Bluetooth: hci_conn: fix potential UAF in create_big_sync
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235682-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,mpg.de:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 3F68A3DE504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paul,

  Thanks a lot for taking the time to look at this.

  > (Using 75 characters per line would save a line.)

  Good catch, I'll rewrap it in v3.

  > I wonder if a debug message about the stale connection would be
useful.

  Yes, that makes sense =E2=80=94 I'll add a bt_dev_dbg() right before the
  -ECANCELED return so it's visible when debugging.

  > gemini/gemini-3.1-pro-preview comments [1]:
  > > Could this introduce a time-of-check to time-of-use race
condition?
  > [ ... ]

  I had the same reflex when I first looked at it, but I think the tool
  is reading the check in isolation. The hci_conn_valid() at the top
of
  a *_sync callback is really just a "did this connection get torn down
  before the work ran?" guard =E2=80=94 it's the same idiom already used by
  hci_le_create_conn_sync(), hci_le_pa_create_sync() and
  hci_le_big_create_sync() in hci_sync.c. It was never meant to fully
  serialize against a concurrent hci_conn_del().

  The piece that actually closes the UAF in v2 is in
  create_big_complete(): it now takes hci_dev_lock() and re-validates
  conn before dereferencing it, which mirrors what
create_pa_complete()
  does. That's the part doing the real work here.

  If there's a genuine strict-TOCTOU window between the valid check and
  the &conn->iso_qos access inside create_big_sync(), it would equally
  affect every other *_sync user of the same idiom, so I'd rather not
  try to rework that in this fix =E2=80=94 happy to revisit it separately i=
f
  you think it's worth digging into.

  > > + if (err =3D=3D -ECANCELED)
  > > +         return;
  >
  > Should the error message still be printed in this case?

  I went back and forth on that one. In the end I kept it silent to
  stay consistent with create_pa_complete() in hci_sync.c, which also
  just returns on -ECANCELED without logging. Happy to add a print if
  you'd rather have one, though.

  I'll send a v3 with the rewrap and the debug message in a timely manner.

Cheers !

On Fri, 10 Apr 2026 at 21:25, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear David,
>
>
> Thank you for the patch.
>
> Am 10.04.26 um 19:34 schrieb David Carlier:
> > Add hci_conn_valid() check in create_big_sync() to detect stale
> > connections before proceeding with BIG creation. Fix
> > create_big_complete() to handle the resulting -ECANCELED error
> > and validate the connection under hci_dev_lock() before
> > dereferencing, following the established pattern used by
> > create_le_conn_complete() and create_pa_complete().
>
> (Using 75 characters per line would save a line.)
>
> > Without this, create_big_complete() would unconditionally
> > dereference the stale conn pointer on error, causing a
> > use-after-free via hci_connect_cfm() and hci_conn_del().
> >
> > Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS conn=
ections")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >
> > v1 -> v2: fix create_big_complete() to handle -ECANCELED and
> >    validate conn under hci_dev_lock(), matching the pattern in
> >    create_le_conn_complete() and create_pa_complete().
> > v1: https://lore.kernel.org/r/20260408155638.95927-1-devnexen@gmail.com
> >   net/bluetooth/hci_conn.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 11d3ad8d2551..feebe933efc8 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, =
void *data)
> >       u32 flags =3D 0;
> >       int err;
> >
> > +     if (!hci_conn_valid(hdev, conn))
> > +             return -ECANCELED;
> > +
>
> I wonder if a debug message about the stale connection would be useful.
>
> gemini/gemini-3.1-pro-preview comments [1]:
>
> > Could this introduce a time-of-check to time-of-use race condition?
> > Because create_big_sync() executes asynchronously in the cmd_sync_work
> > workqueue without holding hci_dev_lock(), hci_conn_valid() only protect=
s
> > the lookup for the duration of its internal rcu_read_lock().
> > If a concurrent thread acquires hci_dev_lock() and calls hci_conn_del()
> > immediately after hci_conn_valid() returns true:
> > cpu 1
> > create_big_sync()
> >     if (!hci_conn_valid(hdev, conn))
> >         return -ECANCELED;
> > cpu 2
> > hci_dev_lock(hdev);
> > hci_conn_del(conn);
> > hci_dev_unlock(hdev);
> > cpu 1
> >     if (qos->bcast.out.phys =3D=3D BIT(1))
> > Will this lead to a use-after-free on the conn pointer since qos resolv=
es
> > to &conn->iso_qos?
> > Additionally, since conn is passed to the workqueue without holding a
> > reference via hci_conn_get(), could this be susceptible to a pointer re=
use
> > problem?
> > If the original connection is freed and the memory is reallocated for a
> > new, unrelated connection before the work runs, hci_conn_valid() might
> > incorrectly return true. This could cause the new connection to be wron=
gly
> > operated on or deleted later in create_big_complete().
> > Does the caller queueing the work need to take a proper reference with
> > hci_conn_get() and release it in the completion callback instead?
> > [ ... ]
>
>
>
> >       if (qos->bcast.out.phys =3D=3D BIT(1))
> >               flags |=3D MGMT_ADV_FLAG_SEC_2M;
> >
> > @@ -2204,11 +2207,22 @@ static void create_big_complete(struct hci_dev =
*hdev, void *data, int err)
> >
> >       bt_dev_dbg(hdev, "conn %p", conn);
> >
> > +     if (err =3D=3D -ECANCELED)
> > +             return;
>
> Should the error message still be printed in this case?
>
>      bt_dev_err(hdev, "Unable to create BIG: ECANCELED");
>
> > +
> > +     hci_dev_lock(hdev);
> > +
> > +     if (!hci_conn_valid(hdev, conn))
> > +             goto done;
> > +
> >       if (err) {
> >               bt_dev_err(hdev, "Unable to create BIG: %d", err);
> >               hci_connect_cfm(conn, err);
> >               hci_conn_del(conn);
> >       }
> > +
> > +done:
> > +     hci_dev_unlock(hdev);
> >   }
> >
> >   struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __=
u8 sid,
>
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://sashiko.dev/#/patchset/20260410173451.4797-1-devnexen%40gmail.com

