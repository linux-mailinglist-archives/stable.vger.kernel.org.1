Return-Path: <stable+bounces-109197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F110AA12FAA
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AB1163C5B
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5BA94A;
	Thu, 16 Jan 2025 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXHJ7tqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11979EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987168; cv=none; b=pzE5nWvV3dB5xV9o8OJYSf8sEGkjCm5be7ksw2LBjlHgrT51eThGmJBf/UxMjzPrOWocULE1ii67yx+N51EmkaPoYKGtsLv0nwnPbZKY/OLYpU/eGzj6U4+ZVrCfLvyGNeVPZkDJgYvYGiA4E5F1Mfun4ludyHvgOppqxCY3LqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987168; c=relaxed/simple;
	bh=NYSZnVRaP/EYAUKB5i4/3S7ZREnQLLCpuoPgOmbBr1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQ+ObRNwGhtk0kQU1Q07vFSGgSwd4u/UERssCSc5u9CNgcZ+m5X89gGPPE+KyrXxtkzcHym+eHwup1izgrlyjOTamOcPJ+9bPfg0GzUU6TUfYL3D2fLBVW49Nzv0BJ7rqmx2w6Vweax8rMM+jnmv6p2CTnYyrS69MKxL5Tiq/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXHJ7tqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE84C4CED1;
	Thu, 16 Jan 2025 00:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987167;
	bh=NYSZnVRaP/EYAUKB5i4/3S7ZREnQLLCpuoPgOmbBr1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXHJ7tqRVakuXcXkMkmacEceirD/C7Gc29Y7Pv4C4exwfY2KyaEg24d99zjr3vhql
	 653MJsCFdJ8a4rDN7w1urKZQb00UbMaiMZ+Z7MpzBiD0kV+HUe7MkMWHv4JnfADco3
	 rFt5/ndLdZ9PPenSQiMc5Um5ptN9Rj+fnSTlbZALjY5LkOMO3UxR1TdqbRkNnFLf17
	 SXxfCEGgylwzVkZrjy12ZiNCVnqVflBULSqYD0hNCrYdfPm0K5+LDqOUySakIotKQ3
	 v1nYEP0n/VFzMms1WRGiIgUVjS5OTojfksDPK06nSJ2ri0NWVGBC9y1cL0et8QXHKU
	 kgTCZzWluiPWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] net: defer final 'struct net' free in netns dismantle
Date: Wed, 15 Jan 2025 19:26:03 -0500
Message-Id: <20250115165541-f7473358e3782a0c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115091913.335173-1-kovalev@altlinux.org>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0f6ede9fbc74 ! 1:  2b14d8a38dbc net: defer final 'struct net' free in netns dismantle
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
     +
      static void net_free(struct net *net)
      {
    - 	if (refcount_dec_and_test(&net->passive)) {
    -@@ net/core/net_namespace.c: static void net_free(struct net *net)
    - 		/* There should not be any trackers left there. */
    - 		ref_tracker_dir_exit(&net->notrefcnt_tracker);
    - 
    --		kmem_cache_free(net_cachep, net);
    +-	kfree(rcu_access_pointer(net->gen));
    +-	kmem_cache_free(net_cachep, net);
    ++	if (refcount_dec_and_test(&net->passive)) {
    ++		kfree(rcu_access_pointer(net->gen));
    ++
     +		/* Wait for an extra rcu_barrier() before final free. */
     +		llist_add(&net->defer_free_list, &defer_free_list);
    - 	}
    ++	}
      }
      
    + void net_drop_ns(void *p)
     @@ net/core/net_namespace.c: static void cleanup_net(struct work_struct *work)
      	 */
      	rcu_barrier();
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

