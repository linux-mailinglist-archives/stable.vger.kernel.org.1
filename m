Return-Path: <stable+bounces-246210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J8PHIdqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:59:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB5352672B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8E6E307410C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC893955DC;
	Tue, 12 May 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zetH97Lv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0C377567;
	Tue, 12 May 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608642; cv=none; b=tqOh3Gy9dOsCetCvZhIFalIdzkLh+fjYjmKuyB7g9zUjC+a5dqU7DgFdD9uyxXNBtzSQI1vauyi8qXb8LpXl3w+Y4N7G3cltUA9OMz3ORyF0yW0ZV7WtWRWJAvPoZxnY36oJGPHrMU0TWYNv8duuQFuqMHS75iS1GWP9PKlLOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608642; c=relaxed/simple;
	bh=3xdMN296sD/Vd/xOANQuQXBLy5xOhp6CSHBwPltMOSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jev0EnHLPDbNoyx5s0kpzkqFY/dGovl6ZQJ+uTV2zp7lJRNpgn75hw7nOk0/j53PA3yFt6EvLQpZFfO0RtuN0FJHpazXRZYDTgRiprAJD0cwnB/ZIYFNtRVljTNLwLC5VB62AZNif13K5mKjcsuiRKK+QU9VgwC0qjx/Pv+Udz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zetH97Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C21DC2BCB0;
	Tue, 12 May 2026 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608641;
	bh=3xdMN296sD/Vd/xOANQuQXBLy5xOhp6CSHBwPltMOSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zetH97LvH6yLStHhD5PkbYMrJilLZywhd2PZoa1S9MCRaLW+iy8o83H/doTIEm8MB
	 mQHTwfeTvPCLIo6nSctP7QVQdaiT+ezxBoDhyfeksVLzTP9vZdP0syDouDKY1+sDEA
	 EwwOOHbuZIyWQCXFpbhlZduR85xQhWusFsc7l0tY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6.18 157/270] isofs: validate block number from NFS file handle in isofs_export_iget
Date: Tue, 12 May 2026 19:39:18 +0200
Message-ID: <20260512173941.753524144@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 0BB5352672B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246210-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 24376458138387fb251e782e624c7776e9826796 upstream.

isofs_fh_to_dentry() and isofs_fh_to_parent() pass an attacker-
controlled block number (ifid->block or ifid->parent_block) from
the NFS file handle to isofs_export_iget(), which only rejects
block == 0 before calling isofs_iget() and ultimately sb_bread().
A crafted file handle with fh_len sufficient to pass the check
added by commit 0405d4b63d08 ("isofs: Prevent the use of too small
fid") can still drive the server to read any in-range block on the
backing device as if it were an iso_directory_record.  That earlier
fix was assigned CVE-2025-37780.

sb_bread() on an out-of-range block returns NULL cleanly via the
EIO path, so there is no memory-safety violation.  For in-range
reads of adjacent-partition data on the same block device, the
unrelated bytes end up in iso_inode_info fields that reach the NFS
client as dentry metadata.  The deployment surface (isofs exported
over NFS from loop-mounted images) is narrow and requires an
authenticated NFS peer, but the malformed-file-handle class is
reportable as hardening next to the existing CVE-2025-37780 fix.

Reject block >= ISOFS_SB(sb)->s_nzones in isofs_export_iget() so
the check covers both isofs_fh_to_dentry() and isofs_fh_to_parent()
call sites with a single line.

Fixes: 0405d4b63d08 ("isofs: Prevent the use of too small fid")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260419212155.2169382-3-michael.bommarito@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/isofs/export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -24,7 +24,7 @@ isofs_export_iget(struct super_block *sb
 {
 	struct inode *inode;
 
-	if (block == 0)
+	if (block == 0 || block >= ISOFS_SB(sb)->s_nzones)
 		return ERR_PTR(-ESTALE);
 	inode = isofs_iget(sb, block, offset);
 	if (IS_ERR(inode))



