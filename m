Return-Path: <stable+bounces-240511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFA0LPg16mk+xAIAu9opvQ
	(envelope-from <stable+bounces-240511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 17:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BD0454196
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 17:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A5E930D25BD
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8B35CBD6;
	Thu, 23 Apr 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9++1bKZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF92BEC4E;
	Thu, 23 Apr 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956582; cv=none; b=j+tAzaBdN3J1WkZF9pO7e6kXOndvgbQ1yPW3X+nikA/eOjUpOchUPVLFouG00N1JlEtARC5f/h8A+NhR0HYRwx+Jkt8wW1B0u2x0/IVPG9nNv8KrcMF64VboehXopkxUOccWrkvAgRpo2VBUCy7HoRHkOT3g/v41ME4WxsitlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956582; c=relaxed/simple;
	bh=rQtJyg98FPKQTGRAUXuSfYXDH7AOf6p1ENCuefnOVK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4kPQud34+p++g4aJX0ILurlcLQ7CZq+SAGmJI5hf/hjd2CzmkMhOqN1IoAs3VC6FfcAko72npMefEjL9tQ6cgUjpIfjnip7iP2eUeIkBxlLEUnsByOMiRt2zSi/Yl+G6+mVQSJiGcN87qbKbfhcYPXVIcIG0kKg3ET9WKAXIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9++1bKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D6FC2BCAF;
	Thu, 23 Apr 2026 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776956582;
	bh=rQtJyg98FPKQTGRAUXuSfYXDH7AOf6p1ENCuefnOVK8=;
	h=From:To:Cc:Subject:Date:From;
	b=s9++1bKZIRQFMWLOYuaJsuL4IQQDmbqEmbx20BBr+2XLP36ZgEIDUA+1dQrUUALOm
	 Xup12QRFQ/4GBYsi2Pye3ObpCvg8lsOi66YlxwFJHaalagYQ7AC0t5lkhLBmHtauhP
	 PzPZREJdJbzgYgHp9/M88z55JDauXRC1h10GYZpjFGVuBwcs3iz1fGBMtH6VpT/Ji6
	 JffDgyRxI/KvdvvVyLnKn0vJ2ABb79MS3NmWevwQNgZUzVzFx7XOkWnbuRngbZ7x6L
	 EOBiY/+kSlzqC4WsErkL/NdNZWFB7fDbNyNSZXd3zXXm4tAzx630bUan5ruymYMVJ5
	 g9/ZVHGxQ3C7Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/sysfs-schemes: fix use-after-free for [memcg_]path
Date: Thu, 23 Apr 2026 08:02:50 -0700
Message-ID: <20260423150253.111520-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240511-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:server fail];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31BD0454196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reads of 'memcg_path' and 'path' files in DAMON sysfs interface could
race with their writes, results in use-after-free.  Fix those.

Changes from RFC
- rfc: https://lore.kernel.org/20260422144059.72000-1-sj@kernel.org
- Fix a typo in commit description.
- Drop RFC tag.
- Rebase to latest mm-hotfixes-unstable.
Changes from v2
- v2: https://lore.kernel.org/20260420125405.362137-1-qjx1298677004@gmail.com
- Split patch for individual fixes commits.
- Hand-off authorship to SJ, give Co-developed-by: to Junxi.
- Use mutex_trylock() instead of mutex_lock().
- Add RFC tag for Sashiko review round.
- Wordsmith commit messages.
Changes from v1
- v1: https://lore.kernel.org/20260420085332.178473-1-qjx1298677004@gmail.com
- Protect not only user-writes but also user-reads.

SeongJae Park (2):
  mm/damon/sysfs-schemes: protect memcg_path kfree() with
    damon_sysfs_lock
  mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock

 mm/damon/sysfs-schemes.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)


base-commit: 26232ccdfcc7029d92b633b01f5f22913ab72168
-- 
2.47.3

