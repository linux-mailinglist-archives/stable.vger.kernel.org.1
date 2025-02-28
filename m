Return-Path: <stable+bounces-119884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A256A490AA
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B2A3B2D96
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 04:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE531AF0C0;
	Fri, 28 Feb 2025 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhf6XwJU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BA1A3140
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718800; cv=none; b=neQOlBEIrrjY87zpiafDKZEfffq93gXpl+oJoGXi69yjIGqUOd9dbASNCyabbakkO8vVw1K6q7sDxcaJQjwtH4k9mvEAlSNMKC+wXkd4WVrZQPu5M4pdLAAQ2yEUTbs28a9ebiS31NXRvhYqDiH+8/s61u0dWtHTf3k2qGm+/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718800; c=relaxed/simple;
	bh=kXNchMMkgEVA9HI58eLIOi22/GDVK8xVwuJkPuHFB+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnYQ0mQzBi9C3W3v4E2Nam4Dxm4xKxtNKhFE5yY5t/eXYf4hTADcPAteYFFgqVuttj9uLzo2KqyQ/EUgSbZPHLTR/B01Ne0CK3+cvZXRm4STNLrJu2B6qIwO2HR4fDtO9tL5ZNFk3ONrdVDGQz9fTO/ZtfywC3tLdVwJLfa0A+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhf6XwJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7B4C4CED6;
	Fri, 28 Feb 2025 04:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718800;
	bh=kXNchMMkgEVA9HI58eLIOi22/GDVK8xVwuJkPuHFB+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nhf6XwJUy4ar1pVkGJxoLYhIoSN4bNFkoztjeLc6uC3Wbx+lYw/mm+piG/Ux6GxyQ
	 RniGwc+yh4XoFrNdad109WrULYQ7anAyPqo8JDmflxlaoZDW1G9pnIK8wssbCcvAZY
	 qdVztG1jiwiE1tuoI6Zl67pSXqmV+V3gaDj0j0OUCEdwicL7HMriG5SW3PLC8INlaW
	 +s52ArxxUaKpDI58bjUALAkwf2m6LOJT/1eYcCeP/C1Rom/wprQhLxgqc2dH4JzAdv
	 kYDQQy8liEoa5/fM/4CcpfINn5aomfhRQJfjyAeaI4nsqCXXd37JGhQr+vBSlQCEDt
	 471kkI/MN9qwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	konishi.ryusuke@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 5.10 5.15 6.1 3/3] nilfs2: handle errors that nilfs_prepare_chunk() may return
Date: Thu, 27 Feb 2025 23:56:15 -0500
Message-Id: <20250227211043-3449e6548f2dee1a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226180247.4950-4-konishi.ryusuke@gmail.com>
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
ℹ️ This is part 3/3 of a series
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: ee70999a988b8abc3490609142f50ebaa8344432

Status in newer kernel trees:
6.13.y | Present (different SHA1: 481136234dfe)
6.12.y | Present (different SHA1: eddd3176b8c4)
6.6.y | Present (different SHA1: 7891ac3b0a5c)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ee70999a988b8 < -:  ------------- nilfs2: handle errors that nilfs_prepare_chunk() may return
-:  ------------- > 1:  6030ff62ea011 nilfs2: handle errors that nilfs_prepare_chunk() may return
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

