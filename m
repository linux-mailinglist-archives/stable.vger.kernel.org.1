Return-Path: <stable+bounces-112086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7131A26991
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03583A493C
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E31153801;
	Tue,  4 Feb 2025 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPPd7Nnk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6A86323;
	Tue,  4 Feb 2025 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631864; cv=none; b=AOQU96JF4rj6jiDrUMhuRdR0K350vAWlD0nfw1ItSJENFvz24J1NC/WWpzyCG0enzM3iQTMtWEX4kI3dqjx39FY0eObyyt19qcpYcyQAWlwMMIQTxujiA9LPIjvxTt1hjL/fJ4kh8O6qLtk2RLtb1wl+mPtihrEubyJHtlFQtn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631864; c=relaxed/simple;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixLKAPKWnwG48vo6e5ASv8BrNBuXDmtxp1prSPjL0C8Ny56GdT/2f8if1gcIkJJdYgMHdIIhN3sc+qqWcn7E00jaSp3XPMYP0DRKMWbM5Nb7v8Geqwq8XSmhDNh2U+ZLECOmswqRHR+icyshT6qTD/I2JuyT5LdA1yFBC/81nEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPPd7Nnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D89C4CEE5;
	Tue,  4 Feb 2025 01:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631863;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jPPd7NnkJsQa2ogPuViWdzfkqrZ86JJiaVa5DL9MMb6VNzkFYBDpgH8dn7G2kZASW
	 U8EWfVDD1wqPorz8t0SynaU9RJd3eblPVVQPIV7dXm/2W3Axq1VScSrgXjer8exhds
	 eIUaDX9pgmu1XXTKLs4Ef4mtEVKHw5wLGZZ9wiNsGEP5zsyhZFhQHi1L6bGSSmcksc
	 casKYCdXBcVPn5ARXHCnee0qgroKYKjM/opbCkeImh00gHadOFnK8yON9Vws0Sg07P
	 LWNHXxngFttjxHyrpnHGlfK4bUwzZWiXOKln8+zqSeGGDUYnvsWrfJeOcTnici+aou
	 3mpJVfkuVO10A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	syzbot+fc519d7875f2d9186c1f@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.13 2/6] orangefs: fix a oob in orangefs_debug_write
Date: Mon,  3 Feb 2025 20:17:29 -0500
Message-Id: <20250204011736.2206691-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011736.2206691-1-sashal@kernel.org>
References: <20250204011736.2206691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.1
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


