Return-Path: <stable+bounces-217496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNbSA9hXl2lPxAIAu9opvQ
	(envelope-from <stable+bounces-217496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:35:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9B161B86
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E5E530300CF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677429B79B;
	Thu, 19 Feb 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec9bKDxk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DB2DEA89
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526096; cv=pass; b=sCfOHbE79wTB5pW35fDx4/nTrtkMW8KWF/B2lDRSMDojEQNp++Wa5h7BkvclWpL7t5X6vFEL1QURGKiPuADVOpcoEZ0XlAVYGZzUNrXvBSOmh80k+t2bWhefkWOvV3rrJrweaHVsl+OGJNO2r+17x7gdks8hzBgWpCVh2bGWDbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526096; c=relaxed/simple;
	bh=A9XZgGLty3z85XE93Yr3ix2KCS8uEQs1krXvsGkWnsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBr7vX239HO3ueZXP04nEf792CeKI/Qw7K4UqsqAAUmY5il9EC8rHQlH4/L1iP/VwZRQ/HFfwJPBpaByZ7HlEcTDDUIuvGmr4TlMIFIN1YGmf4T/bPgA3QVIlZrz98yyHYglGZqqKuGCXynMbTfELj9G6rh3TOEdqTVWC1fvnJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec9bKDxk; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8946e0884afso22889316d6.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 10:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771526094; cv=none;
        d=google.com; s=arc-20240605;
        b=bPXNb8p5sCM0lXbtv6Ov/tqdHoe+h54i8u47BYIOvp82v4X97LYkdKzQFzwFChp/Q2
         CO76HE7g01ib5MCugV7f6MRlefTE8H/j1ng1ywigTXDGsVVPL2PoOXRAPGjM1D1vHXJB
         iBUFv6pzC3ldtnjdPDnSrTbAtESLMmk6mRblOG/qKwZqI4YoCtoJ69YiHabTU0UO3aIB
         ms6gfjXgFHuq6c/5BVsAXbfFVJIjrNAhzmmJAjqtyvSiRhFvtRP0v5aVsskJzvjR0pNI
         v23iTQ/qpng46smXQJsLwv5O5e8b6mb+osA0uA99IvmI81T8kAyjPLZkTOwzbs6RvYmJ
         rVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JV2qH9cY1Yzb57AevKyGXAKH0CdShb+Ar1Fm6qQ3YJM=;
        fh=nQb0plBqxQISzRJIO6s/SVlx5+42c9YLNitJ+K5kCvM=;
        b=T6EI3qbACLu5UaHrlm+WAucjQ+VGP/GbDYrepuPEuhcikoC0UPODNE6vW9z+K/K4mR
         xxeA0ZpbQkUtMz/meWDvnuHlHTjmeWU1dDXAbULkA6fxBu3rS8kvKgMSSr5nDsizq2iC
         q3+sIz7KSVRufrz3F7ZtGyWIUOuUjfQrii5VFKJrIiuD7j52/dBL00a9VDheCr0Ui/Y0
         XHb3DI1ehLdWI2LOW9B6lfN0Jhu2r4PEgmSIFdSWuVvPzJ7g/SyjTVExzZ7M+LQoQJZ7
         63Rv7EV8HqrI80SOZaR2SMnmpXiq6FWVEXdj/F4wdq8COsvmDSvjNcBH9PLu7sesdsi8
         iyLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771526094; x=1772130894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV2qH9cY1Yzb57AevKyGXAKH0CdShb+Ar1Fm6qQ3YJM=;
        b=Ec9bKDxkQyPkg8L4xCEhGDMajKGi9rwbOkG9ZQedFgS/y/85i/Nd9geMNMe5KW7RA9
         cpVL2RGT5dyn8+dK73khJNHI5Rt+SB3K3O7XbZHk2C60aszYxbyNYNZxdoEj/x1z89KT
         LacHSPdIAj28EOZiiLkGXC72NJmP8qmwxdBNFjAUroD4jfAEo4u1Os7ac0VmsK1zmlOi
         nUNQYau2flcJYoWgA1xo0YtP+6YLZpeMbiCmkTJjKuwsaXRyWeRcep86aa9iuwezlfma
         BOaaANyT5c/AhAvNmqpAmJDmIj6YP8k6dywXkfYW7qxpoJMaB432oT79pgHgnKGAH6UU
         hUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771526094; x=1772130894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JV2qH9cY1Yzb57AevKyGXAKH0CdShb+Ar1Fm6qQ3YJM=;
        b=tLsySVgfLlmRni2nHxoA0JewtRq23m8MaQmBivnsghw44olujPyw03XzZSjb1F9WFK
         GbqEEyR3B+01naRN3bgCLrKTwuswo+T+wdByW56H8GJji8YnRpj/CYiAHropRNKjWz6C
         /sWFoz9gn/WVH5hx11zMvSHu1OaC8b1MXUfkUrfR8xDClYzdvnN6Wzh82N3d+6KII83K
         Ki074VmWdvqQ6GrA0QxH9SOt8sfhfhYqqgiIeXAID28W5IkjY9eVNnV4MqOHCeZOg3OB
         EGARCHBXVbQSRGzLZVJPz5rjYK4wkHmDhWBeiLAiUavPfvKJkIDzRA9PLcEge8VrmrSg
         WH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmJduAS5Q7bUt9RSxVK8X/q+tmfi3U7LUDGJreWQIDOXYZYpKHXLdG1Bw7JpMO1GYPwDooOVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LrlStLnmdZlbQ8g14YY96Iz6fj4Q0aVItBQNp7xjtkfF9ldB
	QlD4kEtGRsxB8wdeO/L/ap42umCwO8yrHOoekCvcOh6zLeMoKTCyA8PStKzECh6oXAYVyVsPo2M
	XjNiruWezl29z7FL3z9vNLGVifJYHTXA=
X-Gm-Gg: AZuq6aJn5yftS+/C5mBvj0nXZWKlTvN9vSs+NRaAj3R6+NHCU/xMMEPP6ModLrjjUZf
	wnyLLbLeoYTewD4U8WC87oq190YBfVyPC7HqyoC1bQwinWEelGpjbTzu7bSNfbR8YIHxMpnp/dP
	q2bqeAOFMOdilWsa+fMacGzm/8dOTE7MTVw9WsMgqGrJjcWGJsYDWf5BmHgS5l+amTuKbG6JvMU
	F7wdm9IH0fo3aMKwDbt3SjFklskTWTYMtiIfo2J4tacg+BvYRFCRadSjuTnlChhoHKo4arivWiO
	TB1iExVN6rGN4ibqjK6q3k6oKSrZ0hNlEguopSbJQelrbAg8XkaSecN8tryZV8ieZvuKt0EMfbf
	BSPOVPeQVPNiXoqQu5vQ4fcHN
X-Received: by 2002:ad4:5bcd:0:b0:896:f47e:fd53 with SMTP id
 6a1803df08f44-8974030972amr271050186d6.17.1771526093915; Thu, 19 Feb 2026
 10:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
 <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
 <CADbaWgEfX87oPoiO3vdn_s4=Q4TVRVzh=qDgewEC-t2Xa9gU7Q@mail.gmail.com>
 <CALGDAeCGPpEjJonFJ5q7tg7UhJwp+CnLO9Fb8U6dEhjGzRS=nQ@mail.gmail.com> <CABBYNZJ9cSB_-Q_yVPPivqHCPw+9DE=mfN0J3oqDSm0naDxwjg@mail.gmail.com>
In-Reply-To: <CABBYNZJ9cSB_-Q_yVPPivqHCPw+9DE=mfN0J3oqDSm0naDxwjg@mail.gmail.com>
From: Daniel Matsumoto <insidetf2@gmail.com>
Date: Thu, 19 Feb 2026 15:34:43 -0300
X-Gm-Features: AaiRm53GQRVzIz8NqMEFE_SLu5CJbMafC9IX56Fim2NE-ouFliNMPhCflJnHqCs
Message-ID: <CADbaWgF53sPZbR3uahemgZVYv8rENT7-hYBCh5X5prvd3kPo3w@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Maiquel Paiva <maiquelpaiva@gmail.com>, luiz.von.dentz@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217496-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[insidetf2@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73A9B161B86
X-Rspamd-Action: no action

> That seems valid, although it lacks a reproducer, since we need to
> protect the list mesh_pending.

Actually, looking at the locking semantics, 003ca042a386 is also flawed .

1. The list is already protected. The only caller of mgmt_mesh_add()
is mesh_send(), which explicitly acquires hci_dev_lock(hdev) before
the allocation and list insertion.
2. The patch uses the wrong mutex. It adds
guard(mutex)(&hdev->mgmt_pending_lock) to protect hdev->mesh_pending.
Isn't that lock meant for the mgmt_pending list? not the mesh lists?
3. The locking is asymmetric. The guard is added to the add() and
find() paths, but mgmt_mesh_remove() (which does list_del()) and
mgmt_mesh_next() are left untouched.
4. It replaces a fast path with a blocking lock. In mgmt_mesh_find(),
the patch removes a lockless list_empty() optimization, forcing the
code to acquire an expensive mutex just to iterate an empty list.

Since the execution path is already serialized by the primary device
lock, adding an orthogonal mutex here only introduces overhead and
potential deadlocks.
I suggest not merging that patch as well.


On Thu, Feb 19, 2026 at 2:49=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Maiquel,
>
> On Thu, Feb 19, 2026 at 12:08=E2=80=AFPM Maiquel Paiva <maiquelpaiva@gmai=
l.com> wrote:
> >
> > Thank you for the detailed follow-up.
> > The explanation about EXPORT_SYMBOL makes perfect sense.
> >
> > I was analyzing the function's limits in complete isolation,
> > and didn't realize the context of the trust limit within the module its=
elf.
> >
> > I will certainly use this as a great learning experience,
> > (it's never too late to learn!)
> >
> > I fully agree with reverting commit ac0c6f1b6a58
> > ("Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add")
> > to avoid confusion and unnecessary code changes,
> > since the function that calls mesh_send already handles sanitization.
> >
> > Just to confirm: what will happen to the other commit in this series th=
at addresses the blocking problem
> > (003ca042a386)? The handling of the mesh_pending list was indeed unprot=
ected
> > that's exactly what guard(mutex) is for.
>
> That seems valid, although it lacks a reproducer, since we need to
> protect the list mesh_pending.
>
> > Thank you for the review.
> >
> > Thanks,
> > Maiquel Paiva
> >
> > Em qui., 19 de fev. de 2026 =C3=A0s 13:23, Daniel Matsumoto <insidetf2@=
gmail.com> escreveu:
> >>
> >> Hi Luiz,
> >>
> >> Makes perfect sense regarding EXPORT_SYMBOL. Thanks for taking a look
> >> and dropping it.
> >>
> >> Regards,
> >> Daniel
> >>
> >>
> >> On Thu, Feb 19, 2026 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
> >> <luiz.dentz@gmail.com> wrote:
> >> >
> >> > Hi Daniel,
> >> >
> >> > On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.i=
n> wrote:
> >> > >
> >> > > Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow=
 in
> >> > > mgmt_mesh_add"):
> >> > >
> >> > > I reviewed the call path for this patch and the overflow condition
> >> > > appears to be unreachable in the current tree.
> >> > > The only caller of mgmt_mesh_add() is mesh_send() in
> >> > > net/bluetooth/mgmt_util.c. The length parameter is explicitly
> >> > > sanitized before the call:
> >> > >
> >> > > if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
> >> > >    len <=3D MGMT_MESH_SEND_SIZE ||
> >> > >    len > (MGMT_MESH_SEND_SIZE + 31))
> >> > > return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
> >> > >       MGMT_STATUS_REJECTED);
> >> > >
> >> > > Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which inclu=
des
> >> > > the param buffer sized for this maximum length, the bounds check
> >> > > introduced in the commit is redundant.
> >> > > While defensive programming is valid, tagging this as a fix for a =
heap
> >> > > overflow is misleading for backporters and security scanners, as t=
he
> >> > > overflow cannot be triggered.
> >> >
> >> > Yeah, well I would say it would only be valid to apply defensive
> >> > programming if that function would be marked with EXPORT_SYMBOL so i=
t
> >> > could be used outside of net/bluetooth context.
> >> >
> >> > > Please consider dropping this from the stable queue to avoid
> >> > > unnecessary code churn.
> >> >
> >> > +1, will drop it entirely, it seems I will need to ask for more
> >> > evidence as apparently people are relying too much on LLVM nowadays.
> >> >
> >> > --
> >> > Luiz Augusto von Dentz
> >> >
>
>
>
> --
> Luiz Augusto von Dentz

