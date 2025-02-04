Return-Path: <stable+bounces-112092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC1A269A0
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF1C3A60E9
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648511662F1;
	Tue,  4 Feb 2025 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYKrOUCD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392B15DBBA;
	Tue,  4 Feb 2025 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631885; cv=none; b=QOzOxNEJ9xdG71T7/8f1JNbNFtkAZ98a2DV2oBXgA6xwXWE0RQSoDAFWt6/fSbmSf4lyNpBeSk9Q1xj045pnf9b/1Rvy/Mb5aebqvMzvnbOE0FOEx2fnuYemhaLrYLp7jvI4rqWcxp1E2cGvNVg7wKiFqHBbjKAyCBxNQEkbsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631885; c=relaxed/simple;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NluS8UeFGVAE22wf7ZF/+j8S2HfROiWChN7t9pBZkY2Bfp+0kc34vV7EWpDddlvwMD1zic+XKu/2UF8YMIQ9lcY6J90k4QAbQqaCOAEB5kuPIXy7ux2PPN6qKKTzi+BXDKlxXYmaFbr17bSAgTv1H3GltiWIbU0gRgHikh5GhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYKrOUCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16A4C4CEE6;
	Tue,  4 Feb 2025 01:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631884;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYKrOUCDVYD95f04s3e1Ixw+5RFBi+P00MI+bByS65jVsijnaN5oucBHeNaLtTqAS
	 YYPCWqQz+OKQlVFGb1ynsSLfH1RSWdV8E65DhgHgmlHjz8Fmbcy34zqURyjnGnB8P+
	 iTX5KOl4TvYJUolI68fpov+z25e5d9waA5Xx/NuMKvEXlWUVpRG5mcjgtaPFVOpgM/
	 e1a2x0quRXNl5+J9ZmPlDT2rNEFJVHgbvH9HG88CR/EFlxL8r+fVAN1ROjBu9jKfF+
	 yimScW9Mf7Ti5gsTeChU0aGiHOxQaV4fnUo9vrhBwz74ZtNloRK+LbMX/OO97Z2/3d
	 ak7uIyK6C2s4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	syzbot+fc519d7875f2d9186c1f@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.12 2/5] orangefs: fix a oob in orangefs_debug_write
Date: Mon,  3 Feb 2025 20:17:50 -0500
Message-Id: <20250204011757.2206869-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011757.2206869-1-sashal@kernel.org>
References: <20250204011757.2206869-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.12
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


