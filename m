Return-Path: <stable+bounces-217972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP0yOfwbnmntTQQAu9opvQ
	(envelope-from <stable+bounces-217972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:45:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A660118CE8B
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F320A30B7834
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44FA33EB02;
	Tue, 24 Feb 2026 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yy7qt4U6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98807226D00
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969477; cv=none; b=TtYyeK+Mhm2TwlhC7/jbXkyvoDCqmhy6Mj+7FqwF/ueCi8crTjvPoFvHn3IM6bGEcS3E31Id3TqrFZ/fIn51bzSwq3fJZOeeQekFxilOGrGhyYikOa5DmTVt15hmdMNdHqE13Oz90BdRNZMDhIIw9aBBv8SspbD+IcrrvNHftJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969477; c=relaxed/simple;
	bh=HIq69EaVhXsOKFm3PqSGWtpy8HKdkdWnPHgVyndWUwg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l6DxLPy3EWAt7OwkaTnlkh+kQprO1OYtV4QknJHceZOliHOVpzo3phJHHuP9K2cz+yRGfkGFBjtPDiFSjDlKeqiIL1vPfRNdZn3wIIGagU+zWhgvEABREeKVpj1fmuzhfGrNyGxSOwHozQINqvKOC7kN6u32nyCcNH8Qi4wofUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yy7qt4U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59188C116D0;
	Tue, 24 Feb 2026 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969477;
	bh=HIq69EaVhXsOKFm3PqSGWtpy8HKdkdWnPHgVyndWUwg=;
	h=Subject:To:Cc:From:Date:From;
	b=Yy7qt4U6vXmj+IWT0lcDhMs3cD1IpvSX+uByglpd3JuhCXXtR6m1pYFdQGNZo8Z/a
	 TZZDONaPlDDULxuv/eUthXGDes2OOo6rTgddU1/gxdcT+f1diZzhigohgqJV31T47T
	 GspoUceFAnJUh9PFUmFl3fpRCbfoPCv97dmZ3w9o=
Subject: FAILED: patch "[PATCH] ext4: drop extent cache when splitting extent fails" failed to apply to 6.1-stable tree
To: yi.zhang@huawei.com,libaokun1@huawei.com,ojaswin@linux.ibm.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:44:29 -0800
Message-ID: <2026022428-arrogant-refill-c828@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217972-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,huawei.com:email]
X-Rspamd-Queue-Id: A660118CE8B
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 79b592e8f1b435796cbc2722190368e3e8ffd7a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022428-arrogant-refill-c828@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79b592e8f1b435796cbc2722190368e3e8ffd7a1 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 29 Nov 2025 18:32:39 +0800
Subject: [PATCH] ext4: drop extent cache when splitting extent fails

When the split extent fails, we might leave some extents still being
processed and return an error directly, which will result in stale
extent entries remaining in the extent status tree. So drop all of the
remaining potentially stale extents if the splitting fails.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Message-ID: <20251129103247.686136-8-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1094e4923451..945995d68c4d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3267,7 +3267,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 
 	err = PTR_ERR(path);
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
-		return path;
+		goto out_path;
 
 	/*
 	 * Get a new path to try to zeroout or fix the extent length.
@@ -3281,7 +3281,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		return path;
+		goto out_path;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3358,6 +3358,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		ext4_free_ext_path(path);
 		path = ERR_PTR(err);
 	}
+out_path:
+	if (IS_ERR(path))
+		/* Remove all remaining potentially stale extents. */
+		ext4_es_remove_extent(inode, ee_block, ee_len);
 	ext4_ext_show_leaf(inode, path);
 	return path;
 }


