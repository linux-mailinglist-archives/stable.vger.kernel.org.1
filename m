Return-Path: <stable+bounces-143848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4782AB4216
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D737419E289D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8532BDC1F;
	Mon, 12 May 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tawqHi/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C1297A74
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073123; cv=none; b=X7jxMFZ5VUon8WWgum0mLSxerHHADKmmsmXhUUw3cxhLwmqLpcirRb518oVC/MifImgwlaDtnDrVgcGTdZfdkJmm5Ew9tc/9HHUSaO7pgYsSEy0jg5rVDc5+X1WQ7zrOVwNLt0593i6XSLjGkjDgJfXNk/weN1Za7CD1/48FhOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073123; c=relaxed/simple;
	bh=gOkOpJCs2yklwiq2PZesXqHU99bqS+TyCaYLXiQqXgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fdl9JT0uNJi3CxuL+jBJOJ9FDKJZ5NwgGdN/wrET5Yo6+pYA+ouuZK4LXx+yukLoyfwIUnLejbDVFmkRmotQPQC4NsdOX18supQE0YnDO4m2slwATBOxwCKOZP5BB6fefjdRSePv2wD+A/xyIjkJzIdopgzixSnckyxpfAq5ZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tawqHi/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB1FC4CEE9;
	Mon, 12 May 2025 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073123;
	bh=gOkOpJCs2yklwiq2PZesXqHU99bqS+TyCaYLXiQqXgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tawqHi/+23Nuzx00oI3zRRzYcl7nAe+fZL4iqRPaWyoNdoNT76i2JETOejbtBmWit
	 FMz0zIzmZipNJiCShU7jlIanDTaTaeonyxifynXIWmhl8s4GPcUzc2bvMcs+1+P/5X
	 ajvCo1EXQBOQLe2thprTa8JE559/fgi/uZXhUjhCjzp7rIvr78pRwHQYZXjAJCPKAt
	 nx2Fpbi2R2f15BiXXhuuOgnjGIpBdeZyveNoGoEz8RyoJWwHTU777bIYWFiJ3ITdmQ
	 ySZ7n7Wj3/nkAW7zqlcY0jJYGGd/R59nvXWVfAE6thz9kwOOmScKKtiF++YUZLDI59
	 IRObLzkclfrvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Mon, 12 May 2025 14:05:19 -0400
Message-Id: <20250511230337-793b30bd8ebec8ef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509095938.3246212-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 28cb13f29faf6290597b24b728dc3100c019356f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Filipe Manana<fdmanana@suse.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  28cb13f29faf6 ! 1:  20190e64dc113 btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
    @@ Metadata
      ## Commit message ##
         btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
     
    +    [ Upstream commit 28cb13f29faf6290597b24b728dc3100c019356f ]
    +
         Instead of doing a BUG_ON() handle the error by returning -EUCLEAN,
         aborting the transaction and logging an error message.
     
         Reviewed-by: Qu Wenruo <wqu@suse.com>
         Signed-off-by: Filipe Manana <fdmanana@suse.com>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/btrfs/extent-tree.c ##
     @@ fs/btrfs/extent-tree.c: int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
    + 			ei = btrfs_item_ptr(leaf, path->slots[0],
    + 					    struct btrfs_extent_item);
    + 			num_refs = btrfs_extent_refs(leaf, ei);
    ++			if (unlikely(num_refs == 0)) {
    ++				ret = -EUCLEAN;
    ++				btrfs_err(fs_info,
    ++			"unexpected zero reference count for extent item (%llu %u %llu)",
    ++					  key.objectid, key.type, key.offset);
    ++				btrfs_abort_transaction(trans, ret);
    ++				goto out_free;
    ++			}
    + 			extent_flags = btrfs_extent_flags(leaf, ei);
    + 		} else {
    + 			ret = -EINVAL;
    +@@ fs/btrfs/extent-tree.c: int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
      
    - 		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
    - 		num_refs = btrfs_extent_refs(leaf, ei);
    -+		if (unlikely(num_refs == 0)) {
    -+			ret = -EUCLEAN;
    -+			btrfs_err(fs_info,
    -+		"unexpected zero reference count for extent item (%llu %u %llu)",
    -+				  key.objectid, key.type, key.offset);
    -+			btrfs_abort_transaction(trans, ret);
    -+			goto out_free;
    -+		}
    - 		extent_flags = btrfs_extent_flags(leaf, ei);
    - 		owner = btrfs_get_extent_owner_root(fs_info, leaf, path->slots[0]);
    + 			goto out_free;
    + 		}
    +-
     -		BUG_ON(num_refs == 0);
      	} else {
      		num_refs = 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

