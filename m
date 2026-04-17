Return-Path: <stable+bounces-238462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKPpHdXz4Wmv0AAAu9opvQ
	(envelope-from <stable+bounces-238462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:48:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7808418E97
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84359308D25D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D93AEF47;
	Fri, 17 Apr 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2xJ8+9J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A953750AC
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415419; cv=none; b=UEk9iKxMzt43nQb8OuhDGLUgrv0JcpHJE5qMNacxD/1/iBVUlZRJb2Fb+dblMh71dP004fiI/oHgktKvCewOS9GV0vlFkILV6C9XGdI4gbML7FnX1o5P8pAE/+TplA1tNdNzJUvrRLoNo33b9RiIZG80nwbgIO1zbleYTDd0KXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415419; c=relaxed/simple;
	bh=JMis1PWBmQ2nY0YUn8Z/PvKMUmrRKtNhJv6gZchAt+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RN0bfosDj9BN/CnSk1cpNodrawFAoA2ngK3B/mAsqwu4JqlCNjb8ubdccZKFmbiWcHEmPl+ldi0LoXG7ZV4iJ3r1iitR0iaiC3+pThGG0yPHvx19hzY8xE9cWJMCPXwiBHIZcJKQuWBesj972KPv5XFgV427z4/ozYso7Tbx8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2xJ8+9J; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f07078ff0so368605b3a.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776415417; x=1777020217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMis1PWBmQ2nY0YUn8Z/PvKMUmrRKtNhJv6gZchAt+s=;
        b=P2xJ8+9JXzms47E7PWeEjYeToPBvwMRXGyKfHzmfYyGc6TwOQd2VayFrCaTBTPj29s
         eWAU3Po7LtrjsUKyGb+y/sS/xxPXyWdkiHeTo52eUARxn9VipLo9fflZ+aVuzzL5ZrEl
         8gcNZXITxXe/dhET0V9VrmV0m0pJCwVbi51T9SeWsdYqw/HKIOeEeVU1a7o2AS/+/FEX
         GTVjg7s/xFVvvQltrwqdROTZyQFQCjIMmAlqqOUGvE1sUNDndlt9jrS/a47Aorxnjs82
         fzuQAJLqFv4iZEZ4Ouod0rrjPOcPKJxcCLHXBYK4sZrrL2peB4mmFD3xnCS705KQQKuH
         ALpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415417; x=1777020217;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JMis1PWBmQ2nY0YUn8Z/PvKMUmrRKtNhJv6gZchAt+s=;
        b=WeUS0rBFZ1cOtjB9VtQKLhGR2VIKUrkdmHS5eUF7aOiytW5MgfPn5Q5tk3bgEOZ5jt
         6ltOi4fzs1W+xPB5bgZGxfYWwe8aW38Cimmj+G6BvAIpRQ+bvI7Bfc2e3EiqMHxqrj+y
         tDwne+4GYrA53wzaH8XZI3oD9YoAj/BMjFs4vzm+XXcqFdaWFR7dSElTjrEphqNhjGyC
         +qEPpZe4zvf6+d38KIjIliFnH3ebcd7m/iPseyvOogNz/lc7gZzG4J5tyUPN2eH5s3yJ
         rWPnlQp15ewk/LkIq4ZbRrD4z4KGyDD68bZEw6EZ+yVvZHm0ejC6K9X9INGmhN1M+lV3
         EzWg==
X-Forwarded-Encrypted: i=1; AFNElJ8kdFRqca0lR7oAUO8TsCCX75cQKpVMMG43sYYdg4Vqm84GdckgZoLwZgWvDbz9gLyStXzRQ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02+8axB0Uz4UuBKYd2sUcvaOEEtNRlGvMn9o0z2rXiSSjvjjJ
	pY6p1VjnKM6F1j/stmwgeLYkJwtLvXpJDYEgQFyz5fFpYwT0Dkihylyxih3uc5TzI8QI/vEiteL
	8j3sazcIsNsrcnrsiDIg8Uja8iA==
X-Received: from pfhx21.prod.google.com ([2002:a05:6a00:1895:b0:82f:7163:35c4])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a248:b0:82f:316:3208 with SMTP id d2e1a72fcca58-82f8c8fb879mr1813947b3a.29.1776415417107;
 Fri, 17 Apr 2026 01:43:37 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:43:34 +0000
In-Reply-To: <CABb+yY23aTXeXu6G-8sHjw32DCqmhsJLu2Mt-txenOgTBiyv+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY23aTXeXu6G-8sHjw32DCqmhsJLu2Mt-txenOgTBiyv+A@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260417084335.2092188-1-joonwonkang@google.com>
Subject: Re: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error
 code when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: akpm@linux-foundation.org, angelogioacchino.delregno@collabora.com, 
	jonathanh@nvidia.com, joonwonkang@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	matthias.bgg@gmail.com, stable@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238462-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,collabora.com,nvidia.com,google.com,lists.infradead.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7808418E97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, Apr 3, 2026 at 10:19=E2=80=AFAM Joonwon Kang <joonwonkang@google.=
com> wrote:
> >
> > > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@goo=
gle.com> wrote:
> > > >
> > > > When the mailbox controller failed transmitting message, the error =
code
> > > > was only passed to the client's tx done handler and not to
> > > > mbox_send_message(). For this reason, the function could return a f=
alse
> > > > success. This commit resolves the issue by introducing the tx statu=
s and
> > > > checking it before mbox_send_message() returns.
> > > >
> > > Can you please share the scenario when this becomes necessary? This
> > > can potentially change the ground underneath some clients, so we have
> > > to be sure this is really useful.
> >
> > I would say the problem here is generic enough to apply to all the case=
s where
> > the send result needs to be checked. Since the return value of the send=
 API is
> > not the real send result, any users who believe that this blocking send=
 API
> > will return the real send result could fall for that. For example, user=
s may
> > think the send was successful even though it was not actually. I believ=
e it is
> > uncommon that users have to register a callback solely to get the send =
result
> > even though they are using the blocking send API already. Also, I guess=
 there
> > is no special reason why only the mailbox send API should work this way=
 among
> > other typical blocking send APIs. For these reasons, this patch makes t=
he send
> > API return the real send result. This way, users will not need to regis=
ter the
> > redundant callback and I think the return value will align with their c=
ommon
> > expectation.
> >
> Clients submit a message into the Mailbox subsystem to be sent out to
> the remote side which can happen immediately or later.
> If submission fails, clients get immediately notified. If transmission
> fails (which is now internal to the subsystem) it is reported to the
> client by a callback.
> If the API was called mbox_submit_message (which it actually is)
> instead of mbox_send_message, there would be no confusion.
> We can argue how good/bad the current implementation is, but the fact
> is that it is here. And I am reluctant to cause churn without good
> reason.
> Again, as I said, any, _legal_, setup scenario will help me come over
> my reluctance.
>=20
> Thanks
> Jassi

Hi Jassi, can we continue discussing this issue from where we left off last
time?

Thanks,
Joonwon Kang

