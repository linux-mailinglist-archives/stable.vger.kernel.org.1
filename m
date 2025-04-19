Return-Path: <stable+bounces-134712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D0A94360
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1CB8A310E
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5319E96D;
	Sat, 19 Apr 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLWUB00C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C43259C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745065173; cv=none; b=oNA/RQEC1ECYzKSNkpUDlFVF4a3J6Kzpomq+7b+iyPlqSz3lFnUsAHTreTIjPHY3gHyFQ1OJP3YSvOgxG/02M8RQVvgZSUvIVVUti5L16zwyfPQZedEgCXevTQcreXVAuPLwChiV8AJUaA9igLJI1IsFUzpA95VvCLlTVKoCB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745065173; c=relaxed/simple;
	bh=Qe2UfCk994QuEFFQhMiby/kQfCXNehUpeGGU9Qc+YBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh/6wRcPBhFSJfyFsZa0VJe8Cw7+0dZcT+thrJUKTSquQTIvO0CW3MxgYXQoTKHa2Nz79Vi0nBsPic3t9YggUAz8i5yry+4uUV7Qo9Gxcl59h0V1qoLxIHY4DjkBprQ7DXGaOgs6tJykY2ZqR1eZwF9BS4+5DMdqrNVr3RNLVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLWUB00C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BBFC4CEE7;
	Sat, 19 Apr 2025 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745065172;
	bh=Qe2UfCk994QuEFFQhMiby/kQfCXNehUpeGGU9Qc+YBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLWUB00CpJoAT2vm5fxNa7YDC4bWIWXC3xolPxUBrl/6km3Gk2vaEoOa1zn23XEfQ
	 /34LjQK2Ot7InNfbAlwgIGwaO2Ew7XwV4Hi9nB8MsSNH9Pq0s4yZnsrK3iLhuQXjdd
	 DS3oM3PVf1+9wqyZZH2b/YY2Uyee3rETLcaZu5VJR0fGuHPEQTrZtWLANNErA6p1tD
	 T6NVP/LBZf6GRJ2paK+VSYNixjiTlfzHD8e9nRvA/+M46dFujBablxs1S9GiwAuZvm
	 9csizAibFxOO77HlYTI+oj8bTgB/ji54HKMv1FyHMk/YDhruryd5w7FtXoLv1rNBrY
	 HFBsWfh+HeR1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/2] md: factor out a helper from mddev_put()
Date: Sat, 19 Apr 2025 08:19:30 -0400
Message-Id: <20250419080717-ed4d6ead98db5c3b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250419012303.85554-2-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 3d8d32873c7b6d9cec5b40c2ddb8c7c55961694f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 452f50807917)

Note: The patch differs from the upstream commit:
---
1:  3d8d32873c7b6 ! 1:  c3ea0d86c3059 md: factor out a helper from mddev_put()
    @@ Metadata
      ## Commit message ##
         md: factor out a helper from mddev_put()
     
    +    commit 3d8d32873c7b6d9cec5b40c2ddb8c7c55961694f upstream.
    +
         There are no functional changes, prepare to simplify md_seq_ops in next
         patch.
     
         Signed-off-by: Yu Kuai <yukuai3@huawei.com>
         Signed-off-by: Song Liu <song@kernel.org>
         Link: https://lore.kernel.org/r/20230927061241.1552837-2-yukuai1@huaweicloud.com
    +    [minor context conflict]
    +    Signed-off-by: Yu Kuai <yukuai3@huawei.com>
     
      ## drivers/md/md.c ##
     @@ drivers/md/md.c: static inline struct mddev *mddev_get(struct mddev *mddev)
    @@ drivers/md/md.c: static inline struct mddev *mddev_get(struct mddev *mddev)
     +	 * Call queue_work inside the spinlock so that flush_workqueue() after
     +	 * mddev_find will succeed in waiting for the work to be done.
     +	 */
    ++	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
     +	queue_work(md_misc_wq, &mddev->del_work);
     +}
     +
    @@ drivers/md/md.c: static inline struct mddev *mddev_get(struct mddev *mddev)
     -		/* Array is not configured at all, and not held active,
     -		 * so destroy it */
     -		set_bit(MD_DELETED, &mddev->flags);
    - 
    +-
     -		/*
     -		 * Call queue_work inside the spinlock so that
     -		 * flush_workqueue() after mddev_find will succeed in waiting
     -		 * for the work to be done.
     -		 */
    +-		INIT_WORK(&mddev->del_work, mddev_delayed_delete);
     -		queue_work(md_misc_wq, &mddev->del_work);
     -	}
     +	__mddev_put(mddev);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

