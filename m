Return-Path: <stable+bounces-204243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB4ECEA245
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC4FA300F725
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B81DE2C9;
	Tue, 30 Dec 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdUfHW0o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DC2AEE4
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111341; cv=none; b=LFCzl00y3vQfp+a3FsD0eIswKBPHLPl8vRErq2WtiYFTIXzKyTZfTBKOgGX9VdB2cIqNeorTB784JTLj/uCWuZAVNCXXBXAJV88DuDBtaucINIre28aXaJOLv2rOBjHC1ZG2Y3n8GUwQO8JqvuEDIuQ2MQTPdpvg5QRZlPMs/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111341; c=relaxed/simple;
	bh=zR30jTL0Ttlfs9W1vcXCpXLDxGJAX1MefYe8ozke5U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfxtLF80F40KZwUb9ph65Wcukg7/Z7HRcRrrTjQt840D5YrMJvKJK2BAoSiuhkCV27KOfpx9+l/PxemK1rUs8kYAzoGttYp/EJvOWj4tMmwuzB1g1/7cU5ejWruqfFbykQtc1+dfCeyoAJWbn4kgUkU6iAzcfrjz2VIaGWAQvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdUfHW0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0345C4CEFB;
	Tue, 30 Dec 2025 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111341;
	bh=zR30jTL0Ttlfs9W1vcXCpXLDxGJAX1MefYe8ozke5U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdUfHW0oJnxMfLXcdoTdD+6HHoKQcYDcAHuj45wfkTtawVEoG+QwLaHwPobh/6swp
	 Hp7KAdZgeGBJ7l3X+o4TNoJPwO1yYNlcvXnha7bpF35V1zpSnFDo/KtV2JteToxNl4
	 rOGjGMgYg1y6pEQjtv5TRfF1WNB6fnh6EW0ZSwh3oaLD7a9cxPksfB/fj7SJF/1MJV
	 WmAm1fGdh9+WJqYk4vMwXmAsERDbAEDaYrysiXr2lRGF+8xHTTQeGi7WuVslkyboKh
	 naskURYABPbwU8VbkaHV81IPduEDrrrYF9hfJpxqiwcpAOLy8vHJ3W7n7GbpYA5O/+
	 baCLwA7hUASRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: use f2fs_err_ratelimited() to avoid redundant logs
Date: Tue, 30 Dec 2025 11:15:38 -0500
Message-ID: <20251230161539.2301172-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122936-footless-sensitize-ae33@gregkh>
References: <2025122936-footless-sensitize-ae33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 0b8eb814e05885cde53c1d56ee012a029b8413e6 ]

Use f2fs_err_ratelimited() to instead f2fs_err() in
f2fs_record_stop_reason() and f2fs_record_errors() to
avoid redundant logs.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: ca8b201f2854 ("f2fs: fix to avoid potential deadlock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b9913ab526fd..84e682c92b7d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4053,7 +4053,9 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 
 	f2fs_up_write(&sbi->sb_lock);
 	if (err)
-		f2fs_err(sbi, "f2fs_commit_super fails to record err:%d", err);
+		f2fs_err_ratelimited(sbi,
+			"f2fs_commit_super fails to record stop_reason, err:%d",
+			err);
 }
 
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
@@ -4096,8 +4098,9 @@ static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
 
 	err = f2fs_commit_super(sbi, false);
 	if (err)
-		f2fs_err(sbi, "f2fs_commit_super fails to record errors:%u, err:%d",
-								error, err);
+		f2fs_err_ratelimited(sbi,
+			"f2fs_commit_super fails to record errors:%u, err:%d",
+			error, err);
 out_unlock:
 	f2fs_up_write(&sbi->sb_lock);
 }
-- 
2.51.0


