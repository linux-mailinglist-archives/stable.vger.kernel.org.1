Return-Path: <stable+bounces-106117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AAA9FC755
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11273161EF6
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6494409;
	Thu, 26 Dec 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4oNlYyQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C308EC5
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176116; cv=none; b=nwA/wxQvcIIMGMQictv5JR5s3m+mxUbZwjQB2e4B15ZXiKj+J0v5W+iaUZUQkNmKX8Yked0GDyrvo3M1cIBsDnVu0pEJQMoCLNfNiog7JJZ4RSPvP5oTFkFGJ78nI0nvKZR4bBB4tqikt9aTW6usNRj6HpQpA1Vgrdf7mTYfhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176116; c=relaxed/simple;
	bh=m9Te+Ep69/912BLz4HLILhOb4kQ4Jpe0aZmvEdThBNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmPQllaBHAOY3JmAFR0DD1GJHw9aXAgyiICu4rvN4Q8IM1MmSopTiCC07joqSKKlHbIRGyo6QVyB8Xz2yT9U80DDAnK5s4sSd4mf8pQf5l89iXKu78KRV9vF2kpk/sim/18L8p/ef1L7MOKQJ7msUexYCpBRJjcupdgbi55QDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4oNlYyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1E2C4CECD;
	Thu, 26 Dec 2024 01:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176116;
	bh=m9Te+Ep69/912BLz4HLILhOb4kQ4Jpe0aZmvEdThBNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4oNlYyQlCdr/9X+SZ23OmGO8q4EO1nFP7GfZtzltMrEZPSPOeEnvPpBiuNWjWkuV
	 Dd9G+2CbDq/izbJskikateW1h0LP6wjPm3Nx3T+MZgO0sFHU6EYj15TqFnMEDeoOs8
	 xE7+0CV+FanlwCFO+R70PSJ4PWYqOp+wbLKidvFA9TtcPPMgfyXbzWWc6Xy1vhH24D
	 VxAM0wfR0cRRr/kX7f5RK6TTTrb4OkpgJi7wKYBtrxqQWgHIIpDCKWKsIns9kgPFpo
	 KBF0hcsjoG37YBMseXy1OsTYtM+DAFEUhZGDMaQnAB5vjzCukmbOjXAYXkTf1qSf9k
	 cefRLKmlYTpcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 5.10.y 3/4] ipv6: use skb_expand_head in ip6_xmit
Date: Wed, 25 Dec 2024 20:21:54 -0500
Message-Id: <20241225194059-eb27b923ecc9e8e3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241225051624.127745-4-harshvardhan.j.jha@oracle.com>
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

The upstream commit SHA1 provided is correct: 0c9f227bee11910a49e1d159abe102d06e3745d5

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
1:  0c9f227bee11 ! 1:  a38cbbbc21d7 ipv6: use skb_expand_head in ip6_xmit
    @@ Metadata
      ## Commit message ##
         ipv6: use skb_expand_head in ip6_xmit
     
    +    [ Upstream commit 0c9f227bee11910a49e1d159abe102d06e3745d5 ]
    +
         Unlike skb_realloc_headroom, new helper skb_expand_head
         does not allocate a new skb if possible.
     
    @@ Commit message
     
         Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    (cherry picked from commit 0c9f227bee11910a49e1d159abe102d06e3745d5)
    +    Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
     
      ## net/ipv6/ip6_output.c ##
     @@ net/ipv6/ip6_output.c: int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

