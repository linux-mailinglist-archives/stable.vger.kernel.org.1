Return-Path: <stable+bounces-234223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN4eLiud1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA33C092A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BECE2301BC08
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCC924B28;
	Wed,  8 Apr 2026 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IsTzGUVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D762494F0;
	Wed,  8 Apr 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672301; cv=none; b=c9m33JHkdv8KiMUe74eSLnOXZGjWV2TpVpsF+S6qTCSL9ArSJWKrPAGAIKuVdviNpXeNBLvbN0/JZXFVF5+jKtzSPvIbPBNXJx7CuU1//S+gPnZQNKFClUnAAqrJX5IW1ccrRMdqHrubPgCduBKeTs4ESNhJAOs4vFE1A0a7ipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672301; c=relaxed/simple;
	bh=HMids3lujWR1PKHPlYYmBGTcK+RvRlLn/CKtdZj19BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXjy5IBM8I0Eg6lxbiIwMFM1cW1xBrayNjO0EoMWRV5qUhzMAeKdQ4TLO/+6PBaVIlpd3ET5UfLgJoajWixWG09lVHJilEZKwMd9GbdqUgxIvAZHq705aJFqK7HMirm0Z5Bov87wDa6pr6W8FKtzkaGVHNGXfcRPxNdUm7ZOyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IsTzGUVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EF6C19421;
	Wed,  8 Apr 2026 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672301;
	bh=HMids3lujWR1PKHPlYYmBGTcK+RvRlLn/CKtdZj19BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsTzGUVkfKM7gRIYLrrX+9CA4wmwY9jLy+xGjIqhsjv2b84hy1C728VrtFfOPWTxe
	 740qpXpCnuw/rQgvbkDB0+KG7IztWFPAWqtLim9M+LySVzzScY2W5zXaqn+b+LO5r1
	 aFnNurQuNPFbrLtf83mLSDlCDoUTgWG1WeX7pcAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 234/312] Revert "ext4: avoid infinite loops caused by residual data"
Date: Wed,  8 Apr 2026 20:02:31 +0200
Message-ID: <20260408175942.493312250@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234223-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 15FA33C092A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 4fee3f2f4839571a6294946a2efcdb69caa61393.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 42a06360086a8..bb27c04798d2b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4424,13 +4424,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
-		/*
-		 * Gracefully handle out of space conditions. If the filesystem
-		 * is inconsistent, we'll just leak allocated blocks to avoid
-		 * causing even more damage.
-		 */
-		if (allocated_clusters && (err == -EDQUOT || err == -ENOSPC)) {
+		if (allocated_clusters) {
 			int fb_flags = 0;
+
 			/*
 			 * free data blocks we just allocated.
 			 * not a good idea to call discard here directly,
-- 
2.53.0




