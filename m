Return-Path: <stable+bounces-134690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02576A94339
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60163189A227
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F21B4244;
	Sat, 19 Apr 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axlQVi15"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6418DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063245; cv=none; b=QUF3U8cNAoetqq8OkaWvBQpR1nn+d3x2ihiVq+NB7nVEpEZCJ0RE/0wP24XoFhmpTiOQ5rLISBB3BDnqc+opzE+2LQDao/upgny30P3CdX0rdjBLHzpYpxnMKW2bIWv47j40UVNhbWdE+CaOYsKc0Qi9clOwV6jAVYrlsunEk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063245; c=relaxed/simple;
	bh=uuiUp2Tat09Qc+rnwrwRHVufIohaWz4GuZIsjXZ+j2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAgu/j6oCz62J///eU/xh8G2HCFTZO9mbFoHZF0MSlCoJFm3A56imVK0k0Nlc0ALddNl/FhWBGwRmRFPE6jLLb81JRgSe5RJWQ9//eR2o8MKTfNHTxYoYSz78uNN4FDHHm71kzm8oCzSiEzBISDs/SzfHvU7d4btQToCd0r0sdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axlQVi15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB28C4CEE7;
	Sat, 19 Apr 2025 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063245;
	bh=uuiUp2Tat09Qc+rnwrwRHVufIohaWz4GuZIsjXZ+j2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axlQVi15J4DqfPo+2l3v8HyC+k5WakdsOCZMUlixAzIef+84FjcWSJ1MhzctYlUVL
	 w88HV6KVSzxqQ4oXzf3Y5TUwhE/8UFx0TyD6hp4tZQ804UW2HvQ4mRWN/0sczwCJDW
	 6p+vXxQFZyqDPiN/wVd9i0zZhNDWPFt39rrMBbnVqszdQElN8p09QiVdM/ctYoIOCJ
	 13OaonArHtc9qtLgfIXDRVAXjV3xzoP70ecXt0ciQMTaVGszQizJ6Q9syL02a0wOis
	 REkSfuUaBaXfOhX3iczVKKAp1twVygz4k8sviqUoeUbTfTan5mCFY547+NBeI4QOZS
	 aEPZv2v8S/uFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] net: defer final 'struct net' free in netns dismantle
Date: Sat, 19 Apr 2025 07:47:23 -0400
Message-Id: <20250418194414-f759aa593d6ce98d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418012409.2059897-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  0f6ede9fbc747 ! 1:  933695261e2d5 net: defer final 'struct net' free in netns dismantle
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
| stable/linux-5.15.y       |  Success    |  Success   |

