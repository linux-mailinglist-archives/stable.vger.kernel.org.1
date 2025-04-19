Return-Path: <stable+bounces-134713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F428A94361
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D568A3148
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515FF1C84C7;
	Sat, 19 Apr 2025 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAoNiVOC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF98259C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745065175; cv=none; b=f+FI6pucdO//uRqadfWTLYT+vjGIhbk11sVojYKpiaK1B0D5BdlbQP1mN+mthT0DUuc+S5iL/muw2fkK/tLP5Rcs9O/gDiH2/EGaYHyinlhEJMzURTz3596QVCYHnwXHGy1hdU1pOUPDSLc+b2j7vhkDB3xHLPvRVJzCUh0CA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745065175; c=relaxed/simple;
	bh=/xYFvR23ASTDPjTFL7YVdZqgktDEE4mSLrPpu8j04rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkyJ9yqDvV+dGPLee4bjebgPMvP0m7up0BtWIuRGAhaow68TBW10CX83fPlZZTCIwx0ft78imfITyiy4HN1nprCr/T/dBWFcNU+kJ01dfo0OIcG4dTJBN55sJ2ZKSCvP5Fp2HkFIKGn0fFUtAtLJCpGSo1RCF8ppb4ThobhDEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAoNiVOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFCDC4CEE7;
	Sat, 19 Apr 2025 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745065174;
	bh=/xYFvR23ASTDPjTFL7YVdZqgktDEE4mSLrPpu8j04rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAoNiVOCvmMdaHYMPHaqXE0YwVYiTkDMTNS+7Z/zBlAV5P09m+sgbh3FvSjOGs6tv
	 qVf5rY+HtcVoqJPOOBjlu4JcVNJh6zmO664I3Fn0PsR3oVp2JIs6l2ymIaAv8GOMYZ
	 spMdXWJ5o1teIEh23MVBa2ypS3kPa8SA+vJY8tELefyo3cFtgmi05EdplusGhaz9kd
	 f4cW8d3rVvLCGOGP1MfwUmosS45mI8Yz2vYUE4SDK0xxa/qG865lU3mM5tU3nDQ0jB
	 oatHM0Vg3JY6YRCKcosUztf0Htu3GZbgkb1hkxmQmBZA7PY8oJTS6sbIpZssEsrGG2
	 1ZKy96qWa5JYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 2/2] md: fix mddev uaf while iterating all_mddevs list
Date: Sat, 19 Apr 2025 08:19:32 -0400
Message-Id: <20250419081136-34ad419abdc11548@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250419012303.85554-3-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 8542870237c3a48ff049b6c5df5f50c8728284fa

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 5462544ccbad)
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8542870237c3a ! 1:  dd49667d64662 md: fix mddev uaf while iterating all_mddevs list
    @@ Metadata
      ## Commit message ##
         md: fix mddev uaf while iterating all_mddevs list
     
    +    commit 8542870237c3a48ff049b6c5df5f50c8728284fa upstream.
    +
         While iterating all_mddevs list from md_notify_reboot() and md_exit(),
         list_for_each_entry_safe is used, and this can race with deletint the
         next mddev, causing UAF:
    @@ Commit message
         Closes: https://lore.kernel.org/all/Z7Y0SURoA8xwg7vn@bender.morinfr.org/
         Signed-off-by: Yu Kuai <yukuai3@huawei.com>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    [skip md_seq_show() that is not exist]
    +    Signed-off-by: Yu Kuai <yukuai3@huawei.com>
     
      ## drivers/md/md.c ##
     @@ drivers/md/md.c: static void __mddev_put(struct mddev *mddev)
    @@ drivers/md/md.c: static void __mddev_put(struct mddev *mddev)
      void mddev_put(struct mddev *mddev)
      {
      	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
    -@@ drivers/md/md.c: static int md_seq_show(struct seq_file *seq, void *v)
    - 	if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
    - 		status_unused(seq);
    - 
    --	if (atomic_dec_and_test(&mddev->active))
    --		__mddev_put(mddev);
    --
    -+	mddev_put_locked(mddev);
    - 	return 0;
    - }
    - 
     @@ drivers/md/md.c: EXPORT_SYMBOL_GPL(rdev_clear_badblocks);
      static int md_notify_reboot(struct notifier_block *this,
      			    unsigned long code, void *x)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

