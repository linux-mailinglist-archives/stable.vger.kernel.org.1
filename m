Return-Path: <stable+bounces-254719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOuXEoncF2oUTggAu9opvQ
	(envelope-from <stable+bounces-254719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A64975ED276
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFC7B30166A6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80AB31F996;
	Thu, 28 May 2026 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7YGmvms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0C314D16;
	Thu, 28 May 2026 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948676; cv=none; b=AbU5t1cIPG9QjYiPiWnhsI0sunyNgKa0+um06Rsa8y5q5whbc7nfXS0qXcUfQk9Pcb2qaQHwyA/9l3BHOlfwjl9vE0m6SLwatWJzIL5c2fJMT+r3Zk5bJJOafI0Go+Cly1T1FTLcucz/Rp9XRtG7RkcHs9svjDZjWqYrUrfHYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948676; c=relaxed/simple;
	bh=cnn1UsWuBUe6jsXDVoFy0owDkMb9xwrzX/LrGEh9ZLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ny1XefTb2pLWLOnr57wdJSUqmU8wsJhp/iD62SJqiWITh9LZsNsMHtCBr0Gvlpq68dZZXhh/imzJmvupX4vCiv4fbcv3B+fXavJbHZRFrIO3LfuHDnvS+Bvhy/bSOwj3utViIPVCb3aewPfGySyV//42ix9Jl3HFsaOlJxfaRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7YGmvms; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01831F000E9;
	Thu, 28 May 2026 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779948675;
	bh=uGuuTi3QEXHp4Ch0W1P8wvpFXg0lxffEiocLYQhFz+g=;
	h=From:To:Cc:Subject:Date;
	b=c7YGmvmsEqxOZKvXhcQeMe4CjW1iX6UE5jFAApLcOFOiTQnmFgSUyRi7fY9R82ipr
	 hDZavK8E3ZJE3cbHrNupUy8ZtHTKKhPE8zJM3KkGmVVNj+srGMENb57MEuIY6NmOaa
	 qNxQSC1HEanFz13tDhMHmcNNu+PX3/hdpSlaz27B9+XqeVB3z8pabCrV4bHqOAzx5k
	 GYBb2m6yNpjsZX1dUoVOcY9h5HTtXvrWbua+z3syZAM4LUQXbVDI+0jfvGTx3w6Z3x
	 jTntY1iWPSdO169TGCE0Ic6S3Z/EIwiarfHXcVa16KrUZsJLDotfhPrZOpp3vBpqPD
	 PvQoU51GprsmA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/{reclaim,lru_sort}: handle ctx allocation failures
Date: Wed, 27 May 2026 23:11:07 -0700
Message-ID: <20260528061110.2172-1-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254719-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A64975ED276
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_RECLAIM and DAMON_LRU_SORT could dereference NULL pointers if
their damon_ctx object allocations fail.  The bug is expected to happen
not frequently,, because the allocation is arguably too small to fail on
common setup.  But theoretically it is possible and the consequence is
bad.  Fix those.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260419014800.877-1-sj@kernel.org

SeongJae Park (2):
  mm/damon/reclaim: handle ctx allocation failure
  mm/damonn/lru_sort: handle ctx allocation failure

 mm/damon/lru_sort.c | 4 ++++
 mm/damon/reclaim.c  | 4 ++++
 2 files changed, 8 insertions(+)


base-commit: 3c18aac8c775b020a2c50e91051f106dc621ad3e
-- 
2.47.3

