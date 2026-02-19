Return-Path: <stable+bounces-217487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEONHT9Nl2m2wQIAu9opvQ
	(envelope-from <stable+bounces-217487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:49:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D64016167B
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E3A3012C51
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D19350A1A;
	Thu, 19 Feb 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5eaFwji"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3D2580F2
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523363; cv=pass; b=ibz3hYZxi48cz4wBH6Lr3ZHCtfoa9t9kPLh75TH8tqOUE7y3d8txCvUX6yICBTP0YqTs2CsuFlj7Kl8yfkiar6mZdFuuMRK71bYlHNtLK1VriVENGQVabfN1sZooh9HOINtn1soO+RScyeJ5NudEr5Z3aXbxA/DsHSA8N/HxlnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523363; c=relaxed/simple;
	bh=nthbS0viVjFrlhnBCE7lWWs7/UpBfZh1k0Iq3ugZ8n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ohkv4j40jVE5h8FqaBLqEVtrDuR0ExlmTsIY86zMH6IGk4IB2ro7n8eMfidvkAhXEHBMDCzRGA/lnjrhdeNv78qjAqyKfLKDCpHcatmbDJFc11+N1nlfo5pxmKJxTL0DypD5JnGQeRFx+7OmBKJp2RGYFVJLpat8TbsIgHetFUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5eaFwji; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7947cf097c1so10983317b3.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771523361; cv=none;
        d=google.com; s=arc-20240605;
        b=L3hFHNA0ZFTvCbBA8QJMsL3fz54t3aObZpErdEor0jVxATL4gEK0yv7qEmF61On6fv
         A6gdk9yZ0znz8gec41hHmk3c+UQWrVdfYxL/SxoLgzu22yepZUhfGvFNKWOpwjs/wZHl
         /K4QRZFTKUnqASHTGJ0eG7dOD8+E8DyA2sUcjRVvlB0q4NPoIq3u7WauJNvFqn7sj1CS
         lc3KZIzJ/irC4ZtrVvCme9ZCVUMPEVrL6igPEf3AIrZMMe6EMPqXGYvcaHwTJqdwplSB
         eZS1sIeDTe/9O8WlgZy4kJwqubuJ3Oo8GCnB97rvGyVwO8/NDt8g0YvxLCkXhRixv0SH
         Vzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNq8j0WObSJ7gPKSfbCO7fM3Ese3EJIEbd+/lawWf+4=;
        fh=i3hZ9tIkMctsWgkoZalXSYQ9h9yhKyMKrU4dWnStDKs=;
        b=WywJTyM04k+ygt8bxWbUa6qIE++EiYDn91XKoOnu4/anJdtlwh5+VBBoIAQZLhTu7S
         tvr8Lh989Ex1iBBIHkHe1T0fwMbQcpkgAjSG7qhf3G9UmUMZDyVBVeL0yBusD+fQLvTu
         heHAlwG6wSIQ97nanIZ1/Rh9cO8vmJxcIVaZ9mb+ngprX4F3OR6Dpae9d0/NN7PSGrPE
         g4ryxL3h2FtVR835zVbkTraGPfGvcrZNeC3NCNrI3L/JtFrzGeCSEgEAZzL6Eem8EmIo
         5loO94QHcoeM3jf84v/Xky5TxXH0HWrb2VNPkgKio4JLc2d0xsQDDRVjBFkcBnV8uwOO
         zMdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523361; x=1772128161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNq8j0WObSJ7gPKSfbCO7fM3Ese3EJIEbd+/lawWf+4=;
        b=H5eaFwjibveyfStWBXDAHbmpCNc8oIlhXjPGDD9b7bvERL/omWio7xdSccZZkyGPx5
         CH/kOFlzraNnqZNpETdb3Tk8VnWwTJbQILdB2AxTK99wTfOH4FXJNJ0HWd2qiDEP9v/c
         roHNZaAalojbiCeWSdquT4PCYcdgfvkWuol9efIryzsS6nv09Y4V+wdvGukSPoS66eI+
         qksN9z7VJ6Sln5BTPgelL0NsUFxvRasJE85BXeD1c3PleMcbKcR7ALpuKveh2tCxnLfU
         ou67PW3yBmAp9LCf9ZHj6S9zLMzt1zVsefohS2bGnjpK/m3jMJCTbq/PIhKEfAuppCJS
         mJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523361; x=1772128161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNq8j0WObSJ7gPKSfbCO7fM3Ese3EJIEbd+/lawWf+4=;
        b=Z4TNUe7YXjIcFFi6ZvJhANCVEbe5vCQVOKq7vOodniy5BRWuOcCZQgm9f/q8YN7LcZ
         QUeKAo2VTxy7fG4a5TQnnOP/bWcttD+8RxPUrm1w02I8KPysGxsrc6s0SWZC20y+Uj1H
         ZNaPxSEmO4y9q9X++5VfS2ZclNRa2iQK/Cfg2S2Nl4po7j/P9UZPdNjH9QLoqaPfthx1
         +eAhswcRSi33R+Zl3rlFvsYywxiy1BgJI4AcF0WmfO332ZbmDatKG47Hawp8bKQQPDtp
         LKH7ig70CLwMx8UnPPGe9ixrMcBKAUxUVTFZMCky9A9djK5RO60UosUF/2f/UjqJtf/I
         g8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuA1HShCECDypErmbyEpsopHL38EYs4lXadOk6au2PSA6rS7zwDEWaijsGUyJ53sHfjmPFRJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLEYPKsyV8H3G6LhItCVZ4IxGOBXen/IINsFLx6zC4w5CEDaK
	KZgEJlo25zcD0a38tOOHiJJfT2fYUUEqbJEKZdVbPjAcYWVijcHmf5wnAjrjRj0HsHcSAQ39CYJ
	uace+cqQ8EAV36kv+wzZK8arVRBj4F7w=
X-Gm-Gg: AZuq6aLdmAoWNgOWUnPvQ9FG2QnITzAjWMDS0ovF06D8YTOC1CxSYXPhL+50dRC6CCl
	P40myWrgr8Bn9HuIW84gGZ+f8tIjTFAutMk68rIvmy1yfOeP871//c+ho+Jxv0L18O1S0+7/dso
	xthpaoUKJJPYi6Stam5U8pZSMHEQpvJhYhzdriirxqv3qL2nxXIP41kYqdmJqVOPl7G4CpuHb4/
	U2TkujMHoLxJBf4mcpaR0zDETnjB7TOPPTvJTYuSp6WBmLHoMSplA1q5QgCYmS2yENR3HETjaDE
	ebkmmnMO7PHYI7cc7who43t+wR9hk8hITT2pMkZmQPDiYNxuMw7TNIWpIgexOER9j9UrFQ==
X-Received: by 2002:a05:690e:130b:b0:64a:d7b7:8fab with SMTP id
 956f58d0204a3-64c21b8b654mr15264045d50.91.1771523361363; Thu, 19 Feb 2026
 09:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
 <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
 <CADbaWgEfX87oPoiO3vdn_s4=Q4TVRVzh=qDgewEC-t2Xa9gU7Q@mail.gmail.com> <CALGDAeCGPpEjJonFJ5q7tg7UhJwp+CnLO9Fb8U6dEhjGzRS=nQ@mail.gmail.com>
In-Reply-To: <CALGDAeCGPpEjJonFJ5q7tg7UhJwp+CnLO9Fb8U6dEhjGzRS=nQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Feb 2026 12:49:09 -0500
X-Gm-Features: AZwV_QjYWiliR1zasSh8flKtwogXUGhGG_iQzwQpvtfDZaoyhjDTUMVfQKN_vMQ
Message-ID: <CABBYNZJ9cSB_-Q_yVPPivqHCPw+9DE=mfN0J3oqDSm0naDxwjg@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Maiquel Paiva <maiquelpaiva@gmail.com>
Cc: Daniel Matsumoto <insidetf2@gmail.com>, luiz.von.dentz@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217487-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9D64016167B
X-Rspamd-Action: no action

Hi Maiquel,

On Thu, Feb 19, 2026 at 12:08=E2=80=AFPM Maiquel Paiva <maiquelpaiva@gmail.=
com> wrote:
>
> Thank you for the detailed follow-up.
> The explanation about EXPORT_SYMBOL makes perfect sense.
>
> I was analyzing the function's limits in complete isolation,
> and didn't realize the context of the trust limit within the module itsel=
f.
>
> I will certainly use this as a great learning experience,
> (it's never too late to learn!)
>
> I fully agree with reverting commit ac0c6f1b6a58
> ("Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add")
> to avoid confusion and unnecessary code changes,
> since the function that calls mesh_send already handles sanitization.
>
> Just to confirm: what will happen to the other commit in this series that=
 addresses the blocking problem
> (003ca042a386)? The handling of the mesh_pending list was indeed unprotec=
ted
> that's exactly what guard(mutex) is for.

That seems valid, although it lacks a reproducer, since we need to
protect the list mesh_pending.

> Thank you for the review.
>
> Thanks,
> Maiquel Paiva
>
> Em qui., 19 de fev. de 2026 =C3=A0s 13:23, Daniel Matsumoto <insidetf2@gm=
ail.com> escreveu:
>>
>> Hi Luiz,
>>
>> Makes perfect sense regarding EXPORT_SYMBOL. Thanks for taking a look
>> and dropping it.
>>
>> Regards,
>> Daniel
>>
>>
>> On Thu, Feb 19, 2026 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> >
>> > Hi Daniel,
>> >
>> > On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.in>=
 wrote:
>> > >
>> > > Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow i=
n
>> > > mgmt_mesh_add"):
>> > >
>> > > I reviewed the call path for this patch and the overflow condition
>> > > appears to be unreachable in the current tree.
>> > > The only caller of mgmt_mesh_add() is mesh_send() in
>> > > net/bluetooth/mgmt_util.c. The length parameter is explicitly
>> > > sanitized before the call:
>> > >
>> > > if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
>> > >    len <=3D MGMT_MESH_SEND_SIZE ||
>> > >    len > (MGMT_MESH_SEND_SIZE + 31))
>> > > return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
>> > >       MGMT_STATUS_REJECTED);
>> > >
>> > > Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which include=
s
>> > > the param buffer sized for this maximum length, the bounds check
>> > > introduced in the commit is redundant.
>> > > While defensive programming is valid, tagging this as a fix for a he=
ap
>> > > overflow is misleading for backporters and security scanners, as the
>> > > overflow cannot be triggered.
>> >
>> > Yeah, well I would say it would only be valid to apply defensive
>> > programming if that function would be marked with EXPORT_SYMBOL so it
>> > could be used outside of net/bluetooth context.
>> >
>> > > Please consider dropping this from the stable queue to avoid
>> > > unnecessary code churn.
>> >
>> > +1, will drop it entirely, it seems I will need to ask for more
>> > evidence as apparently people are relying too much on LLVM nowadays.
>> >
>> > --
>> > Luiz Augusto von Dentz
>> >



--=20
Luiz Augusto von Dentz

