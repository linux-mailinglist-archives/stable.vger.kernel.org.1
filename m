Return-Path: <stable+bounces-244911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CIGBNa2/mlxvQAAu9opvQ
	(envelope-from <stable+bounces-244911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 06:23:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8609B4FE0CE
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 06:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04279301F483
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 04:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8B318EDC;
	Sat,  9 May 2026 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L/Jgi5+b"
X-Original-To: stable@vger.kernel.org
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39181E8320
	for <stable@vger.kernel.org>; Sat,  9 May 2026 04:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778300625; cv=none; b=Xsbczgt/0qNoUflfNrpDq6XzwcFlYCntmFEZwjVt9PzKt7ZgWgMO/L0emnCil/h7TOzN5V0kpTwgv7d6921Tlj0DghP8o+ixebrMmq5ut5LW3LHPKA8NH09ZBHke2AuywApuMWqj+uGo6W3N3CC6R3/5x8H2i44UJx3iluxQC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778300625; c=relaxed/simple;
	bh=sXVUgUiexe6pW0yV/m2bxYF4BP+fyNnZvw0G86FXGfI=;
	h=Content-Type:To:From:Message-Id:Subject:Cc:Date:Mime-Version; b=kCOz4KMzPn9a+4eho0eAw+/Sian8LkZTdmxl4vzzNarwQ3HI7p6zXiBdyuTj/OQP3/RLxAy2hg8n1J1dinP9DJg0b8McLQK3sfAuSkSDvCLtI3SLDe2TFd55Xwitnz+arwqy+vQd7LOHThJoYhqGMrUu/gw/jrB2ssR24eZBfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L/Jgi5+b; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778300611; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=GV7P7vEAFPZuslqOmWnT2zTRNsZaE/E9s732MHBL+jQ=;
 b=L/Jgi5+bSeOqh529AAi3HY2zCg1DokWA8JPVyrQLGed5HoXxh+YSZ8B2Z4gOJJIVxWCFJ0
 m9bd5QSxEopvyZ1BTSimiRDss19HLpJSRGL2nTYdaTCf/ln+pGDwS7E8stT6sGX9Lhme20
 bO4LUTwYop77NIkRswa3X0TVDk9wVxUkgxRQ06E3MNJj73viEymIZXlJwoMVS24r77m1lC
 wlQQCDa8IGO6V+u7eCHg1YXm13avUQtAfCy6bB4ocoDViMSbJdu+D7dIkQ3TWZfdXFNJMM
 G2kJmaRsHOOyQM9mPzUfcgQObvuqjTrruiyFhHJuh+h5i5jbCakoaICmMyi67g==
X-Lms-Return-Path: <lba+269feb6c1+6aef85+vger.kernel.org+yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <axboe@kernel.dk>, <dhowells@redhat.com>
From: "Xin Yin" <yinxin.x@bytedance.com>
Message-Id: <20260509040119.1116544-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.20.1
Subject: [PATCH] block: fix pages array leak in bio_map_user_iov error path
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Xin Yin" <yinxin.x@bytedance.com>, <stable@vger.kernel.org>
Date: Sat,  9 May 2026 12:01:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: Xin Yin <yinxin.x@bytedance.com>
X-Rspamd-Queue-Id: 8609B4FE0CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yinxin.x@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Action: no action

In bio_map_user_iov(), when iov_iter_extract_pages() is called with pages
set to NULL (because nr_vecs > UIO_FASTIOV), want_pages_array() internally
allocates a pages array via kvmalloc_array(). If iov_iter_extract_pages()
subsequently returns bytes <= 0 (e.g., due to pin_user_pages_fast()
failure), the code jumps to out_unmap without freeing the dynamically
allocated pages array, causing a memory leak detectable by kmemleak.

This can be triggered from userspace by issuing an SG_IO v4 ioctl on a
bsg device with a large din_xfer_len and an invalid din_xferp (mapped
PROT_NONE), which causes pin_user_pages_fast() to fail after the pages
array has already been allocated by want_pages_array().

The kmemleak backtrace looks like:

  unreferenced object 0xffff... (size 2048):
    backtrace (crc 0):
      kvmalloc_node+0x...
      want_pages_array+0x...
      iov_iter_extract_pages+0x...
      bio_map_user_iov+0x...
      blk_rq_map_user_iov+0x...
      blk_rq_map_user+0x...
      bsg_transport_sg_io_fn+0x...

Fix this by freeing the dynamically allocated pages array (when it
differs from the on-stack stack_pages) before jumping to the error path.

Fixes: 403b6fb8dac1 ("block: convert bio_map_user_iov to use iov_iter_extract_pages")
Cc: stable@vger.kernel.org # 6.5+
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 block/blk-map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-map.c b/block/blk-map.c
index 0aadbaf7a9ddd..5b9f14caad4f9 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -304,6 +304,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
 					       nr_vecs, extraction_flags, &offs);
 		if (unlikely(bytes <= 0)) {
+			if (pages != stack_pages)
+				kvfree(pages);
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
 		}
-- 
2.20.1

