Return-Path: <stable+bounces-269593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Xi+Bp2YQWrbsQkAu9opvQ
	(envelope-from <stable+bounces-269593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 23:56:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7959E6D50CA
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 23:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KIKOrHyB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269593-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269593-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDEE3033A92
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052873BAD9F;
	Sun, 28 Jun 2026 21:54:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4E3B9920;
	Sun, 28 Jun 2026 21:54:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683696; cv=none; b=dZ6560dJe6g7zEvEkFW7gatcE3ycS72W+i1l4duiLFAPgxmLIrbwUMb/YBG8WEmWyzt5ywpJ2ma04ogL0lAAZ0Z1nORnuLlVnxKPiPG4c33pwukIrbiFsDwYLGy3jLawDOWtkvNgKNk8UmoBzvOiEnQYdqEbLC0o+oN+eNPD4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683696; c=relaxed/simple;
	bh=Jw2oTQLhBHZGvZ350628faSMeulnsQF9NZJ4Pgd/Ll0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wvx0p5EnCxIqUzA3P8NtEOkZe5cRWnEyhhHF8JH18kYE3t85wIvjk3+QJBlrO2tr+VBW9g6nBu3Ubw4KHfnGdgsFc2L1tONAQAHrm6lcZdDbWd8OMQRXy7uwyaC4zGfsqGZUlrMji127tWDh2lYTWTx5xT/qqknukjkIx/MVr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIKOrHyB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195A61F00A3D;
	Sun, 28 Jun 2026 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683695;
	bh=0zk+m+sDW42nDojjPEG5tIM5jKTMmO4VQ//ftyAMI5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KIKOrHyBpox31ZVRgjjA3zukl1E6KLrTpfKB3z5CmMQQlGES4cPmTkgBTV+W+abaE
	 Yn3oPDhTvoexdatR0KdXmseFdWlErL5/gHW16OWxy3y+a3NYWcBub0xVFUhcL0R0Dz
	 YeLssf3oBdUFjmvmqMmCgLB+dr2Vn3mHyoJ/H8j+7uQoE9raMZNoQSxeK6xjizFAaG
	 mBK8gQHJaV6/LLpbDvZLqtRdC9qPHFWdDSv7FVdC+BE6l1s6fk2nN5qNTUF7461Gmi
	 CiVhScCKTtnDN28u4GPlXmrORxZ+MzyRjsrJZf9nw6Ew9nKOH3Fd9URF+2F4+IqITO
	 065ExZ5yeHuvQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 5/6] samples/damon/wsse: stop and free damon ctx when damon_call() fails
Date: Sun, 28 Jun 2026 14:54:44 -0700
Message-ID: <20260628215447.96166-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628215447.96166-1-sj@kernel.org>
References: <20260628215447.96166-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:sj@kernel.org,m:stable@vger.kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:zenghui.yu@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269593-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7959E6D50CA

damon_sample_wsse_start() calls damon_call() right after damon_start()
is succeeded.  The kdamond that has started by the damon_start() could
be terminated by itself before or in the middle of the damon_call()
execution. There could be multiple reasons for such a stop including
monitoring target process termination and kdamond_fn() internal memory
allocation failures.  In the case, damon_call() will fail and return an
error without cleaning up the DAMON context object.  The
damon_sample_wsse_start() caller assumes it would clean up the object,
though.  When the user requests to start DAMON again,
damon_sample_wsse_start() is called again, allocates a new DAMON context
object and overwrites the pointer for the previous object.  As a result,
the previous context object is leaked.

Safely stop the kdamond and deallocate the context object when the
failure is returned.  Note that the kdamond should be stopped first,
because damon_call() failure means not complete termination of the
kdamond but only the fact that the termination process has started.

The user impact shouldn't be that significant because the race is not
easy to happen, and only up to one DAMON context object can be leaked
per race.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260610034828.4632-1-sj@kernel.org

Fixes: cc9c1b8c205b ("samples/damon/wsse: use damon_call() repeat mode instead of damon_callback")
Cc: <stable@vger.kernel.org> # 6.17.x
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/wsse.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index bbd9392ab5b36..ff5e8a890f448 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -92,7 +92,12 @@ static int damon_sample_wsse_start(void)
 		return err;
 	}
 	repeat_call_control.data = ctx;
-	return damon_call(ctx, &repeat_call_control);
+	err = damon_call(ctx, &repeat_call_control);
+	if (err) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	return err;
 }
 
 static void damon_sample_wsse_stop(void)
-- 
2.47.3

