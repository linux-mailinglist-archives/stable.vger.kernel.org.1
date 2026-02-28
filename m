Return-Path: <stable+bounces-220110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCd3GH0oo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 030C31C5017
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B23309ACA3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3F47DF8C;
	Sat, 28 Feb 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhh2TLTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F61346772;
	Sat, 28 Feb 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300021; cv=none; b=PZJPSJaYCSkEA5RPQeXJ33g4y+EiPu7pOvmtIvMzpg0BEriAUC3IEaquKx5oWdRw/UzD6I8dnF3OKvRUims797PA0/QjvRNcZJrBOkZo8l+ARJ+NozDQDB4Yg+iLnm9rZN9CcASAx85GO8nOV7+vWkneearCAlE3cIFmaE8Sbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300021; c=relaxed/simple;
	bh=zSBqITKXPk67SSan2baRsnOFT1Uv1ewpQLqTHOjYpk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVvPRyd1SNIKLLSAOgjAttznaAdzDSuuUk6NsjmQoYgLy/RK9wb4r/JRuO0hPNJ0ZK2EwYpOY1El4prPUHz/nlX1wh15/IXBWKKHaE5WWxPNISZqyOGKRRdfc6FmTO48zuxut39Af4IoTMLBoY7fPSK57kd6FGu1yaUtqofNi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhh2TLTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B88FC19425;
	Sat, 28 Feb 2026 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300021;
	bh=zSBqITKXPk67SSan2baRsnOFT1Uv1ewpQLqTHOjYpk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhh2TLTsnR7VFm3Nh5o7FVT/TBaWBLX/AURn4V4EmL4IrNA80+cF3Y9TJQPgF4M7u
	 hS59bPNI7alEU3FrZMemp4QsbJ45Jfg43oCeI/gCt30X5EnH3mFSpqoLMT/Zt06Ugm
	 jEp4j5XFvsfrylR8HrkZUO86UIhtxrpdPigMudsLpfuupqFIWhfzCwNjWkKvT4YM9J
	 mP5fXwah1rvRPLCAnzdzD1lMRJqexihi8N5y49HQ1dVvpi+VvDB22HytX+upR43yNz
	 JVQq2RPk2OgFdv78ToOg2ikLyjHZVBk6dgzuOYE0SWqy5mEYvZx33kChaFCPl6YuVM
	 K57wYj01JgwYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 032/844] io_uring: add IORING_OP_URING_CMD128 to opcode checks
Date: Sat, 28 Feb 2026 12:19:05 -0500
Message-ID: <20260228173244.1509663-33-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220110-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email,purestorage.com:email]
X-Rspamd-Queue-Id: 030C31C5017
X-Rspamd-Action: no action

From: Caleb Sander Mateos <csander@purestorage.com>

[ Upstream commit 42a6bd57ee9f930a72c26f863c72f666d6ed9ea5 ]

io_should_commit(), io_uring_classic_poll(), and io_do_iopoll() compare
struct io_kiocb's opcode against IORING_OP_URING_CMD to implement
special treatment for uring_cmds. The recently added opcode
IORING_OP_URING_CMD128 is meant to be equivalent to IORING_OP_URING_CMD,
so treat it the same way in these functions.

Fixes: 1cba30bf9fdd ("io_uring: add support for IORING_SETUP_SQE_MIXED")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.h | 6 ++++++
 io_uring/kbuf.c     | 2 +-
 io_uring/rw.c       | 4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index a790c16854d32..0f096f44d34bf 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -595,6 +595,12 @@ static inline bool io_file_can_poll(struct io_kiocb *req)
 	return false;
 }
 
+static inline bool io_is_uring_cmd(const struct io_kiocb *req)
+{
+	return req->opcode == IORING_OP_URING_CMD ||
+	       req->opcode == IORING_OP_URING_CMD128;
+}
+
 static inline ktime_t io_get_time(struct io_ring_ctx *ctx)
 {
 	if (ctx->clockid == CLOCK_MONOTONIC)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 67d4fe576473a..dae5b4ab3819c 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -171,7 +171,7 @@ static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
 		return true;
 
 	/* uring_cmd commits kbuf upfront, no need to auto-commit */
-	if (!io_file_can_poll(req) && req->opcode != IORING_OP_URING_CMD)
+	if (!io_file_can_poll(req) && !io_is_uring_cmd(req))
 		return true;
 	return false;
 }
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 28555bc85ba0f..01367ac09531a 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1253,7 +1253,7 @@ static int io_uring_classic_poll(struct io_kiocb *req, struct io_comp_batch *iob
 {
 	struct file *file = req->file;
 
-	if (req->opcode == IORING_OP_URING_CMD) {
+	if (io_is_uring_cmd(req)) {
 		struct io_uring_cmd *ioucmd;
 
 		ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
@@ -1376,7 +1376,7 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 			break;
 		nr_events++;
 		req->cqe.flags = io_put_kbuf(req, req->cqe.res, NULL);
-		if (req->opcode != IORING_OP_URING_CMD)
+		if (!io_is_uring_cmd(req))
 			io_req_rw_cleanup(req, 0);
 	}
 	if (unlikely(!nr_events))
-- 
2.51.0


