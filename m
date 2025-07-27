Return-Path: <stable+bounces-164864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FAB1318C
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 21:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47CE3B8203
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A888C2253E1;
	Sun, 27 Jul 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlJCifQz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5B1A314E
	for <stable@vger.kernel.org>; Sun, 27 Jul 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753644968; cv=none; b=qVi5o0TRnEU7L1FFqpL63uRnqDoY1RHp6d4QA4V6vxKSQGL664iSB6KvlC9YSYsq2GNFvHdEA5RVHFeYy/lNFER6Fi/su6TzkIY3Gzu28IdxSPMEJwL/UI88Pbr7O+tUQ5TT1HFOdh0qdpIxo7sT2uPk3/8mhE/Sqg9GpUXMT1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753644968; c=relaxed/simple;
	bh=2r4/V5njGHPApKM0MH6s6gN53PEgNeTciHuH8vaRQOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NW/Cvg1KQ515oJrRZUIGrvqHKNyz/vGtPWl11pqGOkKUAEXd6sapki6xC5JNZsNYZY9hI2T3Esi8hsQGYKp1+mw3osEaM77ec/xs17lW+jSQAprGPwyCsoxA+U1sg5torsvqlsAzyHUeRy4eYrm7XOWk/WK6kT/FJTnTBc4ahcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlJCifQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E129C4CEEB;
	Sun, 27 Jul 2025 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753644967;
	bh=2r4/V5njGHPApKM0MH6s6gN53PEgNeTciHuH8vaRQOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlJCifQzKqTcG6+TZNSpJ51O4dDR03vM8mEWVsP4/gXpquqRjz7f+JiBaEMq+ZvQ9
	 loephwIlp3fXs/mR9Sjd4rCSTm+u1Q64K8sARKmN/EpY+1iRY6Q40pHFtdbbnDmWcy
	 MkcqtuTWdnEaPKHlD0FjHhoQgHJVwocTjDOyJTlO8tEHKIgSBJeH/bSDUxJjA+2VAp
	 s/GpukQi6Eh2qQygFLjzY9ZNQf3ZMx9AdM5HZopQdfmpUQpummCpqeGExamJX8VLXv
	 DV7vTroWaiSSVf2Qh+BvXDxHQLcDdyHzs50dwVUFe0dq6qiIuLbgbBvk0Ki+7K9UzZ
	 0P2bLQfgzEfLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] jfs: reject on-disk inodes of an unsupported type
Date: Sun, 27 Jul 2025 15:36:05 -0400
Message-Id: <1753632118-83d9e68d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727095645.530309-1-duttaditya18@gmail.com>
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

The upstream commit SHA1 provided is correct: 8c3f9a70d2d4dd6c640afe294b05c6a0a45434d9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Aditya Dutt <duttaditya18@gmail.com>
Commit author: Dmitry Antipov <dmantipov@yandex.ru>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8c3f9a70d2d4 ! 1:  9a6415feacfb jfs: reject on-disk inodes of an unsupported type
    @@ Metadata
      ## Commit message ##
         jfs: reject on-disk inodes of an unsupported type
     
    +    [ Upstream commit 8c3f9a70d2d4dd6c640afe294b05c6a0a45434d9 ]
    +
         Syzbot has reported the following BUG:
     
         kernel BUG at fs/inode.c:668!
    @@ Commit message
         Fixes: 79ac5a46c5c1 ("jfs_lookup(): don't bother with . or ..")
         Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
         Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
    +    Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
     
      ## fs/jfs/jfs_imap.c ##
     @@ fs/jfs/jfs_imap.c: static void duplicateIXtree(struct super_block *sb, s64 blkno,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.6.y        | Success     | Success    |

