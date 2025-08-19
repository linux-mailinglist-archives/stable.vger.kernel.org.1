Return-Path: <stable+bounces-171715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2A4B2B683
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348BA1765A1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2901287274;
	Tue, 19 Aug 2025 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edFAhsdL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77483287266
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568734; cv=none; b=RbOZvnP4bijai/TuQ9jMwPQ9VTRIljRm2Ke2SPwb19/aQS5jn/Zw+FHAhBcoDRz6iYHy1HjbdpZ5N2L0m8CjYdUwjffFO8xrwQ4A8gNv4bIBAAFy3KMXybIwLcMqbd6Q+cVdsH8IE4wC1qIT5ek87h7fcHOk6EFC7fKzcQ8gqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568734; c=relaxed/simple;
	bh=/GEsj1OEru9fo8JezAXFatNtA1qpuV4jwvPBrImQqV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wex5bzhHh5aEc+5RE+BBeLKea2UD9oI/RIL54BC3YcLgYnZIZc6LHo2h4LSY/uUUN+7iJbYtIcb9EIeDnjz8E5hSBoSNMHBquEaXOut2mPsC8DqvrhBtedpWJlJo8Z3RefXsBBhJPEbgxA9OO5qqmubELIe1mMjUwYpCf3t4jpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edFAhsdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C486AC16AAE;
	Tue, 19 Aug 2025 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755568734;
	bh=/GEsj1OEru9fo8JezAXFatNtA1qpuV4jwvPBrImQqV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edFAhsdLBoJ0feR+nEmsw6JMnF4TREUM3XmKdwUh2pnxOH0jvpSeafPEowC59+Nfm
	 ghpgbKEYIhkxaQ+KI2Ph7hbHh9EwtrPE7Cz2pRIHkeInMme0IAgYOHRiU24v3DTi1u
	 WgrU1SQFT53zeXTXqyrdsYschqG9+Vfc9g48lRC9/nCUhhBDnotA0vYny0oW8McvG2
	 sDY3vQ+/raX9pWLNtfE1N6JE6i3iGMNSGlIV9u3p7FN59M6GMqRGWD/e7UxvWZEF+L
	 jK0BeVQAjEDmcBuCl+NZ1+NSrL7wJ1HztTCFvEbl4VppinL7L1nwubSOjm36Mxxfgk
	 tlC7NQo74k3YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] btrfs: zoned: requeue to unused block group list if zone finish failed
Date: Mon, 18 Aug 2025 21:58:49 -0400
Message-ID: <20250819015850.263708-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819015850.263708-1-sashal@kernel.org>
References: <2025081853-parrot-skeleton-78e1@gregkh>
 <20250819015850.263708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit 62be7afcc13b2727bdc6a4c91aefed6b452e6ecc ]

btrfs_zone_finish() can fail for several reason. If it is -EAGAIN, we need
to try it again later. So, put the block group to the retry list properly.

Failing to do so will keep the removable block group intact until remount
and can causes unnecessary ENOSPC.

Fixes: 74e91b12b115 ("btrfs: zoned: zone finish unused block group")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 841954bd788f..13b223eef995 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1623,8 +1623,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		ret = btrfs_zone_finish(block_group);
 		if (ret < 0) {
 			btrfs_dec_block_group_ro(block_group);
-			if (ret == -EAGAIN)
+			if (ret == -EAGAIN) {
+				btrfs_link_bg_list(block_group, &retry_list);
 				ret = 0;
+			}
 			goto next;
 		}
 
-- 
2.50.1


