Return-Path: <stable+bounces-48031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D58FCB6F
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C42028AE5C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31A19FA70;
	Wed,  5 Jun 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIw3C5Ow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88619FA68;
	Wed,  5 Jun 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588282; cv=none; b=q8hF6lZLPwqJ5BpqYBCnA4cz5GHKM6IXWLORcN2ZflnWWsGC4/RbAVlJlN+kXRzY9/LFtdUevw80jD8ZL+mY5UGfRfX5TNH4vc0/bw86XiZssQjtKlkEpyzfJs2JQT4p65ixFyFMTdI/vYwlyhIOvYy6+Gjaz2xB67XdIjl7g4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588282; c=relaxed/simple;
	bh=WpX8KJ2rFv8rTWOq152ssnWgFzrGTDeKzlN5FY1Oq58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pd8x1aoCiqfs9aizgb7nhMisHyuZU6cy+j08MN7yX+QdGJhQ3tUIe19JmIh7r5EV42mRmuKtZ5Zf2p9wN9629lLDJu9tOO51t0Q2brJ+faxBGub2esrbQsc3W8CFOAgO+wsmjysZUNgcma1000zM+tt+8TMTJHYlhIOBJGEdrFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIw3C5Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6485C32786;
	Wed,  5 Jun 2024 11:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588282;
	bh=WpX8KJ2rFv8rTWOq152ssnWgFzrGTDeKzlN5FY1Oq58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIw3C5OwJTAPbI1NdQjDOJR4HQjm0V8QNyTIKeYHLzuNJMwhSIql0s9Clt/0BttE2
	 ZH7zoYd1ZQ73fX5zVX5XOzvHGkja17Laf3jefxeTCUewNMLAA+61RXQnbM6cMLp0vv
	 bJpksREyjBNFdTaW+cEofGALfrtHT8hS8jgtHV0bSJ9tUfh8gU4YH01ftzLutVz7Zd
	 KK8xdhkyYz/1t720Jc8lCzKcfHqLsWv2clfmPvg8tmwB/YrF3MWVZCdBKqNAn3rTlU
	 UrRXb6st8e3zCorH+v5jFQccWtGyDZD+spLpDaaIsPn7mYOl8omicgsX4F5D2+LV5N
	 ozBkq3MSO92RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	=?UTF-8?q?Light=20Hsieh=20=28=E8=AC=9D=E6=98=8E=E7=87=88=29?= <Light.Hsieh@mediatek.com>,
	Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 10/24] f2fs: don't set RO when shutting down f2fs
Date: Wed,  5 Jun 2024 07:50:20 -0400
Message-ID: <20240605115101.2962372-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 3bdb7f161697e2d5123b89fe1778ef17a44858e7 ]

Shutdown does not check the error of thaw_super due to readonly, which
causes a deadlock like below.

f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
 - bdev_freeze
  - freeze_super
 - f2fs_stop_checkpoint()
  - f2fs_handle_critical_error                     - sb_start_write
    - set RO                                         - waiting
 - bdev_thaw
  - thaw_super_locked
    - return -EINVAL, if sb_rdonly()
 - f2fs_stop_discard_thread
  -> wait for kthread_stop(discard_thread);

Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 67bedd5b69cc1..e1e2f0a067b99 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4194,9 +4194,15 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	if (shutdown)
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 
-	/* continue filesystem operators if errors=continue */
-	if (continue_fs || f2fs_readonly(sb))
+	/*
+	 * Continue filesystem operators if errors=continue. Should not set
+	 * RO by shutdown, since RO bypasses thaw_super which can hang the
+	 * system.
+	 */
+	if (continue_fs || f2fs_readonly(sb) || shutdown) {
+		f2fs_warn(sbi, "Stopped filesystem due to reason: %d", reason);
 		return;
+	}
 
 	f2fs_warn(sbi, "Remounting filesystem read-only");
 	/*
-- 
2.43.0


