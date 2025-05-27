Return-Path: <stable+bounces-147169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C91AC5677
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FA81BA751E
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48851D88D7;
	Tue, 27 May 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwSVfO2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054A1E89C;
	Tue, 27 May 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366501; cv=none; b=cUTrAll0VJGNonfgKtf9U7hQLjebiHOGhlRXm6Cmnoeiz4ohW3AG1QHsVUHZQIPP9sAFDfsfoUjZM711bfR5UkrbxDQ9T5XBuqqSGb2x2Ii1YsReJZgZ3sfJvlydeLY1cD8ShHdtiXqgaktOl7vQlI7GdKjdQ2O1lZd4tSrpmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366501; c=relaxed/simple;
	bh=Tg00eZ8Vg3amrRye/9kebQw5cCnkzxkP33j7R1s2+JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vASfAfDxyf4/k5g8wFi26CskQTqAfRJdwR0Uu/ZeTE/J7iViY8bPNClGibEdpUAPMEql1mc8H6oVmSni2ST7aTUrRCDTCrEBh4WbRYQ4IiS6eM+rt+fIvct0waZZCI8JkY9kETtf1p3HMrAA0mGWEobY0vDQFrfqetIBOPUSnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwSVfO2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC90C4CEE9;
	Tue, 27 May 2025 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366501;
	bh=Tg00eZ8Vg3amrRye/9kebQw5cCnkzxkP33j7R1s2+JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwSVfO2A+GUSwpiQy6d73v2BTTGwXAXRq57L1/1JYpWxqweufqh2AyQVPik+54XJ7
	 jHq+2nu4cyE6BsaXwKZAVumUgR08ax6blQtmWuXK0qKsgIzkEu/OLV5FJTJZM03HbR
	 xmdqugIFljtFP/y4xC1S/ZrJSRSaHgAhSNYbxHpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 048/783] cifs: Fix querying and creating MF symlinks over SMB1
Date: Tue, 27 May 2025 18:17:25 +0200
Message-ID: <20250527162515.088443531@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 4236ac9fe5b8b42756070d4abfb76fed718e87c2 ]

Old SMB1 servers without CAP_NT_SMBS do not support CIFS_open() function
and instead SMBLegacyOpen() needs to be used. This logic is already handled
in cifs_open_file() function, which is server->ops->open callback function.

So for querying and creating MF symlinks use open callback function instead
of CIFS_open() function directly.

This change fixes querying and creating new MF symlinks on Windows 98.
Currently cifs_query_mf_symlink() is not able to detect MF symlink and
cifs_create_mf_symlink() is failing with EIO error.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/link.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index 6e6c09cc5ce7a..34a026243287f 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -258,7 +258,7 @@ cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_open_parms oparms;
 	struct cifs_io_parms io_parms = {0};
 	int buf_type = CIFS_NO_BUFFER;
-	FILE_ALL_INFO file_info;
+	struct cifs_open_info_data query_data;
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
@@ -270,11 +270,11 @@ cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 		.fid = &fid,
 	};
 
-	rc = CIFS_open(xid, &oparms, &oplock, &file_info);
+	rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, &query_data);
 	if (rc)
 		return rc;
 
-	if (file_info.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
+	if (query_data.fi.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
 		rc = -ENOENT;
 		/* it's not a symlink */
 		goto out;
@@ -313,7 +313,7 @@ cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 		.fid = &fid,
 	};
 
-	rc = CIFS_open(xid, &oparms, &oplock, NULL);
+	rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, NULL);
 	if (rc)
 		return rc;
 
-- 
2.39.5




