Return-Path: <stable+bounces-262504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HW49I3JvKWp4WwMAu9opvQ
	(envelope-from <stable+bounces-262504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:06:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442266A186
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:06:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EIh1pLpT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262504-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262504-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92DEB338499B
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57DE4183A6;
	Wed, 10 Jun 2026 13:56:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA8411693;
	Wed, 10 Jun 2026 13:55:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099760; cv=none; b=QPiU+TUQHO1SZ2COeSnzj/GHotD2v1+ey96s+AQY1tDYTBTEbVS0T69eME4Z4pW6pC8E3IKsA+nFU69Qv4fzvR8jesfr6pOaSHaKpZCfMyFLqUvHX8YnpbjYX9ggSDQQDYY6Py9WyslUkJ288+eIqVVE+TL/ZQjbm0BsnDZIeXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099760; c=relaxed/simple;
	bh=TfsEZLUqDtwJmnCHv8HnBS3HJBzu8hi+ZTgLnYsJoZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUPEOWCqRq3Ebr+z+tJYy0wxQcs9iQEaF09b5W2G3aekbpe4nyXz8v6UortNS2vSLZDCa1nZolk1DIQCLAiKIdu/9ouS72rr85bYwGgYmf9sTPnOJYcepk0q+Ie3hr7+foepeonOCZJAMrGhUNnP69reJKYAGKupFht+35FoE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIh1pLpT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9F71F00899;
	Wed, 10 Jun 2026 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099758;
	bh=np27EpbpG+TlvGmhDpEg+i4zWgXnS+HKHhJxhydFuds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EIh1pLpT2Kntma9pyfpR4fjjgcl52ZD0EWa3Cz25JtupEDkZxy8Aja17UnCvyT+Pz
	 ny3Cri1QeNZb6hlymfZYRIqiZIJdBVDzg/HvDq8PDNAt2+sgTI74s+1QP/ceDS3JA1
	 ALdMpay/0c9/+Xkxxz0HygOZmYjmqJ9I27MNUCoS8SvF9eEl0u9b7p8bbZAun8IRp4
	 Q1U2bU+dXx8XyTvhbMckUINDlXcw9y50gaypzzgUS5UYxUVuIYYH3GczZRs/znh1g2
	 o7b/0dEs7SQWm6bcGkFIpmiWX3cAktuRBSuH5JDtDIAcanQxoIDIR4kwXaLKQVZrJo
	 Vr1fnszUF1n/A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 5/6] samples/damon/wsse: stop and free damon ctx when damon_call() fails
Date: Wed, 10 Jun 2026 06:55:43 -0700
Message-ID: <20260610135546.64943-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
References: <20260610135546.64943-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262504-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0442266A186

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
Signed-off-by: SeongJae Park <sj@kernel.org>
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

