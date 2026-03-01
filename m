Return-Path: <stable+bounces-221458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COWVLCilo2lXJAUAu9opvQ
	(envelope-from <stable+bounces-221458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:32:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FF41CDA73
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31B4302EEBE
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB1D283CBF;
	Sun,  1 Mar 2026 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpTgvBzp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE72727EB;
	Sun,  1 Mar 2026 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328315; cv=none; b=UT9jL/K5R6TEDR/1OainLttpwFWPW2ywNb1aNsu1sJDrnicA8JqfGcXT3Jq0lkXmOnO89zn3NUQBq65eHgFygjSElYnMqw0vktYijW52W+T4LV0xdcDfgypxZt9euRsyPsMth2PLDr5jlSmqkH+D1VISgG+snUAOVv+Ojuhjo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328315; c=relaxed/simple;
	bh=y1tSg0gpsbVlAC5WHtPZe5wAvSJVAH/Yx+1WLN87+Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFnfN5ndSfwxxjZFJgOIq9uPKvF0tt84AAZeqQK9mmCM4T224jKspCZBEPntOJOEp5vYYqbkHG5gUUiY+xGMnUpJ+x8kktwPlqIAqGzraQd4Wt7TIJF6BQHkkC6dHKK+VR2hm9ANO6UR6jWwEQmdoPSjQXSraHFMMw3mEZS0tko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpTgvBzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6F3C19421;
	Sun,  1 Mar 2026 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328315;
	bh=y1tSg0gpsbVlAC5WHtPZe5wAvSJVAH/Yx+1WLN87+Ek=;
	h=From:To:Cc:Subject:Date:From;
	b=lpTgvBzpCQc2/atIhvylNwEs6K3UD6vLkhcrrELmAlir4PAfC/nG1NCuG4+Nu04uT
	 7rZcmkBwOns2bQU655yeZX6kCweHZDpCXPGGwaWPYVnRp3/M0N8QX+P6pc/sSrdqnh
	 GYbl7gqjufN2OJaHlIugwgU8YtpoupNnyhJZ+KvWX+fQtORQnQDJvHdpjuODdYYouK
	 l0SCy1lCWC62H3wmeNpjFX9JuPo7lQORauOd2y1TGRHb1De2NUuTuSv0Bs6Omm5NCc
	 UsaQe0KQA+Eoox8Cduj0doQHOdVJufY9f1d3wjHF7jnIOdEQZYstyhdPXCQABPwn7U
	 xQT2xf+p5SMBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	heming.zhao@suse.com
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ocfs2-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: FAILED: Patch "ocfs2: fix reflink preserve cleanup issue" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:12 -0500
Message-ID: <20260301012513.1682267-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fasheh.com,evilplan.org,oracle.com,gmail.com,live.cn,huawei.com,linux-foundation.org,lists.linux.dev,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221458-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,live.cn:email,fasheh.com:email,huawei.com:email,oracle.com:email,linux-foundation.org:email,evilplan.org:email]
X-Rspamd-Queue-Id: 31FF41CDA73
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5138c936c2c82c9be8883921854bc6f7e1177d8c Mon Sep 17 00:00:00 2001
From: Heming Zhao <heming.zhao@suse.com>
Date: Wed, 10 Dec 2025 09:57:24 +0800
Subject: [PATCH] ocfs2: fix reflink preserve cleanup issue

commit c06c303832ec ("ocfs2: fix xattr array entry __counted_by error")
doesn't handle all cases and the cleanup job for preserved xattr entries
still has bug:
- the 'last' pointer should be shifted by one unit after cleanup
  an array entry.
- current code logic doesn't cleanup the first entry when xh_count is 1.

Note, commit c06c303832ec is also a bug fix for 0fe9b66c65f3.

Link: https://lkml.kernel.org/r/20251210015725.8409-2-heming.zhao@suse.com
Fixes: 0fe9b66c65f3 ("ocfs2: Add preserve to reflink.")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/ocfs2/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 5fd85f5178689..e434a62dd69f9 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -6395,6 +6395,10 @@ static int ocfs2_reflink_xattr_header(handle_t *handle,
 					(void *)last - (void *)xe);
 				memset(last, 0,
 				       sizeof(struct ocfs2_xattr_entry));
+				last = &new_xh->xh_entries[le16_to_cpu(new_xh->xh_count)] - 1;
+			} else {
+				memset(xe, 0, sizeof(struct ocfs2_xattr_entry));
+				last = NULL;
 			}
 
 			/*
-- 
2.51.0





