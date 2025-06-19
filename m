Return-Path: <stable+bounces-154772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C849AE015B
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C318B3B1B40
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874C327AC28;
	Thu, 19 Jun 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft8F4EoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815125DAF7
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323855; cv=none; b=kij6z33GWnPQJt+CNO7Dh0Ck8sxkl0HYpps10DD1DAZED0D/SENvXbJuYy9u8imRWBoC7WLmITozbsGc5yhcT3+ZEJPRW4ww7fak4d2RouPtJLGJKXWpmikDtBF7USdLtoXdb8LHRes6APKGu5KkjzpUivb3MLpvduVwwT4bGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323855; c=relaxed/simple;
	bh=qOKlyO9MyEyW+4UJFlboumCFW+jUU7ijK3XVlS/rc0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmlVeJdRV7PjT06nDtH/ShcgYoxTNmTWRnlcLwLCXppw/fPsZGO6Hw5x3Zje1Nj3nxOhK+X3a1dODwoEmrTU+dXS6m87qAoHmR9j4iQOfyqD6adOWMdmA4Q04qDKhkY9T9TOS6Z/tNfWs2MVMrafWcDTkQNUsWTxJOSxWiEmbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft8F4EoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AFBC4CEEA;
	Thu, 19 Jun 2025 09:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323854;
	bh=qOKlyO9MyEyW+4UJFlboumCFW+jUU7ijK3XVlS/rc0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ft8F4EoYJypAtIao1pgyThBm6WpDIckzxdseHuDLSOFSYBBa1Tv716o8434UymnDw
	 c2JIPn8BhP0pjYTPzroxlIGZ0lHpYf1UJZD7ZaSVkvAVcCoGb1/ujBfwQKnemacNz0
	 XVOXv4QA2hFJQBnibwSmeQ5hNgub0/FzKF9TanlOt791t5g/M7K2SM3xxrOKBh5i0N
	 IyhKNirfN5ZALdhKR0+4mrEvKrcK7oKxMatxiAUdf48Gn+8Q03/pVrHHgMiQ1ZxE4s
	 K7UmFmjDOuwme+K9w9NSebSY1knRMpzEF2Kfl0YWE8QqKxVk+wTsGCtGNYOn3R8J5V
	 wkPe5U3TnejnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 2/2] ext4: avoid remount errors with 'abort' mount option
Date: Thu, 19 Jun 2025 05:04:13 -0400
Message-Id: <20250618164314-a5cf2a6f46e973f1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617210956.146158-3-amir73il@gmail.com>
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

The upstream commit SHA1 provided is correct: 76486b104168ae59703190566e372badf433314b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Amir Goldstein<amir73il@gmail.com>
Commit author: Jan Kara<jack@suse.cz>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 26cc5063e3c2)
6.6.y | Present (different SHA1: 6c63de9b4d0e)
6.1.y | Present (different SHA1: dfc2eb29016f)

Note: The patch differs from the upstream commit:
---
1:  76486b104168a ! 1:  73557e9fd536a ext4: avoid remount errors with 'abort' mount option
    @@
      ## Metadata ##
    -Author: Jan Kara <jack@suse.cz>
    +Author: Amir Goldstein <amir73il@gmail.com>
     
      ## Commit message ##
         ext4: avoid remount errors with 'abort' mount option
     
    +    [ Upstream commit 76486b104168ae59703190566e372badf433314b ]
    +
    +    [amir: backport to 5.15.y pre new mount api]
    +
         When we remount filesystem with 'abort' mount option while changing
         other mount options as well (as is LTP test doing), we can return error
         from the system call after commit d3476f3dad4a ("ext4: don't set
    @@ Commit message
         Tested-by: Jan Stancek <jstancek@redhat.com>
         Link: https://patch.msgid.link/20241004221556.19222-1-jack@suse.cz
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    +    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
     
      ## fs/ext4/super.c ##
    -@@ fs/ext4/super.c: static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
    +@@ fs/ext4/super.c: static int ext4_remount(struct super_block *sb, int *flags, char *data)
      		goto restore_opts;
      	}
      
    @@ fs/ext4/super.c: static int __ext4_remount(struct fs_context *fc, struct super_b
      	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
      		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
      
    -@@ fs/ext4/super.c: static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
    - 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
    - 		ext4_stop_mmpd(sbi);
    +@@ fs/ext4/super.c: static int ext4_remount(struct super_block *sb, int *flags, char *data)
    + 	 */
    + 	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
      
     +	/*
     +	 * Handle aborting the filesystem as the last thing during remount to
    @@ fs/ext4/super.c: static int __ext4_remount(struct fs_context *fc, struct super_b
     +	if (test_opt2(sb, ABORT))
     +		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
     +
    - 	return 0;
    - 
    - restore_opts:
    + 	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s. Quota mode: %s.",
    + 		 orig_data, ext4_quota_mode(sb));
    + 	kfree(orig_data);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

