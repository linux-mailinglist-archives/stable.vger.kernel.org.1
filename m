Return-Path: <stable+bounces-111928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A8EA24C3C
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABB118852F8
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618121C5F34;
	Sat,  1 Feb 2025 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo6JMu8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190E126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454036; cv=none; b=B0lgIevquGk9XT8+/o60Q/ls+ofF5SYa0is9LylhoQIKTU3R/TjMvya+PvbeyDyS+7+TmsfPiGip5paxOXiSjo5HOHM7WKOVfj54AzUAz9ko7UDRO3wG3spolScP9PzSx/32bDqvmSTlozjZZrkaczsWhHz8yQMS1aOstkE46o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454036; c=relaxed/simple;
	bh=xhq8oPpSeGAufQsdnxiEYacHJChkKZFdzmz3tkp4pOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6DPqNaBTaWuvUuNa3laC9rhLlJe78pWbr12gN+04ZPXTeUWn6LulzfeA/s0ixdJwsONc0PXIaoVgfAX3aBYa5RuSYzJM1VU60wAKv+8c5JoT2Xlkfcf7mjFKo0N74qnVs6bQHJnrp0fnJY9s7KxQi1mycCL1bTzgZbd/qfe8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo6JMu8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85142C4CED3;
	Sat,  1 Feb 2025 23:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454036;
	bh=xhq8oPpSeGAufQsdnxiEYacHJChkKZFdzmz3tkp4pOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo6JMu8WvFQZ6kwGrh/m5MfXAiuoU1M9/YARr8/lRvBZVLq0iUdQYFPDjgrSqT+hd
	 zJT7CfwogVJQbNpw+KgBkL6I8UakUSE1/wjA5hIBmgoy+UT1ZymmtudNq7Ulw11Ql0
	 h5IjOBqrMKpy0V4DM8dkqp8FDw4ATPZXUa5FR9ADRr90dN5PRyxXao5PChP3hn6zPR
	 t5M7p2f5B+nSSW/tEYorgs2lQygGuX+UB2NaDKqYSwcBe/UUf3zNTJaILU81vobBVm
	 Gt7eYa4VggsmHDWPYQLPpLW27GRfO5Q3hVUjQcMy7+3qWcPq7s0wzdEnu8SNfmORnE
	 GLv0UIZiIQWZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 15/19] xfs: inode recovery does not validate the recovered inode
Date: Sat,  1 Feb 2025 18:53:54 -0500
Message-Id: <20250201144829-725671b71b802cff@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-16-leah.rumancik@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 038ca189c0d2c1570b4d922f25b524007c85cf94

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Dave Chinner<dchinner@redhat.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: b28b234276a8)
6.1.y | Present (different SHA1: e8f4f518d29f)

Note: The patch differs from the upstream commit:
---
1:  038ca189c0d2c ! 1:  8f643a2b86e6b xfs: inode recovery does not validate the recovered inode
    @@ Metadata
      ## Commit message ##
         xfs: inode recovery does not validate the recovered inode
     
    +    [ Upstream commit 038ca189c0d2c1570b4d922f25b524007c85cf94 ]
    +
         Discovered when trying to track down a weird recovery corruption
         issue that wasn't detected at recovery time.
     
    @@ Commit message
         Signed-off-by: Dave Chinner <dchinner@redhat.com>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/libxfs/xfs_inode_buf.c ##
     @@ fs/xfs/libxfs/xfs_inode_buf.c: xfs_dinode_verify(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

