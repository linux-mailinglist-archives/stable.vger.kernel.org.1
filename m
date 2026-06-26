Return-Path: <stable+bounces-268794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FpdxAoNPPmoQDQkAu9opvQ
	(envelope-from <stable+bounces-268794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:08:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EA6CBEE5
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:08:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=b306XkxQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268794-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268794-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA8EB3013A5F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBAC3EBF13;
	Fri, 26 Jun 2026 10:07:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA053E0088
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:07:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468472; cv=none; b=IB2GGOWfgsh0Fqgz4o9NaA6tIul2NUczLKfs4zCEnFyrWRiO5OuEfWmtRNfNtW/4iWsHYxiYwqWbJ+a1BXJiNOFy0xVlM4ArAlBhS8SIZ2YHq7Jo298ExIJ4S6rpxzq+vHtft1RL0r3v1nMLQ527vjHMEhE5mMOvKm0B9j6Pnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468472; c=relaxed/simple;
	bh=496daIy9Oynkrnkj9PQ6+RVEEu0Tbv+Ca2uKBtp295I=;
	h=Cc:From:Subject:Date:Content-Type:Mime-Version:To:Message-Id; b=o5Q/FSgwEc8QJNprVdB5e6c6HI1d6pui4Reqx7ONBs5F2jdK3pWyLuFIlHjkngbvXvKYFXjV5lgfAAb/goJRkQvjWcsUqh1Nt9dAmQnBKzKtVkxatlQGRdpBF24vyxnHvhwQHDlI6f7lyKLv8Lsj28wyuTRPw5aysEiSGx2H9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b306XkxQ; arc=none smtp.client-ip=209.127.230.112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782468466; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wbsYFv/aAybDSG7qH0hXOfSoTmIEui7F1AIt3Vyenn8=;
 b=b306XkxQJFxtsg5iQm1zrJtSr57z67MfuUEKzyizS3JsdlZzPLThnji7TCZkxKYXXIXPSS
 cbN5TFK074TwnLA+BFs8ytl0xlrx1l8stgiLSenWJvr+TPwDRl496cC+6r5+lYaQfgfwwv
 aEZXbK/SkB4BnrPbSR4tf5KRNK95MgudaibejLrvNqz0TLHoszT+gdQGB2ghnkPayrPoub
 TI6kRaFiv9t0QW+7wM5OTZtFRCbpsn5FUP8tezIptw7vPBbjf7S4qzdn4JYx+eXTrJtyUa
 octFUSFhuhlGv7WNEo51mrhJwxDjsHn6/LRIsueeTwcv/ZNop1TW8D8/uV3heg==
Cc: <libaokun@linux.alibaba.com>, <jack@suse.cz>, <ojaswin@linux.ibm.com>, 
	<ritesh.list@gmail.com>, <yi.zhang@huawei.com>, 
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Zhu Jia" <zhujia.zj@bytedance.com>, <stable@vger.kernel.org>, 
	"Zhang Yi" <yizhang089@gmail.com>
From: "Zhu Jia" <zhujia.zj@bytedance.com>
Subject: [PATCH v2] ext4: cancel dirty accounting for folios without buffers
Date: Fri, 26 Jun 2026 18:07:40 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a3e4f70+67c9c1+vger.kernel.org+zhujia.zj@bytedance.com>
X-Original-From: Zhu Jia <zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
Message-Id: <20260626100740.52455-1-zhujia.zj@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268794-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:libaokun@linux.alibaba.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhujia.zj@bytedance.com,m:stable@vger.kernel.org,m:yizhang089@gmail.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,vger.kernel.org,bytedance.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 745EA6CBEE5

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
accounting. Then cycle the folio through writeback state so the generic
writeback helpers update the xarray DIRTY/TOWRITE tags.

Fixes: cc5095747edf ("ext4: don't BUG if someone dirty pages without asking ext4 first")
Cc: stable@vger.kernel.org
Suggested-by: Zhang Yi <yizhang089@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhu Jia <zhujia.zj@bytedance.com>
---
Changes since v1:
- After folio_cancel_dirty(), cycle the folio through writeback state so
  generic writeback helpers update PAGECACHE_TAG_DIRTY/TOWRITE, as
  suggested by Yi and Jan.

 fs/ext4/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c2c2d6ac7f3d1..4c25dcd47fb15 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2715,7 +2715,15 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 */
 			if (!folio_buffers(folio)) {
 				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
-				folio_clear_dirty(folio);
+				/*
+				 * folio_cancel_dirty() pairs the dropped dirty
+				 * state with dirty accounting. Cycle through
+				 * writeback state so the generic writeback
+				 * helpers update the xarray tags.
+				 */
+				folio_cancel_dirty(folio);
+				folio_start_writeback(folio);
+				folio_end_writeback(folio);
 				folio_unlock(folio);
 				continue;
 			}
-- 
2.20.1

