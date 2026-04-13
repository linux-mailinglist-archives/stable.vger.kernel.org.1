Return-Path: <stable+bounces-237504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL4uLIgi3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E2A3F0BB5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49714305CCD1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194933C188;
	Mon, 13 Apr 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u+AYIeH7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845ED3382FA;
	Mon, 13 Apr 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099625; cv=none; b=h4XECizhjcW7vG1hPmulj2+xLYH4IRjrpSdFbyuwATEmAeq86tehTwt8VrD2FIh6dSBp5r0Kjr6hni0ydpkqQ23VqheNyWpbgPrBR5qCDxpSvNpAExBbPm46ZQaL4AHCq6jEqC5syJhVDizKenGNVn+sGO7+sXxoa2Pxr4OqHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099625; c=relaxed/simple;
	bh=1taNT22CiamjziOB4a1Po72QXWOU6A4ZwrLQB0hS3bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlMSny/TcAskrMZp9lpx2H0JbQE2Zkh7GlZ4ZzCdChudg8zKRA7mcsg20pPihmdrxgs5N0k9FdvGdtyHyN1AUmdKcN5lusETLygI1Ehf+DmNAHHr1DpiDjpEKy3SusoXy5V23N5lvUi33hYg9bXIwHLhzqaap+KrMcPbUCgS+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u+AYIeH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A392C2BCAF;
	Mon, 13 Apr 2026 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099625;
	bh=1taNT22CiamjziOB4a1Po72QXWOU6A4ZwrLQB0hS3bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+AYIeH7//qxUKCIkxqREjbT+M/xsSPFGvKsPxdAVtd3yjC96i3aenTsP8QIfiCQa
	 +gYG+00bCj2+nMsxoTEFosoC7kcOhFf9fXEupFyfqWzAnI2KT8Ggvxf6NQkSmLeFh9
	 F6Ik9o4EPihEJ8N/Th4qgp0ve4YPTIquC9NTQLwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Robert Garcia <rob_garcia@163.com>
Subject: [PATCH 5.10 412/491] io_uring/tctx: work around xa_store() allocation error issue
Date: Mon, 13 Apr 2026 18:00:57 +0200
Message-ID: <20260413155834.453704310@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-237504-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,kernel.dk,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[stable,cc36d44ec9f368e443d3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 58E2A3F0BB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 7eb75ce7527129d7f1fee6951566af409a37a1c4 upstream.

syzbot triggered the following WARN_ON:

WARNING: CPU: 0 PID: 16 at io_uring/tctx.c:51 __io_uring_free+0xfa/0x140 io_uring/tctx.c:51

which is the

WARN_ON_ONCE(!xa_empty(&tctx->xa));

sanity check in __io_uring_free() when a io_uring_task is going through
its final put. The syzbot test case includes injecting memory allocation
failures, and it very much looks like xa_store() can fail one of its
memory allocations and end up with ->head being non-NULL even though no
entries exist in the xarray.

Until this issue gets sorted out, work around it by attempting to
iterate entries in our xarray, and WARN_ON_ONCE() if one is found.

Reported-by: syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com
Link: https://lore.kernel.org/io-uring/673c1643.050a0220.87769.0066.GAE@google.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Modify the function in io_uring.c because it's located here in v5.15. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -8524,8 +8524,19 @@ static int io_uring_alloc_task_context(s
 void __io_uring_free(struct task_struct *tsk)
 {
 	struct io_uring_task *tctx = tsk->io_uring;
+	struct io_tctx_node *node;
+	unsigned long index;
 
-	WARN_ON_ONCE(!xa_empty(&tctx->xa));
+	/*
+	 * Fault injection forcing allocation errors in the xa_store() path
+	 * can lead to xa_empty() returning false, even though no actual
+	 * node is stored in the xarray. Until that gets sorted out, attempt
+	 * an iteration here and warn if any entries are found.
+	 */
+	xa_for_each(&tctx->xa, index, node) {
+		WARN_ON_ONCE(1);
+		break;
+	}
 	WARN_ON_ONCE(tctx->io_wq);
 	WARN_ON_ONCE(tctx->cached_refs);
 



