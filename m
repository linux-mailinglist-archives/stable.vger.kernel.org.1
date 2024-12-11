Return-Path: <stable+bounces-100662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A09ED1EC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885E4284EF3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057FD1DDC3A;
	Wed, 11 Dec 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqLxAiva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AB1DDC28
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934767; cv=none; b=nEruNX7g9pzi6QtDUeTjOJ39OBcjAaltZe8ofmzrsqCjDmuMLVrl4U6DfJxQZZYKj4a+b0OO60j8W3hhl5hpt2tMaVbGCiNLYPn3eS7B+4alddBlf3nr8yjVH1FRjBpc1+S4SK1lwZEh8gfZjZECLyFHnaP+xO3Fd2C0odXnc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934767; c=relaxed/simple;
	bh=jM+PuwsYkcC4dd6I45wRX+/+VfVNngGoQKn6wnHhelk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaUg+U9Vvzup5Qs3Zn9EpmuTnhaW5DD5syqoOUTGKLArA4LfapoQpzOoXX0zcV2y3Xis7DYOpm9CWC2YeM0vZKWfyuLv1IeipOxWJTKybpZQwpzS695NK5KChsZmdfZBc1wpnDMxLZ4VQBVDtYtk/lcxVcI1KASBbQDsdgh2tVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqLxAiva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C827C4CED7;
	Wed, 11 Dec 2024 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934767;
	bh=jM+PuwsYkcC4dd6I45wRX+/+VfVNngGoQKn6wnHhelk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqLxAivakCZbaf3S6bYfizFZ1OCFtlLAkVoyYyKCZBIcLs3p+HZ7Q9VuKcT3pXsLZ
	 sZlgdiQwWwboEreR9pYQ/ZSEUrBI+IvOmpw5ZkOI9qRvq4kY7xRZw22H6gJOxBaqcH
	 OOyQJ1Ste95eTP4oHc0C+i7AEPy0y53WH4KqE5LbgBUth7JY1NdUZXBItEvHt9ybgv
	 oGH+2EDmiW4UvNqhoIm1gLidJlOJbZfK3WqSz2TALUvU2BY1kJ4khRrzBqkEigmhrk
	 s68lrHPAVNwR8gRTxRNdgjZlfZqezIgD8UKN7bu5kc4gqMXYvdNYmYy07qWZ5zmIXR
	 a9fTp0MPVAHQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: libo.chen.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Wed, 11 Dec 2024 11:32:45 -0500
Message-ID: <20241211094123-9216e12276833847@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211083351.235475-1-libo.chen.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: dd89a81d850fa9a65f67b4527c0e420d15bf836c

WARNING: Author mismatch between patch and upstream commit:
Backport author: libo.chen.cn@eng.windriver.com
Commit author: Willem de Bruijn <willemb@google.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3db4395332e7)
6.1.y | Present (different SHA1: 5a2e37bc648a)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  dd89a81d850fa ! 1:  2115d8ab02118 fou: remove warn in gue_gro_receive on unsupported protocol
    @@ Metadata
      ## Commit message ##
         fou: remove warn in gue_gro_receive on unsupported protocol
     
    +    [ Upstream commit dd89a81d850fa9a65f67b4527c0e420d15bf836c ]
    +
         Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
         not known or does not have a GRO handler.
     
    @@ Commit message
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Link: https://lore.kernel.org/r/20240614122552.1649044-1-willemdebruijn.kernel@gmail.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
     
    - ## net/ipv4/fou_core.c ##
    -@@ net/ipv4/fou_core.c: static struct sk_buff *gue_gro_receive(struct sock *sk,
    + ## net/ipv4/fou.c ##
    +@@ net/ipv4/fou.c: static struct sk_buff *gue_gro_receive(struct sock *sk,
      
      	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
      	ops = rcu_dereference(offloads[proto]);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

