Return-Path: <stable+bounces-105236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36989F6F23
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216CD1890EDF
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79135161311;
	Wed, 18 Dec 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNi20Jek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371E715697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555675; cv=none; b=Fkj5zcRt7FdgmOhRWse9JNX/mI4TkgSHYlxU2NezlA7IbQ1s9Lz+DpHgoZZEsOqRDtyyI5LfmDIYX0qazrb+HgCYYiEzGjG9sW3Fw6FIiB5l9bPTONrwSTbEnemZR89U+nqKSMemq4fezA79CSkqOOiWpCH3GTwosEjf0oR1rN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555675; c=relaxed/simple;
	bh=pj5tDrLwRUqJ4Dkx2KpOb90zHKYJqlQJ1X62pFpJCvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAZZo4zpRDOhl6qOBzE0qWKvXWoJZGFQaQmpUdmmE8ArfkRDBTjo0/VbeTfRON4jd/NQ2RK7yMKFeZ4Z36nh1ByTCi673Oe6qCLwbaHS5ZbXVwgz5KuoV7E4u8T0NPoLugsnwwbiekI8qDhXzEbvKZiD3o0yF9XeBVh+TRxnD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNi20Jek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5DFC4CECD;
	Wed, 18 Dec 2024 21:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555675;
	bh=pj5tDrLwRUqJ4Dkx2KpOb90zHKYJqlQJ1X62pFpJCvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNi20Jek8qXgff+OQ/IXzBVurSz1ZyWCgB08KJu2R0u9KlH/c6PVk0qHn6t0PM/aO
	 XoahH/HeV94ZlJRLkVZywVirMcfPGsb6LFJoX+ClkWY+Y/ePFNEjZdeqj234xoQELu
	 JBRvO7Po7UZBzgTq6Xca4tEJbZAF41/s30b/mxxQosCnB1w6+Ogu/Gktm4SY2mXOaE
	 ClMPhPTyTwdF48CT2LvRFP6I80jlm2ejgEB9bw9CVZMck9hULuuPBhTz7w4czIRLVQ
	 pyhZZYmk7vvwqWciy2kP2gPU9sK1a7SopJFE+Q8lkR7NFBjiZLHwyHM/X5zZl55V6u
	 0GJLf3e+NXd+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 02/17] xfs: verify buffer, inode, and dquot items every tx commit
Date: Wed, 18 Dec 2024 16:01:13 -0500
Message-Id: <20241218150706-0fdf3ab3157e50d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-3-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: 150bb10a28b9c8709ae227fc898d9cf6136faa1e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Darrick J. Wong <djwong@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  150bb10a28b9 ! 1:  1893edde1b81 xfs: verify buffer, inode, and dquot items every tx commit
    @@ Metadata
      ## Commit message ##
         xfs: verify buffer, inode, and dquot items every tx commit
     
    +    commit 150bb10a28b9c8709ae227fc898d9cf6136faa1e upstream.
    +
         generic/388 has an annoying tendency to fail like this during log
         recovery:
     
    @@ Commit message
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/Kconfig ##
     @@ fs/xfs/Kconfig: config XFS_DEBUG
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

