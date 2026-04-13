Return-Path: <stable+bounces-237394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHV9Lkgj3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-237394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:09:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 246743F0D8E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5B4F3023D9F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E50F320393;
	Mon, 13 Apr 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuvkTzaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B852D9ECD;
	Mon, 13 Apr 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099342; cv=none; b=Z+CzFteI/gCKfjSk0kkiQDdbI9ueSnxaEjL61cbFXBz4DGSFj6SMegKC+2kf1FX7daZxPR86gZ72L5DLzV+8YO9f2fQOTPYBEAfoYg69v6woRvwbNyP9BheX9l6XFda1I8ZYPupuXOWPczfe+9uIi3tL4lk23zbn3gSOXqmaoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099342; c=relaxed/simple;
	bh=Mkq6UOU5DOGg6eQXAGFYWji/VxHDfigJEVwg6ubRtaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG7q/i/W+90cqCta5jrfpPzyG2uTE0hNF8HGIHuuuxpfDh4eqGCDtjXfNGK3P+0+EcWvH6GYlNeDP2J+12n9JUlDf9g0jZGvJ5C5Wl+5nphagB9qU7rQMdm/6okxhF1MDhIyoQqCgDWAnOZyAAtZztQekKnOA8qruCu5FGrLGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuvkTzaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFE6C2BCAF;
	Mon, 13 Apr 2026 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099342;
	bh=Mkq6UOU5DOGg6eQXAGFYWji/VxHDfigJEVwg6ubRtaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuvkTzaXrv86IyynXOQlMOWXMjMzPt4IylriUFlFf6CrdH08nsFYBNiWkej5McKN5
	 qEoktM36uduslH/izJDXtDT2aYb7QZxSkJTMAbWkOl2Bem9U/tEYIncvVIYKCuw5Ih
	 VDoBZB7m4grJWjPdUZfcyBKH2CxQFZgBI7ZW6Vzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Milos Nikic <nikic.milos@gmail.com>,
	Andreas Dilger <adilger@dilger.ca>,
	Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 5.10 303/491] jbd2: gracefully abort on checkpointing state corruptions
Date: Mon, 13 Apr 2026 17:59:08 +0200
Message-ID: <20260413155830.385886345@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237394-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,dilger.ca,huawei.com,linux.alibaba.com,suse.cz,mit.edu,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dilger.ca:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: 246743F0D8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milos Nikic <nikic.milos@gmail.com>

commit bac3190a8e79beff6ed221975e0c9b1b5f2a21da upstream.

This patch targets two internal state machine invariants in checkpoint.c
residing inside functions that natively return integer error codes.

- In jbd2_cleanup_journal_tail(): A blocknr of 0 indicates a severely
corrupted journal superblock. Replaced the J_ASSERT with a WARN_ON_ONCE
and a graceful journal abort, returning -EFSCORRUPTED.

- In jbd2_log_do_checkpoint(): Replaced the J_ASSERT_BH checking for
an unexpected buffer_jwrite state. If the warning triggers, we
explicitly drop the just-taken get_bh() reference and call __flush_batch()
to safely clean up any previously queued buffers in the j_chkpt_bhs array,
preventing a memory leak before returning -EFSCORRUPTED.

Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260311041548.159424-1-nikic.milos@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/checkpoint.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -303,7 +303,15 @@ restart:
 			 */
 			BUFFER_TRACE(bh, "queue");
 			get_bh(bh);
-			J_ASSERT_BH(bh, !buffer_jwrite(bh));
+			if (WARN_ON_ONCE(buffer_jwrite(bh))) {
+				put_bh(bh); /* drop the ref we just took */
+				spin_unlock(&journal->j_list_lock);
+				/* Clean up any previously batched buffers */
+				if (batch_count)
+					__flush_batch(journal, &batch_count);
+				jbd2_journal_abort(journal, -EFSCORRUPTED);
+				return -EFSCORRUPTED;
+			}
 			journal->j_chkpt_bhs[batch_count++] = bh;
 			transaction->t_chp_stats.cs_written++;
 			transaction->t_checkpoint_list = jh->b_cpnext;
@@ -361,7 +369,10 @@ int jbd2_cleanup_journal_tail(journal_t
 
 	if (!jbd2_journal_get_log_tail(journal, &first_tid, &blocknr))
 		return 1;
-	J_ASSERT(blocknr != 0);
+	if (WARN_ON_ONCE(blocknr == 0)) {
+		jbd2_journal_abort(journal, -EFSCORRUPTED);
+		return -EFSCORRUPTED;
+	}
 
 	/*
 	 * We need to make sure that any blocks that were recently written out



