Return-Path: <stable+bounces-92179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37569C4B85
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 02:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EA8B2396B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 01:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EB1F7574;
	Tue, 12 Nov 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR0jeD4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBC5234;
	Tue, 12 Nov 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373703; cv=none; b=CURR4Fj2TPUVgJNvjaK2RkggqqZopQiM+PJVL4vMxYH0uOdFWbSqAfBRbRLYRBnRmnM3NMdIlSuHmvt08Y11y+V6mahmBTCZOx+vHIOjr/f+6PEVSNXCW6aSUo/DumS56Kpp6kcU5x4klGQj5PaBgR8s73KhxC3BTB2j5NYRy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373703; c=relaxed/simple;
	bh=Yvcx1AXHc9kQyvfwxXWWRFwqQa663r5SsuoB/VXqYXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2M+zF6r/kmr1xn+xxSII+lNq/efXQ/JxNSwbU0mmMLUprbDcUh+fDxG2EMM42m0gSe+5zVBiX//nRpJNnMRY4PrT9rUCtwahmulmliJ2Ka+KGrezAQr8Fgzuk+8/tCN229fuqvv5agruDiuSzJzHJ3J3goeux7zpG9t8kRA41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR0jeD4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D626C4CECF;
	Tue, 12 Nov 2024 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373702;
	bh=Yvcx1AXHc9kQyvfwxXWWRFwqQa663r5SsuoB/VXqYXA=;
	h=From:To:Cc:Subject:Date:From;
	b=CR0jeD4AnXXENKTzMnCiXV+YDbVByQZ1f1SM6m9Kz49TNoTgxYlqjiEzSrytFxW3/
	 3yFUXYsZGSAW7NAwLrdHlKghhpBSWQLbwciLglfY+LG7CS/1HvegPgq1t3EqggOemD
	 0GUQeW8vV0KKghLpb/dMH6o0Ma+Y9lYI182/NG2YBnIsnzgxIO61sjymclv7MUgmwt
	 nlV/7+V5sbZZBzBP4X3XtUDaNyeUMwF1/MWaD6A2fx9FF5aX6jcTpV+JLk3xAP+tmQ
	 G8niQcGQakL6PlRvAfZkeanxvqYc4IJZuwLSVKl4nVg2FIlKZ8vXcy/2S7xrN8woXC
	 TYuqrgoch00bQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	stable@vger.kernel.org,
	Daniel Rosenberg <drosen@google.com>
Subject: [PATCH] Revert "f2fs: remove unreachable lazytime mount option parsing"
Date: Tue, 12 Nov 2024 01:08:20 +0000
Message-ID: <20241112010820.2788822-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.

The above commit broke the lazytime mount, given

mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");

CC: stable@vger.kernel.org # 6.11+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49519439b770..35c4394e4fc6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -150,6 +150,8 @@ enum {
 	Opt_mode,
 	Opt_fault_injection,
 	Opt_fault_type,
+	Opt_lazytime,
+	Opt_nolazytime,
 	Opt_quota,
 	Opt_noquota,
 	Opt_usrquota,
@@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_mode, "mode=%s"},
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_fault_type, "fault_type=%u"},
+	{Opt_lazytime, "lazytime"},
+	{Opt_nolazytime, "nolazytime"},
 	{Opt_quota, "quota"},
 	{Opt_noquota, "noquota"},
 	{Opt_usrquota, "usrquota"},
@@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			f2fs_info(sbi, "fault_type options not supported");
 			break;
 #endif
+		case Opt_lazytime:
+			sb->s_flags |= SB_LAZYTIME;
+			break;
+		case Opt_nolazytime:
+			sb->s_flags &= ~SB_LAZYTIME;
+			break;
 #ifdef CONFIG_QUOTA
 		case Opt_quota:
 		case Opt_usrquota:
-- 
2.47.0.277.g8800431eea-goog


