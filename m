Return-Path: <stable+bounces-105233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8675F9F6F1D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D299189057E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E75161311;
	Wed, 18 Dec 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHPxH3qu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241615697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555669; cv=none; b=HQ31VXM4kax/EXZZJLPuj+j783tdc4NAjCC0gY2PB51eb0QOMiupk/aJ3/rCooI1N/jhcg+2FZgCqiCaK+XB6nqxH6h30sfFvkw/B8ZzSHRaxJ8T3QcyCRr4ZyduYEctogeJgBVi1aCtXgdz6DkjBzb0qiY0H54Q/WVpT2TWTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555669; c=relaxed/simple;
	bh=MkS86VX+6PfEx6TqY3z5xnAYP0adD8yPMq8Ms1fSQd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+V29cUGltMvFnFCwbvSyCao7cPdfa1cTMBDwKKVNAnkW1gvWvjdWYuDgrLRf8b+XDvremJdHiMOBmnDFPK2OlEP12B24JrS0P5vBT2YNyrRz0ON7bVTEz3wZoxt4xs3BjihqXd9kzYj14Oj5GKkNd85HDNKEpty53T4VsAiaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHPxH3qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8B6C4CED7;
	Wed, 18 Dec 2024 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555668;
	bh=MkS86VX+6PfEx6TqY3z5xnAYP0adD8yPMq8Ms1fSQd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHPxH3qu6TAukd7NGARxERw0Se1FymPgdkBE2TlUh2zhQWhjcA3vOPBCoGjEi/NSh
	 LmIt7we2vem5mkFKvX8mo+I+cNIUksmsyuWdYesw0geceg9UtMk7uSxW52l9JLgoEx
	 ocDuihABSyjhHXCyB0IwP/8O5lccfMa+vozrtcz47cEMDun9ZlWpCExAD6HxRqiFQP
	 rgBv6FxkQ4qXXmSw7oi1B3UXTFyUn7SXDxAamnI4Y2YASFXcHjDPJhQwGZuIFb6DYx
	 CWjv8hmzd4xVJCFjU5zjHmQ300LbLo6LnWmbW5d+M/5IhHOI0Nx5iaLtSt9P+q3Z5i
	 bW/x6cF9SU6QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 03/17] xfs: use consistent uid/gid when grabbing dquots for inodes
Date: Wed, 18 Dec 2024 16:01:07 -0500
Message-Id: <20241218151133-9e8ef112d0363a06@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-4-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: 24a4e1cb322e2bf0f3a1afd1978b610a23aa8f36

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Darrick J. Wong <djwong@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  24a4e1cb322e ! 1:  329c0e502f76 xfs: use consistent uid/gid when grabbing dquots for inodes
    @@ Metadata
      ## Commit message ##
         xfs: use consistent uid/gid when grabbing dquots for inodes
     
    +    commit 24a4e1cb322e2bf0f3a1afd1978b610a23aa8f36 upstream.
    +
         I noticed that callers of xfs_qm_vop_dqalloc use the following code to
         compute the anticipated uid of the new file:
     
    @@ Commit message
         Fixes: c14329d39f2d ("fs: port fs{g,u}id helpers to mnt_idmap")
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/xfs_inode.c ##
     @@ fs/xfs/xfs_inode.c: xfs_create(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

