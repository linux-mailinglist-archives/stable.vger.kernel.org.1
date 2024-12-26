Return-Path: <stable+bounces-106119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF289FC756
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A88F1882BF3
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A454C9F;
	Thu, 26 Dec 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZCTfDq5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E744683
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176120; cv=none; b=hlsu3QdncCZFcN0on5VAs/X2AxcRgll0w440uHzT6whFBZx0FPVeyhLsg8HO1qiT4Jmj5PRLiLbKvb/bWhIVVIYyp05siGVCEysRQAE3h5n+PeZV4ApJQevlfmUyAG7NP7rEDQOvpu7OZyP4Dh+6L4jzSKYgqixREhmIx/L6YYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176120; c=relaxed/simple;
	bh=3A/eR3jEDkXd8PnOOWpYA+f7TM5Dzyw34HEziYo7mW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+p2tKS79/o37JAADrgkMFcw+AMRCDUKYv4t2gMR9RRLaYycYUE6/MQBDH586vTIG8rk4vNmnFNmSk/Re+x+ReyzLB45Igonj8lSVNLA0mD4R1iRa7D8MMeXLsHQZtvNOyYGc9T4CAW3PSqCq/+pgO68e3TB4L/zeSfexerb7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZCTfDq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7726C4CED7;
	Thu, 26 Dec 2024 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176120;
	bh=3A/eR3jEDkXd8PnOOWpYA+f7TM5Dzyw34HEziYo7mW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZCTfDq5gC57ni4YmCEU315FhHSov5PU17Q6HzPYgWMwkottOQfVZOQScx2EU6E0a
	 3f9NX7uk0OMb4NKnp6eBDq789Ox4M27rDltl2EA0gy4Bqn8jbDRbXPjSx0vCW+NWeX
	 yCyP7tpiOYDBIkeV/U+iAw6PK7/QfnlzDzfuBjMQKyleGbMyI8UnU37ljlweN+zEMW
	 NBg2LqlgfXd+X4B0HqIKjgv9inIxv7APX/cQOl7GJ/UE/bbv1PRPIzqLdK/1V3l3o/
	 2qkwCKAvtkTPjrDIUSNnwM6GgwQtdxNYoljajM8Vtmh05YNyXSM5tPapfI9G7BRG9C
	 tkt4hfUGoYeOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: trondmy@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] NFSv4.0: Fix the wake up of the next waiter in nfs_release_seqid()
Date: Wed, 25 Dec 2024 20:21:58 -0500
Message-Id: <20241225190038-4af90f3cfafdad8a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
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

Found matching upstream commit: c968fd23c68e9929ab6cad4faffc8ea603e98e5d

WARNING: Author mismatch between patch and found commit:
Backport author: trondmy@kernel.org
Commit author: Trond Myklebust <trond.myklebust@hammerspace.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c968fd23c68e ! 1:  4b6aa0b050af NFSv4.0: Fix the wake up of the next waiter in nfs_release_seqid()
    @@ Commit message
         seqid being removed is at the head of the list, and so is relinquishing
         control of the sequence counter to the next entry.
     
    -    Reviewed-by: Yang Erkun <yangerkun@huawei.com>
         Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
     
      ## fs/nfs/nfs4state.c ##
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

