Return-Path: <stable+bounces-119882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E722A490A9
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F529188E04B
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 05:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D01ADC89;
	Fri, 28 Feb 2025 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWrtW7eD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F51A3140
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718797; cv=none; b=OWNj9uP49bg+Cb8ZxGn/O9fiy5cSLWPvUGBtxpd13lFjODdWVlQ2bgRESd2kfJG5ICTB6sOJI6CU0XC9W3hwlWvj/3L9UExbdeKu1XBnobxF+ltn2jHNe6lanjvOYgQb7F6E6XwkNl+miDiCZh/dSTxp9ibwJUTK3AaSDpBR+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718797; c=relaxed/simple;
	bh=UHdZJ986Rs6nzBrVhdWynemWeRDUVuiEGIt3nhota0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAc8vFR0Ay5CZePFAz78vE4JieB3sZj2F/fKMKMYqm2JYw2Y/R6bX7f0ovVIn9ZZ32XrDBsTQlQWKlirT3SKCau4nGTW81xWxFsuBQY11o4KdcRqjI7b9YY4RcnOJnTWJixJ+zcW2UrxDSQNhc2obZvT0lTMT8I+6Oh+2998n04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWrtW7eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1293AC4CED6;
	Fri, 28 Feb 2025 04:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718797;
	bh=UHdZJ986Rs6nzBrVhdWynemWeRDUVuiEGIt3nhota0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWrtW7eD/4ERqhUKQe91moYnU/K2mbO0swA+DtG2ssxWBEJh42X8wY/9YHEQoBpAp
	 4xzJKk8rZ1eXKiYJMwDOSCEFUgrMs+da21UNrE9h6MSq2w3bWWaFFjAy5xHGWeFJdT
	 ZWHGNd6tTJZ6f8qQhrRBNne+CKbYATu2q6IxOJNLCakkXaxqFZJQFAmT4Z3oZmd8M9
	 rk+sVF1pxuV9hmpH+kbverkZakEYyYKRC0ZZoP8V8fdATr++J1mbt/iokd3i/ydOpa
	 yqalM80JnCZCrrP/pCv1wg7FlX2+Zc6IvU5QdjAr9EBpsH3nuP/6pY69EL/XdD3yXE
	 JduAXDaxVVJLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Squashfs: check the inode number is not the invalid value of zero
Date: Thu, 27 Feb 2025 23:56:12 -0500
Message-Id: <20250227142317-7980cd9af3d37985@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226081646.1983643-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 9253c54e01b6505d348afbc02abaa4d9f8a01395

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Phillip Lougher<phillip@squashfs.org.uk>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: be383effaee3)

Note: The patch differs from the upstream commit:
---
1:  9253c54e01b65 ! 1:  fee0f4eb6fa1f Squashfs: check the inode number is not the invalid value of zero
    @@ Metadata
      ## Commit message ##
         Squashfs: check the inode number is not the invalid value of zero
     
    +    [ upstream commit 9253c54e01b6505d348afbc02abaa4d9f8a01395 ]
    +
         Syskiller has produced an out of bounds access in fill_meta_index().
     
         That out of bounds access is ultimately caused because the inode
    @@ Commit message
         Cc: Christian Brauner <brauner@kernel.org>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/squashfs/inode.c ##
     @@ fs/squashfs/inode.c: static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
    @@ fs/squashfs/inode.c: static int squashfs_new_inode(struct super_block *sb, struc
      	i_uid_write(inode, i_uid);
      	i_gid_write(inode, i_gid);
     -	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
    - 	inode_set_mtime(inode, le32_to_cpu(sqsh_ino->mtime), 0);
    - 	inode_set_atime(inode, inode_get_mtime_sec(inode), 0);
    - 	inode_set_ctime(inode, inode_get_mtime_sec(inode), 0);
    + 	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
    + 	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
    + 	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

