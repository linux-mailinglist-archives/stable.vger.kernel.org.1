Return-Path: <stable+bounces-144018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154EBAB44CF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F12E188C60D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE62989AE;
	Mon, 12 May 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMEICoi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A77298266
	for <stable@vger.kernel.org>; Mon, 12 May 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077613; cv=none; b=CeM35UJlIa9AfXQ9OoUXrSp0aIMJRIByu0M4/wBrCHqvrRwySrK5B5ubunlb9GDNaZiZt7eK4OShrJbw5qpHOelfEBycEO5KULVu/7my1VrZ+R0Kpj4Z1Naczrw74EradT9riS8i8EOyG3x2l/az6Vu6l9mX6gcm9Z1vfReLE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077613; c=relaxed/simple;
	bh=UpYxTXHwvbGSbMJk3XRdJlbgg9PqlpJlwzM7ayHWFY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/EQvybJ/hweNdWFojE+4jEUoVdNldb+Rhs0WsIOHee9o8mpUS0Wp2l6/Nvu7o/DNcDmcr2rfXQJp+QhRhqrWBUCETu9QEhGGNgkCdK3mizPaMIYnUpP27WSueuNLStyA9kRREr518HUNu7mHJimisrD5Sl+vjPgcm01K5J0uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMEICoi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621CFC4CEE7;
	Mon, 12 May 2025 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747077612;
	bh=UpYxTXHwvbGSbMJk3XRdJlbgg9PqlpJlwzM7ayHWFY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMEICoi6flmiVgv+dZia4q2YuoTgLE9XBQg1d2n1KURlMkwGu6uz2ZByksHL/XsmX
	 Ti0JgE5dDE7idii1+XdkjNHpG5q/nk8TnxRdUO/PGsLMufPwz9F7l29Krb5Oof1c5T
	 +GMEOOu1Pg0ucNEuv9tFPZyZvQb8dgkrWWNZwcpUhsFn05aUlD0m0BAUrRgbyTPOnz
	 NQlv+CG03WbA0JfmlhnNuw00cxvps5x9tVXFBLpKMNoFwrcP2hpj/aGI5UY2np13W9
	 HqtAtcOkyOs7SN/PVEWXSvYI9jVs90miamOg+Z/OqlSLZRcKLxpYWhxqlLMJN/spZW
	 UyHa/QSlojB4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Mon, 12 May 2025 15:20:09 -0400
Message-Id: <20250511215955-b7236ec222b3b830@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509095114.3245010-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  28cb13f29faf6 ! 1:  2c6bdbac7c73e btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
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
    + 			ret = -EUCLEAN;
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
| stable/linux-6.6.y        |  Success    |  Success   |

