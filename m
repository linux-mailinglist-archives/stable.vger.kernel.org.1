Return-Path: <stable+bounces-171712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B3CB2B655
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56CC1B27CF9
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0E61F4C9F;
	Tue, 19 Aug 2025 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqzauv0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42D1F4285
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567281; cv=none; b=Cdlfp3gVFGEnQ4ZjZ+E2WIASE2GsfBsihw0mBSMMAv03KVi5nRMPl0m9IOT/gLTFqxagnfkBJajroMdQxD9cT2Yf5Tj4IMfgt6xECCz/0jhOqpoXxacYKis+AU5Ja44aSMi3aDfJxhsV2jk6q5Yoea0tnWPxrYeVp5vnKq80cPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567281; c=relaxed/simple;
	bh=YqsfQAnZCC1qodRbWwI48+pPZDGygW0CG2SQq2DJPo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c59+5PtC7D/CiZA82WniAENuQ2O6d8W16Cl88+ShAA38UDefWRh80vYyP+mdgDxPcWXgNczxo/jpB7mS0c2TAcZ1vHNd1jJEuQYoetyTbF2h1J2LXR2ez2JssOOP0VzzLt5HYi5wdf+ijuJFeMn2+xX/JnSomN3pc3LTVOeT1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqzauv0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EB0C16AAE;
	Tue, 19 Aug 2025 01:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755567281;
	bh=YqsfQAnZCC1qodRbWwI48+pPZDGygW0CG2SQq2DJPo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dqzauv0To9ccRnJciAD878xnGP79yStQ82lUtV7QSk8T15SGTYhqeFc3JRL7osaF6
	 4sd/2JoFAG3A5bEqxGkvyavo+go5rpueffvMbA0MznmyQzxSfm4doEV2TWUMlm9H11
	 kfEUuWsCE7E6p2QX+KKpiIEZUWWr9LU1XOL8T+rB2at/pZ2thlqypizsbkgkc9qHqc
	 xs0Fi7RiItNPveTNnufE7pJEddcti9VDNmz+/NFpuljSTQUZ5mrmNImJcTMhtFFYTs
	 z6kLbNOD81ftydeyesA8sjgB7JcP3OXaHO1t36Ag2qRrjhyyMgLCl4h2tRc0Ym7rg6
	 sQJF3rrVdbHaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alan Huang <mmpgouride@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 5/5] xfs: Remove unused label in xfs_dax_notify_dev_failure
Date: Mon, 18 Aug 2025 21:34:34 -0400
Message-ID: <20250819013434.249383-5-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819013434.249383-1-sashal@kernel.org>
References: <2025081857-glitter-hummus-4836@gregkh>
 <20250819013434.249383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Huang <mmpgouride@gmail.com>

[ Upstream commit 8c10b04f9fc1760cb79068073686d8866e59d40f ]

Fixes: e967dc40d501 ("xfs: return the allocated transaction from xfs_trans_alloc_empty")
Signed-off-by: Alan Huang <mmpgouride@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_notify_failure.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 14024fb4feea..6853a7e45ebd 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -351,7 +351,6 @@ xfs_dax_notify_dev_failure(
 			error = -EFSCORRUPTED;
 	}
 
-out:
 	/* Thaw the fs if it has been frozen before. */
 	if (mf_flags & MF_MEM_PRE_REMOVE)
 		xfs_dax_notify_failure_thaw(mp, kernel_frozen);
-- 
2.50.1


