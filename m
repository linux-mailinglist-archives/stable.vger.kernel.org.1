Return-Path: <stable+bounces-110055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C3A185D4
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AC188B2F5
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E91F5433;
	Tue, 21 Jan 2025 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0BIsE6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E1A1EB2F
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489165; cv=none; b=iSl/4qX0XPfob42NZkD0tkfR+UviSTKki0eY7+5Gk/91R7l8R+QxnGEc7t0EWwLpT5Ox9wbfUGkJKZ9QY7z8Gh5t+EP9eLSELL1Dka3SSgTDmS22zaIuiC9q6qmd1GsNFp0zwP215HLEiXLlXqZz+flVaE8khEpN4dh+j3mLzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489165; c=relaxed/simple;
	bh=XNPdPcCOcAn5Of4pejcezfWknHKC1UzZ+/hIK+UCN0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5cgue/aGiahXqE6oL9VqACB7uSwo4Eb2wJX/UFNNZii3A45kldonHBPaL94czKVX2RorUL7I6PLcM4hyljjomjgZMSF1O1352vv2epvp3x5UWhZySiju6TDReWNmhJrf1ngdLLXDleINneiItCvEtm6pxMcL4mnTbHBbHyZHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0BIsE6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6EAC4CEDF;
	Tue, 21 Jan 2025 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489164;
	bh=XNPdPcCOcAn5Of4pejcezfWknHKC1UzZ+/hIK+UCN0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0BIsE6ilmZBLyIlx31wL6Se0eM2gx4z313GUlhyluVhBFoK2yq9UsLGoBjVtbppz
	 aBZmPdAFFENFJLG/R6RDiR0/sPD7FbkKmAsrSSHjs9Fz9NMtb1MVHWOrBlXepP7HGK
	 4pgu79bMco+vSvW4Y1AKwDQHCF3z6akgG43igcj5vqLuNNp5kz9k0KwZNQmz0gQkdt
	 QzcC0dURtIAZOFb4tOsDHsuAp0bIlt0LOM3AePZAaDHo/1jBz6M4Jk2gmwkQEmyPKz
	 /AQYfQZT7fTi9PHVtl1ZpHDQaPJfIIQqWhwRfdsw6nHYySoqqhs3FRO+WBbtXnFADm
	 C4yCbRIcuVDGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: fix data-races around sk->sk_forward_alloc
Date: Tue, 21 Jan 2025 14:52:42 -0500
Message-Id: <20250121123722-6ca75290b4d810cc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_A0C9136B409C0E18FC860D5AE51A950F5007@qq.com>
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

The upstream commit SHA1 provided is correct: 073d89808c065ac4c672c0a613a71b27a80691cb

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Wang Liang<wangliang74@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  073d89808c065 ! 1:  b42ede0a73c71 net: fix data-races around sk->sk_forward_alloc
    @@ Metadata
      ## Commit message ##
         net: fix data-races around sk->sk_forward_alloc
     
    +    commit 073d89808c065ac4c672c0a613a71b27a80691cb upstream.
    +
         Syzkaller reported this warning:
          ------------[ cut here ]------------
          WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
    @@ Commit message
         Signed-off-by: Wang Liang <wangliang74@huawei.com>
         Link: https://patch.msgid.link/20241107023405.889239-1-wangliang74@huawei.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## net/dccp/ipv6.c ##
     @@ net/dccp/ipv6.c: static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
    @@ net/ipv6/tcp_ipv6.c: int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
     +	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
      		opt_skb = skb_clone_and_charge_r(skb, sk);
      
    - 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
    + 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
     @@ net/ipv6/tcp_ipv6.c: int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
    - 				if (reason)
    - 					goto reset;
    - 			}
    + 		if (nsk != sk) {
    + 			if (tcp_child_process(sk, nsk, skb))
    + 				goto reset;
     -			if (opt_skb)
     -				__kfree_skb(opt_skb);
      			return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

