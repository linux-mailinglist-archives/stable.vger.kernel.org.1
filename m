Return-Path: <stable+bounces-231177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHMkJidZymn27gUAu9opvQ
	(envelope-from <stable+bounces-231177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA77359EA3
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78B65301E205
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDC3BBA19;
	Mon, 30 Mar 2026 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fs8UmJ7s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30C3BA238
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868765; cv=none; b=Gd/uX8x/SXetKzb8WDGlU3i7IsbkvUmwsrGA+5/K/WWU8gaYBUUKFrOlNbmaOlN8UK3M9UveGbwhIJRD49KLR8tmr5T+y5RNbWqxF9k3s2WlVQIi0abSECPajYgQuaejDcwa4YtqL6tUvEZN00iHAJUIeIE5tEoIk1ctrXsyYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868765; c=relaxed/simple;
	bh=mWPE/a2Z8beZhjw4qHmFBhKhZobM6LgiFw5racoE/EQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rfp4ouPZOVlRffd9UZRvIDg1aMXyOd0C7kgprtaa0AzA43bQajKh4s2C9Ea/wlt95wNAPI3vz9ckiupzJJnK6bP48RCjkmi0d1zCipXdpPMTNMcrV279CJrpbsiwfvBSNlwZFvNeucmjAIDo4rkoFSUh+ROmMHjTj/JtXK/yVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fs8UmJ7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8051FC2BCB1;
	Mon, 30 Mar 2026 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774868764;
	bh=mWPE/a2Z8beZhjw4qHmFBhKhZobM6LgiFw5racoE/EQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Fs8UmJ7sYNwozwn5iSEyX16aduM+2LXtXZArSK8IvUWQ7Iq+6OuPUrnEi5SW1jGZk
	 74oPt3HHxutJUlWk5RfmCgkwlzxCu/8oPinBerqpexYbhGFCZIyrkZoL8GlKYdYbHc
	 xKIy8UpaHImRuCyuiXjtyJvkG47IwiIFmIA7JxVk=
Subject: FAILED: patch "[PATCH] ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths" failed to apply to 5.10-stable tree
To: libaokun@linux.alibaba.com,jack@suse.cz,joseph.qi@linux.alibaba.com,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 13:06:01 +0200
Message-ID: <2026033001-credibly-reclining-650d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231177-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,alibaba.com:email,msgid.link:url,gregkh:email,huawei.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EDA77359EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ec0a7500d8eace5b4f305fa0c594dd148f0e8d29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033001-credibly-reclining-650d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec0a7500d8eace5b4f305fa0c594dd148f0e8d29 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun@linux.alibaba.com>
Date: Mon, 23 Mar 2026 14:08:36 +0800
Subject: [PATCH] ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths

During code review, Joseph found that ext4_fc_replay_inode() calls
ext4_get_fc_inode_loc() to get the inode location, which holds a
reference to iloc.bh that must be released via brelse().

However, several error paths jump to the 'out' label without
releasing iloc.bh:

 - ext4_handle_dirty_metadata() failure
 - sync_dirty_buffer() failure
 - ext4_mark_inode_used() failure
 - ext4_iget() failure

Fix this by introducing an 'out_brelse' label placed just before
the existing 'out' label to ensure iloc.bh is always released.

Additionally, make ext4_fc_replay_inode() propagate errors
properly instead of always returning 0.

Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260323060836.3452660-1-libaokun@linux.alibaba.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 6e949c21842d..2f0057e04934 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1613,19 +1613,21 @@ static int ext4_fc_replay_inode(struct super_block *sb,
 	/* Immediately update the inode on disk. */
 	ret = ext4_handle_dirty_metadata(NULL, NULL, iloc.bh);
 	if (ret)
-		goto out;
+		goto out_brelse;
 	ret = sync_dirty_buffer(iloc.bh);
 	if (ret)
-		goto out;
+		goto out_brelse;
 	ret = ext4_mark_inode_used(sb, ino);
 	if (ret)
-		goto out;
+		goto out_brelse;
 
 	/* Given that we just wrote the inode on disk, this SHOULD succeed. */
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		ext4_debug("Inode not found.");
-		return -EFSCORRUPTED;
+		inode = NULL;
+		ret = -EFSCORRUPTED;
+		goto out_brelse;
 	}
 
 	/*
@@ -1642,13 +1644,14 @@ static int ext4_fc_replay_inode(struct super_block *sb,
 	ext4_inode_csum_set(inode, ext4_raw_inode(&iloc), EXT4_I(inode));
 	ret = ext4_handle_dirty_metadata(NULL, NULL, iloc.bh);
 	sync_dirty_buffer(iloc.bh);
+out_brelse:
 	brelse(iloc.bh);
 out:
 	iput(inode);
 	if (!ret)
 		blkdev_issue_flush(sb->s_bdev);
 
-	return 0;
+	return ret;
 }
 
 /*


