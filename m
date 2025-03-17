Return-Path: <stable+bounces-124718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A5EA6590D
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEE81885D76
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE720ADF8;
	Mon, 17 Mar 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWYeuhU9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF81E1E18
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229623; cv=none; b=BnWTgT7FE/6VmbVQY27KMr/qWUrUTUQ19kWNwNRYbrQheg/e9bmgITCKEkbGNcVgLZJ0C0yqKHIUlcU8RzXG+chenaecQPi5Ai4UPFT2MCoxCH67gNffxSSR3Rk8BEku+sGUTTIRCBOB9UUoGKV+RL0im/o3EZ4hFKRYqImHRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229623; c=relaxed/simple;
	bh=+i9eQ2aT04zOjQNdP1dbiCkLsdxAIwmCVoNJZYIa+JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBTGlrsfO033QWeFvQsYLpLnInJn0k0sfFqJ1baNHBS1htVimv/6gGFmPQkCko2wHRa0m94tcrK1eqvC9YbeAFlvfzgFlg3AATOoV4iR/F/ml521Yf0WP50ak3MytpGhSI+ehQuUO/f8aaCV/tZ6X9Itw0GXvWvvngb2R8H2s0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWYeuhU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F4CC4CEED;
	Mon, 17 Mar 2025 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229623;
	bh=+i9eQ2aT04zOjQNdP1dbiCkLsdxAIwmCVoNJZYIa+JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWYeuhU9tU9tjibLkhSLONyE2gPgJtgPbSYeJRC+MAlhs5aGHNzkB0+JKT4eW+0y3
	 V30nvUom/rb16tkdA5/p+8rGg/EP344oILq8S9bwTlRUIDV0TXl2LNmfA2gjgKE0Hz
	 fojl+LWswPlQ2m4FWqmO2zLXZq31E+phW0MJ84pu6gfqlswCD2An1AlP/K4HjRxUBt
	 rey2DfDUqAXeFFxUQdX16jGC6WYAsuTGP+hGi+oKf/5/pJ6DKYcRDRPDfI7qUyzjw/
	 yCauksa8s6MmKtJW0E2Am8SIQlua6526VDsC/5mNkPQxVOg5SQxhwV/F2M0BLh6cSh
	 p4E+WkChzqbkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	songmuchun@bytedance.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
Date: Mon, 17 Mar 2025 12:40:21 -0400
Message-Id: <20250317094838-6b3bf9961f9e91a4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317032934.6093-1-songmuchun@bytedance.com>
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

Found matching upstream commit: 6bda857bcbb86fb9d0e54fbef93a093d51172acc

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 2094bd1b5225)
6.6.y | Present (different SHA1: 679b1874eba7)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6bda857bcbb86 < -:  ------------- block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
-:  ------------- > 1:  211b2b8efdf06 block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

