Return-Path: <stable+bounces-145952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51DAC0200
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467369E164C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417CA3F9FB;
	Thu, 22 May 2025 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWMdcFw4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA81758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879430; cv=none; b=bWJDYQFF8oPNXulqq+TAMqvlBh61YaI1ncHn221B9WmU9UUqXdlXSPx1e1maTN/PM5iPvHyWIr8feK+6sYfw8jaKVdtmW3C3asJtxEBqooYsb3Vr1qKWTT60pc7xdw1n9WtzLpuxP2hLh+2MN7QvQ7pnrB/nHm+zPwKy4cD9PGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879430; c=relaxed/simple;
	bh=RmTy86hXCE1em91f5HeQMaEgJWiIAwjqcDa4X3lNAUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd1aHo6vJ3jEEvj0TA06NkZY8sILBB0lE2Bqwv8JFRYhgze46qltueMHUToZ4l3amjIrGNiJPxioqo85fFIbkydySDUTHlPlmJoStdbl0PsJRUFdb35tTAQ0SEGiOgQy9cFEGYUccnM+z35/AhzgNkePR+MTSzuUbRIR5ByoKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWMdcFw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6975EC4CEE4;
	Thu, 22 May 2025 02:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879429;
	bh=RmTy86hXCE1em91f5HeQMaEgJWiIAwjqcDa4X3lNAUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWMdcFw4rMCIYo5OFbcNmPeMssgMZBcBKOpajQeNSRHp9p14LLFw3eMBBv/X4Pk+6
	 t31H7pZ6T3P50/na2r8ICO64Du3z2/XbGYsWWY0Ys+Eaye3xXkKbTRVa4ROIEqobeX
	 hUIKdzR0FaaTSvVpvA6ZJhqEvtgQGjLaLu7oN2bFPEw+057AX1FB0U84IJq+epDnpU
	 2dPY7DAy4KBa2tWAcD5pt8nvaMIvc6T244HjRlrJojhcXAlwgZq3lZbgITeNAVK+OG
	 IfMkZav/CHgWUtApyddvDu/TRWj3otyrJVNhFyOjuDU5xD7tER4j+/fjumWlbpB7TH
	 1+uHyAYF79cmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qingfang Deng <dqfext@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 3/5] kernfs: switch kernfs to use an rwsem
Date: Wed, 21 May 2025 22:03:47 -0400
Message-Id: <20250521154443-367c6fc07dc3045a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521015336.3450911-4-dqfext@gmail.com>
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

The upstream commit SHA1 provided is correct: 7ba0273b2f34a55efe967d3c7381fb1da2ca195f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Qingfang Deng<dqfext@gmail.com>
Commit author: Ian Kent<raven@themaw.net>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  7ba0273b2f34a ! 1:  a0418b6d194c8 kernfs: switch kernfs to use an rwsem
    @@ Metadata
      ## Commit message ##
         kernfs: switch kernfs to use an rwsem
     
    +    Commit 7ba0273b2f34a55efe967d3c7381fb1da2ca195f upstream.
    +
         The kernfs global lock restricts the ability to perform kernfs node
         lookup operations in parallel during path walks.
     
    @@ fs/kernfs/dir.c
     -DEFINE_MUTEX(kernfs_mutex);
     +DECLARE_RWSEM(kernfs_rwsem);
      static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
    - static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
    - static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
    + /*
    +  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
     @@ fs/kernfs/dir.c: static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
      
      static bool kernfs_active(struct kernfs_node *kn)
    @@ fs/kernfs/dir.c: static void kernfs_drain(struct kernfs_node *kn)
      }
      
      /**
    +@@ fs/kernfs/dir.c: static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
    + 		/* If the kernfs parent node has changed discard and
    + 		 * proceed to ->lookup.
    + 		 */
    +-		mutex_lock(&kernfs_mutex);
    ++		down_read(&kernfs_rwsem);
    + 		spin_lock(&dentry->d_lock);
    + 		parent = kernfs_dentry_node(dentry->d_parent);
    + 		if (parent) {
    + 			if (kernfs_dir_changed(parent, dentry)) {
    + 				spin_unlock(&dentry->d_lock);
    +-				mutex_unlock(&kernfs_mutex);
    ++				up_read(&kernfs_rwsem);
    + 				return 0;
    + 			}
    + 		}
    + 		spin_unlock(&dentry->d_lock);
    +-		mutex_unlock(&kernfs_mutex);
    ++		up_read(&kernfs_rwsem);
    + 
    + 		/* The kernfs parent node hasn't changed, leave the
    + 		 * dentry negative and return success.
    +@@ fs/kernfs/dir.c: static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
    + 	}
    + 
    + 	kn = kernfs_dentry_node(dentry);
    +-	mutex_lock(&kernfs_mutex);
    ++	down_read(&kernfs_rwsem);
    + 
    + 	/* The kernfs node has been deactivated */
    + 	if (!kernfs_active(kn))
    +@@ fs/kernfs/dir.c: static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
    + 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
    + 		goto out_bad;
    + 
    +-	mutex_unlock(&kernfs_mutex);
    ++	up_read(&kernfs_rwsem);
    + 	return 1;
    + out_bad:
    +-	mutex_unlock(&kernfs_mutex);
    ++	up_read(&kernfs_rwsem);
    + 	return 0;
    + }
    + 
     @@ fs/kernfs/dir.c: int kernfs_add_one(struct kernfs_node *kn)
      	bool has_ns;
      	int ret;
    @@ fs/kernfs/dir.c: static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *p
     -	lockdep_assert_held(&kernfs_mutex);
     +	lockdep_assert_held_read(&kernfs_rwsem);
      
    - 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
    - 	spin_lock_irq(&kernfs_rename_lock);
    + 	spin_lock_irq(&kernfs_pr_cont_lock);
    + 
     @@ fs/kernfs/dir.c: struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
      {
      	struct kernfs_node *kn;
    @@ fs/kernfs/dir.c: struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *
      
      	return kn;
      }
    -@@ fs/kernfs/dir.c: static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
    - 		/* If the kernfs parent node has changed discard and
    - 		 * proceed to ->lookup.
    - 		 */
    --		mutex_lock(&kernfs_mutex);
    -+		down_read(&kernfs_rwsem);
    - 		spin_lock(&dentry->d_lock);
    - 		parent = kernfs_dentry_node(dentry->d_parent);
    - 		if (parent) {
    - 			if (kernfs_dir_changed(parent, dentry)) {
    - 				spin_unlock(&dentry->d_lock);
    --				mutex_unlock(&kernfs_mutex);
    -+				up_read(&kernfs_rwsem);
    - 				return 0;
    - 			}
    - 		}
    - 		spin_unlock(&dentry->d_lock);
    --		mutex_unlock(&kernfs_mutex);
    -+		up_read(&kernfs_rwsem);
    - 
    - 		/* The kernfs parent node hasn't changed, leave the
    - 		 * dentry negative and return success.
    -@@ fs/kernfs/dir.c: static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
    - 	}
    - 
    - 	kn = kernfs_dentry_node(dentry);
    --	mutex_lock(&kernfs_mutex);
    -+	down_read(&kernfs_rwsem);
    - 
    - 	/* The kernfs node has been deactivated */
    - 	if (!kernfs_active(kn))
    -@@ fs/kernfs/dir.c: static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
    - 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
    - 		goto out_bad;
    - 
    --	mutex_unlock(&kernfs_mutex);
    -+	up_read(&kernfs_rwsem);
    - 	return 1;
    - out_bad:
    --	mutex_unlock(&kernfs_mutex);
    -+	up_read(&kernfs_rwsem);
    - 	return 0;
    - }
    - 
     @@ fs/kernfs/dir.c: static struct dentry *kernfs_iop_lookup(struct inode *dir,
      	struct inode *inode = NULL;
      	const void *ns = NULL;
    @@ fs/kernfs/dir.c: int kernfs_remove_by_name_ns(struct kernfs_node *parent, const
     +	down_write(&kernfs_rwsem);
      
      	kn = kernfs_find_ns(parent, name, ns);
    - 	if (kn)
    - 		__kernfs_remove(kn);
    + 	if (kn) {
    +@@ fs/kernfs/dir.c: int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
    + 		kernfs_put(kn);
    + 	}
      
     -	mutex_unlock(&kernfs_mutex);
     +	up_write(&kernfs_rwsem);
    @@ fs/kernfs/inode.c: int kernfs_setattr(struct kernfs_node *kn, const struct iattr
      	return ret;
      }
      
    -@@ fs/kernfs/inode.c: int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
    +@@ fs/kernfs/inode.c: int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
      	if (!kn)
      		return -EINVAL;
      
     -	mutex_lock(&kernfs_mutex);
     +	down_write(&kernfs_rwsem);
    - 	error = setattr_prepare(&init_user_ns, dentry, iattr);
    + 	error = setattr_prepare(dentry, iattr);
      	if (error)
      		goto out;
    -@@ fs/kernfs/inode.c: int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
    - 	setattr_copy(&init_user_ns, inode, iattr);
    +@@ fs/kernfs/inode.c: int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
    + 	setattr_copy(inode, iattr);
      
      out:
     -	mutex_unlock(&kernfs_mutex);
    @@ fs/kernfs/inode.c: int kernfs_iop_setattr(struct user_namespace *mnt_userns, str
      	return error;
      }
      
    -@@ fs/kernfs/inode.c: int kernfs_iop_getattr(struct user_namespace *mnt_userns,
    +@@ fs/kernfs/inode.c: int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
      	struct inode *inode = d_inode(path->dentry);
      	struct kernfs_node *kn = inode->i_private;
      
    @@ fs/kernfs/inode.c: int kernfs_iop_getattr(struct user_namespace *mnt_userns,
     -	mutex_unlock(&kernfs_mutex);
     +	up_write(&kernfs_rwsem);
      
    - 	generic_fillattr(&init_user_ns, inode, stat);
    + 	generic_fillattr(inode, stat);
      	return 0;
    -@@ fs/kernfs/inode.c: int kernfs_iop_permission(struct user_namespace *mnt_userns,
    +@@ fs/kernfs/inode.c: int kernfs_iop_permission(struct inode *inode, int mask)
      
      	kn = inode->i_private;
      
    @@ fs/kernfs/inode.c: int kernfs_iop_permission(struct user_namespace *mnt_userns,
     -	mutex_unlock(&kernfs_mutex);
     +	up_write(&kernfs_rwsem);
      
    - 	return generic_permission(&init_user_ns, inode, mask);
    + 	return generic_permission(inode, mask);
      }
     
      ## fs/kernfs/kernfs-internal.h ##
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

