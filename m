Return-Path: <stable+bounces-110434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335CBA1C3AE
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 15:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C4D7A3867
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8861CD1F;
	Sat, 25 Jan 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2QpwMlC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC9134AC
	for <stable@vger.kernel.org>; Sat, 25 Jan 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737813829; cv=none; b=H0vp3QgBih0vB13BxAU/vzriyhWQ6s7qFRhenlSS1jW7vi+70U3jEm5RA5A/Vj+GcRylrtEthiHFAvf/Nr1gYPMf+KqewYs/TDQo9VSHWKbOb2ffnUOifx/d26tNmzEoUJSp1D86J70qu03RV6mCEKQqpzPsZSi3cS3CcQekkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737813829; c=relaxed/simple;
	bh=9Jk0Pj5qI/Gbt7c3Vy+Irg+RPq3MZbwdjHz7Sp7ljQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATF4D00ZYuZzzjXB/2rPYWS+vGvP/OXnvbjVzVB6wAdppaIWpLMrLyEqQVnH7edW2/x3aGGv85rQfTqxNy+FuOz6pif/23VGT8InPnt65vRMM4QKzF0NIpFCnoAv+B33PYQXrizsYs6EPOz6boNeuPrJZIaRf9SCW6gciIOZCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2QpwMlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEED4C4CEDD;
	Sat, 25 Jan 2025 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737813828;
	bh=9Jk0Pj5qI/Gbt7c3Vy+Irg+RPq3MZbwdjHz7Sp7ljQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2QpwMlCgmpxbFVPo9EnNr1Qlctez63v1reb/EomQDDq8ex72Oi7mNu8e5yY6fcnZ
	 w6a4U69Jb6LpQPw3h5DG/GDdUgVjYLFeeO1bOSuKt5NxVRKSzKxRs+ObkUC/XEBCW5
	 U0vRlVHLkc0DELpGQjQ38J1XjHMVH049dcunv+JZRARSqYxA5NpRA39tDCgjnxgCJB
	 bfHBJ+LTah2j1pQNTNm7xfIIL1vCwJrvg5HYpIZfavjoDOSLVnHXrlrjOUSznMhBu3
	 mVos1RuHqdbTJqDEkmhndoQwQs/kJoIJmRp4etE3Zdupi6EjM7WMKzlqP7oshiecKn
	 wH6KGKFSfPVgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shaoying Xu <shaoyi@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 2/2] ext4: fix slab-use-after-free in ext4_split_extent_at()
Date: Sat, 25 Jan 2025 09:03:46 -0500
Message-Id: <20250124205321-d47ea8205bb009a1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250125003135.11978-3-shaoyi@amazon.com>
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

The upstream commit SHA1 provided is correct: c26ab35702f8cd0cdc78f96aa5856bfb77be798f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shaoying Xu<shaoyi@amazon.com>
Commit author: Baokun Li<libaokun1@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8fe117790b37)
6.1.y | Present (different SHA1: a5401d4c3e2a)
5.15.y | Present (different SHA1: cafcc1bd6293)
5.10.y | Present (different SHA1: e52f933598b7)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c26ab35702f8c ! 1:  2df1566f67dbb ext4: fix slab-use-after-free in ext4_split_extent_at()
    @@ Metadata
      ## Commit message ##
         ext4: fix slab-use-after-free in ext4_split_extent_at()
     
    +    [ Upstream commit c26ab35702f8cd0cdc78f96aa5856bfb77be798f ]
    +
         We hit the following use-after-free:
     
         ==================================================================
    @@ Commit message
         Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
         Link: https://patch.msgid.link/20240822023545.1994557-4-libaokun@huaweicloud.com
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    +    Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
     
      ## fs/ext4/extents.c ##
     @@ fs/ext4/extents.c: static int ext4_split_extent_at(handle_t *handle,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

