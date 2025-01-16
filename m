Return-Path: <stable+bounces-109189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A3A12FA2
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5560E163B5B
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E238C1E;
	Thu, 16 Jan 2025 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9aySpJZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD179EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987135; cv=none; b=Nck6ood6jRfNCFyZ1WLeaDAdmgpUxkaRIClVCbdJyRmVU742YJnwKFRvHrtTvtnAQXCAIQwSqnoO9v6zRGqrr27N3D6CsMM/CZpwWqgRMDOmfc8OFw+hMrb1w5XBcHcKW/tLk30JgIyhFIccJxibCUAIIO4x2DUxrEJ9r3zzEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987135; c=relaxed/simple;
	bh=RJaOhFYtPZsAg0/Exlnmgx21xB86feMrmkZ7PZmgaAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bczn6m4aOGyYXDq3UAf/g8Njh3zw7iVKGVuegOYAlnA8kbFWp3kIBn+9OjFCYnfYpuWE+CzXlpNZUVNCLhHO23Luf+8H6/SaTqCav3SSy22r+l8V1nCrCx3n0FR8M0HDNxi6G/7XNKGa0UwMrAhHrEENSua7Z6+q6DtFU3SOgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9aySpJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DDBC4CED1;
	Thu, 16 Jan 2025 00:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987135;
	bh=RJaOhFYtPZsAg0/Exlnmgx21xB86feMrmkZ7PZmgaAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9aySpJZkCg/6aUAc8HR5fcH6i7hgEkpLQudzmbs88ajKzFgTIhvbja6l8FaH2PYm
	 6bbp5F79kP1QA/AGC55Ma78AQDg0DRi/0KrRb3RJtDji6IphDfomVRx2Vs58Dfq+xY
	 YQmbn+FZSZ+coLHoGASSIQXJ1/+oiHtPV9UbamMIh6zW+wyKUnOGBfMJZy9jehCqFw
	 ybhrFFgGqdumzNWky7+VzJ10n+N/1GIAVZZky7qeaJh7h5J1ekZmadwSGxmG3wcd0x
	 jedwJeud90OmEutHD6etn6LSszPOgDUfumf7kDK9whYuFNJ/td7kxCP9vpwJ9VFUTJ
	 mGY2pFDLIJULQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] net: defer final 'struct net' free in netns dismantle
Date: Wed, 15 Jan 2025 19:25:31 -0500
Message-Id: <20250115160422-e1d7cda0f4f3d04c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115091642.335047-1-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 0f6ede9fbc747e2553612271bce108f7517e7a45

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev<kovalev@altlinux.org>
Commit author: Eric Dumazet<edumazet@google.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 6610c7f8a8d4)
6.6.y | Present (different SHA1: b7a79e51297f)
6.1.y | Present (different SHA1: 3267b254dc0a)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0f6ede9fbc74 ! 1:  bb5ecf836b36 net: defer final 'struct net' free in netns dismantle
    @@ Metadata
      ## Commit message ##
         net: defer final 'struct net' free in netns dismantle
     
    +    commit 0f6ede9fbc747e2553612271bce108f7517e7a45 upstream.
    +
         Ilya reported a slab-use-after-free in dst_destroy [1]
     
         Issue is in xfrm6_net_init() and xfrm4_net_init() :
    @@ Commit message
         Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://patch.msgid.link/20241204125455.3871859-1-edumazet@google.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
      ## include/net/net_namespace.h ##
     @@ include/net/net_namespace.h: struct net {
    @@ net/core/net_namespace.c: static struct net *net_alloc(void)
      static void net_free(struct net *net)
      {
      	if (refcount_dec_and_test(&net->passive)) {
    -@@ net/core/net_namespace.c: static void net_free(struct net *net)
    - 		/* There should not be any trackers left there. */
    - 		ref_tracker_dir_exit(&net->notrefcnt_tracker);
    - 
    + 		kfree(rcu_access_pointer(net->gen));
     -		kmem_cache_free(net_cachep, net);
    ++
     +		/* Wait for an extra rcu_barrier() before final free. */
     +		llist_add(&net->defer_free_list, &defer_free_list);
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

