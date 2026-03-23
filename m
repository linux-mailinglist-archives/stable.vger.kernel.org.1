Return-Path: <stable+bounces-227920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMGAIEz/wGmiPQQAu9opvQ
	(envelope-from <stable+bounces-227920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:52:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513D2EE7AE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 793B1300668A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E238239E;
	Mon, 23 Mar 2026 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="lE4VlWy6"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD6366DC4;
	Mon, 23 Mar 2026 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255944; cv=none; b=g27CgGckY0v+Ag4Hwui9j1bGzH1LEHmYrdtmSckAsLwN1NJaSdazoPHPIGiiHoxhoWJkx1oi6Yx4k8p4zOeanS8OhaP3oytmDtH3a+Idru+V2va0CDImtw9tyaMLxaXtVIJoZtKY93uh5OQm5hhyhyTit1pis6+rIripwGw4sVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255944; c=relaxed/simple;
	bh=0wg1x6yH4B6ulhzrnDXeX2xcLVQWtuyo6J/6tVMYvh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMDa81viWZOhwls0w2pQJt7EhzhycdqFWOFL72ywBkMKm6pDI+OMwi6UC7SjwZrWFYZOJo8ulaXcMSXe6X5D/oQDYMQvVGcHmaXdtDIqC1tsRkx97uIbTBtD+AHkWKGzHtVGEpmhp4rVx0Yab3Ax94svLfQhyjTYJh8mCG34Hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=lE4VlWy6; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1774255936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYIKaq6RqMCVMjkTrPjv9Za1ry2XEuhSkXIBu8VGE+g=;
	b=lE4VlWy6ymbdvjugYdmL0BsXmqJ1Ea0QASXrHEV83UiKMkcLAbZEDUL5EJYr+YO2U1l0u0
	JQX2CKDjENkTbHDuEC2f3V/Y7RibpJ3Ulx5t/JeIkGTYejSjRDj33LG7lon7YyW0fA+Cq+
	xp9SkEbRh6AFvQoBm40NLjWqxkCp0XM=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
Subject: [PATCH 6.1] erofs: Fix the slab-out-of-bounds in drop_buffers()
Date: Mon, 23 Mar 2026 11:52:14 +0300
Message-ID: <20260323085216.7965-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[swemel.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[swemel.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227920-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[swemel.ru:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arefev@swemel.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,5b886a2e03529dbcef81];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,swemel.ru:dkim,swemel.ru:email,swemel.ru:mid]
X-Rspamd-Queue-Id: 1513D2EE7AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

No upstream commit exists for this patch.

Syzbot reported that a KASAN slab-out-of-bounds bug was discovered in
the drop_buffers() function [1].

The root cause is that erofs_raw_access_aops does not define .release_folio
and .invalidate_folio. When using iomap-based operations, folio->private
may contain iomap-specific data rather than buffer_heads. Without special
handlers, the kernel may fall back to generic functions (such as 
drop_buffers), which incorrectly treat folio->private as a list of
buffer_head structures, leading to incorrect memory interpretation and
out-of-bounds access.

Fix this by explicitly setting .release_folio and .invalidate_folio to the
values of iomap_release_folio and iomap_invalidate_folio, respectively.

[1] https://syzkaller.appspot.com/x/report.txt?x=12e5a142580000 

Fixes: 7479c505b4ab ("fs: Convert iomap_readpage to iomap_read_folio")
Reported-by: syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/erofs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 7b648bec61fd..302e824827fc 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -406,6 +406,8 @@ const struct address_space_operations erofs_raw_access_aops = {
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
 	.direct_IO = noop_direct_IO,
+	.release_folio = iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 };
 
 #ifdef CONFIG_FS_DAX
-- 
2.43.0


