Return-Path: <stable+bounces-141372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3E6AAB2EC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1588A4E73A0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62744A62F;
	Tue,  6 May 2025 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIGHN36A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEE37B329;
	Mon,  5 May 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485947; cv=none; b=jRgH2PU77CO4Ez4mepwYftBeizkHIFrfPBidXN4+/OPAfK+glmEfU7M82kwMJD3SVxyfc9jYj7MZePhMMbp6YfOffAvjqhh9NL0eSSm7R8A+QoDsiGW0ax/qaeGDU4O/MOKQ6HOwEh9je4HXwXyFUMzNko9N09N8BO9n81BsODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485947; c=relaxed/simple;
	bh=n9hhTDj40JpZ/5hfqIn73ebJDLsxbovJ/7hGyXWzv98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6IOXFzdsqvz+MQpFpyc/6q1M0QGzD++AeNt4B9+GAZG7PbZXZBwjAUp40Psl3FWsGGm9vj6/Hbp3FmrkMN934RIju6FznqmU2TZ7Rkk2CvsIZw86P+fwGN2+gXI26uu7tQLUT+ibjJG5wCEhIE/G3njUGooNb7Ozjp/HW7s1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIGHN36A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414B4C4CEEF;
	Mon,  5 May 2025 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485946;
	bh=n9hhTDj40JpZ/5hfqIn73ebJDLsxbovJ/7hGyXWzv98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIGHN36Ai/Iykp/fsGls38r+aIoW/4gOkMoJxMwFT0xIoTYfFwh1hUsxA8/PwAclw
	 U2F4vSaiTyYrgIAvZHv2nyuV0t/uajUqXzqshkgtCSRBzIsmUTDsiT+GzKqS9p/4sE
	 XVq9ugGXR9UVuUwv5IRmsJ98Ftqw9pxfa5BX4MQxlu66eHzaPJrOR/bHIMd8RKGOJE
	 VL3BrYdWqKhBLeL7hCKtPiC+KMCQj1YKUzlnIMHNg4hCaKWqyfnzeVA4xtZFOkrHrB
	 Dw2umkeJMo3nj3zgjR8rouwx8vdfajNeijeMQOIWog9qfzelpIgXufd98fkXOb4r+L
	 vEdvyFiefZK0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 078/294] f2fs: defer readonly check vs norecovery
Date: Mon,  5 May 2025 18:52:58 -0400
Message-Id: <20250505225634.2688578-78-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 4cc87921aac3e..10e50bede8080 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -707,10 +707,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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
@@ -1390,6 +1388,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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


