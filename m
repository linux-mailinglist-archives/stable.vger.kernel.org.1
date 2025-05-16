Return-Path: <stable+bounces-144609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058A2AB9FA9
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BADA1883110
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E01A7264;
	Fri, 16 May 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya6oIb9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3639ACC
	for <stable@vger.kernel.org>; Fri, 16 May 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408386; cv=none; b=j0R1erHIhYGWrL6+ZUQD6dTraRWFsCLmnnNly8raTBRb8n3ZW/n82NN9IXEJwd7I/qDJRzcrXtEEEXqZ405PYSNW27qULAa9b3I4kJTuR+qoUN8B7Vz0RXwDJuwqhllvQL6wlZPrVywIQQoajuRDL2hy443sG5PlqSAAUGlzQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408386; c=relaxed/simple;
	bh=AHohmIQQuUIxvrqjp+ds6L4/fKWQKRQq58r0rO9c7ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mxf73oMwEdoEYdOOx8F6W+sqvHR/z9/M9nxJsIveN/QxFbpydmio4vwa+5okvJwgsKuIgpMsCCxWT3X1TqKX2tfNvk585vFkbRK6eMEKkqcu/yMT45FnMExeVoU110VXv3WfsYnb6NoSuDVDobciQyuELOazclH7hbjaQD9MTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya6oIb9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCA7C4CEE4;
	Fri, 16 May 2025 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408385;
	bh=AHohmIQQuUIxvrqjp+ds6L4/fKWQKRQq58r0rO9c7ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ya6oIb9rfDdR/Ll5/z5C+G4DW0PN9l0eBA6ZP79nlK2cIG9Y8RuA/u4pTenh89Bs3
	 mL+b8DSrhIb414lWqGKLGPVW5UoyiejLK973uNK9Ti7IkWvdj+Oh+dRURNF7Tyjs8q
	 jJiurFNwFgGu8t/ingF1GG3AQOYgLQSaQJo6uXZZOVpH6GpW/yhxLK2tKW1ZnPdRHL
	 uVZJJ3iUUKy6Neg5CtNKkmGzKgEe+IDx4qPxj2Zlh0wbDLHFiwutCqgd5jgr2mGHOB
	 Y6CMmtEzz5/j4uz1XJL+sFu68TbNXJT6RqGj0MZqPROPeXgTJ0C5+0GJ1ZcaLlxKIq
	 1HQEbl0rc9MUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ipv4: Fix uninit-value access in __ip_make_skb()
Date: Fri, 16 May 2025 11:13:03 -0400
Message-Id: <20250515081242-84ff67101aca95da@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250515060244.413133-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: fc1092f51567277509563800a3c56732070b6aa4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Shigeru Yoshida<syoshida@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 5db08343ddb1)

Note: The patch differs from the upstream commit:
---
1:  fc1092f515672 ! 1:  d14a3911b2aab ipv4: Fix uninit-value access in __ip_make_skb()
    @@ Metadata
      ## Commit message ##
         ipv4: Fix uninit-value access in __ip_make_skb()
     
    +    [ Upstream commit fc1092f51567277509563800a3c56732070b6aa4 ]
    +
         KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_skb()
         tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cause a
         race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRINCL
    @@ Commit message
         Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
         Link: https://lore.kernel.org/r/20240430123945.2057348-1-syoshida@redhat.com
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
     
      ## net/ipv4/ip_output.c ##
     @@ net/ipv4/ip_output.c: struct sk_buff *__ip_make_skb(struct sock *sk,
    + 		 * so icmphdr does not in skb linear region and can not get icmp_type
      		 * by icmp_hdr(skb)->type.
      		 */
    - 		if (sk->sk_type == SOCK_RAW &&
    --		    !inet_test_bit(HDRINCL, sk))
    +-		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
    ++		if (sk->sk_type == SOCK_RAW &&
     +		    !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
      			icmp_type = fl4->fl4_icmp_type;
      		else
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

