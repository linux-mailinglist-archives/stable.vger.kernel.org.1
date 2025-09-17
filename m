Return-Path: <stable+bounces-180425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED2B812CB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221011C27253
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6028D8E8;
	Wed, 17 Sep 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeOY82yC"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172D2FDC35
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130142; cv=none; b=kn30Nf8W/2cI+T7OK6SnTRYTgoc/GN3X/QZ0iEvWCr7PwDZwJcTRGmDJHRd9zrjlwe+XhbNg2VhLpWRITigXJnl3GzUH7EPue5B4LvIgb7coXVy8EosPbjUpoJLTHnAa949btX1tgnmktMPlrZ38BkJe8jfalgCYe+8Mi5YrsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130142; c=relaxed/simple;
	bh=H0/gKaaxvlfYUtn6gGmXwBaSMrd32CreXcUAxjE7SsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i71Ns2791KOCKFK++lxb4ZgV2FEPkCqhzUkYFowJF3RtCZtP+wC8zdBdGKoIcC0M9RGBkndvVe/NF2Ty7SiRXZcfi0rl+7sRM8NMCcwAsRbZHL2tRk1g3lpvk3C3hvdlmD9871YAT4vRzDTvqXH/p+4lzXL1vEcj5vG2cbAE0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeOY82yC; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-424195ca4e6so11905ab.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758130139; x=1758734939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RibQXdSsRsxO3CMdVMzbtMJw7Z5sCxH0F5qvTjzb6hg=;
        b=yeOY82yCwQtC8v/dGjpal6nZpduYV8OIsTJuoWcV+BRDbHNf8vfIhwYeXQ0PBaJz6K
         eCoBuNdVVVd4DRQCN7yuV9sR8JVezYkJRPBtqjUepGTpWA/sgIlmp4L1aMjcUnC2bAwV
         uz1B9miYNwD8aGLE2bOvgphjRDfalVNG7rM/+vScd6cs34U9iWtqfIdEGv2PL0Y9gCkf
         aIEd/EcGQoWnBkiYqCVcUG6SrNBNTED+JnPo/SlijUNzXkmqv37fl1i8hK76oDNCrH/J
         KHiz/EtPg/I6DcYNYWyAFlbt8w/U3aOvd2OsIzKMglAH4t1vEI9Hk2L4SsZ17SCIGPFg
         mfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130139; x=1758734939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RibQXdSsRsxO3CMdVMzbtMJw7Z5sCxH0F5qvTjzb6hg=;
        b=qPJgN73MkMBTn0R5rSn5DhSDA2re6xoQhIskaG8tl0a548K1WyWZExGnoBizeNAzzH
         utq3XEgrJz7FclAGDLRM5Kc9PzfyCXuNszA57oIYtsuns5xXnh2QaBidihk5sg5ggYob
         FYduAU60NJn6pUe6W7crcIgDak9aZoIP6MUgGEzjiyj/owqjpBeu22FNGgzQA/ajlt8C
         iovqMJqVG2j9N+AASvneR2CXxapSmqZf05fWWQV0/7rTcvGmwQ6AxVoJk6hUmuO08ArB
         ktJT7GsOUsgH1JaoGbwGUbnUaawMEWe/9wANgPcpoJvA4KjDCCiLgbHaeDaW0vfxxI6a
         AuPw==
X-Forwarded-Encrypted: i=1; AJvYcCWAhDZ+zepJRLksQSqA6sC7SL3ALqGgIDjt4pyUbSzk3fVAsbYiCyQ7UEnUrNgB7m3+cyKcPes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLIpMvo15hW6ife7s53EajAplaipfbXKvZdG6MKVtg90Bv/2J
	Q679QblEGpgCt9OZ6r/eUXfdfQeJZkwQOR5SWWI2eNnCGOQUyD/eLediGnZoxlLlJNHUwwJzner
	5Mdd2MXkb07aHPqP19dvKNLuqbXzey25lAyid8sYG
X-Gm-Gg: ASbGncs83XCVHmeLZElUigOd5vRBpP7hs45YrCGb4ru/H56FG+f6lIqbvqzRFJzno03
	32WZiCp3HsHjWsMHMpeAUjXESdCnJZzRHKrXmv7nQzT95KL9T5gKM/JK8D1GomvV6qO4RRqk81p
	/Inu7hHUNk7W23HX73LUBIxOCbqer7DR3T2aFn6xl6c2nINM44UTyS4fVrsirTZiKAeY9rjcbrz
	aatKxCxW3TOAv6vruUSsGNL4jfCiC1yNPvdOuoPVS+t
X-Google-Smtp-Source: AGHT+IFFGrAyXguz20mFyMKBXRRfTnkPERkiQ1wXQwdoDKL/pxWsskk/k1ikwhW0kYf3w5UWArMFVx4/etlizuFuw9Y=
X-Received: by 2002:a05:6e02:168d:b0:422:62f8:20f9 with SMTP id
 e9e14a558f8ab-4241863c4d8mr7806975ab.8.1758130139286; Wed, 17 Sep 2025
 10:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135337.1736101-1-edumazet@google.com> <CAEWA0a6b5P-9_ERvh9mCWOgbH6OYdTUXWVGgA20CQ5pfDC2sYA@mail.gmail.com>
 <CANn89iLC+Gr9BbyNQq-udVY-EZjtjZxCL9sJEpaySTps0KkFyg@mail.gmail.com>
 <CAEWA0a4x4XMZKtpz_pNKruC4zwjETVxUuEMs2m_==Dpib_Jrqg@mail.gmail.com> <CANn89iKZDvL9vKbmDa4ivnrm11e0fc65A-MXs8kY4MxR0CnGTw@mail.gmail.com>
In-Reply-To: <CANn89iKZDvL9vKbmDa4ivnrm11e0fc65A-MXs8kY4MxR0CnGTw@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Wed, 17 Sep 2025 10:28:48 -0700
X-Gm-Features: AS18NWDPgb9cZN1-L4a4OUlkwPSMPcDLR2W5EDAL9vUYoqX_KqKda6HCCMD9wfE
Message-ID: <CAEWA0a7fnv3hRJyYGkP9yjcG-dAGFbb0JjdmTF3a5kk6n3RAOg@mail.gmail.com>
Subject: Re: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:20=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Sep 17, 2025 at 10:03=E2=80=AFAM Andrei Vagin <avagin@google.com>=
 wrote:
> >
> >  is
> >
> > On Wed, Sep 17, 2025 at 8:59=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 8:39=E2=80=AFAM Andrei Vagin <avagin@google.c=
om> wrote:
> > > >
> > > > On Wed, Sep 17, 2025 at 6:53=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > Andrei Vagin reported that blamed commit broke CRIU.
> > > > >
> > > > > Indeed, while we want to keep sk_uid unchanged when a socket
> > > > > is cloned, we want to clear sk->sk_ino.
> > > > >
> > > > > Otherwise, sock_diag might report multiple sockets sharing
> > > > > the same inode number.
> > > > >
> > > > > Move the clearing part from sock_orphan() to sk_set_socket(sk, NU=
LL),
> > > > > called both from sock_orphan() and sk_clone_lock().
> > > > >
> > > > > Fixes: 5d6b58c932ec ("net: lockless sock_i_ino()")
> > > > > Closes: https://lore.kernel.org/netdev/aMhX-VnXkYDpKd9V@google.co=
m/
> > > > > Closes: https://github.com/checkpoint-restore/criu/issues/2744
> > > > > Reported-by: Andrei Vagin <avagin@google.com>
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >
> > > > Acked-by: Andrei Vagin <avagin@google.com>
> > > > I think we need to add `Cc: stable@vger.kernel.org`.
> > >
> > > I never do this. Note that the prior patch had no such CC.
> >
> > The original patch has been ported to the v6.16 kernels. According to t=
he
> > kernel documentation
> > (https://www.kernel.org/doc/html/v6.5/process/stable-kernel-rules.html)=
,
> > adding Cc: stable@vger.kernel.org is required for automatic porting int=
o
> > stable trees. Without this tag, someone will likely need to manually re=
quest
> > that this patch be ported. This is my understanding of how the stable
> > branch process works, sorry if I missed something.
>
> Andrei, I think I know pretty well what I am doing. You do not have to
> explain to me anything.


Eric, please don't misunderstand me. I want to get this patch into the stab=
le
kernels as soon as possible. I appreciate your help here.

Thanks again for the fix.

