Return-Path: <stable+bounces-108033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C0A06590
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD618891D7
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00511A7264;
	Wed,  8 Jan 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQqbXKrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D022611
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365789; cv=none; b=FARMtwFCXwIR+2+PeQv9vQoYc9m3Gb2BWnOOTm/6lFhjKFRuVskewLgQt+W0Vmdif28h4TDWSSNp0vc6ZRT+hGTsDEq9bHzDUtfzD8BLT/d0bx4+UK5bW6c3mp2Ci+UEJsQXT32IshRyz4L3i2n9DGWA2tEq0/LkdWas5o7CYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365789; c=relaxed/simple;
	bh=ERSC7CgXhHwa0kfLiPF5Qkvd5vjfDHxYqzHaoaKdZw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAtB2cAPbsZVEr5W10fRvVSprx3PiSb9Hu9/AVvsSJiGP31CY+SjNVU0NNYdhzF5/yRgTwsloIv4rVlcuA4NtK9aPn5/Rr/KQeLJp/X4sNuUMpxiX7k/6FNoGmzcKs2Y/z5Y0ivzEuR77kXmhjr0vxlW14aBz9vAthky24fUnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQqbXKrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BBDC4CED3;
	Wed,  8 Jan 2025 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365788;
	bh=ERSC7CgXhHwa0kfLiPF5Qkvd5vjfDHxYqzHaoaKdZw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQqbXKrN/cGzvhNFq0iKXzcurTJ/nOpRjBmGWDj7682OnzGkSCVqL9m9XYhRzf8UB
	 eZiFL39mjeI0Pt68PnGpBmTIB9f9nP3Dl69+kpyIcLEkRv0BzYIOf0qzgsRCjzFyGN
	 kWb+qSACgUD3Trrq+HrmPl1iRjEGtucOGY1IKYv2VCgYWQndCPbJeXsAHltfJLXbw+
	 P6XEpOhynImt5dLYhW8XjmxaEKOPXJT7g9b/pkJcRTrorTbSoBLAaaLpt+LhHXf3nt
	 ev0YvlS0phWJduqlrKP21Ycc/Z+ffARQE0vJzm5uLaz2yguCEorvmhG1gactP11q8F
	 A65Zr53ylnUBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] ceph: give up on paths longer than PATH_MAX
Date: Wed,  8 Jan 2025 14:49:47 -0500
Message-Id: <20250107141116-9da07b060df44667@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250107155010.2658845-1-idryomov@gmail.com>
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

The upstream commit SHA1 provided is correct: 550f7ca98ee028a606aa75705a7e77b1bd11720f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Ilya Dryomov<idryomov@gmail.com>
Commit author: Max Kellermann<max.kellermann@ionos.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 99a37ab76a31)
6.6.y | Present (different SHA1: 82dfe5074a06)

Note: The patch differs from the upstream commit:
---
1:  550f7ca98ee0 ! 1:  092e42aac21a ceph: give up on paths longer than PATH_MAX
    @@ Metadata
      ## Commit message ##
         ceph: give up on paths longer than PATH_MAX
     
    +    commit 550f7ca98ee028a606aa75705a7e77b1bd11720f upstream.
    +
         If the full path to be built by ceph_mdsc_build_path() happens to be
         longer than PATH_MAX, then this function will enter an endless (retry)
         loop, effectively blocking the whole task.  Most of the machine
    @@ Commit message
         Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
         Reviewed-by: Alex Markuze <amarkuze@redhat.com>
         Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
    +    [idryomov@gmail.com: backport to 6.6: pr_warn() is still in use]
     
      ## fs/ceph/mds_client.c ##
     @@ fs/ceph/mds_client.c: char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
    @@ fs/ceph/mds_client.c: char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, s
     +		 * cannot ever succeed.  Creating paths that long is
     +		 * possible with Ceph, but Linux cannot use them.
      		 */
    --		pr_warn_client(cl, "did not end path lookup where expected (pos = %d)\n",
    --			       pos);
    +-		pr_warn("build_path did not end path lookup where expected (pos = %d)\n",
    +-			pos);
     -		goto retry;
     +		return ERR_PTR(-ENAMETOOLONG);
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

