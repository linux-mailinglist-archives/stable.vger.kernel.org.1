Return-Path: <stable+bounces-85384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDA99E717
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A674B21512
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136A1E764A;
	Tue, 15 Oct 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FaFnHdV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B51CFEA9;
	Tue, 15 Oct 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992932; cv=none; b=cLBzQQI6PNzSoQfSSOp99ZBgktxmtjdgWmYqnmPXxkrR+/FgwFB40R597MYZbyGSSXKnFFo1zi4rEEAp5jucQE2HaBNj3U3AVfZ3DQM2nq1zQYrnVoihlkW0OYNWkkZrLFcalOuk3CJDQ1AW9lgQazjUfevTNJpMPz30R34F+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992932; c=relaxed/simple;
	bh=eg/rV0FVMN/j8db28BknjR6HRRumnO+SLNmWQdcwpuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy+pzpfbt5eilF54wTxcZhitgDzCngXNozuYA/ybWFLa334NnS3AEFxY1Pn6c6ofjJM3cMiN8jLGhnq4YbEkPhcnZX/j2z919JRuSLnWkEi9afe6xkofA+asa5Ka8sU4Sh8H6gTUhhu84s2pqs54sWfrTvU4ykucAc0JhTGcxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FaFnHdV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8B9C4CEC6;
	Tue, 15 Oct 2024 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992932;
	bh=eg/rV0FVMN/j8db28BknjR6HRRumnO+SLNmWQdcwpuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaFnHdV1ur824l/TBYnGOm+dNo2/E+QVEnFW6YfnQnP1c5myqFpgtVU42wAHuL86H
	 Q1RjIqim+PdJW3AGRj+sYcaevqntn2UG/dyjqAyxd8tMY4SwtDJDYMVY0qIGjudzMk
	 jHAOz6XjrLWMgBZBz3HJlH+NSRqvLIRNgDCW21Yo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonggil Song <yonggil.song@samsung.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 262/691] f2fs: fix typo
Date: Tue, 15 Oct 2024 13:23:30 +0200
Message-ID: <20241015112450.749257916@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonggil Song <yonggil.song@samsung.com>

[ Upstream commit d382e36970ecf8242921400db2afde15fb6ed49e ]

Fix typo in f2fs.h
Detected by Jaeyoon Choi

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: aaf8c0b9ae04 ("f2fs: reduce expensive checkpoint trigger frequency")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e49fca9daf2d3..25f879ed599a5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -261,7 +261,7 @@ enum {
 	ORPHAN_INO,		/* for orphan ino list */
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
-	TRANS_DIR_INO,		/* for trasactions dir ino list */
+	TRANS_DIR_INO,		/* for transactions dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
-- 
2.43.0




