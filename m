Return-Path: <stable+bounces-135275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1BA9897C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9751316F39D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF18632B;
	Wed, 23 Apr 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLb3xwOR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594D1E86E
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410625; cv=none; b=fnXKocYaS4TCvG5x/QQJDm/M5zWhV/kO+Hh0a0H+EO7H417p7Yet5iuOjtXeUdwIme4o/Eiaz1Ax1E5NoZOX8/ydiZgzqyDQhVXCkgx4kOeMgdOSpQ1lwhYokq7KMngOA7EtOm9Xr7QR6EKBPM7MEBHDEr7ZpjcyuaclLfDMsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410625; c=relaxed/simple;
	bh=tVd4Jsj6NHNOl5giePyYKHJHYnNT4aY68CUsVTD1P9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXYBGBnsIe0a0mvXWQBEXJ4+iUPYxoLlTEUWTGqQ1n2KsrRJ9/cHciYtFl4US7dw3d06GMCNY74umPou1Bv0wb9umjQ9Hm6xN5nxf03HMdhSfzwwwPSOeLN9DVBI8GYVabvz6toh7dPzadp1goAmrzMVNb6BPwW9zKkUdKMu5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLb3xwOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF683C4CEE2;
	Wed, 23 Apr 2025 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410625;
	bh=tVd4Jsj6NHNOl5giePyYKHJHYnNT4aY68CUsVTD1P9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLb3xwORbPrt9Ksz16YXNnW6CC7KeRcY6iF8U+vqYAffNYrEPcHufJtgz49t4PjS7
	 66dCQIDoUQod1rOfu4xKVSRtHtnnYmuakYIY0Tw2c/HWa5jHh6c61cpqmVj96x+0B8
	 oyYdg0IW7M4soKdpvKnfrNCNuZ7M7UtmX47huuUV/Ohk4rRBgLCe3GR2Mwo8iLAIXG
	 0vJsTVVPgn1netGqfmpYp+LUzvW6JI7ziAUb4aIvR+kPk7+Lva3DTWM5G89mIZzlCg
	 f+t1IadNrVAouakricK+vqs5+/1P9LnCukC2mfuHaqTtMI0abA08MpuhAkwzgKBgy+
	 5OGbqLmPsHGhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 23 Apr 2025 08:17:03 -0400
Message-Id: <20250423071750-c46e56727dc3bbcf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423024008.1766299-1-Zhi.Yang@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: fb63435b7c7dc112b1ae1baea5486e0a6e27b196

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: lei lu<llfamsec@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 7cd9f0a33e73)
6.1.y | Present (different SHA1: d1e3efe78336)

Note: The patch differs from the upstream commit:
---
1:  fb63435b7c7dc ! 1:  26087c0d9df82 xfs: add bounds checking to xlog_recover_process_data
    @@ Metadata
      ## Commit message ##
         xfs: add bounds checking to xlog_recover_process_data
     
    +    commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 upstream.
    +
         There is a lack of verification of the space occupied by fixed members
         of xlog_op_header in the xlog_recover_process_data.
     
    @@ Commit message
         Reviewed-by: Dave Chinner <dchinner@redhat.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/xfs/xfs_log_recover.c ##
     @@ fs/xfs/xfs_log_recover.c: xlog_recover_process_data(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

