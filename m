Return-Path: <stable+bounces-124910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC0A68A81
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2411B6065E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D783202C47;
	Wed, 19 Mar 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCtmty+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13C2AEED
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382167; cv=none; b=szL0H3KHvsf8dpQ9F/+EDn/lFdh8VK3ylL2/XkKPuQ8ArMDjD05MY6ZSThFD1jHPv+x7mNtlRb3LkSB9MshOZNYMSdjc1hTcY1Ja9pzcOVJ544U8b1ReiXvRGTjApjz4xdhYBNKmQpJiRAQueRRC3umwZJLsNFB4JiysYZgYFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382167; c=relaxed/simple;
	bh=N1ko33Y76Ns05fD5tzlHyCtxkRCix7eMOQXaFOiw5Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrpCczsYl0yDYmJUPRXw/A74RS//EdA3e/pbCgHziOMVZ1JcjEAoU7FOkMD1LnjGtwkReMff8mJGQLj8PlvvVskfolxSO3hYh/CcOn4ZeF4HUi/F+r5N7eeLLWOcmFxjOS32qWBzumDOqbpRyFbOlFSgNikdRRUmrkkyCMPirUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCtmty+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56383C4CEEA;
	Wed, 19 Mar 2025 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742382166;
	bh=N1ko33Y76Ns05fD5tzlHyCtxkRCix7eMOQXaFOiw5Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCtmty+ec6tZu8cJgukTuIpeBmrxkx6xz0HLcaWiitfAbAHJtXioBA4h4sXep8wSh
	 SZSmVXjBnCwtW686999KnATGi80l7Js11Z+isaIjydGrakzovG/wEokQAmk3wZ4B8P
	 owccCsTWuyC+zzMRCyfFCtK7pvorStaaWYKhukIly7zwSANFNZmrZBPeFTXBoGf4I2
	 bHixhJ5PVqxJ8IwVu94m5zk2eueGqYTYjOV9waN4MTDU+RI/6RDus7VPCKWyBbEhLa
	 5C3KtaN6wUIN5b7GfqjR83HdCSREGnVAcmuD547WqALLfbXjQUon7vSVBG8TX5oT3R
	 Q039bc86M1jWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	donghua.liu@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: prevent use-after-free due to open_cached_dir error paths
Date: Wed, 19 Mar 2025 07:02:45 -0400
Message-Id: <20250319070153-8cb1672a2748b3b4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250319090839.3631424-1-donghua.liu@windriver.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: a9685b409a03b73d2980bbfa53eb47555802d0a9

WARNING: Author mismatch between patch and found commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Paul Aurich<paul@darkrain42.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 47655a12c6b1)
6.6.y | Present (different SHA1: 791f83305357)

Note: The patch differs from the upstream commit:
---
1:  a9685b409a03b ! 1:  94e68b9a81ffa smb: prevent use-after-free due to open_cached_dir error paths
    @@ Commit message
         Cc: stable@vger.kernel.org
         Signed-off-by: Paul Aurich <paul@darkrain42.org>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    [ Do not apply the change for cfids_laundromat_worker() since there is no
    +      this function and related feature on 6.1.y. Update open_cached_dir()
    +      according to method of upstream patch. ]
    +    Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## fs/smb/client/cached_dir.c ##
     @@ fs/smb/client/cached_dir.c: int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
    - 	SMB2_query_info_free(&rqst[1]);
    - 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
    - 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
    -+out:
    + 		/*
    + 		 * We are guaranteed to have two references at this point.
    + 		 * One for the caller and one for a potential lease.
    +-		 * Release the Lease-ref so that the directory will be closed
    +-		 * when the caller closes the cached handle.
    ++		 * Release one here, and the second below.
    + 		 */
    + 		kref_put(&cfid->refcount, smb2_close_cached_fid);
    + 	}
      	if (rc) {
    - 		spin_lock(&cfids->cfid_list_lock);
    - 		if (cfid->on_list) {
    -@@ fs/smb/client/cached_dir.c: int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
    - 			/*
    - 			 * We are guaranteed to have two references at this
    - 			 * point. One for the caller and one for a potential
    --			 * lease. Release the Lease-ref so that the directory
    --			 * will be closed when the caller closes the cached
    --			 * handle.
    -+			 * lease. Release one here, and the second below.
    - 			 */
    - 			cfid->has_lease = false;
    --			spin_unlock(&cfids->cfid_list_lock);
    - 			kref_put(&cfid->refcount, smb2_close_cached_fid);
    --			goto out;
    - 		}
    - 		spin_unlock(&cfids->cfid_list_lock);
    --	}
    --out:
    --	if (rc) {
     -		if (cfid->is_open)
     -			SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
     -				   cfid->fid.volatile_fid);
     -		free_cached_dir(cfid);
    -+
    +-		cfid = NULL;
    ++		cfid->has_lease = false;
     +		kref_put(&cfid->refcount, smb2_close_cached_fid);
    - 	} else {
    - 		*ret_cfid = cfid;
    - 		atomic_inc(&tcon->num_remote_opens);
    + 	}
    + 
    + 	if (rc == 0) {
     @@ fs/smb/client/cached_dir.c: void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
      		cfids->num_entries--;
      		cfid->is_open = false;
    @@ fs/smb/client/cached_dir.c: int cached_dir_lease_break(struct cifs_tcon *tcon, _
      			cfid->time = 0;
      			/*
      			 * We found a lease remove it from the list
    -@@ fs/smb/client/cached_dir.c: static void cfids_laundromat_worker(struct work_struct *work)
    - 			cfid->on_list = false;
    - 			list_move(&cfid->entry, &entry);
    - 			cfids->num_entries--;
    --			/* To prevent race with smb2_cached_lease_break() */
    --			kref_get(&cfid->refcount);
    -+			if (cfid->has_lease) {
    -+				/*
    -+				 * Our lease has not yet been cancelled from the
    -+				 * server. Steal that reference.
    -+				 */
    -+				cfid->has_lease = false;
    -+			} else
    -+				kref_get(&cfid->refcount);
    - 		}
    - 	}
    - 	spin_unlock(&cfids->cfid_list_lock);
    -@@ fs/smb/client/cached_dir.c: static void cfids_laundromat_worker(struct work_struct *work)
    - 		 * with it.
    - 		 */
    - 		cancel_work_sync(&cfid->lease_break);
    --		if (cfid->has_lease) {
    --			/*
    --			 * Our lease has not yet been cancelled from the server
    --			 * so we need to drop the reference.
    --			 */
    --			spin_lock(&cfids->cfid_list_lock);
    --			cfid->has_lease = false;
    --			spin_unlock(&cfids->cfid_list_lock);
    --			kref_put(&cfid->refcount, smb2_close_cached_fid);
    --		}
    --		/* Drop the extra reference opened above */
    -+		/*
    -+		 * Drop the ref-count from above, either the lease-ref (if there
    -+		 * was one) or the extra one acquired.
    -+		 */
    - 		kref_put(&cfid->refcount, smb2_close_cached_fid);
    - 	}
    - 	queue_delayed_work(cifsiod_wq, &cfids->laundromat_work,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

