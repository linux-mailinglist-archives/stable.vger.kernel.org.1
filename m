Return-Path: <stable+bounces-105239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1168F9F6F24
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E12F7A43B1
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B8154BE2;
	Wed, 18 Dec 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9hYIBNs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8A15697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555681; cv=none; b=pn0Pd4Jw6zAQrm4XcFEBg54hhizuMmcWYLJAn+lR0MmWt6/DZY2EtGNyk/m9T7D5cOb8LcA9lrtaiGvcU0HeFVBelkuU0nzzdyMBCAEB+I3XnHlNYfrC+Pz5Ky5OjXyVNgIUzrYx7bueZu+C9uoehNgvyFzirCZM8h8C/Nc/EtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555681; c=relaxed/simple;
	bh=vRjJ04b2epUWmsvooaynbwTb+VxK4IZkZ7l4iiKbpIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awEFnRskfKJZ5NLYKhMlu/htav/W4FQZ/gMwpTJG9QwYSfDLongML1j2ElMr0weoO9sfm1kiG8nmgK1IIycRrEvZGF6/U6iitYZrRhbbIBLSr79PT2BteV8FktiSLZt9KxGidTs2+NyxF6SjB11NR1ryFiIwXxk5KV15pQePc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9hYIBNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F58C4CECD;
	Wed, 18 Dec 2024 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555681;
	bh=vRjJ04b2epUWmsvooaynbwTb+VxK4IZkZ7l4iiKbpIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9hYIBNsCMac4c6EarNyOVOYFXsS6+QNeRP2kdv/0fi4EbcMTKaeK3Nn8e9UtVb3Y
	 W/tO/svKutwEDkjhpaTnoBjcyejqzGz7Bzh0cb6lDIQgTVLD9//hv2U3pJ1qtWWD7+
	 C9dsqk8uiZv/TVh2KwWXYk4p0Cw+UjpDryuGov8IaqOLlLqt7iuXpnySn4+Rvq20hB
	 ZBGScsTtGd/+7B6rWLxh5DSKh3qicxheqrcUfKT0zPA1gIWB+hwvlXqyoU95//f1n6
	 BszPT4q9d+lg7atvWfae/OC3v5LWuS6FMN48FrknjN+ZOPFHDptYvrRLafjr2Hap2x
	 8jjyqqidsJi0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 08/17] xfs: don't walk off the end of a directory data block
Date: Wed, 18 Dec 2024 16:01:19 -0500
Message-Id: <20241218153612-1e96282cb1e1b09b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-9-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: 0c7fcdb6d06cdf8b19b57c17605215b06afa864a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: lei lu <llfamsec@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0c7fcdb6d06c ! 1:  04b957ad4003 xfs: don't walk off the end of a directory data block
    @@ Metadata
      ## Commit message ##
         xfs: don't walk off the end of a directory data block
     
    +    commit 0c7fcdb6d06cdf8b19b57c17605215b06afa864a upstream.
    +
         This adds sanity checks for xfs_dir2_data_unused and xfs_dir2_data_entry
         to make sure don't stray beyond valid memory region. Before patching, the
         loop simply checks that the start offset of the dup and dep is within the
    @@ Commit message
         Signed-off-by: lei lu <llfamsec@gmail.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_dir2_data.c ##
     @@ fs/xfs/libxfs/xfs_dir2_data.c: __xfs_dir3_data_check(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

