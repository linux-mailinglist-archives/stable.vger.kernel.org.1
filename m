Return-Path: <stable+bounces-95832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDA49DEC97
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5E7281E9A
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025991A265D;
	Fri, 29 Nov 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZxe/CHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680613DB9F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910593; cv=none; b=pNPc8WlyEy4/SIXbrymj259i/8cf9+A0+QbAxZQNTjZIJdvcFTugAJTmRN8zmnvBlfXMKNOz0ktWII0i9eMkfd0lDtbMtZf/bjqBlQ/d+qQ9Zqq2NNb4EqlnyTFj465NV38sc+Qjq5tcja+gVgSCVUvta0mKrBH9GlbRx/LwxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910593; c=relaxed/simple;
	bh=pbhV0wVEb8rnjWJwSo1743CJjF/eA2mVG3vdgFygba4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZRPGwaU10rzPq5nDLgU8OftTdNw7YbUCaRxjwtibNS09qzMCiiwHWirNtPvKi0AIZvJAptHpm0gBe+hDL1K3ONLstDh2VvlN/CqNv3hZgjVz1EM4jiukLtCAV5OlRaRF8TtZcs1Tl25ypAZI+oWj2dq5K9l6JlJLed+XPf7s6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZxe/CHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62ECC4CECF;
	Fri, 29 Nov 2024 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910593;
	bh=pbhV0wVEb8rnjWJwSo1743CJjF/eA2mVG3vdgFygba4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZxe/CHfdFz169e2LnXB0a/YLTGeUNYSoXjrGiA4ecZ99Q+l03H3060qzsk7icM7u
	 KJaMK1ryCtW4+ZDDUYRz7+scuDKDUHC62+hMcnI2o1a/+5VMbTEFe77fXa/PlZgO0S
	 1Dg+aBbwacRLP6LC6Qxd/DbJuGUiksloMX+LPNjxM0HF3m9QWrLSjogO3CuzWwD1pc
	 mbL1WuSNZWdzLB423W5oDEwD3xSKWFOPayAl7ewh27b4iRPHvUTH/u65CkrOkk064d
	 tBEvnPSOFMeKGt9KZnkaolaMkymZtwnlogkC0INLADOjRIXpfNM50gWUmOs3yPmvWD
	 +EyGjUiHkW2Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] kernfs: switch global kernfs_rwsem lock to per-fs lock
Date: Fri, 29 Nov 2024 15:03:11 -0500
Message-ID: <20241129143043-6aea62392ec8e78f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129113236.209845-1-jpiotrowski@linux.microsoft.com>
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

The upstream commit SHA1 provided is correct: 393c3714081a53795bbff0e985d24146def6f57f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Commit author: Minchan Kim <minchan@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  393c3714081a5 ! 1:  b3f5272b13165 kernfs: switch global kernfs_rwsem lock to per-fs lock
    @@ Metadata
      ## Commit message ##
         kernfs: switch global kernfs_rwsem lock to per-fs lock
     
    +    [ Upstream commit 393c3714081a53795bbff0e985d24146def6f57f ]
    +
         The kernfs implementation has big lock granularity(kernfs_rwsem) so
         every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
         lock. It makes trouble for some cases to wait the global lock
    @@ Commit message
         Signed-off-by: Minchan Kim <minchan@kernel.org>
         Link: https://lore.kernel.org/r/20211118230008.2679780-1-minchan@kernel.org
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
     
      ## fs/kernfs/dir.c ##
     @@
    @@ fs/kernfs/dir.c
      
     -DECLARE_RWSEM(kernfs_rwsem);
      static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
    - static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
    - static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
    + /*
    +  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
     @@ fs/kernfs/dir.c: static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
      
      static bool kernfs_active(struct kernfs_node *kn)
    @@ fs/kernfs/dir.c: static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *p
     -	lockdep_assert_held_read(&kernfs_rwsem);
     +	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
      
    - 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
    - 	spin_lock_irq(&kernfs_rename_lock);
    + 	spin_lock_irq(&kernfs_pr_cont_lock);
    + 
     @@ fs/kernfs/dir.c: struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
      					   const char *name, const void *ns)
      {
    @@ fs/kernfs/dir.c: int kernfs_remove_by_name_ns(struct kernfs_node *parent, const
     +	down_write(&root->kernfs_rwsem);
      
      	kn = kernfs_find_ns(parent, name, ns);
    - 	if (kn)
    - 		__kernfs_remove(kn);
    + 	if (kn) {
    +@@ fs/kernfs/dir.c: int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
    + 		kernfs_put(kn);
    + 	}
      
     -	up_write(&kernfs_rwsem);
     +	up_write(&root->kernfs_rwsem);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

