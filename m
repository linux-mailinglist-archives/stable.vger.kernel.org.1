Return-Path: <stable+bounces-245760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNDFL6A/A2ro2AEAu9opvQ
	(envelope-from <stable+bounces-245760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:56:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6B523134
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 874CA3136F8E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D353ABD80;
	Tue, 12 May 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKJc1uIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E93905F0
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595751; cv=none; b=l8gH8APgidH3geNqlo7gtrduWVoh8IJrTPIQDm4++8X83ABxA2g7K/EaFmhw63mu1h7HwjyqiRuliBiveyWOP5RyvJOSr2W+jipifCZxuSSeEO+c2ZQZ8Ic0D9wVa4RkoHZNzGwGxQhv6Tp4Mq8deg5SVeKKsU90aLZzd+IX1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595751; c=relaxed/simple;
	bh=4aKGwsQYImF9DUHAw9hNlamZrG6yth4HZpeniXwWEu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mST+qRrIFiLTgrp21P/dR4Yz7NIFyDgN2yXLgOg+YOwqP6ZEY+wsIrIMxURFhfvIgP4rh9DqAPBDRCOdWulvPGAJ5lKOAuZjioFmw8j12/z+oBulguvoI2utfy1PuJGU0vNL7J3khp7Djon3lJGTS4P4twxumgJ0rdx2esMGzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKJc1uIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AE9C2BCB0;
	Tue, 12 May 2026 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595751;
	bh=4aKGwsQYImF9DUHAw9hNlamZrG6yth4HZpeniXwWEu8=;
	h=Subject:To:Cc:From:Date:From;
	b=vKJc1uIQhpMMbcoAwqItJCQdxxSJ727YeOdm6ScRdSksGI0xMi4anL3Ifv8n/cP2+
	 WGaYJVPhKc77mr/0ZODTZj7RdZdFSbXk2EXq/GfhX+IhoT3ahd9rgM2dC2kkDZWqXJ
	 RXv5tJMxfYV65KBXNh171reoA040uUXHCx7aDY8E=
Subject: FAILED: patch "[PATCH] f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()" failed to apply to 5.10-stable tree
To: zzzccc427@gmail.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:22:28 +0200
Message-ID: <2026051228-unfocused-stimulant-c32e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EAB6B523134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245760-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5471834a96fb697874be2ca0b052e74bcf3c23d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051228-unfocused-stimulant-c32e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5471834a96fb697874be2ca0b052e74bcf3c23d1 Mon Sep 17 00:00:00 2001
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 18 Mar 2026 15:32:53 +0800
Subject: [PATCH] f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()

f2fs_update_inode() reads inode->i_blocks without holding i_lock to
serialize it to the on-disk inode, while concurrent truncate or
allocation paths may modify i_blocks under i_lock.  Since blkcnt_t is
u64, this risks torn reads on 32-bit architectures.

Following the approach in ext4_inode_blocks_set(), add READ_ONCE() to prevent
potential compiler-induced tearing.

Fixes: 19f99cee206c ("f2fs: add core inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e0f850b3f0c3..89240be8cc59 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -687,7 +687,7 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
+	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(READ_ONCE(inode->i_blocks)) + 1);
 
 	if (!f2fs_is_atomic_file(inode) ||
 			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))


