Return-Path: <stable+bounces-126588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB7A70772
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBD2188716B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E525D1FA;
	Tue, 25 Mar 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef98kSNh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7FF19EED3
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921807; cv=none; b=oBS4uxkiLBw8L/TFySoTs0xVeV4tTkZtFIEeOIlHxaIqwBNdJMsiQbw1oWMEhzmUh+vMy4sUOlm+jSbiNKbBVFssKlIwJhfmDWUBYbU83/16Q3tCMOnIWVdPuTu2j9L5YH+EVB0iOEUt1serOavEs2/K+ZbHMoDFbdn+0t8o4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921807; c=relaxed/simple;
	bh=NCknYFpe6m97x70w6BRHfXSMOTTkrwc5LAMSkIL870Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OK5ToJ6GQO80cswmenuXfppT5wEukM1iZymltyw5bz72R3nAPcwa6+rLbjFvIsQoeDuerxo7keglBg8sS9hyXMC/EY0ljxphj0lhyryilDpIVJHysMgQROOFZysRZI3tfvNFQEBPYHnhGS2pfbmVKvSwCF3ehtNOgbUjKEAupaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef98kSNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA19AC4CEE4;
	Tue, 25 Mar 2025 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742921806;
	bh=NCknYFpe6m97x70w6BRHfXSMOTTkrwc5LAMSkIL870Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ef98kSNhS5FPxk3IHPOfLuMx60/v6ykQJ3NE4M+Rs0bYrfQJ5W2VQ0prhW7lJoynM
	 SuUJUFIsVK/H+GfD+epgeGX/58/2QCn/MYxlHOoZxAa82h2so1gR9R3rUbSiwEachE
	 W64inrVwnP2RMCMQJxbbnMZhRR5MGCLCKORQwCsLfyekTq6WNKHpwSFw2TUvMdtcOL
	 w6fSRG9Z8kqHW+x/3BybtXvOhm4avCWBfMNb9gWOl/5TNz/0iHZU+CSIK4OBCIB65B
	 UpEGwY131NJNPQCUUQ5IG43a4MfpZRl4xBVwVh1JUhEp8TyiY6oL3KU8nCvFPARvhL
	 Gk+03AIlOervw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/page_alloc: fix memory accept before watermarks gets initialized
Date: Tue, 25 Mar 2025 12:56:44 -0400
Message-Id: <20250325124736-cc99722df0f49555@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325121621.2011574-1-kirill.shutemov@linux.intel.com>
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

Found matching upstream commit: 800f1059c99e2b39899bdc67a7593a7bea6375d8

Status in newer kernel trees:
6.13.y | Present (different SHA1: 18c31f7ee240)
6.12.y | Present (different SHA1: f4bc2f91e6f5)

Note: The patch differs from the upstream commit:
---
1:  800f1059c99e2 ! 1:  48ab092457a25 mm/page_alloc: fix memory accept before watermarks gets initialized
    @@ Commit message
         Cc: Thomas Lendacky <thomas.lendacky@amd.com>
         Cc: <stable@vger.kernel.org>    [6.5+]
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 800f1059c99e2b39899bdc67a7593a7bea6375d8)
    +    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
     
      ## mm/page_alloc.c ##
    -@@ mm/page_alloc.c: static inline bool has_unaccepted_memory(void)
    +@@ mm/page_alloc.c: static bool try_to_accept_memory_one(struct zone *zone)
      
      static bool cond_accept_memory(struct zone *zone, unsigned int order)
      {
    @@ mm/page_alloc.c: static bool cond_accept_memory(struct zone *zone, unsigned int
      	if (list_empty(&zone->unaccepted_pages))
      		return false;
      
    -+	wmark = promo_wmark_pages(zone);
    ++	wmark = high_wmark_pages(zone);
     +
     +	/*
     +	 * Watermarks have not been initialized yet.
    @@ mm/page_alloc.c: static bool cond_accept_memory(struct zone *zone, unsigned int
     +	if (!wmark)
     +		return try_to_accept_memory_one(zone);
     +
    - 	/* How much to accept to get to promo watermark? */
    --	to_accept = promo_wmark_pages(zone) -
    + 	/* How much to accept to get to high watermark? */
    +-	to_accept = high_wmark_pages(zone) -
     +	to_accept = wmark -
      		    (zone_page_state(zone, NR_FREE_PAGES) -
      		    __zone_watermark_unusable_free(zone, order, 0) -
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

