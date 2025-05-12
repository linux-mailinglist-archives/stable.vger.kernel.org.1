Return-Path: <stable+bounces-143837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A25AB41EF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798801B601DD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2702BCF55;
	Mon, 12 May 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz16j9yY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5229E074
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073111; cv=none; b=K+ZlPptQri9Q3ONZd8kYnWDeJ6OJ/1aq0lGUMsBVcP3Py+luYIaAU+kNsI0rqVqZHrvXn2V+3F8nAH4gKckLmxJeCv3QymRDkS0XAHLbYPssQf8H1KZmfy/Uv/lKZqhBkrtQBfua8dlApO7hG9glQMwcxbxaiRZDrppf1LV7YT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073111; c=relaxed/simple;
	bh=y8K1d5GDYQkJyeEiLlR44SalB6YDvmTLtq4nhAZRHEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBlUSWT+hYz1WvtL6IBfKomIGazNn4G9JpE0jV2dgpPfiYl5YAesx7fDu9IiKScGBsxRlX3sSFeXbA34fnVDOEW4r3Et0BCxZ5KJgn1hp8UMs1k0IyL2fqCgB476Tf75jxX1mgXFPoTkTh6aABRpoU0R4Gchp0MCnGMJgrK+bhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz16j9yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FABC4CEE7;
	Mon, 12 May 2025 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073111;
	bh=y8K1d5GDYQkJyeEiLlR44SalB6YDvmTLtq4nhAZRHEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz16j9yYXHtxeNAy0n8l6XSSjeWLp9wi2nCEYQ+IqDk3QBUJcuEHoyaGmwpQqWFDd
	 Dxy1fjT/l5JXErl23r6lYfKund7gO6Wm22evCDYYwMywimzZps0zHnIsD/tVGvYJ7L
	 N9IZsQsHX0QPu3iQB4uJFr9biBHUvnhuBw9I0uoSjSlRh9bVpm/lMJdpAXcPXH/lEl
	 j62pY99tbgvmcq/cA4SQpEmh7us2Z9zF8Mtm/3F43zFXBkXlHMDQ/zemoDAIBm4GtX
	 UmEw/v7yBnEAHL7Wwm+yhL1UIs4jO3nxhWgcbuQRkGHWfK7+VOt0gM/2rlh4/urk2G
	 mTlreE8/IfKnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Mon, 12 May 2025 14:05:06 -0400
Message-Id: <20250511212256-b890b19460389408@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509100325.3246741-1-jianqi.ren.cn@windriver.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  28cb13f29faf6 ! 1:  05ffdab55c95b btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
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
| stable/linux-5.10.y       |  Success    |  Success   |

