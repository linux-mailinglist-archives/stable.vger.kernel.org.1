Return-Path: <stable+bounces-268183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ie+2Elf9O2rPhggAu9opvQ
	(envelope-from <stable+bounces-268183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:52:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE356BFCE1
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Nql89Uxo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268183-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268183-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F35023030F52
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995333DA7C4;
	Wed, 24 Jun 2026 15:52:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508243DA7F3
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 15:52:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316348; cv=none; b=AMUhA9Q9m294I4D/gHKllfIAlG28vuVYkzmVuo6shoXGq6AOv4wcvzmftjRiQSEzbMzuRYMDAtbWEpS3wyKPT8+m+XVunzeTH6206/EQVIxw3SNj2ae7acOF6fGIVXnOUtjNyKCn3uOdsBKxQeJdt0fxEYpR3XeK/lcnqcP7cnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316348; c=relaxed/simple;
	bh=bIHPCHPeTWyLWSSLg2Wih8mmuE/8TdUsbfVXadmZQoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0o2MTExJQ0JOaZQ9eZFRiRhCu3tJF0Lg10v4+efeA5V1zAEUUOmy/IdAg69bYqqVqY7dw1OqWIG58OyujHLmlEbHVe8Af3jKQzj0AgEO2nMDuw/HvB5yysSs25Zm6UAVC9U3GJr5E8zxaVvavDU49hidhbWnsQqyS96dcbTSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nql89Uxo; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782316345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDwgsSpIaXJqcgTFTiBzchXG7H7XwgMajj+pitRMm8Y=;
	b=Nql89UxoPMGg6mB6nbq8Ei3W2U9LI8or1Nztr0Rl/PZjBodddWR1RvBMUvcuk3Vu3Fb0jM
	+37MyyOgq3cgXzr03JEazCo4ITmwDrGMJfnKzB6cPuzevZdgWy++pxDlgGOV62FdIjXavN
	8WikqJXRFE6ciUCwCAr9vryRv6oDpkY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-HQ8F8BMCMzKPj9Y2QCZbEA-1; Wed,
 24 Jun 2026 11:52:21 -0400
X-MC-Unique: HQ8F8BMCMzKPj9Y2QCZbEA-1
X-Mimecast-MFC-AGG-ID: HQ8F8BMCMzKPj9Y2QCZbEA_1782316339
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0D1B1805C05;
	Wed, 24 Jun 2026 15:52:18 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 99FD41956042;
	Wed, 24 Jun 2026 15:52:11 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jun 2026 17:52:18 +0200 (CEST)
Date: Wed, 24 Jun 2026 17:52:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bradley Morgan <include@grrlz.net>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
Message-ID: <ajv9KWlTGqNV_yi_@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
 <ajpv5bW01_xtlZ6R@redhat.com>
 <87bjd0c5xk.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjd0c5xk.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268183-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[grrlz.net,kernel.org,goodmis.org,efficios.com,linux-foundation.org,infradead.org,google.com,gmail.com,smail.nju.edu.cn,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:ebiederm@xmission.com,m:include@grrlz.net,m:brauner@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:elver@google.com,m:nogikh@google.com,m:tglx@kernel.org,m:adrianhuang0701@gmail.com,m:kexinsun@smail.nju.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BE356BFCE1

On 06/24, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Add Eric.
> >
> > OK, I agree, it seems we need a simple fix.
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> > -------------------------------------------------------------------------
> > But let me add some "offtopic" notes... Why do we actually need this fix?
> >
> > kill_something_info(). But at first glance sys_kill/kill_something_info
> > can simply use SEND_SIG_NOINFO? If yes, this makes sense anyway, I will
> > re-check...

....

> So I think tracing the basic kill syscall is interesting.
>
> It uses an explicit siginfo.  It does that so it can choose
> between setting si_code to SI_TKILL and SI_USER.
>
> If the signal number is -1 it sends to every process in the
> system (or at least the pid namespace).
>
> That will require translation.

Most probably I was wrong, I didn't try to re-check yet.

But at first glance kill_something_info() never use SI_TKILL, and
__send_signal_locked(SEND_SIG_NOINFO) will do the necessary translation,
in this case si_pid/si_uid are the current task's pid/uid.

But again, I am not sure. Didn't have to to actually look at this code.

> I suspect just fixing send_signal_locked looks the easiest,
> especially if you make the siginfo parameter const.

Yes, agreed, and I have already acked this patch.

I think we can improve this unconditional rewrite later, on top of this fix.

Oleg.


