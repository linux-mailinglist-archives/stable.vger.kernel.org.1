Return-Path: <stable+bounces-218797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PlkJ2xVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:50:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934D190018
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EED7321AE23
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B92F25EF9C;
	Wed, 25 Feb 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FD8ONlih"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333926CE1A;
	Wed, 25 Feb 2026 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983673; cv=none; b=Z9OWBEO8qSCG4KRPPCzETIXfWlWpArndq+pPZ0qHW3vjDAD6eX6sZTM+hIyXTSHM1LBoKuI2M+KgFEJDu+BblI9lFGJN9tQ0/uyym81Pp5DIhYdmJrMY8mSpLTMTPVjlg5EQhAz4B92NuVXK4Wr/eEbs66Iq97d3AdvdHXKY3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983673; c=relaxed/simple;
	bh=k3JELUXMTEHML+CbDHUV8jZTBpizpDLnnGy6qQJRVvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stAD1C3cVkQZtmrmyygWlWpoEHm9uYOcluzdlIUeMU5j7kiknWsTHRqCnJoYvG+FCPFuUHASivrSoDkms9t34EJQNLKO/f//fnxt+Ggnhcd+jj+z/fNObxYX4IEbna0LPA1+bw7gZPKFFndg+ICuFh1RAyc0QCphM1PCArln+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FD8ONlih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5ABC116D0;
	Wed, 25 Feb 2026 01:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983673;
	bh=k3JELUXMTEHML+CbDHUV8jZTBpizpDLnnGy6qQJRVvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FD8ONlihR1vppEy8csg/YmfypPCExf5WFOdoEJSVxddsynIEs0ItFrZcfl+i99RdO
	 6SKdPu10h1FI4FJyP33kVFMxabOtK8yATX69eWDtXOc+9KnzagkatDdb+fbzYoBodC
	 jH+OqqKP0Q9FJz/8SIYLZjS/mIKaNm1NVS+5ozxU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.19 759/781] ext4: drop extent cache when splitting extent fails
Date: Tue, 24 Feb 2026 17:24:28 -0800
Message-ID: <20260225012418.333087565@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218797-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,huaweicloud.com:email]
X-Rspamd-Queue-Id: 4934D190018
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit 79b592e8f1b435796cbc2722190368e3e8ffd7a1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3267,7 +3267,7 @@ static struct ext4_ext_path *ext4_split_
 
 	err = PTR_ERR(path);
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
-		return path;
+		goto out_path;
 
 	/*
 	 * Get a new path to try to zeroout or fix the extent length.
@@ -3281,7 +3281,7 @@ static struct ext4_ext_path *ext4_split_
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		return path;
+		goto out_path;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3358,6 +3358,10 @@ out:
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



