Return-Path: <stable+bounces-163372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ECFB0A533
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EEDA80F79
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E52DC35C;
	Fri, 18 Jul 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fychlPFN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC82DC350
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845388; cv=none; b=uBDsJ7eV58wIaY0e+tzxNjEZI27DOiI8j3dhgD4DJVY26GJjqxWqOdHdn3KQH0CJVkkGOw1wrSgXUTAK3VDhq55BucjS+mua+4DnAWXJiXbtbOUBe1s+x7Q2bK4n9H+nUsQLmYLkUeb+sQXEpy5zz2aBDrjqebtAolCd7p/+QHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845388; c=relaxed/simple;
	bh=QZ9PEYiL/83edSQnQttyYr7jFl9fKOPg5CBuJaM1EBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNxnXQbfLkKz+KBlStnQw1G/RZ3n+6y1kURQwyTbbCS/awVI3pv9TBaZoxs2/NFmF9cBPkvQn/N1MyN+UiVUsPBsqEkNQJuyryE+QoRp5a28EaY8XdTyhT1D0EG3sONTubr89HQQs2YgjV1PDYLN7zogD96h+DWnP5x3D3nl4Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fychlPFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A275C4CEEB;
	Fri, 18 Jul 2025 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752845388;
	bh=QZ9PEYiL/83edSQnQttyYr7jFl9fKOPg5CBuJaM1EBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fychlPFNmVmPLUFXqlKci9dAyRph9N3DLLqe0DsAh2fx/t3k7jrrSe+ujnj21v8Co
	 RY1szw9OMoJZI1/VyOoVNOA9GJDCyLM/F0VSXNyHfLMw9fyzcsIfiAyNCXDomDS0LB
	 FBDrLNTr86tiEsYW/qQW7fbn5vdNd6rIRj+nxqPs2zEg/4ooZF1EPNs4U4qCcFjRG6
	 wXdppwSn9kEK+ubJTZMKd5Ubg06yYbj4Vy6HfZZaWiVQgHaN9NQXX+xEU/coWB7A3m
	 EvG7tLUihixhcfwl4bpIa3pyTRzPUJt2FYFYAeIrU3nvHGUTpjnC0XJlAHBInw3Hq7
	 Y3Gh095hS5WEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] btrfs: fix block group refcount race in btrfs_create_pending_block_groups()
Date: Fri, 18 Jul 2025 09:29:44 -0400
Message-Id: <1752844937-f98ec06c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <tencent_C3ACCD708660161A98683D6A583E30255109@qq.com>
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

The upstream commit SHA1 provided is correct: 2d8e5168d48a91e7a802d3003e72afb4304bebfa

WARNING: Author mismatch between patch and upstream commit:
Backport author: <alvalan9@foxmail.com>
Commit author: Boris Burkov <boris@bur.io>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  2d8e5168d48a ! 1:  7e8e9017eb32 btrfs: fix block group refcount race in btrfs_create_pending_block_groups()
    @@ Metadata
      ## Commit message ##
         btrfs: fix block group refcount race in btrfs_create_pending_block_groups()
     
    +    [ Upstream commit 2d8e5168d48a91e7a802d3003e72afb4304bebfa ]
    +
         Block group creation is done in two phases, which results in a slightly
         unintuitive property: a block group can be allocated/deallocated from
         after btrfs_make_block_group() adds it to the space_info with
    @@ Commit message
         Reviewed-by: Filipe Manana <fdmanana@suse.com>
         Signed-off-by: Boris Burkov <boris@bur.io>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## fs/btrfs/block-group.c ##
     @@ fs/btrfs/block-group.c: void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

