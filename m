Return-Path: <stable+bounces-154769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9EAE016D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067D01BC00E3
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F08265614;
	Thu, 19 Jun 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJK4NmIP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6D25DAF7
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323851; cv=none; b=aUmFi8J6obziLzZLc9PHfW/b/I7nOJP0YBtmTrwn7umaqzSgqO3mxvIu8mOtnm1ptUoA3lqtrbmF8RVwcmJUV1EGpyuJxRcKcs2OmufGnUHOr2Pmhei5jupW0u1HFNDNkm+JCiXeNroQQYcU53DxComZ4GZsPpeQHt3i0mb3IkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323851; c=relaxed/simple;
	bh=8mcXfmOJxK0VS2BhpPz6Ku/zA2rnbQYYDkwsNLDa53I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5OXpElfOOnC7ae1+88P9+Lnf0lwGm8XC1X230ZfESwzW/qRLBMr3772cnE4PD+2clWZDTLCbYOR4unYpOI5OTYZVvcfWhfTVCm+qY09hOdKiTx0iVR0OQp5untYmY8db3svcMZzWeHfdAq+Da4CX8lkOP0+AvNV5lKhaYOgxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJK4NmIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77474C4CEEA;
	Thu, 19 Jun 2025 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323850;
	bh=8mcXfmOJxK0VS2BhpPz6Ku/zA2rnbQYYDkwsNLDa53I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJK4NmIPjJ/IU3KDPgiljX8VpPiXDaL5dfrJP6P2PKu6xVxO6e/TO5xSUk/1c6eHo
	 yAnNTlG5JuRPjxlN+9iWTh5YP7p11mGv3LhiUtl/BcyVuzZjGLLbsxu/KKAj7UB18E
	 puyMi0jhX6BrEMkrfulMcmBxn9Cya7OcdpLQG+fWC+XhwKXlbc09bsN4kZKY+KnpDu
	 SCq5poVJy/hyNoBQb/piorzI9u8w41nEiri3nfUZYGQi25GhxmQNhryjjoNsPVLWsg
	 Yq39g0PNfXH912j6M7OBx1g/vrEKy8oteeL0x1C6r3FLYCNqugvUWU+OnR20TkNp4v
	 gpHeRUvbDjsMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10,5.15 1/2] net: Fix checksum update for ILA adj-transport
Date: Thu, 19 Jun 2025 05:04:09 -0400
Message-Id: <20250618131323-5e8ae3a33ddd577d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <0bd9e0321544730642e1b068dd70178d5a3f8804.1750171422.git.paul.chaignon@gmail.com>
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

The upstream commit SHA1 provided is correct: 6043b794c7668c19dabc4a93c75b924a19474d59

Status in newer kernel trees:
6.15.y | Present (different SHA1: ce211a9d9fc1)
6.12.y | Present (different SHA1: 0de96086526a)
6.6.y | Present (different SHA1: 5dd8c050f1bc)
6.1.y | Present (different SHA1: 9dc3a16a1abb)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6043b794c7668 ! 1:  7f3475830b70a net: Fix checksum update for ILA adj-transport
    @@ Metadata
      ## Commit message ##
         net: Fix checksum update for ILA adj-transport
     
    +    [ Upstream commit 6043b794c7668c19dabc4a93c75b924a19474d59 ]
    +    [ Note: Fixed conflict due to unrelated change in
    +      inet_proto_csum_replace_by_diff. ]
    +
         During ILA address translations, the L4 checksums can be handled in
         different ways. One of them, adj-transport, consist in parsing the
         transport layer and updating any found checksum. This logic relies on
    @@ Commit message
         Acked-by: Daniel Borkmann <daniel@iogearbox.net>
         Link: https://patch.msgid.link/b5539869e3550d46068504feb02d37653d939c0b.1748509484.git.paul.chaignon@gmail.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
     
      ## include/net/checksum.h ##
     @@ include/net/checksum.h: void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
    @@ net/core/utils.c: void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *s
     +				     __wsum diff, bool pseudohdr, bool ipv6)
      {
      	if (skb->ip_summed != CHECKSUM_PARTIAL) {
    - 		csum_replace_by_diff(sum, diff);
    + 		*sum = csum_fold(csum_add(diff, ~csum_unfold(*sum)));
     -		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
     +		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr && !ipv6)
    - 			skb->csum = ~csum_sub(diff, skb->csum);
    + 			skb->csum = ~csum_add(diff, ~skb->csum);
      	} else if (pseudohdr) {
      		*sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

