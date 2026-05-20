Return-Path: <stable+bounces-249925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPY3EMG7DWpT2wUAu9opvQ
	(envelope-from <stable+bounces-249925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:48:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CF58F0ED
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F7543014FD6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2B7344DA4;
	Wed, 20 May 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcSJHfK+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BC369D6C
	for <stable@vger.kernel.org>; Wed, 20 May 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284916; cv=pass; b=WAt/Q9FT3veXikkBahSTHka4j5iBzzOXNb8XkWyOuRIdOcCldJMNX7iN7XwxZTIgmnkCrfAKivdD3DIdIZlRD2XsXEgjaGTKAPdNtRJ8j4lGWdRzeVk5BL4/ct7mNJ+37Fs9801HTBoTaiXTE/xySyA1COL34dxUiwzE403D5Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284916; c=relaxed/simple;
	bh=Ux4DsBH/b+Hxghz4BUeS5WLTOtBGR43EC7jTFpvlaU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRjL6xvxlOFyoFjzHbjKVZSsknBCC472nEpIEcAVlAK428wrKfhS43wsOf7XiVBpO9RKuhpulhzuUBZoCijq3L3LnP+aktIUwIS8CBHUZ6zY2A6GLcPBu5pDvOX6f3gdy7j/1OsfpakR3h0LF7jI1ioUvesmmTGPE+6eqeMab8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcSJHfK+; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6b9bca48so74542561cf.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 06:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284914; cv=none;
        d=google.com; s=arc-20240605;
        b=hFxwvSyAwBxB9V3S3zl+ZRdyP6yJZKE97ivlH/j7SYVtuKJhQjkBXtaIYldGzQNc81
         Tnjp+FqoHiDyI0tTVNyjOWMuYAQUUXMmkhkS+/0My+Z9kl4lvhbCDzOxhSldcl2EgmwG
         kTCCrt8Ksf1m6uYyHyELEG6RqhgQUJEYSl6UFp//4yMKwYO2E1ezMrupPY4V23MATDa2
         Dl8o7hZS6ScwE44MesPeDe71YNu4oTp9vdUsqm4ldrV0WqabtfYKQZxv24WpwcEwg6nP
         Ipc37Fdq0Rlzo7SKFp3uXyqv3SjzDQgFl3/sWKePOJZGDjYHI/VOlzHhe15BMVCm3T/5
         SW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cDlDwz3hMGqwA/Q8tdCQU22JoDf/l7QLUPLiALNk5o=;
        fh=OUmln7uQPoMg7n+j8MbPAIjeQNqzvEHCgWtqs+OJIls=;
        b=CzUyNAys+l+NSLxrzZkCVMzC5yghI4e4oSI94y0eLmFPMMw183xgOm/VlZQsHVQdmk
         6PA4Z/WAn615ojznYIIiicHITOkIgZsg1JGUdv5n2YWy0d2qY1IO8lUR5o+/V60BzGzG
         lhRqKJBCUGmgVrnIp/6/Oo0QEqIim0B4jZwKpUb+Ir5d7EXSrHUe6azZz7pLEmRZbPY2
         /y4N5Vt/KeR82ubB3VlEqm0EsSjF38pvkQsHQQf+TyI841nMZORHCLCL0szHbMf0aXiV
         m/E2VxxtSM88UfYsWgCHunCq11shL8Nyz7Npymz3LXHVKw3QADjimIU6LWu8evv6JSfv
         Bn9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779284914; x=1779889714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cDlDwz3hMGqwA/Q8tdCQU22JoDf/l7QLUPLiALNk5o=;
        b=QcSJHfK+rzABe8aOKmyPao+xrndA/F3g68EBf41o3MWqnF/hXuyGtMqfYsMc96xpAl
         Av93s+gBb8Nw9AtUSbC2iBfOxMpG3t9JHJ1ZPkJLGYz7veu6m2sUsl/kuUo2W15Jlvgm
         GpaVjVZ1qFOlAQd9d0rQD/cku9z87UO2wM3q6pqNENKw+vs0dlkwKp3T63lRfxM0xvBj
         3jJARN+7HkAQk0hhhkEZDpt3xcZhur6o7lR3pT5RdK6fIDx0znwY9SuWWvmess8ogUsf
         KgZKcbMpMU6LaxCvRYhLOq+irndB3rKZNhCW/0fRXHaUJMwtqTbnDtKCL1QkJWnHeuH+
         dRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284914; x=1779889714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cDlDwz3hMGqwA/Q8tdCQU22JoDf/l7QLUPLiALNk5o=;
        b=hraWlLyHel8+wkbQwTV3Ha0NquzJEamK1QleF5gUa2XHS+ZjyFdKe5U4p0WJ5LeNtX
         j0Mc0LxdInxP0Ci+s7PWN1VqDVJJSzMbrEcD4gPArUgDDtb7DaFGggYoaey7tlpJO1vX
         +cU+dqCRjf99H1DRXGrb6poGo9F0/HgrZwK7+A//KAiKf3DuvCf4eDmAV87QJ1rgwOx2
         iLnP0og/G373N9q4baDjbKEiHBfcHOEV3ba+9lokzOcrhf/LXhUh1TMAuthziQfM5ROU
         ioC7nb4B1xajr3jpgAxY9jobzyMyyi+7sHhMpJ7MbBAEz0ndBinmew4ekW6KuOJ3/ufu
         nt9A==
X-Forwarded-Encrypted: i=1; AFNElJ/bpY0AkweZxNx9Pjed6GE3LP6Dp9glRPfkdZjnLHBp2dQwXD1U/Fn7BIprrOWKDf/jLpAe4M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK53+X2Qkf0+mHd3r0zhYXzXg+L7SZaHjMucOri+YMmkGVCZvn
	F7FITObviFXssOcir1eZpp7PyglfVeQ8230Mk5EJzlXiOxX4tFW9LTNk9Sn8dWvNuo3bqnhiJiG
	mMNG9eYpJllg5PAVYQ2jk4kqVpuKh5KD5Serd0yFT
X-Gm-Gg: Acq92OEYITwIsYrl3ygCPuDXtNvNpf24URA4N6hR1gc+LFa3dtDnISTu8TLXHU+THlH
	oIa9Gh+AlXNSkDVbOTqlInBVGnoII9NWizn6mc+FMKIzGwzxd2PgSD0ruOCetUhoVeS57ReHcrj
	d3RdfyLo4n3pUuFsSKXcFIcES8DYsKqwFGgTvyPQflg8WOgGFMmbLdnPFx6KMJIea8u1i1v9q3N
	BTQc2O2zCtddH9jbBn7Ib5AXCLinFqu2l6KeRYfHv9amWLUHnmM8nOdZ7ad+iDwGvXOipKdZond
	nI5hxWMdNR3RWQnIkapR2Ui6No3ZPwlsfAAjzX+lKQareB8zW4lLbSeY1cG8V6ULSzwna0FT2f9
	HJC7FGFXuBQI3PPfo6r81hZ4/j9O6eGo47ZIFl1qhOEvYYJCxLPXKuAYsctjFH2GL
X-Received: by 2002:a05:622a:1e89:b0:509:30b0:8323 with SMTP id
 d75a77b69052e-5165a0a4269mr339397951cf.31.1779284913096; Wed, 20 May 2026
 06:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519172635.86304-1-yzjaurora@gmail.com> <4172DA29-330F-42FE-91FE-C247D67F852A@remlab.net>
In-Reply-To: <4172DA29-330F-42FE-91FE-C247D67F852A@remlab.net>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 May 2026 06:48:20 -0700
X-Gm-Features: AVHnY4I1HxtwYRIMQmpaAedNn2XzP1Myd4LGPNWE-JvWR-mVw8CYeoBpVMex7PQ
Message-ID: <CANn89iLrG5axgET0_gsTKM0mM1v8aMUzGBLcPgo0icDJB2VuZw@mail.gmail.com>
Subject: Re: [PATCH net] phonet/pep: disable BH around forwarded sk_receive_skb()
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: Zijing Yin <yzjaurora@gmail.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249925-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,remlab.net:email,syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DA8CF58F0ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:03=E2=80=AFAM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
>
>
> Le 19 mai 2026 20:26:33 GMT+03:00, Zijing Yin <yzjaurora@gmail.com> a =C3=
=A9crit :
> >The networking receive path is usually run from softirq context, but
> >protocols that take the socket lock may have packets stored in the
> >backlog and processed later from process context. In that case
> >release_sock() -> __release_sock() drops the slock with spin_unlock_bh()
> >and then calls sk->sk_backlog_rcv() with bottom halves enabled.
> >
> >Typical sk_backlog_rcv handlers process the socket whose backlog is
> >being drained, so the BH state at entry is irrelevant for the slocks
> >they touch. pep_do_rcv() is different: when the inbound skb targets an
> >existing PEP pipe, it forwards the skb to a different *child* socket
> >via sk_receive_skb(). That helper takes the child slock with
> >bh_lock_sock_nested(), which is just spin_lock_nested() and assumes BH
> >is already off. The same child slock therefore ends up acquired with
> >BH on (process path) and with BH off (softirq path):
> >
> >  process context                   softirq context
> >  ---------------                   ---------------
> >  release_sock(listener)            __netif_receive_skb()
> >   __release_sock()                  phonet_rcv()
> >    spin_unlock_bh()                  __sk_receive_skb(listener)
> >    [BH now ENABLED]                  [BH already disabled]
> >    sk_backlog_rcv:                   sk_backlog_rcv:
> >     pep_do_rcv()                      pep_do_rcv()
> >      sk_receive_skb(child)             sk_receive_skb(child)
> >       bh_lock_sock_nested(child)        bh_lock_sock_nested(child)
> >       =3D> SOFTIRQ-ON-W                   =3D> IN-SOFTIRQ-W
> >
> >Lockdep flags this as inconsistent lock state, and it can become a real
> >self-deadlock if a softirq on the same CPU tries to receive to the same
> >child socket while its slock is held in the BH-enabled path:
> >
> >  WARNING: inconsistent lock state
> >  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> >   (slock-AF_PHONET/1){+.?.}-{3:3}, at: __sk_receive_skb+0x1cf/0x900
> >    __sk_receive_skb              net/core/sock.c:563
> >    sk_receive_skb                include/net/sock.h:2022 [inline]
> >    pep_do_rcv                    net/phonet/pep.c:675
> >    sk_backlog_rcv                include/net/sock.h:1190
> >    __release_sock                net/core/sock.c:3216
> >    release_sock                  net/core/sock.c:3815
> >    pep_sock_accept               net/phonet/pep.c:879
> >
> >Wrap the forwarded sk_receive_skb() in local_bh_disable() /
> >local_bh_enable() so the child slock is always acquired with BH off.
> >local_bh_disable() nests safely on the softirq path.
> >
> >Discovered via in-house syzkaller fuzzing; the same root cause also
> >on the linux-6.1.y syzbot dashboard as extid 44f0626dd6284f02663c.
> >Reproduced under KASAN + LOCKDEP + PROVE_LOCKING, reproducer:
> >https://pastebin.com/A3t8xzCR
> >
> >Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
> >Link: https://syzkaller.appspot.com/bug?extid=3D44f0626dd6284f02663c
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
>
> Acked-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>

Reported-by: syzbot+9f4a135646b66c509935@syzkaller.appspotmail.com
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

