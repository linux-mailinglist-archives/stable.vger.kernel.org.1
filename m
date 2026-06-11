Return-Path: <stable+bounces-262584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CIpFOkf8KWqcggMAu9opvQ
	(envelope-from <stable+bounces-262584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:07:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F33D66D7A8
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:07:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nK13vhrB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262584-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262584-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB263091F33
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88ADFC0A;
	Thu, 11 Jun 2026 00:06:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0119E56A;
	Thu, 11 Jun 2026 00:06:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781136419; cv=none; b=pFgk0HlY66+pAHDE22P6wcMlEgx626z0q64lBf8DKJNUJEWNBGybfMM4U13Ah7ShTvnduI+mz6KWm+pnMhf59wuEe403XHFMjDoTCYvd3NEce+X/pu/96ttQXwSC8Bz2W0iqZWRFVUeEKaIv34Fx+nLlZ/G+Qx635vLz8+ea/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781136419; c=relaxed/simple;
	bh=q36BwwCsV40+cFpAm3AvOUUrjVXzu4BR8KoZBT9OlPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSKF1ZHDifu4nWQvVN+KK9DMBdj5o6KbJE2i689FUqMa9ORrd48ZBYe2XcTauhSR+d64+KhEaITDDnkDL3c/yXCS3c5VHjPcocZPCGfiFldOWv34qxLYGxYddLJMzdBtpXFhs1dWhptlZBfd+YRe34SWwTH2QPW/qxGgPrRDp40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK13vhrB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95581F00893;
	Thu, 11 Jun 2026 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781136418;
	bh=6ZiqRq+M7qmIk1c5q+OVo0ETrzZ8J3PZC8bJm21Xrmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nK13vhrBbVYUK3fkIigBoyZRmWr3HNoCWYLMmEinbOXYrfWmN49FxDfGBMrXf579D
	 UVNQD1X2HKXOqycminDynETvnmfGL96Jvo8Eh8MtMgrpnk01Dr2i6+5/ifOdypM8gn
	 ov923rhoVIr0KBLcylMaataHU/0yi7vhpZXEdLDHhYPmYscQgrQIawaDtY8tKL1gX+
	 sjQuyQkd27ub0DAeRcF+ys8E4DLlWHoPiFxiYwOeZk92kVEwwi9Kt34dH92ZwNfljM
	 K5S8jqnMFA7PDFqEInmlIxRA6N3zv7WeaYvGhgojZb1Uq9BiPY7l8GU+SwoGGjzmUG
	 FxgVS3Q+0UMjw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 0/6] samples/damon: handle damon_{start,stop}() failures
Date: Wed, 10 Jun 2026 17:06:45 -0700
Message-ID: <20260611000646.68793-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262584-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F33D66D7A8

On Wed, 10 Jun 2026 06:55:38 -0700 SeongJae Park <sj@kernel.org> wrote:

> All DAMON sample modules are not correctly handling failures from
> damon_start().  Among those, mtier also has an additional problem for
> handling of damon_stop() failures.  wsse and prcl also have a problem in
> their damon_call() failure handling.  As a result, memory leaks, next
> DAMON operation disruptions, and use-after-free can happen.  Fix those.
> 
> Note that only the damon_start() failure caused issues can reliably be
> reproduced.  Reproducing those issues require the admin permission,
> though.

Finally this series passed the Sashiko review [1].  I initially aimed to drop
RFC of this patch series as soon as passing Sashiko review.  But, the size of
this series has been 3x compared to the initial one, because Sashiko was
finding more pre-existing issues for every review round, and I added fixes for
those in this series.

Due to the size and short remaining time until the next merge window, I'm now
hesitatng.i  The last three fixes might not deserve to rush, because they are
relatively difficult to intentionally be reproduced.  The first three fixes
might be better to be merged as soon as possible, since the issues can reliably
and repetitively triggered.  But, still those are sample modules, and the bug
was introduced with 6.14, which was released in Mar 2025.

So I think it is better to give Andrew and Linus more time for the merge
window.  I will hold dropping RFC tag of this series until it seems Andrew
finished the next merge window works.  Let me know if any of you have different
opinions, though!

[1] https://sashiko.dev/#/patchset/20260610135546.64943-1-sj%40kernel.org


Thanks,
SJ

[...]

