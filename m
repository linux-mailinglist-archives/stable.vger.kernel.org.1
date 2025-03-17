Return-Path: <stable+bounces-124706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA6FA65906
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C79E3B8DFC
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980820969A;
	Mon, 17 Mar 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdKqrC4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B839209692
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229605; cv=none; b=pSo0MEm4/HMf2soUeD39UGFqlRLHv/peOqI54b9foRdkXsOFpu/LnEHcyXaZCRlh+/KhgfkIhXR3PTQxxSpS8aW0/G01uZ2SlTSd+Bxv5vDlIu5CSs1xjGklRYkjW+6xOLFzKU/TCWkjOXPENEOAdLgnEpTjmx/Np4fbpInlayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229605; c=relaxed/simple;
	bh=6gI5sO2TVWLQc+VoGiXbA3sDMfk1R6h8sdoTsVAnyXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l64Lmw5QF4lkagv38VmJFBnp9V/pqXnE999mWHt2Qhc4hWGZYm3e0qythd0H7CtQlHq307WIIfLMxjPmwD43/vLiE7LWf7YVIXjTtWwJ78EuKLt8KmSHeCmUy4kzIiN6ghH2GE2uGeOIjFcKd1XOlYvAQ+NnRxLK1gstuXZl+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdKqrC4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E82C4CEE3;
	Mon, 17 Mar 2025 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229605;
	bh=6gI5sO2TVWLQc+VoGiXbA3sDMfk1R6h8sdoTsVAnyXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdKqrC4bozqTYcOR91NT5+Kwq6l6t86obfRfwQi7W3usKQsq5xBbJ5LSjuJOo2m6A
	 zmxtfRRuztWrSCQD7t4zb8frw1LJBXiJa7YxPqCuSeTIljMp7xd00dJsOMOvHPma57
	 qv7wpz33e22mOL4es27M6p6ZFdaFK+5rehpPcRtaXZU/ydICXFJ+FP1KHyvhF1E2gj
	 C1LRRyLwgcG+1b529qsvlDUXDDEK45W+DE46FHkIk16w4vx7oIh2wIhq3sWFbceTia
	 /SL7YF5c8goKyKJbbQ9nptpPitpzokk6TuajnUyxTCxHznw100LAxJ/JcGkvtWfUBk
	 PuwCCRYbBi6+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	songmuchun@bytedance.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
Date: Mon, 17 Mar 2025 12:40:03 -0400
Message-Id: <20250317085133-b618b4ac697a8a12@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317072021.22578-1-songmuchun@bytedance.com>
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
-:  ------------- > 1:  e5851a818c868 block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

