Return-Path: <stable+bounces-141503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE01AAB726
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36849500874
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BAF46E593;
	Tue,  6 May 2025 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8+DI7ZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BDA2ECFE3;
	Mon,  5 May 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486502; cv=none; b=l6Xpv4V+w/vGR+yYIEiK6BoHT9Mpe6JpYMS0c8Wow6DYIhG611ouXcDvSIWW9NKPZgF9sPpWFV9qmTaS9Q1yI15V3tAtZbCOwKaXtLaRN/BDnFr2wgNmswonEUvuSc1iCmmVcAOUFWkT7B7ltC8l/SDLpzJp00aS6DgOmROa0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486502; c=relaxed/simple;
	bh=0uhOEJdesMZ0/FMN3zc75mJ1ev9hHoeL2W/wxepzwK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvZ9cA4deT7VFc0yQZpdme/AJYXhrKNhnxtEFdI5iTJmAUc64n9wg7lYZsIJnl0ml/qh3y0qVdXhVVzTinnWJXoVwM9legKJcmIKh9dW+nXCcAzpypKJbYrfhbraDvcMnkuNlVyvZET+QvaVnIo86DPgdSQtSBkVe3TIt5dFuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8+DI7ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252F1C4CEEE;
	Mon,  5 May 2025 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486501;
	bh=0uhOEJdesMZ0/FMN3zc75mJ1ev9hHoeL2W/wxepzwK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8+DI7ZElXRFLCk8pNwP4B6SfdcXuO8ntSqY7g5kA21uo0LQtQ023mEC7s60mfY4k
	 /oMv9uKQXgadf93jQZbCK3tej7CbM9ETzmToEJ4Ds0BvG9S8l9KWToU94gzonT2wPz
	 E2d1rh5d+R9jqxMvhEzEXesDtEPxrQPsAIgRZNh+lN0WWRlhlLDUo8nDchAQ/eVQ/w
	 XYtrVTbX+yfcf73BB1nF0l9R6xPN250MuN3iCB+MBTRNIccFICPGyoz3tCdWz0IR0R
	 GZZHMpAx1hlg6bd74/UHg2+UIh2RjuIkDMKjquYfX92wtuQUS32/hbiUf49XC+xRXx
	 L7YqBS72IJEQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 062/212] f2fs: defer readonly check vs norecovery
Date: Mon,  5 May 2025 19:03:54 -0400
Message-Id: <20250505230624.2692522-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 72160b906f4b3..0802357d45256 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -745,10 +745,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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
@@ -1404,6 +1402,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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


