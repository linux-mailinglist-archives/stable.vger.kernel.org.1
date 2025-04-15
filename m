Return-Path: <stable+bounces-132785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C3CA8AA3E
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B671902D9E
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F7257ACA;
	Tue, 15 Apr 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFrKsF4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C5253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753394; cv=none; b=LnB33vrYKWuAUArgTH9DpeNEd1izLYzFXI5PVHsZ5rh8cBhZo7LhgBgto/Y3+71xbi1RNcTFRqAQqp348HxG0ebiIlqa4Yh9iV6upWlqj129j41V6f8/HgsJ/RnIMa+tJGqCJD4vGsyOSf66aDtXKSJ4IsE5GDH4zVzgNFfpU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753394; c=relaxed/simple;
	bh=Ey0S1NX9kvDKmgJ8/eCBH3U9DlLW9eSJPsJ27WYvpVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baEzPApzW8Yfe2DTNt/T5OfJsrU3xO2OkoKnuNNui2fv/khaebArHqqaJpiAd0t7xe3E8Jj0Z4oZW4hUMJdb+KupxXpgBlXc8/tAWOj3Q+BoJvkTCGDyF0bS9YSnNXeHMdfY/enMM/fzMXJiq1yILzOpxcS+P/32hWi/bCWcnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFrKsF4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02559C4CEE7;
	Tue, 15 Apr 2025 21:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753393;
	bh=Ey0S1NX9kvDKmgJ8/eCBH3U9DlLW9eSJPsJ27WYvpVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFrKsF4hqNUKAirMUuCgG6ou49NIlp3H0IxuvZQtuhUEPK2Wcs5TPaMQeqJUZukkP
	 MXLGA2UxS9I3B1Gwm//kw7jc0QWp40Re7pH/4pCWIESlFQB6qKKfUn1hrfACDI3bhU
	 DkBu50HQsZss98lTNkJvZGJpPVftSZ5QFVYaomXIaWWbPQQjoFHVqjmuVR1PRcylet
	 3GK7/A8jKJSMY3lgdFs0j5Tm5olvIzzpck0pUNesaXds7snzEWs3nN8TXPgTPw0nv8
	 FI4RJC6+LPJuehW8xaXNHp4D7B1KlSMySVIwqzwevELgVeOXoB5Ok+TCS4S/iink8T
	 aL0FnR3Gy4PHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 4/6] net: fix crash when config small gso_max_size/gso_ipv4_max_size
Date: Tue, 15 Apr 2025 17:43:11 -0400
Message-Id: <20250415124015-bfc23e13b0e7cdb2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414185023.2165422-5-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: 9ab5cf19fb0e4680f95e506d6c544259bf1111c4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>
Commit author: Wang Liang<wangliang74@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ac5977001eee)
6.1.y | Present (different SHA1: e9365368b483)

Note: The patch differs from the upstream commit:
---
1:  9ab5cf19fb0e4 ! 1:  92a2aab3e8a99 net: fix crash when config small gso_max_size/gso_ipv4_max_size
    @@ Metadata
      ## Commit message ##
         net: fix crash when config small gso_max_size/gso_ipv4_max_size
     
    +    [ Upstream commit 9ab5cf19fb0e4680f95e506d6c544259bf1111c4 ]
    +
         Config a small gso_max_size/gso_ipv4_max_size will lead to an underflow
         in sk_dst_gso_max_size(), which may trigger a BUG_ON crash,
         because sk->sk_gso_max_size would be much bigger than device limits.
    @@ Commit message
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Link: https://patch.msgid.link/20241023035213.517386-1-wangliang74@huawei.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [ Resolve minor conflicts to fix CVE-2024-50258 ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Harshit: Clean cherrypick from 6.1.y commit]
    +    Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
     
      ## net/core/rtnetlink.c ##
     @@ net/core/rtnetlink.c: static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
    @@ net/core/rtnetlink.c: static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
      	[IFLA_PHYS_PORT_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
      	[IFLA_CARRIER_CHANGES]	= { .type = NLA_U32 },  /* ignored */
      	[IFLA_PHYS_SWITCH_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
    -@@ net/core/rtnetlink.c: static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
    - 	[IFLA_TSO_MAX_SIZE]	= { .type = NLA_REJECT },
    - 	[IFLA_TSO_MAX_SEGS]	= { .type = NLA_REJECT },
    - 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
    --	[IFLA_GSO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
    -+	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
    - 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
    - };
    - 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

