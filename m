Return-Path: <stable+bounces-111930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD42A24C3E
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90F1188513F
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA2D1534FB;
	Sat,  1 Feb 2025 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1U0w55L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A0126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454040; cv=none; b=doRttv64R2VOX7VSTIPASHg6SbQF/9aYT9v0glAN7aCyyUkBTxMttIh0e3CfrnuRaMyESpYsDu1fbOZm6AOXsgDmvinJF1ldcL1fZbKPuPtdnUTxmWxyDCTWbh/H6N4dELTZbkVSoM37hdsN65ZBYisu8T0d9g28k6PZ6KOcSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454040; c=relaxed/simple;
	bh=veuBZc+RNRSDdZ9JdS/w2c9H/GQUmzaZcO8vqQnh0ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aHveW7ihXTPRbtc8ni/9979j1itW2dvlYRqbcKEDHDFlQoNkugRskoDTwYVL+/m4zDDWJURWLqr+Tm/ce2pQCZt3QOiTBzrCpUsWcsja+0/ZbGZsGotLQmq2FSTHg3MtNMPWIqIFe1/LnrD/svGvyXXp+2E8D42wc16hXW13J8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1U0w55L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E082C4CED3;
	Sat,  1 Feb 2025 23:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454040;
	bh=veuBZc+RNRSDdZ9JdS/w2c9H/GQUmzaZcO8vqQnh0ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1U0w55L3y9iWzdl0f9tzruX8/9qGSMEFr6ArI8dDNU63ng1+fgwIKqsD8VdWbB+L
	 lLI1I2p3S1vJpIJf7HK+66F34yXRs6F1N16uRfo73gfTQ7d7n2EPOAHxtp8Os/tcv/
	 vCvczH8a7KfAAqY3RU5PAaFkXp0d7uRC9Brw3b4/12xqqV+YDTc4dybjKipipXSb0C
	 ofwm+2meYxB5zbkZlr2iGU4p52mpqNEy+Ld3X1MeoBiFXyvNh1YcN1paLdC8zQcl5q
	 Xs+dGD0uBBXw43Lb8kkGHHEr8cfjkUZ2yF/1Oa129OeCw4yaUNwUdLzjwrWPPXaNm4
	 /jX6SUJt6sXCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 07/19] xfs: introduce protection for drop nlink
Date: Sat,  1 Feb 2025 18:53:58 -0500
Message-Id: <20250201135047-caf02998973b5a0e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-8-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 2b99e410b28f5a75ae417e6389e767c7745d6fce

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Cheng Lin<cheng.lin130@zte.com.cn>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 47b07e51d0c2)
6.1.y | Present (different SHA1: 85d34cba11ff)

Note: The patch differs from the upstream commit:
---
1:  2b99e410b28f5 ! 1:  9782c142297e3 xfs: introduce protection for drop nlink
    @@ Metadata
      ## Commit message ##
         xfs: introduce protection for drop nlink
     
    +    [ Upstream commit 2b99e410b28f5a75ae417e6389e767c7745d6fce ]
    +
         When abnormal drop_nlink are detected on the inode,
         return error, to avoid corruption propagation.
     
         Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_inode.c ##
     @@ fs/xfs/xfs_inode.c: xfs_droplink(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

