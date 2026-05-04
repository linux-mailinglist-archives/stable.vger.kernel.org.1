Return-Path: <stable+bounces-243410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDoIH3ar+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 878834BF30A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63A5C3040C3C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168F3AA4F8;
	Mon,  4 May 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2nUzs+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358671ADC83;
	Mon,  4 May 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903812; cv=none; b=s70h8iTeZZidf99IB/eAV2r2rRx9l83S1a+sgAx5gqj0C6u9J/Osbuh1+8/O3lhZHgMQzp1TYsUphmlKIoVJEOEaie0PmJgLJVgOPPe8UV+yK5IkO48uPeIqiS4l+Rupnbj2Onq9QVEOK+LUJY+SSDsWHdZDVexri3aCvrvgeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903812; c=relaxed/simple;
	bh=sqiL1+RUGlSpCFHQihuCA5iBHoN9V9akAUTrwyZ+vFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/eARkVGib8TD6K1D6a5oMLvI3gFr4NzlMZminN7JpI7w4isWMwzUaxE0SjYAhYw8DZ3oVZmyA8zN6+P6btpNXmlGioq/2YPBDamGKI33BQ7+YD1g5/KP+fNbIvSGhFUb7DdUyfyGr7ihWYnpEOBKyV0RFGYRQWQD/cHvjXlPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2nUzs+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E02C2BCB8;
	Mon,  4 May 2026 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903812;
	bh=sqiL1+RUGlSpCFHQihuCA5iBHoN9V9akAUTrwyZ+vFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2nUzs+o0b7GeFYmji73wEeV5FW1uVNIojPDb0q5iSGAigqqIMNzvpJICAh+FoYZu
	 XUAaf1Q8B3/eSdeCuERHaFIBrSi5TfqziuYx1rYpb7k66oSS0n2wwIKvhmMEnMsxdJ
	 ZTb3hp7xEIaA40E7gdC9YYNzsT6t6wEFOYwt8wt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 071/275] io_uring/register: fix ring resizing with mixed/large SQEs/CQEs
Date: Mon,  4 May 2026 15:50:11 +0200
Message-ID: <20260504135145.566940476@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 878834BF30A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243410-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 45cd95763e198d74d369ede43aef0b1955b8dea4 upstream.

The ring resizing only properly handles "normal" sized SQEs or CQEs, if
there are pending entries around a resize. This normally should not be
the case, but the code is supposed to handle this regardless.

For the mixed SQE/CQE cases, the current copying works fine as they
are indexed in the same way. Each half is just copied separately. But
for fixed large SQEs and CQEs, the iteration and copy need to take that
into account.

Cc: stable@kernel.org
Fixes: 79cfe9e59c2a ("io_uring/register: add IORING_REGISTER_RESIZE_RINGS")
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/register.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -514,10 +514,20 @@ static int io_register_resize_rings(stru
 	if (tail - old_head > p.sq_entries)
 		goto overflow;
 	for (i = old_head; i < tail; i++) {
-		unsigned src_head = i & (ctx->sq_entries - 1);
-		unsigned dst_head = i & (p.sq_entries - 1);
+		unsigned index, dst_mask, src_mask;
+		size_t sq_size;
 
-		n.sq_sqes[dst_head] = o.sq_sqes[src_head];
+		index = i;
+		sq_size = sizeof(struct io_uring_sqe);
+		src_mask = ctx->sq_entries - 1;
+		dst_mask = p.sq_entries - 1;
+		if (ctx->flags & IORING_SETUP_SQE128) {
+			index <<= 1;
+			sq_size <<= 1;
+			src_mask = (ctx->sq_entries << 1) - 1;
+			dst_mask = (p.sq_entries << 1) - 1;
+		}
+		memcpy(&n.sq_sqes[index & dst_mask], &o.sq_sqes[index & src_mask], sq_size);
 	}
 	WRITE_ONCE(n.rings->sq.head, old_head);
 	WRITE_ONCE(n.rings->sq.tail, tail);
@@ -534,10 +544,20 @@ overflow:
 		goto out;
 	}
 	for (i = old_head; i < tail; i++) {
-		unsigned src_head = i & (ctx->cq_entries - 1);
-		unsigned dst_head = i & (p.cq_entries - 1);
+		unsigned index, dst_mask, src_mask;
+		size_t cq_size;
 
-		n.rings->cqes[dst_head] = o.rings->cqes[src_head];
+		index = i;
+		cq_size = sizeof(struct io_uring_cqe);
+		src_mask = ctx->cq_entries - 1;
+		dst_mask = p.cq_entries - 1;
+		if (ctx->flags & IORING_SETUP_CQE32) {
+			index <<= 1;
+			cq_size <<= 1;
+			src_mask = (ctx->cq_entries << 1) - 1;
+			dst_mask = (p.cq_entries << 1) - 1;
+		}
+		memcpy(&n.rings->cqes[index & dst_mask], &o.rings->cqes[index & src_mask], cq_size);
 	}
 	WRITE_ONCE(n.rings->cq.head, old_head);
 	WRITE_ONCE(n.rings->cq.tail, tail);



