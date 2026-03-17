Return-Path: <stable+bounces-225942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B7XGyNQuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:59:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE902AA4E8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C84F308C62D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ABE3C6612;
	Tue, 17 Mar 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CFufbgYX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948893C660D
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752118; cv=none; b=tlUGaxIM+gqqFj2q/0BJVjg8Sm/tFrSXJnS1JNc+SExct0e1j6ZJPAk4CFKBG6wrRf974jRPS8A44E/kpEEw7GdBTWfBUN+oEwRKOX95YF2+YgL27R4DPb7atwVkwuoH5ANcdcu0HdRfUDUWJen8LOfp2+IFOiNpFo7rcTh2Gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752118; c=relaxed/simple;
	bh=eDqSeOS3c5pB+ucblrGLNU8FdM37L53wsS3dMUWeVOk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DSLaoVhbLPmPExx8/riMKQ8OdRjiz4uGE2UZCDftRcCCx4EIApghXTGSFm1WTECFRW4GId7txkCxkxD+Fm2yniksk6H8Cof9jqeH2tUG0J/Wcs8uP343dZm6G13W5iJ5cPWpG8am57/zdofIzGhMb1B0hw+VVc7r9CP5EXLJVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CFufbgYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0022EC4CEF7;
	Tue, 17 Mar 2026 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752118;
	bh=eDqSeOS3c5pB+ucblrGLNU8FdM37L53wsS3dMUWeVOk=;
	h=Subject:To:Cc:From:Date:From;
	b=CFufbgYX45rpkg83bo4AHCt533zxjGFuLKjZ0CV9vDxMhouFqQaQxrSC7Tlq27KLz
	 Ys6D/X9mAXnTazQmlQ2g36K2OAaN23b8qv0OkFKa4Rk403I+t3gDSYco95fu+LaELh
	 /KauUe0hRubtubBVGgSqBZMhph+SvpSWS+LaGGqk=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: check if target buffer list is still legacy on" failed to apply to 6.1-stable tree
To: axboe@kernel.dk,keenanat2000@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:55:02 +0100
Message-ID: <2026031701-elsewhere-bulk-0f93@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225942-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.dk,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EE902AA4E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c2c185be5c85d37215397c8e8781abf0a69bec1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031701-elsewhere-bulk-0f93@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2c185be5c85d37215397c8e8781abf0a69bec1f Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 12 Mar 2026 08:59:25 -0600
Subject: [PATCH] io_uring/kbuf: check if target buffer list is still legacy on
 recycle

There's a gap between when the buffer was grabbed and when it
potentially gets recycled, where if the list is empty, someone could've
upgraded it to a ring provided type. This can happen if the request
is forced via io-wq. The legacy recycling is missing checking if the
buffer_list still exists, and if it's of the correct type. Add those
checks.

Cc: stable@vger.kernel.org
Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index dae5b4ab3819..e7f444953dfb 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -111,9 +111,18 @@ bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags)
 
 	buf = req->kbuf;
 	bl = io_buffer_get_list(ctx, buf->bgid);
-	list_add(&buf->list, &bl->buf_list);
-	bl->nbufs++;
+	/*
+	 * If the buffer list was upgraded to a ring-based one, or removed,
+	 * while the request was in-flight in io-wq, drop it.
+	 */
+	if (bl && !(bl->flags & IOBL_BUF_RING)) {
+		list_add(&buf->list, &bl->buf_list);
+		bl->nbufs++;
+	} else {
+		kfree(buf);
+	}
 	req->flags &= ~REQ_F_BUFFER_SELECTED;
+	req->kbuf = NULL;
 
 	io_ring_submit_unlock(ctx, issue_flags);
 	return true;


