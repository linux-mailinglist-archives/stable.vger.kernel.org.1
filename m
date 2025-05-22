Return-Path: <stable+bounces-145963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F1AC020B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE57A7A713B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C062B9B7;
	Thu, 22 May 2025 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOtoj6rg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087601758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879474; cv=none; b=LBTI21UDVSSvmKBm848kOVeMb6KzKT8839MjlwiC9csBC/0nM2JUO+uvmxK/xGhZ9JmH0SfgsY7bZFaOsENLGNnD8dpKk7Zz7V9v6fWAc0SGrAT8T/dsv5qS/WWVxO5d5lkUZ+ET6HsyYdfd2v1gRLUx5LmrG7/Sau8S7lOgfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879474; c=relaxed/simple;
	bh=gOQ6yznFDahh86L1LmFuyN27Q8bxaZ+EDHEz32x8++k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxnng7wBtyqN1maFTaqZ0UNo5gFun6W0qI96c0sfIDrrrhxlbuM7g6Qq7QbAsawHqXEoOygJMuuNdKOTZzoPlxPDU5C5K3hm6iLhnOnIw0AJcJQzoVJsno4+zfjpVLx6YY6G4lmrGb0kT9LzI6YiDg3STs29eQhSO3tISRsVHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOtoj6rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B04C4CEE4;
	Thu, 22 May 2025 02:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879473;
	bh=gOQ6yznFDahh86L1LmFuyN27Q8bxaZ+EDHEz32x8++k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOtoj6rgUwRceAISC+0AeDjBCIzWEmzbCa8oGNqQANKUbaiBnEXhcjHzkkPRzkMMz
	 T/mvddRi7lfJlP5xbNIbTNetFSTq59tqumc0c0q5skBBXI1c7QdBFLJIsxansPOo/d
	 sAgBqpkKVFNCqBg0/HdUb/XrrJvlg2vsvScJCdkgSvpoW+lWwrtScUHdAacOXIuuuN
	 rOeuCprnWtrQbdUzRkysXs/J23KwQc2GL+dOXnQ/m/ezbK5x9q8kyLZfx4pH+Eup9j
	 LjBAMtelEg1sX+LMkaUPPfMg8KaILT4PllblsrblKR3SUvje+npQCWAmU3fBvvYTWN
	 bEDqpupTdspcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 13/27] af_unix: Detect Strongly Connected Components.
Date: Wed, 21 May 2025 22:04:29 -0400
Message-Id: <20250521204252-0e0c4235f78e66fa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-14-lee@kernel.org>
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
ℹ️ This is part 13/27 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 3484f063172dd88776b062046d721d7c2ae1af7c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Found fixes commits:
927fa5b3e4f5 af_unix: Fix uninit-value in __unix_walk_scc()

Note: The patch differs from the upstream commit:
---
1:  3484f063172dd ! 1:  3c8c9bc58de2c af_unix: Detect Strongly Connected Components.
    @@ Metadata
      ## Commit message ##
         af_unix: Detect Strongly Connected Components.
     
    +    [ Upstream commit 3484f063172dd88776b062046d721d7c2ae1af7c ]
    +
         In the new GC, we use a simple graph algorithm, Tarjan's Strongly
         Connected Components (SCC) algorithm, to find cyclic references.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-7-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 3484f063172dd88776b062046d721d7c2ae1af7c)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: void wait_for_unix_gc(struct scm_fp_list *fpl);
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

