Return-Path: <stable+bounces-225263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFoFIWjHs2kqawAAu9opvQ
	(envelope-from <stable+bounces-225263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:14:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FEE27F6CA
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75227318CC3C
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0036AB5E;
	Fri, 13 Mar 2026 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L4q5ULpa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L4q5ULpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD65330D35
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389157; cv=none; b=rDXvl54H8LP7vKN7H9S5KxE+FuQTy/9f37ZJ5lCdE0Io+C+bLoHIXABlCOfOLuybVi+6pw9z7rTmZ3p6t/YKvFy9EDOtfb/AjRKiJVUOnHsmgrS7aEURL0Cx24P5srm3BDS55n1Jin4foDllIPNmWb33jcTo8TqZw/6jiekgJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389157; c=relaxed/simple;
	bh=vbcc5K10vQNN/VVddyoPX4YlLlX42ocZcrQf+B+PO7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYHzlh6COSZ1QQNjattoVd0usvGjjjasOHGpoNLKemngVSC1Z9lUCllZ0FSjr9zQpGPj1FhfvuqJBRB44+R9DJAxIZzzCSY/WCIhbcLAh7BLj0+3jvTy48ta7Qbpeo3KyLfc2Vh8Z2MzStMKI8cKezCZlrqUixirpYKtuRs5tWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L4q5ULpa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L4q5ULpa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82D924E428;
	Fri, 13 Mar 2026 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773389153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MghTzkGJejGDi7XxGLM7oPSZbZwR1JfnwjSrypF5lJY=;
	b=L4q5ULpa0mki0I+TD0uv4gervOE3kSiJurZO712Pd62TRIALTnmCCkAQzlH/VPzaaEZ8ce
	ZLEU3KyC6T2tdTS0zY6W1jAxSaWyxLgisrtqIFhMEQySHrFU+rAJUSwrt0+LI7HwVBB7EQ
	bMICzh+HzspNjThngdL6G5dAzl5ymFo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=L4q5ULpa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773389153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MghTzkGJejGDi7XxGLM7oPSZbZwR1JfnwjSrypF5lJY=;
	b=L4q5ULpa0mki0I+TD0uv4gervOE3kSiJurZO712Pd62TRIALTnmCCkAQzlH/VPzaaEZ8ce
	ZLEU3KyC6T2tdTS0zY6W1jAxSaWyxLgisrtqIFhMEQySHrFU+rAJUSwrt0+LI7HwVBB7EQ
	bMICzh+HzspNjThngdL6G5dAzl5ymFo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D30840408;
	Fri, 13 Mar 2026 08:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QSFHMF/Fs2mgKgAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 13 Mar 2026 08:05:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Jean-Christophe Guillain <jean-christophe@guillain.net>
Subject: [PATCH v2] btrfs: zlib: handle page aligned compressed size correctly
Date: Fri, 13 Mar 2026 18:35:26 +1030
Message-ID: <ab5c12312b275589abd42c47a0c34b7e68375407.1773389056.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225263-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,guillain.net:email]
X-Rspamd-Queue-Id: E9FEE27F6CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
Since commit 3d74a7556fba ("btrfs: zlib: introduce zlib_compress_bio()
helper"), there are some reports about different crashes in zlib
compression path. One of the symptoms is list corruption like the
following:

  list_del corruption. next->prev should be fffffbb340204a08, but was ffff8d6517cb7de0. (next=fffffbb3402d62c8)
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:65!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  CPU: 1 UID: 0 PID: 21436 Comm: kworker/u16:7 Not tainted 7.0.0-rc2-jcg+ #1 PREEMPT
  Hardware name: LENOVO 10VGS02P00/3130, BIOS M1XKT57A 02/10/2022
  Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
  RIP: 0010:__list_del_entry_valid_or_report+0xec/0xf0
  Call Trace:
   <TASK>
   btrfs_alloc_compr_folio+0xae/0xc0 [btrfs]
   zlib_compress_bio+0x39d/0x6a0 [btrfs]
   btrfs_compress_bio+0x2e3/0x3d0 [btrfs]
   compress_file_range+0x2b0/0x660 [btrfs]
   btrfs_work_helper+0xdb/0x3e0 [btrfs]
   process_one_work+0x192/0x3d0
   worker_thread+0x19a/0x310
   kthread+0xdf/0x120
   ret_from_fork+0x22e/0x310
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---

Other symptoms include VM_BUG_ON() during folio_put() but it's rarer.

David Sterba firstly reported this during his CI runs but unfortunately
I'm unable to hit it.

Meanwhile zstd/lzo doesn't seem to have the same problem.

[CAUSE]
During zlib_compress_bio() every time the output buffer is full, we
queue the full folio into the compressed bio, and allocate a new folio
as the output folio.

After the input has finished, we loop through zlib_deflate() with
Z_FINISH to flush all output.

And when that is done, we still need to check if the last folio has any
content, and if so we still need to queue that part into the compressed
bio.

The problem is in the final folio handling, if the final folio is full
(for x86_64 the folio size is 4K), the length to queue is calculated by

  u32 cur_len = offset_in_folio(out_folio, workspace->strm.total_out);

But since total_out is 4K aligned, the resulted @cur_len will be 0, then
we hit the bio_add_folio(), which has a quirk that if bio_add_folio()
got an length 0, it will still queue the folio into the bio, but return
false.

In that case we go to out: tag, which calls btrfs_free_compr_folio() to
release @out_folio, which may put the out folio into the btrfs global
pool list.

On the other hand, that @out_folio is already added to the
compressed bio, and will later be released again by
cleanup_compressed_bio(), which results double release.

And if this time we still need to put the folio into the btrfs global
pool list, it will result a list corruption because it's already in the
list.

[FIX]
Instead of offset_inside_folio(), directly use the difference between
strm.total_out and bi_size.
So that if the last folio is completely full, we can still properly
queue the full folio other than queueing zero byte.

Fixes: 3d74a7556fba ("btrfs: zlib: introduce zlib_compress_bio() helper")
Cc: stable@vger.kernel.org # 7.0+
Reported-by: David Sterba <dsterba@suse.com>
Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221176
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add missing reported-by/link/cc tags
---
 fs/btrfs/zlib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 1a5093525e32..147c92a4dd04 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -308,7 +308,9 @@ int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 	}
 	/* Queue the remaining part of the folio. */
 	if (workspace->strm.total_out > bio->bi_iter.bi_size) {
-		u32 cur_len = offset_in_folio(out_folio, workspace->strm.total_out);
+		const u32 cur_len = workspace->strm.total_out - bio->bi_iter.bi_size;
+
+		ASSERT(cur_len <= folio_size(out_folio));
 
 		if (!bio_add_folio(bio, out_folio, cur_len, 0)) {
 			ret = -E2BIG;
-- 
2.53.0


