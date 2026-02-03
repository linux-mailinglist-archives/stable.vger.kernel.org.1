Return-Path: <stable+bounces-213294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAudABM2gmmVQgMAu9opvQ
	(envelope-from <stable+bounces-213294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:53:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69378DD288
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677BB30D7C0B
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A4631B100;
	Tue,  3 Feb 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfmATMS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC530DD1C
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141075; cv=none; b=jy/2hp3CiKflx2VQ7h7wkIZlHbZidNiMXUuGfIQGk948A5xrLHLixFE9cWhrelhdVXbn6BKYu+7U4CgRyiF/1MRToOyQq6bhGZi0owqhFBKWevqH03NPmqIpIUSui2wSE4C5JjFuzx7xOpeTnqMjlilMxZu+UDQxapB8uqYI560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141075; c=relaxed/simple;
	bh=pKqUhlLuCVmDgflJ53Ki+Dx5KCURS3Z1Od62WaoGW1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA2Zdot1a2bri1AJ1PC5etwG0Vm6pdBqmqLTp19mkSxdKEeEGD1wEhG1Wy2MjyGsz3HOnHgaFzL9lrcL6w45QRHM58GCK61k5Ui7198eTyDe2pJyQmdZWW3JPOIA3kPC9cs22dTEI37ccBUM194qyfRv1qEpQ+d0vyUUCDoY1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfmATMS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BF7C116D0;
	Tue,  3 Feb 2026 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141074;
	bh=pKqUhlLuCVmDgflJ53Ki+Dx5KCURS3Z1Od62WaoGW1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfmATMS0T5wCICYrwuj7KOTYVbrIgwpcN7AcVB/0Api4KY0d/Z+CK2UargkUNnoJ9
	 D8w5upxnnXa/wO8QbVXehEaKHP3ZyBATwblzzGHbenWfy5R+gZWQalTXvSfMsSRv1O
	 BL1GuiAxIAAxGYON9EKsXo5YQ6gCShbfr8hqrrWQCAb0U26ynqpAS/KHQinJbRdXqT
	 EAWyoFSk67u0oOx77LpUDeN9bUWYf59CIxM8x5E6eCo2jKncR3oiEBv5Ea/VmOZ42b
	 5rzI5MDWX7iczgKJJSpxpKf6u+DT/SbSR2df4qIw3yjA77RKJblfNs3D7ExeaiGNTI
	 09sJ6EGRYAKCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] perf: Simplify get_perf_callchain() user logic
Date: Tue,  3 Feb 2026 12:51:11 -0500
Message-ID: <20260203175112.1341936-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020313-shone-sister-6db5@gregkh>
References: <2026020313-shone-sister-6db5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213294-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: 69378DD288
X-Rspamd-Action: no action

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit d77e3319e31098a6cb97b7ce4e71ba676e327fd7 ]

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250820180428.760066227@kernel.org
Stable-dep-of: 76ed27608f7d ("perf: sched: Fix perf crash with new is_user_task() helper")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/callchain.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 677901f456a94..012a2c9a9babe 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,21 +246,19 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				regs = NULL;
-			else
-				regs = task_pt_regs(current);
+				goto exit_put;
+			regs = task_pt_regs(current);
 		}
 
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			start_entry_idx = entry->nr;
-			perf_callchain_user(&ctx, regs);
-			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-		}
+		start_entry_idx = entry->nr;
+		perf_callchain_user(&ctx, regs);
+		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
 
+exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.51.0


