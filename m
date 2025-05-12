Return-Path: <stable+bounces-144019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E073DAB44D7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B79B7B4208
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3622989BD;
	Mon, 12 May 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/+KZZDS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08252989B8
	for <stable@vger.kernel.org>; Mon, 12 May 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077617; cv=none; b=g9B2Yj6p1pQPVhkUXnrgJA8DDiKyhCELMlhC6hUUJoPHYU4gIAkbABvVjOfwkX90HpV7J8DDSfVTVtEFzhLbF6T3V0KwfBBZJ8v2us0PPUxzcaqkhgbtyQKcfVIqppW54PdQXFnfm+xH8neJA6zQk51pFfBdpLfFS9F3D58/6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077617; c=relaxed/simple;
	bh=JpZyGrkrVBNVS/YXVHTbokp+fuRNkJ5pvjb3sgf3O3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUHXzVzalKd8ixEjoqFIuInH1oshhFhnWcMrWS+uuWf9h1OzorF94Vo2yT82i4kPmV+e6FSGpSUpcYWXL6DVh7sCY9fd9isj+i26HCUQ5SMaHFmLVnor7aEkFP12wSnZPv9c1bzuXpI9Wf+ab2UzQ6eyztGaac20w6t9Ff7nK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/+KZZDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE20DC4CEE7;
	Mon, 12 May 2025 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747077617;
	bh=JpZyGrkrVBNVS/YXVHTbokp+fuRNkJ5pvjb3sgf3O3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/+KZZDSWDyKhJRpOQknoegNq/+WUX7ntfd2NRL1S5o2J+n2cTIlZLQlLr+PPukDp
	 mFpBUdwqgyKyN8eBP0OLnnt3DY0ZCkOMBg1b9KSFwjWsjum/xU/cQN62eICzrFIw9Z
	 oP0r58rAwd7z6WAWahSOUsUp5Iil/fUpgXWnsEtFfta4GoHnZFIPXwiqE7ZADR6r3q
	 BuW/SSa6i5REWp+0Wep3d67xyZqahoxxAFx0C0rV4HPDxZEA+G2BuP4ikLzMtCFptq
	 oXs+s2ojTsOvs1YSwABUQz1ZpmzJ0jPlaClxCbPyGul/o2LP3wTFSkZ6xxxDTSFNdF
	 pMHUL8OiIMoOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Mon, 12 May 2025 15:20:13 -0400
Message-Id: <20250511214723-a9da90a8408d6b37@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509100139.3246547-1-jianqi.ren.cn@windriver.com>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  28cb13f29faf6 ! 1:  3723cdb982a3c btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
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
| stable/linux-5.15.y       |  Success    |  Success   |

