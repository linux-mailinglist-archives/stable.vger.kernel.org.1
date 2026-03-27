Return-Path: <stable+bounces-230666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LRKqKwSVxmm1MQUAu9opvQ
	(envelope-from <stable+bounces-230666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:32:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DAF3461EA
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC7230ED907
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660DE3F23BA;
	Fri, 27 Mar 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is4rSzNP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284BD3F1643;
	Fri, 27 Mar 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621569; cv=none; b=o4HNknW7jH6tjrRRojap/ySTFi3I4njHE4JjdxJfgY5x+EKkDK4WvS7LLuHU1IKfHTcTRkEC8nc93tS04KBL+aOZDxrBjnpnTqGCZeDPEI1Fmg1u19us0WLOt+vIp8jrxEReTpA952bJbW6GOEvN7WDeqRNAZCm4PQcUAbVsC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621569; c=relaxed/simple;
	bh=d66lxQH+dgjLSvHH2YVQ1SE5I6mwDEHa8Tb0MRJAXn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pg710pjS6lEKuIrKpkIm17AQNoIM5ucEn3XDDtnhEl3hn9kj3hewnvybX+0mFkOosAM4gCozmK2Sbrzdl68/7L5n5JGwDVBS8d68tWOcI0Q7n0zpv7RtIurPGWb8+CQkdOaQUrkryplgiiPxXZp/oQa3mHiAZ0dP1TfrmcbaZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is4rSzNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ABDC19423;
	Fri, 27 Mar 2026 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774621568;
	bh=d66lxQH+dgjLSvHH2YVQ1SE5I6mwDEHa8Tb0MRJAXn0=;
	h=From:To:Cc:Subject:Date:From;
	b=is4rSzNPi7o9FVMxVUPZZTobzL57fC6GgLlnwJga61pjmm9tCr5h8Jyfy83rArlzT
	 EwclD4muTv8KgQf8YeKv1o5/9kYyCIgwCGscfn0CXsXZLQoOyC5Kzzcnx8dZcMaREy
	 EClRnJs+qonm8x/cOAJvwED53utcN/ZPoyhI+D33YEitCPtDVNFcwkGE/Ll3yP+pFA
	 caGVR7ly0Y7m9XJfAkWtIwwo1Z/PCtRaJ21ZySYV1SQex4pZK0K02mgdKst8sZSrBy
	 PB5i42QuZAboo52Yc2TlaLemNNHsl9cIQPTUrU/7JVSivKYWl32+8Sykaa9tbgk30q
	 hZHVERs3PZmqQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 0/2] mm/damon/core: fix damon_call()/damos_walk() vs kdmond exit race
Date: Fri, 27 Mar 2026 07:26:02 -0700
Message-ID: <20260327142605.4834-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230666-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16DAF3461EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damon_call() and damos_walk() can leak memory and/or deadlock when they
are called while the kdamond is terminating.  Fix those.

Changes from RFC v2
(https://lore.kernel.org/20260327004952.58266-1-sj@kernel.org)
- Update and wordsmith commit message.
- Add damos_walk() race fix.
Changes from RFC v1
(https://lore.kernel.org/20260326062347.88569-3-sj@kernel.org)
- Clarify damon_call() call condition.
- Init call_controls_obsolete before kdamond_started completion.
- Wordsmith commit message.
- Split out repeat_call_control leak fix from the series.

SeongJae Park (2):
  mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
  mm/damon/core: fix damos_walk() vs kdamond_fn() exit race deadlock

 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 66 ++++++++++++++++++-------------------------
 2 files changed, 30 insertions(+), 38 deletions(-)


base-commit: 1f03f2e753209de7ef14a675a55453d74c9df5d2
-- 
2.47.3

