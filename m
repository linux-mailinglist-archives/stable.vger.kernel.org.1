Return-Path: <stable+bounces-151426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4CDACE05D
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67153A7BEC
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D128ECC6;
	Wed,  4 Jun 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p87yjeiD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C028F505
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047671; cv=none; b=czPq/1vzFuzMTmNconJzUWpan4l8nwW0IwbVwBV8GFAEWbjU1o9pDjI8gqyKICz/m2dfp/Xp6NTtZmGjLDiXCSIpsV0a66wNa4BrfNk8E5vZOvgBlGpQv/mCgid4c+oKyff6vj60ZWt1oXNXtrjJD40yUOeUf4AlVjVPWfyw8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047671; c=relaxed/simple;
	bh=WXDUKLCdofQdBNyUU5jbGLaNdEZQjNN49nulQ0lPsoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdFWZIbQqoFJOnCby7RIts2lzeSbnS1/8QyMkJGJ93feCSyzxhxrcVaniKNotVl5vM03PnqResDo/ABzPfezW181GVboqnbKXdTEx26CjxuMZNmuoqLPNy0K4ZCtWIn8p6vvuJl8wn6CdvgWSI/k6J3xrriPNOkxZO9tOt5l/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p87yjeiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2164FC4CEE4;
	Wed,  4 Jun 2025 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047671;
	bh=WXDUKLCdofQdBNyUU5jbGLaNdEZQjNN49nulQ0lPsoI=;
	h=From:To:Cc:Subject:Date:From;
	b=p87yjeiDJLV6y366fS8HghSdXnDxtC2eMUFK2RTsPeg4RScw/d7g30z3x2If2eKFb
	 LAKtvDM/20DXEruZQqdZSpi0uP8xAnu+D5K177M/DsxzDxXcA6Oa0JuWO4AwMKGojR
	 xlPhwEDnb6PTupUlxKyIUf4NIMVWU4wXipe16zarhkkAjrYUCL36xRocVQJNOD0b2G
	 lGNwdn3bL1tElYgvyetOwV/NcFRGf7W4MCv1NGFCca8vr3crur1H+F+1MH0TP5D4VB
	 CWacfhvhjNlmlOn5+w7c4OH9WZYEOLleV+qbDl9K6u3DlbgrkhfuxhG1lgniMEqodO
	 x6GGZPbv7FI+g==
From: hubcap@kernel.org
To: stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	hubcapsc@gmail.com
Subject: [PATCH 6.14] orangefs: adjust counting code to recover from 665575cf
Date: Wed,  4 Jun 2025 10:34:02 -0400
Message-ID: <20250604143414.213477-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

A late commit to 6.14-rc7 (665575cf) broke orangefs. I made a patch that
fixes orangefs in 6.15, but some pagecache/folio code got pulled into
6.15 that causes my 6.15 patch not to apply to 6.14. Here is a tested
6.14 flavored patch that was never upstream that I hope can get applied
to 6.14-stable...

---
 fs/orangefs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aae6d2b8767d..3e8ce0fea4d7 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -32,12 +32,13 @@ static int orangefs_writepage_locked(struct page *page,
 	len = i_size_read(inode);
 	if (PagePrivate(page)) {
 		wr = (struct orangefs_write_range *)page_private(page);
-		WARN_ON(wr->pos >= len);
 		off = wr->pos;
-		if (off + wr->len > len)
+		if ((off + wr->len > len) && (off <= len))
 			wlen = len - off;
 		else
 			wlen = wr->len;
+		if (wlen == 0)
+			wlen = wr->len;
 	} else {
 		WARN_ON(1);
 		off = page_offset(page);
@@ -46,8 +47,6 @@ static int orangefs_writepage_locked(struct page *page,
 		else
 			wlen = PAGE_SIZE;
 	}
-	/* Should've been handled in orangefs_invalidate_folio. */
-	WARN_ON(off == len || off + wlen > len);
 
 	WARN_ON(wlen == 0);
 	bvec_set_page(&bv, page, wlen, off % PAGE_SIZE);
@@ -341,6 +340,8 @@ static int orangefs_write_begin(struct file *file,
 			wr->len += len;
 			goto okay;
 		} else {
+			wr->pos = pos;
+			wr->len = len;
 			ret = orangefs_launder_folio(folio);
 			if (ret)
 				return ret;
-- 
2.49.0


