Return-Path: <stable+bounces-230941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBpfD7pFyWkAxAUAu9opvQ
	(envelope-from <stable+bounces-230941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9B352955
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C12F300404E
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFF37F726;
	Sun, 29 Mar 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoMqxdD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FD27603A;
	Sun, 29 Mar 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798256; cv=none; b=OJ4LzOcM9qOzhriQIi/gMKMNfSTKfOLVNM+y+IsL+e7EbvVrET4NgLON4El9LZ+S5En2RO0/tjrqMGG+nt7adLt+gZM9eOtkckCg9rZf1gKWyfgJjD9AE+HHINBlev4ErkFDXjSm/dhhKevdXK2OCvXYXmbrKOQxzJwCmtSzuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798256; c=relaxed/simple;
	bh=F6rB/oSgunb1Uwn0bqw0CxoNAheCQwZDVnE4QMMy5W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8vpR+3I2P5Febfl4DpQpZJqQnxDDwpwAntsLllOVwdE1J6rEvLCCNU5EASmGbqnLWhRsYKlBNdg+Yus111AWW+1s1O87lip9nk3i+ypXFQyysCFdokSKvA/ZAVNK5aBTrtX3ya0jGHz8mnRc7H1AZ07uf5PAbKm94LL5nwmgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoMqxdD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C75C116C6;
	Sun, 29 Mar 2026 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774798255;
	bh=F6rB/oSgunb1Uwn0bqw0CxoNAheCQwZDVnE4QMMy5W4=;
	h=From:To:Cc:Subject:Date:From;
	b=OoMqxdD4hnvNwAN+Z47Q+bFg6GC+0rO7D2sCDao2j87/P9P9HIT8Xb+pU77OCu0vj
	 fmCTFc+aUORYySWRafg1YanIftfU8HBzPHj8qbqLey9pxOwZ9SfwRK2asFD77QkKH6
	 8k+trMTJ2fzffR/wVXifCFEmhdTRVp632zkjIhWnGPxdeKhvclme8rh5r2heIDgwYU
	 WOIEYdFHamiO+hHwSrIvO4lxvjHCt/7rvTCfWTjoXqXbxynbSDEZcGOSR8yKFolm+d
	 ipg27t8KFMeK1IrDwZRFnPmgty/0vooOe9/zehTZPvuJRInBM4hFa9huywxLTJ3Gs1
	 a7L/d1HmF62BQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] Docs/admin-guide/mm/damon: warn commit_inputs vs other params race
Date: Sun, 29 Mar 2026 08:30:48 -0700
Message-ID: <20260329153052.46657-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230941-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2ED9B352955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Writing 'Y' to the commit_inputs parameter of DAMON_RECLAIM and
DAMON_LRU_SORT, and writing other parameters before the commit_inputs
request is completely processed can cause race conditions.  While the
consequence can be bad, the documentation is not clearly describing
that.  Add clear warnings.

The issue was discovered [1,2] by sashiko.

[1] https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org
[2] https://lore.kernel.org/20260319161620.189392-2-objecting@objecting.org

Changes from RFC
(https://lore.kernel.org/20260328172415.49940-1-sj@kernel.org)
- Wordsmith.
- Rebase to latest mm-new.

SeongJae Park (2):
  Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates
    race
  Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param
    updates race

 Documentation/admin-guide/mm/damon/lru_sort.rst | 4 ++++
 Documentation/admin-guide/mm/damon/reclaim.rst  | 4 ++++
 2 files changed, 8 insertions(+)


base-commit: b761d53965a239abe1469f2e4e2d4f7d69fac9bd
-- 
2.47.3

