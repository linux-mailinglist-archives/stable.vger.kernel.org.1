Return-Path: <stable+bounces-49356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF38FECEC
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2504A1F25B33
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D371B374F;
	Thu,  6 Jun 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9N0lVuZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B21B3749;
	Thu,  6 Jun 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683425; cv=none; b=PeeogZ4HWK93NfjRmACxwf6bP/cai7Ph4znyVJGxsQdr1sDG6iO4jwhcRDmBBTZdXIbEsQUCxhNJKrE1iR/sGak1cy3baTg5/JGqRo61TsRv1PNDjHszYSmwcq57dAZvy1fofl/rJdcQnQZCZ39T9JCyWRfm3LWFUeyEWGr4MP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683425; c=relaxed/simple;
	bh=u45LQQ2In0tINj+Gej515+pvuip0LU1mOE743K5jepo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/Ycmh3lOCsWNQszo/9kUOTa8UKptE4t0G0coRo8aKw5Ed6ynEAfHSE5NO7Ro6f8pA6yRXXegOUDtKhjWGjcAN7sfBpjVmZKP+car6kMLZUokbyI8eD6UhT0Npcd5ylH5rv6Tht6c87N++m00I4MwS5z9+sQhaqI6cLeNDAUHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9N0lVuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669D7C2BD10;
	Thu,  6 Jun 2024 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683425;
	bh=u45LQQ2In0tINj+Gej515+pvuip0LU1mOE743K5jepo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9N0lVuZ2Y9iFDS0Yzn87Hn9oriOr990H/gV1V5qXJpkP80TyV4Y9mUuC4yDszYev
	 J4v76MS3F2NsL1tj6LVHk1Xm/qux1tEexjAFZgY/gv+CCH9SEsobtRoNLMG3JIoPRy
	 FgzhnbXjbscH+gnw3XrwUICZOWItCKp3ks1htirA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 311/473] f2fs: fix to check pinfile flag in f2fs_move_file_range()
Date: Thu,  6 Jun 2024 16:04:00 +0200
Message-ID: <20240606131710.230071837@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit e07230da0500e0919a765037c5e81583b519be2c ]

ioctl(F2FS_IOC_MOVE_RANGE) can truncate or punch hole on pinned file,
fix to disallow it.

Fixes: 5fed0be8583f ("f2fs: do not allow partial truncation on pinned file")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1a7ee769f9389..1c47c7cbcd6cd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2816,7 +2816,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
-	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst) ||
+		f2fs_is_pinned_file(src) || f2fs_is_pinned_file(dst)) {
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
-- 
2.43.0




