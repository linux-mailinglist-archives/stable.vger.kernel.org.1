Return-Path: <stable+bounces-262395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eZSzCdG7KGpLIwMAu9opvQ
	(envelope-from <stable+bounces-262395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:20:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B2D6652C2
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:20:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RlHD8R2t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262395-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262395-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54BD313A964
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F3B23E35F;
	Wed, 10 Jun 2026 01:14:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E8233934;
	Wed, 10 Jun 2026 01:14:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054070; cv=none; b=RWsOFWjSXcLRxStSWnp+5dXCqccbODRxzQOEHF2CK7SFiTzJbJ/6e4aYAM2tE+5AoarNLOr6q4UpR828bCyr9eUN2UmsVY5uDEAJwZxkCCHnFooFIcO86zZRY0Dhyz2RWWNui/1Cbvhg7vG0ftkoEjux8+pJUpXQDEqUFOqqZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054070; c=relaxed/simple;
	bh=MUhLH4KjnWf280jQwEAPII5VPYmn2Z+FNONeKmftcSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzW/iqN0UxI2j7D8HyqpuEqCY6SK+n31RcifBZZLmQ2A/9mftJZUqRDL8o5i7PZ8hYJBrot7lu8+iGnkf5vNfcSxyNrXpbCAUJBh5YbXycC6DNHFeOJH256ElnYc4/1OeZfubYPh8ah0NiyafIsVoqGMiZXjTcuAD1MzzAXxli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlHD8R2t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4101F00899;
	Wed, 10 Jun 2026 01:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054069;
	bh=Pb0n/eJX1vGIeSAU0z6olfpVOoRIiAMjbL+eNzYDAJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RlHD8R2tmPn4c+ph6TQwiYaWFXdVRwLlvgGWj9DDOSP38PEXQP4YCZ85EF+s9T0fc
	 kxU1mYxcmac/7lxca5ZVA92AiS8souEpHcb712bJVI6f+5/nqJaz8hSWt9rwsbOcRz
	 xUfOlrMOaV5V8wOjJz7+hmaoHNP4gmAB3DMZGgaAsfqhSPCdbqL5x1JHEOXRhdQqvQ
	 E3iy0LwpVWW8L5pa+YPy5yBFjW6FlhDh04HTskfayNOuRwGcFhUCvqd2k6bsgoE6rQ
	 Bqd577ewXcupCac58o/T5bSVr1sh/pyNl3khldS7tKGQx/BZzYXvs272lgyHWPbA/P
	 3HqYRVid37o2A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 1/4] samples/damon/wsse: handle damon_start() failure
Date: Tue,  9 Jun 2026 18:14:14 -0700
Message-ID: <20260610011420.3018-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610011420.3018-1-sj@kernel.org>
References: <20260610011420.3018-1-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-262395-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63B2D6652C2

damon_sample_wsse_start() callers assume it will clean up resources when
it fails.  And the function does the cleanup for context buildup
failures.  However, it is not doing the cleanup for damon_start()
failure.  As a result, when damon_start() fails, it leaks the memory for
DAMON context.  Free the context in case of the failure to fix the
issues.

Note that the issue can reliably be reproduced because the module calls
damon_start() in the exclusive mode.  For example,

    $ sudo damo start
    $ echo $$ | sudo tee /sys/module/damon_sample_wsse/parameters/target_pid
    $ echo Y | sudo tee /sys/module/damon_sample_wsse/parameters/enabled
    $ sudo cat /proc/allocinfo | grep damon_new_ctx

Because the first command is running another DAMON instance, the third
command fails the damon_start() call because the new DAMON instance
cannot exclusively run.  And without this fix, by repeating the third
and the fourth commands above, we can show the memory consumption is
only increasing due to the leaks.  It requires the sudo permission
though.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260609145814.70163-1-sj@kernel.org

Fixes: b757c6cfc696 ("samples/damon/wsse: start and stop DAMON as the user requests")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 799ad44439434..bbd9392ab5b36 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -87,8 +87,10 @@ static int damon_sample_wsse_start(void)
 	target->pid = target_pidp;
 
 	err = damon_start(&ctx, 1, true);
-	if (err)
+	if (err) {
+		damon_destroy_ctx(ctx);
 		return err;
+	}
 	repeat_call_control.data = ctx;
 	return damon_call(ctx, &repeat_call_control);
 }
-- 
2.47.3

