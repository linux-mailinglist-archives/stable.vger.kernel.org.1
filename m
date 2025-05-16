Return-Path: <stable+bounces-144626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EBDABA2BE
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4DB179030
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515327AC33;
	Fri, 16 May 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBMUaR5J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8A19938D
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420011; cv=none; b=GL3YdkpVmgkILQan4EXmsktO569e6JOF+FAZ/9poIzxdZfnCSVo/RAULhxbmM++SlDFzsWXuAfSDzkGWuM8/43QIFWUzvJCZznHbf5bLgpl3oufhFoGXnhU37oNnOudh6jRrX+33fpAEwuEXqeTVHPLlFsd8wyNnwFpKtGCI6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420011; c=relaxed/simple;
	bh=6XZYS2fftLhJuPVenmjusaMbzB+KF8Cw1m/egu7M/aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRJkaAn3kp2dyUMeFynMzPoSQo61bpf20N/5KUZGyRCZhBFT5veN2jEnkEVMu1a2fBckG8i1Okhk184xKMvtei92rP6zncV82WW4OOpCmSPr1tPHo1kGIPeTKVBcUfED5s9QSAdpKBHGQJrFVbAkiHBPLS3fg9SOER/O75FpMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBMUaR5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70929C4CEE4;
	Fri, 16 May 2025 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747420010;
	bh=6XZYS2fftLhJuPVenmjusaMbzB+KF8Cw1m/egu7M/aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBMUaR5JrDoO12rRFvZsI+Rdm/b58BjKvIgUuvBqL6C9Xt9VoYc+SHyzy2+rmjUfA
	 Bq5OPmlDNtNoeiK3HyQPbrYrG4hn6X4cWWYkZ3UKOqvvncCQcM7EwMDa579UkJh+rp
	 O0T5VRQGmYf92MEke7n2jsHUT76jqGVCPRTpFhXXpE0rlbRGi96haNoIdtglI9AyxL
	 Tj6a7g5nSuUOk4IXrJcpA4xHE/5Bgwj6ld2d3iZPQciYFoAad0j7yVLhtiHY4sS2SM
	 d0CfafT255EGvQMqHg2MU61s3S9A1RT93gktefjtDlk3+3fm6vYyVIzrtmh/9q2Byr
	 ZV7lEt4m7pSJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs: relax assertions on failure to encode file handles
Date: Fri, 16 May 2025 14:26:49 -0400
Message-Id: <20250516113604-f3756a310ee0dfb4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516005329.1343966-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  974e3fe0ac61d ! 1:  0b03c1f28e522 fs: relax assertions on failure to encode file handles
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
     @@ fs/overlayfs/copy_up.c: struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

