Return-Path: <stable+bounces-145966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CCAC0211
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5234F9E52E3
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF313F9FB;
	Thu, 22 May 2025 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHJHm48/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7A1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879487; cv=none; b=s8IEHcPyynQywid+5euAS0Q2Ul5+7TNDxncmuBXPvJwas8m3bZ+ULFPlodkDr95ySGsNlCgp859VHX++IG0FFVejUfpRZjO9Q5vhVn1h8W1llSkURZqItAM+a26iuIthwicWfUZe2QmyQhBRlklKHoiJ6cqXlb59Z3kIfPx1cig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879487; c=relaxed/simple;
	bh=SmWUuClSv6l92aabDHTIILhwoON8LpqzMjmbZr41/MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+iQHvfqLXj8obX73DZjoSl8SBIaddc3gflALLqO5WXGoWJo0QHztFJtBH8vB37sYo8nGrfKqZ0NtNOkcT0HZibQIMi1UK1CM43JmjSn/zIKLxClUqoNsyNWWK8pEq/w71WODVD6BEZYYd8k9lKY5ei1SFahnBabYgFPC3nYxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHJHm48/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBBBC4CEE4;
	Thu, 22 May 2025 02:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879487;
	bh=SmWUuClSv6l92aabDHTIILhwoON8LpqzMjmbZr41/MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHJHm48/KYf0+zoZvRLpsgek37HDnmtzrReORJDF02mACq2XU7WPnditiSpAs9L0P
	 qFlsZcq17jAhgpIJVCDoBqFgeFWakK021lXEjZ8AlJDrinvBlRDk/bBvA7440Wogu6
	 WZFhohztL11gCyvVi8eNWTc1C6QqXKZVE4JeQj4UlbfSM9jYg5nSHV3mpSP5BQyLcM
	 clRuNpe2VXip3fgIIEOloCtGof9h8jFWFwF9VdXs7xvQrmcayn4fWh90ZRrGwfTeXU
	 LxenFeuH5gih2WoxeY66mHIBLitjU73ov3lcGQJYiiBgMsLslkUzy3fVzgOxEKo9w4
	 gc8Z8TZuvVbcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 15/26] af_unix: Save O(n) setup of Tarjan's algo.
Date: Wed, 21 May 2025 22:04:43 -0400
Message-Id: <20250521175355-480f609a88ccdcac@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-16-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: ba31b4a4e1018f5844c6eb31734976e2184f2f9a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ba31b4a4e1018 ! 1:  f5cf8e02384b4 af_unix: Save O(n) setup of Tarjan's algo.
    @@ Metadata
      ## Commit message ##
         af_unix: Save O(n) setup of Tarjan's algo.
     
    +    [ Upstream commit ba31b4a4e1018f5844c6eb31734976e2184f2f9a ]
    +
         Before starting Tarjan's algorithm, we need to mark all vertices
         as unvisited.  We can save this O(n) setup by reserving two special
         indices (0, 1) and using two variables.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-10-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit ba31b4a4e1018f5844c6eb31734976e2184f2f9a)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_vertex {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

