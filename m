Return-Path: <stable+bounces-134613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E350EA93A32
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D1D1B6755B
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750132144CD;
	Fri, 18 Apr 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/N4jx7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491115624B
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991867; cv=none; b=SkryjPQZs/j4RSuhBfeFu0+gwb1gm9oKIurrRZg4uLZwwcf6raSVTVd+mREg2LkT8iaTpIexvl7Xib3c2csORWaF70ma51zINGdcrCHtutcEPuG045myOZVS/xJpJR/eMd8NMa9FDJSrCbjMi+VAzyT9O2jQI0ca0r9o0VfsIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991867; c=relaxed/simple;
	bh=jpTWB50Inp5cXiy56Jm/Jg0wYxvYKzcz8Vszg4Gf7Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRh7pSS2TXXnQMP5XmVz9+dVgzJiOWUIe8WmHtw+WapKkyJaFBHi/oOAqiRTeNGWD+kGPXvWI1pA2/ZO5Poxt2fSMnVsticPG8S1DaFZ83ZmANMwdOoPsAX1VJBHk8kgBn1Ph0BrmC8nJq+M5BAiCOZbiio6iAah3bQr1nKJ4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/N4jx7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387A4C4CEE2;
	Fri, 18 Apr 2025 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991866;
	bh=jpTWB50Inp5cXiy56Jm/Jg0wYxvYKzcz8Vszg4Gf7Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/N4jx7qtJcOcRu82BISFdIln59IlkwwX9C63QnQChoyW66we8ttOTw0Db8koWLQd
	 RHMDHZshvyuWFS2q2tjcQgOMS+4IloFvu23/dWGFeTrt9tuf7sKQgnoB/njxR4etTh
	 X1in6chO0+QlepxAiaeGqLBScbn9XVlEV30V+3sb0ykvt0FMgu5UMuuq8L8PAQLlGx
	 2ei3O080Hb4jpONIya+uMHgGNn9getuX8CjbYhWigSWA6WZSZGKG2pxkuy8e7uotrk
	 6nhEHBHN4MG9SSnRxasO9SQTFRNXwqc8065FjTpSPzHQp2/60LkYldd8xCBULG9oQu
	 W0V43jNYAIaHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] net: defer final 'struct net' free in netns dismantle
Date: Fri, 18 Apr 2025 11:57:45 -0400
Message-Id: <20250418085224-47ce831a17b6f93e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417075740.1747626-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 0f6ede9fbc747e2553612271bce108f7517e7a45

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Eric Dumazet<edumazet@google.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 6610c7f8a8d4)
6.6.y | Present (different SHA1: b7a79e51297f)
6.1.y | Present (different SHA1: 3267b254dc0a)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0f6ede9fbc747 ! 1:  e37924b352d9b net: defer final 'struct net' free in netns dismantle
    @@ Metadata
      ## Commit message ##
         net: defer final 'struct net' free in netns dismantle
     
    +    [ Upstream commit 0f6ede9fbc747e2553612271bce108f7517e7a45 ]
    +
         Ilya reported a slab-use-after-free in dst_destroy [1]
     
         Issue is in xfrm6_net_init() and xfrm4_net_init() :
    @@ Commit message
         Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://patch.msgid.link/20241204125455.3871859-1-edumazet@google.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
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
| stable/linux-5.10.y       |  Success    |  Success   |

