Return-Path: <stable+bounces-19640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294308524B9
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 01:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2AA1C23C80
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 00:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000385927;
	Tue, 13 Feb 2024 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7sgAM/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DC85658;
	Tue, 13 Feb 2024 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783817; cv=none; b=aVGobQGa8JXWuZTL/v2Btgt9gkaxGc0rMIFpSpx/GbamPMEfcBSPh+dcUYxl4hrMSErVC6O9b8QrZSCXBFP+ZFEcY7qw5JCQ+DBBSueuiqmEwvgWXfiS3KT7+sRsI6F/huvxgt6gJFO97QZIy9atPoPXCJSGpgf3O+WUJkg9KZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783817; c=relaxed/simple;
	bh=zzfaMW36TFR9E0D+23cDE5J+VT8F4h0RMltlRkh65yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=so//M5SWOqmiK/zVP4oKzjPE4ADGlj9NXfXDBg38VYY8rAPjr+73xsjgerb/aVjjsBYKBd9qGhLjifQ1hy6VKVcyS7+TnKFDeT7gMdk7+AZhLR+SkNWg3F8OJPgPPQ32g0ZUf+EQVLOblln7B2ruP9rTuI+/hcmoH6WzBJj3eC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7sgAM/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72116C43390;
	Tue, 13 Feb 2024 00:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783817;
	bh=zzfaMW36TFR9E0D+23cDE5J+VT8F4h0RMltlRkh65yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7sgAM/FOno/j97Ow8j914p7BNhyP5NQipysY5PQMOsOzrASFadxLLDjhopxqNcLu
	 pWuXv6mKWEhjnKpj+Uc5f9tcZ4A71G2XsRsuHcyWpANQooufS3jT75g56VY2O0O0aO
	 hTt9oHHwPnuxC3X/zwbBno2GuZfz7YkBPBBrvNnE73//ozhVSW4uCCFTcIr5CbCtNG
	 9NTEnD4cC3/zAhBA5euuvmxYRGbx5phh5+R8ZbJw39Pl4XIZ2JZj9fygFc25oGRFOi
	 duBR0vqBOwyffDQHg2qaHkfYJ930GsQuE4BNOXC2kfl+SegBklcWaSR/0ytAsi3YTP
	 owrj32dtL33Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 04/22] fs/ntfs3: Print warning while fixing hard links count
Date: Mon, 12 Feb 2024 19:23:06 -0500
Message-ID: <20240213002331.672583-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 85ba2a75faee759809a7e43b4c103ac59bac1026 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 176b04a5d1ad..0ff673bb4b2b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -402,7 +402,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 
 	if (!is_match && name) {
-		/* Reuse rec as buffer for ascii name. */
 		err = -ENOENT;
 		goto out;
 	}
@@ -417,6 +416,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	if (names != le16_to_cpu(rec->hard_links)) {
 		/* Correct minor error on the fly. Do not mark inode as dirty. */
+		ntfs_inode_warn(inode, "Correct links count -> %u.", names);
 		rec->hard_links = cpu_to_le16(names);
 		ni->mi.dirty = true;
 	}
-- 
2.43.0


