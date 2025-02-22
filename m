Return-Path: <stable+bounces-118661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 754CCA40993
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCDB1710C1
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D21C84D8;
	Sat, 22 Feb 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7C5rtT5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE069D2B
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239609; cv=none; b=mUq9yQkwX3nIPRvLU5/XebHZuI5ZfRssavWNLEK24VasrqjyIjp7OVcRqmsNMIknqDTxlsK7B27xDn4jumSAj1g+FLIGf7u7ZWrLYmkJQk0XB4Ruq7SCYM08KtSZUxBXgw9xrVtZpyc1duHsZz/y+mpDb7bvo9FP5j9xTI95jYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239609; c=relaxed/simple;
	bh=Dq9SY3JwAMa5iqG/eYDQr/5fu2e32gmK5jJguB1+UPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ5YyQ4/mg+rPLj479D9hC+l1pljIbX/GJrSzb1OzNEWTq6p1qiXd58O5lGCgr4RVPlZztvVvk0g1FfaINcilswzIVZJaS2KVT2t6cHfhFqfm183YuBeVPu8o5302InXerVHO83DsdOvToOYQthur1RAktFuyDIexGwXw+zK9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7C5rtT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20098C4CED1;
	Sat, 22 Feb 2025 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239608;
	bh=Dq9SY3JwAMa5iqG/eYDQr/5fu2e32gmK5jJguB1+UPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7C5rtT5ok29MjE1QiBjDb343bv2zcfrB+EknnZqfU1Sbs7/VE8BqIuN2VwWfU9eq
	 Nhm8sz/EYzide43WUfvqX222QPVwgspps/wz5+wQffM8VnY0ip8CQTrovDTTEPflza
	 HHEhnwwoyGZ605avRHGeYtnu0k56Ynsgi+KF11SaqVA1CJ4hYgLIVMbyptLkthpsGM
	 2j184s39HVIGwVS5XJt3T9rRIQ2yTWOrYyLIEx+7MfpYr/k0PuHc+6htmNfxSCmxZh
	 7/42DaBzLJb+Ud6S8TOJskGL+J6VA3s9AUlITP9ZC0DEjS+pP2Js/cn7NgpHNe8/NX
	 CKU+a9UgNVMgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/3] nilfs2: eliminate staggered calls to kunmap in nilfs_rename
Date: Sat, 22 Feb 2025 10:53:26 -0500
Message-Id: <20250222104458-0079f273804719f4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221133848.4335-3-konishi.ryusuke@gmail.com>
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

Summary of potential issues and notes:
ℹ️ This is part 2/3 of a series

The upstream commit SHA1 provided is correct: 8cf57c6df818f58fdad16a909506be213623a88e

Note: The patch differs from the upstream commit:
---
1:  8cf57c6df818f ! 1:  810716ff8329b nilfs2: eliminate staggered calls to kunmap in nilfs_rename
    @@ Metadata
      ## Commit message ##
         nilfs2: eliminate staggered calls to kunmap in nilfs_rename
     
    +    commit 8cf57c6df818f58fdad16a909506be213623a88e upstream.
    +
         In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
         with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
         path.
    @@ Commit message
         Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
         Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
     
      ## fs/nilfs2/namei.c ##
     @@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

