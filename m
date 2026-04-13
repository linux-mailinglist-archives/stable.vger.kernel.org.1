Return-Path: <stable+bounces-237089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DRJOZUk3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:15:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC273F10DA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9532330ED32B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5CB3161BF;
	Mon, 13 Apr 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJz62Dzp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED4313550;
	Mon, 13 Apr 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098556; cv=none; b=boPYs0AY+vD/OjXEya/P/86ymipUt3OIearQ3Ciyr0LoZ9Gmsx0b+ylUY85s0KDL3eS8XooLB4qGD3U5OGndH6qoKQQLOgqYE1RTPDHI4250QD7ked4B+7u2XVEwIr3aew3FuspzQzTyahf6tlSHcKdedpa8yDj56DYgcLKAcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098556; c=relaxed/simple;
	bh=YDmgKjvJoEOs9zuRrPei2HvIK/L7xlAadDY987LCfL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtA5jTS2fh6xvTRnNw+1NLT9bm/sPoJhAYhN7ApwiErD/xHNG6anZ/CqSTILq5jvBee7tc7f+L6CUr5D8IvsMOETQqfe/B1QYnDPsI/iGvorB+ZXudFD9Xbk2/T8yuG40y2iv+rJbZwspR9l51Uk2w0IZuL5TybGTx9dnazGfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yJz62Dzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC375C2BCB0;
	Mon, 13 Apr 2026 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098556;
	bh=YDmgKjvJoEOs9zuRrPei2HvIK/L7xlAadDY987LCfL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yJz62DzpDIVWyBBNPlHB6NHi3FnsRzoCtv4DIrBlTRG1n/rveYsUfWOJFQVs6zEZT
	 sfyGYyDXtpIWJtRDZ02KOY30emgopYEmzYGBaSXXFPDMsu/dJcRMCC+SGNNYuq34AO
	 6dD4WAphNDZEk8hbCuSwXUUtSlJP9WB1Kg1oI86Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 570/570] io_uring/poll: correctly handle io_poll_add() return value on update
Date: Mon, 13 Apr 2026 18:01:41 +0200
Message-ID: <20260413155851.831023445@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237089-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 9BC273F10DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6127,7 +6127,7 @@ static int io_poll_add_prep(struct io_ki
 	return 0;
 }
 
-static int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
+static int __io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_poll_iocb *poll = &req->poll;
 	struct io_poll_table ipt;
@@ -6139,11 +6139,21 @@ static int io_poll_add(struct io_kiocb *
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
@@ -6159,6 +6169,7 @@ static int io_poll_update(struct io_kioc
 		ret = preq ? -EALREADY : -ENOENT;
 		goto out;
 	}
+	preq->result = -ECANCELED;
 	spin_unlock(&ctx->completion_lock);
 
 	if (req->poll_update.update_events || req->poll_update.update_user_data) {
@@ -6171,16 +6182,17 @@ static int io_poll_update(struct io_kioc
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



