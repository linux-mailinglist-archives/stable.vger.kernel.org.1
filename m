Return-Path: <stable+bounces-271861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YEnNHtkGSGq2jwAAu9opvQ
	(envelope-from <stable+bounces-271861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 21:00:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72704705059
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 21:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kGPT7ODQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271861-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271861-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED6C3300E6B8
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9268E30ACF1;
	Fri,  3 Jul 2026 19:00:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3E279334
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 19:00:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105236; cv=none; b=O0HPjoqTcIaQ4gTy+wx+VXpOXir6NvQ+NFNl0phTexsYbqQWweZVuWy0jXpA7Pa7t8FYAcUBTl23juz+pKG2c9w/0K2N++RcqwHRuYCJvuNu4Vvpqmfq/qJbeWA8CjmHcVS8kqXOH6kB0FhnvRR0sVlF5XLPcATUFGzJci/v9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105236; c=relaxed/simple;
	bh=zhXJxE6QXofgAqg+AvkbmKyi1PZy76dvfXmWcYOm5Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSbNP57urvLbvWbv1QvgoC5F1b+dEqHI7P0kN3pJONEOlTGXERchtprgCPjFzem1F/7QIuIqZHVT4HaD8nmkIshuO3PnukIm9G8hy8hdoYPX3mhRISC5uBfs40KXxKnAqSWj3QkZBnxJf+SCbspE1DCuTRgpF9r0/eg7BtwcI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGPT7ODQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA681F000E9;
	Fri,  3 Jul 2026 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783105235;
	bh=bgjKry3ORNWS6iwAmf/LilPlgKNck5ZK+CYIU6Btf40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kGPT7ODQIl9/DXyRgVUTs06BSC3leFVYc7WMqcB79GBXJlFeLVJw0fcXWwiShxuAb
	 fMPRWt/00THS18uF/bN6ZxAxgRr/TmHKVyrvOfFD1oRaT+5FruUWUYpdAwUZbHWsu7
	 Ud44ycfi/DXMxmdC16yoAkoLImKuh5SEgeMHJbx+WqEPYH1E7JsC+bJDFHsPopzd31
	 6uOH50F6eMT9obpVCSVfT9h+vZ9oWIqYC6ELzrqljQmXXg9BwopP/OGCy+OrWOcZMR
	 nCDtKZihlKSyVGbsjHcd2iwuC2F8XNFDrmSx/RJz32Ne15iMESPGBNS1obkbhOSGFP
	 xsW9Iiq5+AKsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Ruipeng Qi <ruipengqi3@gmail.com>,
	Chao Yu <chaseyu@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()
Date: Fri,  3 Jul 2026 15:00:31 -0400
Message-ID: <20260703190031.290388-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703190031.290388-1-sashal@kernel.org>
References: <2026070242-blizzard-gestation-23e0@gregkh>
 <20260703190031.290388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:chao@kernel.org,m:stable@kernel.org,m:ruipengqi3@gmail.com,m:chaseyu@google.com,m:jaegeuk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271861-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72704705059

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8b4468ec023d0d1b4669dfb867588997cc03a06b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3028e940d5ffc7..d185b209f89a5f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -408,6 +408,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 * dir/node pages without enough free segments.
 	 */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
+		/*
+		 * Submit all cached OPU/IPU DATA bios before triggering
+		 * foreground GC to avoid potential deadlocks.
+		 */
+		f2fs_submit_merged_write(sbi, DATA);
+		f2fs_submit_all_merged_ipu_writes(sbi);
+
 		if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
 					sbi->gc_thread->f2fs_gc_task) {
 			DEFINE_WAIT(wait);
@@ -426,13 +433,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 				.err_gc_skipped = false,
 				.nr_free_secs = 1 };
 
-			/*
-			 * Submit all cached OPU/IPU DATA bios before triggering
-			 * foreground GC to avoid potential deadlocks.
-			 */
-			f2fs_submit_merged_write(sbi, DATA);
-			f2fs_submit_all_merged_ipu_writes(sbi);
-
 			f2fs_down_write(&sbi->gc_lock);
 			f2fs_gc(sbi, &gc_control);
 		}
-- 
2.53.0


