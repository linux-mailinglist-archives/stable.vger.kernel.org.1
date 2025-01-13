Return-Path: <stable+bounces-108537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1064A0C531
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA27165A6F
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAA1F9F5F;
	Mon, 13 Jan 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYoJU6r5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C01FA15D
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809739; cv=none; b=bLdlD+Mh1q2IUEKkqKC16WznOgPkSjRkG9cV0c7GUsJMxq16ZBVOP4kNzMKGktrHpNTZ7lpeIkkcuWUrmXTzesDsJP8bR2moV5ceqcBi+33zcQGva8rf/2pBjB33uWpPHeBQNycwFyjnHElEENxbgQzkhDrPIQV6P0B2sFJvGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809739; c=relaxed/simple;
	bh=tShjpp39Ve+NxUDA/CSe2L1CLO+UEMz9mbcN7D/xmqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFI0odJNZhZpV7ujUIv5QJlGsrAs/0v70JxR3qgSCvexBLE4EDGgbada6G2p79XG6CYwHYI7JEU5nATZsKTg/cwtPjhRvqT8qVhWCCJMVjZAxWvG8jH+x9iTAfy6eBjp23XcDjFWt26vnbJ99cS4XJxvX0PrnJwT2K6P5Tf4rH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYoJU6r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B39C4CED6;
	Mon, 13 Jan 2025 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809738;
	bh=tShjpp39Ve+NxUDA/CSe2L1CLO+UEMz9mbcN7D/xmqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYoJU6r57xP0W3le0MUU5ZJOs0OqRTH7hmgCj55Y2rkh90IxywBs2r8aedf/xWrro
	 MGtc0bzcjB6F8l0MFIqrs/XV2k/JSkAkg/4D0emMhEeJilXDd7qyn1d3bB/ul1u5eM
	 pp+SVI1nOP77YWkMfY1VgCwkbFbLt4UHScNpSGRVPIlCZ8afbkiOFVqpdAFYsvwqhi
	 6r8qeJp6vy6TxC8o7c/s+v5UKju7YF+w+n92uTjz5N8LCqybJ5+AqY+T6snbUoDFzD
	 bZSZ0s21hPCUgNTVXD6zB5Mw6XRL+Kr1uiem7ms7Ykby2KemEZ9QKsrsfGTENBAjcP
	 ySnWR/WGeiOew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] scsi: sg: Fix slab-use-after-free read in sg_release()
Date: Mon, 13 Jan 2025 18:08:56 -0500
Message-Id: <20250113154914-d677dbd3643494e5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_F25BABE1B0C2A434C8D316D5147CD849FE0A@qq.com>
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

The upstream commit SHA1 provided is correct: f10593ad9bc36921f623361c9e3dd96bd52d85ee

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Suraj Sonawane<surajsonawane0215@gmail.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 1f5e2f1ca587)
6.6.y | Present (different SHA1: 59b30afa5786)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f10593ad9bc3 ! 1:  7c77aeeb186d scsi: sg: Fix slab-use-after-free read in sg_release()
    @@ Metadata
      ## Commit message ##
         scsi: sg: Fix slab-use-after-free read in sg_release()
     
    +    commit f10593ad9bc36921f623361c9e3dd96bd52d85ee upstream.
    +
         Fix a use-after-free bug in sg_release(), detected by syzbot with KASAN:
     
         BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30
    @@ Commit message
         Link: https://lore.kernel.org/r/20241120125944.88095-1-surajsonawane0215@gmail.com
         Reviewed-by: Bart Van Assche <bvanassche@acm.org>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## drivers/scsi/sg.c ##
     @@ drivers/scsi/sg.c: sg_release(struct inode *inode, struct file *filp)
    - 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp, "sg_release\n"));
      
      	mutex_lock(&sdp->open_rel_lock);
    + 	scsi_autopm_put_device(sdp->device);
     -	kref_put(&sfp->f_ref, sg_remove_sfp);
      	sdp->open_cnt--;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

