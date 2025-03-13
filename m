Return-Path: <stable+bounces-124346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4682A5FD9F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511A83A38F6
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4468136347;
	Thu, 13 Mar 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMJ6pz8M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9C153801
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886538; cv=none; b=nnf9rdGYUpca04wgDqvYz/919vxExB/UFcCQcth+xp+i76ZDCl28BEoigNejMEP45QLR9GDJbYmKI+t9C6iqvnuNEjn2f0hatP/GjHcBIkVjwNkWVQu37I9xj/gQv8UTyv7nVgulIcsSlp7DMDqG23mFCMvDXImEFntsuOk0P1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886538; c=relaxed/simple;
	bh=DK2RXTTy3iIOOT+rFpYOb9uUOYjN0DtGpLM6eFl6ujQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6HxUlZVoGjQrhjiIzVYnUtKgMowje+Y8ljOseXV21QsnVU9iyIe6sa2txN7/4Wchhzwq3QNKB0SGt/f/WKm+BohoMxOAQSECPYyEVYJCLSAw8zGkPAo8i0KWhVuM74NH1ESaffXDgeFNKTYNyxx5hRR7gffucO9zsoHVDrH4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMJ6pz8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58034C4CEDD;
	Thu, 13 Mar 2025 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886537;
	bh=DK2RXTTy3iIOOT+rFpYOb9uUOYjN0DtGpLM6eFl6ujQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMJ6pz8MWzodQVBkmnPllVRIapZbMeir+4GPPfy7xVq/3CHJtQUMu3AayM+CK+7nt
	 N/eMKfwEStTTBbPNSlMRv6Ru/5Z0c4Va7eUSFxXDtkWhHW6nGRQArnZtatMK4UCpon
	 AlbFApOWHAAmvB4joDeBMs6vzIj5E0dnzecEbIliU5LEXlDNOa5shR9MZVxej9vbTZ
	 8DTtA7rC9SpPzLvx5kVVxbmepjj/q2q8sQJ1F/uNgv7YdJYqZY2j+J3cmgsn+VM9DB
	 KskE76paAysFtQJdwLIuJ1U6ckpUJ8PHVruEIgz0je44UzhSJyq+yCH8yVOJJtJaaO
	 V4opufKEllUOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdelkareem Abdelsaamad <kareemem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 5.15.y] ipv6: Fix signed integer overflow in __ip6_append_data
Date: Thu, 13 Mar 2025 13:22:16 -0400
Message-Id: <20250313131400-77a3493595c27cc7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313135001.21490-1-kareemem@amazon.com>
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

The upstream commit SHA1 provided is correct: f93431c86b631bbca5614c66f966bf3ddb3c2803

WARNING: Author mismatch between patch and upstream commit:
Backport author: Abdelkareem Abdelsaamad<kareemem@amazon.com>
Commit author: Wang Yufen<wangyufen@huawei.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f93431c86b631 ! 1:  bc8424dc08f8e ipv6: Fix signed integer overflow in __ip6_append_data
    @@ Metadata
      ## Commit message ##
         ipv6: Fix signed integer overflow in __ip6_append_data
     
    +    [ Upstream commit f93431c86b631bbca5614c66f966bf3ddb3c2803 ]
    +
         Resurrect ubsan overflow checks and ubsan report this warning,
         fix it by change the variable [length] type to size_t.
     
    @@ Commit message
         Signed-off-by: Wang Yufen <wangyufen@huawei.com>
         Link: https://lore.kernel.org/r/20220607120028.845916-1-wangyufen@huawei.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Conflict due to
    +    f37a4cc6bb0b ("udp6: pass flow in ip6_make_skb together with cork")
    +    not in the tree
    +    ]
    +    Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
     
      ## include/net/ipv6.h ##
     @@ include/net/ipv6.h: int ip6_find_1stfragopt(struct sk_buff *skb, u8 **nexthdr);
    @@ include/net/ipv6.h: struct sk_buff *__ip6_make_skb(struct sock *sk, struct sk_bu
      					 int len, int odd, struct sk_buff *skb),
     -			     void *from, int length, int transhdrlen,
     +			     void *from, size_t length, int transhdrlen,
    - 			     struct ipcm6_cookie *ipc6,
    + 			     struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
      			     struct rt6_info *rt, unsigned int flags,
      			     struct inet_cork_full *cork);
     
    @@ net/ipv6/ip6_output.c: EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
      					 int len, int odd, struct sk_buff *skb),
     -			     void *from, int length, int transhdrlen,
     +			     void *from, size_t length, int transhdrlen,
    - 			     struct ipcm6_cookie *ipc6, struct rt6_info *rt,
    - 			     unsigned int flags, struct inet_cork_full *cork)
    - {
    + 			     struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
    + 			     struct rt6_info *rt, unsigned int flags,
    + 			     struct inet_cork_full *cork)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |

