Return-Path: <stable+bounces-235131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMMKGlyr1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:24:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0943C2E68
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B79831CEF88
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C439035C1B5;
	Wed,  8 Apr 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XN+w+XBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830432A3FD;
	Wed,  8 Apr 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674649; cv=none; b=GT/cFCuRPFZcq7WRkw7QO88E5AKkPIAwhm2FnRjCWxbkB48w1+nBBNlXa5uYMWu95YaSlq5V5dklND/958DK0AVKUEWeB+ig6ia5zWpfvDwo82irQD/04ccQ4lmzot1yRj372kljXgg1Eo7O6PbFhOVizj6Z8N9RL0AWwXKm+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674649; c=relaxed/simple;
	bh=y1pX/X7OCQIP/KEjEPAe/LIgSMxHpWncSRJ4aoj3CUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTpgHW0KEUgmGAFXM/CEVadWKXAxxn8Z0d9flGeEPKTICqkeH4mtOTxr1MlOa0AZ5Mp17NQcYb4ykji8pSz+p0pzi635svxuaBRvtUrAJetMQmHo/u0H9a6Xf1e2idUyEXfwTUPLdgo1OMcT0UHqT1Fr4DyZ613glCvhjkWBXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XN+w+XBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E6DC19421;
	Wed,  8 Apr 2026 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674649;
	bh=y1pX/X7OCQIP/KEjEPAe/LIgSMxHpWncSRJ4aoj3CUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XN+w+XBIKnLK141kJdMM06CasaPyWJALGKGZ/pxzKL8THIGuU/1iysvYxUPnH2GGj
	 Q0Fh3eR/3lAhuFD9PqCtSdcphcHXaNUst1+W9pnoIObA6Djk3R2DJ7aZ+YiKq0j90I
	 yW+E9LBt/vVDK89aMRQh2fQ+A3+zlGlqxe3rJhNs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qi Tang <tpluszz77@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 136/311] io_uring/rsrc: reject zero-length fixed buffer import
Date: Wed,  8 Apr 2026 20:02:16 +0200
Message-ID: <20260408175944.493368570@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235131-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,kernel.dk:email]
X-Rspamd-Queue-Id: BA0943C2E68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qi Tang <tpluszz77@gmail.com>

[ Upstream commit 111a12b422a8cfa93deabaef26fec48237163214 ]

validate_fixed_range() admits buf_addr at the exact end of the
registered region when len is zero, because the check uses strict
greater-than (buf_end > imu->ubuf + imu->len).  io_import_fixed()
then computes offset == imu->len, which causes the bvec skip logic
to advance past the last bio_vec entry and read bv_offset from
out-of-bounds slab memory.

Return early from io_import_fixed() when len is zero.  A zero-length
import has no data to transfer and should not walk the bvec array
at all.

  BUG: KASAN: slab-out-of-bounds in io_import_reg_buf+0x697/0x7f0
  Read of size 4 at addr ffff888002bcc254 by task poc/103
  Call Trace:
   io_import_reg_buf+0x697/0x7f0
   io_write_fixed+0xd9/0x250
   __io_issue_sqe+0xad/0x710
   io_issue_sqe+0x7d/0x1100
   io_submit_sqes+0x86a/0x23c0
   __do_sys_io_uring_enter+0xa98/0x1590
  Allocated by task 103:
  The buggy address is located 12 bytes to the right of
   allocated 584-byte region [ffff888002bcc000, ffff888002bcc248)

Fixes: 8622b20f23ed ("io_uring: add validate_fixed_range() for validate fixed buffer")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
Link: https://patch.msgid.link/20260329164936.240871-1-tpluszz77@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rsrc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 41c89f5c616da..81446f9649ae9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1084,6 +1084,10 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 		return ret;
 	if (!(imu->dir & (1 << ddir)))
 		return -EFAULT;
+	if (unlikely(!len)) {
+		iov_iter_bvec(iter, ddir, NULL, 0, 0);
+		return 0;
+	}
 
 	offset = buf_addr - imu->ubuf;
 
-- 
2.53.0




