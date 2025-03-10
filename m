Return-Path: <stable+bounces-121650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E6A58A4C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A94018870D7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385C18FC74;
	Mon, 10 Mar 2025 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVsRDTpw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71763156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572878; cv=none; b=V9grxC7E0W18IaHTOJk6h0DGHr7rD+Lr8O+XJS7z2CkPERVTsn8aWat6gNa1jwt3Y1C5pFd7FlSos3XCNKCUFt16YVw4YP3Fak+HFDZilTwzTL+JkJ9IM4ovHxcUgXqAarMqciaXoN+GV6p9z2ADpgDemMtXYCLbC7TEQ8SCnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572878; c=relaxed/simple;
	bh=nguXYV3SNUIDgSUvKYFgHIRm2EayBk+zXNllP0/hRvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PD+V4rBwfehFlK3civRU5R6KHmMgXxtnYXU45BYt/9HwxPxpN9ormQuu+9UdTvC2aYciQlVyhgy0Sl4qhNiMZczhzLDTcwHWjrJSEZvXnZ4VnbxotqFHKSkc+9TXmirDJHzdfe1rjxxfVuXGBk22NKkIIMHoYt2bA+vvsUN+KzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVsRDTpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C502DC4CEE3;
	Mon, 10 Mar 2025 02:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572878;
	bh=nguXYV3SNUIDgSUvKYFgHIRm2EayBk+zXNllP0/hRvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVsRDTpwvG7GOyG8TVavv5vp5NR6hFyULh43qyo5h0kYWB8sZHepvYUfkSKjB2GCH
	 64/Q4qECVAzLjNxTBsDniHi2FHxrX5qJCXoMy1rGrOpO0j8qFgBKQw/uZmKIQy1Wqi
	 gCIKEbjL6qeLLDnTELwxVTqUqtBSE1SN3LvuO7ykPt5VfuesDPSUhHeRfbe1Q6ZZTX
	 VEOXFOK9MO9aSYxkU0dTJlzHNr4Wf4zftbHB8E+Lzczn8IC92XrF50BdhTINggx4df
	 rq3Llggjn/vatmiJL1lG/zLlxJy1AJGFddHVE9+auR/D/0LXIbZLZzhHfvJPQzZqvF
	 8c438UITuUVQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v5.4 v2 1/3] overflow: Add __must_check attribute to check_*() helpers
Date: Sun,  9 Mar 2025 22:14:36 -0400
Message-Id: <20250309204244-dbbee93b496c69ca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307130953.3427986-2-florian.fainelli@broadcom.com>
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

The upstream commit SHA1 provided is correct: 9b80e4c4ddaca3501177ed41e49d0928ba2122a8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  9b80e4c4ddaca ! 1:  0aad002281c33 overflow: Add __must_check attribute to check_*() helpers
    @@ Metadata
      ## Commit message ##
         overflow: Add __must_check attribute to check_*() helpers
     
    +    commit 9b80e4c4ddaca3501177ed41e49d0928ba2122a8 upstream
    +
         Since the destination variable of the check_*_overflow() helpers will
         contain a wrapped value on failure, it would be best to make sure callers
         really did check the return result of the helper. Adjust the macros to use
    @@ Commit message
         Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
         Link: https://lore.kernel.org/lkml/202008151007.EF679DF@keescook/
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## include/linux/overflow.h ##
     @@
    @@ include/linux/overflow.h
     +}))
      
      /**
    -  * array_size() - Calculate size of 2-dimensional array.
    +  * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

