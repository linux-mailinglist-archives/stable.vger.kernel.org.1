Return-Path: <stable+bounces-227781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNDGFWvbvmnZfgMAu9opvQ
	(envelope-from <stable+bounces-227781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 18:54:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F802E69D3
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 18:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A79D3018095
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B1833BBCD;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn8hxWdj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1A326D65;
	Sat, 21 Mar 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115675; cv=none; b=GFq0Bec+oENeuPYqG3YEqgWQXAYK+rwoKQsRHZfpg9F6tcBUtNhUsmL5ulQiZHfwPpuPwcaDLHfIN7M4sqlfxQ98IIWTXdEtpLop8YS98y8QJRWbfdOY/d0GT9MO06GXlwQbQIrw86pnETHs5EiQoZSIvH+IIW1oVmr97SjGOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115675; c=relaxed/simple;
	bh=YoReG2ITY2y0HZje9C+bQfiynbTvb6Sk5IqZjXN4jgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcNkHdbgtFp0v0ZMv8raT06DCi6/lhnBnbNi1GFqkWUeEyKkMi/McWGaYjjyRL6/NhYRxsqnz0ab5btSBTbqpLbPLescyRWGVsuW3BOwaZVFsGakNtZwvTBeJvlGXbmN3YeXxT5IFlHfJArrAO+TCDkfMXQgyS+GDnYORkELhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn8hxWdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F0EC2BCAF;
	Sat, 21 Mar 2026 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774115675;
	bh=YoReG2ITY2y0HZje9C+bQfiynbTvb6Sk5IqZjXN4jgA=;
	h=From:To:Cc:Subject:Date:From;
	b=Wn8hxWdjY8nwvWguSRylu6QdUeIm950qxeCvN+XJLKNCFiGT1rvu2S3BS5RXw2cxt
	 Esz/AQ9kDq9aoqZS2gvlm/exy7gvh/sPZQYJmZLwErh98XF2l1RsLHDkI0Am6AeDtV
	 JF79+nbLaPdKFb+mn1AH21nzU/DA/fPW4L0XALHGz/6vJxNMRkCE7RaNZ6tyS1CxOY
	 fe4GrcRbccmK+BX5mC2TDQiN1yAcXHtY6AtKZM7AOe6ofrFZl07nsuJrlM4M2fc/Nt
	 pX3SCOAdu21ChF8POhoezaza/gcja1Matw0PGMPkd0Ez9SaxagAGL0AlFW4Ar+RSOk
	 cUCw7yXoHy9bw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] mm/damon/sysfs: fix memory leak and NULL dereference issues
Date: Sat, 21 Mar 2026 10:54:23 -0700
Message-ID: <20260321175427.86000-1-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-227781-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9F802E69D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_SYSFS can leak memory under allocation failure, and do NULL
pointer dereference when a privileged user make wrong sequences of
control.  Fix those.

Changes from v2
(https://lore.kernel.org/20260320163559.178101-1-objecting@objecting.org)
- Wordsmith second patch commit message.
- Add NULL dereference trigger steps on the commit messages.
- Collect the valid Reviewed-by: from SJ for the second patch.
- Rebased to latest mm-new.
Changes from v1
(https://lore.kernel.org/20260319155742.186627-1-objecting@objecting.org)
- Check kdamond->contexts->nr from damon_sysfs_handle_cmd()
- Collect Reviewed-by: from SJ for the first and the third patch.

Josh Law (3):
  mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx()
    failure
  mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
  mm/damon/sysfs: check contexts->nr in repeat_call_fn

 mm/damon/sysfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: 42bc5b563370622d688719aa248a4c861839373a
-- 
2.47.3

