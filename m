Return-Path: <stable+bounces-106651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B59FF9CC
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9722E162B6E
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A3B1DDD1;
	Thu,  2 Jan 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1OBjVsU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874779D2
	for <stable@vger.kernel.org>; Thu,  2 Jan 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824231; cv=none; b=qysWt9HgUoTllzHyTsMDphOzBE99j8ImJ3cANX1rQQVeKTNiBSwHZ1lAL6qm4WTQkH9dQce24Bnp4EYb98tC5U08yZPwdWr+qhoRcxYgajWWg3gHCzGOgQUZjeIIYiO++3pKoL9g8tpmWmo3aCsErNf0zbzKbMMgTE3VjLJmHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824231; c=relaxed/simple;
	bh=Yrp55O6T+NxGtdCWAjV0F8IgNRSSuA/kKSyjjr5r3Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llqt+VIoIJ67gfo3L9yhIBzInhA22+SoGKJAO6yra4DN8YKZCVc1jkD3BiKne9AO3ZfErAHGdANygXcEoyOyXsDTkB+l0P8wSPoHK2Bcf2cO5YuGqmAcigQex6pTYd128T7Q+B3nzVkp8IOxOdGjEXw0AI1SeaLYw30Yofo6a0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1OBjVsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D3FC4CED0;
	Thu,  2 Jan 2025 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735824231;
	bh=Yrp55O6T+NxGtdCWAjV0F8IgNRSSuA/kKSyjjr5r3Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1OBjVsUvhUqYRYLwZ5FHhvyKgVyOlVVuMBkv5CkaO9j5ethYeeBg+TCl2n+Q11qj
	 pSdf3J6CK1QQcANypZpqU/yqcgJdoxqx6AWpk4APmD8rubuuGh3NMyk1Cq0fHpEVE1
	 ZVfq74OjrLEmRtH5NzAva0cuDXdGoGv/t4vsMydBdci8xol3GYp8mCeZ9ZqCFaTVjC
	 SYZ9D1CnVYhFxN6gsh/WxEK5Ups23W08efjC76FZGjw8Drnx87LCFFF0+rSctIST1w
	 MYHeKio46Tv435RXa9KD/pYZUU+hPS/6IXJGYinJznTRop3oPIT7o3oGjUNZmpX/Qa
	 A8eM7S0JtNshQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] f2fs: fix to wait dio completion
Date: Thu,  2 Jan 2025 08:23:49 -0500
Message-Id: <20250102073954-9f9ba7172f0fdc24@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250102062245.456512-1-alvalan9@foxmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 96cfeb0389530ae32ade8a48ae3ae1ac3b6c009d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alva Lan<alvalan9@foxmail.com>
Commit author: Chao Yu<chao@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  96cfeb038953 ! 1:  e3d82566464b f2fs: fix to wait dio completion
    @@ Metadata
      ## Commit message ##
         f2fs: fix to wait dio completion
     
    +    [ Upstream commit 96cfeb0389530ae32ade8a48ae3ae1ac3b6c009d ]
    +
         It should wait all existing dio write IOs before block removal,
         otherwise, previous direct write IO may overwrite data in the
         block which may be reused by other inode.
    @@ Commit message
         Cc: stable@vger.kernel.org
         Signed-off-by: Chao Yu <chao@kernel.org>
         Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
    +    [ Resolve line conflicts to make it work on 6.6.y ]
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## fs/f2fs/file.c ##
     @@ fs/f2fs/file.c: int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
    @@ fs/f2fs/file.c: int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
     +		if (attr->ia_size < old_size)
     +			inode_dio_wait(inode);
     +
    - 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
    + 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
      		filemap_invalidate_lock(inode->i_mapping);
      
     @@ fs/f2fs/file.c: static long f2fs_fallocate(struct file *file, int mode,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

