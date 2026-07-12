Return-Path: <stable+bounces-273511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dvqFO6LNU2qRfAMAu9opvQ
	(envelope-from <stable+bounces-273511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 19:23:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C37457B7
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 19:23:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VJKVgeN3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273511-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273511-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5610E30134B8
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560D43603D5;
	Sun, 12 Jul 2026 17:23:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F51E5B64;
	Sun, 12 Jul 2026 17:23:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783877020; cv=none; b=mGjSaagsIj5MwDor+bBJNQKUP5xhTgqvCrZMqNlojNybL8sPdKQ8JxNUM++8ZXS2Hd58xqGTupcU5lcaUkyztPUkwmBEuWNLFRVwZrw7CW4rU700QCRZNaDH14dButS9zZzA+eKegSpjksOOdlV++74FAhakP7Jdbt6ZZa0EmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783877020; c=relaxed/simple;
	bh=2bvgYPt+GqQeBP3pjiVPuadeJRieLBCmg5szj7F0/Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5Gz5OEcPEloFxFKTmnWaiOVfRHCWP1kq+W4B2HifzwDlipmqCCxCzlu2zbILuKsRCFysY6WF9A8Lf/5DonlOiQyLkNufFykNGvpD5PBZAZZ8Az8ZYUGmIkE6wIFj2KTrSlCgEt7gcYUwFR9g5v/Mb7uJ3HS9xoeNh2FzX3sPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJKVgeN3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B51F000E9;
	Sun, 12 Jul 2026 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783877018;
	bh=erlvsdImMPOzbt0J1t9Lju9UV9yCJY2fVSin6DJP3CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJKVgeN3+Qn9GQFaBZQs61WHX/XKRIQzg+VY+N85N3T4lXGBLDHUw6/kFxaqHeTDt
	 hSjbJ90rPOVOp/1M/6hIflDQN76PPxSyWqZO26rX6kvVtXrkviX6esW3Ecq/mKDDLn
	 cak6LKA9nGH4Tv0CmidCuQGTFUSRm9puODoduSJpRCxbrrX+RTjitGDi/WMLLSd1hZ
	 cGY0KNWr9a1qrorOJixlRykl4c5vVDjPs/yRFLYC8j0M6Nh1eh9HfMllpE2+979jlM
	 zfRtDJ7ZASjMRh/bLGJyhfboi66TXhAI8LRbPq7B0TJIJ7V6uU+4wbZKE57By28zEr
	 22ICvS1YigYNw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: skip aging from repeated aggressive merging
Date: Sun, 12 Jul 2026 10:23:34 -0700
Message-ID: <20260712172335.92448-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712165432.87609-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273511-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:akpm@linux-foundation.org,m:stable@vger.kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C5C37457B7

On Sun, 12 Jul 2026 09:54:30 -0700 SJ Park <sj@kernel.org> wrote:

> The number of DAMON regions could temporarily exceed the user-defined
> maximum number of regions limit for corner cases.  For example, users
> could lower the limit via runtime parameters update.  For such a case,
> kdamond_merge_regions() repeats merging regions in the case doubling the
> merge threshold.  The repeated merge operation could update the age of
> regions multiple times.  This corrupts the monitoring results.  Fix the
> issue by asking the merge operation to skip aging for the corner case.
> 
> The user impact is degradation of the monitoring quality.  The impact
> should be mild, since the degradation is only temporal, and it is not
> common to happen in realistic setups.

Sashiko found no blocker for this patch.  Sashiko sent findings to damon@
mailing list [1], and I replied.  Please read those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]

