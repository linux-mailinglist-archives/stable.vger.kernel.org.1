Return-Path: <stable+bounces-105238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593B9F6F22
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A1216E10E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A1161311;
	Wed, 18 Dec 2024 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOqV2Qov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AD15697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555679; cv=none; b=mCqiWQLxndiVHQiolJK49B5lF3K0IT6uyzN7HakDmz6aA/LkFs2z+aRpI72BsgoOPxGh3R6/3LCv9uASnk2+5CFI6wKVBUUly+fXyy6DzG5r0NvVGxt5tLs3H6FvkAnMmbb74m+0DNVXJppNjKVK5/cH38o/QCZ/U0Tnzeq9apM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555679; c=relaxed/simple;
	bh=mQXJldFRrHYlo32dUCXYGNGqaDnCljBZK2Y/Fan3RDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1RHvD9YprmCESDlZdSJn7lXgJbF6sHfFthNCpuww1+XeKrZYRmSTLGGqErJcTx6rt3Ver7u+9aI9M5geGK17TgqgCezeOYaqaXvks0NaPmEOocPQ6GAkbYqFiTan83dYrgLWi7/7YwHyubJv3eEMoF6TFs7hOhoFWatFnZ5k1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOqV2Qov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BB9C4CED0;
	Wed, 18 Dec 2024 21:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555679;
	bh=mQXJldFRrHYlo32dUCXYGNGqaDnCljBZK2Y/Fan3RDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOqV2Qovz8GomUqYzNB14jgZMQBJC4fgfgN6NcK0Lse//rYKAsqW95kuJFa9p1qCv
	 8v5NlVhhjRrjPKsw+ZidJ9WRgZfZXnf42bTeLr5WtbgZFm1knVHIOcb/CRULO+YFWm
	 p0uJVmuxA1Kk/9VsofvfuR71rk9ZbJOeL9yQVf2XbjL9DN/Aj1qh6kdmypQ7aFfB57
	 L5pqDkBTiJLAPXjNFC/bKTMeEWl3JkzdcfqFICf2Wr/dCQC1+Cu9i602wBC+NT0lHE
	 T/GChl+NkYoyzwe6ZxG0vQ1RDmMlAUWFYJ/NI5Kj7+AiWgsHYO6X81SipPaKU0KqHO
	 GocBM7SdjyCjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 09/17] xfs: convert comma to semicolon
Date: Wed, 18 Dec 2024 16:01:17 -0500
Message-Id: <20241218154003-f2680119a28a6fab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-10-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: 7bf888fa26e8f22bed4bc3965ab2a2953104ff96

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Chen Ni <nichen@iscas.ac.cn>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7bf888fa26e8 ! 1:  0a7d90d411d7 xfs: convert comma to semicolon
    @@ Metadata
      ## Commit message ##
         xfs: convert comma to semicolon
     
    +    commit 7bf888fa26e8f22bed4bc3965ab2a2953104ff96 upstream.
    +
         Replace a comma between expression statements by a semicolon.
     
         Fixes: 178b48d588ea ("xfs: remove the for_each_xbitmap_ helpers")
         Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/scrub/agheader_repair.c ##
     @@ fs/xfs/scrub/agheader_repair.c: xrep_agfl_init_header(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

