Return-Path: <stable+bounces-166775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF2B1D81B
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592DF3B8BED
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F932252906;
	Thu,  7 Aug 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEflyT3u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E478254846
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570409; cv=none; b=es9V/E1zWw9Rl0PXDztW3pNiT0r4thpUsSJWX5+tEpubXnVRu8wvE947WjQ++pLD9xoqDgbEZHFVaU2O7MNpvUdBhgrj7OlRzMnlP+QHTRI7IvaJVam2qkylklZpAWN3yiKpx1n3nAhCHsdwkaX56HszzsXCCA3ZTuBZe0p/fJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570409; c=relaxed/simple;
	bh=hs+mTELyq9CfJnkQF6EmKMfKN3YHIlTRDlsK1GHMjvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOnEtSDC2kR2e85mSbIx6DPoW1FwZNe6CkXlxXr/sS+TbZ446wTEwiosW/f8E8tLmNSSpjHZl6bCGHzQa+E1mUMeDRG7XyW2u9mXV42xPy0tzwCivCdAswnjln07tPKkmycvZqxBkhPJtxGDvcLss8aB/ri2g//jLmqtWKQjx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEflyT3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2859C4CEF1;
	Thu,  7 Aug 2025 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754570408;
	bh=hs+mTELyq9CfJnkQF6EmKMfKN3YHIlTRDlsK1GHMjvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEflyT3uYwSv0bGSm38RwXF5qEjO0QTSym9Y7AzV41XVHE5METxKp6OI9SRTGatqT
	 Dc+3lh9K5NmBPCMrtifTbAEm+bMOLmPBs02cNLwhCAvDW19VTJAogb882GDiUAej6F
	 lqLLTIlvPyysPNHiMDo7wxb1mmpVFcBzMMJa4ekUfovdLglH2X1KdCCpkNpq65WtN5
	 VaJPXzAioZ4VonbJEJL8YnW4Tu4/SUo9XQT2+G9CIP35nEy4mIAtlrl1VQfAxGRM8L
	 rZhg7/RgVtQ86DqqCyUw5zOZbLjD8jnGukUWUzsnzDbty8NYWfkthsaka5TtGrY3/6
	 5Xsowm/3MDhYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sumanth.gavini@yahoo.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] gfs2: replace sd_aspace with sd_inode
Date: Thu,  7 Aug 2025 08:40:05 -0400
Message-Id: <1754520137-b1f3231c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805194005.327445-1-sumanth.gavini@yahoo.com>
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

Summary of potential issues:
❌ Patch application failures detected
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: ae9f3bd8259a0a8f67be2420e66bb05fbb95af48

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sumanth Gavini <sumanth.gavini@yahoo.com>
Commit author: Andreas Gruenbacher <agruenba@redhat.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: 67c02d33ab1a)
6.12.y | Present (different SHA1: 271e6bf41afa)

Found fixes commits:
9126d2754c5e gfs2: Don't clear sb->s_fs_info in gfs2_sys_fs_add

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.6.y        | Failed      | N/A        |

