Return-Path: <stable+bounces-164866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98092B1318E
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 21:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1042D3B9DCB
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9C2253E1;
	Sun, 27 Jul 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx9Ng6Og"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938F223705
	for <stable@vger.kernel.org>; Sun, 27 Jul 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753644974; cv=none; b=pe0kyMQ6SfthRDfRmw0qD91S/W+0lI39J/XTm5OdnyjBMDcocH5NqhTMVS14VoFZRqFAZJQ2fSWy4kz9kNaQrF75lGWXMfIQcjNrLy7Pd1t2K5Io+rqSYNGsCKsm7FoAfblGsbZhg8YU/sLSQoqvvQOKcbwYyrYOfLIUUzFq2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753644974; c=relaxed/simple;
	bh=OWZQXo2OFXOFsN06OKSTAdz6KqAOyS4o4lQyXhdFXNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYaSE2LYzKn28EdHG4BPAjqrmsNsMhJHsC0hf+56zgH0p2L7WMNl3zgNoxocpglfTlzS6+WkSSMawTtka51GBhcFeXAgoN1dDo1IeMbN+RGKTnUP6btQkC8q+th/i4DtYZCkITuEhO9gEqm0oXnw6JQxOD4HuL99GQ3AAw6OreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx9Ng6Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D71C4CEEB;
	Sun, 27 Jul 2025 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753644973;
	bh=OWZQXo2OFXOFsN06OKSTAdz6KqAOyS4o4lQyXhdFXNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fx9Ng6OghwASQG3x5KFMbKktLE3CMUr6J+ZJ6BdEzGnPh0k5sC2NixbchTvMghzvB
	 Y2cWRVXBAYyBcbEMAZP0BAYDhmRNAdXopH8VzHxI/kEOQ92MlQ4vcGG3uIOvh74XUa
	 uFsiny9qcoUxeXgHjZ4S+wD/jHFLT1Fuza6fiEm8DYfN7ptdpKQ0jQxsYxZA8FY8nf
	 HVAHHSdH1k3R7nTf6Iq7p4GgotiWd5V/mWfrroGyIEo9zPOlmnbkZcM8ZNxYmTRHzN
	 Yae9qdXr2tyBICCwVmJobvNjtd9YxPgorw8fQZiyz2vknSLEMFwHLthk0/y3P57S4c
	 cOmGeln/2tRtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] jfs: reject on-disk inodes of an unsupported type
Date: Sun, 27 Jul 2025 15:36:11 -0400
Message-Id: <1753632305-a4ccb0a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727095111.527745-1-duttaditya18@gmail.com>
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

Note: The patch differs from the upstream commit:
---
1:  8c3f9a70d2d4 ! 1:  72a6c46e170a jfs: reject on-disk inodes of an unsupported type
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
| origin/linux-6.12.y       | Success     | Success    |

