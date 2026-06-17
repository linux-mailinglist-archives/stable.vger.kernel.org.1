Return-Path: <stable+bounces-266940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QbJuNRIiM2pe9wUAu9opvQ
	(envelope-from <stable+bounces-266940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:39:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875B69CB50
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:39:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=Sa1LncG4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266940-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266940-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C29305ECD3
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38283A383C;
	Wed, 17 Jun 2026 22:38:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8D374E71;
	Wed, 17 Jun 2026 22:38:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735914; cv=none; b=jkMqIQi+YKwV2kTcthsHGIQDO61Vvq8xpo8dQZs2okWOKAu51euo1hKuCtyPfTAcqsx2dYg9okbhwbNpMtvzafprJjmUTs0ii+2yHP25yl/9GjReMJyBI62RLIRa4V4KH23z61Gp7gM+mChATEInnf3nPfZfLXxu5ng6FulAicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735914; c=relaxed/simple;
	bh=miJMth9NyM2FROzcJJsAaeehqJACDVc+hdtB6GRIlWQ=;
	h=Date:To:From:Subject:Message-Id; b=RZP02ZFgXk+Gq3iDHDZ5+Y/ACv5HRvvLRuVqVhwn1L8kv8VaJb3Rt8bzZ2YXALjcY2T4/ATJdF07uA7x1G4R2ZcZ9hJ1GH9gTlxwTqBPDf4dwZEx5A9zqL8Iw51t5r/DLiDaK83wZ8rXgg264xgdh/IrNcQCMwBRUa+60CNcY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sa1LncG4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0780B1F000E9;
	Wed, 17 Jun 2026 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781735913;
	bh=N5YX6geLgDWOznxn64/2ski9sMseXntQPNyd+iEC6QQ=;
	h=Date:To:From:Subject;
	b=Sa1LncG4FIsOKz+fXKPTx1rWVVsHm5CztgjDPth52A2oFmomLF6oi11MyJHyAtZ+6
	 yLNzZo53/Psk9Lpts1QZx8WCllAcAe3iFdKjd0RVJb3Q10dzKIB/FFEb1FR01jJrj6
	 o71fhUknaDew5AWdR7hu10vACvFO0mea0o06dGik=
Date: Wed, 17 Jun 2026 15:38:32 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,icb@fastmail.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] ocfs2-fix-null-h_transaction-deref-in-ocfs2_assure_trans_credits.patch removed from -mm tree
Message-Id: <20260617223833.0780B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266940-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:piaojun@huawei.com,m:mark@fasheh.com,m:junxiao.bi@oracle.com,m:joseph.qi@linux.alibaba.com,m:jlbec@evilplan.org,m:heming.zhao@suse.com,m:gechangwei@live.cn,m:icb@fastmail.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn,fastmail.org,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3875B69CB50


The quilt patch titled
     Subject: ocfs2: fix NULL h_transaction deref in ocfs2_assure_trans_credits
has been removed from the -mm tree.  Its filename was
     ocfs2-fix-null-h_transaction-deref-in-ocfs2_assure_trans_credits.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ian Bridges <icb@fastmail.org>
Subject: ocfs2: fix NULL h_transaction deref in ocfs2_assure_trans_credits
Date: Thu, 11 Jun 2026 09:46:38 -0500

[BUG]
A direct write over unwritten extents can panic the kernel in
ocfs2_assure_trans_credits() when the journal aborts during DIO
completion. The crash is a general protection fault from a NULL pointer
dereference.

[CAUSE]
ocfs2_dio_end_io_write() loops over a direct write's unwritten extents,
marking each written under a single journal handle. If the journal
aborts (for example after an I/O error) while the extent tree is being
updated, the handle is left aborted with its transaction pointer
cleared. The extent merge treats that failure as not critical and
reports success, so the loop keeps using the handle.
ocfs2_assure_trans_credits() reads the handle's remaining credits
without first checking whether the handle is aborted, and that read
dereferences the cleared transaction pointer.

[FIX]
A journal abort is recorded in the handle itself, so callers are
expected to test the handle rather than rely on a returned error.
Make ocfs2_assure_trans_credits() do that, as the other ocfs2 journal
helpers already do, and return -EROFS when the handle is aborted.

Link: https://lore.kernel.org/airKTsM1fRVN-Wj7@dev
Fixes: be346c1a6eeb ("ocfs2: fix DIO failure due to insufficient transaction credits")
Signed-off-by: Ian Bridges <icb@fastmail.org>
Reported-by: syzbot+e9c15ff790cea6a0cfae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e9c15ff790cea6a0cfae
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/journal.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/ocfs2/journal.c~ocfs2-fix-null-h_transaction-deref-in-ocfs2_assure_trans_credits
+++ a/fs/ocfs2/journal.c
@@ -473,8 +473,12 @@ bail:
  */
 int ocfs2_assure_trans_credits(handle_t *handle, int nblocks)
 {
-	int old_nblks = jbd2_handle_buffer_credits(handle);
+	int old_nblks;
 
+	if (is_handle_aborted(handle))
+		return -EROFS;
+
+	old_nblks = jbd2_handle_buffer_credits(handle);
 	trace_ocfs2_assure_trans_credits(old_nblks);
 	if (old_nblks >= nblocks)
 		return 0;
_

Patches currently in -mm which might be from icb@fastmail.org are



