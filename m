Return-Path: <stable+bounces-164791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF9B1276E
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE53AB8CC
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AC2620D2;
	Fri, 25 Jul 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy5r1DjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2E2609C5
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485980; cv=none; b=Vp7XCalEIYhlexb1yhowlqR+MaUQjoWxYWay4pDrQ3521xO3TVkQwcDsV7q/e4lOyMHQ5sDNJtvGxsiGS//C8wbMrJbkA15ow7kbfTP3/WllargQf+aBaz98rWfOD663GRNyx5kNAftndRvbm6vawfpfy0CsjFC4lbcgpKGEEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485980; c=relaxed/simple;
	bh=Qqib+9FCL8X5YNqn55PTjmSKQoIj/DUe5okZSrlFhX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhdNao/pIUZdoF446Dr+KcI6pfD0AYMJFjwBe8B4MNXCHnMiIKn7k89DUyxNCpAeQFGUpmyN4ZdOpEZ9isYbzgu0dbEW19bv+00DaWrKs0BsLn/SMuVcWv1o3jvoSzfEiOlQhkFP+o443SK0ZkGd4PgCYJ/U5NZWJ93Mz4vYX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy5r1DjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1109C4CEF4;
	Fri, 25 Jul 2025 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485979;
	bh=Qqib+9FCL8X5YNqn55PTjmSKQoIj/DUe5okZSrlFhX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qy5r1DjU+wULViIljBmqTDvakc1Cj/faKL6LZLktok0PXHG1rMMdO2lp/1PJyT1zn
	 4ZBxLkbzoivkOqWkhcjl41+sFGJZMOfrTUpXz1j2tL//Hyu9Z7SpZU4OW+ybaWg2Pd
	 c+m+bJewEkJGx11UUw63CdOfY4efmSQC4RCPzsab3n8f3Pm1fIMt/g4Kr3SSBypaDu
	 9B1yVqSQ+6Prl5K1BqItBxSPGqj0Ww+4ZcEKyfsRW1IU3gY5yGTeUXFfA5S4MPbqJZ
	 jjedrLwR9HJrBpCBA0vVGuY+BtoyrWDDbLz+dp+fi5LnZUHlwlPg+C/hCHTZyij8CF
	 BIXIfDX2nnNrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] net: add netdev_lockdep_set_classes() to virtual drivers
Date: Fri, 25 Jul 2025 19:26:17 -0400
Message-Id: <1753461306-3b9f6dd9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724200524.172820-1-sumanth.gavini@yahoo.com>
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

The upstream commit SHA1 provided is correct: 0bef512012b1cd8820f0c9ec80e5f8ceb43fdd59

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sumanth Gavini <sumanth.gavini@yahoo.com>
Commit author: Eric Dumazet <edumazet@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0bef512012b1 ! 1:  9684eff65270 net: add netdev_lockdep_set_classes() to virtual drivers
    @@
      ## Metadata ##
    -Author: Eric Dumazet <edumazet@google.com>
    +Author: Sumanth Gavini <sumanth.gavini@yahoo.com>
     
      ## Commit message ##
         net: add netdev_lockdep_set_classes() to virtual drivers
     
    +    commit 0bef512012b1cd8820f0c9ec80e5f8ceb43fdd59 upstream.
    +
         Based on a syzbot report, it appears many virtual
         drivers do not yet use netdev_lockdep_set_classes(),
         triggerring lockdep false positives.
    @@ Commit message
         Signed-off-by: Eric Dumazet <edumazet@google.com>
         Link: https://lore.kernel.org/r/20240212140700.2795436-4-edumazet@google.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
     
      ## drivers/net/dummy.c ##
     @@ drivers/net/dummy.c: static int dummy_dev_init(struct net_device *dev)
    @@ drivers/net/veth.c: static void veth_free_queues(struct net_device *dev)
      ## drivers/net/vxlan/vxlan_core.c ##
     @@ drivers/net/vxlan/vxlan_core.c: static int vxlan_init(struct net_device *dev)
      	if (err)
    - 		goto err_gro_cells_destroy;
    + 		goto err_free_percpu;
      
     +	netdev_lockdep_set_classes(dev);
      	return 0;
      
    - err_gro_cells_destroy:
    + err_free_percpu:
     
      ## net/ipv4/ip_tunnel.c ##
     @@ net/ipv4/ip_tunnel.c: int ip_tunnel_init(struct net_device *dev)
    @@ net/ipv6/ip6_gre.c: static int ip6erspan_tap_init(struct net_device *dev)
     
      ## net/ipv6/ip6_tunnel.c ##
     @@ net/ipv6/ip6_tunnel.c: ip6_tnl_dev_init_gen(struct net_device *dev)
    - 	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
    + 	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len - t_hlen;
      
      	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
     +	netdev_lockdep_set_classes(dev);

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Success     | Success    |

