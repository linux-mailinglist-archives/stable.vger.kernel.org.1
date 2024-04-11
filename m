Return-Path: <stable+bounces-38648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91778A0FB2
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B1E1F28835
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CC14600E;
	Thu, 11 Apr 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTB5swJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941A13FD94;
	Thu, 11 Apr 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831187; cv=none; b=IufbinhK8G7k7PVUGKNmuX8VHzrL0dCPfScDKZ6yEc3mcKRt3MSwuMBlrQxNebMudunkB2INk+kOKZgusKQVGbqt8trH1t12S1qkFgYZo7fM8W3PTtNi5EXW+UlKBBHcwkDwl/1NYQBVT0DCGTOSgjAcOJbG5w/aRH4bGG9eAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831187; c=relaxed/simple;
	bh=/L0dVy2/VGSLG68m6j7T+Bw2mLeaN+VgVmMS8FlL+qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWtaRi4APYnLyvqexW/p7zywwyNuNEp21Q8uHQ4EIeVJ9044rg+NB4HVvuvRfS4t8BsQbjmYI2ncY8/DQP8T+SzP4PMKEFlcvtC04dPtOaQpI013aVaw8LVF5KSCYwelMAcx5DSNF03MXP7B8zmNL0loafTlgNDP9k9JD1ekAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yTB5swJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05185C433F1;
	Thu, 11 Apr 2024 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831187;
	bh=/L0dVy2/VGSLG68m6j7T+Bw2mLeaN+VgVmMS8FlL+qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yTB5swJaZ0YspunKwE0pjoshG8r6U/9vk7z7f3I8sT3NiNCQ7gIavE8oMBWfbIsJt
	 xBgROA2FiZQTUxjxRFOXhEOoaDXSk26yO/PzQl9cV63YCSqlAxXTgct45ZKptSxYUb
	 sCS47YkWBY/3ELSbYXcvvQUwlxl25Pv3WP9WPqIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/114] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Thu, 11 Apr 2024 11:56:05 +0200
Message-ID: <20240411095418.031907626@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

[ Upstream commit 7411055db5ce64f836aaffd422396af0075fdc99 ]

The unhandled case in btrfs_relocate_sys_chunks() loop is a corruption,
as it could be caused only by two impossible conditions:

- at first the search key is set up to look for a chunk tree item, with
  offset -1, this is an inexact search and the key->offset will contain
  the correct offset upon a successful search, a valid chunk tree item
  cannot have an offset -1

- after first successful search, the found_key corresponds to a chunk
  item, the offset is decremented by 1 before the next loop, it's
  impossible to find a chunk item there due to alignment and size
  constraints

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 36adbb3d096a9..453d037987fb3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3352,7 +3352,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
-		BUG_ON(ret == 0); /* Corruption */
+		if (ret == 0) {
+			/*
+			 * On the first search we would find chunk tree with
+			 * offset -1, which is not possible. On subsequent
+			 * loops this would find an existing item on an invalid
+			 * offset (one less than the previous one, wrong
+			 * alignment and size).
+			 */
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
-- 
2.43.0




