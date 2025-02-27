Return-Path: <stable+bounces-119791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B428A47506
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02845188AF51
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B01E8341;
	Thu, 27 Feb 2025 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQQuje8A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FE3209
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632900; cv=none; b=WfE5nRj8r4REWRH25EaqNkPFhGtrhazNUx7wHx3GPAoDAIVRNPAbr09wRsgJwg+itmGA2YjTlNQVvb8YsSxRRYIyrDxeXkrXmPGWe3O5SV/+WFhMW8bTQPByUz14CI+Gc86vXTXyuGqhxtY1m0z+XKmJvCowmsdGBbYf49hNFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632900; c=relaxed/simple;
	bh=nwyKLabkfAizAsOHtbjbtQTeJWtV846meOmhWP6lIZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWdxr5llBzOV8qBEJKJqZag3+A6g+emgdrUtqM7TxGISeEthSM4wI/6Wm4b2dP/vjSmFUzIwgSR79lXpz0+kKtNLBbbXgMvXW4IkyxvZHgMttFeZ2OXNqdBs8dkB2Vx+DDH9nNCiPL+jUYRO0zt1Z9f/0FcW/aZHopPQXwm/aKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQQuje8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB9C4CEE6;
	Thu, 27 Feb 2025 05:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740632897;
	bh=nwyKLabkfAizAsOHtbjbtQTeJWtV846meOmhWP6lIZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQQuje8Aa1ijuRqPYB0K5V6w+bybfE46NKk8RMWWyj5WalhojI/5RcHT8p5YZ482X
	 hZwVnqkjL0OhiuD7dlwuMYJuG+cSCsQyBnkIGFLwcZXeUgyKS7RAKQlOmsfE6LnjJH
	 4ne9yaszZWKt0L8VMlY13DBTMlch4894GLRIOJpUb6I1Iz+BqxnAA2PeLA8PJYkJQq
	 Gdak24kmFZ5DT1bAtWAz60UZvtxaFrJ4JjF71Q7JrCr6s436jgt+IWQCB3/8PaLvm2
	 9tW0NWkI1ep3EFmWgLCyiXARm1l0zOrIe9tw1gC5BIQ/vEgVwNCU6R2twVz5u85ce4
	 jAi2TUZHAL0rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	konishi.ryusuke@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 5.10 5.15 6.1 2/3] nilfs2: eliminate staggered calls to kunmap in nilfs_rename
Date: Thu, 27 Feb 2025 00:08:16 -0500
Message-Id: <20250226162913-e81899c209764ce1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226180247.4950-3-konishi.ryusuke@gmail.com>
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

Summary of potential issues:
ℹ️ This is part 2/3 of a series
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: 8cf57c6df818f58fdad16a909506be213623a88e

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8cf57c6df818f ! 1:  13fc7f2e9d896 nilfs2: eliminate staggered calls to kunmap in nilfs_rename
    @@ Metadata
      ## Commit message ##
         nilfs2: eliminate staggered calls to kunmap in nilfs_rename
     
    +    commit 8cf57c6df818f58fdad16a909506be213623a88e upstream.
    +
         In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
         with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
         path.
    @@ Commit message
         Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
         Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
     
      ## fs/nilfs2/namei.c ##
    -@@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
    - 	inode_set_ctime_current(old_inode);
    +@@ fs/nilfs2/namei.c: static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
    + 	old_inode->i_ctime = current_time(old_inode);
      
      	nilfs_delete_entry(old_de, old_page);
     -	nilfs_put_page(old_page);
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

