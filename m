Return-Path: <stable+bounces-124902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8DAA68A0A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC103BF923
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A68253B71;
	Wed, 19 Mar 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTh7OXDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C8251796
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381659; cv=none; b=OLX1aTJEiNYOApdqWWxKNsQfotX+C2j2LO9kWEBhQGbHqpCDuqu0wIKXRVHs4gnZdg5hhK8xOcpelxBxjf0xjqQbqZj/s0YUlWXs3iYg/c6QGelyPUeNXN6Rkcne+27Au3IJHaHCboPwtByAd2gtpN1KINqnXk6ciJ6VNirRL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381659; c=relaxed/simple;
	bh=CeOCFUXugif8zVZpcm0LBs39CNwLvLeiFzmgAiCibF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWX1Q1bzvyyxi+v7RXsMXoaBZqjRwa+78ZD4aGFh8CpQOduprZCsE4B3zSs2uiIPSUcA05giVX01HEY4HP0GCCEuwt0i28QrUQAjeLe1VL+5YvhDGZgaDDh03wwHdQxNgglt8uexY4iCfa2KBQNqvisHL/wAYrHtIsjcNt/BwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTh7OXDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE90C4CEE9;
	Wed, 19 Mar 2025 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381656;
	bh=CeOCFUXugif8zVZpcm0LBs39CNwLvLeiFzmgAiCibF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTh7OXDXLzhocBvhhiY/32gQ69OV1u1ne/32N+C51YD52wjG0Nfmu5e5UH/5Q0yYB
	 LrSBDdXMK8NvD5sSco0M7fsZn9GzJ9NI1GDUqdIKzKH+PFOrlZsvE6X9yG3f1S/p7t
	 3OH/NUp0bDZqf71fYy9gpTRkltVnBr1mSmC3nzXYDLJkOMNHoUiA/74Dsitro2+Q6S
	 0cu0Jxjsr9sbD3v3zXfUbM7dddCK7MyfGFsnb9XMUcn+Cp6TffG4RpkByDhjhpd0xe
	 +vUr9+5Yg1s3jwJU3BlIFbAkV8C9DvesNKo0YvLH682ocwCDfGWEciDT6HLuqaMjx/
	 KjShlRDsdnZnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,6.6 v2 1/2] netfilter: nf_tables: bail out if stateful expression provides no .clone
Date: Wed, 19 Mar 2025 06:54:14 -0400
Message-Id: <20250319055305-bc6e87b8ae7280b1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318221522.225942-2-pablo@netfilter.org>
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

The upstream commit SHA1 provided is correct: 3c13725f43dcf43ad8a9bcd6a9f12add19a8f93e

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  3c13725f43dcf ! 1:  297e4b7613a98 netfilter: nf_tables: bail out if stateful expression provides no .clone
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: bail out if stateful expression provides no .clone
     
    +    commit 3c13725f43dcf43ad8a9bcd6a9f12add19a8f93e upstream.
    +
         All existing NFT_EXPR_STATEFUL provide a .clone interface, remove
         fallback to copy content of stateful expression since this is never
         exercised and bail out if .clone interface is not defined.
     
    +    Stable-dep-of: fa23e0d4b756 ("netfilter: nf_tables: allow clone callbacks to sleep")
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
     
      ## net/netfilter/nf_tables_api.c ##
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| Current branch            |  Success    |  Success   |

