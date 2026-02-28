Return-Path: <stable+bounces-220087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCMiLXcno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C241C4F20
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52B0930CEAE0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE033A03F;
	Sat, 28 Feb 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg1woAdy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6133A01E;
	Sat, 28 Feb 2026 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299980; cv=none; b=gzdh6lL1Tvc1wgfs6vV4GlwmphNnu6hJYKPUPvhL3ehGKFN9by14iJsPcmtE1O/CibZTblcBknTgBPHlDLM3HshoXnRyZ2RXk5Kj9qomVQs3DrYUkVXkfggBBhicdzQhnx0jpMHE7B/0LnIL+xrOMfDBRXCMdrXCMdyqd3zMiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299980; c=relaxed/simple;
	bh=RIczDaL9PYQP5+M+OkprKa3ruNJrkZtJ83omwcciUhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxO5kejmk+CPfAKl6JYOH2r6aOU5JBGjm50ljYErhl7xoLhwddnJx7lOQ0CILAtdfsb44UAROWyRwU8AqVmYdZ5qofN8kqiIB+5Bc/cCaRGi1MzSJriSA1SLKoNR2hu5Xx3xD/G0HtCpR4Qg3muntztbWnYa8xEOSx1ztOqSr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg1woAdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7915FC19425;
	Sat, 28 Feb 2026 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299980;
	bh=RIczDaL9PYQP5+M+OkprKa3ruNJrkZtJ83omwcciUhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg1woAdylgoVJCyZbzHNxHb4F7AoYeXfr6ESgJaXA9P+3S9vBkKlXDuF2ZwvD+rST
	 +n7GG9zthLTMBW4l7G+hR2ilcTkNHZnHtc4fsPC+BRVWPo0dejAkYufVcerkNdOV2i
	 ev98GnyhsohZx1IGWzOR6SUZC2AqGwHGFfPWPPI0Cql6OyLcP3K1Z16qtoIad9cfKe
	 ZrHqtK+AA4eQOO2dSAcEUNzl0BRTnI7Qn3QKz+cFbs7Bt28to0RqHX5KJ52hrnIa0Z
	 KoA5CD/QXBpp9JPgYgXisy8u0GLMVjuY47jliVv5ImxiJIIqBp7ExgidWEF3Rel8tR
	 l11+MdExfu/KA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sri Jayaramappa <sjayaram@akamai.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Ian Rogers <irogers@google.com>,
	Joshua Hunt <johunt@akamai.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 009/844] libsubcmd: Fix null intersection case in exclude_cmds()
Date: Sat, 28 Feb 2026 12:18:42 -0500
Message-ID: <20260228173244.1509663-10-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220087-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,akamai.com:email]
X-Rspamd-Queue-Id: 25C241C4F20
X-Rspamd-Action: no action

From: Sri Jayaramappa <sjayaram@akamai.com>

[ Upstream commit b6ee9b6e206b288921c14c906eebf4b32fe0c0d8 ]

When there is no exclusion occurring from the cmds list - for example -
cmds contains ["read-vdso32"] and excludes contains ["archive"] - the
main loop completes with ci == cj == 0. In the original code the loop
processing the remaining elements in the list was conditional:

    if (ci != cj) { ...}

So we end up in the assertion loop since ci < cmds->cnt and we
incorrectly try to assert the list elements to be NULL and fail with
the following error

   help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.

Fix this by moving the if (ci != cj) check inside of a broader loop.
If ci != cj, left shift the list elements, as before, and then
unconditionally advance the ci and cj indicies which also covers the
ci == cj case.

Fixes: 1fdf938168c4d26f ("perf tools: Fix use-after-free in help_unknown_cmd()")
Reviewed-by: Guilherme Amadio <amadio@gentoo.org>
Signed-off-by: Sri Jayaramappa <sjayaram@akamai.com>
Tested-by: Guilherme Amadio <amadio@gentoo.org>
Tested-by: Ian Rogers <irogers@google.com>
Cc: Joshua Hunt <johunt@akamai.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20251202213632.2873731-1-sjayaram@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/help.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index ddaeb4eb3e249..db94aa685b73b 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -97,11 +97,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 			ei++;
 		}
 	}
-	if (ci != cj) {
-		while (ci < cmds->cnt) {
-			cmds->names[cj++] = cmds->names[ci];
-			cmds->names[ci++] = NULL;
+	while (ci < cmds->cnt) {
+		if (ci != cj) {
+			cmds->names[cj] = cmds->names[ci];
+			cmds->names[ci] = NULL;
 		}
+		ci++;
+		cj++;
 	}
 	for (ci = cj; ci < cmds->cnt; ci++)
 		assert(cmds->names[ci] == NULL);
-- 
2.51.0


