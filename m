Return-Path: <stable+bounces-251701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE8HLmIADmp+5QUAu9opvQ
	(envelope-from <stable+bounces-251701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:41:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9A59700A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA4A1301023D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39473D75D3;
	Wed, 20 May 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0H5b+awv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5115E8B;
	Wed, 20 May 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298668; cv=none; b=GG8wXX0aBRYFAqgoC9ZHbbn3RmUG1baCe1uNw7o56k7VyZAumpKk643oiNhkdIYauDGL2OEpLb7E8QxBH+KCfwNhcDw6ACtWs0QxgTTaSncfSBi7r/tOkDIPo7oigAIWQ7HewRAsXCmn39kPrjkaITOTcHlH6Z8zoN6oHvQTQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298668; c=relaxed/simple;
	bh=jeYs/YBddoBJ52Rhw8sbwjCksDDgpYQa9/bOx4+nMRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs6ajlYavsHeU8LQq2x1/ccBBDi9ueaAh/LvKOMWtHM5Uu5CPC4l8iyi8jDAT6bhdLVPbqzsinxG9SKNp2yDJ3Z0FBskktcNJskythNkc7tKuzBSR2VCSiseMK0VgEwAZdb9Bfs5g6vw5Fn0KP7vR9X75XonEIiQ2FxGSHxn7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0H5b+awv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0C41F000E9;
	Wed, 20 May 2026 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298666;
	bh=DeGLIornzc4FzLeA3F4gNluMliXw1PL0v4JewZqIcJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0H5b+awv0sqlN1pBcq8bcNUqWd082iin3DWZ4VKR2r8DXCTt6Lo3BCZBc4UNwVZDg
	 0V4G28i3xlOd/Tc0N8SdlJmsHjPBcKHxiMBwZ70U3rKsvwq4QR5ca/gXw39n0x2ocY
	 mgZ9oTNKqNmOt1T0nnjEvhl2vb0iATgNJeEbwGvQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 499/957] perf trace: Avoid an ERR_PTR in syscall_stats
Date: Wed, 20 May 2026 18:16:22 +0200
Message-ID: <20260520162145.347079999@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251701-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DBF9A59700A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit d05073adda0f047e9b2115a2932bcb2797eab238 ]

hashmap__new may return an ERR_PTR and previously this would be
assigned to syscall_stats meaning all use of syscall_stats needs to
test for NULL (uninitialized) or an ERR_PTR. Given the only reason
hashmap__new can fail is ENOMEM, just use NULL to indicate the
allocation failure and avoid the code having to test for NULL and
IS_ERR.

Fixes: 96f202eab813 (perf trace: Fix IS_ERR() vs NULL check bug)
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-trace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1f0b9ba3cdc15..96efe1fba8547 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1565,7 +1565,9 @@ static bool syscall_id_equal(long key1, long key2, void *ctx __maybe_unused)
 
 static struct hashmap *alloc_syscall_stats(void)
 {
-	return hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
+	struct hashmap *result = hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
+
+	return IS_ERR(result) ? NULL : result;
 }
 
 static void delete_syscall_stats(struct hashmap *syscall_stats)
@@ -1573,7 +1575,7 @@ static void delete_syscall_stats(struct hashmap *syscall_stats)
 	struct hashmap_entry *pos;
 	size_t bkt;
 
-	if (IS_ERR(syscall_stats))
+	if (!syscall_stats)
 		return;
 
 	hashmap__for_each_entry(syscall_stats, pos, bkt)
@@ -1589,7 +1591,7 @@ static struct thread_trace *thread_trace__new(struct trace *trace)
 		ttrace->files.max = -1;
 		if (trace->summary) {
 			ttrace->syscall_stats = alloc_syscall_stats();
-			if (IS_ERR(ttrace->syscall_stats))
+			if (!ttrace->syscall_stats)
 				zfree(&ttrace);
 		}
 	}
@@ -4441,7 +4443,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	if (trace->summary_mode == SUMMARY__BY_TOTAL && !trace->summary_bpf) {
 		trace->syscall_stats = alloc_syscall_stats();
-		if (IS_ERR(trace->syscall_stats))
+		if (!trace->syscall_stats)
 			goto out_delete_evlist;
 	}
 
@@ -4749,7 +4751,7 @@ static int trace__replay(struct trace *trace)
 
 	if (trace->summary_mode == SUMMARY__BY_TOTAL) {
 		trace->syscall_stats = alloc_syscall_stats();
-		if (IS_ERR(trace->syscall_stats))
+		if (!trace->syscall_stats)
 			goto out;
 	}
 
-- 
2.53.0




