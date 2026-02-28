Return-Path: <stable+bounces-220867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G+VHjpao2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:12:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D971C8D94
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 831CD346B96B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A841E5C6;
	Sat, 28 Feb 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2NiN0V3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A741E5BB;
	Sat, 28 Feb 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300752; cv=none; b=Dx40WllK6FHbXKaPVDczQqGamN2TKuo0lvU0w/wune5cdAlMEwHiuqXKbUseFcHG4Dun9GvMx2OQi8XkC0CfB9darq6Aq70JbDLfCBD4eFwhKcNY6OGUGqoSwITZLEGIcnLuCsyOvYAU8pi3S8yDA45MNb/3gGRcN3bCE+mA6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300752; c=relaxed/simple;
	bh=b42WEZw7ILAb0uLleni0IDk7v/nd9K5I8bG6AzqTbbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfhngrl8KLi5gO/oJZZY3Ra7cF6/5qydhHSNmtPY9gX7AFJ6y+xY5v1FnrsQ17siXGSwlDYBW3r7DOqw4rE2O7YyJrHW3It1PpTOjGAphJn2QhWWEMc2awm9FuI19R7bt79y8leAAaXFrxa5rDDWsA2lATYDUAElwewzFFm/Vf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2NiN0V3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C0C2BC87;
	Sat, 28 Feb 2026 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300751;
	bh=b42WEZw7ILAb0uLleni0IDk7v/nd9K5I8bG6AzqTbbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2NiN0V3eVIrKuyjKEED3DhLyKhe+6uCC7H8UurWUaLh0ERSEDzha1sOYQE+S71Hl
	 +hVR1siX01ImghCRwB3wjXHnWfRAfGbFOWpoLnhAyM2tPlPk/D5Xk6MhqnZwlElobv
	 9Sc4voXSYev1DJodKwtqccUEsC+JASk6e0eplfJHFhbi5KFbE/c+FJVLsabgNwxO7r
	 DvO2sZo++ie4kvcwU6JasMczI98e7N5ZKbPJNkZ98hbaHXUmXGNr4J+jqRvUHp+fEN
	 j+2wAe1vxdT/WQZIbzWHtDimu1Z/bQgz2HyaUT6iCzRHZ4ZSYYf6/L5rom2knkGH7n
	 qCFFVXEp/IGyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 788/844] io_uring/openclose: fix io_pipe_fixed() slot tracking for specific slots
Date: Sat, 28 Feb 2026 12:31:41 -0500
Message-ID: <20260228173244.1509663-789-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220867-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: D1D971C8D94
X-Rspamd-Action: no action

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit f4d0668b38d8784f33a9a36c72ed5d0078247538 ]

__io_fixed_fd_install() returns 0 on success for non-alloc mode
(specific slot), not the slot index. io_pipe_fixed() used this return
value directly as the slot index in fds[], which can cause the reported
values returned via copy_to_user() to be incorrect, or the error path
operating on the incorrect direct descriptor.

Fix by computing the actual 0-based slot index (slot - 1) for specific
slot mode, while preserving the existing behavior for auto-alloc mode
where __io_fixed_fd_install() already returns the allocated index.

Cc: stable@vger.kernel.org
Fixes: 53db8a71ecb4 ("io_uring: add support for IORING_OP_PIPE")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/openclose.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 15dde9bd6ff67..606ce0664e6a4 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -336,31 +336,34 @@ static int io_pipe_fixed(struct io_kiocb *req, struct file **files,
 {
 	struct io_pipe *p = io_kiocb_to_cmd(req, struct io_pipe);
 	struct io_ring_ctx *ctx = req->ctx;
+	bool alloc_slot;
 	int ret, fds[2] = { -1, -1 };
 	int slot = p->file_slot;
 
 	if (p->flags & O_CLOEXEC)
 		return -EINVAL;
 
+	alloc_slot = slot == IORING_FILE_INDEX_ALLOC;
+
 	io_ring_submit_lock(ctx, issue_flags);
 
 	ret = __io_fixed_fd_install(ctx, files[0], slot);
 	if (ret < 0)
 		goto err;
-	fds[0] = ret;
+	fds[0] = alloc_slot ? ret : slot - 1;
 	files[0] = NULL;
 
 	/*
 	 * If a specific slot is given, next one will be used for
 	 * the write side.
 	 */
-	if (slot != IORING_FILE_INDEX_ALLOC)
+	if (!alloc_slot)
 		slot++;
 
 	ret = __io_fixed_fd_install(ctx, files[1], slot);
 	if (ret < 0)
 		goto err;
-	fds[1] = ret;
+	fds[1] = alloc_slot ? ret : slot - 1;
 	files[1] = NULL;
 
 	io_ring_submit_unlock(ctx, issue_flags);
-- 
2.51.0


