Return-Path: <stable+bounces-270469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nzxpCZNlRmqySgsAu9opvQ
	(envelope-from <stable+bounces-270469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A486F8428
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:20:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bCNG4Yrb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270469-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270469-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE92031307B2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5AD42E8E5;
	Thu,  2 Jul 2026 13:11:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26043635E
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:11:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997893; cv=none; b=n/tsojbS7XN8Ro9iwDUiTKfJVYwB3fW/5J9Uehs5f2pFeQGyc8qnhPJMzk+aFlPQ/4PZzP5v45PmXBjq7oi5eV5Vdkq+146nZ/M8aJ5CKpsMLedm0cYpNP7aIxwA4seBupaU1T9t1VLP+ZsYQMz2deRCGsgRgKPBwAXP5yg21Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997893; c=relaxed/simple;
	bh=IIlo+GjBl9FZ3N9GcoSJvC5Bp16ywBec+jocnwGi0iY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iYGs+jhLYfSKE0zKcEnV/BKDfdWMM7dHkJzt+q1kuG13b29uRWKX4tQolH5JYPisHiJBRgLcH2p+vUNnii0dDBBrcc6jNK7ppRiZi0AuWKhQTY6ihL4QTlXQaOIqXhbcAcmo8BMNMBSBQX5VRZq3qagxinUoVMuf3aqE47KeUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bCNG4Yrb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D663A1F000E9;
	Thu,  2 Jul 2026 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997890;
	bh=ye+BRQERerrMw43ow6KeHeV0emT9zeK9f1rrNroV6EM=;
	h=Subject:To:Cc:From:Date;
	b=bCNG4YrbQz4lWuqgYxHsI3U5WbJNceY1kfhRd2Qz/WkMghP5eBmCY6LPAFoKmdQ5r
	 U4vrunSBzEmlxkKVeZOBzXUwCi8r2rQTp9Efs6ZLvHCnY3psBbFHhBEPF+7hl7GBwv
	 SOL8tizpPF/b1kX3gxtSiVpwn9QmN62wTSHY4H7Y=
Subject: FAILED: patch "[PATCH] f2fs: fix potential deadlock in gc_merge path of" failed to apply to 7.1-stable tree
To: chao@kernel.org,chaseyu@google.com,dhavale@google.com,jaegeuk@kernel.org,ruipengqi3@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:11:40 +0200
Message-ID: <2026070240-portal-down-4efd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270469-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:chaseyu@google.com,m:dhavale@google.com,m:jaegeuk@kernel.org,m:ruipengqi3@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70A486F8428


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8b4468ec023d0d1b4669dfb867588997cc03a06b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070240-portal-down-4efd@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b4468ec023d0d1b4669dfb867588997cc03a06b Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 19 May 2026 01:14:38 +0000
Subject: [PATCH] f2fs: fix potential deadlock in gc_merge path of
 f2fs_balance_fs()

When we mount device w/ gc_merge mount option, we may suffer below
potential deadlock:

Kworker					GC trehad			Truncator
- f2fs_write_cache_pages
 - f2fs_write_single_data_page
  - f2fs_do_write_data_page
   - folio_start_writeback  --- set writeback flag on folio
   - f2fs_outplace_write_data
   : cached folio in internal bio cache
  - f2fs_balance_fs
   - wake_up(gc_thread)
   : wake up gc thread to run foreground GC
   - finish_wait(fggc_wq)
   : wait on the waitqueue --- wait on GC thread to finish the work
									- truncate_inode_pages_range
									 - __filemap_get_folio(, FGP_LOCK)  --- lock folio
									 - truncate_inode_partial_folio
									  - folio_wait_writeback            --- wait on writeback being cleared
					- do_garbage_collect
					 - move_data_page
					  - f2fs_get_lock_data_folio
					   - lock on folio  --- blocked on folio's lock

In order to avoid such deadlock, let's call below functions to commit
cached bios in GC_MERGE path of f2fs_balance_fs() as the same as we did
in NOGC_MERGE path.
- f2fs_submit_merged_write(sbi, DATA);
- f2fs_submit_all_merged_ipu_writes(sbi);

Cc: stable@kernel.org
Fixes: 351df4b20115 ("f2fs: add segment operations")
Cc: Ruipeng Qi <ruipengqi3@gmail.com>
Reported: Sandeep Dhavale <dhavale@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chao Yu <chaseyu@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7c8ac62b1b0d..1ef4edb77078 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -445,6 +445,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	if (has_enough_free_secs(sbi, 0, 0))
 		return;
 
+	/*
+	 * Submit all cached OPU/IPU DATA bios before triggering
+	 * foreground GC to avoid potential deadlocks.
+	 */
+	f2fs_submit_merged_write(sbi, DATA);
+	f2fs_submit_all_merged_ipu_writes(sbi);
+
 	if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
 				sbi->gc_thread->f2fs_gc_task) {
 		DEFINE_WAIT(wait);
@@ -464,13 +471,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			.err_gc_skipped = false,
 			.nr_free_secs = 1 };
 
-		/*
-		 * Submit all cached OPU/IPU DATA bios before triggering
-		 * foreground GC to avoid potential deadlocks.
-		 */
-		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_all_merged_ipu_writes(sbi);
-
 		f2fs_down_write_trace(&sbi->gc_lock, &gc_control.lc);
 		stat_inc_gc_call_count(sbi, FOREGROUND);
 		f2fs_gc(sbi, &gc_control);


