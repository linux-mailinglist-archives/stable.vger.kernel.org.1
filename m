Return-Path: <stable+bounces-132861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C25A90639
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BDC47A723C
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628C1B4140;
	Wed, 16 Apr 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaArd4c0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E71AA1EC
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813479; cv=none; b=hppsoVfWFlVEYkkXuHRk43EVbXAb58LgAqTYrojZFLwwRwZeBcrAzxm6bk9Ljzq0ifrBA6pr7/n5V14eU44z5UfcSkoWgz1G5ToHxISq59fGUssk0SHueqvTi3JsSvN3VA+2WIAc6CECCR1qjqnIWN1gBt6ilaEEOPykfRZ7J3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813479; c=relaxed/simple;
	bh=7NNKwPoyt2ZzMxHTzv4dlNI221IYYDUxpfNUMrunNxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2AqYizu/Qx8t3Na4k/TYQf0qO6+uT9C8DGnZjyMg86+7O8xXJGMjfOrbEOrdAWurvb3jhHILBG19EEhG3YIcAsKqXYB9x9QZAHyxB94F5V/A4sLfhIXKraOsJB/gmcECiD5647Xsz+FYxKI4BQCqWSiz5DJKiFoVCBp1nywb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaArd4c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1363CC4CEE2;
	Wed, 16 Apr 2025 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813478;
	bh=7NNKwPoyt2ZzMxHTzv4dlNI221IYYDUxpfNUMrunNxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaArd4c0TbtEhAjfwxuUA6A9d5F1Lo/NO0Sw1tFg4M3gHNFtFZuJ2N2rjnuBZSPuB
	 GyiJZ0jnxZMaD3FjOBIFCIPLa81cQEo6q4sOQiLf/8Hn8Z121OyoqlMsMhWlT/h0Jx
	 W8AJIu6+qOxFFYd+FbVhHfKh03wwOB8SG6Pte2PgtU4pxcIPRwsLY1pqjPpfiX58mi
	 JTKiOy5+pi/UddcFNTJggYMvC6FvH5dlmdzXj0fAMaXAMrqtaofreSZA7YKvu1EUZH
	 L5IYVBYwzeiROuNpQfh6NNAACnSrOprU/gQ3hgX0OBNXl07NL5ijnzCtQzD6jH9c+X
	 t/6UzLpxcIIzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15/5.10] scsi: ufs: bsg: Set bsg_queue to NULL after removal
Date: Wed, 16 Apr 2025 10:24:36 -0400
Message-Id: <20250416094011-ed9b5902c7a2bb3a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416013633.449339-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 1e95c798d8a7f70965f0f88d4657b682ff0ec75f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Guixin Liu<kanie@linux.alibaba.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 9193bdc170cc)
6.12.y | Present (different SHA1: 88a01e9c9ad4)
6.6.y | Present (different SHA1: 5f782d4741bf)
6.1.y | Present (different SHA1: 5e7b6e44468c)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1e95c798d8a7f ! 1:  be0ecc3eb507b scsi: ufs: bsg: Set bsg_queue to NULL after removal
    @@ Metadata
      ## Commit message ##
         scsi: ufs: bsg: Set bsg_queue to NULL after removal
     
    +    [ Upstream commit 1e95c798d8a7f70965f0f88d4657b682ff0ec75f ]
    +
         Currently, this does not cause any issues, but I believe it is necessary to
         set bsg_queue to NULL after removing it to prevent potential use-after-free
         (UAF) access.
    @@ Commit message
         Link: https://lore.kernel.org/r/20241218014214.64533-3-kanie@linux.alibaba.com
         Reviewed-by: Avri Altman <avri.altman@wdc.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/ufs/core/ufs_bsg.c ##
    -@@ drivers/ufs/core/ufs_bsg.c: void ufs_bsg_remove(struct ufs_hba *hba)
    + ## drivers/scsi/ufs/ufs_bsg.c ##
    +@@ drivers/scsi/ufs/ufs_bsg.c: void ufs_bsg_remove(struct ufs_hba *hba)
      		return;
      
      	bsg_remove_queue(hba->bsg_queue);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |

