Return-Path: <stable+bounces-141615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04254AAB745
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4527AE04A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76428982A;
	Tue,  6 May 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJWcSAyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975722F3A70;
	Mon,  5 May 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486886; cv=none; b=sOuQ1qlEkTpkBfzFoVmcPVuySoFG2adioIJvSnLJHW3M9yy5NEaGgLmUwRuuffQFKMAYyMGMjpmqbAAHtVhlKtt/DOWxTo+mLnFTik64qd1lHBYUVqMn5SUSREWwsLrzznByEH0qIexlwo038uv9UveLOKpJQ/ZY1TvhHlYBndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486886; c=relaxed/simple;
	bh=SsB4YWj0Wp+JdtD/I74jyR9V7Tx+JLtGyt37WCHYMwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZ8YeiDtYyjzOxbadAfnADuMAV+XtQLzoFu94tNFVDLGiRp38CC08QdRjdzotGa2PF4UhHfnEtQcgs4rJsusfj7NxRRG30Z2GRfNB7Jze0BkG/6YVFwu3n3f8J6NTzXszHrdY/5++IIm2cRQIS3c8jcaa0GOzdBEt4mIWV0oNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJWcSAyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9B3C4CEEE;
	Mon,  5 May 2025 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486886;
	bh=SsB4YWj0Wp+JdtD/I74jyR9V7Tx+JLtGyt37WCHYMwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJWcSAydeJUcFNv7PPnOP2RRnxvzmUKsqW4oLggwnV+4ulnnWSPAgQ/Yj+Oc6BDAq
	 W2MLg080cRCRn+tBEqwWqFJzl1UTJ9QgNl5KnQjnomSyv7K3yRvCG1lvuxgX0h/n0P
	 lj5FqjAjX6Xoerj7MUjC/+3lTRDaJ9ZITi3b64hIfekAZNiukvQ0caV3afqAXuFain
	 7N3KGH2L/q2OUc4m2R17FZhHcu0fY5FeOdKi48BivA0kov2/7OaDSlBwX17Ri1TSQz
	 39C+HAP6TDxEyEVsnhlWE2ageUQQ39FrZtxTgZDhyzDZ8tdO02CDzeB08JWfdtYqgU
	 3Fh8iP7uPxEQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 044/153] f2fs: defer readonly check vs norecovery
Date: Mon,  5 May 2025 19:11:31 -0400
Message-Id: <20250505231320.2695319-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 9cca49875997a1a7e92800a828a62bacb0f577b9 ]

Defer the readonly-vs-norecovery check until after option parsing is done
so that option parsing does not require an active superblock for the test.
Add a helpful message, while we're at it.

(I think could be moved back into parsing after we switch to the new mount
API if desired, as the fs context will have RO state available.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0cf564ded140a..77a7b789e32ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -729,10 +729,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			set_opt(sbi, DISABLE_ROLL_FORWARD);
 			break;
 		case Opt_norecovery:
-			/* this option mounts f2fs with ro */
+			/* requires ro mount, checked in f2fs_default_check */
 			set_opt(sbi, NORECOVERY);
-			if (!f2fs_readonly(sb))
-				return -EINVAL;
 			break;
 		case Opt_discard:
 			if (!f2fs_hw_support_discard(sbi)) {
@@ -1386,6 +1384,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
+
+	if (test_opt(sbi, NORECOVERY) && !f2fs_readonly(sbi->sb)) {
+		f2fs_err(sbi, "norecovery requires readonly mount");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.39.5


