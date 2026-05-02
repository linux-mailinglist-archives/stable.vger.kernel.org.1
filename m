Return-Path: <stable+bounces-242582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL9FBUJq9WnkKwIAu9opvQ
	(envelope-from <stable+bounces-242582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 05:06:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CAD4B0BE6
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 05:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81643016CAF
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 03:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84292236FD;
	Sat,  2 May 2026 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPDCG//f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA121DD525
	for <stable@vger.kernel.org>; Sat,  2 May 2026 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691198; cv=none; b=IDJ+2rClORpzQbomxUQCKyGuANj0CpdyxMEikgQdncyGhyqz6DOqeMvIKXaVYIIZwXIC/wLQ9wXhTdlTBRy1qA4DSS401/bNOH74k72fdn0jpj9+U+5ZIF6jeS0ljC7b9vAUcTAFUeDgYovbwYwZZVGzgNoKnrKf7JKCGwqmSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691198; c=relaxed/simple;
	bh=5oL081m1pbWM8M4iwVYJIisa55uoUlK3U0lVydp28Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uo6Oa+wmKNp97RhgiA7O1uskK/2pTyrRU5y900plxUQslGEUALPmxkGQ4KbrkBE1cGAdkEy6/79Sp/WuNwyRfWl6zziaxHC4OzAOpaLXwlM7KfHyQeD0MvedI8Tr9D02BEazHk38V0e6AvV+higc4CuW/boJylejE++6zFzqP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPDCG//f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC9AC2BCB4;
	Sat,  2 May 2026 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777691198;
	bh=5oL081m1pbWM8M4iwVYJIisa55uoUlK3U0lVydp28Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPDCG//fYvPABnefnqmEAQykWpfRlpIEgOEb4eIx9C2rcpZVfiNVvvOxkC6NWoJY6
	 y6CiZ7ZUHSUX6V9mKX/Uz6n/LH5ULeXp52Jhq3+0HWI9eCxN2TUNcvOAVxzAAX+lGi
	 CdQKLO3TWEwNJ2kh1671wxgbA4HpPq0oxe+V4v5Qjo2Jb4R+CYbnfZEa5pizTTixcY
	 0Z7iR1VFuQCByEhYzmPcdlyDAuMCKZ2pIsQzdJKvg6AAsup4zg/A/3kX75GqN5r+5g
	 fVyT6/5c5v87He7ahiNgzQVHfD1GA/ROC8Z1Qk/wTwq/qRmYRyM7aN9OqDi9Em6CBY
	 RSuX6rIhKuulg==
From: SeongJae Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race" failed to apply to 6.18-stable tree
Date: Fri,  1 May 2026 20:06:23 -0700
Message-ID: <20260502030624.127487-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026050141-likewise-trapeze-f1cc@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69CAD4B0BE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242582-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 01 May 2026 13:01:41 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 33c3f6c2b48cd84b441dba1ee3e62290e53930f4
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050141-likewise-trapeze-f1cc@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 33c3f6c2b48cd84b441dba1ee3e62290e53930f4 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Fri, 27 Mar 2026 16:33:15 -0700
> Subject: [PATCH] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race

The patch should be merged together with daf51c2e9585 ("mm/damon/core: fix
damon_call() vs kdamond_fn() exit race") but seems you tried to apply the patch
without the dependent one.  Nonetheless, the previous one also cannot be
cleanly applied.  Even after the previous one is applied, the patch cannot
cleanly applied, either.  So I posted the two patches [1,2] that ported for
6.18, as replies to this original mail.

[1] https://lore.kernel.org/20260502030257.127460-1-sj@kernel.org
[2] https://lore.kernel.org/20260502030257.127460-2-sj@kernel.org


Thanks,
SJ
 
[...]

