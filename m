Return-Path: <stable+bounces-139752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C35AA9ED5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC7E17BF09
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1A279334;
	Mon,  5 May 2025 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3HvHw5o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9D279325;
	Mon,  5 May 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483271; cv=none; b=N+0YPkUl0rPxuC3gJfSuguP0BSzCuYjlRj7Y1NsAdi4wup6hRfv8pBL7+hMtSjeQDm/44MrMHUJznnEcBnJUckoqkXwGtNDdWG12RWaOMmBjCgSNT9+ERvisaWUMNgk5nYJmijrbueeawBp7LLOJfzg6+srBo6wt1J3rvhgM3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483271; c=relaxed/simple;
	bh=/P+my4y0q9Q4XIY2GjPQUkqXcXiVng231bnVt4DlsUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPwCINEVzq7Y9c3KtM0ZlK47FHvRyaIw7BXwIqatWiggd+t+LsNAldtvn94PTfgLpJSosu7VDBvAOWwoZXx4/SyCtfw2Kz3HskEe26NstSWuKuk+qy2TwHfZpljZ/CBrHmLipMB1kGPyqfTpelxpfpLeqAp8Y5OVaZxk3ti4Faw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3HvHw5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7AFC4CEE4;
	Mon,  5 May 2025 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483270;
	bh=/P+my4y0q9Q4XIY2GjPQUkqXcXiVng231bnVt4DlsUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3HvHw5orsrAOMCzqnyn1dzRqwauPeacZGd9Dh01T1EGySdaC5eF9UbhLbllKQVLx
	 Q/UmvTFm4tZHBWjwp3Cnv/eruE5c9eKUwwaHyifYyvvd5efwcxoJ1eir/KL/mu5i+j
	 kKnKO5Da5dgMxgqF14dgjkUoBAhn1rQp8MKQ0OEqlyZyO55mshOZhlncUxoWY/qLI8
	 fFVqHj/4GHfChPlxVWQ3aHWjbCHBvpsfDzut80VP0aegYZ40XSEcJ4WYU1hwxb+1Va
	 4eoLGJRyDey3/Ln4aPoMHOvYs7xSFN12RzwFfMfQ7XbNlo+38/caGr/5KWVvgE+yNR
	 wr8xLfprpoQ8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.14 005/642] cifs: Fix querying and creating MF symlinks over SMB1
Date: Mon,  5 May 2025 18:03:41 -0400
Message-Id: <20250505221419.2672473-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

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


