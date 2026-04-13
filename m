Return-Path: <stable+bounces-235978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB89Boq53GkvVwkAu9opvQ
	(envelope-from <stable+bounces-235978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:38:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 668013E9ECD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 479F6300916D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC036404A;
	Mon, 13 Apr 2026 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t0yPqyxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Kq3htOd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t0yPqyxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Kq3htOd"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAA3624DB
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073015; cv=none; b=a41P+A1jtZ0gAOThN0CEYpOSahqk4cMw85Q2KNoCNVPAfL1wHh5BTCbcO0buEReJXqJJTEHisEQkXBDmAGaBRHML7T3FOBWqvk3TNUzTmH55HiX+vUJQwVwfWWx9pTod3LQBlE5vq1uSIfopZbR61wGIiP3tMKoNCv72pDC+RUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073015; c=relaxed/simple;
	bh=QmTIoBAchIY+pe5X8DTpJXlXGK/uWBerFKCE0ptjle4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksVasdIXYDCdOUpM8PguPRtx3BfmVLuzG2YUGcPshxF0zHigzw+glOQVKq2aYfUXCFdkfHRXveRNwHMoekWszNjJ1Uppigqrbl+rC9lmVWlnlQLk5k/Of5Ea3sP9eYrxCqY5+Qi2XzkG0e0BdelkUoFtmYz/taPQhp16j2pjyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t0yPqyxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Kq3htOd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t0yPqyxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Kq3htOd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B5995BDDC;
	Mon, 13 Apr 2026 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776073012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zpq8kjeNIvb9jFsMF9AD32hVWMZZRMxx90VRGTrvU+0=;
	b=t0yPqyxm0oAW12yi70/aaau00c1Px7HnuExKZmFFNOXQ00PBcV1GGEHjAJPzgI+CTt3BxV
	avgj3Ak+hUndbcdz+tcoEAAm+e/dnRjJ27Uvoo429IwlsAQ4ZpiG0sg7WzxOUo6/2AGtv2
	X/YobycCRYwOFuEWQlT6ADy/hrg/Y4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776073012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zpq8kjeNIvb9jFsMF9AD32hVWMZZRMxx90VRGTrvU+0=;
	b=7Kq3htOdf0hriXwh1+IH8CM5hZOszPRo7dWj6McKMMD2ZHmbdFuLpmY+qIoRFfh+sMyWwn
	RGh40dhy5n6ZP6CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776073012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zpq8kjeNIvb9jFsMF9AD32hVWMZZRMxx90VRGTrvU+0=;
	b=t0yPqyxm0oAW12yi70/aaau00c1Px7HnuExKZmFFNOXQ00PBcV1GGEHjAJPzgI+CTt3BxV
	avgj3Ak+hUndbcdz+tcoEAAm+e/dnRjJ27Uvoo429IwlsAQ4ZpiG0sg7WzxOUo6/2AGtv2
	X/YobycCRYwOFuEWQlT6ADy/hrg/Y4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776073012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zpq8kjeNIvb9jFsMF9AD32hVWMZZRMxx90VRGTrvU+0=;
	b=7Kq3htOdf0hriXwh1+IH8CM5hZOszPRo7dWj6McKMMD2ZHmbdFuLpmY+qIoRFfh+sMyWwn
	RGh40dhy5n6ZP6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8824ADFE;
	Mon, 13 Apr 2026 09:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xCMtHzS53GlEWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Apr 2026 09:36:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 223CAA0AFF; Mon, 13 Apr 2026 11:36:44 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH] writeback: Fix use after free in inode_switch_wbs_work_fn()
Date: Mon, 13 Apr 2026 11:36:19 +0200
Message-ID: <20260413093618.17244-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3335; i=jack@suse.cz; h=from:subject; bh=QmTIoBAchIY+pe5X8DTpJXlXGK/uWBerFKCE0ptjle4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBp3LkTRaCXLIFbJ8U/1etB83+UZMczMACbZ7lgK m8rBaOIUciJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCady5EwAKCRCcnaoHP2RA 2QlMCADVs8GlstAYuGbk93Jm7pRf/GmDp6S8GJwD0eyjl8BDbjXAvQoTidKBa6bo0jWHxu51K7f zonwUgBW13XC0j+I4za5U3Kk7ULrFGEzibI+qHLc2WMXNV3LAtddN03RHDGm086uql0L9S1NvFG rGfn+B8WuG01tC8KsQHUYnlT4qXv2xFvdwnFxuIA8KZs5RWaIcvGG7PTQFW2Jg0wjQ07wsI7t2e 4G9HOIaK/EvqA01wEW+UU9lk6e+djG3lPwSlViDrQVA1c/XcV63U3u9RJB9y44Sck7fOFFqP5Bk PI0bBAeoW54WhA9C3E6BfBaI/Y8B30uOkGHCnWLxk0pkok/p
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[suse.cz];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235978-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:mid];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 668013E9ECD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

inode_switch_wbs_work_fn() has a loop like:

  wb_get(new_wb);
  while (1) {
    list = llist_del_all(&new_wb->switch_wbs_ctxs);
    /* Nothing to do? */
    if (!list)
      break;
    ... process the items ...
  }

Now adding of items to the list looks like:

wb_queue_isw()
  if (llist_add(&isw->list, &wb->switch_wbs_ctxs))
    queue_work(isw_wq, &wb->switch_work);

Because inode_switch_wbs_work_fn() loops when processing isw items, it
can happen that wb->switch_work is pending while wb->switch_wbs_ctxs is
empty. This is a problem because in that case wb can get freed (no isw
items -> no wb reference) while the work is still pending causing
use-after-free issues.

We cannot just fix this by cancelling work when freeing wb because that
could still trigger problematic 0 -> 1 transitions on wb refcount due to
wb_get() in inode_switch_wbs_work_fn(). It could be all handled with
more careful code but that seems unnecessarily complex so let's avoid
that until it is proven that the looping actually brings practical
benefit. Just remove the loop from inode_switch_wbs_work_fn() instead.
That way when wb_queue_isw() queues work, we are guaranteed we have
added the first item to wb->switch_wbs_ctxs and nobody is going to
remove it (and drop the wb reference it holds) until the queued work
runs.

Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3c75ee025bda..d63baa1b6fec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -570,28 +570,30 @@ void inode_switch_wbs_work_fn(struct work_struct *work)
 	struct inode_switch_wbs_context *isw, *next_isw;
 	struct llist_node *list;
 
+	list = llist_del_all(&new_wb->switch_wbs_ctxs);
 	/*
-	 * Grab out reference to wb so that it cannot get freed under us
+	 * Nothing to do? That would be a problem as references held by isw
+	 * items protect wb from freeing...
+	 */
+	if (WARN_ON_ONCE(!list))
+		return;
+
+	/*
+	 * Grab our reference to wb so that it cannot get freed under us
 	 * after we process all the isw items.
 	 */
 	wb_get(new_wb);
-	while (1) {
-		list = llist_del_all(&new_wb->switch_wbs_ctxs);
-		/* Nothing to do? */
-		if (!list)
-			break;
-		/*
-		 * In addition to synchronizing among switchers, I_WB_SWITCH
-		 * tells the RCU protected stat update paths to grab the i_page
-		 * lock so that stat transfer can synchronize against them.
-		 * Let's continue after I_WB_SWITCH is guaranteed to be
-		 * visible.
-		 */
-		synchronize_rcu();
+	/*
+	 * In addition to synchronizing among switchers, I_WB_SWITCH
+	 * tells the RCU protected stat update paths to grab the i_page
+	 * lock so that stat transfer can synchronize against them.
+	 * Let's continue after I_WB_SWITCH is guaranteed to be
+	 * visible.
+	 */
+	synchronize_rcu();
 
-		llist_for_each_entry_safe(isw, next_isw, list, list)
-			process_inode_switch_wbs(new_wb, isw);
-	}
+	llist_for_each_entry_safe(isw, next_isw, list, list)
+		process_inode_switch_wbs(new_wb, isw);
 	wb_put(new_wb);
 }
 
-- 
2.51.0


