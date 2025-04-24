Return-Path: <stable+bounces-136633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D24A9BB2E
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28501BA4394
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C927BF9E;
	Thu, 24 Apr 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTFc0eG5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B844A93D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536967; cv=none; b=mE1Vau/OASt1qkwTRs+gN9Vefiyd2DkbpYd/4D4hAxkj74l5bJki/KmuU2Bk/dC1ia9pnDyRnF64SIjoQy9SD9/+kHtXBXh3qzaHa30RsecsCP1kYFeKw9ECrKkYW9Fro9WHWmv9RrWpMe6WDQwItIXM2ZbUy6bP3ovdRoFQTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536967; c=relaxed/simple;
	bh=OUodgECuh+knwIdKk+qVahbwOKac9lfZTkMcrunMv4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlGQJ9fjZhKDvslS2le348XWpLyTNgijdPhePKDriVkM2q812G5x9njAm3zIgcAqqCPuIgfUAWC+7SAR05LwWfZp9h9utqenqoFo6wFMSYrJ1K5EYe6cImM7bissDSimT8vNDUOWfUIma1R+Wdxh5tfQVTAUTPk30HBFdQO6LjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTFc0eG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F8EC4CEE3;
	Thu, 24 Apr 2025 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536967;
	bh=OUodgECuh+knwIdKk+qVahbwOKac9lfZTkMcrunMv4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GTFc0eG5s1IE1BlAzjgNlapQJv7KuEV0oZCj3dAW1837ZS1z856poxS//JCKGsuSL
	 7FlHk26fNm4o7VfNzeDh9Sk2nD099Ufkd9b2z5zrUAZyA94U76z7ukAsv0dGf74Xpr
	 +np3jnmKC4WNSL1r8ilMjEEu5Jghka1L0FB5RKwhtrkx2PfIdIuItx33o/zlY292p5
	 4ofT/TC8xSHRJ5vzMryMw/DCzzlaGNy1AEP7/HmtnMSPXUQR9LzgBvDGHIKpZnPWZs
	 M297QxTZmJEKgGpcdcBp1YjePazz5BshQobw8+Skd8v46wq2BWrLBkz7mlgyo0bMZD
	 1Hs2W7JhcGVzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] Bluetooth: SCO: Fix UAF on sco_sock_timeout
Date: Thu, 24 Apr 2025 19:22:42 -0400
Message-Id: <20250424165930-3baf689a3314baed@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424062142.3054734-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 1bf4470a3939c678fb822073e9ea77a0560bc6bb

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d30803f6a972)
6.1.y | Present (different SHA1: 9ddda5d967e8)

Note: The patch differs from the upstream commit:
---
1:  1bf4470a3939c ! 1:  47ca818750c07 Bluetooth: SCO: Fix UAF on sco_sock_timeout
    @@ Metadata
      ## Commit message ##
         Bluetooth: SCO: Fix UAF on sco_sock_timeout
     
    +    [ Upstream commit 1bf4470a3939c678fb822073e9ea77a0560bc6bb ]
    +
         conn->sk maybe have been unlinked/freed while waiting for sco_conn_lock
         so this checks if the conn->sk is still valid by checking if it part of
         sco_sk_list.
    @@ Commit message
         Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
         Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## include/net/bluetooth/bluetooth.h ##
     @@ include/net/bluetooth/bluetooth.h: int  bt_sock_register(int proto, const struct net_proto_family *ops);
    @@ include/net/bluetooth/bluetooth.h: int  bt_sock_register(int proto, const struct
      void bt_sock_link(struct bt_sock_list *l, struct sock *s);
      void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
     +bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
    - struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
    - 			   struct proto *prot, int proto, gfp_t prio, int kern);
      int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
    + 		     int flags);
    + int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
     
      ## net/bluetooth/af_bluetooth.c ##
     @@ net/bluetooth/af_bluetooth.c: void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
    @@ net/bluetooth/af_bluetooth.c: void bt_sock_unlink(struct bt_sock_list *l, struct
     +
      void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
      {
    - 	const struct cred *old_cred;
    + 	BT_DBG("parent %p, sk %p", parent, sk);
     
      ## net/bluetooth/sco.c ##
     @@ net/bluetooth/sco.c: struct sco_pinfo {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

