Return-Path: <stable+bounces-233285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D2sYL7MH0WmXDwcAu9opvQ
	(envelope-from <stable+bounces-233285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 14:44:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159439B188
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 496A03006161
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6633F5AC;
	Sat,  4 Apr 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjDDAt5k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23F309DAF
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775306672; cv=none; b=d56Em5L57xbEjW0eZ0UGjjKQTMRxP/CE2zQnyV9T8XtlX6TDxumg1bTsGSw9uRH9JHEVoxUG1p4F+J3ZVyX0X5160t6byZq0HSubf7cd78ZYSMH3GVBxyiOBng/BAwt5N22vqYpDV1V0Ps7CmwIYV/zOzylhEGOZSoZTdGzIKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775306672; c=relaxed/simple;
	bh=6x4+gdTKW6z5iGkG21DDDihOqybDWtH12NpDzzaC5ZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y2kllAK0dDj8dmp+3RQjj1BTSNpVnGL8fkdK/YfppLlRK+c0xuBG+ULDInTSUnQSxnNa1bqyEzc581gVissxPlSm5yhGHatJcCMbJcETdImOkYjbUr50UwLq1XZR//pSdmgocTLmBvDnaeLaeGwsWqln89CjX95A0HItXhZX3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjDDAt5k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0c30b51bfso62059095ad.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775306671; x=1775911471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1l0x4W+UvoXzUmEv9e5e/HxO0/QK/ip62Tt8sY3EdQ=;
        b=KjDDAt5kGR0Iuq0ShmJgU1XnUrSQJ5FwFnWfziq13bwtnVB/cmgvoslH9ulhtJ5I1v
         dQHuVgT2N/JAZttz+ofOadtku+MW9ZTQoYYmYwmCnYAupr3xZBfiU1yxm4fvUbSgrwnf
         5HCHX8optEwRaXmDDQ5OvgA5XQLUM185mL4meaWIyEj6juTDSWwoYZECBHsEAVZTgSYG
         8Qg/dFQmbvYljuP+ghE+GQz++KCtw91Zx6szxXmZikfnJ6rOytUil3ZGxuOm2lsqa0Rs
         dAgNIkQ+1fdosVhMPrSQoL4cpPamogRdawdWD4nAVqbwdR7DblRHjoLzCeN5XJEJQF53
         7Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775306671; x=1775911471;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q1l0x4W+UvoXzUmEv9e5e/HxO0/QK/ip62Tt8sY3EdQ=;
        b=OmCqhD2avS0fuWuiBlHWkv4yBP+borWprSy4uyGojkysOS5w3a+yS1LBPausakHJ5h
         XkC6Mi8bSNcnJuwsrQknje4UfdauwR2+gQEFzWwLdC03+Ryjmw1/L5DoYzxzTkT5lSxq
         ss7hNcRxpafFDuMjq/NFdZ4kwZBsDW8OwPpiKUuVlWp/NQewkouqTv9Wc2ytHfbe75+L
         f3U+2+Y8kP6IUSczq0ihOMtHnqo6ej5UZOrOQ4gB03lTirM1Pq+XtJx2ZtcdBxJoAu9C
         4lws7wpWpOPLXJ8s5F+ASFAcbn7pTNaWywZpxESx4/meU7QgtIntRiLf7ZZwGizSbvSb
         BrWA==
X-Forwarded-Encrypted: i=1; AJvYcCUKrLqyswmXR+yyYDAZHQ8LEY6xgM0Nd+KX5lymzz5sq7zOo2w03wpfr+rqHOMfEDKkGQDqy6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vFxg9FHM53xNhYkcRAaoXBW3RulLqGe4Waj7o21ATRyYbaz5
	5HHC4gXM/fklMU3Nd6Y11kEuwiR//Shvfr9trTYWsFspu0u0tPW0Uw4zNcETDtBJibYQBUk4Krb
	GWfhWpi57EOUd7EIowy2uOK3Fzw==
X-Received: from plwg14.prod.google.com ([2002:a17:902:f74e:b0:2b0:5b0d:f4db])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e748:b0:2b2:50bd:83b3 with SMTP id d9443c01a7336-2b281706f12mr64261875ad.10.1775306670477;
 Sat, 04 Apr 2026 05:44:30 -0700 (PDT)
Date: Sat,  4 Apr 2026 12:44:27 +0000
In-Reply-To: <CABb+yY0uDQh-3cadPQONV=NJKjMtc4mJekgjmHYVaHnfHXvGZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY0uDQh-3cadPQONV=NJKjMtc4mJekgjmHYVaHnfHXvGZQ@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404124428.3077670-1-joonwonkang@google.com>
Subject: Re: [PATCH v3 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: angelogioacchino.delregno@collabora.com, jonathanh@nvidia.com, 
	joonwonkang@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-tegra@vger.kernel.org, matthias.bgg@gmail.com, stable@vger.kernel.org, 
	thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[collabora.com,nvidia.com,google.com,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233285-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 5159439B188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, Apr 3, 2026 at 9:51=E2=80=AFAM Joonwon Kang <joonwonkang@google.c=
om> wrote:
> >
> > > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@goo=
gle.com> wrote:
> > > >
> > > > Previously, a sender thread in mbox_send_message() could be woken u=
p at
> > > > a wrong time in blocking mode. It is because there was only a singl=
e
> > > > completion for a channel whereas messages from multiple threads cou=
ld be
> > > > sent in any order; since the shared completion could be signalled i=
n any
> > > > order, it could wake up a wrong sender thread.
> > > >
> > > > This commit resolves the false wake-up issue with the following cha=
nges:
> > > > - Completions are created just as many as the number of concurrent =
sender
> > > >   threads
> > > > - A completion is created on a sender thread's stack
> > > > - Each slot of the message queue, i.e. `msg_data`, contains a point=
er to
> > > >   its target completion
> > > > - tx_tick() signals the completion of the currently active slot of =
the
> > > >   message queue
> > > >
> > > I think I reviewed it already or is this happening on
> > > one-channel-one-client usage? Because mailbox api does not support
> > > channels shared among multiple clients.
> >
> > Yes, this patch is handling the one-channel-one-client usage but when t=
hat
> > single channel is shared between multiple threads.
>=20
> hmm.... how is this not single-channel-multiple-clients ?
> A channel is returned as an opaque token to the clients, if that
> client shares that with other threads - they will race.

They will race because of the current blocking mode implementation. With th=
is
patch, they should not race as it handles the known racing point. So, I thi=
nk
it will be important to decide whether to support multi-threads in blocking
mode or not.

> It is the job of the original client to serialize its threads' access
> to the channel.

I can see the disparity with the non-blocking mode here. Currently, the cli=
ent
does not need to serialize its threads' access to the channel in non-blocki=
ng
mode whereas it needs to in blocking mode. It would be nice if the client d=
oes
not need to in both modes, but it may also depend on the necessity as you s=
aid.

> > From my understanding, the
> > discussion back then ended with how to circumvent the issue rather than=
 whether
> > we will eventually solve this in the mailbox framework or not, and if y=
es, how
> > we will, and if not, why.
>=20
> It will be interesting to see how many current clients actually need
> to share channels. If there are enough, it makes sense to implement
> some helper api
> on top of existing code, instead of changing its nature totally.

I agree that we may need research on the current uses of channels and the
necessity of shared channels. However, it may require non-trivial amount of
time since it requires thorough understanding of the context of every clien=
t
driver. At this point, I think we at least need a clear documentation in te=
rms
of multi-threads support as we have none now. Since it is obvious that
multi-threads is not supported for now, I can create another patch to add t=
his
to the API doc to be clear. How do you think?

Thanks,
Joonwon Kang

