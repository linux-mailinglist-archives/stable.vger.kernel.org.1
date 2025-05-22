Return-Path: <stable+bounces-145998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14BAC0237
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699AF4E00A1
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26C2B9B7;
	Thu, 22 May 2025 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbqwUgXj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04366FBF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879655; cv=none; b=CRNGUjandjVB6VOg5drLKOWXdNu4MIkctx2Xi9Sbe2QEmsPXrptHfFcZOwRdPje5bIaO4mYfpeSV5SqArUqVIxR+xsLiJmy/3EWSwhiLb4gGeRXxdSCNy7vc9jZXk3IjcwTyhK672LviuxUlNW79qlFyAF7mEfIhAbYJcKkLV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879655; c=relaxed/simple;
	bh=0ZI2dlrF9iZxGxjxn4RRSilb4V9nJ8h2i6sXiWvdLX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwfpRC648BlBezs2HSNsAzrqxwrr47LKbRte3jOkO70xi4tCof9IaJubGMlJvGExt/ShkI0wtbDrzXPMNxqAcx+Tbojayw4FQBw9eoWouKTgtH7nx+YwjK7JL5aeP+ldo+6/0UcvG5fpZQJuv/48g/lh1JvlQjn17lveRR7ctQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbqwUgXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6641AC4CEE4;
	Thu, 22 May 2025 02:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879654;
	bh=0ZI2dlrF9iZxGxjxn4RRSilb4V9nJ8h2i6sXiWvdLX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbqwUgXjzDTRJCDxVs8MzsXexOK6jNJji5H+gm05un7/hvWp95g36BOPu4/pLfPzV
	 iAfG8exgthRLKVRlZSaa1yuWpMvWZJFSg3DOzQJ3rUnEd2/nku4xkKb359oRSSgXg/
	 xDc+N6Vk0JlqY62ZarQGiF5VobBvA4Ocr3SNAY1gLpB9QVD5k4WJLelVCKj8c00n16
	 +kTfAtwzPjLrvt2vlbJRwUcG5P+CsAY9b4wf7b6Js4pYJZg+Rzx/06EG3LtgVBPKTn
	 yUaVs9THeU+tjNabRAfO2j2tU4IBXteMOhMXCd6Rtrge9hfKBZ7H5Fsb2boxUdLHMN
	 ImyMUJvxEbxQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 18/26] af_unix: Assign a unique index to SCC.
Date: Wed, 21 May 2025 22:07:30 -0400
Message-Id: <20250521180833-4ab23d902a5351ac@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-19-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: bfdb01283ee8f2f3089656c3ff8f62bb072dabb2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  bfdb01283ee8f ! 1:  eea9db6abacdf af_unix: Assign a unique index to SCC.
    @@ Metadata
      ## Commit message ##
         af_unix: Assign a unique index to SCC.
     
    +    [ Upstream commit bfdb01283ee8f2f3089656c3ff8f62bb072dabb2 ]
    +
         The definition of the lowlink in Tarjan's algorithm is the
         smallest index of a vertex that is reachable with at most one
         back-edge in SCC.  This is not useful for a cross-edge.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-13-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit bfdb01283ee8f2f3089656c3ff8f62bb072dabb2)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_vertex {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

