Return-Path: <stable+bounces-94606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378349D6004
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7BB224AD
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5F473501;
	Fri, 22 Nov 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjKGCj2B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6CF12E7F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283512; cv=none; b=BT3/dLGurmJMTaEk6EnfIkiCfBe4O8wxWdye4W0zNyvb0wD8yYr/dMIgiPOy1Y353Pw+zXnN7j8djklwGb9E/OwMj34lGHhEewH/hiq+VZjwiNWrDfWcxqVXdXNidxYLASYPvjbmjbHYXz2SwUV/kt+XClUShPxH3S5wLZZCJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283512; c=relaxed/simple;
	bh=b06kHRAaCF0am7imBtytRwXZ1zW6G/BnRq3D28QCbTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6MSvmrytOmAqKesaA/tpFg2dNMvsUsEh5jV/UzeYQbLu14wVY9BQyl7035Z3D3srfaYPNBcACieTW7YXm5XEP1RqnrZdwXlMOnth1PKKghAdwE5NeXojoTsUX6pH3Qe6vBRfGzrd70KYKdrIY2eh0ruDwILtjOak7FxCGKWX88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjKGCj2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BE7C4CECF;
	Fri, 22 Nov 2024 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732283512;
	bh=b06kHRAaCF0am7imBtytRwXZ1zW6G/BnRq3D28QCbTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjKGCj2B5Iw+osmXZy7vXD1qrddZnrgxGsA5qYYtyYJM94Img88VOeWxnt+zUVN2+
	 ctUwIFH7q2lSz/D3OEBSp1A6Hm/FHdBd6hviEU+NYq4HMIAuwmhUSzIXxWXYyVfRoP
	 cXFtPMGK1N5qaoQqvYMYy9P65OcFnfMzcWLiBE01VZb9WfP3Y8Gxe90lShTjAs/xbP
	 80rc7JlFrEdLQvSak13NdycgAp56TNa72L8aSlkuu2gGi/TgUXhM38D8XvDWnnNsn5
	 62mLkXvrNvwdfbUQxJD6ZUdpUYlqvVWrekvWSdJ1oUgf+f/A2GarhQkMJuHTaRJ1Sf
	 hmns/B8ZGvlog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] net: fix crash when config small gso_max_size/gso_ipv4_max_size
Date: Fri, 22 Nov 2024 08:51:53 -0500
Message-ID: <20241122084559-4fde08dbbd648221@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122031809.3853183-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 9ab5cf19fb0e4680f95e506d6c544259bf1111c4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Wang Liang <wangliang74@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: e72fd1389a53)
6.6.y | Present (different SHA1: ac5977001eee)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 08:40:39.766289882 -0500
+++ /tmp/tmp.58u8agz5Rn	2024-11-22 08:40:39.760746269 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 9ab5cf19fb0e4680f95e506d6c544259bf1111c4 ]
+
 Config a small gso_max_size/gso_ipv4_max_size will lead to an underflow
 in sk_dst_gso_max_size(), which may trigger a BUG_ON crash,
 because sk->sk_gso_max_size would be much bigger than device limits.
@@ -18,15 +20,17 @@
 Reviewed-by: Eric Dumazet <edumazet@google.com>
 Link: https://patch.msgid.link/20241023035213.517386-1-wangliang74@huawei.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+[ Resolve minor conflicts to fix CVE-2024-50258 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- net/core/rtnetlink.c | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
+ net/core/rtnetlink.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
-index e30e7ea0207d0..2ba5cd965d3fa 100644
+index afb52254a47e..45c54fb9ad03 100644
 --- a/net/core/rtnetlink.c
 +++ b/net/core/rtnetlink.c
-@@ -2032,7 +2032,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
+@@ -1939,7 +1939,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
  	[IFLA_NUM_TX_QUEUES]	= { .type = NLA_U32 },
  	[IFLA_NUM_RX_QUEUES]	= { .type = NLA_U32 },
  	[IFLA_GSO_MAX_SEGS]	= { .type = NLA_U32 },
@@ -35,12 +39,6 @@
  	[IFLA_PHYS_PORT_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
  	[IFLA_CARRIER_CHANGES]	= { .type = NLA_U32 },  /* ignored */
  	[IFLA_PHYS_SWITCH_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
-@@ -2057,7 +2057,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
- 	[IFLA_TSO_MAX_SIZE]	= { .type = NLA_REJECT },
- 	[IFLA_TSO_MAX_SEGS]	= { .type = NLA_REJECT },
- 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
--	[IFLA_GSO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
-+	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
- 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
- };
- 
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

