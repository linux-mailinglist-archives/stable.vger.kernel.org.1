Return-Path: <stable+bounces-170977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE5EB2A6C3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B527BA6CB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C20319847;
	Mon, 18 Aug 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xPvb/aUR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8430F52C;
	Mon, 18 Aug 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524413; cv=none; b=BiCYMP26KwPfbYU6xHAeJL/1TO/7X/htKN56dKE5VEcBVQiteH+Ty1HMOw05uFbLrqoGXPACzFOimQ7mk10fTyRSoURNYUvbqpFv4roTbVRpwAgcTzc3zsH5OGcwHiKoPVGDaqT7fSLNfebCjGjJUaJ5Wd45dj6S8nGtKqFyYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524413; c=relaxed/simple;
	bh=bJnaTynGnAkzZc/I+dxjW9O0aKT3bWqHjS4cU28Zp48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjN9t0ssSNgfgFAvjrZofCnaRo7UpCsMuib2tPEyfaLjqGK9jJnHycqMALgZUsC+BtECoTyY3hKVJgAe04a/dA74BNczDir8if6+f2Sk+mQ4gXHpTx1TssbBmi/FOQFdws9SbD4BXyqaCxsrbUsEaM/PYtrI9HUGptfPm6gxRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xPvb/aUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D28C4CEEB;
	Mon, 18 Aug 2025 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524412;
	bh=bJnaTynGnAkzZc/I+dxjW9O0aKT3bWqHjS4cU28Zp48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xPvb/aURBhGdL44SUQazuXLDkeUPKRRPrX2D7IuXkE/LXrYOrejqYSaEqwYXAUPkb
	 QOxI6qSZqKlt2XUjWctGBj9swIC4Bm9t6Rliw/VaGBpPzBbbhiioY7oh0eOOIpSsC5
	 H7cUui2uRksrnw1awP3EE0WQ0Ga8CdofwBZPcqQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.15 463/515] btrfs: abort transaction during log replay if walk_log_tree() failed
Date: Mon, 18 Aug 2025 14:47:29 +0200
Message-ID: <20250818124516.244233250@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 2a5898c4aac67494c2f0f7fe38373c95c371c930 upstream.

If we failed walking a log tree during replay, we have a missing
transaction abort to prevent committing a transaction where we didn't
fully replay all the changes from a log tree and therefore can leave the
respective subvolume tree in some inconsistent state. So add the missing
transaction abort.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7276,11 +7276,14 @@ again:
 
 		wc.replay_dest->log_root = log;
 		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
-		if (ret)
+		if (ret) {
 			/* The loop needs to continue due to the root refs */
 			btrfs_abort_transaction(trans, ret);
-		else
+		} else {
 			ret = walk_log_tree(trans, log, &wc);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
+		}
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,



