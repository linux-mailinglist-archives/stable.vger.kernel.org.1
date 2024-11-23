Return-Path: <stable+bounces-94692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF29D6BA2
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 22:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DD3B22509
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19521A7ADE;
	Sat, 23 Nov 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrk8Hk2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A41A7ADD
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732397408; cv=none; b=WL36Q/8pAmf0hS+onw3E6mERI7VRWTGb0G6T0+ZN2PR+vaJmptFBzCccOf9jOMV9n9tUkNKHkg517+pe8hpyobhgvuzv/Hs0f79VVs7abXpGJy4BLEJfEtk/v1cS0ww6dmeoxPhQ8/4NR8upllA/18x+7dcxHj8GAIQzRDhlHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732397408; c=relaxed/simple;
	bh=gEdUsTZyORZ1VzMtwoOX8SG4Oxz1KgYxwt39oAbNJ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogyUJdB9bPQSMYxYAfPhXoSoCqs2SVgNyNbjLxQHMQf4b+MLS/rlnOv+rfmQ78oHSAqom/fOQHxCwtCXLDEZbx3MapP+kl8FZU0wQ+ruEBp2zkM6wtmUvL1jtlLubAugi1W30BNaO2wkIN79zQxOg6EkV7so37Wpj6byQWRQvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrk8Hk2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE607C4CECD;
	Sat, 23 Nov 2024 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732397408;
	bh=gEdUsTZyORZ1VzMtwoOX8SG4Oxz1KgYxwt39oAbNJ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrk8Hk2LWeWUjuNV2uJU48UcXx76x1US2WNfaPDcIrlOe7mtJGQnL9H3akV6IZQ+N
	 4MVucYs+b4KoVDL/oaL+dEJnym+C0qxp3yKGJwGo3CDP+P0rpu5joRVHZP3qXQfOZC
	 RY0bM+14nI6l/LoOXx9gDcC/98qJfui/uLLiWCODYihR2V8q06AOqUVpvyEaqanlSY
	 HduWxXyyN4/HEXPtQgG1Bam03mo7wtreHckERNRZWr0N8wB+WLi5TSdc1D3Bw7nNXb
	 JvO9KCJHVTREh2aZO5Hwmrbv2bodqFXzge66wPYSF9lsidDx9soY/iZdS/47R8WFBF
	 DSf9FY/K63WqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH net v2] udp: Compute L4 checksum as usual when not segmenting the skb
Date: Sat, 23 Nov 2024 16:30:06 -0500
Message-ID: <20241123153611-f1816a991d9ce741@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
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

Found matching upstream commit: d96016a764f6aa5c7528c3d3f9cb472ef7266951


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 15:36:10.452516394 -0500
+++ /tmp/tmp.YUZFWQktZJ	2024-11-23 15:36:10.442794360 -0500
@@ -1,5 +1,3 @@
-If:
-
   1) the user requested USO, but
   2) there is not enough payload for GSO to kick in, and
   3) the egress device doesn't offer checksum offload, then
@@ -17,15 +15,17 @@
 Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
 Acked-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
 Cc: stable@vger.kernel.org
-Link: https://patch.msgid.link/20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com
-Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+---
+Changes in v2:
+- Fix typo in patch description
+- Link to v1: https://lore.kernel.org/r/20241010-uso-swcsum-fixup-v1-1-a63fbd0a414c@cloudflare.com
 ---
  net/ipv4/udp.c | 4 +++-
  net/ipv6/udp.c | 4 +++-
  2 files changed, 6 insertions(+), 2 deletions(-)
 
 diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
-index 8accbf4cb2956..2849b273b1310 100644
+index 8accbf4cb295..2849b273b131 100644
 --- a/net/ipv4/udp.c
 +++ b/net/ipv4/udp.c
 @@ -951,8 +951,10 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
@@ -41,7 +41,7 @@
  
  	if (is_udplite)  				 /*     UDP-Lite      */
 diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
-index 52dfbb2ff1a80..0cef8ae5d1ea1 100644
+index 52dfbb2ff1a8..0cef8ae5d1ea 100644
 --- a/net/ipv6/udp.c
 +++ b/net/ipv6/udp.c
 @@ -1266,8 +1266,10 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
@@ -56,3 +56,4 @@
  	}
  
  	if (is_udplite)
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-6.11.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-6.6.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-6.1.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-5.15.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-5.10.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-5.4.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-4.19.y       |  Failed (branch not found)  |  N/A       |

