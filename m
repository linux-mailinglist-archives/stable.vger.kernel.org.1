Return-Path: <stable+bounces-258273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BbrCjYlG2pm/ggAu9opvQ
	(envelope-from <stable+bounces-258273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:58:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C400A610B72
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E6543021EE0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D936EAB1;
	Sat, 30 May 2026 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fg2djrFQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32E23D7E6;
	Sat, 30 May 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163796; cv=none; b=JaMKVT6zoPPTOhBiK9QA1MXuScgTDDW/4v2eoxwZ6Bh8i8yilSBKjla2aQV19JSIVt2V8Xh794OJmKaB+cLxSY2BTziGFva/5elQ+WDjvI7KC/nzUi0xNih/eTIkUA0b9sK2e6FEob8T1PmMB2nSSrnMCVTfCQAhEOJfGbJCye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163796; c=relaxed/simple;
	bh=Cv83n99KBzccUWmR+3JcxOqBp7yRZ/7ZWaS8cROIvPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVKgmILfT8IX2pqizs+OtTRvfJYkS8rxFnChZdIKcAX02ONiSpkxrlEXMAYAlaxlMCl8zWu81RxDgtYfKIvuEiJjKhd/EV1JwV+KBlPIu6tN2pMGUrn0tPu3T0Oq//lqwEjyuKXpgYVp4UYIQ6E9kC5OEZJD6OlrHSjMNGl6sBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fg2djrFQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF171F00893;
	Sat, 30 May 2026 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163795;
	bh=wgJm/fONoFhrtdxk/MWxwFdsjEbJFTEtefBlrTTwADM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fg2djrFQuOcnu84znbXKIIBWiozdgM4INzmBB5QNhqyFg55Q0avlXk6Vhr5TcOo0F
	 igvyWeigu53+0RwoPXWvhuTpHprBRxDT0K41D8Zre4nPoXhtwdFVNdxOZuCwCaIsfQ
	 7DkiLpzlirdrWx/Negy1GlmxM73LMUWZ9G/2LDlM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5.15 333/776] isofs: validate block number from NFS file handle in isofs_export_iget
Date: Sat, 30 May 2026 18:00:47 +0200
Message-ID: <20260530160249.178606597@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258273-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C400A610B72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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



