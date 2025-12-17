Return-Path: <stable+bounces-202827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ECACC9562
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 19:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1473030AFF2C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C534FF75;
	Wed, 17 Dec 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY29QPkB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B234FF6C
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976742; cv=none; b=SDk2bUw6xhoZudfqGz16Bb8fZNJplc3EoVpa1MOqRBnCnCBLp5L/7x9z/SwBjCFVQQFDCb+hnRQYqkUI4MQrdR7vEfJtZDsjwBDfon/gCE/B4ndN06zEdRrqFchp1Mdjl7pJLkEwL2N6iLHn+cHBr3Cd7exwmP8SuK8r8oFaEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976742; c=relaxed/simple;
	bh=+w1uTCwONcBVyp5eI2/M7TmQteqZQCqAMEPWafZNv+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ5zblGu8HdCToeejSfpF+P1YaKFp8v8jLvleIl65P6KIZDXr2/+gBUq/XWCOernJxG/E6dF3clknSOz8HiwOBOcLGuZn+CmcD2xmezz5f9zNDjkAFEJ9a1kbQJRzQXoPRImpqegtoHiQGHIw49tr+oVWjeRpBU9jCDY7CKOf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY29QPkB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7d0f26eb44so96797666b.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765976738; x=1766581538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TypY7h1/+sYivtFKhfjf73cUHfAF4nkZLmlfMoZ28/Q=;
        b=DY29QPkBGOfzm45hNEpcicqlHoTjKAsaKLzTdCfE1pr006gY5KrgDQ3gpU5qApZX7M
         Vhv+F29Kmy1FAvxxZbmZisOz12JtJI88pZkabiznk5Z0VszYsuPeT92TTwKP5DgpmWhF
         h2YsbiF+WIrAFft2aokYNJHPUe02wI3xoDJiwHNziR1MMLJDoCwuPrEG5m14CDT02IZV
         +uDd3/VNMjGS0OHnQ0KtpKoRyJz6pSklFttu49PIfhJTX7lVj4UQwUlSWxuMhh/cHMd6
         wX9dNKqGX2gWmJhTS83+aQEwTKZD3pxoYAA/VvqKvClABRKnKSVGqVjceSgbhJ5qk/Ts
         F/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976738; x=1766581538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TypY7h1/+sYivtFKhfjf73cUHfAF4nkZLmlfMoZ28/Q=;
        b=T/NIH6vVmcCQZ8/TbzJBwN6tb9JCGkncx/VWUA1DXFx1DMBAvO6k05k978urAnBFVD
         aT2KiskWAQvYrGK4M+CGZyotOfnIoUHzmJvcw0gcBdjyZWe+I836eypopZ+vp0MbBI1d
         pTpjXJTb6gMaP9QYU72/FeCvoww4YYmTFSCSsbLPCN/TTlovLWD/36OApoYYSAuA0ChH
         OirTdVOWW1i6fe2prLrEVbVaSP3ude5zXzyeuSTi1b+PRNcI3YuIazU0mpE0TupTHQvv
         5P4vg0Y9zzfT/ULAr2wdHJXfiFmYkRQRrU0/au3PpDPxM4OQ3emz7NfWWxwWMUKWuWzc
         9dnA==
X-Forwarded-Encrypted: i=1; AJvYcCU0SRuyeUhD79A6v9TR2oQUGiy861W5qff0xI8a05topGpnyrIjmbdTKfDvmRUhI0Lo5hijB0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8W4UB7wtvMq3yUHexHg6Lw5DzhxVZBac6u1ocb2E06dl3YAO8
	jf6SjtcyHit6D+gfZUn1hwUIHV390yaF4/JCaLQt5zB+hFLRD+A5/qCcgGJWcyngmu9YXGpITpN
	ilBNY4O7vZ6+vMOAhUodUh2pzvz7twkk=
X-Gm-Gg: AY/fxX7TuSZuKqmHT9Cv24K5zbp8OdyEJz/AOs2TYPmVn1xbIgESnh6wH0IgIIBL2yt
	0cQaTEbIE8qNskuKCwLmTwHJ/BvuteM/IG5sRAtqL28Fk9WhgwSLx5go3DeOLsrAdBFhLTgXox8
	+faSeRQf6KXSY1Qn2tYjwuDiAZY9nRpDMphb2zWOlhkwfWT94rEAMdKDOSHLWhmFGRMFqN/PWIH
	Y/QmVVXqLAuJpUXVZsL4M7OemuxEzPx4vOCiIlaD9u1on3W8khR6YG1Ch7oleRTPpUQK5Jt
X-Google-Smtp-Source: AGHT+IFazB3f4/1bhVy2oXsu6BrlIpTYELoVLleyYFPAoLjBMbc2b6in36ubjUTMEhmfp5i3UoCkHuCsyiXdhN/7b88=
X-Received: by 2002:a17:907:9689:b0:b73:8bdb:9608 with SMTP id
 a640c23a62f3a-b7d235b1605mr1000580666b.2.1765976738187; Wed, 17 Dec 2025
 05:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217124659.19274-1-pioooooooooip@gmail.com>
 <20251217124659.19274-2-pioooooooooip@gmail.com> <ebb7cb16-781b-4f33-b7c0-3c5dd383913c@kernel.org>
In-Reply-To: <ebb7cb16-781b-4f33-b7c0-3c5dd383913c@kernel.org>
From: =?UTF-8?B?44GP44GV44GC44GV?= <pioooooooooip@gmail.com>
Date: Wed, 17 Dec 2025 22:05:27 +0900
X-Gm-Features: AQt7F2qrW6VynHp9kFV2IJSZxuez5PtnNmmRyq0ft-lTrP3B_4NuH3Kwr9fcVq4
Message-ID: <CAFgAp7gP_yk7nF_AN+B_DRDJW--ytCKKQToG2m6y4h_SLBBaLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED
 in nfc_llcp_recv_disc()
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-nfc@lists.01.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Sorry about that =E2=80=94 my previous response might not have made it to t=
he
list/thread.
Replying here to address your concerns before sending v3.

1) DM_DISC reply after LLCP_CLOSED
This is not a new behavior introduced by my change. In the old code, the
LLCP_CLOSED branch did release_sock() and nfc_llcp_sock_put(), but it did n=
ot
return/goto, so execution continued and still reached nfc_llcp_send_dm(...,
LLCP_DM_DISC) afterwards. The disc patch only removes the redundant
CLOSED-branch
cleanup so release_sock()/nfc_llcp_sock_put() are performed exactly once vi=
a the
common exit path, while keeping the existing DM_DISC reply behavior.

2) Initial refcount / double free concern
nfc_llcp_recv_disc()/recv_hdlc() take an extra reference via nfc_llcp_sock_=
get()
(sock_hold()). The issue is the mismatched put/unlock: the CLOSED branch dr=
ops
the reference and releases the lock, and then the common exit path does the=
 same
again. This is a refcount/locking imbalance regardless of whether it immedi=
ately
frees the object, and it may become a UAF depending on timing/refcounting.

Regarding your formatting notes: I will wrap commit messages per
submitting-patches,
use a 12-char sha in Fixes, and run scripts/checkpatch.pl (and --strict) an=
d fix
reported warnings before sending v3.

Best regards,
Qianchang

On Wed, Dec 17, 2025 at 9:57=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/12/2025 13:46, Qianchang Zhao wrote:
> > nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold(=
).
> >
> > In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED stat=
e, the
> > code used to perform release_sock() and nfc_llcp_sock_put() in the CLOS=
ED branch
> > but then continued execution and later performed the same cleanup again=
 on the
> > common exit path. This results in refcount imbalance (double put) and u=
nbalanced
>
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597
>
> > lock release.
> >
> > Remove the redundant CLOSED-branch cleanup so that release_sock() and
> > nfc_llcp_sock_put() are performed exactly once via the common exit path=
, while
> > keeping the existing DM_DISC reply behavior.
> >
> > Fixes: d646960f7986fefb460a2b062d5ccc8ccfeacc3a ("NFC: Initial LLCP sup=
port")
>
> 12 char sha.
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>
>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> > ---
> >  net/nfc/llcp_core.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> > index beeb3b4d2..ed37604ed 100644
> > --- a/net/nfc/llcp_core.c
> > +++ b/net/nfc/llcp_core.c
> > @@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_l=
ocal *local,
> >
> >       nfc_llcp_socket_purge(llcp_sock);
> >
> > -     if (sk->sk_state =3D=3D LLCP_CLOSED) {
> > -             release_sock(sk);
> > -             nfc_llcp_sock_put(llcp_sock);
>
> You did not answer my previous review. You also did not answer my
> concerns from earlier private report. Please respond before you send
> again v3.
>
> > -     }
> > -
> >       if (sk->sk_state =3D=3D LLCP_CONNECTED) {
> >               nfc_put_device(local->dev);
> >               sk->sk_state =3D LLCP_CLOSED;
>
>
> Best regards,
> Krzysztof

