Return-Path: <stable+bounces-48004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8118FCB05
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1B81F23F4B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1693DABE1;
	Wed,  5 Jun 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQupnB3H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76119924C;
	Wed,  5 Jun 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588189; cv=none; b=Z7OxNI5esU/HWyJBTIbsRdv+KJLtxOSNK1DeKVT93XeYTxhUEQ/GgG3s529mAYOkmfKGeJJoCmD/Gcqby7dsy51ojZk7uBJYGhD6C2dbC7gz0IZa3fQBqJsd59u+f+16YnC7PeQMIigRQV9lCYZyNTgmzs0GywMw/gX9c9vv1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588189; c=relaxed/simple;
	bh=YXLht4DMVx9D4bBLqSYfEGN9zRr4REGZhY2ixp5EipA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbnKweDsHVZxRG35l62mxEXiBYdT2lGjGWcsqSt7dWtHYQ4ptR0Kd2e52pimpnyze5CufZAZGdjYficlnu5r30v2iioT8HSainrw96t46bGcxhrUwrnhiCw61kIj7FWaKF47OOuXZhowcKk+cHsZYo56CHVgzIC6m7x64Er4Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQupnB3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9231FC32781;
	Wed,  5 Jun 2024 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588188;
	bh=YXLht4DMVx9D4bBLqSYfEGN9zRr4REGZhY2ixp5EipA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQupnB3Hf1a2wkwqP6i9Dj8ZKVYPlgB6t5QdZrMVpGa2i29e98edU/Ojt1c0XBkWr
	 DriPAFvLdXG13ib3DGFjVM07f3pSpil0Wzv8INE202/t0mq6oeG2aZ/aJHv4gsTLTW
	 fXJEsZn1Og/6c/vKis3jJoorsOOY3e+/AOWpk3ox6oK9QkRW3oln5ur4AHVQwF1/l5
	 111HpOZILKnYgVbl/squlMHPVEyGWm7zov+s8xlzw+G9TROF7UbD4G0vnIx5ovsvov
	 jetUcQ+QF24o7GQAcV55Hf2cHiRCsblK1VIrb4o1bmqQpVD2yQIePF2NYYiUdFDvyX
	 wG1XsRLdOkjsg==
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
Subject: [PATCH AUTOSEL 6.9 11/28] f2fs: don't set RO when shutting down f2fs
Date: Wed,  5 Jun 2024 07:48:40 -0400
Message-ID: <20240605114927.2961639-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index e4c795a711f0f..2f75a7dfc311d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4129,9 +4129,15 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
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


