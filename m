Return-Path: <stable+bounces-110054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E02A185D3
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22376188B39E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F3D1F4E50;
	Tue, 21 Jan 2025 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOfKvGLy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81651EB2F
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489162; cv=none; b=HFQZ2lJHr7YIS0I4Fs19RCErlFc92hZhjGl2JGh4odYfxtHKzNQjbptE4mKnnW9IdgXM0JM8jCKKtg7LEhNt0ijoL4i4uuoB8smfvBjcFrgnenbp5PNfi+tsx23hzVmOinCJmt5E4p9rQKr+KSafSSna4hM2u+u9JbZdAAuBybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489162; c=relaxed/simple;
	bh=AyyFEcvog/xNMAfrVVXD9cgH6xxjAv8kdujkkLFnLXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y98CDHBebS9dp4qjFGCAT9JUClZyub/msK3+Fpem+PC9b28Dax0alOKT4Tx6nTXXfZB4toPZIOT/PQzp7P3u7l5MC+i6/k2G906nzVzd+OG9cjyQkIssqEfH/6ftsQxfwMfiTIMWDZVXK+5Akioe3GquknyVre0F88PWtwRX6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOfKvGLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5A8C4CEDF;
	Tue, 21 Jan 2025 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489162;
	bh=AyyFEcvog/xNMAfrVVXD9cgH6xxjAv8kdujkkLFnLXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOfKvGLy83gENLZo5bOivwZcHwTozmVQix8NTd545Oalt/0JylPQFp9ObuvPn+W1c
	 QriiDGDVPRa1aipQ6oRlLOANWNt5XK/tzqN5m+dSbx2PR5DbiVFjLKxwdBJ8elHTzM
	 cbAfdjZmzdKnMj79bPoW/FPHRoOS/wxxGaqqwSdYwpYuM1qnMdGkY5Sg6gCJ/U2MHe
	 uhaX/4KgiW/xfu9XikpstjvFgfc0B8w08CFD9DAj+0Ay8BnN2oMiHpVXI/xach6jH+
	 0VYPmkJ6qTIk7HCKZP9cZsMTvDAB0wUPBfmDmEJVd3OuN3rTUT9kgHrbkZClKJ3q21
	 kQoVmU1dJchmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hsimeliere.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1-v5.4] scsi: sg: Fix slab-use-after-free read in sg_release()
Date: Tue, 21 Jan 2025 14:52:40 -0500
Message-Id: <20250121122350-735f0951dcfbdf8e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250121141509.201877-1-hsimeliere.opensource@witekio.com>
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
Backport author: hsimeliere.opensource@witekio.com
Commit author: Suraj Sonawane<surajsonawane0215@gmail.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 1f5e2f1ca587)
6.6.y | Present (different SHA1: 59b30afa5786)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f10593ad9bc36 ! 1:  6931ce4ecfe44 scsi: sg: Fix slab-use-after-free read in sg_release()
    @@ Metadata
      ## Commit message ##
         scsi: sg: Fix slab-use-after-free read in sg_release()
     
    +    [ Upstream commit f10593ad9bc36921f623361c9e3dd96bd52d85ee ]
    +
         Fix a use-after-free bug in sg_release(), detected by syzbot with KASAN:
     
         BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30
    @@ Commit message
         Link: https://lore.kernel.org/r/20241120125944.88095-1-surajsonawane0215@gmail.com
         Reviewed-by: Bart Van Assche <bvanassche@acm.org>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
     
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
| stable/linux-5.4.y        |  Success    |  Success   |

