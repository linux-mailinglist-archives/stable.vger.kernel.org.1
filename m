Return-Path: <stable+bounces-243002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIcEAd2K+Gl+wQIAu9opvQ
	(envelope-from <stable+bounces-243002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:02:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6129E4BCB8B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58132303FFC2
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE03CAE72;
	Mon,  4 May 2026 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg2n33R4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD83C140F
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896046; cv=none; b=ODpm2lp9BqeYwpM50+YrXrG7OX+Lk2dfEEw1SW47r2I5sjKyXHCGblsSC7xJt46BtbOWKsLbFvcPMsC9FA6fbbbmTMnvRVyVFKwcDpZxEu6Q5pIV9c1W/gaBD2LXw9Dn3Xgkxsp0bSKBV3BNIb5gRYXAz+ieT0hspon7feASzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896046; c=relaxed/simple;
	bh=Hl3CwSSKFL604+Bs52WMEy2/aMMaTyXNZKZlz0sf9iA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKxMFRA7sDTGhdJeXrvqXzB40R/9A0plUAFBuowdFhVUvRGl5xvfupNPrXOsSKZhsZdwEA6b06ys/M4z0y+97afWr98OqrfbsJVVxUp81bGOc70Zg81G14YfBgyhHwqdqVfM0nRulxxX66nseTtgT2FbUZ46w7zbkZTVDUqpbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg2n33R4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so45091745e9.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896041; x=1778500841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beppBlc4z/k/6sDHwfuJF7187wKyaJgaXtM+Bj5I6v4=;
        b=Mg2n33R4EO93QUFugy97+NfyCpOmf9d0YAP8/oC6wA4Hp2Xr8qd+RHE0X7Hg+u5Irp
         oSaSFS0C7NGQYdWDk8lEceIZ25KbnpB5tec9XqSQvSm/qnvOkGBSa82qC3xN+zfQdHZk
         QVE+6mG9c3vqM39rdBtMbditMUCXoooVRCnbSrV6/ZiUBtKFOLh+ZKvEkNX2Utw70vmu
         O6dfqo1UKs8KhhPsxp6zpUYU0ComONxGVBWs3lxgpuPobtZs9ICvs4AeHHCssNU2fyU7
         VzKFOtfLgvIOvQttbNU/0NSPW8WNsY7CiUyDXwovFZpHRaPZPTID9cyhLK90mPCAuifn
         r5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896041; x=1778500841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beppBlc4z/k/6sDHwfuJF7187wKyaJgaXtM+Bj5I6v4=;
        b=N8o1AxElOkeFci/Wg4m/mQWLq5jp6PoUKRki+lHns+aw3xgE8HR1t6oBglRXarKKBa
         VYeuAmk5AuEt09r7qNLLfc96A/SxpXp8fFyO5pf+g15LTyeVKlyFTeA5fEG25DdXmhC7
         ohuzGuaM7cEoFn7rmJD6h2Yx4cZb6E55Hz0vKwd7dfv4q9XuWojTTufEq99kz6lZ/BS7
         fPEPwHkN/QpS1JUuvGL+WIrs6/3jLA/swpeDnt1A8GyLFoTRzl/6iuQFgAFachRDq+V0
         iuVU2pQic4O9pnzUigyQpF2A7mfALtiefZX1Fvkj7FubqUVdhv12QOc4QOcq9N+2Ylom
         LMPA==
X-Forwarded-Encrypted: i=1; AFNElJ+GoObpYtgkNg1lxSDS8xVpk9N+c+4GmoITccZg8HePVoj0uQsWbc8TQQGaoXS4VU3ddlgtfow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxbra5QFyiO3s9XqsG10/IkxOxjSjGHpXHhSW7v1tBTtni3PmE
	jvEqFSYrhI+6gAwTa9K4H8xnJxFMZbKk8tZtXxMqDTp8A3qu49/iU4s9
X-Gm-Gg: AeBDieteGR8NWB7AXMzK4sGLgoIDbzx3Fef86gXdKNwVP/lk0e3JiieODGu4wB5mbxr
	VQq9FZ+YmZovIBhRWQ8cu3wSj4D6ue1v/08fJrlNRwY6tXGL9qup+oQmRsBH473zztVA2uf+NBy
	2yiZBOBOFfrIY3G2aA+WH5FrwgfF8ysBjU/cVqps+2lckrEoJLhNbJ/DXDY2E43DSE2v7Fa91CJ
	xbGoSl3kOWLqU9fEFJ4O/N94u9TSl4LSudWhH5aUsuO22hX5H75goxbhiTsR8kGHKBNs0oGR9Gj
	7D+1GqispcH+83XjzgQv5d1Duhn+Sf7H/gT2vjfxze1aQgJQPX4VKfCXsxHFfq3rIjmyL+hRqVW
	WLIgQy7UNqNrF1gygb/CjrJSlUx/S7eioeybg4AZ3PmpEVXCkO8zYEmV6KrsskAHIDf7Yb3TQGk
	1wXXqCywwVgvdKdnryEv6PtBZfbIJKl4EEdcHrNLzjsjzz8P4Djl8Z2xp/+Shg9B7VgkcOSKPqu
	Q7LoopvtM546A==
X-Received: by 2002:a05:600c:8b04:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48a9852f332mr148382325e9.3.1777896032816;
        Mon, 04 May 2026 05:00:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2fa5sm230452445e9.12.2026.05.04.05.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:00:31 -0700 (PDT)
Date: Mon, 4 May 2026 13:00:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Soheil Hassas Yeganeh
 <soheil@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, Willem de
 Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe
 <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <20260504130027.50040ce6@pumpkin>
In-Reply-To: <20260429-november-speisen-3084d769d316@brauner>
References: <cover.1752824628.git.namcao@linutronix.de>
	<43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
	<CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
	<20250718085948.3xXGcxeQ@linutronix.de>
	<20260429-november-speisen-3084d769d316@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6129E4BCB8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243002-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]

On Wed, 29 Apr 2026 08:54:06 +0200
Christian Brauner <brauner@kernel.org> wrote:

> On Fri, Jul 18, 2025 at 10:59:48AM +0200, Nam Cao wrote:
> > On Fri, Jul 18, 2025 at 09:38:27AM +0100, Soheil Hassas Yeganeh wrote: =
=20
> > > On Fri, Jul 18, 2025 at 8:52=E2=80=AFAM Nam Cao <namcao@linutronix.de=
> wrote: =20
> > > >
> > > > ep_events_available() checks for available events by looking at ep-=
>rdllist
> > > > and ep->ovflist. However, this is done without a lock, therefore the
> > > > returned value is not reliable. Because it is possible that both ch=
ecks on
> > > > ep->rdllist and ep->ovflist are false while ep_start_scan() or
> > > > ep_done_scan() is being executed on other CPUs, despite events are
> > > > available.
> > > >
> > > > This bug can be observed by:
> > > >
> > > >   1. Create an eventpoll with at least one ready level-triggered ev=
ent
> > > >
> > > >   2. Create multiple threads who do epoll_wait() with zero timeout.=
 The
> > > >      threads do not consume the events, therefore all epoll_wait() =
should
> > > >      return at least one event.
> > > >
> > > > If one thread is executing ep_events_available() while another thre=
ad is
> > > > executing ep_start_scan() or ep_done_scan(), epoll_wait() may wrong=
ly
> > > > return no event for the former thread. =20
> > >=20
> > > That is the whole point of epoll_wait with a zero timeout. We would w=
ant to
> > > opportunistically poll without much overhead, which will have more
> > > false positives.
> > > A caller that calls with a zero timeout should retry later, and will
> > > at some point observe the event. =20
> >=20
> > Is this a documented behavior that users expect? I do not see this in t=
he
> > man page. =20
>=20
> The selftests rely on this behavior that timeout=3D0 sees events from a
> concurrently running producer. They would fail at a very higher rate
> after this change - believe me I had a similar patch that changed
> something in this area. I would explore the seqcount that Mateusz
> suggested tbh.
>=20

Does this scenario really affect any real programs?
It doesn't make sense to have multiple threads looking for level-triggered
events on a single epoll fd.
When epoll returns an event you really need to do a (usually) read on
the associated file descriptor before calling epoll again.

To split the epoll processing between multiple threads you need lots of
epoll fd with the underlying fd distributed between them and get the
threads to process the epoll fd sequentially (eg by putting the fd in an
array and using an atomic increment of a global array index to get the
next epoll fd to process).

-- David

