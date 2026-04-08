Return-Path: <stable+bounces-234190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOf0AJSc1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:21:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FBB3C0774
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC09309C65E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13153D9033;
	Wed,  8 Apr 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nPnkY7Tv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B103D8907;
	Wed,  8 Apr 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672216; cv=none; b=YuBHu5bERFhOUscyvn2SQxw3FbKTGLWa0eDD2So7xaeu2SdxJbtlPW8zHG3ijl7RWjht1arFRclcFVGUWggLdU/2O//DCySpfC6DkxvvYVN4QJcK9kKzNZLtWO1tgBlCWTfy/QxZpdsCBOUg7jTCcasa+fqf+UKEzuoXDWzR5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672216; c=relaxed/simple;
	bh=7PXe5XEyGf96as/aRkmdNnga09Iu0PrhrudTPeoi/s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO7QyXcAb/hCHWJgjbzdcc8lpYk338xXnlLt6wS1c0qFTAuxhi5Cd3hM6d50UDFiSxtdB9TSBrvmQsT79eMy/mPpVjYxnZBRT6Itqtxe4gXhSbAjmTBEO5LfLFVEpBsfzuv+0S5dpyIlNBKiNL79jFbsU+Ek8uglP7mSHSduYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nPnkY7Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09012C19421;
	Wed,  8 Apr 2026 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672216;
	bh=7PXe5XEyGf96as/aRkmdNnga09Iu0PrhrudTPeoi/s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPnkY7Tv7ZgoKJrsPWuEh2/ZhEFXfQ75QGvABpMyJcEYZ/Pjtp53AOk/xUDYoxlRW
	 TUradz2vkqkXUE1WwNEdceuXlNJHUQHzwhlABRDzfXfZWFWfsRnHwqROoUtODYC8Cs
	 JLic2klqDvCDqRJ3KhcVXNZr6S3mYoUwBMsf72aE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 235/312] Revert "ext4: drop extent cache when splitting extent fails"
Date: Wed,  8 Apr 2026 20:02:32 +0200
Message-ID: <20260408175942.529389949@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234190-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53FBB3C0774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit de8e1b17e3876a44c4537bff0bc2dfd244efe8d9.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bb27c04798d2b..30b0b25aac9ff 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3252,7 +3252,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 
 	err = PTR_ERR(path);
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
-		goto out_path;
+		return path;
 
 	/*
 	 * Get a new path to try to zeroout or fix the extent length.
@@ -3266,7 +3266,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		goto out_path;
+		return path;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3343,10 +3343,6 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		ext4_free_ext_path(path);
 		path = ERR_PTR(err);
 	}
-out_path:
-	if (IS_ERR(path))
-		/* Remove all remaining potentially stale extents. */
-		ext4_es_remove_extent(inode, ee_block, ee_len);
 	ext4_ext_show_leaf(inode, path);
 	return path;
 }
-- 
2.53.0




