Return-Path: <stable+bounces-126034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE6A6F458
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747201642F3
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1D255E58;
	Tue, 25 Mar 2025 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NamrZRgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6619F111
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902691; cv=none; b=JGPu0S+BsEwNeZaBl2/nQJebO8PowScQN6GmMWiAGDDpxQoi2VIOVUcOfGYqwU+3wKXSNloENZnSH0QaEyQeBof2LRd1nU8Wc/xGy8jbl70y6ML5+g2dQ72zEVpkuSVEUyjzf7eWAvIKRT5R5JoPtG2Cl6A9BpHtXYfJ/fHoY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902691; c=relaxed/simple;
	bh=03dhfMLpbJt1HUVt1aBOj4FzjztkSJGfPJotnosXOso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXMmb0g0/82/sCVcbuJCwt2Zkys9clVA49n12uvX0efumJPbKg8ZN+veTb8Ntjqe1zMzU5AtTzOhsZQM1e5n+6E2UOgdbc1cDOJ+2FzbbDhU2e3NDutxh3NBpSmju1BWuCIwokyuSsv4MEgxkDvjQDp+9TEeM2lqFUse3th3KNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NamrZRgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202DAC4CEE4;
	Tue, 25 Mar 2025 11:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902690;
	bh=03dhfMLpbJt1HUVt1aBOj4FzjztkSJGfPJotnosXOso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NamrZRgQoOQLAwMJJGjehrMqjSEJ67Ta//PCj5cwTVIj1uRJmcNKT6+t6CjVRxWzU
	 m2cu6Vw8rpj3/njq5Ucb+DiC3ZasypOVlcYB9RCDSQdW71MrjKFciBkJrVW+DU91ek
	 LUDVg68/fW7O4XIi0tnOFZVr6R5JVCvdenSR2jS1hjc8jT4gWTD+E1oTJn0/JyDo8Y
	 1WV6dNnLGU2NZs++Pemy9SIAzRP6dhYbEKY05ypxsESgb/JxAmxhxFhpUp2feCtUtN
	 74ZvwVSnLrINm+ZJEajWhZaIS7NDN5esgmwl9S2+ib4z5VDeNddiOtCTGp8ZwK03bK
	 BWpFYggebCxDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ziy@nvidia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/huge_memory: drop beyond-EOF folios with the right number of refs
Date: Tue, 25 Mar 2025 07:38:08 -0400
Message-Id: <20250324211615-37f7b03bf4b2ca3a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324185007.142918-1-ziy@nvidia.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 14efb4793519d73fb2902bb0ece319b886e4b4b9

Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  14efb4793519d ! 1:  8e2adc6066c3d mm/huge_memory: drop beyond-EOF folios with the right number of refs
    @@ Commit message
         Cc: Yu Zhao <yuzhao@google.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 14efb4793519d73fb2902bb0ece319b886e4b4b9)
     
      ## mm/huge_memory.c ##
     @@ mm/huge_memory.c: static void __split_huge_page(struct page *page, struct list_head *list,
    @@ mm/huge_memory.c: static void __split_huge_page(struct page *page, struct list_h
      			__filemap_remove_folio(tail, NULL);
     -			folio_put(tail);
     +			folio_put_refs(tail, folio_nr_pages(tail));
    - 		} else if (!folio_test_anon(folio)) {
    - 			__xa_store(&folio->mapping->i_pages, tail->index,
    - 					tail, 0);
    + 		} else if (!PageAnon(page)) {
    + 			__xa_store(&folio->mapping->i_pages, head[i].index,
    + 					head + i, 0);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

