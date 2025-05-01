Return-Path: <stable+bounces-139370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D22AA6385
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD0F1BA849A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332232253EC;
	Thu,  1 May 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO/P/9N0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695D2248A0
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126602; cv=none; b=CHc7hd+iJgrjy8Pea7goRmTb2w5gFKjwY4ukE8wstNnhlkxHA1BYWWk6ot8ZkgfC/b2ZKcEFL/OZqHZhf7oByKynR5mEXXAVgu5Aewqef5IOQ3168G1c0OiQmW3UJwNpKv2M0MHdq+F2R1UqRdGjxq0hZ/kKRiyHyl1bmCvXuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126602; c=relaxed/simple;
	bh=y8MX2ccI461J1L0wen7sCr6W4aTK7c5X9tjtlEl0Bgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKiuLREl4XmdmHVARihsSbRAgRlrTTOUutnQiYFIdO/jtayI1tCD/SEehylTu7vpvgySO2Vwr3YrmtB+z6V/27EHlcIV+2tbkX/yDpCTrVHanmhVUHSiFgEFb6VXvKhwnshcDSkbLjDazP/fvXH0FtmscX01UCa0B4U/ekKqm1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO/P/9N0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D62C4CEE9;
	Thu,  1 May 2025 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126601;
	bh=y8MX2ccI461J1L0wen7sCr6W4aTK7c5X9tjtlEl0Bgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QO/P/9N0vcVh/cTQKXbD70G258CPjJaXlLAvdNRfnv7+knKpiQUAxQ3WnmSH1cmL3
	 FHbBQPBcYER4lENLEe0LA2ylsFRNx67O4Ni7ojJqXUJh5G2pnVVKxVxIDSnKQkkkhA
	 r/aOggEFvk36skT5c1QoBL8eJOOhEjjZLzZVcc7m+pBVnfYC7Rm9x8AlAC+VOIxTzG
	 bpvhyayPE/O3mPYHv8nEvStFYJUOjnRvf0aq1crPVQiG144jn28kdyuA+TCdd6+n5L
	 aNPUI/QcT1frZxgShUTduZ6VQy3wxsTp6csvpDx4HTBTTJw4l42ZCBka1G1hSkXNNk
	 yaSnCVumsYxOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 12/16] xfs: allow symlinks with short remote targets
Date: Thu,  1 May 2025 15:09:56 -0400
Message-Id: <20250501130518-f483590f7d251da9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-13-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 38de567906d95c397d87f292b892686b7ec6fbc3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0aca73915dc1)

Note: The patch differs from the upstream commit:
---
1:  38de567906d95 ! 1:  a037bc2828645 xfs: allow symlinks with short remote targets
    @@ Metadata
      ## Commit message ##
         xfs: allow symlinks with short remote targets
     
    +    [ Upstream commit 38de567906d95c397d87f292b892686b7ec6fbc3 ]
    +
         An internal user complained about log recovery failing on a symlink
         ("Bad dinode after recovery") with the following (excerpted) format:
     
    @@ Commit message
         Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_inode_buf.c ##
     @@ fs/xfs/libxfs/xfs_inode_buf.c: xfs_dinode_verify_fork(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

