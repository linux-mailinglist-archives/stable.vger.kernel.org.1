Return-Path: <stable+bounces-132339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DAEA872A8
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E708B1892C75
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635A1D7E37;
	Sun, 13 Apr 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQBqBPEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255361C1F21
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562796; cv=none; b=gmPsyGpRcmE1FwrKSsNbI/YiAonu9s9Qf3QIKHnIXpVHcZ3g5bOpohK+La05db1dZ0VjeImOnbY6Q1mR7eG/7PenmNIv9IZVjM79Ae382GPgUF8+ITCMCHX/bq4+1nE8O8Y8YMr+P0LAioFH9LLluIStPUgbVegwL/4W5QBftY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562796; c=relaxed/simple;
	bh=eJ7V+Ni0Uamj3HcOsyw2B8k0GfAq0/rqzUIyeyKhdg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwJQLEr5MCCKADHAvu5jIzSZoDZOpH6HCGiS1/tNz6CTDh50J3fvksdFlAmpxts4g484d2/MVynIBSb7mTvDe5uEEvfTd9WtIInKtsXpOSitIq8Acb2lEpnJeSamtpqhDuaVouxd6UfaeTwKu/iVwHIZKOdhErFQoV5uwQX9rwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQBqBPEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C2EC4CEDD;
	Sun, 13 Apr 2025 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562795;
	bh=eJ7V+Ni0Uamj3HcOsyw2B8k0GfAq0/rqzUIyeyKhdg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQBqBPEm/IlRg+Up9rkloL+uy3xmidF6MiS2SMve/cdMTtE0S3uOKT+lI4lJnSL9x
	 ycBmbh7DT7eZUHbGgdvKBOko3OfbEzWMeyQILqV1EkQTgVF//sVrCrlIpWJ6EOAvAv
	 7bOsSZfsEamgMqW5VkPxBPRYPa/cVBts5GTRBfQMEHfo7nXPSoWqomaEhtZbdkmcW3
	 j5MXdqfqiTBwxR95i35y4Giz/rKq7mxz452cWOO6UKXrNdJVfutIMZlxZOuhgb1J5p
	 1ccDUQtwS2fkXCkFrpEGglh2w8E/Q62A8a2oi3IjHtZjVkZMop9O7y/l7sjHb4vlkS
	 9tTk8r4Wh9wwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] ext4: fix timer use-after-free on failed mount
Date: Sun, 13 Apr 2025 12:46:33 -0400
Message-Id: <20250412101326-fbe02ede0ea1bd3e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411081911.219016-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 0ce160c5bdb67081a62293028dc85758a8efb22a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Xiaxi Shen<shenxiaxi26@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 9203817ba46e)
6.1.y | Present (different SHA1: cf3196e5e2f3)

Note: The patch differs from the upstream commit:
---
1:  0ce160c5bdb67 < -:  ------------- ext4: fix timer use-after-free on failed mount
-:  ------------- > 1:  806747a29525d ext4: fix timer use-after-free on failed mount
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

