Return-Path: <stable+bounces-249988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOwBLj7PDWr53QUAu9opvQ
	(envelope-from <stable+bounces-249988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:11:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D2B5908FB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC663055D59
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D80301704;
	Wed, 20 May 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcXhJvIL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783A1714AA
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288397; cv=none; b=iaNBf6MdPbx4isQgmt6RSp/K3142+gZppsfcpSNFR0EnXr96LyR2LkH/7O9JejAJfoYnqjdUcJWf93BRhlN2ZhHLITKQHv1W/SI8Cm1qIKV71nzJiuL2QluxL4lpVP5PJenWVqAtRw5a5Ga+Q3GmCluQxjjhyIJ7SOWPS0RFTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288397; c=relaxed/simple;
	bh=OaJu/x1pwGss2SJGOTLbDeS8biTdWsnovmOVRLd+Fdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/LVWAlsRe6Gey43u3YZhu6wsp5JVivyM3SXK8Z2HRiXfV0G5gZ0QbD8Xv5avgRZoSheTxpGeBiYfJEhuqX0mDaXTNAqjGeELWT8Qe/jVZQx22p4YzwtGujXWpAL2xMr3FZlnx+gNEHPJR0N5v2mWOyIir8pBm2SOm8RtAGnTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcXhJvIL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C91F000E9;
	Wed, 20 May 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288396;
	bh=k+zwS6Si0XdbMF0pTXNbDYOSuu8CYswBUIcjd4zXn/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TcXhJvILVV1hNhX58DaUCqkeY8yvPYei9Gr+twZKLTxKTWbGsuTdnwREXk52H1gDL
	 2+TyLAT2CzMTY2Jl06QNSgG/whaiAwzZvixR3jbt4bCKD/D53zhM7wfOakbZkx8BA7
	 2sT7o65bkSG6aCXAldGohcq6pbCFIlflkmhtoP4IF2h9EIg23a6Er1U9SPoX92NqOS
	 n9KBoACrlp9BUeCNo/Zbbp1Q0kl398heZInsg7nlTKXFlfKPo6G2zv1MxjBe4B1IoA
	 F/8OEjRUabrCz6hxyIBB8DBjpIEHhfgCrO0P024nsTNuMrvsNqvI4Y7OAoVacOiMHP
	 UxdrucFuwBzpA==
Date: Wed, 20 May 2026 10:46:35 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [5.15.y] build issue when building the queue
Message-ID: <ag3JS6WBj-_26wEy@laps>
References: <c059d010-19c8-4891-9b12-a9658ff59b21@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c059d010-19c8-4891-9b12-a9658ff59b21@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-249988-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 14D2B5908FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:28:28PM +1000, Matthieu Baerts wrote:
>Hi Sasha, Greg,
>
>(+cc Kuniyuki)
>
>Our CI at MPTCP cannot build the patches being queued for v5.15:
>
>
>  net/unix/af_unix.c: In function 'bpf_iter_unix_hold_batch':
>  net/unix/af_unix.c:3352:22: error: 'unix_table_locks' undeclared
>(first use in this function); did you mean 'unix_table_lock'?
>   3352 |         spin_unlock(&unix_table_locks[start_sk->sk_hash]);
>        |                      ^~~~~~~~~~~~~~~~
>        |                      unix_table_lock
>
>  net/unix/af_unix.c: In function 'bpf_iter_unix_batch':
>  net/unix/af_unix.c:3397:14: error: implicit declaration of function
>'unix_get_first'; did you mean 'unix_get_socket'?
>[-Werror=implicit-function-declaration]
>   3397 |         sk = unix_get_first(seq, pos);
>        |              ^~~~~~~~~~~~~~
>        |              unix_get_socket
>
>
>https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26156680393/job/76937788263#step:9:2175
>
>For the first one, unix_table_locks has been introduced in afd20b9290e1
>("af_unix: Replace the big lock with small locks."). Before, the version
>without 's' (unix_table_lock) was used.
>
>For the second one, unix_get_first has been introduced in 4408d55a6467
>("af_unix: Refactor unix_next_socket().").
>
>It looks like these errors are due to:
>
>  bpf-af_unix-use-batching-algorithm-in-bpf-unix-iter.patch
>
>This backport of 855d8e77ffb0 ("bpf: af_unix: Use batching algorithm in
>bpf unix iter.") is needed for 4d328dd69538 ("bpf, sockmap: Fix af_unix
>iter deadlock") apparently.
>
>I'm not sure how you want to fix this in v5.15: backporting new
>improvements, or adapting. But maybe easier to drop the faulty patch for
>the moment, and bpf-sockmap-fix-af_unix-iter-deadlock.patch I suppose.

Thanks for the report. I've just dropped this (and few other follow-up
commits).

-- 
Thanks,
Sasha

