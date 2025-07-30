Return-Path: <stable+bounces-165555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB95B164A3
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088457A560C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD42DEA7E;
	Wed, 30 Jul 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNdCNTXr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCA2DEA6E
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892948; cv=none; b=BCMVL3Qp4CUJE3rLgtVoHcn5hZHmci7M3EB78kPYBDf0IzFczERdw78QujOrBLR8MXN2eyPXrGZCoiZ4dSFzJpAuwbbgfllmDUi70OX0Z+CTNVt1DEn//mDb8Pq4NGv4BqXMqsI1aEuvDrCeTDmCn6Xy4N9cUtY4iV9RlIPXI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892948; c=relaxed/simple;
	bh=71F4YuDhfIGgfRqrpfWqbwqjLuOOSXwkKTgOTTMDaaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbmInl38G2svUGx4VxYRpE7Udj5ATXYsnyXJ3Jytq+DtLqm2N6+14B+eXuuImkCDRn3AXCn10XBuzXzlZizeTm0gUbN1UUn+Uvudw8/0SmF3UXONjf05bZSc/U1yHTR88wHDLDLxb7M/uc5ev0pkoRbgChq3as1fDuuAl1YGfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNdCNTXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B511C4CEEB;
	Wed, 30 Jul 2025 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892948;
	bh=71F4YuDhfIGgfRqrpfWqbwqjLuOOSXwkKTgOTTMDaaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNdCNTXrJOkmK8bFZf1+HAK0oVa9YMk3ULk9WX3DzitNihM+y2mfLBHlEboCHJXXf
	 5Y70zQbNANFYOpmnRy0DFftNMwD9MaX7MHroKS/RG4dmGm3tMimnhMU36PoUL9nS4q
	 LUuUVifbkjTvWKD30TKhhrwucI7eoKDt+yUIKxLusj6k+muk2ZoZiiaudbAHlZ47Qn
	 ukhRTBYfpzFTzv1UhsOF61OLLHHfXyTT4Tkmy6n30YUvTInp1aC+W/2OPzMYEEKgaG
	 huC93AzYrjpaxlEbLI1hc4Izf01pC5g9XpxmlUEQTxphRLhwupThjbuyPdXKvh7E6W
	 xCgsvjuB4tRQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/4] mm: reinstate ability to map write-sealed memfd mappings read-only
Date: Wed, 30 Jul 2025 12:29:05 -0400
Message-Id: <1753862000-19708450@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015247.30827-4-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: 8ec396d05d1b737c87311fb7311f753b02c2a6b1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 464770df4609)
6.6.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

