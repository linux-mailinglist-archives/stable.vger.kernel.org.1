Return-Path: <stable+bounces-220759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDO6DyJEo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:38:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E861C732C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE32B32ACAB6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD3405995;
	Sat, 28 Feb 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEARsXub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9B40598D;
	Sat, 28 Feb 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300639; cv=none; b=oyf1BhlZJFPKjwynAu9BIYOylvuHpFf9ksVMHh90YY0kNI+B+Ra62DeH9oOr7C1YAJVK9W+YFom7d45fU8jVvfzvmOKp84jJSlI/cJzY0q38MRXDxlpanm43vTZCtNs01/Wj9Y0TjVjkDMtceNtefw6FTgdjIHw+X+gRxvQEBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300639; c=relaxed/simple;
	bh=1SCvZYGLN1+S53XWG957Hu6A7osok9Yn5DZDvXwHEXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN5xZwysGT1W5mGuVIUlRCVP6uRMQ+6kS74LecUm3LlhlFNXfL0R02HOgGArV/zpDdrEAoCPtEvn/UhPars4uYn0Iec2/HoLPqOCLfKc0VqFxHqIC4chhMnmOi5QDMRvvWQWsZo21uhTz3m1GTFYLgm1BqyqLxUkZYdK5h6PNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEARsXub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1908C116D0;
	Sat, 28 Feb 2026 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300639;
	bh=1SCvZYGLN1+S53XWG957Hu6A7osok9Yn5DZDvXwHEXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEARsXubCN8y+O5meWRNc2R6OwbSWgSAp4QSyJz9/QMnTYkqKLRyIwrWN/YVGW38m
	 zAgXTsXpADnVSqgQPM4fswRKGaosTqLkseFdxVyvJDLWQPgmDE4gPwvJRcbR0vsqaV
	 Cgjrs56/459pzNTxIsEN/DM/zAVGLmFJydccjUcLFiSSRmgUrM4oKZ5qO+1750aW4p
	 o3XVo+xVm++6DcA5GGNMyTfXsAwBVz0pOBl8Ynm2KMONO6wuK4xYwaOh8/jXJdwEPh
	 mGHI2U/VrOQ95bwgcqk3q4LkXqr+xxBgwPPI5FjtMohWNmTHsuXXtAnOMp5OiV5a5E
	 3oLmkN+IjmO4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 680/844] xfs: fix freemap adjustments when adding xattrs to leaf blocks
Date: Sat, 28 Feb 2026 12:29:53 -0500
Message-ID: <20260228173244.1509663-681-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220759-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60E861C732C
X-Rspamd-Action: no action

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 3eefc0c2b78444b64feeb3783c017d6adc3cd3ce ]

xfs/592 and xfs/794 both trip this assertion in the leaf block freemap
adjustment code after ~20 minutes of running on my test VMs:

 ASSERT(ichdr->firstused >= ichdr->count * sizeof(xfs_attr_leaf_entry_t)
					+ xfs_attr3_leaf_hdr_size(leaf));

Upon enabling quite a lot more debugging code, I narrowed this down to
fsstress trying to set a local extended attribute with namelen=3 and
valuelen=71.  This results in an entry size of 80 bytes.

At the start of xfs_attr3_leaf_add_work, the freemap looks like this:

i 0 base 448 size 0 rhs 448 count 46
i 1 base 388 size 132 rhs 448 count 46
i 2 base 2120 size 4 rhs 448 count 46
firstused = 520

where "rhs" is the first byte past the end of the leaf entry array.
This is inconsistent -- the entries array ends at byte 448, but
freemap[1] says there's free space starting at byte 388!

By the end of the function, the freemap is in worse shape:

i 0 base 456 size 0 rhs 456 count 47
i 1 base 388 size 52 rhs 456 count 47
i 2 base 2120 size 4 rhs 456 count 47
firstused = 440

Important note: 388 is not aligned with the entries array element size
of 8 bytes.

Based on the incorrect freemap, the name area starts at byte 440, which
is below the end of the entries array!  That's why the assertion
triggers and the filesystem shuts down.

How did we end up here?  First, recall from the previous patch that the
freemap array in an xattr leaf block is not intended to be a
comprehensive map of all free space in the leaf block.  In other words,
it's perfectly legal to have a leaf block with:

 * 376 bytes in use by the entries array
 * freemap[0] has [base = 376, size = 8]
 * freemap[1] has [base = 388, size = 1500]
 * the space between 376 and 388 is free, but the freemap stopped
   tracking that some time ago

If we add one xattr, the entries array grows to 384 bytes, and
freemap[0] becomes [base = 384, size = 0].  So far, so good.  But if we
add a second xattr, the entries array grows to 392 bytes, and freemap[0]
gets pushed up to [base = 392, size = 0].  This is bad, because
freemap[1] hasn't been updated, and now the entries array and the free
space claim the same space.

The fix here is to adjust all freemap entries so that none of them
collide with the entries array.  Note that this fix relies on commit
2a2b5932db6758 ("xfs: fix attr leaf header freemap.size underflow") and
the previous patch that resets zero length freemap entries to have
base = 0.

Cc: <stable@vger.kernel.org> # v2.6.12
Fixes: 1da177e4c3f415 ("Linux-2.6.12-rc2")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 33c6c468ad8d5..b858e3c2ad50a 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1476,6 +1476,7 @@ xfs_attr3_leaf_add_work(
 	struct xfs_attr_leaf_name_local *name_loc;
 	struct xfs_attr_leaf_name_remote *name_rmt;
 	struct xfs_mount	*mp;
+	int			old_end, new_end;
 	int			tmp;
 	int			i;
 
@@ -1568,17 +1569,36 @@ xfs_attr3_leaf_add_work(
 	if (be16_to_cpu(entry->nameidx) < ichdr->firstused)
 		ichdr->firstused = be16_to_cpu(entry->nameidx);
 
-	ASSERT(ichdr->firstused >= ichdr->count * sizeof(xfs_attr_leaf_entry_t)
-					+ xfs_attr3_leaf_hdr_size(leaf));
-	tmp = (ichdr->count - 1) * sizeof(xfs_attr_leaf_entry_t)
-					+ xfs_attr3_leaf_hdr_size(leaf);
+	new_end = ichdr->count * sizeof(struct xfs_attr_leaf_entry) +
+					xfs_attr3_leaf_hdr_size(leaf);
+	old_end = new_end - sizeof(struct xfs_attr_leaf_entry);
+
+	ASSERT(ichdr->firstused >= new_end);
 
 	for (i = 0; i < XFS_ATTR_LEAF_MAPSIZE; i++) {
-		if (ichdr->freemap[i].base == tmp) {
-			ichdr->freemap[i].base += sizeof(xfs_attr_leaf_entry_t);
+		int		diff = 0;
+
+		if (ichdr->freemap[i].base == old_end) {
+			/*
+			 * This freemap entry starts at the old end of the
+			 * leaf entry array, so we need to adjust its base
+			 * upward to accomodate the larger array.
+			 */
+			diff = sizeof(struct xfs_attr_leaf_entry);
+		} else if (ichdr->freemap[i].size > 0 &&
+			   ichdr->freemap[i].base < new_end) {
+			/*
+			 * This freemap entry starts in the space claimed by
+			 * the new leaf entry.  Adjust its base upward to
+			 * reflect that.
+			 */
+			diff = new_end - ichdr->freemap[i].base;
+		}
+
+		if (diff) {
+			ichdr->freemap[i].base += diff;
 			ichdr->freemap[i].size -=
-				min_t(uint16_t, ichdr->freemap[i].size,
-						sizeof(xfs_attr_leaf_entry_t));
+				min_t(uint16_t, ichdr->freemap[i].size, diff);
 		}
 
 		/*
-- 
2.51.0


