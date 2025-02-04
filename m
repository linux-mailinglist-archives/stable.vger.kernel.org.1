Return-Path: <stable+bounces-112103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C3A269B5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF89F1881363
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3C215046;
	Tue,  4 Feb 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9LtmFHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC861FF1BF;
	Tue,  4 Feb 2025 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631930; cv=none; b=Jpy6zrTibEu/Xr+HQ4+RBGyQ8jcb4VmDFW8DtxuBfIURDf6hQeEbj/m0+EnAftVPSt8j4jTfom/VeEgc7aEl2fKWydcy5wSxTgPkf0vCvJ//EpDOf05MKtuqlGsV18D54lKAf65VjYo1olOE8TDlPkj99LIUW5qxm8sllTrvAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631930; c=relaxed/simple;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjbA4n/QSLaPkalNq3iNqijTRK4LBeuQABxWV+OaAruujX9Oj58754IBoezdDcbPtzEzX6SPrN4IvqzErejMVvs0D2hqaEmfsxBMuHRtmhhiMu20xgvxjYCn7j8qJVM367XDdtZzaaMnzQgK8JwcIqHtnMpZgMSTHBaTlrN0PKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9LtmFHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1840CC4CEE0;
	Tue,  4 Feb 2025 01:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631929;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9LtmFHPMJepg2mwddO8YX4OtiRoMYpmgLUHQWQxcNWjpZ1S6LCfPLXmGBpgg2YC/
	 DjJME+MpewAPFigkulbxkc8DLO95OymbbM5u/FLPe2ykm+PtXWI26fLkF2799jw/0j
	 yZ8mNi284sZfcEQ5cT5EvFPcrTEeTUiGosobEQt/IuXQAiqEujnBHcHm+f8B085tDW
	 R0olmKvLnrBcO1syZpufCV5Wa0+ioQ0MjqnLh81I8D2ZdZ6X+yfIAyNlhowqfU2kSK
	 J22v6mSzSXm/7LPv/FeJbUG6QCYkwQBuWLq/4popcgm01HwQAu2XZU35+1lLbiYs7p
	 9zL+8oJ4jOIWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	syzbot+fc519d7875f2d9186c1f@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 5.15 2/3] orangefs: fix a oob in orangefs_debug_write
Date: Mon,  3 Feb 2025 20:18:38 -0500
Message-Id: <20250204011842.2207159-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011842.2207159-1-sashal@kernel.org>
References: <20250204011842.2207159-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

[ Upstream commit f7c848431632598ff9bce57a659db6af60d75b39 ]

I got a syzbot report: slab-out-of-bounds Read in
orangefs_debug_write... several people suggested fixes,
I tested Al Viro's suggestion and made this patch.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Reported-by: syzbot+fc519d7875f2d9186c1f@syzkaller.appspotmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/orangefs-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f5433846..fa41db0884880 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -393,9 +393,9 @@ static ssize_t orangefs_debug_write(struct file *file,
 	 * Thwart users who try to jamb a ridiculous number
 	 * of bytes into the debug file...
 	 */
-	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN + 1) {
+	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN) {
 		silly = count;
-		count = ORANGEFS_MAX_DEBUG_STRING_LEN + 1;
+		count = ORANGEFS_MAX_DEBUG_STRING_LEN;
 	}
 
 	buf = kzalloc(ORANGEFS_MAX_DEBUG_STRING_LEN, GFP_KERNEL);
-- 
2.39.5


