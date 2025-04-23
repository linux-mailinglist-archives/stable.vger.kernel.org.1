Return-Path: <stable+bounces-135268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84EAA98982
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934E53AB995
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651A1F37D8;
	Wed, 23 Apr 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyAxBgw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4B1119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410611; cv=none; b=UKq3VW4EY9eGsywIzI/4LuIilUIGqIPrE/JyUwbDMnknY9vGq4uSF6Q2h1At1kOkv4W9dP1tEOdZQZ/H207WqFmuLrOsWmo3UKHxK4441Tvhq4T51Q4dV7s39AF9E8esy8R4W/GReG/yuwMghNvPUsdu5tqMr54ll6uHyluitbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410611; c=relaxed/simple;
	bh=HfedYAeF1abtrIhrpbUD/Yau9e2WgQ5rRbCFIA6i0gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWKgAEW/pvC1K9QsT7R4Nnwhni+NA24IyzASb6pOY9Szcftp499tNwtpVHGAg+a2HpcnVhTu50Gmae/xq3EH9hAAyGLVWV0TEisXkVH5NG4DXiMoh/9O5WbCZ6j9Z92cc+qPAaQJKKbtg+Wtos4X1Da+vSoYgJ3kVzwyhXl6aM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyAxBgw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B686C4CEE2;
	Wed, 23 Apr 2025 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410611;
	bh=HfedYAeF1abtrIhrpbUD/Yau9e2WgQ5rRbCFIA6i0gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyAxBgw+EtzW+wgW13ex1zs3MEg4ec0JeP8ha0epY8OCxs7L1R/eaDrgmCuI9K4Cs
	 ADlHCTemzmcNZLBPJ6z7VaTNnWmYcVK2xDUgTG/coai+c4+SVN6QotNcdm+PkkSIoj
	 tU4ydvzpW4KPUJCbDXwa/Nm0ZaNmLLOmYrbHCeP5CdcZrj4sQN+G5Tat0Ys1/hmLWG
	 U7aGHJRh9IPYyoLhSgT7fO58xQ4pl0xJCUVdJcr5hpyrwGj7GWp6lK4dUBftGc0ZIv
	 ptnpiWp2T4wAba7Rjfea8rslCLGy682yNJQJdl7Fi9whAneZ8loy+Q9fm/+xs5G0YO
	 xt93EL/Z+ffKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 23 Apr 2025 08:16:49 -0400
Message-Id: <20250423071353-ba0f13b425caad71@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423021325.1718990-1-Zhi.Yang@eng.windriver.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fb63435b7c7dc ! 1:  cf9831ea2bc08 xfs: add bounds checking to xlog_recover_process_data
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
| stable/linux-5.10.y       |  Success    |  Success   |

