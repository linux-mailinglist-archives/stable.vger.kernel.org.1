Return-Path: <stable+bounces-220385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP16G1c2o2lG+gQAu9opvQ
	(envelope-from <stable+bounces-220385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5ED1C6116
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A9DF30FDBF3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E43A7159;
	Sat, 28 Feb 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSdR9kr3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23683A7152;
	Sat, 28 Feb 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300279; cv=none; b=PC2OFK0fIIAlIfTBxeomPVaU9+URiBCwbEvi495yJIF85yGw+SUYDI6Z30HIB/gzJAKMaGPfD9O7lJDO7KBupzRhq+EMxIrawm38ZT0yskgRkhbSODVnAlsmlFtdd/dbPGcM2iMItlAvYffRdS8mThVqZU9MkcuksC/xu11jfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300279; c=relaxed/simple;
	bh=HN4EfW9F7yvRr7y8ctW1zUJ0R/d77Dw9QTlI2qKEDIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvJSWkbJRRG4xiPewtWs0LN4pTiVHZ616rnmQFjpjeg9Qdh1slzc8CzevBDATOiwBL7PqXl3I5qt/1phsYE5Dwl2kGgpYeYYKwe+OX3+XcWpmSjMXEDpFhu1BZhBSyOsW3qHmlAQUlJ++vqVX5OvGo738TiGNX+b+/rnp35G0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSdR9kr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134B3C19425;
	Sat, 28 Feb 2026 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300278;
	bh=HN4EfW9F7yvRr7y8ctW1zUJ0R/d77Dw9QTlI2qKEDIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSdR9kr3p72r6jldzzmapB3qdyzFdFvdiPSlh1pnu+w+KRCYBbQhNxWboXaWTU9f+
	 fMlynGOgbd5P1LSKUQx4SUEzpAVR0+yqMxJQl/EE5cLW/Q9Vbbec1qiPlIVfg/sARf
	 Rc+hHRL2WTXx+3c/Piw0XoW3EHzHitc8fwrJ/wgUoRCwkTzFZ8lQ8G3OFaCG5532v8
	 fx1tkEg76ET9h4T/DLxwLOU6BjFSYLHen2ETxIBNmpmlV7l+0ZdXpCISRrtvCkwZR0
	 X3DVVBD5N28RPyVLkhQlC1qINs6E2532d7uA/pN7oaZiSaV76t7IaztaVaRVcmfhBS
	 tz4/MrYnJ3XcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 306/844] ext4: propagate flags to convert_initialized_extent()
Date: Sat, 28 Feb 2026 12:23:39 -0500
Message-ID: <20260228173244.1509663-307-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220385-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EC5ED1C6116
X-Rspamd-Action: no action

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 3fffa44b6ebf65be92a562a5063303979385a1c9 ]

Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
extents however this is not respected by convert_initialized_extent().
Hence, modify it to accept flags from the caller and to pass the flags
on to other extent manipulation functions it calls. This makes
sure the NOCACHE flag is respected throughout the code path.

Also, we no longer explicitly pass CONVERT_UNWRITTEN as the caller takes
care of this.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/07008fbb14db727fddcaf4c30e2346c49f6c8fe0.1769149131.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 418c4351ef40c..986e85902d06a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3857,6 +3857,7 @@ static struct ext4_ext_path *
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
 			   struct ext4_ext_path *path,
+			   int flags,
 			   unsigned int *allocated)
 {
 	struct ext4_extent *ex;
@@ -3882,11 +3883,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-		path = ext4_find_extent(inode, map->m_lblk, path, 0);
+		path = ext4_find_extent(inode, map->m_lblk, path, flags);
 		if (IS_ERR(path))
 			return path;
 		depth = ext_depth(inode);
@@ -4298,7 +4299,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
 				path = convert_initialized_extent(handle,
-					inode, map, path, &allocated);
+					inode, map, path, flags, &allocated);
 				if (IS_ERR(path))
 					err = PTR_ERR(path);
 				goto out;
-- 
2.51.0


