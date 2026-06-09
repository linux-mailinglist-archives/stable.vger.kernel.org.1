Return-Path: <stable+bounces-262173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jujjEnyOJ2p/ywIAu9opvQ
	(envelope-from <stable+bounces-262173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 05:54:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DA65C203
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 05:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=fB9870Ws;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262173-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262173-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B268F303C422
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 03:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C443BFAF0;
	Tue,  9 Jun 2026 03:52:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6213BFE59
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 03:52:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977142; cv=none; b=CfYAFuNzH+3TCCJ6IKcC/YDbPxpNvwemKlADh409I4sZzi2hDkv9wi2kdmfecJFMmH9DHstkDKaQohBHzItdL4kpLhzhuJ0f7uKqS/39hwG4l1VNSbc/81XbSZ9uwgn/sE1kk9yQmsF+7WwYsXMjxtp+MIeAwjnjDdo0ghf6MRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977142; c=relaxed/simple;
	bh=plbZEdBsEVoiceLx354lAPpDb+2W2oYexV0z66OGR+g=;
	h=From:Message-Id:Date:Mime-Version:To:Subject:In-Reply-To:
	 References:Content-Type:Cc; b=kKJ5yZr8/34S2bLc4lszSpMatXDlSMb8OpoLcUwdkYdiCJmh7Fw5zol/cIuPBh1RTUJ9FtqTWzOcmB/Wa8IYBa+D3XCtQXocZL8braSRUBte3PJbSLlIRBVUlWT9bdnB4FWWP0ArLiWKBLHtIMNRaJygsjqag4RKNOEoIKePDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fB9870Ws; arc=none smtp.client-ip=209.127.231.112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780977133; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ljcX9HGQP8qScfeDL8/boo3qpaXpTglRdp4ziKmpebY=;
 b=fB9870WsFGiHhl09pn8nfA5qaJjAt8MDvnPMqd48I9gfnXjN05QcjfcrKNTO7z/NNb8Vhv
 /pdh7/4gKNQ6RlWClYQI3XqWvG8E2Do5euK+QMkGMapFh/FJzvEFkfzlojE6FsCahFMgKO
 BMZif3R0afQq8s3DJvWoz8xP78yM4k4vMKpF/SSmTj4k1L44no6S7/Z4AnCTQbp7TRqJGD
 Gw77lFA8aWwPp/I10qIsfmydy/MkkdODxZQsdPSr4xi/xt+XEhot6zEJ9yoafvgxP+AbPo
 3e6WU+vt9R5UCAkaSm1Bmnr043u0rqcLLYlP0Uybj/EiSLDQrjDcCSx+bUeMXw==
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Message-Id: <20260609035202.90669-2-zhujia.zj@bytedance.com>
Date: Tue,  9 Jun 2026 11:52:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a278deb+c7b3ab+vger.kernel.org+zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
To: "Theodore Ts'o" <tytso@mit.edu>, 
	"Andreas Dilger" <adilger.kernel@dilger.ca>
Subject: [PATCH v3 1/2] fs/buffer: avoid tail commit walk for uptodate folios
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260609035202.90669-1-zhujia.zj@bytedance.com>
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
References: <20260609035202.90669-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Matthew Wilcox" <willy@infradead.org>, 
	"Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, 
	"Baokun Li" <libaokun@linux.alibaba.com>, 
	"Ojaswin Mujoo" <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani" <ritesh.list@gmail.com>, 
	"Zhang Yi" <yi.zhang@huawei.com>, <linux-ext4@vger.kernel.org>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Jia Zhu" <zhujia.zj@bytedance.com>, <stable@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262173-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:willy@infradead.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:libaokun@linux.alibaba.com,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhujia.zj@bytedance.com,m:stable@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,zeniv.linux.org.uk,kernel.org,suse.cz,linux.alibaba.com,linux.ibm.com,gmail.com,huawei.com,vger.kernel.org,bytedance.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,bytedance.com:dkim,bytedance.com:email,bytedance.com:mid,bytedance.com:from_mime,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F5DA65C203

block_commit_write() always walks every buffer_head attached to the
folio.  That was cheap for order-0 folios, but large folios can contain
hundreds of buffer_heads.  For a small buffered overwrite of an
already-uptodate large folio, the commit work is therefore proportional
to the folio size rather than the copied range.

This became visible with ext4 regular-file large folios, where cached
small overwrites reach block_commit_write() through block_write_end().
Before ext4 enabled large folios for regular files, this path was only
hit with order-0 folios for normal ext4 buffered writes, so the full walk
was bounded.  The ext4 large-folio commit is therefore the regression
point for this generic helper cost.

The full walk is still needed when the folio is not uptodate, because
block_commit_write() uses per-buffer uptodate state to decide whether
the whole folio can be marked uptodate.  Keep those folios on the old
full-buffer path.

For a folio that was already uptodate on entry, the commit no longer
needs tail buffers for folio-uptodate discovery.  The copied range has
already been processed once block_start reaches @to, so stop there and
avoid the suffix walk.

Fixes: 7ac67301e82f0 ("ext4: enable large folio for regular file")
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org # v6.16+
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index b0b3792b1496e..c8c41c799030d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2096,6 +2096,7 @@ void block_commit_write(struct folio *folio, size_t from, size_t to)
 {
 	size_t block_start, block_end;
 	bool partial = false;
+	bool uptodate = folio_test_uptodate(folio);
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
 
@@ -2118,6 +2119,8 @@ void block_commit_write(struct folio *folio, size_t from, size_t to)
 			clear_buffer_new(bh);
 
 		block_start = block_end;
+		if (uptodate && block_start >= to)
+			break;
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-- 
2.20.1

