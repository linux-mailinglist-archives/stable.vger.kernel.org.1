Return-Path: <stable+bounces-144627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAFABA2BF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED3417E33B
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D2227AC46;
	Fri, 16 May 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiNiKgSC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5C19938D
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420013; cv=none; b=QqGCiaoVmiSmlpIVxdYBDqAl+Ks9AqdcuIA8znidu8ROCVKXdMmAZAB8jUG7fx8F87bak32VdORNZkQykc3NT8KlVRIDkSJhYz5Nd/Fzb3rhPixtYykh8Tf0oAJ3rglPNb5n5ZnZmnb/53FEDxzfk36/5ec2zgc0RSe1mYTimjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420013; c=relaxed/simple;
	bh=9VhGCekkyxpxS4N7P4zZkQXKvyS0Ep5vY7v5Wj1CNPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIK9l36SFNshCmW33tNlkPb4391Cb+H7lLP8ob1E7AdNZKwccdWBp1BdqMBGdGsKV0N7h5YuWZJblEnE//unQn/jiobPT1eXTDpltDkOhBcMMyWJzlh3JFRQ4QRoHC5hnEPLOMr3CvOLrWoJWfiWy0SFM/WSGzomsCp+DZYtFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiNiKgSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EDEC4CEED;
	Fri, 16 May 2025 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747420012;
	bh=9VhGCekkyxpxS4N7P4zZkQXKvyS0Ep5vY7v5Wj1CNPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiNiKgSCCUrgKp2F7HC37xs4b/8LarLcqw7ckuxZrvxn0xWY9nOnYRFQpG1Hvh4vZ
	 oqOD+d5Eb4ZjMYA94Vd/i60tYX8iPPdJMgJrgsCxl8bFy77F5Yluv1kmdCinX953H3
	 hnRUIjXW8SkyvenZ4raS5xl8CI+soQzIDDgHOxuDYbLpg/1LlxV/2Fzp53H4sl6BL0
	 7dKth3O0TLpDrhtDfU9nHEkHGxwL0MbrJiENycLzJcDxGRlYllFQhkENOy8xT0sROQ
	 i6xHLlTk1RMR4neUjo1CT7J4WutP3wA/F+VD3PtzsAu4aRwXBLe/Paa9C6x41ydyTe
	 Kuk2yj4LS0Ebg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] fs: relax assertions on failure to encode file handles
Date: Fri, 16 May 2025 14:26:51 -0400
Message-Id: <20250516112303-ef8c8750ddc4dd7d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516010604.1344396-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 974e3fe0ac61de85015bbe5a4990cf4127b304b2

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Amir Goldstein<amir73il@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: adcde2872f8f)
6.6.y | Present (different SHA1: f47c834a9131)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  974e3fe0ac61d ! 1:  e03b9715a3d01 fs: relax assertions on failure to encode file handles
    @@ Metadata
      ## Commit message ##
         fs: relax assertions on failure to encode file handles
     
    +    commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
    +
         Encoding file handles is usually performed by a filesystem >encode_fh()
         method that may fail for various reasons.
     
    @@ Commit message
         Signed-off-by: Amir Goldstein <amir73il@gmail.com>
         Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
         Signed-off-by: Christian Brauner <brauner@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/notify/fdinfo.c ##
     @@ fs/notify/fdinfo.c: static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
    - 	size = f->handle_bytes >> 2;
    + 	size = f.handle.handle_bytes >> 2;
      
    - 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
    + 	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
     -	if ((ret == FILEID_INVALID) || (ret < 0)) {
     -		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
     +	if ((ret == FILEID_INVALID) || (ret < 0))
      		return;
     -	}
      
    - 	f->handle_type = ret;
    - 	f->handle_bytes = size * sizeof(u32);
    + 	f.handle.handle_type = ret;
    + 	f.handle.handle_bytes = size * sizeof(u32);
     
      ## fs/overlayfs/copy_up.c ##
    -@@ fs/overlayfs/copy_up.c: struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
    +@@ fs/overlayfs/copy_up.c: struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
      	buflen = (dwords << 2);
      
      	err = -EIO;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

