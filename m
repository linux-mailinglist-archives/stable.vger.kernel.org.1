Return-Path: <stable+bounces-124254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E4A5EF36
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03D517DAEC
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F73262D27;
	Thu, 13 Mar 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERD5f/Tl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33043159
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857106; cv=none; b=AJLs1yZHP4DxKiNGbkjgfggb4gxAXpwfYvR2nhcJGRiArc6L+adv5fSjyfTdFU9EQx2xrm9s/5ap+/Zm+HDLCLPULb1JMui9RzDCZTCVJOWNqHcNH1rmxSHm4TxhtguRKLtWJBzcWe/qcMQ/MWnpi5J615U+Pjd9w7kwCyUv1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857106; c=relaxed/simple;
	bh=H0dC6sxGDUpqAu+3/HAQd+Psvp3CoVtknUt6mNf8QpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfEMXp4I9jf4keH4TxYI4wY/6K98t3Qf778Car0CG2TgzH+tu2udslzjP56wXDrqgWjmdg7FeNkIxv2eGp/+JjxuVvMdms14Q2cUJsTPWk6OfKqZBUWBZR4zwaw4xcTFYLNGJfG2TKKk+mZtiA7LI1tJTyvtt/KFofKjdaGILZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERD5f/Tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC358C4CEDD;
	Thu, 13 Mar 2025 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857106;
	bh=H0dC6sxGDUpqAu+3/HAQd+Psvp3CoVtknUt6mNf8QpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERD5f/Tl5dh1tKL0w+8VZaSLkU4KwV3Vv65m7DkMWT7fjqy7zrCxY4wAfKCi21exQ
	 I9cVNmtgI9yjnTTENg/gMNd8BhWvnqhMqP/bl56k6OD9guGxM5kzBiDnbbQJlo+qDf
	 1zVADxbb8PoIi3gTsf4yNoyWFjMoW8erUXBsTgO6ulRkm2QmhKdQbThUa9ZsSthbTz
	 cFgq0tyWioR+EDYXt8Fxbt6Fc9wNL5LDneCC2Jx7C16arv4L8Z4lAW9QqjJxMU9lCu
	 q+aHWRiJbvBtDGTq17pO8OTtpVsBFEbGDUgPUduEBzElXO5ztimoBHs7UvNfVmzyse
	 YDGe0Qq/ryC0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] zram: fix NULL pointer in comp_algorithm_show()
Date: Thu, 13 Mar 2025 05:11:44 -0400
Message-Id: <20250312233739-1edd18e0fe8227d0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311003949.3927527-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: f364cdeb38938f9d03061682b8ff3779dd1730e5

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Liu Shixin<liushixin2@huawei.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 843d366ff197)

Note: The patch differs from the upstream commit:
---
1:  f364cdeb38938 ! 1:  ececa37568222 zram: fix NULL pointer in comp_algorithm_show()
    @@ Metadata
      ## Commit message ##
         zram: fix NULL pointer in comp_algorithm_show()
     
    +    [ Upstream commit f364cdeb38938f9d03061682b8ff3779dd1730e5 ]
    +
         LTP reported a NULL pointer dereference as followed:
     
          CPU: 7 UID: 0 PID: 5995 Comm: cat Kdump: loaded Not tainted 6.12.0-rc6+ #3
    @@ Commit message
         Cc: Jens Axboe <axboe@kernel.dk>
         Cc: Minchan Kim <minchan@kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    [This fix does not backport zram_comp_params_reset which was introduced after
    +     v6.6, in commit f2bac7ad187d ("zram: introduce zcomp_params structure")]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/block/zram/zram_drv.c ##
     @@ drivers/block/zram/zram_drv.c: static int zram_add(void)
      	zram->disk->private_data = zram;
      	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
    - 	atomic_set(&zram->pp_in_progress, 0);
    -+	zram_comp_params_reset(zram);
    -+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
      
    ++	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
    ++
      	/* Actual capacity set using sysfs (/sys/block/zram<id>/disksize */
      	set_capacity(zram->disk, 0);
    + 	/* zram devices sort of resembles non-rotational disks */
     @@ drivers/block/zram/zram_drv.c: static int zram_add(void)
      	if (ret)
      		goto out_cleanup_disk;
      
    --	zram_comp_params_reset(zram);
     -	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
     -
      	zram_debugfs_register(zram);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

