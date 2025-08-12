Return-Path: <stable+bounces-168616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04CFB235AE
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4241E7BA9C3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3E2FE584;
	Tue, 12 Aug 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KaX6/byC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFB284685;
	Tue, 12 Aug 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024765; cv=none; b=sB5vyxMuV5Ods0YSyk0EJPhQz6GEmp4rnERMs2UMozNqKLZSJzUhKLmTS5yPy4Ov7BP+ZuTUPRRsICo6uAb+hu15OniiL58jfikd/hkqx+cSVThhDQrdtVrogLiC0bqGHnunZztp27CXa8+nuYF+kKVuCVEMNbuJPwu3w97Afyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024765; c=relaxed/simple;
	bh=ZkxoPuhbftXg8JxdKCmaOWD2O5/EvrBhuv+KsuREZXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiWJNZQ53Rfg/fMb1RW58sfS6jCRQnnTkTlrW9dZ+CO+eSISdVxnEL217kvt1Hcxo4/oNiiJQ5ZSEEtTW32qWFUquPjY8yXFpsRjkn8wsF026L6tR5fQKhGNLXx1B7TPui9EjgMjrbUYRX73sN+K75SJoSEjiwV5f6yZO5pNvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KaX6/byC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33485C4CEF0;
	Tue, 12 Aug 2025 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024764;
	bh=ZkxoPuhbftXg8JxdKCmaOWD2O5/EvrBhuv+KsuREZXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaX6/byCUUWeTdohK0KojbFHR+PD+3kXDbhuaC7TpRt57PcxNijS18UvaRrYr/rQg
	 Jiqmb8CwYk9OM6lf4eHLctaGvh0lpFCWEPULNEX2BTLZRPoYrS0IHMvKefOPfFLlDz
	 197B/e55N+la3YHTEqASPtEHzLCfRdULEKnW+qvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 471/627] f2fs: turn off one_time when forcibly set to foreground GC
Date: Tue, 12 Aug 2025 19:32:46 +0200
Message-ID: <20250812173441.184356907@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 8142daf8a53806689186ee255cc02f89af7f8890 ]

one_time mode is only for background GC. So, we need to set it back to
false when foreground GC is enforced.

Fixes: 9748c2ddea4a ("f2fs: do FG_GC when GC boosting is required for zoned devices")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3cb5242f4ddf..d915b54392b8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1891,6 +1891,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	/* Let's run FG_GC, if we don't have enough space. */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		gc_type = FG_GC;
+		gc_control->one_time = false;
 
 		/*
 		 * For example, if there are many prefree_segments below given
-- 
2.39.5




