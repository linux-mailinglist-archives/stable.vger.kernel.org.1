Return-Path: <stable+bounces-119867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA9A48A62
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 22:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380411883746
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D58270EC8;
	Thu, 27 Feb 2025 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld55pj4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189726FA68;
	Thu, 27 Feb 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691444; cv=none; b=iYxXUiE0E2BpexTiCeC9bO876D7PpfvNzZBStiYzttU4PemdkkH/fs9Er5/Mt0PF3RHcCNiZnn/UNLtEkVS8hLR1ObdZhjF1r0XLjqSG/JF6yQoIJv1Ueo3B3blsDaUU5w6n7pwTnLm/ajK36uFl5bWba5Ll0pJ+F6IcUgGAnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691444; c=relaxed/simple;
	bh=vD8RUpJ0yAedJRgQfUTf+GMBbYOFPmK1x7iiFwnW3Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rG45vl3iS+4I/kb9TMeKJNMC2g5nKURQ8OLbJgm8Ytfivy90VX9Ceh6Cg0zs0okL/vhmNrxJuLx7t7QDZ/0FMGd/aVAYFSFucZp69OJPgyruZ0AtxQzDBzaVFY9UAAjy+m94TwXzykyLkJnMyIeQHsO/QBcNSyY23/wTsxQAeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld55pj4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C323C4CEDD;
	Thu, 27 Feb 2025 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740691443;
	bh=vD8RUpJ0yAedJRgQfUTf+GMBbYOFPmK1x7iiFwnW3Fg=;
	h=From:To:Cc:Subject:Date:From;
	b=ld55pj4bFuPsOkON+H2nuyZvN0PedfTwaoPB4SGghCybDpYfWimkHPVYIHe3BP17u
	 DHeK+UQ+rLFEdd8ZD3CmaotrWR7EE7wZkbYft6Tn4ttVYPfkVcHWQMT45m3Vv+Vz5W
	 bcsiufUXD7hA22Urm7yD+baM6ktDtKT5XPi7IR8Zfll7oyJfgrYXIwbYj3IhbNk+En
	 AoyNw1owA8ZXK7Xf5m6++KMzsY+grs/n5KyIK2vplpNCZ/fuaVnWnMZ3CCClzHSAIz
	 GBwW9TMSy5pJfLgu9uaBh6RCl07TdZLcCwyvjRT7KIxDyHZZ5MQ17h4lmWd2nhDtHk
	 /WFdG7cWY3lsQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix the missing write pointer correction
Date: Thu, 27 Feb 2025 21:24:01 +0000
Message-ID: <20250227212401.152977-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If checkpoint was disabled, we missed to fix the write pointers.

Cc: <stable@vger.kernel.org>
Fixes: 1015035609e4 ("f2fs: fix changing cursegs if recovery fails on zoned device")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f5c69cc2de72..7a8fcc1e278c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4752,8 +4752,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_meta;
 
-	if (unlikely(is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)))
+	if (unlikely(is_set_ckpt_flags(sbi, CP_DISABLED_FLAG))) {
+		skip_recovery = true;
 		goto reset_checkpoint;
+	}
 
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD) &&
-- 
2.48.1.711.g2feabab25a-goog


