Return-Path: <stable+bounces-145981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5955CAC0221
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166A74A76C1
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A172D7BF;
	Thu, 22 May 2025 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz6tlqCU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9118E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879548; cv=none; b=gZ7XclIs7l4ArGpNoaKjSEVXNrmLLwhXL2P5QcUdzffPESlzmvbiGT9/qbAOTCUWkEQSfKj9CZ9Tzsg8phwoBgzsm2ePesQaOH9hC6m9zeOV60RKwpVKmOT3smnzBr5AEusdPiR2GCK4ecDIkyQ17N5eSgSXOPt55nKxvAkoMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879548; c=relaxed/simple;
	bh=OIxdjh+Ndbqm/4iXg5sDYaMV1iF7Vp33LVEz6yfYCB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGkJmTeGrcwlAxjlHPtgad99bZ7wLE9V20yj3rJ1kmxZ+ajHLJHogMNDPqA2ZinPvEEVOsqCq5Mxd23rerrheY7lzMSqU4NC6zWm63rryBYPgwC4NwUBCKY3KJESYTEqkYvf1gIG+WdmhT3Qb+aAJPLA5RAHzvMR7QWZBTgtq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz6tlqCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1692EC4CEE4;
	Thu, 22 May 2025 02:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879548;
	bh=OIxdjh+Ndbqm/4iXg5sDYaMV1iF7Vp33LVEz6yfYCB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pz6tlqCUBoq1ditIYZH9jCnz6TWIfk1Hhl94FH0Iind5Gt9GsfzSPRzjAmwfOUBf0
	 iq+MtdG8X6GD6uUBU+SKONPwVAGxe8/gZtvH4CxH4X5xuN2QOGiEVKG67ApR+vW7IM
	 0SvJ8E2R8SweUg5QRZ6oXiyrtdCVqgY6+6WJfec1FYlQWsLNLYPmAOEtlN9DPN4rMU
	 Xl8tfGyc/3lHR+lNpuXFd4sCWQTnCFzRWUxya+H0BVVl3A39AtIC50hKsALfNKCvhB
	 kMMU03/Yp3oMm+TcPhAclxq4ct1VaYWdgwCdDxXK3ApeOYxTad+o4TM5O91nTROHkx
	 EJNG3B2OwzwCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 17/27] af_unix: Skip GC if no cycle exists.
Date: Wed, 21 May 2025 22:05:44 -0400
Message-Id: <20250521210107-2d324fd0ef75c709@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-18-lee@kernel.org>
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

Summary of potential issues:
ℹ️ This is part 17/27 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 77e5593aebba823bcbcf2c4b58b07efcd63933b8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Found fixes commits:
1af2dface5d2 af_unix: Don't access successor in unix_del_edges() during GC.

Note: The patch differs from the upstream commit:
---
1:  77e5593aebba8 ! 1:  15f6ca2c3df2b af_unix: Skip GC if no cycle exists.
    @@ Metadata
      ## Commit message ##
         af_unix: Skip GC if no cycle exists.
     
    +    [ Upstream commit 77e5593aebba823bcbcf2c4b58b07efcd63933b8 ]
    +
         We do not need to run GC if there is no possible cyclic reference.
         We use unix_graph_maybe_cyclic to decide if we should run GC.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-11-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 77e5593aebba823bcbcf2c4b58b07efcd63933b8)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

