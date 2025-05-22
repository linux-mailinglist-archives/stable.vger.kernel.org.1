Return-Path: <stable+bounces-145965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15DAC020E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E044A7437
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656E35953;
	Thu, 22 May 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSem4sX3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042671758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879483; cv=none; b=H2TdDWFuN9TrewUBpjwcou1ju72JJ7fUgbC9mnfCCb3w4ANJ/eNDT1pAg8SVrgTf+GlBzkqbRwPYR9tUiJmK3F9Rc69vIZzJpIf+1PHZKs5a4X2lYwwR7LjzFMSdzdp39dkptTdaqE9bopaOC/f2SX0l2YMFRR3EINYhUQSFplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879483; c=relaxed/simple;
	bh=lINvzRY6WFAhKrs0bj4SO3VqkmymozwjVcnvRJObC7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihW8CBtuYu2yymg6eZmu+jx/mkjTVMukU2DUJrxMLw3HyZeQy6alIz9aI5QOR4C6XbPO0xfZTsp+HGNu7T3lGWqjUko3Id+4zHoQ8Umvjq/99K2VOZcqOBvl/hVHQGuqGwxSX3ZiE+ej2xh3E4IXNz41CdC03iG9ZEH5i664dKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSem4sX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C1EC4CEE4;
	Thu, 22 May 2025 02:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879482;
	bh=lINvzRY6WFAhKrs0bj4SO3VqkmymozwjVcnvRJObC7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSem4sX388f3vNA2Q2I6H2cjwTmQNYRL+D7Aj4Z5o/izsJzE8Z4rWYoH8sTXNycP3
	 TvyrL3qozEoUdKCreL9RzNkdAyLe8+IGLariB2DHRLaoD+GW2UQrx7tiLAei+B+5cF
	 QuluOWjxjPzBCu6mRlkYvrEFWJkoKQ4qLke9KDLWV/9oQXhla1W4CUdvwN6KDegCry
	 XoAZUv9nJAD4mDLv86o18RFg2xiwVhsWU/c6OiUySuWNV6lb2U1FFdXojYDNIpYeIN
	 WQbqcofL3P52IfA7p6Tehqv9LMMs6SJdOKfPunVIezWUqacAfJHgPgeFvSnTiI+Qf+
	 Ljne77fD3QFqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 19/27] af_unix: Assign a unique index to SCC.
Date: Wed, 21 May 2025 22:04:38 -0400
Message-Id: <20250521211025-bd4d24081ae41780@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-20-lee@kernel.org>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bfdb01283ee8f ! 1:  a0878968a63fd af_unix: Assign a unique index to SCC.
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
| stable/linux-6.6.y        |  Success    |  Success   |

