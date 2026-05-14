Return-Path: <stable+bounces-247119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCHEMLldBWpvVgIAu9opvQ
	(envelope-from <stable+bounces-247119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:29:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1877953E005
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5ED33022954
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 05:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CB3B8BC6;
	Thu, 14 May 2026 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoSnhBqa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F0381C4;
	Thu, 14 May 2026 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736566; cv=none; b=NOFHW/xKLMzWdSZuV56Uu5FxQyI7tplxk7tVkLUunbBVgNOBF4gMYdJ+cT4eQnfSme77atrs3kKV5NAqANqtFgGZDJpoZHcgppW24L2ewuC1o6YT+AMdaMfuZv2/C36UPpwfJNSRi8N7IgGFHIXDOadNuqOndHnEGCWrI9Srv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736566; c=relaxed/simple;
	bh=GT3wQv+ArVJ90RYv0e6zEMOwJzZ4kWkjST7lIq8uNyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9MGyBb2C2MI20SOUmQp83UgyEVl4mnTsW+nHYyNgwLfD4O0sdit02Tsuxllwny/6LX8X8Ne3bqsNHsn94UeJailNhVlayWo/zOMH7SfhhqmEd4xfPEHfrw9PwloaI2prGExkRWaS24L1iXWR7XFJYGk3i+aOLUR2Wr2uucs5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoSnhBqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00787C2BCB7;
	Thu, 14 May 2026 05:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736566;
	bh=GT3wQv+ArVJ90RYv0e6zEMOwJzZ4kWkjST7lIq8uNyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoSnhBqa2ezBsWzSpsBhwhrI54zdTpKPo7YS15cjO79VC73NbmCidF+DCsfPZefit
	 FYXodApUm4nmaUCZ0wX5C8S8tN1i8WZNZkAWrTLTqargwTU6xRVhsFSD6q/lX8ELfw
	 1k5pZ6k55mPXT/6vrx2XWhubkXVg0KL7qR1vzqp28vcW9V09Qu2IHvpPXcyPQyUm+4
	 ZnfuUG/Q57/AIJxjfq4GNMzirjZ6xKdF5xqGynVNgO160oWRMQPNB2eFGIqr8ciTuy
	 Gd4sZH4m0GWM7Ea3RAvkhiWLjhv1AJODJzz1TCHDNL2TUPDgFtx0XeuSxEFRiwwcjP
	 d0rZYMxpXL+ZQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y 2/2] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:29:16 -0700
Message-ID: <20260514052917.111980-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513043039.173237-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1877953E005
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247119-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 21:30:36 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org
> Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
> Co-developed-by: Liew Rui Yan <aethernet65535@gmail.com>
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.0.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit b98b7ff6025ae82570d4915e083f0cbd8d48b3cf)
> Signed-off-by: SeongJae Park <sj@kernel.org>
> (port parts of 42b7491af14c ("mm/damon/core: introduce damon_call()")
> and d2b5be741a50 ("mm/damon/sysfs: use DAMON core API
> damon_is_running()") for damon_is_running() dependency)

Sashiko found this backport is incomplete.  Please read my reply [1] for
details.  I will send a complete version as a reply to this mail.

[1] https://lore.kernel.org/20260514052626.111769-1-sj@kernel.org


Thanks,
SJ

[...]

