Return-Path: <stable+bounces-224232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCl9NYsBsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C14624AF9C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E019130F9373
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327DF3803EA;
	Tue, 10 Mar 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcY+KD6O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9408387361;
	Tue, 10 Mar 2026 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141930; cv=none; b=d/SGmyBGVabb1ZcGFv2N/HLZpB49SbaKOJlBHdt+FmLV8yrJHzbm9QKM7jZ+60NRo9GnJuxIP2dfYzUMW6exQVEWZhDnRCM6bFb+/NLKaaaNqNVVnDIauhYlMAlalifuZ+pUPCmQIdBG2FBSZrcQsQMXy36QNSamzPgIr75csrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141930; c=relaxed/simple;
	bh=/7eX8/sxEh/PPFkfM1+1W/qGcMZSZrQuxHPQm77rBNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcdSloiRlNISyPkGRFM1OrVvzAx/t77z4kUG8giUkw1z6HM10wYMbEBGwZqFVPLcWxB6ZvMffmM7OebZkWCKQ6/g4otDfHVhI222L29aDNAh4VFNIcR+n+ymj0nwu0NCqFI7BJK8UZcSswJULXNrbEPC5S+wTkeaM6O6KSmOvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcY+KD6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1008CC2BC9E;
	Tue, 10 Mar 2026 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141929;
	bh=/7eX8/sxEh/PPFkfM1+1W/qGcMZSZrQuxHPQm77rBNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcY+KD6OUcwFGhUqA5QQn7Vqv9ThLJbdPslQZVI64p10DDLYGX3ZUNDmN8e3Cf5+Z
	 xfZp1zzGdjEc6pjPeIPUXsVRduBGQlIeYvyYHOYFXhe3QqYyqJMaEzkYh/RfISCILz
	 ju2AYbZ/SQYRtghuIZ5RrRkvh8WpZKp3M1WKM2vwzlSLoh5D9ptlKZJ2OaDbcOnz1/
	 tkQnfwhp+i9cN1QzYWjRlTvo4arhWWhhomg3bGAzk2RpYZY/Y11uJFTHO9jnBUH0oQ
	 cc1kdJXQkR1NcbbfaZE1sZoLStga4c4bvvIbBSih/R6nPFMRs6vnnoCY08gZru2DXW
	 dhdgnzDPMaj4g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 053/314] btrfs: free pages on error in btrfs_uring_read_extent()
Date: Tue, 10 Mar 2026 07:15:12 -0400
Message-ID: <11787e6cf97a810a0ac3a7a15f2843aa04807c58.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C14624AF9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224232-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

From: Miquel Sabaté Solà <mssola@mssola.com>

[ Upstream commit 3f501412f2079ca14bf68a18d80a2b7a823f1f64 ]

In this function the 'pages' object is never freed in the hopes that it is
picked up by btrfs_uring_read_finished() whenever that executes in the
future. But that's just the happy path. Along the way previous
allocations might have gone wrong, or we might not get -EIOCBQUEUED from
btrfs_encoded_read_regular_fill_pages(). In all these cases, we go to a
cleanup section that frees all memory allocated by this function without
assuming any deferred execution, and this also needs to happen for the
'pages' allocation.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9a34d6530658e..736a1b3170700 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4725,7 +4725,7 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(iocb->ki_filp));
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	struct page **pages;
+	struct page **pages = NULL;
 	struct btrfs_uring_priv *priv = NULL;
 	unsigned long nr_pages;
 	int ret;
@@ -4783,6 +4783,11 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 	btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	kfree(priv);
+	for (int i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			__free_page(pages[i]);
+	}
+	kfree(pages);
 	return ret;
 }
 
-- 
2.51.0


