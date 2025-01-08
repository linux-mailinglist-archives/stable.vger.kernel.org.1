Return-Path: <stable+bounces-108030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B6CA0658D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D80E168098
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895081A7264;
	Wed,  8 Jan 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEs/bb/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790222611
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365783; cv=none; b=gW5FXdcnJJa56Us5cQayzOs+eATHtIaxu1GEnEab8DYLlMIsytTEd/va3vmpQCR6r6PxNSoFrFUpRfGzi/jWP8E2JoGjzonzBl4Ha6DyjMjvlGKcefduTjARdAW2yd29ZxT/4rXrcATzzZwB+yQjXMxA0SF5ylcnN1ffXsBKxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365783; c=relaxed/simple;
	bh=n7OTdfq/HJN5okRJcbseacDq4gAIHjWNvksVWsou0uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3ozJ6P/HiQRsEudLRD0l6nblOZ6ncIkWhgyBxilt9fuEqaeh16evDlYJSe8pytrHQ3Y7SecegNzrEk6vbQZGzxhpTM7B7gAeWH0apO6Duthqquw/xzMrlM+/EDePmdxgmC9+drvCfU6qhlgJsHzWlThaUcipjzeHPGYY3xq6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEs/bb/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE92C4CED3;
	Wed,  8 Jan 2025 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365781;
	bh=n7OTdfq/HJN5okRJcbseacDq4gAIHjWNvksVWsou0uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEs/bb/dG5ewQpR9NPGTH5tbObHZtnu/EOvStrrtxjK+IpGk+ISbw9HE/yBTowZSP
	 nJ6NwF7d+hRmmwty8Sv8e/rjVmNaOpI0lldJmCqA7YY/vwp7sSoO22FBclwz+W7hlU
	 pjDRiSU3VrCynb1LA80ZQPwG6kogJVkUe4M1Y+GBxNRCCyYEabJXaj7yDX5YQBgMBO
	 fWpa9QVZ6X2ugM5r8EG7ClGPSDDYrkkRWMXoGv3n73CZzKWXIE8ACAch7I4iJZYYEV
	 Au1pQ1pwnpsd7P525fLLMxx+C15ngdYLmteeJ7GzBFwQEU5lhuuf/3XqQns/7uVdTB
	 prloy57znQeug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10-6.1] ceph: give up on paths longer than PATH_MAX
Date: Wed,  8 Jan 2025 14:49:39 -0500
Message-Id: <20250107140401-381359c489155c44@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250107154818.2658618-1-idryomov@gmail.com>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  550f7ca98ee0 ! 1:  9c81f6f042e7 ceph: give up on paths longer than PATH_MAX
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
    +    [idryomov@gmail.com: backport to 6.1: pr_warn() is still in use]
     
      ## fs/ceph/mds_client.c ##
    -@@ fs/ceph/mds_client.c: char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
    +@@ fs/ceph/mds_client.c: char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
      
      	if (pos < 0) {
      		/*
    @@ fs/ceph/mds_client.c: char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, s
     +		 * cannot ever succeed.  Creating paths that long is
     +		 * possible with Ceph, but Linux cannot use them.
      		 */
    --		pr_warn_client(cl, "did not end path lookup where expected (pos = %d)\n",
    --			       pos);
    +-		pr_warn("build_path did not end path lookup where "
    +-			"expected, pos is %d\n", pos);
     -		goto retry;
     +		return ERR_PTR(-ENAMETOOLONG);
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Success   |

Build Errors:
Build error for stable/linux-6.1.y:
    bash: line 1: cd: /home/sasha/build/linus-next: No such file or directory

