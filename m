Return-Path: <stable+bounces-230732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJONJF8Ux2mWSgUAu9opvQ
	(envelope-from <stable+bounces-230732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:35:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267834C5AC
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F10A308BD7F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199F39280C;
	Fri, 27 Mar 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV3zfb8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BD3451C1;
	Fri, 27 Mar 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654403; cv=none; b=aYbqBs1NonuFDOX/yAyYB8bAXiwYahwZrE2obUsOLnomSnYme9SYKuxYh18mWaId9mUktzVChFqgSF0AljduLIMAtfTmD8RWo0Wt/3Q7Ryfl+CJHDEqv9mYefxUiA9FJj4Qe6T6+LqkfT2NXdTXRNam9kDIfcBWaVmzy5uqGZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654403; c=relaxed/simple;
	bh=dWCz2l4DePKMhhkdEk4cKnFnxgNxvWZ3jr/uvPfGnKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTVYYt4EDO/GFo4jtRKeS6zbmS5QDrVelabSyYbDhkIo7WDBEQNCJTakQakSqFwo+CpBBw8uM9Z3PYdL6Lt4FbXWZutS/mEClSB/7ibrj0vwaoCm9+XU+LZQaA2R49poRkBs1OJv6k0AqJgvZS/OWrHXr91Fmag52fBvD0NBA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV3zfb8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D254EC19423;
	Fri, 27 Mar 2026 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774654403;
	bh=dWCz2l4DePKMhhkdEk4cKnFnxgNxvWZ3jr/uvPfGnKk=;
	h=From:To:Cc:Subject:Date:From;
	b=aV3zfb8VQPsec1pWT3gMYdrkuEN7lNzJdgQFsiDX/Ne0FwTJgqGc5cSDY9C7gQIj9
	 PlUEfuYv3v6h7nJlkdYNNS6KV99+muIGgtYIfLY2xK6PcNEe2zl244eVVRJW1/+f1U
	 G5+Kh8983qoYEh79fc3+d8nO31o8mcPFWV7lyYHObNOw0Q2Bdhbzu3ApotV5wpI0xV
	 V5DRfegGjPi/ItdFohfT+zrUW66Scp8HdfH8UoRarG9gb6/oVNBdEoL7hMaUYnKH0d
	 QHxshrk+D/6oSPzmLB5LQ83QAeoABvoQXDKl4Pb6RQx1Qd8G0ym7xaZ3zVkJk5gwCe
	 pM6Squ/iQ6dXQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/core: fix damon_call()/damos_walk() vs kdmond exit race
Date: Fri, 27 Mar 2026 16:33:13 -0700
Message-ID: <20260327233319.3528-1-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230732-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3267834C5AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damon_call() and damos_walk() can leak memory and/or deadlock when they
race with kdamond terminations.  Fix those.

Changes from RFC v3
(https://lore.kernel.org/20260327142605.4834-1-sj@kernel.org)
- Drop RFC tag.
- Rebase to latest mm-new.
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
  mm/damon/core: fix damon_call() vs kdamond_fn() exit race
  mm/damon/core: fix damos_walk() vs kdamond_fn() exit race

 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 66 ++++++++++++++++++-------------------------
 2 files changed, 30 insertions(+), 38 deletions(-)


base-commit: 305aff97ab8306284a0aa85f9128403b50c89019
-- 
2.47.3

