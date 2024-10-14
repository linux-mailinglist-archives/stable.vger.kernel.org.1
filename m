Return-Path: <stable+bounces-83686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AF099BEA2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DDC282CDD
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF613D896;
	Mon, 14 Oct 2024 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIVaxgMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052115C13F;
	Mon, 14 Oct 2024 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878306; cv=none; b=W/AsDrCzheD36UA/W1ahlP9Zc5fwXk5Y5yx6JkaiYTCiNdegU4VZD33A/OwNqGZ4o/mIUBiwZkdHIggr3ZUfvbGXqD3efJtDp10atpyZ7f1xJpht2JPvFLD9A+tjLO093Oozofs68RqOXwgNUKjZg4+B8ZT3Awl2ZTs/a05pejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878306; c=relaxed/simple;
	bh=n7vwLDAz1N236CDu81+kTj90InQZoEop61TLuVcXkp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7KhwmnKIcBAfuklNFIaHQK+RRMIhVBPg0lpG9pIc/FDXrW9xBad+QV5NSSqjgvv8Xjed3apOLUvdkZIrlSMTM/s30I4ZTOzWXhEYiS3swUA7f9Em/bggrEukoFG9PA06NMupxSgT+iRSbAjuVrcdbQpbFAXQ7E0uP5exDUJros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIVaxgMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793C3C4CED0;
	Mon, 14 Oct 2024 03:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878306;
	bh=n7vwLDAz1N236CDu81+kTj90InQZoEop61TLuVcXkp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIVaxgMZOm9fw0rKro83d28oCTf0h1msQTkF1z/5BH7DPez7GEgW9albDfGWHts6Y
	 xg1Y+ipJ2Xpqj+PuQOQ0pNZZPLXWmDE+xRDrBOfRhRmGod9zwOorWqVMSRajNXMpcQ
	 JN/WZvwd08N1xUhDnc67bzU5IJngrrc5ihxDv2ecqklwUx4VC1ItXlII3jvdCtUnPx
	 wUAd2PAN8I4Ivp+DQiC/ToXNN0WCCnGbX7xXlCa7P/F0PdG2jDHonA1hqWNt8tzb9X
	 r+MNNUIpP+VZXjnG82zRZCJXQEW/JhNugudl1sJyVuW5+foE+guIlXfuf3jnShYd/f
	 pmGvvSHvjW4BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 08/17] fs/ntfs3: Fix general protection fault in run_is_mapped_full
Date: Sun, 13 Oct 2024 23:57:58 -0400
Message-ID: <20241014035815.2247153-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit a33fb016e49e37aafab18dc3c8314d6399cb4727 ]

Fixed deleating of a non-resident attribute in ntfs_create_inode()
rollback.

Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 20988ef3dc2ec..52b80fd159147 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1703,7 +1703,10 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
 	if (attr && attr->non_res) {
 		/* Delete ATTR_EA, if non-resident. */
-		attr_set_size(ni, ATTR_EA, NULL, 0, NULL, 0, NULL, false, NULL);
+		struct runs_tree run;
+		run_init(&run);
+		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
+		run_close(&run);
 	}
 
 	if (rp_inserted)
-- 
2.43.0


