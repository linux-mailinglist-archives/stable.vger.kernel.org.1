Return-Path: <stable+bounces-104289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D949F2526
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 18:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90ED6163058
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699061B412D;
	Sun, 15 Dec 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6mMpkyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2B1119A
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285097; cv=none; b=mZqkbwmHWWBTz2+yfBr64KRtR068MCB4J8jNyOt9ta8S9MZRrd/5WofK/4o088WTawqTc5EEl+Rq1ysnVJwfQhgZ4CovYrIip/8PsWoa0Bm/fRc0nf5TFefqyLnJ83zTQkUXG+I61mtA0EehuHdefNvF5a/BeCR0gJv8lBc5mfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285097; c=relaxed/simple;
	bh=JcJm6rWjvax47x1qKoZT+fCPTVcPU3XJlaA7VsxoR8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5du1ATZ9Dl9/rK2E0q7uATj+ykZUZ9aReB2PA5v6CWPl0uznJVBylUg+rV1lhYGvWMXWV0jJ9IbYTtCuZyMTX2cExlk5+GKr56NxjXAWIaRsswROwrFgakYIfBk/Ee6ENtpqjL3LiJCG4wW6hQ1iAjrl+YRWAOgM0qdoOYgCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6mMpkyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBDCC4CECE;
	Sun, 15 Dec 2024 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734285097;
	bh=JcJm6rWjvax47x1qKoZT+fCPTVcPU3XJlaA7VsxoR8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6mMpkyhpnXUOPy89+KE5jYd8FRDTsUQT8nC8ILd9P1DwH6kwLDDmP3VKnX3+n4xl
	 WdyPQ92rPTjlRSXfhiUbyb9zrt/ZRndfgt/VIS2LJjgo1ILhhH+RIsNIrLimvuXKrF
	 Dm2UAHKNmfiYjLwggpOJie6F+U9FKqRSW2Bn3OZFJfNwWra6GP34A4L5d08Jr4iGM0
	 b2LDeU0GXHgj4V1x0J04pV2wwRML13d2RWtApzXyXbPjwkSFHDpCULXrradf9dJd38
	 PUcisPHr43pV59ca25R6CeY4SbHbFQoklI5syMeJgPGWsI/rXZBrbX0pBX+GTRfmRv
	 cxko3bopgJ9Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] exfat: support dynamic allocate bh for exfat_entry_set_cache
Date: Sun, 15 Dec 2024 12:51:35 -0500
Message-Id: <20241215091934-2cc7facb6ab36cb2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241214221839.3274375-1-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: a3ff29a95fde16906304455aa8c0bd84eb770258

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Yuezhang Mo <Yuezhang.Mo@sony.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a3ff29a95fde ! 1:  bb39fa77df0f exfat: support dynamic allocate bh for exfat_entry_set_cache
    @@ Metadata
      ## Commit message ##
         exfat: support dynamic allocate bh for exfat_entry_set_cache
     
    +    [ Upstream commit a3ff29a95fde16906304455aa8c0bd84eb770258 ]
    +
         In special cases, a file or a directory may occupied more than 19
         directory entries, pre-allocating 3 bh is not enough. Such as
           - Support vendor secondary directory entry in the future.
    @@ Commit message
         Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
         Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
         Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
    +    (cherry picked from commit a3ff29a95fde16906304455aa8c0bd84eb770258)
    +    [Harshit: Backport - clean cherry-pick to 6.1.y]
    +    Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
     
      ## fs/exfat/dir.c ##
     @@ fs/exfat/dir.c: int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
    @@ fs/exfat/dir.c: struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_
     
      ## fs/exfat/exfat_fs.h ##
     @@ fs/exfat/exfat_fs.h: struct exfat_entry_set_cache {
    - 	struct super_block *sb;
    + 	bool modified;
      	unsigned int start_off;
      	int num_bh;
     -	struct buffer_head *bh[DIR_CACHE_SIZE];
     +	struct buffer_head *__bh[DIR_CACHE_SIZE];
     +	struct buffer_head **bh;
      	unsigned int num_entries;
    - 	bool modified;
      };
      
     +#define IS_DYNAMIC_ES(es)	((es)->__bh != (es)->bh)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

