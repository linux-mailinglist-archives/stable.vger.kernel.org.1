Return-Path: <stable+bounces-106110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F29FC751
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87061882C2C
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2585EACD;
	Thu, 26 Dec 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQmlnAuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1F4C9F
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176102; cv=none; b=a5pSndSv2MznBlzTiK87TS+Bkxa9N/a348UrbPJRtJAESmttJwdL6gKPPGvFOadkpqX/8Rs/RrH02J5/DAESmHbtTV46bB+Igs1ngp/FOIwz38uAZ7dnFCfghJ2FhX2o8ConxOymBw466qoPbbJ4pCAjGM80Qtr25b6ISLFJcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176102; c=relaxed/simple;
	bh=AAEcAHJ/VsYidcMzuM3kFp7sDEXtBBMNUodPfBAUgbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+AnD5NLN5zAY2F3DyjUWpRE7ozq5rQi+0/D2J9TSKwVlCOxSA7icxCqCmglkhVaUqALd6swnHI0lGT4Xuu6ByshB/KOVkMsnWm0kW7K2YVjr1SuSRxND8ANLvHZ49MzYQFQzwO9pKYFrUsATbg7pQbzgccIyQqm55vdb/oWX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQmlnAuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE6C4CECD;
	Thu, 26 Dec 2024 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176101;
	bh=AAEcAHJ/VsYidcMzuM3kFp7sDEXtBBMNUodPfBAUgbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQmlnAuLLaqGpVE9MVDSDFg722FEbBZAA/Zk/gGPr6QIipcU+zxdXzeOXCEprYjlS
	 nNedYoBP60r/aWLDwAUM5KXKHWOrFO4KC4v5TNp8gkL8SkyxFFloDVg7X005NU2KDS
	 fmvoU9iIOOTBGDSYeHTytDCFnooqo9kB6R/byLaTxoRAXYjiBN3XCOm9Emi2BFauIJ
	 1Azod0OFvNdkmeIHShfQpatO3XjceRhyFrmEPvgbHi0jJh4klaoPLaSuoxt+biGofw
	 CDus4GXr2ClQWKxaahYaNxeNX8ICit/BA/sqm5iHoV1q+GcyTGA22PsjCQWsAAvprY
	 oY1LoVCJ/8D8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 5.10.y 2/4] ipv6: use skb_expand_head in ip6_finish_output2
Date: Wed, 25 Dec 2024 20:21:40 -0500
Message-Id: <20241225193455-37628cf3c4ad7f68@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241225051624.127745-3-harshvardhan.j.jha@oracle.com>
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

The upstream commit SHA1 provided is correct: e415ed3a4b8b246ee5e9d109ff5153efcf96b9f2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Commit author: Vasily Averin <vvs@virtuozzo.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e415ed3a4b8b ! 1:  5d647c73654a ipv6: use skb_expand_head in ip6_finish_output2
    @@ Metadata
      ## Commit message ##
         ipv6: use skb_expand_head in ip6_finish_output2
     
    +    [ Upstream commit e415ed3a4b8b246ee5e9d109ff5153efcf96b9f2 ]
    +
         Unlike skb_realloc_headroom, new helper skb_expand_head does not allocate
         a new skb if possible.
     
    @@ Commit message
     
         Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    (cherry picked from commit e415ed3a4b8b246ee5e9d109ff5153efcf96b9f2)
    +    Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
     
      ## net/ipv6/ip6_output.c ##
     @@ net/ipv6/ip6_output.c: static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

