Return-Path: <stable+bounces-237591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJa6KSEo3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:30:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CCC3F17D7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E01E314CE4E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BEC3382FA;
	Mon, 13 Apr 2026 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2x3q/op"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929B333429;
	Mon, 13 Apr 2026 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099852; cv=none; b=ObAXqEeVdO9BzATUszDQ/wRASdKbELLRYijcImyBcqsfuUCM3ULU675+0veoVI2pBMvArD2vG0JjTHH+mOSgD+ndz+era1Szv4AoDSdJRLfebazuy5/YHAMDwiQP3Tz/UJtKDoBwCee+Q0WYazvVZZlX5SHaYcMt8qZZyIIOB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099852; c=relaxed/simple;
	bh=BIRhHfCzeUOQvPswg5nABstbmXbXWyUFvMBtMQpxBGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcoLjgLdcD4GY1T4OZLJfiMnM92zLVuW41HZ7h4RT4BeijzomoyP9dWfIKzHEIqmIoxmvFUJkTWFZOLUVT9w+LdFj7otUN3Bm44oFIDVPJpMIjadECnW/j7dfMvFDaskfHZSruf+CSRzWxv+h+9aDrd9eu68sH/tEAoHDEgi5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2x3q/op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA639C2BCAF;
	Mon, 13 Apr 2026 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099852;
	bh=BIRhHfCzeUOQvPswg5nABstbmXbXWyUFvMBtMQpxBGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2x3q/op3tHwbopkoFoJGZ1MfYaZQs7iJOISWKBPaUS3GrHcgG1dKyUdXAnbbt4fX
	 Jxf1XAY+6I1z7HWUvEhmZPgNGAYdUk4OZ6eaJjm2MwNnprmBjZ/WOwfue00iXT60w7
	 I3gg/YWpixccFLg4wjUgq0GrvsaOapKFNeTdYVkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 491/491] io_uring/poll: correctly handle io_poll_add() return value on update
Date: Mon, 13 Apr 2026 18:02:16 +0200
Message-ID: <20260413155837.438151458@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237591-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E5CCC3F17D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 84230ad2d2afbf0c44c32967e525c0ad92e26b4e upstream.

When the core of io_uring was updated to handle completions
consistently and with fixed return codes, the POLL_REMOVE opcode
with updates got slightly broken. If a POLL_ADD is pending and
then POLL_REMOVE is used to update the events of that request, if that
update causes the POLL_ADD to now trigger, then that completion is lost
and a CQE is never posted.

Additionally, ensure that if an update does cause an existing POLL_ADD
to complete, that the completion value isn't always overwritten with
-ECANCELED. For that case, whatever io_poll_add() set the value to
should just be retained.

Cc: stable@vger.kernel.org
Fixes: 97b388d70b53 ("io_uring: handle completions in the core")
Reported-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
Tested-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5980,7 +5980,7 @@ static int io_poll_add_prep(struct io_ki
 	return 0;
 }
 
-static int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
+static int __io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_poll_iocb *poll = &req->poll;
 	struct io_poll_table ipt;
@@ -5992,11 +5992,21 @@ static int io_poll_add(struct io_kiocb *
 	if (!ret && ipt.error)
 		req_set_fail(req);
 	ret = ret ?: ipt.error;
-	if (ret)
+	if (ret > 0) {
 		__io_req_complete(req, issue_flags, ret, 0);
+		return ret;
+	}
 	return 0;
 }
 
+static int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
+{
+	int ret;
+
+	ret = __io_poll_add(req, issue_flags);
+	return ret < 0 ? ret : 0;
+}
+
 static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -6012,6 +6022,7 @@ static int io_poll_update(struct io_kioc
 		ret = preq ? -EALREADY : -ENOENT;
 		goto out;
 	}
+	preq->result = -ECANCELED;
 	spin_unlock(&ctx->completion_lock);
 
 	if (req->poll_update.update_events || req->poll_update.update_user_data) {
@@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
 		if (req->poll_update.update_user_data)
 			preq->user_data = req->poll_update.new_user_data;
 
-		ret2 = io_poll_add(preq, issue_flags);
+		ret2 = __io_poll_add(preq, issue_flags);
 		/* successfully updated, don't complete poll request */
 		if (!ret2)
 			goto out;
+		preq->result = ret2;
+
 	}
-	req_set_fail(preq);
-	io_req_complete(preq, -ECANCELED);
+	if (preq->result < 0)
+		req_set_fail(preq);
+	io_req_complete(preq, preq->result);
 out:
-	if (ret < 0)
-		req_set_fail(req);
 	/* complete update request, we're done with it */
 	io_req_complete(req, ret);
 	io_ring_submit_unlock(ctx, !(issue_flags & IO_URING_F_NONBLOCK));



