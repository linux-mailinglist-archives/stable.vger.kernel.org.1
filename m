Return-Path: <stable+bounces-267910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kqw+ErRXOmpB6gcAu9opvQ
	(envelope-from <stable+bounces-267910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:53:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911256B5F60
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:53:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=LVSpLGI8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267910-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267910-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43D33065906
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953FC36923F;
	Tue, 23 Jun 2026 09:50:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A790364028
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 09:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208207; cv=none; b=q0Y6Uc8IvkJKAQAWtM9iJcAXaIDBzw1zrGH9tdcqUpuNLCARh66U/6QU//kaxB5EsMo9J1K7DjS/XWKSkBrjRCLQBjsblzmIAKCBiiNdz2+6Y7GHstXcaMVeEhHUSq7v33hGEzQJscE0zZi68sB+ttgezUMHCf1yjo12w2WYRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208207; c=relaxed/simple;
	bh=GjqYyK2hVDn1WEv+LfV7QwaRoebxQ49H8BhODJuEJhc=;
	h=To:From:Subject:Message-Id:Date:Cc:Mime-Version:Content-Type; b=L5qwYjl3HmmhZUhpG/bdrAOzdjbovMFKWc9mnVY0d+YyIsS9EXbyVejhRqsad/K6SOMOhR0SnlEj/cDlfidTkpAw1DhKa2tSk98oDthNfPAYiAiVJKYYzYEzbPVKN05d+vzmv1Haa26yHFEizucNlWuQp6t+EASS/+Ix0qlEF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LVSpLGI8; arc=none smtp.client-ip=209.127.230.111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782208193; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=GAZyq8qnvXQ9uWpGNOBJpOeyhs4XJXzEVP5U6mNKgns=;
 b=LVSpLGI817egX/YhNqXL17WWXlwCFe5gVEq7u+9RNzW8EvfFc3X/DyUg6ztjl+Z6wE+yXr
 gByUqZJksZHyauKcpfO6r/x2TC0OWNoc9wIk7RGfPHwmScnVf93TcLXSHC8Mu+OWS1P0zI
 yCXMkjiMqb08M7hAUVR3wU6V1Cl0tjkF3gRIz59KMO/KZ6YnM0WzRpudzJn+s20pSFNrRq
 FYcgPUU4jqzCzwxdlI65fQlnvToXXvQVKjesWRH7NBlPtnXOTgGXP9O6mAHYB9N59pmLHV
 DaDdN+Hm7bBZCFMvWPn6MAVXA7iPMtlMHGAKOKOrtL+3n9qMvaaNYb2x412ecA==
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
From: "Zhu Jia" <zhujia.zj@bytedance.com>
Subject: [PATCH] ext4: cancel dirty accounting for folios without buffers
Message-Id: <20260623094947.7853-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Date: Tue, 23 Jun 2026 17:49:47 +0800
X-Lms-Return-Path: <lba+26a3a56bf+f7de73+vger.kernel.org+zhujia.zj@bytedance.com>
Cc: <libaokun@linux.alibaba.com>, <jack@suse.cz>, <ojaswin@linux.ibm.com>, 
	<ritesh.list@gmail.com>, <yi.zhang@huawei.com>, 
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Zhu Jia" <zhujia.zj@bytedance.com>, <stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-From: Zhu Jia <zhujia.zj@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267910-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhujia.zj@bytedance.com,m:stable@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,vger.kernel.org,bytedance.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bytedance.com:dkim,bytedance.com:email,bytedance.com:mid,bytedance.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 911256B5F60

Since commit cc5095747edf ("ext4: don't BUG if someone dirty pages
without asking ext4 first"), mpage_prepare_extent_to_map() handles dirty
folios without buffer heads by warning, clearing PG_dirty, and skipping
them. ext4 cannot write these folios because there are no buffer heads to
map and submit.

That recovery leaves dirty accounting behind: folio_clear_dirty() clears
PG_dirty but does not undo the accounting charged when the folio was
dirtied. We have seen this in production as Dirty/nr_dirty staying high
while Writeback/nr_writeback and device write IO stayed near zero, with
many writer tasks blocked in balance_dirty_pages() throttling. Thus the
warning-and-skip recovery can still become a dirty-throttle DoS.

Use folio_cancel_dirty() so dropping PG_dirty also cancels the dirty
accounting.

Fixes: cc5095747edf ("ext4: don't BUG if someone dirty pages without asking ext4 first")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Jia <zhujia.zj@bytedance.com>
---
 fs/ext4/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c2c2d6ac7f3d1..7ea280e70c06e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2715,7 +2715,13 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 */
 			if (!folio_buffers(folio)) {
 				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
-				folio_clear_dirty(folio);
+				/*
+				 * folio_cancel_dirty() pairs the dropped dirty
+				 * state with dirty accounting, but leaves stale
+				 * PAGECACHE_TAG_DIRTY/TOWRITE tags behind. Later
+				 * writeback may rescan this clean folio.
+				 */
+				folio_cancel_dirty(folio);
 				folio_unlock(folio);
 				continue;
 			}
-- 
2.20.1

