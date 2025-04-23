Return-Path: <stable+bounces-135269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD137A98976
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D79170C0F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856B8632B;
	Wed, 23 Apr 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1nG3afj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A91119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410613; cv=none; b=IoBRZMXbOCXqK64STl3xlpWhbAIO6413qedWN8NeWtiDqoaZ2be/bIS56G3IAKHPqBq7atu0zORjywrq9r5+2g3SmInAP/ef+L7T9mLnu3/O5tU2IyetcI9hxABrTdGTc4wgl7Sg/F5Gl2h6o1YTzGiAGeUuLN54hLauF4VtGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410613; c=relaxed/simple;
	bh=BC4AstB2nHc9bzi0pNlUZmVvAttK7RTy4DJP0GFs1Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V57A/0mlG38pNnexrc/MKW9HiFmFmUcOqa80ILEBFG931kXzi1Sb4tdwtRzoXjI2VNbTP0WwNvfswGzeYwLFUjmtxVySGyiwrdhspQeT0h7hCW7PVxlBgtI9Y8vRmA+m50iLfrxZvVwjbk2rAVw9Tv4pX5TuhMOsgSZJgyGRS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1nG3afj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFFBC4CEE2;
	Wed, 23 Apr 2025 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410613;
	bh=BC4AstB2nHc9bzi0pNlUZmVvAttK7RTy4DJP0GFs1Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1nG3afjvTPcVuAF1exoahEclbdWeJHtjZGmXY6JA3mFGPc+Cubjjlm3AO/UvLrrZ
	 0+yqseR9eqDHjTamgPUWlSTwC2hpfNbO2nIcnqcb8U4j9ZnNirUzU9FixiZ77eVQ3S
	 VPsXerCPZqsnr3BbZvFl9RqIWVuRrDqNVtGiGDHI//mq52FquZy/rGCaYVdnJGuNPu
	 4vrdVW4PD3Y1b/+17d+wEHvCsu1qrA+D4DL9v7z8rIx530zRpie3NyTY/LlL/wJKZw
	 pqfr26ntUHGaugaFUxX8MNUUGprY1OhReEjp4MdJuy6j8QCMtfy8pN4oG2EjtxY3xg
	 9qkeExaZRq2+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 23 Apr 2025 08:16:51 -0400
Message-Id: <20250423072840-a7d4423038e9bce0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423074513.3861455-1-Zhi.Yang@eng.windriver.com>
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
1:  fb63435b7c7dc ! 1:  12b817c219a30 xfs: add bounds checking to xlog_recover_process_data
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

