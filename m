Return-Path: <stable+bounces-111933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492DA24C41
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9403F3A4955
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897291CD21E;
	Sat,  1 Feb 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzmKdLLj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776F126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454046; cv=none; b=khTNq45g3SYSLicFn85JcSHWXC/bCnQykgxjUnl2PugzY1HLP8MnNxI83DMIoNC51j7nVl4M29Cm86h3gf+k+owTNpxr4MPfAQ0aDYrlVvi8hj9bHRrLQGPWQ8GW7ao0/7JZTGNpjSnVHuB+KuullJmkrr+zk552/6xu+CseF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454046; c=relaxed/simple;
	bh=AtbRpxITq2+2QEo66yryQdl1+6uQu4AGam4tKN6H4NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUWBobacI9LgkA3grWlfGEU3AE+D+Vo6dH6pzrr03utskdo0W68+a66zFsoHMk5Oh54c76r1P/RuUEaCHe8E5moZw3oFg7mstAJp6G2TutE+3PsLbzr8Nm8knwdzbZ7g7z7fhBQljxaH8OedfrqbLu/bRf7VJTB2RFW/ZSEAykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzmKdLLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92E1C4CED3;
	Sat,  1 Feb 2025 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454046;
	bh=AtbRpxITq2+2QEo66yryQdl1+6uQu4AGam4tKN6H4NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzmKdLLjmGfnU8Xuirq4JURpz0U3VzZu2hJsPYgXQIVGPE23pq7Tz9mmYNIih2qzK
	 hiXkM3ydgcXnwhW233BSWfdRPv9HzcZ/IvD4u0rdizWjVQygv8jRn8pJuOQKk+f3V4
	 r/IigPg8K/q6Fy+nucOjteOa1bf1fOiUgNjPfDF2wu1gJg+jUPN2J0lAYbASlbqlCf
	 VMli3gQ7svxw6JoDIRLwHOvrOjg/ethgJaFs9PjJrX2eXzGiR5dKHO+whzF1VD2HAU
	 S6awk+GGngczLsp9pCabIowQBg+4PWPJ5F3vz7PW/vRf2c+HmOk7iIsbCIH003FgYC
	 LgeheD8K3ZEYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 10/19] xfs: factor out xfs_defer_pending_abort
Date: Sat,  1 Feb 2025 18:54:04 -0500
Message-Id: <20250201141452-88574661d0d68d95@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-11-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 2a5db859c6825b5d50377dda9c3cc729c20cad43

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Long Li<leo.lilong@huawei.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 23f3d79fc983)
6.1.y | Present (different SHA1: d28caa7f7c3b)

Note: The patch differs from the upstream commit:
---
1:  2a5db859c6825 ! 1:  79526dfb16ec1 xfs: factor out xfs_defer_pending_abort
    @@ Metadata
      ## Commit message ##
         xfs: factor out xfs_defer_pending_abort
     
    +    [ Upstream commit 2a5db859c6825b5d50377dda9c3cc729c20cad43 ]
    +
         Factor out xfs_defer_pending_abort() from xfs_defer_trans_abort(), which
         not use transaction parameter, so it can be used after the transaction
         life cycle.
    @@ Commit message
         Signed-off-by: Long Li <leo.lilong@huawei.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/libxfs/xfs_defer.c ##
     @@ fs/xfs/libxfs/xfs_defer.c: xfs_defer_create_intents(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

