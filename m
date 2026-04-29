Return-Path: <stable+bounces-241834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLAnKTK08WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B111490812
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9000F3013A68
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036E3A2572;
	Wed, 29 Apr 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wc2NZB/m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dduQqz5t"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635492DF153;
	Wed, 29 Apr 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447682; cv=none; b=Qc0TMON0XPkmO0ha46gDnM8YxAnqk871665LQjni2qF01Kf3pEXQ0VSam7mz/eqwlrjLpEHzx4w0zfS1iTB4g1x3CIfqyLoJWGD6vYtBxu6P6EuPqBbuTA/gzEYk9HjM1Z9msdqGzPY9GftPhjZ0I03ZasCiMrEYu50JRB7g/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447682; c=relaxed/simple;
	bh=ZjY087y27/p1yVQbqNrTEtjNi2uSsy/tDE64Xr301PA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKhIQAf3rPl9YJiXs+ehej8long3J1qgjWFI4EUX8J8NIydXCBFjamde5vpPQn6Poe8YR5H22S3xwc99mxWHhfJXNcLxH8AJxTGFpcZS6KI6gjKt4FetVaE/ha0U9lZ4t4wgAMo/Yn6uvJnpyxuX9XSLP3Tp3fGYrA5rSltdn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wc2NZB/m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dduQqz5t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777447679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjY087y27/p1yVQbqNrTEtjNi2uSsy/tDE64Xr301PA=;
	b=Wc2NZB/mZtCBhqt2/FTwKHJtZqO3E6aCJurWqUEZDevCxdhZU35MLwSTumxPsyE6e7nmfc
	K5+IpSbVF8iLEnt+AGHDsUnFfx9mCKmuKVf7Pqw6qFOOFyparILBtG4SCSWd4Yyq3GSePu
	8cCJ5s7d5pQfsu5NUVRNlJPHa3HDowX0Z+8JSusWJWPepswG8WQINjayPMIgDaoUgA4u09
	TUk2Tw9YN1/0z1PoAJ+SiNIkx8ZB2+1FoPZWunf4qb5LthzNNshymNvvQRPLLhrkX1uvIK
	OIjRPKALw1q7zKH00J7+Gm5hqe54KuguVmtKcgCrmxg3fs2qKuJvMWJ1PyZKjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777447679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjY087y27/p1yVQbqNrTEtjNi2uSsy/tDE64Xr301PA=;
	b=dduQqz5tESWAwuCaokU8odPFEU7jUerItFVHKfhWC7m7qY1GYaBj2nQ5QcY+uVPDdqrGEA
	myfongr0zJfcFyDQ==
To: Christian Brauner <brauner@kernel.org>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Shuah Khan
 <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Khazhismel
 Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
In-Reply-To: <20260429-november-speisen-3084d769d316@brauner>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de>
 <20260429-november-speisen-3084d769d316@brauner>
Date: Wed, 29 Apr 2026 09:27:59 +0200
Message-ID: <87340exm2o.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4B111490812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241834-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yellow.woof:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Christian Brauner <brauner@kernel.org> writes:
> The selftests rely on this behavior that timeout=0 sees events from a
> concurrently running producer. They would fail at a very higher rate
> after this change - believe me I had a similar patch that changed
> something in this area.

Huh, that's interesting. Do you still remember which selftest cases rely
on this behavior? I would like to study them further.

> I would explore the seqcount that Mateusz suggested tbh.

I will investigate that.

Nam

