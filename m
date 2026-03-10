Return-Path: <stable+bounces-223950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKrKDu38r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B8824A287
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 674593172BA3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F22BF3E2;
	Tue, 10 Mar 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S79+sxWx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618B2D978B;
	Tue, 10 Mar 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141085; cv=none; b=eqwp3cJUwAxf8xh9JT++uPwy46iLg9URWeukF4a7vrzsYawXs6QDRkwjC4tQTEJqim48zEaQ8yPBY+9prkzAMM1lgcwi0rI7zBAaW2DLT7Px9S2LwcrnPaG2/uk4wJdcqeXOvqAvI8nUySwdlttQ222nLt5yleIb9VVxeg0LcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141085; c=relaxed/simple;
	bh=jv3DMAA1XSNq7jOGbr+9p4jBfDcw8FyLJGNaG9LewBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGaTGam2xb/9yf9kIjCB8nAmpM7CHZ89KJVZhBxNeyTx2KXho0/fOM6dhMfDOzV198DWv+cjL79iLqO6tKR+eR4ozQlxBnWcrigh3AoY0ZzExP0lh5PSocIS+hfJNowrruxQ4O/S94DbbBkUDVnZtlLD/XXT6+/3mlrEaZlQ5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S79+sxWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516EAC2BCB3;
	Tue, 10 Mar 2026 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141084;
	bh=jv3DMAA1XSNq7jOGbr+9p4jBfDcw8FyLJGNaG9LewBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S79+sxWxA4Fwsglxb6GALxckShz8IAv4O4w1MQwEHwl5LxM/tr5JlgwyzCFLGMFxX
	 UhADoQ6x9ig3mrm6khbpPSc2gJHPAmhgM2yYBS40lSpxgkAfbBoLTf+65QOr96Mj2d
	 AWwxQqSaiGOtsf1mkzExGLhkMIOD0qPR4ZfqIQjwP5sqfFFJzhjguz6qEnrt2NKxD5
	 Sp7WnagAlNS7OdSpqN0cDE12auTL6fhxJJXKzRz3UDjIYgu9+w3SKq3MWjVrszFe2E
	 sBt+1Qq0IyJTpobWgi4Oo/x71qD777JhLh6ReK1lqruLiL0Ay/mK4lqOxRnG4qXNTQ
	 Lw/eIH88bV56g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 085/311] sched_ext: Fix SCX_EFLAG_INITIALIZED being a no-op flag
Date: Tue, 10 Mar 2026 07:02:12 -0400
Message-ID: <ea789c90acd08e97a3ec71189a0e825498435eb5.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0B8824A287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223950-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 749989b2d90ddc7dd253ad3b11a77cf882721acf ]

SCX_EFLAG_INITIALIZED is the sole member of enum scx_exit_flags with no
explicit value, so the compiler assigns it 0. This makes the bitwise OR
in scx_ops_init() a no-op:

    sch->exit_info->flags |= SCX_EFLAG_INITIALIZED; /* |= 0 */

As a result, BPF schedulers cannot distinguish whether ops.init()
completed successfully by inspecting exit_info->flags.

Assign the value 1LLU << 0 so the flag is actually set.

Fixes: f3aec2adce8d ("sched_ext: Add SCX_EFLAG_INITIALIZED to indicate successful ops.init()")
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 386c677e4c9a0..11ebb744d8931 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -74,7 +74,7 @@ enum scx_exit_flags {
 	 * info communication. The following flag indicates whether ops.init()
 	 * finished successfully.
 	 */
-	SCX_EFLAG_INITIALIZED,
+	SCX_EFLAG_INITIALIZED   = 1LLU << 0,
 };
 
 /*
-- 
2.51.0


