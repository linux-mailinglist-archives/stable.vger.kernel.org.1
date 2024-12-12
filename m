Return-Path: <stable+bounces-103901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC789EFA18
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88592929D7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB5205517;
	Thu, 12 Dec 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ4EvdI1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33001714BF
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026248; cv=none; b=jzDOH5+irANeNOM7oTYso7C4myblThqz/+PZdfeft68cnoyTwDGu0knnxjGi6m1Y0y6+SgE+Qk49ImtRIn6WAzipFGz3C4MUS2rCNN2nITE51Uw/vIYllQcBDbvCLaA/WD+6zhdo6hcyhajF8vOL4/F4jbrUYSYt6j6jvarzaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026248; c=relaxed/simple;
	bh=+SQypAhAB6QmRhXAOHR+NLPX9Ij88bpMxr6O26jgGO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHFgLRkElW7lhtajaMU1xgmai1JDePAzqOOWrCBsSI7DqFFiILYLjLZwVvR2MXZViR/6nUFNh7iDY1GvrPa2wqRS6/fyJMGbW6KEQ7PRL9qpoCbc+HXg7lp2rndBDQkqjByI9XO0ITfKK6Lh/JI7uxryzewOaQjHH4sVc2sbqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ4EvdI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF7FC4CECE;
	Thu, 12 Dec 2024 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026248;
	bh=+SQypAhAB6QmRhXAOHR+NLPX9Ij88bpMxr6O26jgGO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZ4EvdI1h0EyAcGw8M+pQYrFcHsJPflDFINScCRhMwJ3yacFtybmgA7rByKzz/PQN
	 lq6gHsgsCHo4inXKyxOQXSamts/9tDxvyXS3n3cnIVuwU1YmqM08bDM7AkEbf3vQ5r
	 V/fy6R2RRSCaDiwMf2Pl2NqiLvjPVCxuy4JjvOIT501QmMMo/DoexEtNR/QHSRNVL9
	 xZ4BY/i15Lo0h94IK9ktXXfT+XJILHO340b9BAJA8nMw7n2LH93qcTSz4gVahjyYmd
	 5W1drVlCUOvdGNAnmUFAvqrVadwQECjZ7U6y5B7Blbd9HEYdh8mErEyioBNk507jQU
	 RrRzKWySd2o6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] mm: call the security_mmap_file() LSM hook in remap_file_pages()
Date: Thu, 12 Dec 2024 12:57:26 -0500
Message-ID: <20241212064417-9def5aeee31ae590@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241212032639.3020089-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: ea7e2d5e49c05e5db1922387b09ca74aa40f46e2

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Shu Han <ebpqwerty472123@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 49d3a4ad57c5)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea7e2d5e49c05 ! 1:  6fdcac73c2ec9 mm: call the security_mmap_file() LSM hook in remap_file_pages()
    @@ Metadata
      ## Commit message ##
         mm: call the security_mmap_file() LSM hook in remap_file_pages()
     
    +    [ Upstream commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2 ]
    +
         The remap_file_pages syscall handler calls do_mmap() directly, which
         doesn't contain the LSM security check. And if the process has called
         personality(READ_IMPLIES_EXEC) before and remap_file_pages() is called for
    @@ Commit message
         Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
         [PM: subject line tweaks]
         Signed-off-by: Paul Moore <paul@paul-moore.com>
    +    [ Resolve merge conflict in mm/mmap.c. ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## mm/mmap.c ##
     @@ mm/mmap.c: SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
    @@ mm/mmap.c: SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long
     +	if (ret)
     +		goto out_fput;
      	ret = do_mmap(vma->vm_file, start, size,
    - 			prot, flags, 0, pgoff, &populate, NULL);
    + 			prot, flags, pgoff, &populate, NULL);
     +out_fput:
      	fput(file);
      out:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

