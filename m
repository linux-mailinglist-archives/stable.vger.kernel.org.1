Return-Path: <stable+bounces-215118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLytF3/yiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:43:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A2110C4A
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED32D3079BA4
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7B125B2;
	Mon,  9 Feb 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SK71ir++"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C37C276028;
	Mon,  9 Feb 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647733; cv=none; b=OV427MSNwqL+SYAGom65W51IqohJePtBwfd6xoZdEJPqHqsyK8d25DjYqWg02Ne8hm+KTGcOVGrfPzSvQjC+CNFUNGAJ3HTku+tQVxetT9Qtt8V9+0PFFWQnuS23CxFVdYz7y/wPAJHaaxgRKahEFtovH88gtKtzjNuZ517oUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647733; c=relaxed/simple;
	bh=LQYkYjrP7VPerH0vXmIANYQQUO8vDMxkwyJ+ylqHKyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRNwgyN2AsdIKndpzrIsL9MCy2jHYpsrsApeygkl12ldh14bdnc5Z+QaMVSnqFRqE6YPUWrIVQjrG33P/o+mZ9aW/fizA6wVHzWdy0lg+/+glcHsSI52uDbcuG/AzjuI1DTz80xi5CaCqK35sCUbMOCqCdzRu5YeJs/tz8tXdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SK71ir++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F3BC19424;
	Mon,  9 Feb 2026 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647733;
	bh=LQYkYjrP7VPerH0vXmIANYQQUO8vDMxkwyJ+ylqHKyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SK71ir++bExSN6NPaW24KGLthNNZ8p7m4K2bWOophsxCINSlp20r6qNnORDCt3i7T
	 1ioxi1K25KSeyNjuuNdaUVZpcSd1rkxF0ip5uFUKLbdHICidVEviaSydh4wWOu+wbG
	 MEU5GTk/vony3EomUoHl9L/wtftOILloXxzr40Qw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH 6.12 013/113] rbd: check for EOD after exclusive lock is ensured to be held
Date: Mon,  9 Feb 2026 15:22:42 +0100
Message-ID: <20260209142310.688737133@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215118-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: E01A2110C4A
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit bd3884a204c3b507e6baa9a4091aa927f9af5404 upstream.

Similar to commit 870611e4877e ("rbd: get snapshot context after
exclusive lock is ensured to be held"), move the "beyond EOD" check
into the image request state machine so that it's performed after
exclusive lock is ensured to be held.  This avoids various race
conditions which can arise when the image is shrunk under I/O (in
practice, mostly readahead).  In one such scenario

    rbd_assert(objno < rbd_dev->object_map_size);

can be triggered if a close-to-EOD read gets queued right before the
shrink is initiated and the EOD check is performed against an outdated
mapping_size.  After the resize is done on the server side and exclusive
lock is (re)acquired bringing along the new (now shrunk) object map, the
read starts going through the state machine and rbd_obj_may_exist() gets
invoked on an object that is out of bounds of rbd_dev->object_map array.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c |   33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3495,11 +3495,29 @@ static void rbd_img_object_requests(stru
 	rbd_assert(!need_exclusive_lock(img_req) ||
 		   __rbd_is_lock_owner(rbd_dev));
 
-	if (rbd_img_is_write(img_req)) {
-		rbd_assert(!img_req->snapc);
+	if (test_bit(IMG_REQ_CHILD, &img_req->flags)) {
+		rbd_assert(!rbd_img_is_write(img_req));
+	} else {
+		struct request *rq = blk_mq_rq_from_pdu(img_req);
+		u64 off = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
+		u64 len = blk_rq_bytes(rq);
+		u64 mapping_size;
+
 		down_read(&rbd_dev->header_rwsem);
-		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		mapping_size = rbd_dev->mapping.size;
+		if (rbd_img_is_write(img_req)) {
+			rbd_assert(!img_req->snapc);
+			img_req->snapc =
+			    ceph_get_snap_context(rbd_dev->header.snapc);
+		}
 		up_read(&rbd_dev->header_rwsem);
+
+		if (unlikely(off + len > mapping_size)) {
+			rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)",
+				 off, len, mapping_size);
+			img_req->pending.result = -EIO;
+			return;
+		}
 	}
 
 	for_each_obj_request(img_req, obj_req) {
@@ -4725,7 +4743,6 @@ static void rbd_queue_workfn(struct work
 	struct request *rq = blk_mq_rq_from_pdu(img_request);
 	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
 	u64 length = blk_rq_bytes(rq);
-	u64 mapping_size;
 	int result;
 
 	/* Ignore/skip any zero-length requests */
@@ -4738,17 +4755,9 @@ static void rbd_queue_workfn(struct work
 	blk_mq_start_request(rq);
 
 	down_read(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
 	rbd_img_capture_header(img_request);
 	up_read(&rbd_dev->header_rwsem);
 
-	if (offset + length > mapping_size) {
-		rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
-			 length, mapping_size);
-		result = -EIO;
-		goto err_img_request;
-	}
-
 	dout("%s rbd_dev %p img_req %p %s %llu~%llu\n", __func__, rbd_dev,
 	     img_request, obj_op_name(op_type), offset, length);
 



