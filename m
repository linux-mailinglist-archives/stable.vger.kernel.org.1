Return-Path: <stable+bounces-4075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939C8045E3
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45B11F2138A
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33B79E3;
	Tue,  5 Dec 2023 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p8p1cA2B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06546AA0;
	Tue,  5 Dec 2023 03:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE5CC433C8;
	Tue,  5 Dec 2023 03:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746553;
	bh=rHOlzD0/qyoxjajWJ3Mb9bn1cQymlxJhBJnOn+Aqq4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8p1cA2Bb2FGTjwAGDsE3xdPL57KppE9br8ErDGwJ0mWsFpZUhLLFgHtMuPw+LJGG
	 x+TkpSfOq+Mn3tkGe4sxjxMS22HtEVb11ovuJ0zk0oK7quaO5Y184z3im0I4Ypxd/P
	 PZnmk76Ej7A6ZTJW24/Q+YiRcYGjedYonD5VWLv0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 068/134] btrfs: make error messages more clear when getting a chunk map
Date: Tue,  5 Dec 2023 12:15:40 +0900
Message-ID: <20231205031539.854606842@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 7d410d5efe04e42a6cd959bfe6d59d559fdf8b25 upstream.

When getting a chunk map, at btrfs_get_chunk_map(), we do some sanity
checks to verify we found a chunk map and that map found covers the
logical address the caller passed in. However the messages aren't very
clear in the sense that don't mention the issue is with a chunk map and
one of them prints the 'length' argument as if it were the end offset of
the requested range (while the in the string format we use %llu-%llu
which suggests a range, and the second %llu-%llu is actually a range for
the chunk map). So improve these two details in the error messages.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3045,15 +3045,16 @@ struct extent_map *btrfs_get_chunk_map(s
 	read_unlock(&em_tree->lock);
 
 	if (!em) {
-		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
+		btrfs_crit(fs_info,
+			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
-			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
-			   logical, length, em->start, em->start + em->len);
+			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
+			   logical, logical + length, em->start, em->start + em->len);
 		free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}



