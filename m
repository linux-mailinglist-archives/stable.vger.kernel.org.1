Return-Path: <stable+bounces-48054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0738FCBD0
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107D4287C48
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3E1ABCD4;
	Wed,  5 Jun 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZKwb6v5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89881AC45F;
	Wed,  5 Jun 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588363; cv=none; b=pV7feqNsEuGM8+wEYYsNyx0XdJaUqdOiuVQuFAF3lvzYlON/N0+X00iBNRHuAir1CkJG2ts0rzFQpAwxxAU9vuRHDCZMlD9XFx7VvJb0fI57Cz08vBDZ1UqLLfBYGDlQ5g4G2pjQkAVqbh9BQnfiACxccp4zi3XlK6nmC+vsb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588363; c=relaxed/simple;
	bh=g3iRvxT62XnaNPCsvLlGtLyXzGD5qCPrw+stjFgQ0lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mm2jQ9/Vb0rxDQuuTIL9qPNo2sAiCL4ZcpscmtpDJTQJ0trOfV/pgpkQn0xVS2aWASJ1ULJDRQgA9uwnP2xofGkGp17CzXoUt9F3xRg4CiApXrRP5Y/cq8v/SSsAMpTONXETlrF244axnD3f3dUhfPKwWhP/oi/pOrHq/LKB5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZKwb6v5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F483C32781;
	Wed,  5 Jun 2024 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588362;
	bh=g3iRvxT62XnaNPCsvLlGtLyXzGD5qCPrw+stjFgQ0lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZKwb6v55vs/XbVMZfgVqHO6V1D+0YFZt9lgpLTuI5/gXDdiPfjuaA9pdS8WwLjmR
	 5Gm+YifG1CivhJoiTst0C1RfzTLFDKJYm6sTm0YvIOeygciD8kYIaXtwtHNjSklHxy
	 8ZxMjUDvKHNjboczOwqreRYsm95KbSUaIVRQHzabGPRS5q/Mk1YdrpcPtrSdSQmRVI
	 csjhdkM5DCBgRHMkVPqiiNAXAPS/KS6plggC4XmsFVv+m0mh2P+oStLqar7pIN70Vp
	 ej6AzFFDzxMQQhcBqv7BRmVVDvGYMTacgqIwJ8d+QYeCosyg4h+0rM20ls1wqWmUbz
	 l8vAm4e2KSw0w==
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
Subject: [PATCH AUTOSEL 6.6 09/20] f2fs: don't set RO when shutting down f2fs
Date: Wed,  5 Jun 2024 07:51:52 -0400
Message-ID: <20240605115225.2963242-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 5d294c8a025ca..ec3f4a5ed2172 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4178,9 +4178,15 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
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


