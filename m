Return-Path: <stable+bounces-96056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80539E0820
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5507B23166
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058052040BA;
	Mon,  2 Dec 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkmwi/49"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BE203711
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149618; cv=none; b=OTKlpyQvQv/rOoCfPuqipL2S1ouErleXGkALBv5t+p8eo0LlqnIk/FiqN1s9HSR5WKYqH/MZNMWN8M1Z3zRNLsSXgZ7vcW1eh5emF5VyYvXGpvjXrhyEZQ1CtKl6FeCWTriQRstf9IGSut2p98o4VSh2OXk/qPxzG45bZnEWVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149618; c=relaxed/simple;
	bh=gy44+Nn37PSII5NOwdneARNP1mCq47DFSsBIlltRvhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKexelOZTZb0tzq+dpB9U8aV74Boyw3c5Z/CGsLTX9LwVDDXFni2z3O6B/YkRKKelf7jbWWOD2NiURtUEzvh5zkQbKMZbEgzUBKB4TEuv5mtWlHHUR3um7B5gE45ws6aWO7C7IPvK7v+4rGgl91N7f8zVckSbCH4VFiv2tCWH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkmwi/49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF74C4CED1;
	Mon,  2 Dec 2024 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149618;
	bh=gy44+Nn37PSII5NOwdneARNP1mCq47DFSsBIlltRvhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkmwi/49qPnv1hiYmU9/DAOrFcHK0aFIE/+uPTNQkyrFCCTH8NaMQq5vpVn48iXnx
	 IBuxh6qLnPHVpN6PZRuL3PkUJ8+YYee/+6gHTvPDrUNs6EITrmjsH+R42VqFvsLXJG
	 oZZCo99WB2hW7BkUN9pX7Adky0W7saEAIJetr/kE4reA5SbMOj3JudZoh8vNeJAbeQ
	 Riqg81E4lRHcQljvTmy/hxvHcMwvG576cUc4Go3NUXsXg7u3zzqAgQq11LKx3le7jw
	 j/fZguHEBXe6rTia2++LLpCxx4rYMC/+dj+34GLNpwy8ovy15c6MnBqj9kO0Q55xeW
	 BQf/BywGLtcZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/2] cgroup: Make operations on the cgroup root_list RCU safe
Date: Mon,  2 Dec 2024 09:26:56 -0500
Message-ID: <20241202080647-992aab9556b8e021@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202111024.11212-2-siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: d23b5c577715892c87533b13923306acc6243f93

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Commit author: Yafang Shao <laoar.shao@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: dd9542ae7c7c)
6.1.y | Present (different SHA1: f5b7a9792041)
5.15.y | Present (different SHA1: de77545c72c4)
5.10.y | Present (different SHA1: 45a81667e0e8)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d23b5c5777158 ! 1:  ab0b59573d9f9 cgroup: Make operations on the cgroup root_list RCU safe
    @@ Metadata
      ## Commit message ##
         cgroup: Make operations on the cgroup root_list RCU safe
     
    +    commit d23b5c577715892c87533b13923306acc6243f93 upstream.
    +
         At present, when we perform operations on the cgroup root_list, we must
         hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
         we can make operations on this list RCU-safe, eliminating the need to hold
    @@ Commit message
     
         Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
         Signed-off-by: Tejun Heo <tj@kernel.org>
    +    [fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
    +     ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
    +     codes")]
    +    Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
    +    [Shivani: Modified to apply on v5.4.y]
    +    Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
    +    Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
    +    Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
     
      ## include/linux/cgroup-defs.h ##
     @@ include/linux/cgroup-defs.h: struct cgroup_root {
    @@ kernel/cgroup/cgroup-internal.h: extern struct list_head cgroup_roots;
       * for_each_subsys - iterate all enabled cgroup subsystems
     
      ## kernel/cgroup/cgroup.c ##
    -@@ kernel/cgroup/cgroup.c: static void cgroup_exit_root_id(struct cgroup_root *root)
    - 
    - void cgroup_free_root(struct cgroup_root *root)
    +@@ kernel/cgroup/cgroup.c: void cgroup_free_root(struct cgroup_root *root)
      {
    --	kfree(root);
    -+	kfree_rcu(root, rcu);
    + 	if (root) {
    + 		idr_destroy(&root->cgroup_idr);
    +-		kfree(root);
    ++		kfree_rcu(root, rcu);
    + 	}
      }
      
    - static void cgroup_destroy_root(struct cgroup_root *root)
     @@ kernel/cgroup/cgroup.c: static void cgroup_destroy_root(struct cgroup_root *root)
      	spin_unlock_irq(&css_set_lock);
      
    - 	WARN_ON_ONCE(list_empty(&root->root_list));
    --	list_del(&root->root_list);
    -+	list_del_rcu(&root->root_list);
    - 	cgroup_root_count--;
    + 	if (!list_empty(&root->root_list)) {
    +-		list_del(&root->root_list);
    ++		list_del_rcu(&root->root_list);
    + 		cgroup_root_count--;
    + 	}
      
    - 	if (!have_favordynmods)
    -@@ kernel/cgroup/cgroup.c: static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
    +@@ kernel/cgroup/cgroup.c: static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
    + {
    + 	struct cgroup *res = NULL;
    + 
    +-	lockdep_assert_held(&cgroup_mutex);
    + 	lockdep_assert_held(&css_set_lock);
    + 
    + 	if (cset == &init_css_set) {
    +@@ kernel/cgroup/cgroup.c: static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
      		}
      	}
      
    --	BUG_ON(!res_cgroup);
    +-	BUG_ON(!res);
     +	/*
     +	 * If cgroup_mutex is not held, the cgrp_cset_link will be freed
     +	 * before we remove the cgroup root from the root_list. Consequently,
    @@ kernel/cgroup/cgroup.c: static inline struct cgroup *__cset_cgroup_from_root(str
     +	 * If we don't hold cgroup_mutex in the caller, we must do the NULL
     +	 * check.
     +	 */
    - 	return res_cgroup;
    + 	return res;
      }
      
    -@@ kernel/cgroup/cgroup.c: static struct cgroup *current_cgns_cgroup_dfl(void)
    - static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
    - 					    struct cgroup_root *root)
    - {
    --	lockdep_assert_held(&cgroup_mutex);
    - 	lockdep_assert_held(&css_set_lock);
    - 
    - 	return __cset_cgroup_from_root(cset, root);
    -@@ kernel/cgroup/cgroup.c: static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
    - 
      /*
       * Return the cgroup for "task" from the given hierarchy. Must be
     - * called with cgroup_mutex and css_set_lock held.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

