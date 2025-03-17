Return-Path: <stable+bounces-124633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F4A64EAC
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9128F16C744
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D02B23957E;
	Mon, 17 Mar 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8FE1C4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F9214A8F
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214251; cv=none; b=hBLje/JNVi6pHv0wzrGtN7hCI7KSBgWHDKAvBL3ObaukFceZy2lhS27tFkYE1JFPjBjOZ/WeVFKFr4jjXpoy5d4KSCWaBZ4yhvQtfcPdkkEPglneERY83QLflE+Z5yz1IgrDf2SsIgPXdilao6iR003X4UTFDohscTM5OHoOiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214251; c=relaxed/simple;
	bh=NkiAShyMluET0a4t1gWr9GAuB8qHH93g4nqr3MSFe+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdZuDz6LzcdsILHQFP/wgxicwO5Jnl69+6VidCw7reS2j4dJfh94/O50TNpHYaXo4d/KJHGhvcLrSiih4/XWsH+LCE1wpj30L1X6lwqxpXMV5yi1oMvWtX7tQOEre7W0VZdUv0s4hNJSHLM+364tWeTwfwbt+rxBpI2PVJNL3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8FE1C4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C3CC4CEE9;
	Mon, 17 Mar 2025 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214250;
	bh=NkiAShyMluET0a4t1gWr9GAuB8qHH93g4nqr3MSFe+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8FE1C4rGFdjht6N31WkXWio7xUsLXfqCIjUN0SKB4luMfitT/JwcNadMuystlEJL
	 mHNkGIN1E9Fdv0X1R3DXJV4t0LZKNRjbHtTmVJPwwqY0w4TzGFoQsH0sThv0ukS2Jv
	 /nndP4H2ndexvJ0lRm3dJCwolki3NsMGMX8SOygDvy0Z6fJSIwk/SzqXTqyvoJvhcT
	 +9Ui71I9vAdVhGSmHOafGJ881xLVtEWJE+41PnTXd5CoK7o70jq2keROqyt6kiG95J
	 m2kLNZGZPwvGYknKT0qyQX8h/DE4CI5KEb/RNZbW+OaootVcPlLLm3fLAM3PcMnXqL
	 +4C8spZORht9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] rust: Disallow BTF generation with Rust + LTO
Date: Mon, 17 Mar 2025 08:24:09 -0400
Message-Id: <20250316143924-a1d97475965fdcfe@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250316153825.2402903-1-ojeda@kernel.org>
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

The upstream commit SHA1 provided is correct: 5daa0c35a1f0e7a6c3b8ba9cb721e7d1ace6e619

WARNING: Author mismatch between patch and upstream commit:
Backport author: Miguel Ojeda<ojeda@kernel.org>
Commit author: Matthew Maurer<mmaurer@google.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: d0ae348de14f)
6.12.y | Present (different SHA1: 9565f4e43f2f)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5daa0c35a1f0e < -:  ------------- rust: Disallow BTF generation with Rust + LTO
-:  ------------- > 1:  389af4a62159c rust: Disallow BTF generation with Rust + LTO
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

