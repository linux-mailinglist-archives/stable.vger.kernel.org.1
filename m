Return-Path: <stable+bounces-254134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCyWJmg+FGq6LAcAu9opvQ
	(envelope-from <stable+bounces-254134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:19:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5B5CA62A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C8C301C17C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548D3812D2;
	Mon, 25 May 2026 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X39ksAEj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/8XGrph4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D82AE78;
	Mon, 25 May 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711568; cv=none; b=Zrh4oGPX0N19iA/zROZzjjUtYRkk5J4VwHTGXu8rmrD7P0FcBrcdRxbBUVNfMYz7j1G6TLsKCVubOL+uJ478nTVT8UvOW+ch3xH2BMhzuj8VW/0/2kW06do9RLNOX0e4o7JmWhcvOs5tZznm15S5oKJmejTII1sATyYiWzK7q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711568; c=relaxed/simple;
	bh=Aumqt1oWP+s5mDz9gAJi0AYMlq8OwYKbn/v1AX+ufJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5mx9DB87CoKoaic9s5j1fDSpsJjKHqyTZtlL8sMXrMVGFnlJkckZULXlcWYAjzHUgrVp15Ci4ep29mfA0TxOXr6zZwlVMjF4/3P7rdu1DAUECep8vUHMgzjLKbQYLGbYfj4oIqsnRYP5CAZv3AvurvaEapCJCcMjkB48Jxec6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X39ksAEj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/8XGrph4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779711565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yZkxNdalN5qp1FZbRjmCvVdIsnfqPWdCo7aJ0RiWn74=;
	b=X39ksAEj5sOQZvAWx/xEPlthXTEVLwWGUf4NMl9YQv834j+emHfJPrDKxq5Tu+pyLfP305
	TZAwq8o9dwfwpPE913MhEYb4wbyqOkYWH0IWf5eTjvsHQiFte0WnGTme5oYgO2t2+qKrFE
	1JKLZe7fqxmGyq6An2fXdShHVusLLh2DD9uXsk3xeyblc8NB1PVbCq9ZUBlXfuXU/S+3KJ
	ObsOsDRC9BRiMB20JePbTyzs/o7YuloVJ/XFa1/Ltm7J5qIn/ot/i+VwIsD0XlQeQfk3lU
	b9kIB8tRl1jeL16BuquK7oBcP1yvXopHPCIrexSGxsfOPsjGXUuqriAO4/lVMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779711565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yZkxNdalN5qp1FZbRjmCvVdIsnfqPWdCo7aJ0RiWn74=;
	b=/8XGrph4n39zkK5Z1IYvaOa+bQgg1SpOFn6K1hdy0k18e8+Tk+X7Zv0SzdTRyskdgrqwsK
	PjABpC/TbgdXt6Bw==
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Soheil Hassas Yeganeh
 <soheil@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, Willem de
 Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens
 Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
In-Reply-To: <CAGudoHFGHsuGUXmefSrGfOkdcoPJnC5a1qbjc9_G4guC4LvJgQ@mail.gmail.com>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de>
 <20260429-november-speisen-3084d769d316@brauner>
 <87340exm2o.fsf@yellow.woof>
 <xbotidrmois5ygxtqtwqzczkt76wcc7uw5cz5lptda53coaavj@pzvxcpe534cu>
 <87cxzc62yp.fsf@yellow.woof>
 <CAGudoHFGHsuGUXmefSrGfOkdcoPJnC5a1qbjc9_G4guC4LvJgQ@mail.gmail.com>
Date: Mon, 25 May 2026 14:19:24 +0200
Message-ID: <87pl2jisvn.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-254134-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,yellow.woof:mid]
X-Rspamd-Queue-Id: E2E5B5CA62A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mateusz Guzik <mjguzik@gmail.com> writes:
> Apologies for late reply.

No problem. Your comment is welcomed, but I was actually waiting to see
if my testing comes back with anything suspicious.

> The diff reads ok to me, but I would consider not looping in case of
> seq mismatch.

You mean something like below?

static inline int ep_events_available(struct eventpoll *ep)
{
        unsigned int seq = read_seqcount_begin(&ep->seq);

        return !list_empty_careful(&ep->rdllist) ||
               READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR ||
               read_seqcount_retry(&ep->seq, seq);
}

Looping almost never happens, so I don't think it makes any
difference. But sure, it is a bit shorter.

> So does it solve the problem?

Yes it does.

> I think a somewhat of a blocker here would be to bench the thing -- I
> would expect some slowdown compared to stock kernel but should be
> still be faster than the previously proposed patch.

I expect the slowdown to be in the noise, but I will do a benchmark.

Nam

