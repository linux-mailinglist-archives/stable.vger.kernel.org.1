Return-Path: <stable+bounces-221072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KUuBI5No2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6061C82D2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A446131A4745
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F98301F14;
	Sat, 28 Feb 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4lsS0l1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F36175A62;
	Sat, 28 Feb 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301417; cv=none; b=bTEo9MPn94DZwRSkOgTRvnK697BwaoRP0M7Ss+SsPokLZ+jqUuOFOFXtxk8E8xitRqjaOfrWmeOQIRO/Ny9ob5sgE8qmM1K8Ze1mA5jL5beFWPz438YIqpCVbhluaP+Xy883DqWAuMWyMvSCsl+9PwE6tfpz6xGR2HESwC8vmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301417; c=relaxed/simple;
	bh=YHuZmIjUa2BPlEXI0I2i4kyZQxQRN6TdlgoXeGuLW00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMC5Q04BtveI1DXbOZrsrI5+WXdAT1XAYU95rQYpjWF9kVXZQlcIgeYxHXInEM4ML6kLv4pPZQc2ToS5eXD4VypiAxOnpGwRDu+FXMaVwmNsDKdaqdcc37h4OqKQoRjVmW/QaILKEkGBx34eUdJUG4VgiORJqwZBZExMhKIfRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4lsS0l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82702C116D0;
	Sat, 28 Feb 2026 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301417;
	bh=YHuZmIjUa2BPlEXI0I2i4kyZQxQRN6TdlgoXeGuLW00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4lsS0l1kB/8Zs6/zh1z8v7pLJJX1SHG+YyLQFjuyzcEtNVUzD0xsFjzdkhGttjMB
	 +NEJQ7VkU9ASaUE6bxrTUhhqAgXr1Rz7C5t30Uj7GwWqq8NO5BNiiZZ3SXxaekdWD6
	 YjJITttoBy/u4Q++Neav6NL0+cA/+mBLC3VC+AXXYYRaIHoYkJpE2dDrkV3x/+2ysJ
	 7lERtkpEMI1Ln79qNeg7P5WiB0xIaQbeGcryxpCudmZTd3fOmh390QF1Uni7UzdpoK
	 NFLvUf/JHquN8y8QygxHnwBeyk0JYk0vD/ugoOVn6GRJoRZzy8i5rvZ9q/TOuEuj6/
	 gOPg237TuyCJA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 606/752] xfs: delete attr leaf freemap entries when empty
Date: Sat, 28 Feb 2026 12:45:17 -0500
Message-ID: <20260228174750.1542406-606-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221072-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 9F6061C82D2
X-Rspamd-Action: no action

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 6f13c1d2a6271c2e73226864a0e83de2770b6f34 ]

Back in commit 2a2b5932db6758 ("xfs: fix attr leaf header freemap.size
underflow"), Brian Foster observed that it's possible for a small
freemap at the end of the end of the xattr entries array to experience
a size underflow when subtracting the space consumed by an expansion of
the entries array.  There are only three freemap entries, which means
that it is not a complete index of all free space in the leaf block.

This code can leave behind a zero-length freemap entry with a nonzero
base.  Subsequent setxattr operations can increase the base up to the
point that it overlaps with another freemap entry.  This isn't in and of
itself a problem because the code in _leaf_add that finds free space
ignores any freemap entry with zero size.

However, there's another bug in the freemap update code in _leaf_add,
which is that it fails to update a freemap entry that begins midway
through the xattr entry that was just appended to the array.  That can
result in the freemap containing two entries with the same base but
different sizes (0 for the "pushed-up" entry, nonzero for the entry
that's actually tracking free space).  A subsequent _leaf_add can then
allocate xattr namevalue entries on top of the entries array, leading to
data loss.  But fixing that is for later.

For now, eliminate the possibility of confusion by zeroing out the base
of any freemap entry that has zero size.  Because the freemap is not
intended to be a complete index of free space, a subsequent failure to
find any free space for a new xattr will trigger block compaction, which
regenerates the freemap.

It looks like this bug has been in the codebase for quite a long time.

Cc: <stable@vger.kernel.org> # v2.6.12
Fixes: 1da177e4c3f415 ("Linux-2.6.12-rc2")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 91c1b30ebaab3..33c6c468ad8d5 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1580,6 +1580,19 @@ xfs_attr3_leaf_add_work(
 				min_t(uint16_t, ichdr->freemap[i].size,
 						sizeof(xfs_attr_leaf_entry_t));
 		}
+
+		/*
+		 * Don't leave zero-length freemaps with nonzero base lying
+		 * around, because we don't want the code in _remove that
+		 * matches on base address to get confused and create
+		 * overlapping freemaps.  If we end up with no freemap entries
+		 * then the next _add will compact the leaf block and
+		 * regenerate the freemaps.
+		 */
+		if (ichdr->freemap[i].size == 0 && ichdr->freemap[i].base > 0) {
+			ichdr->freemap[i].base = 0;
+			ichdr->holes = 1;
+		}
 	}
 	ichdr->usedbytes += xfs_attr_leaf_entsize(leaf, args->index);
 }
-- 
2.51.0


