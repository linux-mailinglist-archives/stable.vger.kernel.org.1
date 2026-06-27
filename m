Return-Path: <stable+bounces-269409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z6rvFtcHQGo9bQkAu9opvQ
	(envelope-from <stable+bounces-269409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 19:26:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BF6D2646
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 19:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qmc6DOAw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269409-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269409-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1082A302002A
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6E1310620;
	Sat, 27 Jun 2026 17:26:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD4227EA4;
	Sat, 27 Jun 2026 17:26:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581200; cv=none; b=W04g9EQzlcLajJJBZw18f0SRxp/pzOv+c18nBWZWJzBqpW6SJeyzYMrtYZbkdbIbKOF/mNlddyQYFEU1vzBe70ecSZoOk7zZ00xbgn+1+CKF6dk5H1tfiAxT15xn5DMFi/oLfmH1YqINVfAsKzarKwsPWJ7TOYiBHzReTzGGUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581200; c=relaxed/simple;
	bh=qX6NZ+okwh2mZnH7WQDx5tvtSGr+dLkueoTmpTwKr2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdmpsCNw3jXRsrn361IyrVSpWXeCmCwd6cMsWCv/LIipidI6o4n/4ZwZLw9lX+UWWrUpPe06VUyvJyDsmTes4Fu7x2rObWU7/MJskg77ZcU/XlAEhuq0x7T+BnD7XAGPa1HZDzvCVhW71ZeJg/CgTZ10qpq0OHWilC3B0j/8u5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmc6DOAw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E7D1F000E9;
	Sat, 27 Jun 2026 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782581198;
	bh=FQEZdzMR4S9EJURSnXOi0A7QXVE9gI14e3OGLriAsys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qmc6DOAwKXcAP+pOtkC6rejUGyAHxjO/U5tybrHEyTyFKTp/3VjGhisml9GONUBhi
	 emVNvUHwnVMSMfFdCRgYE8hWnnt8EYcJvfjfll5iFqw97elZpbMJIvcFvmoUF+T6Nu
	 jNBi3Xpqv6fgwcTryQZ47RXt6hbbVWEAYReckGFTfyhOzFmy8/NrWM/yoqsJw1rqYU
	 YeadqQfyZnrcsrlRp6Y9Yejto0hw9Y4nGfoimiAVXW+PQj+LAoA4yYOmy5lwwynmJD
	 HSKqqg0MWiEYBeOAvxHpAomZGuvRX7AB5XqMMkwH7pPdij3KwDvM7M/fGH5jiVCdqN
	 acnSntl1VPKug==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Sat, 27 Jun 2026 10:26:31 -0700
Message-ID: <20260627172631.3923-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627170057.1867-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269409-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:akpm@linux-foundation.org,m:yangyingliang@huawei.com,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF2BF6D2646

On Sat, 27 Jun 2026 10:00:56 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON core logic assumes zero length regions don't exist.  However, a
> few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
> DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
> could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
> and divide-by-zero from damon_merge_two_regions().
> 
> For example, the WANR_ONCE() can be triggered like below.
> 
>     # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
>     # CONFIG_DAMON_DEBUG_SANITY=y
>     # damo start
>     # cd /sys/kernel/mm/damon/admin/kdamonds/0
>     # echo 0 > contexts/0/targets/0/regions/0/start
>     # echo 0 > contexts/0/targets/0/regions/0/end
>     # echo commit > state
>     # dmesg
>     [....]
>     [   73.705780] ------------[ cut here ]------------
>     [   73.707552] start 0 >= end 0
>     [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
>     [...]
> 
> Disallow empty region user inputs by updating the validation logic.

The above description is wrong, since this is not updating an existing
validation but adding a new validation.

> 
> Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
> Cc: <stable@vger.kernel.org> # 5.16.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b3100d7fa5596 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -358,6 +358,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  	unsigned int i;
>  	int err;
>  
> +	for (i = 0; i < nr_ranges; i++) {
> +		if (ranges[i].start >= ranges[i].end)
> +			return -EINVAL;
> +	}
> +

Sashiko found [1] this is not complete, since eventually this function uses
aligned addresses.  I will address that in the next revision by doing the
validation with the aligned addresses.

[1] https://lore.kernel.org/20260627172406.3794-1-sj@kernel.org


Thanks,
SJ

[...]

