Return-Path: <stable+bounces-109190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644DA12FA3
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BE1636F6
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94450A957;
	Thu, 16 Jan 2025 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSmozPU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5A8F77
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987139; cv=none; b=DpAOABQnuYd7FFEYfXhdfP/hE7kIxMbvPX6Rj1kWjHdGDUubmBKc0jdO481Kyd9AK8P4vfr/sd2M9x22Z4/di7IOl4GH3vF9SmaGjZEnf5yyJoZugP5/TkHbS8wuEBGP+WFc9o2fV/gVqXFPbX82fn2zULiF4DeLtQlvhl49czM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987139; c=relaxed/simple;
	bh=X7+rHEhtkiZrpfBhd6j+IPZ2k3C4NQEOAHEic4SnNc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DyIJ6bJUuTfvlnhQIsM0y77D6qq6fJuDsPQgp8f7xNf1YW3hAiTTTDwMUqVI2h4+JOVK+WgGiKKxhlyXGQtWQfN2osL/WdfoyGf94BRr0XQC52m53zpqA24ncn+gqrhK2w/FuA/c7SqlOGKdsE562R2hRmjZ0dB/KtqHNt5VUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSmozPU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61710C4CEDF;
	Thu, 16 Jan 2025 00:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987138;
	bh=X7+rHEhtkiZrpfBhd6j+IPZ2k3C4NQEOAHEic4SnNc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSmozPU5S91LFx7YIDd7Fl4xhaTZ2SZPpxsx08zT2BqfTzW+9bSi+re4DaKQmKHzA
	 Jwz0XKMZPb8i+oWZfXVMK76VKCaLf9Xi7yW6dhovs3dZdBwk8IC9cSwd6cJurO5vfo
	 LWEvsyr9ekuXpoFRS9cn21x2560/iCUAf7k0tCE0FVQZuJmmag+lBfRWwXLAKkv6bQ
	 onFcvD7tM8pnVzkj5Axc+UYYLYzyVHILx1GOlExJUNsr6vemae1o77vMw4iMHUfbck
	 nRz8ynl69tvBcEpedDpqjrqrxSlq6q4Gd6Rr4z8szvs++x8n5REo2+ZwtDNB5hNbIM
	 4ZfsjBlHYV0Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10/5.15] blk-cgroup: Fix UAF in blkcg_unpin_online()
Date: Wed, 15 Jan 2025 19:25:35 -0500
Message-Id: <20250115163728-9689e5990ac7e7d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115093709.335950-1-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 86e6ca55b83c575ab0f2e105cf08f98e58d3d7af

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev<kovalev@altlinux.org>
Commit author: Tejun Heo<tj@kernel.org>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 29d1e06560f0)
6.6.y | Present (different SHA1: 5baa28569c92)
6.1.y | Present (different SHA1: 64afc6fe24c9)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  86e6ca55b83c ! 1:  4a53d2caa691 blk-cgroup: Fix UAF in blkcg_unpin_online()
    @@ Metadata
      ## Commit message ##
         blk-cgroup: Fix UAF in blkcg_unpin_online()
     
    +    commit 86e6ca55b83c575ab0f2e105cf08f98e58d3d7af upstream.
    +
         blkcg_unpin_online() walks up the blkcg hierarchy putting the online pin. To
         walk up, it uses blkcg_parent(blkcg) but it was calling that after
         blkcg_destroy_blkgs(blkcg) which could free the blkcg, leading to the
    @@ Commit message
         Fixes: 4308a434e5e0 ("blkcg: don't offline parent blkcg first")
         Cc: stable@vger.kernel.org # v5.7+
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    [kovalev: in versions 5.10 and 5.15, the blkcg_unpin_online()
    +    function was not moved to the block/blk-cgroup.c file]
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
    - ## block/blk-cgroup.c ##
    -@@ block/blk-cgroup.c: void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css)
    - 	struct blkcg *blkcg = css_to_blkcg(blkcg_css);
    - 
    + ## include/linux/blk-cgroup.h ##
    +@@ include/linux/blk-cgroup.h: static inline void blkcg_pin_online(struct blkcg *blkcg)
    + static inline void blkcg_unpin_online(struct blkcg *blkcg)
    + {
      	do {
     +		struct blkcg *parent;
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

