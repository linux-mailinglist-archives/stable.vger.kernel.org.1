Return-Path: <stable+bounces-135273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609FA9897B
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37CC7AECBF
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E411E7C06;
	Wed, 23 Apr 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdGTtTCt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7D33062
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410621; cv=none; b=uf9ThpzGE8L/1v7NL1Seuuu9j3u2FmC3pVl1RkkF5IwoVE5p/YRMWNUjpVOC7gSv1WJSN3K7g3l3HrnGsCSPXSJqHoqymYQPPUUNZDDyoAb8Cfu1tekZLMVYn4swZ5YdkkLh+6WMF0a41ZGzGBmAYDBJPchTRG86D1jgZyDE0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410621; c=relaxed/simple;
	bh=vFpvZdP9PTSd9r8H+dzUfqKzd6WHgxRxNS/dR9X7tN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctAEORIJxJ70VMNeB9iHZREud029rplyEbZ2KrAPxW1GQOP65kX+6l93MRVvbSlsONiRcl0U+Oe/+c6m3IUfiqIhaAVOExOBsOiRlzH9iVi2gznhOr4rOwIm8iuXZQGrXIu6PEsY2mjpQ37bLxf7j/LfCW3DV5K1w073eTJcjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdGTtTCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0118C4CEE2;
	Wed, 23 Apr 2025 12:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410621;
	bh=vFpvZdP9PTSd9r8H+dzUfqKzd6WHgxRxNS/dR9X7tN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdGTtTCtkCuX+6ueAwb1VtvNY3KSy5HzrymZJ+oLCjC88V2qKv6/apXzKC2WuL62q
	 r60J5ML2BiGt2ULMUAMoU/cJDE9QXgnY9VzdLF9hsx29gfwq1zrYnzIpKBwruS/Snl
	 NNkDavCa7Z/7x8yWBOcqFsMdTs9tctivhMXwcQVlVAzHDFaK0YdRTWhinTrJMWDxQ4
	 ths7nITtGEHqOBk21J9J29ZH8nOcUe2Pj4dqoA4mI/4DIkPupPhyEZQu41hPTcwXVG
	 rk77UHnGFfLbPrIHPPfVxhBt8q8M6LRxGAmMCPvnO+o1mA4Fm8brSFOGqgP5/w+Cpf
	 C8pp+1t50q/OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 8/8] selftests/bpf: extend changes_pkt_data with cases w/o subprograms
Date: Wed, 23 Apr 2025 08:16:59 -0400
Message-Id: <20250423081248-ee346ada69260f4a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-9-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 04789af756a4a43e72986185f66f148e65b32fed

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  04789af756a4a ! 1:  0196ebe171f2c selftests/bpf: extend changes_pkt_data with cases w/o subprograms
    @@ Metadata
      ## Commit message ##
         selftests/bpf: extend changes_pkt_data with cases w/o subprograms
     
    +    commit 04789af756a4a43e72986185f66f148e65b32fed upstream.
    +
         Extend changes_pkt_data tests with test cases freplacing the main
         program that does not have subprograms. Try four combinations when
         both main program and replacement do and do not change packet data.
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241212070711.427443-2-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c ##
     @@ tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c: static void print_verifier_log(const char *log)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

