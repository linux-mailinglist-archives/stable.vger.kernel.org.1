Return-Path: <stable+bounces-145964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBAAC020F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5884E7A5E31
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676412DD95;
	Thu, 22 May 2025 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+L/XL8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CC3F9FB
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879478; cv=none; b=ly3VxSESFXb2H3MJPLo4D/3oiJm/xRF2wIMhcZyZHy65Fag1hQMTRaZVYYNqGRXJbxyp1E4iOwov8iDK3s9hDerWTHEi1YL621LueIsgsUF/wI/2yedoOnHVh8ToaLf6jzCW6syWiZjwGCI7hD4Pd8dIBvfmurH3reNbJiyBKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879478; c=relaxed/simple;
	bh=zC+T6CT1xM1JPlhF5iTFHOZlqRqFQXfYlE8duBbbuIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t11F5lVW9RTlnCdw2vjoW52nLsWLEPD0rPwNt+kDD5nU+PrA/Ps7vNp5Q+f4atiBbnTYJdFxK856r/j46/7ZhFoG1lkX7/D/N3452BMJ8LcwI0Ka7Fb0Mqs3IzDFhOIqrg/WuLsDecZSX6Ll25g5KC9a8dVly+XuTJht48CKwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+L/XL8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75C5C4CEE4;
	Thu, 22 May 2025 02:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879478;
	bh=zC+T6CT1xM1JPlhF5iTFHOZlqRqFQXfYlE8duBbbuIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+L/XL8w7U+/l/bbyyS8Msr/cJVDkItNVfA7wdtN8YpcOF11w57OHZJn2N2giR1Us
	 OWwVhOrbGpSoxRtyGx8v7L5uwChTskP0zdmwts12v2mtSkT01WI/u2Ben3vOX+NdDx
	 HyizmAI+fj26LbW2HWEefxlftqBoBV06ByoWncLURSJ5rGxRJ3WKx5uheTQF5pQJe1
	 1xmVmPMzwfwduCYfloaNAAXph71s1u9gPXCYti8zjCHNZyVgkU/qmEuv1jOIrUWL7P
	 aQukivjVBbXSZz97WRyAeHuiQxuTzaGRzLCbNdY5Uwmx7qf7V9TnFZB40cJshkDw8R
	 +2dwc4g9+lQNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 17/26] af_unix: Avoid Tarjan's algorithm if unnecessary.
Date: Wed, 21 May 2025 22:04:34 -0400
Message-Id: <20250521180404-ff1b22b7ff07b92f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-18-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: ad081928a8b0f57f269df999a28087fce6f2b6ce

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ad081928a8b0f ! 1:  2e226e9098825 af_unix: Avoid Tarjan's algorithm if unnecessary.
    @@ Metadata
      ## Commit message ##
         af_unix: Avoid Tarjan's algorithm if unnecessary.
     
    +    [ Upstream commit ad081928a8b0f57f269df999a28087fce6f2b6ce ]
    +
         Once a cyclic reference is formed, we need to run GC to check if
         there is dead SCC.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-12-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit ad081928a8b0f57f269df999a28087fce6f2b6ce)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

